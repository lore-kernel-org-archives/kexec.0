Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwcav-007jZY-4V
 for kexec@lists.infradead.org; Mon, 13 Dec 2021 04:05:47 +0000
Date: Mon, 13 Dec 2021 12:04:52 +0800
From: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 3/3] vmcore: Convert read_from_oldmem() to take an iov_iter
Message-ID: <202112131249.lfVULc7X-lkp@intel.com>
References: <20211213000636.2932569-4-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213000636.2932569-4-willy@infradead.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: kbuild-all@lists.01.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@arm.com>, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org

Hi "Matthew,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on arm64/for-next/core powerpc/next s390/features linus/master v5.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Matthew-Wilcox-Oracle/Convert-vmcore-to-use-an-iov_iter/20211213-080748
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git e463a09af2f0677b9485a7e8e4e70b396b2ffb6f
config: riscv-randconfig-r012-20211213 (https://download.01.org/0day-ci/archive/20211213/202112131249.lfVULc7X-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/22576d6aef6fb4cffad0a4e85953662c147dfe66
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/Convert-vmcore-to-use-an-iov_iter/20211213-080748
        git checkout 22576d6aef6fb4cffad0a4e85953662c147dfe66
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   fs/proc/vmcore.c: In function 'read_from_oldmem':
   fs/proc/vmcore.c:157:31: error: implicit declaration of function 'iov_iter_zero' [-Werror=implicit-function-declaration]
     157 |                         tmp = iov_iter_zero(nr_bytes, iter);
         |                               ^~~~~~~~~~~~~
   fs/proc/vmcore.c: In function 'elfcorehdr_read':
>> fs/proc/vmcore.c:202:16: error: variable 'kvec' has initializer but incomplete type
     202 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                ^~~~
>> fs/proc/vmcore.c:202:31: error: 'struct kvec' has no member named 'iov_base'
     202 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                               ^~~~~~~~
>> fs/proc/vmcore.c:202:42: warning: excess elements in struct initializer
     202 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                                          ^~~
   fs/proc/vmcore.c:202:42: note: (near initialization for 'kvec')
>> fs/proc/vmcore.c:202:48: error: 'struct kvec' has no member named 'iov_len'
     202 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                                                ^~~~~~~
   fs/proc/vmcore.c:202:58: warning: excess elements in struct initializer
     202 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                                                          ^~~~~
   fs/proc/vmcore.c:202:58: note: (near initialization for 'kvec')
   fs/proc/vmcore.c:202:21: error: storage size of 'kvec' isn't known
     202 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                     ^~~~
   fs/proc/vmcore.c:203:25: error: storage size of 'iter' isn't known
     203 |         struct iov_iter iter;
         |                         ^~~~
   fs/proc/vmcore.c:205:9: error: implicit declaration of function 'iov_iter_kvec' [-Werror=implicit-function-declaration]
     205 |         iov_iter_kvec(&iter, READ, &kvec, 1, count);
         |         ^~~~~~~~~~~~~
   fs/proc/vmcore.c:203:25: warning: unused variable 'iter' [-Wunused-variable]
     203 |         struct iov_iter iter;
         |                         ^~~~
   fs/proc/vmcore.c:202:21: warning: unused variable 'kvec' [-Wunused-variable]
     202 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                     ^~~~
   fs/proc/vmcore.c: In function 'elfcorehdr_read_notes':
   fs/proc/vmcore.c:215:16: error: variable 'kvec' has initializer but incomplete type
     215 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                ^~~~
   fs/proc/vmcore.c:215:31: error: 'struct kvec' has no member named 'iov_base'
     215 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                               ^~~~~~~~
   fs/proc/vmcore.c:215:42: warning: excess elements in struct initializer
     215 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                                          ^~~
   fs/proc/vmcore.c:215:42: note: (near initialization for 'kvec')
   fs/proc/vmcore.c:215:48: error: 'struct kvec' has no member named 'iov_len'
     215 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                                                ^~~~~~~
   fs/proc/vmcore.c:215:58: warning: excess elements in struct initializer
     215 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                                                          ^~~~~
   fs/proc/vmcore.c:215:58: note: (near initialization for 'kvec')
   fs/proc/vmcore.c:215:21: error: storage size of 'kvec' isn't known
     215 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                     ^~~~
   fs/proc/vmcore.c:216:25: error: storage size of 'iter' isn't known
     216 |         struct iov_iter iter;
         |                         ^~~~
   fs/proc/vmcore.c:216:25: warning: unused variable 'iter' [-Wunused-variable]
   fs/proc/vmcore.c:215:21: warning: unused variable 'kvec' [-Wunused-variable]
     215 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                     ^~~~
   fs/proc/vmcore.c: In function '__read_vmcore':
   fs/proc/vmcore.c:327:17: error: invalid use of undefined type 'struct iov_iter'
     327 |         if (iter->count == 0 || *fpos >= vmcore_size)
         |                 ^~
   fs/proc/vmcore.c:331:17: error: invalid use of undefined type 'struct iov_iter'
     331 |         if (iter->count > vmcore_size - *fpos)
         |                 ^~
   fs/proc/vmcore.c:332:21: error: invalid use of undefined type 'struct iov_iter'
     332 |                 iter->count = vmcore_size - *fpos;
         |                     ^~
   In file included from include/linux/kernel.h:17,
                    from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from fs/proc/vmcore.c:11:
   fs/proc/vmcore.c:336:62: error: invalid use of undefined type 'struct iov_iter'
     336 |                 tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
         |                                                              ^~
   include/linux/minmax.h:20:46: note: in definition of macro '__typecheck'
      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                              ^
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   fs/proc/vmcore.c:336:23: note: in expansion of macro 'min'
     336 |                 tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
         |                       ^~~
   In file included from arch/riscv/include/asm/bug.h:10,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from fs/proc/vmcore.c:11:
   fs/proc/vmcore.c:336:62: error: invalid use of undefined type 'struct iov_iter'
     336 |                 tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
         |                                                              ^~
   include/linux/const.h:12:55: note: in definition of macro '__is_constexpr'
      12 |         (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                       ^
   include/linux/minmax.h:26:39: note: in expansion of macro '__no_side_effects'
      26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
         |                                       ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~


vim +/kvec +202 fs/proc/vmcore.c

   196	
   197	/*
   198	 * Architectures may override this function to read from ELF header
   199	 */
   200	ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
   201	{
 > 202		struct kvec kvec = { .iov_base = buf, .iov_len = count };
   203		struct iov_iter iter;
   204	
   205		iov_iter_kvec(&iter, READ, &kvec, 1, count);
   206	
   207		return read_from_oldmem(&iter, count, ppos, false);
   208	}
   209	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
