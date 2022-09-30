
Data = importdata('AVE.csv');

Data = Data.data;
Data = Data(:, 2:end);
[Z, mu, sigma] = zscore(Data);

Data = Z;

u1 = Data(:,1); % Inflation Rate
u2 = Data(:,2); % Interest Rate

z1 = Data(:,3); % Median Weekly Income
z2 = Data(:,5); % Employment Rate

y = Data(:,4); % Mortality Rate

% figure
% plot(x,[u1 u2 z1 z2 z3 y]);
% xlabel('Year')
% legend('Inflation Rate', 'Interest Rate', 'Median Weekly Income', 'Employment Rate', 'Income Inequality', 'Mortality Rate')

figure
subplot(2,1,1)
crosscorr(y,z1);
title('Cross-correlation between Infant Mortality Rate and Median Weekly Income')
xlabel('lags(years)')
ylabel('Magnitude')

subplot(2,1,2)
crosscorr(y,z2);
title('Cross-correlation between Infant Mortality Rate and Interest Rate')
xlabel('lags(years)')
ylabel('Magnitude')









