/**
 * MIT License
 *
 * Copyright (c) 2022 JabDoesThings
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

declare module 'PipeWrench-Utils' {
  export const syncCallback: {
    /** @noSelf */
    add(callback: () => void): void;
    /** @noSelf */
    tick(): void;
  };

  /** @noSelf */
  export const isPipeWrenchLoaded: () => boolean;
}

/**
 * hookInto by Konijima, 8/5/2022
 */
 declare module 'PipeWrench-Utils' {
  /**
   * @noSelf
   * 
   * Hook into global object methods to extend or overwrite functionality
   * @param target The target method fullpath
   * @param hook The hook function to apply to that method
   * @throws Throws an error if invalid
   */
  export const hookInto: (target: string, hook: (this: void, method: (this: void, self: any, ...args: any[]) => any, self: any, ...args: any[]) => void) => boolean
}

/**
 * getGlobal by Konijima, 8/8/2022
 */
declare module 'PipeWrench-Utils' {
  /**
   * @noSelf
   * 
   * Get a global object and cast a type
   * @param target The target object/method fullpath
   * @return object | null
   */
  export const getGlobal: <T>(target: string) => T;
}
