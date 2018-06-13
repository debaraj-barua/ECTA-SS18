function visualize(best, p)

[foil, nurbs] = pts2ind(best', p.numEvalPts);
plot(p.nacafoil(1,:),p.nacafoil(2,:), 'LineWidth', 3);
hold on;
plot(foil(1,:),foil(2,:), 'r', 'LineWidth', 3);
plot(nurbs.coefs(1,:),nurbs.coefs(2,:),'ko', 'LineWidth', 3);
axis equal;
axis([0 1 -0.7 0.7]);
legend('NACA Target', 'Approximated Shape');
ax = gca;
ax.FontSize = 24;
drawnow;
hold off;
