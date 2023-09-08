Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA9FEE8018
	for <kexec@archiver.kernel.org>; Fri,  8 Sep 2023 15:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sto4sEVjtfVKKLNth50hkZEbxbAsvXAIKbseBTCfD4Y=; b=jQmzfZyE4d7s2Z
	mWasw2dJLrfruEVCFP7x40EW3B4nStPvRCu0wHlWzZ9FLOjTGQUN5WANAp6cfKa28TP2zBcJgE3ha
	fCKoMLuGtPyHGqi1qrZhjmxC3S5xchwghj6r+spZZyPl5/4bh4ZqEYhy7/y0yLkHIuTbbiL5CAkeI
	w2QbEg2Ti14jPZ55eU3E44oYmaBHjEdItEW2DsXRQyzO9cy5f2S4+4XmvSvQ2Q+pnNsmjZ799Z9eg
	zFankIDSNlVUeXxnX3KX8O54RHBNJ62NWg5TITAGK82Oiu3Rgn02vlLalK8nxFxiEWhzeMKEAvbQe
	6+BeSxbmwps/fHWALH4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qediU-00E1xi-2i;
	Fri, 08 Sep 2023 15:48:18 +0000
Received: from mgamail.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qediR-00E1xI-33
	for kexec@lists.infradead.org;
	Fri, 08 Sep 2023 15:48:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694188095; x=1725724095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7lZwzD4Jl1j1hHG9SxEpqmUzote7v9725kYKuPdquWo=;
  b=MAfJDb8k6mrz8KJQ/SS0cywsiq5aZPiro5wiqmxeIRHY5Jv7nFoBFtma
   nMU5TisqfqOBeJDzM3LA1Ye8/X4VLGHrHRZ1/8wPyjOUqRbWBHzLtzd7Z
   rlADGuT8Ezv+7ZSMOH0jBFz+viSQIB2fakaTw7YNdXSvtv191cjHuAoMK
   +6LlNNqqmFmAlSG77yBEwxL9v0i/XYkugQHBO2JMggZhVxxfKUVhDTeXO
   FIO9aDvXS/p7DqKkk7AdJFeDa+HZSt2T4S3jNaj2HiVQrM0/seq4IvXOt
   /vQN777CX2kkcnLmRqZrTpeNgYImU+xezTQJFgmTIa2cXhPcwxdpIlaQ2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="444113425"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="444113425"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 08:48:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="719194428"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="719194428"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Sep 2023 08:48:12 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qediM-0002PR-2W;
	Fri, 08 Sep 2023 15:48:10 +0000
Date: Fri, 8 Sep 2023 23:47:36 +0800
From: kernel test robot <lkp@intel.com>
To: Pingfan Liu <piliu@redhat.com>, linuxppc-dev@lists.ozlabs.org
Cc: oe-kbuild-all@lists.linux.dev, Baoquan He <bhe@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, kexec@lists.infradead.org,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Ming Lei <ming.lei@redhat.com>, Wen Xiong <wenxiong@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCHv5 1/3] powerpc/setup: Loosen the mapping between cpu
 logical id and its seq in dt
Message-ID: <202309082357.FUmBMhC4-lkp@intel.com>
References: <20230908141941.13660-2-piliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230908141941.13660-2-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_084816_026130_CF2BF0F5 
X-CRM114-Status: GOOD (  11.37  )
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

[auto build test ERROR on powerpc/fixes]
[also build test ERROR on linus/master v6.5 next-20230908]
[cannot apply to powerpc/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pingfan-Liu/powerpc-setup-Loosen-the-mapping-between-cpu-logical-id-and-its-seq-in-dt/20230908-222430
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git fixes
patch link:    https://lore.kernel.org/r/20230908141941.13660-2-piliu%40redhat.com
patch subject: [PATCHv5 1/3] powerpc/setup: Loosen the mapping between cpu logical id and its seq in dt
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20230908/202309082357.FUmBMhC4-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230908/202309082357.FUmBMhC4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309082357.FUmBMhC4-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/prom.c: In function 'early_init_dt_scan_cpus':
   arch/powerpc/kernel/prom.c:365:44: error: lvalue required as left operand of assignment
     365 |                                 nr_cpu_ids = nthreads;
         |                                            ^
   arch/powerpc/kernel/prom.c: At top level:
>> arch/powerpc/kernel/prom.c:79:23: error: 'boot_cpu_count' defined but not used [-Werror=unused-variable]
      79 | static int __initdata boot_cpu_count;
         |                       ^~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/boot_cpu_count +79 arch/powerpc/kernel/prom.c

c1e53367dab15e Srikar Dronamraju      2021-04-15  70  
9b6b563c0d2d25 Paul Mackerras         2005-10-06  71  #ifdef CONFIG_PPC64
28897731318dc8 Olof Johansson         2006-04-12  72  int __initdata iommu_is_off;
9b6b563c0d2d25 Paul Mackerras         2005-10-06  73  int __initdata iommu_force_on;
cf00a8d18b9a1c Paul Mackerras         2005-10-31  74  unsigned long tce_alloc_start, tce_alloc_end;
cd3db0c4ca3d23 Benjamin Herrenschmidt 2010-07-06  75  u64 ppc64_rma_size;
e13d23a404f2e6 Laurent Dufour         2022-11-10  76  unsigned int boot_cpu_node_count __ro_after_init;
9b6b563c0d2d25 Paul Mackerras         2005-10-06  77  #endif
03bf469add176a Benjamin Herrenschmidt 2011-05-11  78  static phys_addr_t first_memblock_size;
7ac87abb8166b9 Matt Evans             2011-05-25 @79  static int __initdata boot_cpu_count;
9b6b563c0d2d25 Paul Mackerras         2005-10-06  80  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
