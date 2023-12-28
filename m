Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58274C3DA6E
	for <kexec@archiver.kernel.org>; Thu, 28 Dec 2023 04:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DIyBrkMhHIXqLMw4MkqpmSrdLPIq4qCBY78mLYDagoA=; b=SxtI7whkBWR3dn
	IjVQkX9hWsBUjvQinb8UHOF+SS2nl0HjGgpXoiY+QX0p9nGdvyjOz+6caGqonW6yPBqlBP3fQluqD
	al6bfqYh7j3Bs1A0xApxrio/47Dbs2HuW2JFk2HUl2Oso2YJcJ2ALK5kpgHQRkiXDZOdSd3zfyo6M
	HWsSgq5Famf5VKqzf3yg9ozeJ33I4YI22PF/zb4k3FwOFTEC/aYnJGDNT+KsZfR/58Jd+kMdKJFmV
	hPmn3fTUVbx0XmuMNUxy8xxsdgtNmTioLTZ1imayg8oKJ26ao5AmupsV55uVre6a7e/ASxxhMIlQ3
	UxZw5YaXQnmfaK91Wmaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIhhL-00G5L8-0c;
	Thu, 28 Dec 2023 04:08:43 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rIhh8-00G5KZ-1e
	for kexec@lists.infradead.org;
	Thu, 28 Dec 2023 04:08:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703736510; x=1735272510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OkLCJyJV4KFZFi+9iX4QeHDCYzZK9rcCw39vsKf1N4o=;
  b=h5Dib5xkvMD+DtT0QkRxMhu9tHC/hQacALNOAl8bqtbJt18sJhYvLG+Z
   MebkrY193K3plEzUDYzJkAG8BPuEC5bXbzZmul4gzVlqjngc1ex1jqfrT
   qW8VPF6jzZl0z9SKjBr80EXPZTwCHLw/K9//2vS5kaNWP58HlF/YfZZJL
   HibKZZeFjAU9+TjbF5AODkwGJccCArDyUE330WVRm1blxWuPBu15MYD3M
   FIy052FHvjQBOc0e9B00v3kpctlbkoLkQH0sLaklnI2el5SqSN038BHbd
   c2EXjNZhuBe/6AaKGnplO8nhMUPiGb8Qco9kRsjY6Cahf+Ps3JOBnGK+T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3806747"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="3806747"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 20:08:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="921998159"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="921998159"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 27 Dec 2023 20:08:21 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rIhgx-000G2F-0i;
	Thu, 28 Dec 2023 04:08:19 +0000
Date: Thu, 28 Dec 2023 12:07:25 +0800
From: kernel test robot <lkp@intel.com>
To: Pingfan Liu <kernelfans@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: oe-kbuild-all@lists.linux.dev, Baoquan He <bhe@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, kexec@lists.infradead.org,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Ming Lei <ming.lei@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCHv10 3/3] powerpc/smp: Allow hole in paca_ptrs to
 accommodate boot_cpu
Message-ID: <202312281100.39B8MAEU-lkp@intel.com>
References: <20231227024147.12485-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231227024147.12485-1-kernelfans@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231227_200830_585570_3ABD649E 
X-CRM114-Status: GOOD (  16.31  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Pingfan,

kernel test robot noticed the following build errors:

[auto build test ERROR on powerpc/next]
[also build test ERROR on powerpc/fixes linus/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pingfan-Liu/powerpc-kernel-Remove-check-on-paca_ptrs_size/20231227-104412
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/20231227024147.12485-1-kernelfans%40gmail.com
patch subject: [PATCHv10 3/3] powerpc/smp: Allow hole in paca_ptrs to accommodate boot_cpu
config: powerpc-microwatt_defconfig (https://download.01.org/0day-ci/archive/20231228/202312281100.39B8MAEU-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231228/202312281100.39B8MAEU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312281100.39B8MAEU-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/smp.h:12,
                    from arch/powerpc/kernel/paca.c:6:
   arch/powerpc/kernel/paca.c: In function 'allocate_paca_ptrs':
>> arch/powerpc/kernel/paca.c:248:55: error: 'threads_in_core' undeclared (first use in this function); did you mean 'threads_per_core'?
     248 |         cnt = max((unsigned int)ALIGN(boot_cpuid + 1, threads_in_core), nr_cpu_ids);
         |                                                       ^~~~~~~~~~~~~~~
   include/linux/compiler.h:236:55: note: in definition of macro '__is_constexpr'
     236 |         (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                       ^
   include/linux/minmax.h:92:25: note: in expansion of macro '__careful_cmp'
      92 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^~~~~~~~~~~~~
   arch/powerpc/kernel/paca.c:248:15: note: in expansion of macro 'max'
     248 |         cnt = max((unsigned int)ALIGN(boot_cpuid + 1, threads_in_core), nr_cpu_ids);
         |               ^~~
   include/uapi/linux/const.h:31:41: note: in expansion of macro '__ALIGN_KERNEL_MASK'
      31 | #define __ALIGN_KERNEL(x, a)            __ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
         |                                         ^~~~~~~~~~~~~~~~~~~
   include/linux/align.h:8:33: note: in expansion of macro '__ALIGN_KERNEL'
       8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
         |                                 ^~~~~~~~~~~~~~
   arch/powerpc/kernel/paca.c:248:33: note: in expansion of macro 'ALIGN'
     248 |         cnt = max((unsigned int)ALIGN(boot_cpuid + 1, threads_in_core), nr_cpu_ids);
         |                                 ^~~~~
   arch/powerpc/kernel/paca.c:248:55: note: each undeclared identifier is reported only once for each function it appears in
     248 |         cnt = max((unsigned int)ALIGN(boot_cpuid + 1, threads_in_core), nr_cpu_ids);
         |                                                       ^~~~~~~~~~~~~~~
   include/linux/compiler.h:236:55: note: in definition of macro '__is_constexpr'
     236 |         (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                       ^
   include/linux/minmax.h:92:25: note: in expansion of macro '__careful_cmp'
      92 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^~~~~~~~~~~~~
   arch/powerpc/kernel/paca.c:248:15: note: in expansion of macro 'max'
     248 |         cnt = max((unsigned int)ALIGN(boot_cpuid + 1, threads_in_core), nr_cpu_ids);
         |               ^~~
   include/uapi/linux/const.h:31:41: note: in expansion of macro '__ALIGN_KERNEL_MASK'
      31 | #define __ALIGN_KERNEL(x, a)            __ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
         |                                         ^~~~~~~~~~~~~~~~~~~
   include/linux/align.h:8:33: note: in expansion of macro '__ALIGN_KERNEL'
       8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
         |                                 ^~~~~~~~~~~~~~
   arch/powerpc/kernel/paca.c:248:33: note: in expansion of macro 'ALIGN'
     248 |         cnt = max((unsigned int)ALIGN(boot_cpuid + 1, threads_in_core), nr_cpu_ids);
         |                                 ^~~~~
   include/linux/minmax.h:31:9: error: first argument to '__builtin_choose_expr' not a constant
      31 |         __builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))),        \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/minmax.h:51:9: note: in expansion of macro 'static_assert'
      51 |         static_assert(__types_ok(x, y),                 \
         |         ^~~~~~~~~~~~~
   include/linux/minmax.h:39:10: note: in expansion of macro '__is_signed'
      39 |         (__is_signed(x) == __is_signed(y) ||                    \
         |          ^~~~~~~~~~~
   include/linux/minmax.h:51:23: note: in expansion of macro '__types_ok'
      51 |         static_assert(__types_ok(x, y),                 \
         |                       ^~~~~~~~~~
   include/linux/minmax.h:58:17: note: in expansion of macro '__cmp_once'
      58 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:92:25: note: in expansion of macro '__careful_cmp'
      92 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^~~~~~~~~~~~~
   arch/powerpc/kernel/paca.c:248:15: note: in expansion of macro 'max'
     248 |         cnt = max((unsigned int)ALIGN(boot_cpuid + 1, threads_in_core), nr_cpu_ids);
         |               ^~~
   include/linux/minmax.h:31:9: error: first argument to '__builtin_choose_expr' not a constant
      31 |         __builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))),        \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/minmax.h:51:9: note: in expansion of macro 'static_assert'
      51 |         static_assert(__types_ok(x, y),                 \
         |         ^~~~~~~~~~~~~
   include/linux/minmax.h:40:17: note: in expansion of macro '__is_signed'
      40 |                 __is_signed((x) + 0) == __is_signed((y) + 0) || \
         |                 ^~~~~~~~~~~
   include/linux/minmax.h:51:23: note: in expansion of macro '__types_ok'
      51 |         static_assert(__types_ok(x, y),                 \
         |                       ^~~~~~~~~~
   include/linux/minmax.h:58:17: note: in expansion of macro '__cmp_once'
      58 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:92:25: note: in expansion of macro '__careful_cmp'
      92 | #define max(x, y)       __careful_cmp(max, x, y)
         |                         ^~~~~~~~~~~~~
   arch/powerpc/kernel/paca.c:248:15: note: in expansion of macro 'max'
     248 |         cnt = max((unsigned int)ALIGN(boot_cpuid + 1, threads_in_core), nr_cpu_ids);
         |               ^~~
   include/linux/minmax.h:31:9: error: first argument to '__builtin_choose_expr' not a constant
      31 |         __builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))),        \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/minmax.h:51:9: note: in expansion of macro 'static_assert'
      51 |         static_assert(__types_ok(x, y),                 \
         |         ^~~~~~~~~~~~~
   include/linux/minmax.h:36:53: note: in expansion of macro '__is_signed'
      36 |         (__builtin_choose_expr(__is_constexpr(x) && __is_signed(x), x, -1) >= 0)


vim +248 arch/powerpc/kernel/paca.c

   242	
   243	void __init allocate_paca_ptrs(void)
   244	{
   245		unsigned int cnt;
   246	
   247		/* paca_ptrs should be big enough to hold boot cpu */
 > 248		cnt = max((unsigned int)ALIGN(boot_cpuid + 1, threads_in_core), nr_cpu_ids);
   249		paca_last_cpu_num = cnt;
   250		paca_ptrs_size = sizeof(struct paca_struct *) * cnt;
   251		paca_ptrs = memblock_alloc_raw(paca_ptrs_size, SMP_CACHE_BYTES);
   252		if (!paca_ptrs)
   253			panic("Failed to allocate %d bytes for paca pointers\n",
   254			      paca_ptrs_size);
   255	
   256		memset(paca_ptrs, 0x88, paca_ptrs_size);
   257	}
   258	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
