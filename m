Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310A8CA100B
	for <kexec@archiver.kernel.org>; Sat, 31 Aug 2024 07:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ccEJylN6xiWnFueDR9fDA1nuu/BGyCoH2v1G7YMALo0=; b=htnOCTwMQ33PYZ
	8RT3UrrsJ7SCcX48iPMyRYqa0moTP43PSNnMs20JNXR3A9gzMXD0yuqjwCPL9PqNT94i+Tav9dFq0
	T15D8TvJiHvbY9vEShVSMp3Z7bXkO9EYQlZb/rtxFgfborGHp3uL6QNSFNEmAp05A7ib6FDVoVMPz
	GF8qEFhz2FaA1X7QuMP9C92ocHCQaHL7pu/7yuQbWzKVrsLGg5BLSgSvA+NhawntUb3/5c4RVDi+H
	qUv1O1tkthEa4WRivvItOIsT9SVHKdp6BpRAqmy+Y7afiAqT454dZeF9KvCZvgAlFCl8OlPWHBmBi
	PZtj7J509uHc/TobRk8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1skIeO-00000008rFZ-0G20;
	Sat, 31 Aug 2024 07:36:00 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1skIeJ-00000008rEO-3Zxp
	for kexec@lists.infradead.org;
	Sat, 31 Aug 2024 07:35:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725089756; x=1756625756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=czp5B2f7yB9kZl1r+dl0QORW3vwTZa6LcMuzRe1KU+8=;
  b=a6DkfDuObpg+6Hlkjg2x9ORDf5QbJiYA1Up45gteXtxb8hcV+zzrcPDF
   L++lP3ucm/pTFgxGtMkwHQbCq4oO9qtGtukxIp3cln2Pc6eqIMXmpSeek
   11/7CBoE7BLEkHKVixFpxoKXzrbH3c6S2f/qPZ2WvFClsgxtBVlrpPX7M
   5Uc3wezLE0FqmV71OFO75XdF7MvR/4InJ1AMh48Nvi4L8API4sGqqZKgk
   B8b1oazQMnyP8n5Q8bLLp6eypLsds9J6YnIWtkzUPqLty3uP+MouXTng0
   X9h/1XnWh0mpdRmmJqCBRef+nqpmxVG0OubEHgCTKYnFN0P/+Y53zOY/V
   Q==;
X-CSE-ConnectionGUID: PyooxJAiRuevW7h2chDsAQ==
X-CSE-MsgGUID: UsaiKaMmSKqMN7T/+cUzZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="26644519"
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="26644519"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 00:35:55 -0700
X-CSE-ConnectionGUID: yxTs2rpBSbuLl83xUL3cog==
X-CSE-MsgGUID: rW71+T5yRlq/qW58K35c4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="68950957"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 31 Aug 2024 00:35:51 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skIeC-0002Qw-1m;
	Sat, 31 Aug 2024 07:35:48 +0000
Date: Sat, 31 Aug 2024 15:35:11 +0800
From: kernel test robot <lkp@intel.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>, seanjc@google.com,
	pbonzini@redhat.com, dave.hansen@linux.intel.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, hpa@zytor.com,
	peterz@infradead.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, thomas.lendacky@amd.com, michael.roth@amd.com,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH] x86/sev: Fix host kdump support for SNP
Message-ID: <202408311530.cYa27OX8-lkp@intel.com>
References: <20240827203804.4989-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240827203804.4989-1-Ashish.Kalra@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240831_003555_964837_624A53D5 
X-CRM114-Status: GOOD (  12.56  )
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

Hi Ashish,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kvm/queue]
[also build test WARNING on linus/master v6.11-rc5 next-20240830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ashish-Kalra/x86-sev-Fix-host-kdump-support-for-SNP/20240828-044035
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/20240827203804.4989-1-Ashish.Kalra%40amd.com
patch subject: [PATCH] x86/sev: Fix host kdump support for SNP
config: i386-buildonly-randconfig-006-20240831 (https://download.01.org/0day-ci/archive/20240831/202408311530.cYa27OX8-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408311530.cYa27OX8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408311530.cYa27OX8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/kvm/svm/svm.c:50:
>> arch/x86/kvm/svm/svm.h:783:13: warning: function 'snp_decommision_all' has internal linkage but is not defined [-Wundefined-internal]
     783 | static void snp_decommision_all(void);
         |             ^
   arch/x86/kvm/svm/svm.c:686:3: note: used here
     686 |                 snp_decommision_all();
         |                 ^
   1 warning generated.


vim +/snp_decommision_all +783 arch/x86/kvm/svm/svm.h

   763	
   764	static inline void sev_free_vcpu(struct kvm_vcpu *vcpu) {}
   765	static inline void sev_vm_destroy(struct kvm *kvm) {}
   766	static inline void __init sev_set_cpu_caps(void) {}
   767	static inline void __init sev_hardware_setup(void) {}
   768	static inline void sev_hardware_unsetup(void) {}
   769	static inline int sev_cpu_init(struct svm_cpu_data *sd) { return 0; }
   770	static inline int sev_dev_get_attr(u32 group, u64 attr, u64 *val) { return -ENXIO; }
   771	#define max_sev_asid 0
   772	static inline void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code) {}
   773	static inline void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu) {}
   774	static inline int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
   775	{
   776		return 0;
   777	}
   778	static inline void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end) {}
   779	static inline int sev_private_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn)
   780	{
   781		return 0;
   782	}
 > 783	static void snp_decommision_all(void);
   784	#endif
   785	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
