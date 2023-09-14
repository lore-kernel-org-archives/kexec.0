Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0308EDE98F
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 08:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WWsU7SiDRvmvff4UFxpAjHNC25r71i3uAU0qR/DiCIE=; b=UUCPrTq7uPnsci
	ThT6o1kAICAXDDgbGmaEU90pcNvyWcfatcvs2nsXVYDu5ND0pHAtMYnI1HyWFojwVD0Ktz9zX1Mrg
	J8uIFp/BFqznw84E9y3DI93r9YtMqM6wPNayHCBVhVDJaX+5LQ1HpaCNOMCRIRAjqXbJgpDuzJ0cz
	wWyY5Qe9kxe1tJB4tWzfClgkolFzlRxGiHfcrDvm/DX8hVIV81OYJR/6AuNjq2IE7S5Y9rHD3YuXq
	rFpOV7Cb1ttiD9PLvG6McaqO2H6Cn7AH/VlFkJq2Y/sdFt8zyGt93FbuJumYUnpzHEg/mlhjdOClS
	A6gQ4fQUJeWWXXNGYKzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qghTM-007fz6-1J;
	Thu, 14 Sep 2023 08:13:12 +0000
Received: from mgamail.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qghTJ-007fxE-3D;
	Thu, 14 Sep 2023 08:13:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694679190; x=1726215190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0HuLFSOV1iee1YccL1q6ba1Qi+BrJA064NEgTIarkeA=;
  b=BeL1S4boKHipFP5a36bI8sYflSsqMUhS+X+pPuUtJuWSg48MGqLhm6Ux
   jc43F7C4X8XxtvuwOkEmVgWRWRAqb+vYfshJxeDt1IUcr30lDWc8RT4vL
   pLirXeGx6GVlh91RX/4nvgzDtRaiWPeZNNRHw7OmaUkjEkpj6x3U6shWj
   qQjkuPNb7sqCB0uZ/9T1OcN8+ycQHwFxz1apsgEc4ZBVgaDdwnLNA4C1O
   zWsFJbeN9fPrM28rshQ/kCYAWAW1xN9OF64UiqqdEgl4/OXLGI1mE+38Y
   30TnJVIoJXvGK/WwIAnzdhlna34uq6OhWF3qA1uXvb+GWdGuqqnXgVsmg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="382693808"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="382693808"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 01:13:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="1075270812"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="1075270812"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 14 Sep 2023 01:13:01 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qghT9-0001MP-09;
	Thu, 14 Sep 2023 08:12:59 +0000
Date: Thu, 14 Sep 2023 16:12:41 +0800
From: kernel test robot <lkp@intel.com>
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	akpm@linux-foundation.org, thunder.leizhen@huawei.com,
	catalin.marinas@arm.com, chenjiahao16@huawei.com,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, x86@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 6/9] x86: kdump: use generic interface to simplify
 crashkernel reservation code
Message-ID: <202309141534.moH4dTcz-lkp@intel.com>
References: <20230914033142.676708-7-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230914033142.676708-7-bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_011310_074455_D426B42F 
X-CRM114-Status: GOOD (  12.43  )
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on powerpc/next]
[also build test WARNING on powerpc/fixes linus/master v6.6-rc1 next-20230914]
[cannot apply to arm64/for-next/core tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/crash_core-c-remove-unnecessary-parameter-of-function/20230914-113546
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/20230914033142.676708-7-bhe%40redhat.com
patch subject: [PATCH v3 6/9] x86: kdump: use generic interface to simplify crashkernel reservation code
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20230914/202309141534.moH4dTcz-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309141534.moH4dTcz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309141534.moH4dTcz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/setup.c:476:15: warning: no previous prototype for function 'crash_low_size_default' [-Wmissing-prototypes]
   unsigned long crash_low_size_default(void)
                 ^
   arch/x86/kernel/setup.c:476:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned long crash_low_size_default(void)
   ^
   static 
   1 warning generated.


vim +/crash_low_size_default +476 arch/x86/kernel/setup.c

   472	
   473	/*
   474	 * --------- Crashkernel reservation ------------------------------
   475	 */
 > 476	unsigned long crash_low_size_default(void)
   477	{
   478	#ifdef CONFIG_X86_64
   479		return max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
   480	#else
   481		return 0;
   482	#endif
   483	}
   484	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
