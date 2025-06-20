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
	// @TODO
  return undefined;
}


export function* Fib2() {
	// @TODO
  return undefined;
}
