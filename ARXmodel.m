data = importdata('data.csv');
%rates = importdata('rates.csv');
maxmin = importdata('maxmin.csv');
Aber = importdata('Aberdeen.csv');
maxmin = maxmin(2:3,:);

Aber = Aber.data;
Aber = Aber(:, 2:end);
[Z, mu, sigma] = zscore(Aber);

Data = Z;

y_mu = mu(4);
y_sigma = sigma(4);

yu_mu = [mu(3) mu(1) mu(2)];
yu_sigma = [sigma(3) sigma(1) sigma(2)];

y_true = Data(:,4)*y_sigma + y_mu;
z1_true = (Data(:,1).*sigma(3)) + mu(3);
z2_true = (Data(:,2).*sigma(1)) + mu(1);
z3_true = (Data(:,3).*sigma(2)) + mu(2); 

u_max = [maxmin(1,3) maxmin(1,1) maxmin(1,2)];
u_min = [maxmin(2,3) maxmin(2,1) maxmin(2,2)];

u1 = Data(1:11,5 ); % Inflation Rate
u2 = Data(1:11,6); % Interest Rate

z1 = Data(1:11,3); % Employment Rate
z2 = Data(1:11,1); % Median Weekly Income
z3 = Data(1:11,2); % Income Inequality

y = Data(1:11,4); % Mortality Rate

x = 2008:1:2020;
x = x';


%% ARX model - Stage 3 [u1, u2, z2] -> y

x_u = [u1 u2 z2];
z_u = [y x_u];
%z_u_pred = [Data(12:13,5) Data(12:13,3)  Data(12:13,1)];

na_ = 2;
nb_ = 1*ones(1,3);
nk_ = 0*ones(1,3);

sys_ = nlarx(z_u, [na_ nb_ nk_]);

yf_arx = forecast(sys_,z_u, 2);
yf_arx = [y;yf_arx]; 
yf_arx_true = (yf_arx.*y_sigma) + y_mu;

aic(sys_)
mse(yf_arx_true, y_true)
%% Phase II plots

figure
plot(x,y_true,'color','blue')
hold on
plot(x,yf_arx_true,'color','red')
legend('actual','forecast')
xlabel('Year')
ylabel('infant deaths (per 100,000 people)')
hold off




