Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C4FC4167B
	for <kexec@archiver.kernel.org>; Tue,  5 Dec 2023 14:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uCHumTS3FzpfbAKKrukMKPAaSXTp+DnvN9aGtxr6o1A=; b=eBKNis6I58SbJq
	9yUby7hMLQQ/aiRoW1MnyLjYNpxzfjueb/Vts+QMcEpwGV4d+RVkOxLA/vKXd6GeFL81UmpI3bYm7
	7XgAYV9HqzWT8lgfWV8TsQOw0Mwcb59Zp3FD/hQYl3M0VQEfQhfwVpJA54DC9Yr7qO18hiWYkxW56
	Ep7vedldgN5JwDn9ivDq6aP8BqcLacxX0qozsG5a3tx+105LUOJjTf3b/8+E3GSOKqM6rB7qRyJR6
	XonAD01YaJGZcSpsJZ46tB5sXtAK1/xZL8Z+1EeksuX61oxAveD3VUXR1cFCGeL5D5gnnpY9x7dtp
	qdW2tyJ3Hlak4gHu0nTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAWDR-007Zji-1i;
	Tue, 05 Dec 2023 14:16:01 +0000
Received: from mgamail.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAWDO-007Zim-27
	for kexec@lists.infradead.org;
	Tue, 05 Dec 2023 14:16:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701785758; x=1733321758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HUtN95CBxY73WyhOnT1Lez/ETMiAOg2Qz+hvrK4nEdc=;
  b=gFDa+OLeuPj/kN1orFWDAyfK++NJQtFfY8rgfpQxfhTmQvEvvaJ3y7U3
   75Um9L1U19Xz/Tg6zRCK+i1gBLXhc9mogQCFR0ndTPudh06pzvqlIzohc
   pWbwhNzodXMHEIUwtDs96kL7BU6iDZ8Ti4kmo4EcWaPaK8ZY4g7VOm7Xh
   VsDjwD5FEFRL1elzmsr75e2zj3ApFPRj1/qWTKydVJTmeT9hunrhvl+As
   4pVCOrew+kMiW2vHA9DHU3uf0AjYAsgIGkv06LZC9Eek1m3czpMM3vnb4
   cKl/d92t8rvnUQMgXfqoBIseEqFouQBgBU1Gaj8aIT9xr4O8zXr7pIRZS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="378924953"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="378924953"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 06:15:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="799984120"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="799984120"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 05 Dec 2023 06:15:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAWCi-000994-33;
	Tue, 05 Dec 2023 14:15:16 +0000
Date: Tue, 5 Dec 2023 22:14:51 +0800
From: kernel test robot <lkp@intel.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@ozlabs.org
Cc: oe-kbuild-all@lists.linux.dev, David Hildenbrand <david@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Baoquan He <bhe@redhat.com>, x86@kernel.org,
	Laurent Dufour <laurent.dufour@fr.ibm.com>,
	Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kexec@lists.infradead.org, Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Akhil Raj <lf32.dev@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v13 5/6] powerpc: add crash CPU hotplug support
Message-ID: <202312052234.Oinhx3bT-lkp@intel.com>
References: <20231204053253.25305-6-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231204053253.25305-6-sourabhjain@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231205_061558_758645_EF5DB784 
X-CRM114-Status: GOOD (  18.70  )
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

Hi Sourabh,

kernel test robot noticed the following build errors:

[auto build test ERROR on powerpc/next]
[also build test ERROR on powerpc/fixes tip/x86/core akpm-mm/mm-everything linus/master v6.7-rc4 next-20231205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sourabh-Jain/crash-make-CPU-and-Memory-hotplug-support-reporting-flexible/20231204-143305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/20231204053253.25305-6-sourabhjain%40linux.ibm.com
patch subject: [PATCH v13 5/6] powerpc: add crash CPU hotplug support
config: powerpc64-randconfig-001-20231205 (https://download.01.org/0day-ci/archive/20231205/202312052234.Oinhx3bT-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312052234.Oinhx3bT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312052234.Oinhx3bT-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/kexec/file_load_64.c: In function 'kexec_extra_fdt_size_ppc64':
>> arch/powerpc/kexec/file_load_64.c:953:52: error: 'threads_per_core' undeclared (first use in this function)
     953 |         possible_cpu_nodes = num_possible_cpus() / threads_per_core;
         |                                                    ^~~~~~~~~~~~~~~~
   arch/powerpc/kexec/file_load_64.c:953:52: note: each undeclared identifier is reported only once for each function it appears in


vim +/threads_per_core +953 arch/powerpc/kexec/file_load_64.c

   915	
   916		// Budget some space for the password blob. There's already extra space
   917		// for the key name
   918		if (plpks_is_available())
   919			extra_size += (unsigned int)plpks_get_passwordlen();
   920	
   921		if (image->type != KEXEC_TYPE_CRASH)
   922			return extra_size;
   923	
   924		/*
   925		 * For kdump kernel, account for linux,usable-memory and
   926		 * linux,drconf-usable-memory properties. Get an approximate on the
   927		 * number of usable memory entries and use for FDT size estimation.
   928		 */
   929		if (drmem_lmb_size()) {
   930			usm_entries = ((memory_hotplug_max() / drmem_lmb_size()) +
   931				       (2 * (resource_size(&crashk_res) / drmem_lmb_size())));
   932			extra_size += (unsigned int)(usm_entries * sizeof(u64));
   933		}
   934	
   935		/*
   936		 * Get the number of CPU nodes in the current DT. This allows to
   937		 * reserve places for CPU nodes added since the boot time.
   938		 */
   939		cpu_nodes = 0;
   940		for_each_node_by_type(dn, "cpu") {
   941			cpu_nodes++;
   942		}
   943	
   944		if (cpu_nodes > boot_cpu_node_count)
   945			extra_size += (cpu_nodes - boot_cpu_node_count) * cpu_node_size();
   946	
   947	#ifdef CONFIG_CRASH_HOTPLUG
   948		/*
   949		 * Make sure enough space is reserved to accommodate possible CPU nodes
   950		 * in the crash FDT. This allows packing possible CPU nodes which are
   951		 * not yet present in the system without regenerating the entire FDT.
   952		 */
 > 953		possible_cpu_nodes = num_possible_cpus() / threads_per_core;
   954		if (image->type == KEXEC_TYPE_CRASH && possible_cpu_nodes > cpu_nodes)
   955			extra_size += (possible_cpu_nodes - cpu_nodes) * cpu_node_size();
   956	#endif
   957	
   958		return extra_size;
   959	}
   960	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
