Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4F1C6FA8F
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 01:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FC8T1SxsnpRvexfS/Hl+YrwUM3ClSWxi1Wey/IxMU84=; b=FWfYkL4fFUPBV9
	aUhOXjt+GAJ1vwSrdoKVsQ8F3RnNWu7nQPDp+7HX/Cd2/ql9BFm/Xvhto1V2Pwzi2g8yCfVAWFn9j
	FVh6pnBq/qC2dNfjrWKpXt4LZB/ehBAL+ZO/W8GReDndOKFxDSMfV5hT02PwC1bL+7tlfHu2+8NHh
	gaIkAhpV69/e7/inoh01J29IBdoxJxIvkVrauRfkFnLNmYEyMngsdTejIZw8Hi4kpTSvteIL76uxZ
	1A0KoJXRO1ikw3fUmpQkQ82X5o63peAzMg2dWf27hBihRM4cJbngD7GhHeAhP0tXjTBCFsmO5WvKH
	gqzDmZO92vFkp4f1p87Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbALP-00Cax9-0A;
	Wed, 30 Aug 2023 01:50:07 +0000
Received: from mgamail.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbALL-00Cawf-0q;
	Wed, 30 Aug 2023 01:50:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693360203; x=1724896203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4pQ9MhnswdyPg5hVLVCCvvXPNWBBShdh094dQn83Vck=;
  b=QX/X5ZftRqqNwjNGOqCdjPvt3lZtmbCv2EU0W6iYAKlb97CxGTIH8QsW
   IsV/U3TR0bpJALXaCajuDD0uKJ4pQddtgq+nZy9ASao/R+AU/gxjyNXc3
   pmTB+NUqS7R66f6Sa1kXUCd2O8HyA7Ys8R622btrcsLwD0vGN2MVfGKkq
   AGyiw9G4GQOO6SzqS++Kd7MgsFrwr2v8sm4fFb8ueEz7er6ja4Y2TaWQ5
   HjrynBw0RfBP6cO/JzCzdcaoNbRCuRq2PhWX0XYTkr6hsET2U0N74t70+
   LpiuJ1/hWvCqITe5/pM+Sd5VUMzvcYW7bNPNAeHQl+4TDWdttMoK6cqlE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="406521452"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="406521452"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 18:49:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="688712666"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="688712666"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 29 Aug 2023 18:49:56 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qbALD-0009IB-0x;
	Wed, 30 Aug 2023 01:49:55 +0000
Date: Wed, 30 Aug 2023 09:49:27 +0800
From: kernel test robot <lkp@intel.com>
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
	catalin.marinas@arm.com, thunder.leizhen@huawei.com,
	dyoung@redhat.com, prudo@redhat.com, samuel.holland@sifive.com,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	x86@kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 6/8] x86: kdump: use generic interface to simplify
 crashkernel reservation code
Message-ID: <202308300910.e0i4piJT-lkp@intel.com>
References: <20230829121610.138107-7-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230829121610.138107-7-bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230829_185003_318507_E7D1F1B7 
X-CRM114-Status: GOOD (  15.62  )
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

Hi Baoquan,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on tip/x86/core powerpc/next powerpc/fixes v6.5]
[cannot apply to linus/master next-20230829]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/crash_core-c-remove-unnecessary-parameter-of-function/20230829-201942
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20230829121610.138107-7-bhe%40redhat.com
patch subject: [PATCH v2 6/8] x86: kdump: use generic interface to simplify crashkernel reservation code
config: x86_64-randconfig-r022-20230830 (https://download.01.org/0day-ci/archive/20230830/202308300910.e0i4piJT-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230830/202308300910.e0i4piJT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308300910.e0i4piJT-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `reserve_crashkernel_low':
   kernel/crash_core.c:369: undefined reference to `crashk_low_res'
   ld: kernel/crash_core.c:369: undefined reference to `crashk_low_res'
   ld: kernel/crash_core.c:370: undefined reference to `crashk_low_res'
   ld: kernel/crash_core.c:369: undefined reference to `crashk_low_res'
   ld: kernel/crash_core.c:370: undefined reference to `crashk_low_res'
   ld: vmlinux.o:kernel/crash_core.c:371: more undefined references to `crashk_low_res' follow
   ld: vmlinux.o: in function `reserve_crashkernel_generic':
>> kernel/crash_core.c:453: undefined reference to `crashk_res'
>> ld: kernel/crash_core.c:453: undefined reference to `crashk_res'
   ld: kernel/crash_core.c:454: undefined reference to `crashk_res'
>> ld: kernel/crash_core.c:453: undefined reference to `crashk_res'
   ld: kernel/crash_core.c:454: undefined reference to `crashk_res'
   ld: vmlinux.o:kernel/crash_core.c:454: more undefined references to `crashk_res' follow


vim +453 kernel/crash_core.c

71d2bcec2d4d69 Philipp Rudo 2021-12-24  353  
6bee83d29d2e09 Baoquan He   2023-08-29  354  #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
6bee83d29d2e09 Baoquan He   2023-08-29  355  static int __init reserve_crashkernel_low(unsigned long long low_size)
6bee83d29d2e09 Baoquan He   2023-08-29  356  {
6bee83d29d2e09 Baoquan He   2023-08-29  357  #ifdef CONFIG_64BIT
6bee83d29d2e09 Baoquan He   2023-08-29  358  	unsigned long long low_base;
6bee83d29d2e09 Baoquan He   2023-08-29  359  
6bee83d29d2e09 Baoquan He   2023-08-29  360  	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
6bee83d29d2e09 Baoquan He   2023-08-29  361  	if (!low_base) {
6bee83d29d2e09 Baoquan He   2023-08-29  362  		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
6bee83d29d2e09 Baoquan He   2023-08-29  363  		return -ENOMEM;
6bee83d29d2e09 Baoquan He   2023-08-29  364  	}
6bee83d29d2e09 Baoquan He   2023-08-29  365  
6bee83d29d2e09 Baoquan He   2023-08-29  366  	pr_info("crashkernel low memory reserved: 0x%08llx - 0x%08llx (%lld MB)\n",
6bee83d29d2e09 Baoquan He   2023-08-29  367  		low_base, low_base + low_size, low_size >> 20);
6bee83d29d2e09 Baoquan He   2023-08-29  368  
6bee83d29d2e09 Baoquan He   2023-08-29 @369  	crashk_low_res.start = low_base;
6bee83d29d2e09 Baoquan He   2023-08-29  370  	crashk_low_res.end   = low_base + low_size - 1;
6bee83d29d2e09 Baoquan He   2023-08-29  371  	insert_resource(&iomem_resource, &crashk_low_res);
6bee83d29d2e09 Baoquan He   2023-08-29  372  #endif
6bee83d29d2e09 Baoquan He   2023-08-29  373  	return 0;
6bee83d29d2e09 Baoquan He   2023-08-29  374  }
6bee83d29d2e09 Baoquan He   2023-08-29  375  
6bee83d29d2e09 Baoquan He   2023-08-29  376  void __init reserve_crashkernel_generic(char *cmdline,
6bee83d29d2e09 Baoquan He   2023-08-29  377  			     unsigned long long crash_size,
6bee83d29d2e09 Baoquan He   2023-08-29  378  			     unsigned long long crash_base,
6bee83d29d2e09 Baoquan He   2023-08-29  379  			     unsigned long long crash_low_size,
6bee83d29d2e09 Baoquan He   2023-08-29  380  			     bool high)
6bee83d29d2e09 Baoquan He   2023-08-29  381  {
6bee83d29d2e09 Baoquan He   2023-08-29  382  	unsigned long long search_end = CRASH_ADDR_LOW_MAX, search_base = 0;
6bee83d29d2e09 Baoquan He   2023-08-29  383  	bool fixed_base = false;
6bee83d29d2e09 Baoquan He   2023-08-29  384  
6bee83d29d2e09 Baoquan He   2023-08-29  385  	/* User specifies base address explicitly. */
6bee83d29d2e09 Baoquan He   2023-08-29  386  	if (crash_base) {
6bee83d29d2e09 Baoquan He   2023-08-29  387  		fixed_base = true;
6bee83d29d2e09 Baoquan He   2023-08-29  388  		search_base = crash_base;
6bee83d29d2e09 Baoquan He   2023-08-29  389  		search_end = crash_base + crash_size;
6bee83d29d2e09 Baoquan He   2023-08-29  390  	}
6bee83d29d2e09 Baoquan He   2023-08-29  391  
6bee83d29d2e09 Baoquan He   2023-08-29  392  	if (high) {
6bee83d29d2e09 Baoquan He   2023-08-29  393  		search_base = CRASH_ADDR_LOW_MAX;
6bee83d29d2e09 Baoquan He   2023-08-29  394  		search_end = CRASH_ADDR_HIGH_MAX;
6bee83d29d2e09 Baoquan He   2023-08-29  395  	}
6bee83d29d2e09 Baoquan He   2023-08-29  396  
6bee83d29d2e09 Baoquan He   2023-08-29  397  retry:
6bee83d29d2e09 Baoquan He   2023-08-29  398  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
6bee83d29d2e09 Baoquan He   2023-08-29  399  					       search_base, search_end);
6bee83d29d2e09 Baoquan He   2023-08-29  400  	if (!crash_base) {
6bee83d29d2e09 Baoquan He   2023-08-29  401  		/*
6bee83d29d2e09 Baoquan He   2023-08-29  402  		 * For crashkernel=size[KMG]@offset[KMG], print out failure
6bee83d29d2e09 Baoquan He   2023-08-29  403  		 * message if can't reserve the specified region.
6bee83d29d2e09 Baoquan He   2023-08-29  404  		 */
6bee83d29d2e09 Baoquan He   2023-08-29  405  		if (fixed_base) {
6bee83d29d2e09 Baoquan He   2023-08-29  406  			pr_warn("crashkernel reservation failed - memory is in use.\n");
6bee83d29d2e09 Baoquan He   2023-08-29  407  			return;
6bee83d29d2e09 Baoquan He   2023-08-29  408  		}
6bee83d29d2e09 Baoquan He   2023-08-29  409  
6bee83d29d2e09 Baoquan He   2023-08-29  410  		/*
6bee83d29d2e09 Baoquan He   2023-08-29  411  		 * For crashkernel=size[KMG], if the first attempt was for
6bee83d29d2e09 Baoquan He   2023-08-29  412  		 * low memory, fall back to high memory, the minimum required
6bee83d29d2e09 Baoquan He   2023-08-29  413  		 * low memory will be reserved later.
6bee83d29d2e09 Baoquan He   2023-08-29  414  		 */
6bee83d29d2e09 Baoquan He   2023-08-29  415  		if (!high && search_end == CRASH_ADDR_LOW_MAX) {
6bee83d29d2e09 Baoquan He   2023-08-29  416  			search_end = CRASH_ADDR_HIGH_MAX;
6bee83d29d2e09 Baoquan He   2023-08-29  417  			search_base = CRASH_ADDR_LOW_MAX;
6bee83d29d2e09 Baoquan He   2023-08-29  418  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
6bee83d29d2e09 Baoquan He   2023-08-29  419  			goto retry;
6bee83d29d2e09 Baoquan He   2023-08-29  420  		}
6bee83d29d2e09 Baoquan He   2023-08-29  421  
6bee83d29d2e09 Baoquan He   2023-08-29  422  		/*
6bee83d29d2e09 Baoquan He   2023-08-29  423  		 * For crashkernel=size[KMG],high, if the first attempt was
6bee83d29d2e09 Baoquan He   2023-08-29  424  		 * for high memory, fall back to low memory.
6bee83d29d2e09 Baoquan He   2023-08-29  425  		 */
6bee83d29d2e09 Baoquan He   2023-08-29  426  		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
6bee83d29d2e09 Baoquan He   2023-08-29  427  			search_end = CRASH_ADDR_LOW_MAX;
6bee83d29d2e09 Baoquan He   2023-08-29  428  			search_base = 0;
6bee83d29d2e09 Baoquan He   2023-08-29  429  			goto retry;
6bee83d29d2e09 Baoquan He   2023-08-29  430  		}
6bee83d29d2e09 Baoquan He   2023-08-29  431  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
6bee83d29d2e09 Baoquan He   2023-08-29  432  			crash_size);
6bee83d29d2e09 Baoquan He   2023-08-29  433  		return;
6bee83d29d2e09 Baoquan He   2023-08-29  434  	}
6bee83d29d2e09 Baoquan He   2023-08-29  435  
6bee83d29d2e09 Baoquan He   2023-08-29  436  	if ((crash_base > CRASH_ADDR_LOW_MAX) &&
6bee83d29d2e09 Baoquan He   2023-08-29  437  	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
6bee83d29d2e09 Baoquan He   2023-08-29  438  		memblock_phys_free(crash_base, crash_size);
6bee83d29d2e09 Baoquan He   2023-08-29  439  		return;
6bee83d29d2e09 Baoquan He   2023-08-29  440  	}
6bee83d29d2e09 Baoquan He   2023-08-29  441  
6bee83d29d2e09 Baoquan He   2023-08-29  442  	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
6bee83d29d2e09 Baoquan He   2023-08-29  443  		crash_base, crash_base + crash_size, crash_size >> 20);
6bee83d29d2e09 Baoquan He   2023-08-29  444  
6bee83d29d2e09 Baoquan He   2023-08-29  445  	/*
6bee83d29d2e09 Baoquan He   2023-08-29  446  	 * The crashkernel memory will be removed from the kernel linear
6bee83d29d2e09 Baoquan He   2023-08-29  447  	 * map. Inform kmemleak so that it won't try to access it.
6bee83d29d2e09 Baoquan He   2023-08-29  448  	 */
6bee83d29d2e09 Baoquan He   2023-08-29  449  	kmemleak_ignore_phys(crash_base);
6bee83d29d2e09 Baoquan He   2023-08-29  450  	if (crashk_low_res.end)
6bee83d29d2e09 Baoquan He   2023-08-29  451  		kmemleak_ignore_phys(crashk_low_res.start);
6bee83d29d2e09 Baoquan He   2023-08-29  452  
6bee83d29d2e09 Baoquan He   2023-08-29 @453  	crashk_res.start = crash_base;
6bee83d29d2e09 Baoquan He   2023-08-29  454  	crashk_res.end = crash_base + crash_size - 1;
6bee83d29d2e09 Baoquan He   2023-08-29  455  	insert_resource(&iomem_resource, &crashk_res);
6bee83d29d2e09 Baoquan He   2023-08-29  456  }
6bee83d29d2e09 Baoquan He   2023-08-29  457  #endif
6bee83d29d2e09 Baoquan He   2023-08-29  458  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
