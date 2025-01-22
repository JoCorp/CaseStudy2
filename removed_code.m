% % % create test_data_set
% % 
% % tt = [0 1 2 3 4 5];
% % tx = [2];
% % 
% % for i = 2:1:length(tt)
% % 
% %     tx(i) = tx(1)*exp(0.5 * tt(i));
% % 
% % end
% % 
% % % Give time dependent function
% % 
% % sprintf('X(t) = X_0 * e(μ*t) \n \nln(X(t)) = ln(X_0) + μt')
% % 
% % % determine mu in test data set
% % 
% % [mu, cx0, ln_x] = mu_determination(tt,tx);
% % 
% % % calculate data with determined mu
% % 
% % ecx1 = [cx0];
% % 
% % for i = 2:1:length(tt)
% % 
% %     ecx1(i) = cx0 * exp(mu * tt(i));
% % 
% % end
% % 
% % % plot the results
% % 
% % figure(4)
% % plot(tt, tx, '.b', tt, ecx1, '-r', 'MarkerSize', 10)
% % set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
% % title('Growth rate determination')
% % legend('test data', 'calculated data points')
% % xlabel('time')
% % ylabel('Bacterial population')
% % 
% % figure(5)
% % plot(tt, ln_x, '-k')
% % set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
% % title('Linearized data')
% % legend('log(test data)')
% % xlabel('time')
% % ylabel('log(Bacterial population)')
% % create test_data_set
% 
% 
% 
% % Give time dependent function
% 
% % sprintf('X(t) = X_0 * e(μ*t) \n \nln(X(t)) = ln(X_0) + μt')
% 
% % ecx1 = [cx0];
% % 
% % for i = 2:1:length(data_set_2.time)
% % 
% %     ecx1(i) = cx0 * exp(mu * tt(i));
% % 
% % end
% 
% 
% %%
% % select exponential growth segments
% 
% window = 5;
% precision = 0.33;
% allowed_outliers = 2;
% [et, ex] = exponential_selector(time, bio_r, window, precision, allowed_outliers);
% 
% % determine mu for each segment
% 
% [emu1, ecx0_1, eln_x1] = mu_determination(et{1},ex{1});
% [emu2, ecx0_2, eln_x2] = mu_determination(et{2},ex{2});
% [emu3, ecx0_3, eln_x3] = mu_determination(et{3},ex{3});
% 
% peln_x1 = [eln_x1(1) eln_x1(end)];
% pet1 = [et{1}(1) et{1}(end)];
% peln_x2 = [eln_x2(1) eln_x2(end)];
% pet2 = [et{2}(1) et{2}(end)];
% peln_x3 = [eln_x3(1) eln_x3(end)];
% pet3 = [et{3}(1) et{3}(end)];
% 
% % calculate bacterial population with determined mu
% 
% ecx1 = [ecx0_1];
% et1 = et{1};
% 
% for i = 2:1:12
% 
%     if i < length(et1)
% 
%         % Subtracting the start time ensures the model begins from the correct point.
% 
%         ecx1(i) = ecx0_1 * exp(emu1 * (et1(i) - et1(1)));
% 
%     else
% 
%         % values after exponential segment
% 
%         i = round(et1()) + 1;
%         et1(i) = i;
%         ecx1(i) = ecx0_1 * exp(emu1 * (et1(i) - et1(1)));
% 
%     end
% 
% end
% 
% ecx2 = [ecx0_2];
% et2 = et{2};
% 
% for i = 2:1:12
% 
%     if i < length(et2)
% 
%         % Subtracting the start time ensures the model begins from the correct point.
% 
%         ecx2(i) = ecx0_2 * exp(emu2 * (et2(i) - et2(1)));
% 
%     else
% 
%         % values after exponential segment
% 
%         et2(i) = i;
%         ecx2(i) = ecx0_2 * exp(emu2 * (et2(i) - et2(1)));
% 
%     end
% 
% end
% 
% ecx3 = [ecx0_3];
% et3 = et{3};
% 
% for i = 2:1:12
% 
%     if i < length(et3)
% 
%         % Subtracting the start time ensures the model begins from the correct point.
% 
%         ecx3(i) = ecx0_3 * exp(emu3 * (et3(i) - et3(1)));
% 
%     else
% 
%         % values after exponential segment
% 
%         j = i + 4;
%         et3(i) = j;
%         ecx3(i) = ecx0_3 * exp(emu3 * (et3(i) - et3(1)));
% 
%         if j == 12
% 
%             break
% 
%         end
% 
%     end
% 
% end
% plot the results
% 
% figure(6)
% plot(time, bio_r, '.k', et{1}, ex{1}, '-g', et{2}, ex{2}, '-c', et{3}, ex{3}, '-b', ...
%     et1, ecx1, '--g', et2, ecx2, '--c',et3, ecx3, '--b')
% set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
% title('Bacterial growth')
% ylim([0 5])
% legend('data set 2', 'exponential segment 1', 'exponential segment 2', 'exponential segment 3', ...
%     'simulated exponential growth in segment 1', 'simulated exponential growth in segment 2', 'simulated exponential growth in segment 3')
% xlabel('time')
% ylabel('Bacterial population')
% 
% figure(7)
% plot(pet1, peln_x1, '-g', pet2, peln_x2, '-c', pet3, peln_x3, '-b')
% set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
% title('Linearized data')
% legend('Segment 1', 'Segment 2', 'Segment 3')
% xlabel('time')
% ylabel('log(Bacterial population)')
