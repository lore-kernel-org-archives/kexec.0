Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga17.intel.com ([192.55.52.151])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwbxC-007ftB-6u
 for kexec@lists.infradead.org; Mon, 13 Dec 2021 03:24:44 +0000
Date: Mon, 13 Dec 2021 11:24:20 +0800
From: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/3] vmcore: Convert __read_vmcore to use an iov_iter
Message-ID: <202112131103.3ExA0BMN-lkp@intel.com>
References: <20211213000636.2932569-3-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213000636.2932569-3-willy@infradead.org>
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
config: riscv-randconfig-r012-20211213 (https://download.01.org/0day-ci/archive/20211213/202112131103.3ExA0BMN-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/687563a8e516282784ed87ca7ed3eca900b42192
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/Convert-vmcore-to-use-an-iov_iter/20211213-080748
        git checkout 687563a8e516282784ed87ca7ed3eca900b42192
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/proc/vmcore.c:135:9: warning: no previous prototype for 'read_from_oldmem_iter' [-Wmissing-prototypes]
     135 | ssize_t read_from_oldmem_iter(struct iov_iter *iter, size_t count,
         |         ^~~~~~~~~~~~~~~~~~~~~
   fs/proc/vmcore.c: In function 'read_from_oldmem_iter':
   fs/proc/vmcore.c:157:31: error: implicit declaration of function 'iov_iter_zero' [-Werror=implicit-function-declaration]
     157 |                         tmp = iov_iter_zero(nr_bytes, iter);
         |                               ^~~~~~~~~~~~~
   fs/proc/vmcore.c: In function 'read_from_oldmem':
   fs/proc/vmcore.c:187:25: error: storage size of 'iter' isn't known
     187 |         struct iov_iter iter;
         |                         ^~~~
   fs/proc/vmcore.c:188:22: error: storage size of 'iov' isn't known
     188 |         struct iovec iov;
         |                      ^~~
   fs/proc/vmcore.c:189:21: error: storage size of 'kvec' isn't known
     189 |         struct kvec kvec;
         |                     ^~~~
   fs/proc/vmcore.c:194:17: error: implicit declaration of function 'iov_iter_init'; did you mean 'klist_iter_init'? [-Werror=implicit-function-declaration]
     194 |                 iov_iter_init(&iter, READ, &iov, 1, count);
         |                 ^~~~~~~~~~~~~
         |                 klist_iter_init
   fs/proc/vmcore.c:198:17: error: implicit declaration of function 'iov_iter_kvec' [-Werror=implicit-function-declaration]
     198 |                 iov_iter_kvec(&iter, READ, &kvec, 1, count);
         |                 ^~~~~~~~~~~~~
   fs/proc/vmcore.c:189:21: warning: unused variable 'kvec' [-Wunused-variable]
     189 |         struct kvec kvec;
         |                     ^~~~
   fs/proc/vmcore.c:188:22: warning: unused variable 'iov' [-Wunused-variable]
     188 |         struct iovec iov;
         |                      ^~~
   fs/proc/vmcore.c:187:25: warning: unused variable 'iter' [-Wunused-variable]
     187 |         struct iov_iter iter;
         |                         ^~~~
   fs/proc/vmcore.c: In function '__read_vmcore':
>> fs/proc/vmcore.c:337:17: error: invalid use of undefined type 'struct iov_iter'
     337 |         if (iter->count == 0 || *fpos >= vmcore_size)
         |                 ^~
   fs/proc/vmcore.c:341:17: error: invalid use of undefined type 'struct iov_iter'
     341 |         if (iter->count > vmcore_size - *fpos)
         |                 ^~
   fs/proc/vmcore.c:342:21: error: invalid use of undefined type 'struct iov_iter'
     342 |                 iter->count = vmcore_size - *fpos;
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
   fs/proc/vmcore.c:346:62: error: invalid use of undefined type 'struct iov_iter'
     346 |                 tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
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
   fs/proc/vmcore.c:346:23: note: in expansion of macro 'min'
     346 |                 tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
         |                       ^~~
   In file included from arch/riscv/include/asm/bug.h:10,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from fs/proc/vmcore.c:11:
   fs/proc/vmcore.c:346:62: error: invalid use of undefined type 'struct iov_iter'
     346 |                 tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
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
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   fs/proc/vmcore.c:346:23: note: in expansion of macro 'min'
     346 |                 tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
         |                       ^~~
   In file included from include/linux/kernel.h:17,
                    from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from fs/proc/vmcore.c:11:
   fs/proc/vmcore.c:346:62: error: invalid use of undefined type 'struct iov_iter'
     346 |                 tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
         |                                                              ^~
   include/linux/minmax.h:28:34: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                                  ^
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   fs/proc/vmcore.c:346:23: note: in expansion of macro 'min'
     346 |                 tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
         |                       ^~~
   fs/proc/vmcore.c:346:62: error: invalid use of undefined type 'struct iov_iter'
     346 |                 tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
         |                                                              ^~
   include/linux/minmax.h:28:46: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                                              ^
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   fs/proc/vmcore.c:346:23: note: in expansion of macro 'min'
     346 |                 tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
         |                       ^~~
   fs/proc/vmcore.c:346:62: error: invalid use of undefined type 'struct iov_iter'
     346 |                 tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
         |                                                              ^~
   include/linux/minmax.h:32:24: note: in definition of macro '__cmp_once'
      32 |                 typeof(y) unique_y = (y);               \
         |                        ^
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   fs/proc/vmcore.c:346:23: note: in expansion of macro 'min'
     346 |                 tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
         |                       ^~~
   fs/proc/vmcore.c:346:62: error: invalid use of undefined type 'struct iov_iter'
     346 |                 tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
         |                                                              ^~
   include/linux/minmax.h:32:39: note: in definition of macro '__cmp_once'
      32 |                 typeof(y) unique_y = (y);               \
         |                                       ^
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   fs/proc/vmcore.c:346:23: note: in expansion of macro 'min'
     346 |                 tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
         |                       ^~~
   include/linux/minmax.h:36:9: error: first argument to '__builtin_choose_expr' not a constant
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   fs/proc/vmcore.c:346:23: note: in expansion of macro 'min'
     346 |                 tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
         |                       ^~~
>> fs/proc/vmcore.c:347:21: error: implicit declaration of function 'copy_to_iter'; did you mean 'copy_to_user'? [-Werror=implicit-function-declaration]
     347 |                 if (copy_to_iter(elfcorebuf + *fpos, tsz, iter) < tsz)
         |                     ^~~~~~~~~~~~
         |                     copy_to_user
   fs/proc/vmcore.c:353:25: error: invalid use of undefined type 'struct iov_iter'
     353 |                 if (iter->count == 0)
         |                         ^~
   In file included from include/linux/kernel.h:17,
                    from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from fs/proc/vmcore.c:11:
   fs/proc/vmcore.c:389:76: error: invalid use of undefined type 'struct iov_iter'
     389 |                 tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos, iter->count);
         |                                                                            ^~
   include/linux/minmax.h:20:46: note: in definition of macro '__typecheck'
      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                              ^
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   fs/proc/vmcore.c:389:23: note: in expansion of macro 'min'
     389 |                 tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos, iter->count);
         |                       ^~~
   In file included from arch/riscv/include/asm/bug.h:10,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from fs/proc/vmcore.c:11:
   fs/proc/vmcore.c:389:76: error: invalid use of undefined type 'struct iov_iter'
     389 |                 tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos, iter->count);
         |                                                                            ^~
   include/linux/const.h:12:55: note: in definition of macro '__is_constexpr'
      12 |         (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                       ^
   include/linux/minmax.h:26:39: note: in expansion of macro '__no_side_effects'
      26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
         |                                       ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   fs/proc/vmcore.c:389:23: note: in expansion of macro 'min'
     389 |                 tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos, iter->count);
         |                       ^~~
   In file included from include/linux/kernel.h:17,
                    from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from fs/proc/vmcore.c:11:
   fs/proc/vmcore.c:389:76: error: invalid use of undefined type 'struct iov_iter'
     389 |                 tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos, iter->count);
         |                                                                            ^~
   include/linux/minmax.h:28:34: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                                  ^
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   fs/proc/vmcore.c:389:23: note: in expansion of macro 'min'
     389 |                 tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos, iter->count);
         |                       ^~~
   fs/proc/vmcore.c:389:76: error: invalid use of undefined type 'struct iov_iter'
     389 |                 tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos, iter->count);
         |                                                                            ^~
   include/linux/minmax.h:28:46: note: in definition of macro '__cmp'
      28 | #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
         |                                              ^
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   fs/proc/vmcore.c:389:23: note: in expansion of macro 'min'
     389 |                 tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos, iter->count);
         |                       ^~~
   fs/proc/vmcore.c:389:76: error: invalid use of undefined type 'struct iov_iter'
     389 |                 tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos, iter->count);
         |                                                                            ^~
   include/linux/minmax.h:32:24: note: in definition of macro '__cmp_once'
      32 |                 typeof(y) unique_y = (y);               \
         |                        ^
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   fs/proc/vmcore.c:389:23: note: in expansion of macro 'min'
     389 |                 tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos, iter->count);
         |                       ^~~
   fs/proc/vmcore.c:389:76: error: invalid use of undefined type 'struct iov_iter'
     389 |                 tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos, iter->count);


vim +337 fs/proc/vmcore.c

   326	
   327	/* Read from the ELF header and then the crash dump. On error, negative value is
   328	 * returned otherwise number of bytes read are returned.
   329	 */
   330	static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
   331	{
   332		ssize_t acc = 0, tmp;
   333		size_t tsz;
   334		u64 start;
   335		struct vmcore *m = NULL;
   336	
 > 337		if (iter->count == 0 || *fpos >= vmcore_size)
   338			return 0;
   339	
   340		/* trim iter to not go beyond EOF */
   341		if (iter->count > vmcore_size - *fpos)
   342			iter->count = vmcore_size - *fpos;
   343	
   344		/* Read ELF core header */
   345		if (*fpos < elfcorebuf_sz) {
   346			tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
 > 347			if (copy_to_iter(elfcorebuf + *fpos, tsz, iter) < tsz)
   348				return -EFAULT;
   349			*fpos += tsz;
   350			acc += tsz;
   351	
   352			/* leave now if filled buffer already */
   353			if (iter->count == 0)
   354				return acc;
   355		}
   356	
   357		/* Read Elf note segment */
   358		if (*fpos < elfcorebuf_sz + elfnotes_sz) {
   359			void *kaddr;
   360	
   361			/* We add device dumps before other elf notes because the
   362			 * other elf notes may not fill the elf notes buffer
   363			 * completely and we will end up with zero-filled data
   364			 * between the elf notes and the device dumps. Tools will
   365			 * then try to decode this zero-filled data as valid notes
   366			 * and we don't want that. Hence, adding device dumps before
   367			 * the other elf notes ensure that zero-filled data can be
   368			 * avoided.
   369			 */
   370	#ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
   371			/* Read device dumps */
   372			if (*fpos < elfcorebuf_sz + vmcoredd_orig_sz) {
   373				tsz = min(elfcorebuf_sz + vmcoredd_orig_sz -
   374					  (size_t)*fpos, iter->count);
   375				start = *fpos - elfcorebuf_sz;
   376				if (vmcoredd_copy_dumps(iter, start, tsz))
   377					return -EFAULT;
   378	
   379				*fpos += tsz;
   380				acc += tsz;
   381	
   382				/* leave now if filled buffer already */
   383				if (!iter->count)
   384					return acc;
   385			}
   386	#endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
   387	
   388			/* Read remaining elf notes */
   389			tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)*fpos, iter->count);
   390			kaddr = elfnotes_buf + *fpos - elfcorebuf_sz - vmcoredd_orig_sz;
   391			if (copy_to_iter(kaddr, tsz, iter) < tsz)
   392				return -EFAULT;
   393	
   394			*fpos += tsz;
   395			acc += tsz;
   396	
   397			/* leave now if filled buffer already */
   398			if (iter->count == 0)
   399				return acc;
   400		}
   401	
   402		list_for_each_entry(m, &vmcore_list, list) {
   403			if (*fpos < m->offset + m->size) {
   404				tsz = (size_t)min_t(unsigned long long,
   405						    m->offset + m->size - *fpos,
   406						    iter->count);
   407				start = m->paddr + *fpos - m->offset;
   408				tmp = read_from_oldmem_iter(iter, tsz, &start,
   409						cc_platform_has(CC_ATTR_MEM_ENCRYPT));
   410				if (tmp < 0)
   411					return tmp;
   412				*fpos += tsz;
   413				acc += tsz;
   414	
   415				/* leave now if filled buffer already */
   416				if (iter->count == 0)
   417					return acc;
   418			}
   419		}
   420	
   421		return acc;
   422	}
   423	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
