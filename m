Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79796CCFA05
	for <kexec@archiver.kernel.org>; Thu,  6 Nov 2025 14:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jh3BnHvW8PIXMHNCqBwP8m/N0iJoZMQt+GVZ+IQ2MbI=; b=L84b9c3taRk7SIS8DFTiShQFPj
	icIIGmHfEQO4GR5eWxp+CChpGY6RxgVz0OeVWhHrQfyfmpD9Md1uIEqgNGu3Pg/Ctk/EpNwGIyDcH
	B0zoo7z9sjREi2JE0N/EDKti/hHaLGD7KsbOpw4rBbI7MXm2gBc0Voibv/5XSgE70R8HocwXlsQBf
	83jMstg2mCZx/amTMoF2+T0HsVf4NN/zUxNkdixof1YLffLqbl8xmxTfWMTTouMY6LzoWwaOJEzWn
	pPTNw5d7lp3bngPgXz25y6GDWfddBbxcHUg3ZM2eiThPqN3VHxPmu2LJGa3RC5DFjreCGrzZtZpOC
	76zLJUug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH18B-0000000Fi3N-3A7I;
	Thu, 06 Nov 2025 14:38:31 +0000
Received: from mgamail.intel.com ([198.175.65.20])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH188-0000000Fi2q-2JR2
	for kexec@lists.infradead.org;
	Thu, 06 Nov 2025 14:38:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762439909; x=1793975909;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+75GKPCI5jNkPc6bb4WB2j4Mz3JYShSPvH/44slbqt4=;
  b=JzVjJi+LHixsvto3sZ6RlM6/x6uxfIYnEODuMwx3/U9FvppKFfG79c9Q
   aVai1t16Df+blgJtdQatgOQ0bf207u+Mszd4NvdZ3ggRLmd+btUdyViZJ
   PtM0uaCa5K/4UvdFdWz8/cZd3sYZdp7fga4Et/UXitktkBpuou6bMKMvm
   7NxeIpepCpfYrk5R4EemStXfOlohU1YC9eEddfGfNc3j1oxQJivm+usLb
   OGYfGApt2J/M7JTIx0COdkirweY0CTiAlzgu8T5SiOxebZij9QmKTamid
   sONPWe1+1Aaelfc9UwNbCTdS6KVFhz8SfMRVH7lhiyO4KRoxxABjkF8f6
   A==;
X-CSE-ConnectionGUID: hccVG//zRt2yMhzcFnV6Cg==
X-CSE-MsgGUID: CiRZMCS1QdyPvdsIkflvHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64274317"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64274317"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 06:38:28 -0800
X-CSE-ConnectionGUID: mtLqvztIR2+6pQQoTPF7Mg==
X-CSE-MsgGUID: ezPYJZsdQpq225RUv4XYxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187487529"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 06 Nov 2025 06:38:24 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vH182-000U1K-1F;
	Thu, 06 Nov 2025 14:38:22 +0000
Date: Thu, 6 Nov 2025 22:38:11 +0800
From: kernel test robot <lkp@intel.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: oe-kbuild-all@lists.linux.dev, Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan he <bhe@redhat.com>, Jiri Bohac <jbohac@suse.cz>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shivang Upadhyay <shivangu@linux.ibm.com>,
	kexec@lists.infradead.org
Subject: Re: [PATCH v6] powerpc/kdump: Add support for crashkernel CMA
 reservation
Message-ID: <202511062213.dHidoorr-lkp@intel.com>
References: <20251104132818.1724562-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104132818.1724562-1-sourabhjain@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_063828_635786_55546928 
X-CRM114-Status: GOOD (  10.65  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Sourabh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on powerpc/next]
[also build test WARNING on powerpc/fixes linus/master v6.18-rc4 next-20251106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sourabh-Jain/powerpc-kdump-Add-support-for-crashkernel-CMA-reservation/20251104-213036
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/20251104132818.1724562-1-sourabhjain%40linux.ibm.com
patch subject: [PATCH v6] powerpc/kdump: Add support for crashkernel CMA reservation
config: powerpc64-randconfig-r113-20251106 (https://download.01.org/0day-ci/archive/20251106/202511062213.dHidoorr-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251106/202511062213.dHidoorr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511062213.dHidoorr-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/kexec/core.c:62:20: sparse: sparse: symbol 'crashk_cma_size' was not declared. Should it be static?
   arch/powerpc/kexec/core.c:188:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long static [addressable] [toplevel] [usertype] crashk_base @@     got restricted __be64 [usertype] @@
   arch/powerpc/kexec/core.c:188:29: sparse:     expected unsigned long long static [addressable] [toplevel] [usertype] crashk_base
   arch/powerpc/kexec/core.c:188:29: sparse:     got restricted __be64 [usertype]
   arch/powerpc/kexec/core.c:190:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long static [addressable] [toplevel] [usertype] crashk_size @@     got restricted __be64 [usertype] @@
   arch/powerpc/kexec/core.c:190:29: sparse:     expected unsigned long long static [addressable] [toplevel] [usertype] crashk_size
   arch/powerpc/kexec/core.c:190:29: sparse:     got restricted __be64 [usertype]
   arch/powerpc/kexec/core.c:198:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long static [addressable] [toplevel] mem_limit @@     got restricted __be64 [usertype] @@
   arch/powerpc/kexec/core.c:198:19: sparse:     expected unsigned long long static [addressable] [toplevel] mem_limit
   arch/powerpc/kexec/core.c:198:19: sparse:     got restricted __be64 [usertype]
   arch/powerpc/kexec/core.c:214:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long static [addressable] [toplevel] [usertype] kernel_end @@     got restricted __be64 [usertype] @@
   arch/powerpc/kexec/core.c:214:20: sparse:     expected unsigned long long static [addressable] [toplevel] [usertype] kernel_end
   arch/powerpc/kexec/core.c:214:20: sparse:     got restricted __be64 [usertype]

vim +/crashk_cma_size +62 arch/powerpc/kexec/core.c

    61	
  > 62	unsigned long long crashk_cma_size;
    63	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

