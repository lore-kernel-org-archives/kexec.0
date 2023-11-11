Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821F3C4332F
	for <kexec@archiver.kernel.org>; Sat, 11 Nov 2023 10:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EsmUzxjOdRx8Xw1oK1cZo9b0xZ4ILU4Enp3cUXRoPtI=; b=cfoCMk5um6Fm75
	Xs+YY/cjO0zBGTQp54MU5960EY2EVfvpE2QZtrTRMBHe5H/lz5PFfWCbFPYI/f8dsguxNqWj7WXJh
	DuWCYJO/kAeOQ+oYZrZmCTso+NspvFP/vrhr93ujTgkjQWAPhx7tBfNjsiSUSgXlK/Wnx3TnmCt3Y
	5R/CGBBemt8WwY/Ai5pNsALKcE8XESjnuDcEBl24CieRQTN6OPZwdAkAOemSdBS1mvbjRU+Op2w9e
	I45POzY3gFzvY083K2MBQWDTEtCPmZtU8tgc9BkALAsIE2/pVReJ22GCYvhOvFE8cRdF8uD+IMMOX
	ICTJ46DrnbIbyaWXYflg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1lQk-00AM5M-1d;
	Sat, 11 Nov 2023 10:41:34 +0000
Received: from mgamail.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1lQg-00AM4R-2k
	for kexec@lists.infradead.org;
	Sat, 11 Nov 2023 10:41:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699699290; x=1731235290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yDgF8fRMeA3utzT1N//rBGwE20ulKHntUEzKVUCPbnU=;
  b=B5sYcrLOxBvQRkc/jONisRE/415ZIqsDXloFdYmSbcx2NaXFr4UC2kLC
   hJA3sfjMMp/hHDMx3DKd0G2TB8IE0Ec25Wlf/5HbR9G2q5iJMpGVrY7i4
   YWE5w9SYVj3UF8o9jEFFkAxooOMTwdowbr6GY5ftKYarxEEdKinOWvRle
   VCVl93PIN8/W1YLYAgi4vSKEXKzm6q3S+OSoQdL2iWPMEr9DsgvIzuniE
   VR17YXecwZkHEHdChiBF5Ekoldw2y4o0KKfUnTpz9oCdFqO7PMV1NCG4E
   0Dpn4qapm9K0jUfNHJHn6Fx1ydfQjhkvCaQnw6LcLjmyGFccgUGDLPYdw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="394171547"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="394171547"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 02:41:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="1095355185"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="1095355185"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 Nov 2023 02:41:18 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r1lQS-000ANh-2o;
	Sat, 11 Nov 2023 10:41:16 +0000
Date: Sat, 11 Nov 2023 18:41:06 +0800
From: kernel test robot <lkp@intel.com>
To: Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	ross.philipson@oracle.com, dpsmith@apertussolutions.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, luto@amacapital.net,
	nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v7 09/13] x86: Secure Launch SMP bringup support
Message-ID: <202311111806.sbmcWUN1-lkp@intel.com>
References: <20231110222751.219836-10-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231110222751.219836-10-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231111_024130_929364_964FB795 
X-CRM114-Status: GOOD (  15.11  )
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

Hi Ross,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on herbert-cryptodev-2.6/master herbert-crypto-2.6/master linus/master v6.6 next-20231110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ross-Philipson/x86-boot-Place-kernel_info-at-a-fixed-offset/20231111-063453
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20231110222751.219836-10-ross.philipson%40oracle.com
patch subject: [PATCH v7 09/13] x86: Secure Launch SMP bringup support
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231111/202311111806.sbmcWUN1-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311111806.sbmcWUN1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311111806.sbmcWUN1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/smpboot.c:1097:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (slaunch_is_txt_launch())
               ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/smpboot.c:1107:6: note: uninitialized use occurs here
           if (ret)
               ^~~
   arch/x86/kernel/smpboot.c:1097:2: note: remove the 'if' if its condition is always false
           if (slaunch_is_txt_launch())
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/smpboot.c:1046:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +1097 arch/x86/kernel/smpboot.c

  1036	
  1037	/*
  1038	 * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  1039	 * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
  1040	 * Returns zero if startup was successfully sent, else error code from
  1041	 * ->wakeup_secondary_cpu.
  1042	 */
  1043	static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
  1044	{
  1045		unsigned long start_ip = real_mode_header->trampoline_start;
  1046		int ret;
  1047	
  1048	#ifdef CONFIG_X86_64
  1049		/* If 64-bit wakeup method exists, use the 64-bit mode trampoline IP */
  1050		if (apic->wakeup_secondary_cpu_64)
  1051			start_ip = real_mode_header->trampoline_start64;
  1052	#endif
  1053		idle->thread.sp = (unsigned long)task_pt_regs(idle);
  1054		initial_code = (unsigned long)start_secondary;
  1055	
  1056		if (IS_ENABLED(CONFIG_X86_32)) {
  1057			early_gdt_descr.address = (unsigned long)get_cpu_gdt_rw(cpu);
  1058			initial_stack  = idle->thread.sp;
  1059		} else if (!(smpboot_control & STARTUP_PARALLEL_MASK)) {
  1060			smpboot_control = cpu;
  1061		}
  1062	
  1063		/* Enable the espfix hack for this CPU */
  1064		init_espfix_ap(cpu);
  1065	
  1066		/* So we see what's up */
  1067		announce_cpu(cpu, apicid);
  1068	
  1069		/*
  1070		 * This grunge runs the startup process for
  1071		 * the targeted processor.
  1072		 */
  1073		if (x86_platform.legacy.warm_reset) {
  1074	
  1075			pr_debug("Setting warm reset code and vector.\n");
  1076	
  1077			smpboot_setup_warm_reset_vector(start_ip);
  1078			/*
  1079			 * Be paranoid about clearing APIC errors.
  1080			*/
  1081			if (APIC_INTEGRATED(boot_cpu_apic_version)) {
  1082				apic_write(APIC_ESR, 0);
  1083				apic_read(APIC_ESR);
  1084			}
  1085		}
  1086	
  1087		smp_mb();
  1088	
  1089		/*
  1090		 * Wake up a CPU in difference cases:
  1091		 * - Intel TXT DRTM launch uses its own method to wake the APs
  1092		 * - Use a method from the APIC driver if one defined, with wakeup
  1093		 *   straight to 64-bit mode preferred over wakeup to RM.
  1094		 * Otherwise,
  1095		 * - Use an INIT boot APIC message
  1096		 */
> 1097		if (slaunch_is_txt_launch())
  1098			slaunch_wakeup_cpu_from_txt(cpu, apicid);
  1099		else if (apic->wakeup_secondary_cpu_64)
  1100			ret = apic->wakeup_secondary_cpu_64(apicid, start_ip);
  1101		else if (apic->wakeup_secondary_cpu)
  1102			ret = apic->wakeup_secondary_cpu(apicid, start_ip);
  1103		else
  1104			ret = wakeup_secondary_cpu_via_init(apicid, start_ip);
  1105	
  1106		/* If the wakeup mechanism failed, cleanup the warm reset vector */
  1107		if (ret)
  1108			arch_cpuhp_cleanup_kick_cpu(cpu);
  1109		return ret;
  1110	}
  1111	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
