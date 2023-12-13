Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970BFC4332F
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 13:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oWUcXBqBbgbH4Q9CBYy/BNdtZc0zhp0qyZtLziR4s8k=; b=YU5B27XUzHhwFi
	UojYNk8mZexNJgrKXPzZ7yXLVREilSJuDRctKIlz/m5KkjUO7OldtvhZ7k08s4tRzdmgYSCjQ7XmS
	/OZB6c2BMbtFyuoWS5rKyT5Vnh8HVhJBo70OLDPoM5pvkv5I9m+kTJAEpbz5OCdoTgPMkpV0b4hSh
	FlqKk+ZHlb+vi8oH016CJjkFpBpLw/njDJF8b0H6jy7UzYBNmRzyNQuKtsbQ2sf2l2+r2fsIEAYJ6
	cX/3KB7jzt89kcqBryqRTUJuYaHDEnbSITk1Xosi/6n+yyGpY96S7ooi69bWay5+Bvd+cCDGJIn9F
	mIzvsH9Ta0k3UZqY5hkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPUS-00Er9B-0L;
	Wed, 13 Dec 2023 13:41:32 +0000
Received: from mgamail.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPUO-00Er7Y-0N;
	Wed, 13 Dec 2023 13:41:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702474888; x=1734010888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UHu+07MBRevDOSW1Tf5iIKC4rfKnsAW4POR/WWx6Gr0=;
  b=k2Vg66oB1Iv5ilKJQsbiFyyqkIEmf7fijojiLRPZlKFlRjWj8hs74v89
   VBEUZMnvYgU0ybm/2mbgwGTjqvm1VII3Qeg/7EHF/4aC+teFwDzraFHJG
   1ODyoPR0/XlSA3/Bwxm6vh9oBT1jOgGaAIYA9Te6SelT1ziNJNKSDqDpE
   UINNVWRUeZL81/Vs6j+VtTFPaSFszLQI5/HUI2Nc7J74Wrp6YQ++lSMvG
   MQiRu89ab6Udpkppg0sOyMBhUP9gDC0KXcFts6FGdxlMa6A6m5tZ+tq6x
   tObIOBqFqdjb8XmwZXaUFzzjSgpTpR/e1VdTvWj+dKgzQt+1XzwV5nGw9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="461439320"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="461439320"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 05:41:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="892023724"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="892023724"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 13 Dec 2023 05:41:17 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDPUB-000Kcx-1a;
	Wed, 13 Dec 2023 13:41:15 +0000
Date: Wed, 13 Dec 2023 21:41:10 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH 06/15] arm64: Add KHO support
Message-ID: <202312132139.g2NKV67G-lkp@intel.com>
References: <20231213000452.88295-7-graf@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231213000452.88295-7-graf@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_054128_216948_A9C76E94 
X-CRM114-Status: GOOD (  14.12  )
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
patch link:    https://lore.kernel.org/r/20231213000452.88295-7-graf%40amazon.com
patch subject: [PATCH 06/15] arm64: Add KHO support
config: microblaze-randconfig-r133-20231213 (https://download.01.org/0day-ci/archive/20231213/202312132139.g2NKV67G-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231213/202312132139.g2NKV67G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312132139.g2NKV67G-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/of/fdt.c:1012:13: sparse: sparse: symbol 'early_init_dt_check_kho' was not declared. Should it be static?

vim +/early_init_dt_check_kho +1012 drivers/of/fdt.c

  1008	
  1009	/**
  1010	 * early_init_dt_check_kho - Decode info required for kexec handover from DT
  1011	 */
> 1012	void __init early_init_dt_check_kho(void)
  1013	{
  1014	#ifdef CONFIG_KEXEC_KHO
  1015		unsigned long node = chosen_node_offset;
  1016		u64 kho_start, scratch_start, scratch_size, mem_start, mem_size;
  1017		const __be32 *p;
  1018		int l;
  1019	
  1020		if ((long)node < 0)
  1021			return;
  1022	
  1023		p = of_get_flat_dt_prop(node, "linux,kho-dt", &l);
  1024		if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
  1025			return;
  1026	
  1027		kho_start = dt_mem_next_cell(dt_root_addr_cells, &p);
  1028	
  1029		p = of_get_flat_dt_prop(node, "linux,kho-scratch", &l);
  1030		if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
  1031			return;
  1032	
  1033		scratch_start = dt_mem_next_cell(dt_root_addr_cells, &p);
  1034		scratch_size = dt_mem_next_cell(dt_root_addr_cells, &p);
  1035	
  1036		p = of_get_flat_dt_prop(node, "linux,kho-mem", &l);
  1037		if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
  1038			return;
  1039	
  1040		mem_start = dt_mem_next_cell(dt_root_addr_cells, &p);
  1041		mem_size = dt_mem_next_cell(dt_root_addr_cells, &p);
  1042	
  1043		kho_populate(kho_start, scratch_start, scratch_size, mem_start, mem_size);
  1044	#endif
  1045	}
  1046	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
