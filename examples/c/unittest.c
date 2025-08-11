void error()
{
  while (1);
}

unsigned int add(unsigned int a, unsigned int b)
{
  return a+b;
}

void main(void)
{
  unsigned int a = 12, b = 13;

  if (a > b) error();
  if (a >= b) error();
  if (b < a) error();
  if (b <= a) error();
  if (a != a) error();

  if (add(a, b) != 25) error();
}
