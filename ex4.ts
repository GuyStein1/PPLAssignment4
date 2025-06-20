//Q1
export function all<T>(promises: Array<Promise<T>>): Promise<Array<T>> {
  return new Promise<T[]>((resolve, reject) => {
    const results: T[] = new Array(promises.length);
    let resolvedCount = 0;

    if (promises.length === 0) {
      resolve([]);
      return;
    }

    promises.forEach((p, index) => {
      p.then((value) => {
        results[index] = value;
        resolvedCount++;

        if (resolvedCount === promises.length) {
          resolve(results);
        }
      }).catch((err) => {
        reject(err);  // reject immediately on any failure
      });
    });
  });
}


// Q2
export function* Fib1() {
  let a = 1, b = 1;
  while (true) {
    yield a;
    [a, b] = [b, a + b];
  }
}

export function* Fib2() {
  const sqrt5 = Math.sqrt(5);
  const phi = (1 + sqrt5) / 2;
  const psi = (1 - sqrt5) / 2;

  let n = 1;
  while (true) {
    const fib = (Math.pow(phi, n) - Math.pow(psi, n)) / sqrt5;
    yield Math.round(fib);
    n++;
  }
}
