import numpy as np
import pandas as pd
import scipy.stats as stats

# Setup Data
np.random.seed(42)
X = np.random.normal(size=2500)
categories = ['a', 'b', 'c']
y = np.random.choice(categories, 2500)

df = pd.DataFrame({'value': X, 'group': y})

# ANOVA Calculations
grand_mean = df['value'].mean()
group_stats = df.groupby('group')['value'].agg(['mean', 'count'])

# SSB (Sum of Squares Between)
ssb = np.sum(group_stats['count'] * (group_stats['mean'] - grand_mean)**2)

# SSW (Sum of Squares Within)
ssw = 0
for group in categories:
    group_data = df[df['group'] == group]['value']
    group_mean = group_stats.loc[group, 'mean']
    ssw += np.sum((group_data - group_mean)**2)

# Degrees of Freedom
k = len(categories)
N = len(X)
df_between = k - 1
df_within = N - k

# F-Statistic
msb = ssb / df_between
msw = ssw / df_within
f_stat = msb / msw

# P-value
p_value = stats.f.sf(f_stat, df_between, df_within)

print(f"ANOVA F-statistic: {f_stat:.4f}, p-value: {p_value:.4f}")

# Bonferroni Correction (Post-hoc)
# Only perform if ANOVA is significant (p < 0.05)
alpha = 0.05
comparisons = [('a', 'b'), ('a', 'c'), ('b', 'c')]
num_comparisons = len(comparisons)
bonferroni_alpha = alpha / num_comparisons

print(f"\nBonferroni Adjusted Alpha: {bonferroni_alpha:.4f}")

for g1, g2 in comparisons:
    data1 = df[df['group'] == g1]['value']
    data2 = df[df['group'] == g2]['value']
    
    # Perform t-test
    t_stat, p_pair = stats.ttest_ind(data1, data2)
    
    status = "Significant" if p_pair < bonferroni_alpha else "Not Significant"
    print(f"Comparison {g1} vs {g2}: p-val={p_pair:.4f} ({status})")
