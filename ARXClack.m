Clack = importdata('Clack.csv');
Clack = Clack.data;
Clack = Clack(:, 2:end);
[Z, mu, sigma] = zscore(Clack);

Data = Z;

y_mu = mu(4);
y_sigma = sigma(4);
y_true = Data(:,4)*y_sigma + y_mu;
u1 = Data(1:11,1 ); % Inflation Rate
u2 = Data(1:11,2); % Interest Rate
z2 = Data(1:11,3); % Median Weekly Income
y = Data(1:11,4); % Mortality Rate
x = 2008:1:2020;
x = x';

%% 

x_u = [u1 u2 z2];
z_u = [y x_u];
%z_u_pred = [Data(12:13,5) Data(12:13,3)  Data(12:13,1)];

na = 2;
nb = 1*ones(1,3);
nk = 1*ones(1,3);

sys_ = nlarx(z_u, [na nb nk]);

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
