Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A034DC83F2F
	for <kexec@archiver.kernel.org>; Thu, 29 Aug 2024 15:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xpb6kG1fVIY1Gnrh50J7xtuaCuNcM755IEdKFmgmKmI=; b=nF7tc93Mrfnwxh
	nycOvR+1gSc/do/hZ8/mpYBBFjL+TyigLFtl0g+9ri+PwLYT9NMy9/Y5xKUvUbUJqeUjybV/u0cdW
	p5BQO7Z8gdWLf9VEXCi6v2VE46yRu5QprgxKPpPhRGbAxRvkIbFhdF7mMH8rmcVuTt/hlVR4onZTD
	Jc4NcEERQM/45ybIV/2DVsZ1jnwbYRe3DU6CCgb+cEWes2Y6jN4erokUU53cvv30eprhTtnQeXN2M
	UprxLs1QbRUDvLK5lfH6STZqE1sFzpgm5BRrZmMONdGTtADmbawqD3+2NjwiV3OYj5zNDJET5lPvf
	/snVdxk6RZgkIIaYZXqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjhRN-00000002hXZ-0ocS;
	Thu, 29 Aug 2024 15:52:05 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjhPt-00000002h7s-3mr9
	for kexec@lists.infradead.org;
	Thu, 29 Aug 2024 15:50:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724946633; x=1756482633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xwa41nPWXFk5ZvYn4P/GOc574DpMq9cTCMistG6DV14=;
  b=kbhL8+jQ6uvk98ZQKd4UaFdLmnIKSsl9HnGCJql1wgj/8G4rLvVI8gxr
   2y97fVWfZvso++0aOyazIOjwzkaW3hwQVXCDsG3sZLX54kuP4mBL4Tdaf
   7s14A5b+vbNJFsJSrWdwE3lrggBzxyV6pTlc45Y1EF9CkO6jHK/P+TrsG
   y7mWeR/uLuYNSlT5rAz5XwUGFqK3A9LWlGehGJp+B9XylDXwG7hrA+pKz
   ohSx5enbjjLx51X2uIiaaF1WgBj+tnlp0BP0FWlCtGTa8LZ1sRS0zEDaS
   wPsxe65d5RACZe47jo7s6o9hsuwFphbTrScgzBRbs81gesNlRTAwEv2Rh
   g==;
X-CSE-ConnectionGUID: YWKNTRpRRWi2HSZXljNtvw==
X-CSE-MsgGUID: 0rFMd6QZS0aK1EqV8FzBaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34958247"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="34958247"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 08:50:31 -0700
X-CSE-ConnectionGUID: SqhaKlPuSoS/Ppr9Z5wcWA==
X-CSE-MsgGUID: caMfL994RjyUJRCwpirnWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="101129077"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 29 Aug 2024 08:50:28 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjhPl-0000Q4-0p;
	Thu, 29 Aug 2024 15:50:25 +0000
Date: Thu, 29 Aug 2024 23:50:07 +0800
From: kernel test robot <lkp@intel.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>, seanjc@google.com,
	pbonzini@redhat.com, dave.hansen@linux.intel.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, hpa@zytor.com,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	thomas.lendacky@amd.com, michael.roth@amd.com,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH] x86/sev: Fix host kdump support for SNP
Message-ID: <202408292344.yuQ5sYEz-lkp@intel.com>
References: <20240827203804.4989-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240827203804.4989-1-Ashish.Kalra@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_085033_981301_B97185CE 
X-CRM114-Status: GOOD (  12.97  )
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
[also build test WARNING on linus/master v6.11-rc5 next-20240829]
[cannot apply to kvm/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ashish-Kalra/x86-sev-Fix-host-kdump-support-for-SNP/20240828-044035
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/20240827203804.4989-1-Ashish.Kalra%40amd.com
patch subject: [PATCH] x86/sev: Fix host kdump support for SNP
config: x86_64-buildonly-randconfig-002-20240829 (https://download.01.org/0day-ci/archive/20240829/202408292344.yuQ5sYEz-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240829/202408292344.yuQ5sYEz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408292344.yuQ5sYEz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/kvm/svm/avic.c:28:
>> arch/x86/kvm/svm/svm.h:783:13: warning: 'snp_decommision_all' declared 'static' but never defined [-Wunused-function]
     783 | static void snp_decommision_all(void);
         |             ^~~~~~~~~~~~~~~~~~~
--
   In file included from arch/x86/kvm/svm/svm.c:50:
>> arch/x86/kvm/svm/svm.h:783:13: warning: 'snp_decommision_all' used but never defined
     783 | static void snp_decommision_all(void);
         |             ^~~~~~~~~~~~~~~~~~~


vim +783 arch/x86/kvm/svm/svm.h

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
