Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D39CD4847
	for <kexec@archiver.kernel.org>; Wed,  4 Sep 2024 10:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R9rdeOG+n/dVOIN85hnBfU00Q4n3sXUvpEXGxAZsdO0=; b=OhOLXWWi4Wrr2a
	Nk4C8v/erKdkkIH1aoaSPb20WXUWzHHYODazgTJG98xS9yYMX/mklKRg3hVLrkfNow9OechhGAhIV
	BEeFbdifXbuupXoHUXVbhXsfqdfD7+artcGV0nh+pGFjik7ZST/vvJ5hEz/KdwppQnUPRKnYzEk6z
	321Jwkan3jqx0Lz5WHTiLeays9ieXQjYxxuhsa7hhxs+P+EIewv+VG33mTU0MY7UJ1rtHEER/HMfL
	6grwKI03INP8GKbTL8123dgk0pwiAYnyGPHtkkRiXlaCN6gEk0aGILdESBJG4Wq55Kb/EvrWp3HPf
	clHLOOIPFa1d80eCa+FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slmyl-00000003qhL-1Lai;
	Wed, 04 Sep 2024 10:11:11 +0000
Received: from mgamail.intel.com ([192.198.163.14])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slmRt-00000003iKW-3ZdJ
	for kexec@lists.infradead.org;
	Wed, 04 Sep 2024 09:37:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725442634; x=1756978634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MRI42CKgJTs+ilD0WptG4fiGcysSWtMrf69iJuwhEW8=;
  b=GmEMeaVA7qB90ScuXmaxRkiuZAC431r14Q2cWRG9YRiAV2uSDi5HeNYd
   jaqxCnVy4ldnfUNM9Kprr3wiLOEVFF7EpKEsU56eSx7DE5JLM1PK3y+ak
   QgP9ZNLJSnKG2oTcvaA0WUnwwPaLqj2aetZcu/iJNEWPOfv+O/kFmZGir
   6gZayZ2X4FajATFVtkpYcFYkxRToCAeDQUmtWLFEq3T4YFG6sMmgBfwI6
   pyZIU/zQw0RpzKQD7wDYRN88Ol/7mSLoIal0isX2rTFjjHN5vQnxuIs1e
   bKpc5oS81fA/e+sW7jDQjgbNQD2DjAuxSejFF0de8AHE8EEQsEg8vVd3U
   g==;
X-CSE-ConnectionGUID: brvRnIxjTPKVm69X5+PODA==
X-CSE-MsgGUID: z8RmiHHRR1K4rEdWA4PQPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24282247"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="24282247"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 02:37:10 -0700
X-CSE-ConnectionGUID: d0r+BYN8SpGJOZjq18N87w==
X-CSE-MsgGUID: vdCyl8MJT2OrIqkJ7EljEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="70076393"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 04 Sep 2024 02:37:07 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slmRk-0007oi-1D;
	Wed, 04 Sep 2024 09:37:04 +0000
Date: Wed, 4 Sep 2024 17:36:31 +0800
From: kernel test robot <lkp@intel.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>, seanjc@google.com,
	pbonzini@redhat.com, dave.hansen@linux.intel.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, hpa@zytor.com,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	thomas.lendacky@amd.com, michael.roth@amd.com,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH v2] x86/sev: Fix host kdump support for SNP
Message-ID: <202409041737.FSl6a7vH-lkp@intel.com>
References: <20240903191033.28365-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240903191033.28365-1-Ashish.Kalra@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_023713_937843_E294219C 
X-CRM114-Status: GOOD (  12.26  )
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
[also build test WARNING on linus/master v6.11-rc6 next-20240904]
[cannot apply to kvm/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ashish-Kalra/x86-sev-Fix-host-kdump-support-for-SNP/20240904-031215
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/20240903191033.28365-1-Ashish.Kalra%40amd.com
patch subject: [PATCH v2] x86/sev: Fix host kdump support for SNP
config: x86_64-randconfig-r073-20240904 (https://download.01.org/0day-ci/archive/20240904/202409041737.FSl6a7vH-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240904/202409041737.FSl6a7vH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409041737.FSl6a7vH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/kvm/kvm-asm-offsets.c:11:
>> arch/x86/kvm/svm/svm.h:783:13: warning: 'sev_emergency_disable' defined but not used [-Wunused-function]
     783 | static void sev_emergency_disable(void) {}
         |             ^~~~~~~~~~~~~~~~~~~~~


vim +/sev_emergency_disable +783 arch/x86/kvm/svm/svm.h

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
 > 783	static void sev_emergency_disable(void) {}
   784	#endif
   785	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
