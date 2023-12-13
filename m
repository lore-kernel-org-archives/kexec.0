Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589D4C4332F
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 11:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2Hy8IHj2QKLvxzzVQxlrG4Ia7XkvbSEFqLBLGXbVR1o=; b=W1t3dQMXQeIAOc
	I1OZ/wuupJKc0W1vexZIvyLCVeX3ukElK5pgj8tEo+VreWd1d7xFjXc8drVvK6zvAYwhR9n7Rynwq
	uYBp/3nvMe+VqsxBTAZWsuZOlCx27pHx2QJusHqlj2v2US7jR9bNhUvQi0liNILbJdBAm+Hr4R6Y5
	dLBFHzkyiQ+SV/VrieQK05YtQcF1vWH0IKwb7eL29kQkZ7pfUT/jrlPVyMuca/hlRzm3mT3pj/kue
	WsQTxDZUNzdACVARSL7STMhpvPjaJrPj6CIJa1k/YJX5LWqiHLXrNglW6A7aVQzDgc8LbycdnlUUJ
	3lRKOsShBbGRF9z9zqlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDNUM-00ET3A-20;
	Wed, 13 Dec 2023 11:33:18 +0000
Received: from mgamail.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDNUG-00ET0x-2O;
	Wed, 13 Dec 2023 11:33:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702467192; x=1734003192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dL6Em6F9/TJ8e69UFYykBz6xgC2V73mBvEEwVDeutqU=;
  b=a11bDhD3nZxn919vxQiPWoD54m+b1n+fxQLuh1itPLYEJWhgXyGLI0sF
   zQbH1YITeWHGSpAv9mLSKw8sbiBJDtHc0xGXE8+SDmFL6L6oSS00yA5he
   UmiIEdseYsNRfMf4Hlj370oI3OntqnftMGaN7cqs+Up9vv7w0oJ4iCprV
   d8yjO2+KxbEHVU3vajfsFtOpeSjxcS4XBm0ZHvINUb5p+A4RaW+54Y6y6
   N4vUBxUBhC6ExXetrZSw/4/+Bnw+Hqxm6kfuuFrEiPiVbvAD4j0N/0AeI
   wrdfaI/pY7e/TwTG4WyjqD1rfOK4xXjyf6akKe0kuM+HcpBS3pD1sgeHw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="394702318"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="394702318"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 03:33:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="897302957"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="897302957"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 13 Dec 2023 03:33:04 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDNU5-000KUJ-2l;
	Wed, 13 Dec 2023 11:33:01 +0000
Date: Wed, 13 Dec 2023 19:32:49 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	arnd@arndb.de, pbonzini@redhat.com, madvenka@linux.microsoft.com,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 02/15] memblock: Declare scratch memory as CMA
Message-ID: <202312131930.gMiphjju-lkp@intel.com>
References: <20231213000452.88295-3-graf@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231213000452.88295-3-graf@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_033312_788020_35ED9039 
X-CRM114-Status: GOOD (  13.07  )
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

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on arm64/for-next/core akpm-mm/mm-everything linus/master v6.7-rc5 next-20231213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Graf/mm-memblock-Add-support-for-scratch-memory/20231213-080941
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20231213000452.88295-3-graf%40amazon.com
patch subject: [PATCH 02/15] memblock: Declare scratch memory as CMA
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20231213/202312131930.gMiphjju-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231213/202312131930.gMiphjju-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312131930.gMiphjju-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/memblock.c:2153:13: warning: 'reserve_scratch_mem' defined but not used [-Wunused-function]
    2153 | static void reserve_scratch_mem(phys_addr_t start, phys_addr_t end)
         |             ^~~~~~~~~~~~~~~~~~~


vim +/reserve_scratch_mem +2153 mm/memblock.c

  2152	
> 2153	static void reserve_scratch_mem(phys_addr_t start, phys_addr_t end)
  2154	{
  2155	#ifdef CONFIG_MEMBLOCK_SCRATCH
  2156		ulong start_pfn = pageblock_start_pfn(PFN_DOWN(start));
  2157		ulong end_pfn = pageblock_align(PFN_UP(end));
  2158		ulong pfn;
  2159	
  2160		for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages) {
  2161			/* Mark as CMA to prevent kernel allocations in it */
  2162			set_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_CMA);
  2163		}
  2164	#endif
  2165	}
  2166	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
