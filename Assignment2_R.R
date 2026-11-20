# 통계학입문 과제 2 — 단측 Z-가설검정 (R 학생용)
# 이름: 신연우  학번: 2026123064
# 목표: Z-검정, 임계값, p-value, if/else 판단, 기각역 그래프를 작성함
# base R만 사용함

# [상황] 음료의 공칭 평균 용량은 500mL임.
# 36개 표본의 평균은 496mL이며, 모표준편차는 12mL로 알려져 있음.
# 실제 평균이 500mL보다 작은지 유의수준 5%에서 검정함.

# 문제 1. 가설을 작성할 것
# H0: mu = 500 (실제 평균 용량은 500mL이다)
# H1: mu < 500 (실제 평균 용량은 500mL보다 작다)

mu_0 <- 500
x_bar <- 496
sigma <- 12
n <- 36
alpha <- 0.05

# 문제 2. 표준오차를 구할 것: sigma / sqrt(n)
standard_error <- sigma / sqrt(n)

# 문제 3. Z-검정통계량을 구할 것
z_stat <- (x_bar - mu_0) / standard_error

# 문제 4. 왼쪽 단측검정의 임계값을 구할 것
# qnorm(alpha)는 왼쪽 누적확률이 alpha인 지점을 반환함
critical_z <- qnorm(alpha)

# 문제 5. p-value를 계산할 것
# pnorm(z_stat)는 P(Z <= z_stat)를 반환함
p_value <- pnorm(z_stat)

cat('2. 표준오차:', standard_error, '\n')
cat('3. Z-검정통계량:', z_stat, '\n')
cat('4. 임계값:', critical_z, '\n')
cat('5. p-value:', p_value, '\n')

# 문제 6. if/else를 사용하여 귀무가설 기각 여부를 출력할 것
if (!is.na(p_value)) {
  if (p_value < alpha) {
    cat('귀무가설을 기각함\n')
  } else {
    cat('귀무가설을 기각하지 못함\n')
  }
}

# 문제 7. 표준정규분포 그래프에 왼쪽 기각역과 수직선을 표시할 것
if (!is.na(critical_z) && !is.na(z_stat)) {
  x <- seq(-4, 4, length.out=500)
  y <- dnorm(x)
  plot(x, y, type='l', lwd=2, main='Left-tailed Z test (alpha = 0.05)',
       xlab='Z', ylab='Density')
  reject_x <- x[x <= critical_z]
  reject_y <- dnorm(reject_x)
  polygon(c(reject_x[1], reject_x, tail(reject_x, 1)),
          c(0, reject_y, 0), col='gray80', border=NA)
  abline(v=critical_z, lty=2)
  abline(v=z_stat, lty=3)
  lines(x, y, lwd=2)
}

# 문제 8. 검정 결과를 일상적인 언어로 2~3문장 작성할 것
# 답: 표본 36개의 평균이 496mL로, 실제 평균이 500mL라면 이 정도로 작은 값이 나올 확률(p-value)은 약 2.3%에 불과함.
#     이는 유의수준 5%보다 작으므로 귀무가설을 기각하며, 이 음료의 실제 평균 용량은 표시된 500mL보다 적다고 판단할 수 있음.
#     즉, 우연한 차이로 보기 어렵고 제품이 평균적으로 표시 용량보다 조금 덜 담겨 있을 가능성이 높음.
