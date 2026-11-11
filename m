Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE89606A321
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=r9T3SfVr;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F9o7/pau
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=TgHHyvViqeYkOrRMNUh0cE3JRgYXwdKQPlBKnS9WJ2o=; b=r9T3SfVrnBPMQigrMpdnmXZC3a
	aF8FMaymxqc6d9drO7GlEoiBNTJxRAaLmxD0vVjclSj3I/fZfK/C0Ecnrdrv1Ahlxd5gDneD4XrYi
	ZC+d+tZ4ZclRWOKZ9h8LP7d45oBLVFr7EAJlm7s9M2COtix7hMtTCDEXJTa0OMMe2XeriW+zb3F6l
	qGAw3hO4+QGI/hOCg+gOefEOrX3eKAszt7IkCDTLLZ27CfyZ1Hdl8QixQkCAjICKSMZH2N6me4RIP
	CgItm3ruYjpyQSfQ648TzShvCtnGfYLC6qqOYhOfTrmVpeE9lSa56LokIyx6Vf7irINRb4MnJZCg1
	EJ8csR2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xREML-00000007ZfB-3wBB;
	Wed, 11 Nov 2026 19:51:53 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xREMH-00000007Zcy-3nqv
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 19:51:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794426710; x=1825962710;
  h=date:from:to:cc:subject:message-id;
  bh=sryfPCv9MzmwkDJ/wLqT6WugDEONlGMvgwQlll08sa4=;
  b=F9o7/pauzs3ZCpUX7L+PrCL0MWXz+yp/o36q/91feBoTCCnOn7cZatH6
   s5kYcOVOB37fegsVKw+GgDD9eVXE3lcLDQp1qQOnE8l74dlmPhUF0NK0B
   db814pjU6N1v+9Uc76w+vw5uKs1RjifgJujwzxgEQ4iovrTJsjl6wcXHO
   CBj3EjKv7iW1x1wUpMQ6cnoHdGL0viuEGssZUu2KTvV2VmvRy4gAm4Ylu
   n30VwKJ9ni4YuptGwrPYbcT2HXokNZNOjnPvjVDix5H50ZjOSbYFZ42CO
   H+pVfzwhf0SIylXqCZg/kzMMRjIDeHjSCJiL04vsM8L0g4CGXpwSt9CAw
   Q==;
X-CSE-ConnectionGUID: +sVCOEX5TUyRK94GNECJcw==
X-CSE-MsgGUID: uAX4pegGTxWiWBhr+8bzgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3201819"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3201819"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 11:51:48 -0800
X-CSE-ConnectionGUID: VFpKbjdLQcmeMmy+/I+dIw==
X-CSE-MsgGUID: zgQCpvfwREe7dBDpI45lxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8450541"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 Nov 2026 11:51:46 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xREMB-00000000zbt-1Lvv;
	Wed, 11 Nov 2026 19:51:43 +0000
Date: Thu, 12 Nov 2026 03:51:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:next] BUILD SUCCESS
 a0dc8eddbfdb6dd9c5c2b70eb66ab49cb1978425
Message-ID: <20261112035135.OV1wgChV-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_115149_974368_4315521C 
X-CRM114-Status: UNSURE (   4.42  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -4.4 (----)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git next
branch HEAD: a0dc8eddbfdb6dd9c5c2b70eb66ab49cb1978425  Merge branch 'lu-pci-preservation' into next

elapsed time: 1241m

configs tested: 404
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261111    gcc-8.5.0
alpha                 randconfig-2001-20261111    gcc-8.5.0
alpha                 randconfig-2200-20261111    gcc-12.5.0 smatch
alpha                randconfig-r2107-20261111    gcc-10.5.0 cocci
alpha                randconfig-r2307-20261111    gcc-14     sparse
arc                               alldefconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                       axs103_smp_defconfig    gcc-16.2.0
arc                                  defconfig    gcc-16.2.0
arc                             hsdk_defconfig    gcc-16.2.0
arc                         nsimosci_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261111    gcc-15.3.0
arc                   randconfig-1001-20261111    gcc-15.3.0
arc                   randconfig-2000-20261111    gcc-14.4.0
arc                   randconfig-2001-20261111    gcc-14.4.0
arc                   randconfig-2002-20261111    gcc-14.4.0
arc                   randconfig-2003-20261111    gcc-14.4.0
arc                   randconfig-2004-20261111    gcc-14.4.0
arc                   randconfig-2005-20261111    gcc-14.4.0
arc                   randconfig-2200-20261111    gcc-16.2.0 smatch
arc                  randconfig-r2104-20261111    gcc-8.5.0  cocci
arc                  randconfig-r2110-20261111    gcc-10.5.0 cocci
arc                  randconfig-r2308-20261111    gcc-11.5.0 sparse
arc                  randconfig-r2308-20261111    gcc-14     sparse
arc                            tb10x_defconfig    clang-19
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                      am200epdkit_defconfig    gcc-16.2.0
arm                          bcm2835_defconfig    gcc-16.2.0
arm                      davinci_all_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                             hisi_defconfig    gcc-16.2.0
arm                          lpc18xx_defconfig    gcc-16.2.0
arm                         mvebu_v7_defconfig    clang-24
arm                        omap2plus_defconfig    gcc-16.2.0
arm                           pxa910_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261111    gcc-15.3.0
arm                   randconfig-1001-20261111    gcc-15.3.0
arm                   randconfig-1002-20261111    gcc-15.3.0
arm                   randconfig-1003-20261111    gcc-15.3.0
arm                   randconfig-2000-20261111    gcc-16.2.0
arm                   randconfig-2001-20261111    gcc-16.2.0
arm                   randconfig-2002-20261111    gcc-16.2.0
arm                   randconfig-2200-20261111    gcc-8.5.0  smatch
arm                  randconfig-r2103-20261111    gcc-8.5.0  cocci
arm                  randconfig-r2305-20261111    gcc-16.2.0 sparse
arm                         spear3xx_defconfig    gcc-16.2.0
arm                         spear6xx_defconfig    clang-19
arm                            sunxi_defconfig    clang-19
arm                        versatile_defconfig    clang-19
arm                         vexpress_defconfig    clang-19
arm                          vf610m4_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261111    gcc-13.5.0
arm64                 randconfig-1001-20261111    gcc-13.5.0
arm64                 randconfig-1002-20261111    gcc-13.5.0
arm64                 randconfig-1003-20261111    gcc-13.5.0
arm64                 randconfig-2000-20261111    gcc-16.2.0
arm64                 randconfig-2001-20261111    gcc-16.2.0
arm64                 randconfig-2002-20261111    gcc-16.2.0
arm64                 randconfig-2200-20261111    gcc-11.5.0 smatch
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261111    gcc-13.5.0
csky                  randconfig-1001-20261111    gcc-13.5.0
csky                  randconfig-2000-20261111    gcc-16.2.0
csky                  randconfig-2001-20261111    gcc-16.2.0
csky                  randconfig-2200-20261111    gcc-16.2.0 smatch
csky                 randconfig-r2100-20261111    gcc-8.5.0  cocci
csky                 randconfig-r2102-20261111    gcc-8.5.0  cocci
csky                 randconfig-r2110-20261111    gcc-11.5.0 cocci
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261111    clang-17
hexagon               randconfig-1001-20261111    clang-17
hexagon               randconfig-2000-20261111    gcc-16.2.0
hexagon               randconfig-2001-20261111    gcc-16.2.0
hexagon               randconfig-2200-20261111    clang-24   smatch
hexagon              randconfig-r2111-20261111    gcc-12.5.0 cocci
hexagon              randconfig-r2311-20261111    gcc-11.5.0 sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261111    clang-22
i386        buildonly-randconfig-1001-20261111    clang-22
i386        buildonly-randconfig-1002-20261111    clang-22
i386        buildonly-randconfig-1003-20261111    clang-22
i386        buildonly-randconfig-1004-20261111    clang-22
i386        buildonly-randconfig-1005-20261111    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261111    gcc-13
i386                  randconfig-1001-20261111    gcc-13
i386                  randconfig-1002-20261111    gcc-13
i386                  randconfig-1003-20261111    gcc-13
i386                  randconfig-1004-20261111    gcc-13
i386                  randconfig-1005-20261111    gcc-13
i386                  randconfig-1006-20261111    gcc-13
i386                  randconfig-1007-20261111    clang-22
i386                  randconfig-1008-20261111    clang-22
i386                  randconfig-1009-20261111    clang-22
i386                  randconfig-1010-20261111    clang-22
i386                  randconfig-1011-20261111    clang-22
i386                  randconfig-1012-20261111    clang-22
i386                  randconfig-1013-20261111    clang-22
i386                  randconfig-2000-20261111    gcc-14
i386                  randconfig-2001-20261111    gcc-14
i386                  randconfig-2002-20261111    gcc-14
i386                  randconfig-2003-20261111    gcc-14
i386                  randconfig-2004-20261111    gcc-14
i386                  randconfig-2005-20261111    gcc-14
i386                  randconfig-2100-20261111    gcc-14     cocci
i386                  randconfig-2101-20261111    gcc-14     cocci
i386                  randconfig-2102-20261111    gcc-14     cocci
i386                  randconfig-2103-20261111    gcc-14     cocci
i386                  randconfig-2104-20261111    gcc-14     cocci
i386                  randconfig-2105-20261111    gcc-14     cocci
i386                  randconfig-2200-20261111    gcc-14     smatch
i386                  randconfig-2300-20261111    gcc-14     sparse
i386                  randconfig-2301-20261111    gcc-14     sparse
i386                  randconfig-2302-20261111    gcc-14     sparse
i386                 randconfig-r2104-20261111    gcc-8.5.0  cocci
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261111    clang-17
loongarch             randconfig-1001-20261111    clang-17
loongarch             randconfig-2000-20261111    gcc-11.5.0
loongarch             randconfig-2001-20261111    gcc-11.5.0
loongarch             randconfig-2200-20261111    gcc-16.2.0 smatch
loongarch            randconfig-r2103-20261111    gcc-8.5.0  cocci
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                          amcore_defconfig    gcc-16.2.0
m68k                           atari_defconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                           multi_defconfig    gcc-16.2.0
m68k                  randconfig-2000-20261111    gcc-8.5.0
m68k                  randconfig-2001-20261111    gcc-8.5.0
m68k                  randconfig-2200-20261111    gcc-9.5.0  smatch
m68k                 randconfig-r2102-20261111    gcc-8.5.0  cocci
m68k                 randconfig-r2105-20261111    gcc-8.5.0  cocci
m68k                 randconfig-r2108-20261111    gcc-11.5.0 cocci
m68k                 randconfig-r2301-20261111    clang-24   sparse
m68k                 randconfig-r2304-20261111    clang-24   sparse
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261111    gcc-8.5.0
microblaze            randconfig-2001-20261111    gcc-8.5.0
microblaze            randconfig-2200-20261111    gcc-8.5.0  smatch
microblaze           randconfig-r2111-20261111    gcc-10.5.0 cocci
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                        bmips_be_defconfig    gcc-16.2.0
mips                 econet_en751221_defconfig    gcc-16.2.0
mips                           eyeq6_defconfig    clang-24
mips                             gpr_defconfig    clang-24
mips                        lemote2f_defconfig    clang-24
mips                       malta_kvm_defconfig    clang-19
mips                            mtx1_defconfig    clang-24
mips                         qi_lb60_defconfig    gcc-16.2.0
mips                  randconfig-2000-20261111    gcc-10.5.0
mips                  randconfig-2001-20261111    gcc-10.5.0
mips                  randconfig-2002-20261111    gcc-10.5.0
mips                  randconfig-2200-20261111    clang-19   smatch
mips                 randconfig-r2109-20261111    gcc-10.5.0 cocci
mips                 randconfig-r2109-20261111    gcc-11.5.0 cocci
mips                 randconfig-r2303-20261111    clang-24   sparse
mips                 randconfig-r2310-20261111    gcc-11.5.0 sparse
mips                            xway_defconfig    clang-19
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261111    clang-17
nios2                 randconfig-1001-20261111    clang-17
nios2                 randconfig-2000-20261111    gcc-11.5.0
nios2                 randconfig-2001-20261111    gcc-11.5.0
nios2                 randconfig-2200-20261111    gcc-8.5.0  smatch
nios2                randconfig-r2101-20261111    gcc-8.5.0  cocci
nios2                randconfig-r2104-20261111    gcc-10.5.0 cocci
nios2                randconfig-r2105-20261111    gcc-8.5.0  cocci
openrisc                          alldefconfig    gcc-16.2.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261111    gcc-10.5.0
openrisc              randconfig-2001-20261111    gcc-10.5.0
openrisc              randconfig-2002-20261111    gcc-10.5.0
openrisc              randconfig-2200-20261111    gcc-16.2.0 smatch
openrisc             randconfig-r2105-20261111    gcc-8.5.0  cocci
openrisc             randconfig-r2106-20261111    gcc-10.5.0 cocci
openrisc             randconfig-r2302-20261111    gcc-16.2.0 sparse
openrisc             randconfig-r2311-20261111    gcc-14     sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261111    gcc-15.3.0
parisc                randconfig-1001-20261111    gcc-15.3.0
parisc                randconfig-2000-20261111    gcc-11.5.0
parisc                randconfig-2001-20261111    gcc-11.5.0
parisc                randconfig-2200-20261111    gcc-14.4.0 smatch
parisc               randconfig-r2101-20261111    gcc-8.5.0  cocci
parisc               randconfig-r2105-20261111    gcc-10.5.0 cocci
parisc               randconfig-r2108-20261111    gcc-12.5.0 cocci
parisc               randconfig-r2303-20261111    gcc-16.2.0 sparse
parisc64                          alldefconfig    clang-24
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                        eiger_defconfig    gcc-16.2.0
powerpc                         icon_defconfig    clang-19
powerpc                       pcm030_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261111    gcc-15.3.0
powerpc               randconfig-1001-20261111    gcc-15.3.0
powerpc               randconfig-2000-20261111    gcc-11.5.0
powerpc               randconfig-2001-20261111    gcc-11.5.0
powerpc               randconfig-2002-20261111    gcc-11.5.0
powerpc               randconfig-2200-20261111    gcc-13.5.0 smatch
powerpc              randconfig-r2103-20261111    gcc-10.5.0 cocci
powerpc              randconfig-r2307-20261111    gcc-11.5.0 sparse
powerpc                      stx_gp3_defconfig    gcc-16.2.0
powerpc                       tqm8xx_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261111    gcc-15.3.0
powerpc64             randconfig-1001-20261111    gcc-15.3.0
powerpc64             randconfig-2000-20261111    gcc-11.5.0
powerpc64             randconfig-2001-20261111    gcc-11.5.0
powerpc64             randconfig-2002-20261111    gcc-11.5.0
powerpc64             randconfig-2200-20261111    gcc-11.5.0 smatch
powerpc64            randconfig-r2101-20261111    gcc-10.5.0 cocci
powerpc64            randconfig-r2103-20261111    gcc-8.5.0  cocci
powerpc64            randconfig-r2106-20261111    gcc-11.5.0 cocci
powerpc64            randconfig-r2111-20261111    gcc-11.5.0 cocci
powerpc64            randconfig-r2300-20261111    gcc-16.2.0 sparse
powerpc64            randconfig-r2302-20261111    clang-24   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261111    clang-17
riscv                 randconfig-1001-20261111    clang-17
riscv                 randconfig-2000-20261111    clang-21
riscv                 randconfig-2001-20261111    clang-21
riscv                 randconfig-2002-20261111    clang-21
riscv                 randconfig-2003-20261111    clang-21
riscv                 randconfig-2004-20261111    clang-21
riscv                 randconfig-2005-20261111    clang-21
riscv                randconfig-r2107-20261111    gcc-12.5.0 cocci
riscv                randconfig-r2304-20261111    gcc-16.2.0 sparse
riscv                randconfig-r2305-20261111    clang-24   sparse
riscv                randconfig-r2306-20261111    gcc-11.5.0 sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261111    clang-17
s390                  randconfig-1001-20261111    clang-17
s390                  randconfig-2000-20261111    gcc-8.5.0
s390                  randconfig-2001-20261111    gcc-8.5.0
s390                  randconfig-2002-20261111    gcc-8.5.0
s390                  randconfig-2003-20261111    gcc-8.5.0
s390                  randconfig-2004-20261111    gcc-8.5.0
s390                  randconfig-2005-20261111    gcc-8.5.0
s390                 randconfig-r2104-20261111    gcc-8.5.0  cocci
s390                 randconfig-r2110-20261111    gcc-12.5.0 cocci
s390                        zfcpdump_defconfig    gcc-16.2.0
sh                                alldefconfig    gcc-16.2.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                 ecovec24-romimage_defconfig    gcc-16.2.0
sh                  kfr2r09-romimage_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261111    clang-17
sh                    randconfig-1001-20261111    clang-17
sh                    randconfig-2000-20261111    gcc-16.2.0
sh                    randconfig-2001-20261111    gcc-16.2.0
sh                    randconfig-2002-20261111    gcc-16.2.0
sh                    randconfig-2003-20261111    gcc-16.2.0
sh                    randconfig-2004-20261111    gcc-16.2.0
sh                    randconfig-2005-20261111    gcc-16.2.0
sh                    randconfig-2200-20261111    gcc-16.2.0 smatch
sh                   randconfig-r2310-20261111    gcc-14     sparse
sh                            se7780_defconfig    gcc-16.2.0
sh                         sh7763rdp_defconfig    gcc-16.2.0
sh                               ul2_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261111    gcc-16.2.0
sparc                 randconfig-1001-20261111    gcc-16.2.0
sparc                 randconfig-2000-20261111    clang-18
sparc                 randconfig-2001-20261111    clang-18
sparc                 randconfig-2200-20261111    gcc-12.5.0 smatch
sparc                randconfig-r2109-20261111    gcc-12.5.0 cocci
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261111    gcc-16.2.0
sparc64               randconfig-1001-20261111    gcc-16.2.0
sparc64               randconfig-2000-20261111    clang-18
sparc64               randconfig-2001-20261111    clang-18
sparc64               randconfig-2200-20261111    gcc-9.5.0  smatch
sparc64              randconfig-r2100-20261111    gcc-10.5.0 cocci
sparc64              randconfig-r2100-20261111    gcc-8.5.0  cocci
sparc64              randconfig-r2101-20261111    gcc-8.5.0  cocci
sparc64              randconfig-r2309-20261111    gcc-11.5.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261111    gcc-16.2.0
um                    randconfig-1001-20261111    gcc-16.2.0
um                    randconfig-2000-20261111    clang-18
um                    randconfig-2001-20261111    clang-18
um                    randconfig-2200-20261111    clang-24   smatch
um                   randconfig-r2102-20261111    gcc-8.5.0  cocci
um                   randconfig-r2106-20261111    gcc-12.5.0 cocci
um                   randconfig-r2107-20261111    gcc-11.5.0 cocci
um                   randconfig-r2301-20261111    gcc-16.2.0 sparse
um                            x86_64_defconfig    gcc-14
um                            x86_64_defconfig    gcc-16.2.0
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261111    gcc-14
x86_64      buildonly-randconfig-1001-20261111    gcc-14
x86_64      buildonly-randconfig-1002-20261111    gcc-14
x86_64      buildonly-randconfig-1003-20261111    gcc-14
x86_64      buildonly-randconfig-1004-20261111    gcc-14
x86_64      buildonly-randconfig-1005-20261111    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261111    clang-22
x86_64                randconfig-1001-20261111    clang-22
x86_64                randconfig-1002-20261111    clang-22
x86_64                randconfig-1003-20261111    clang-22
x86_64                randconfig-1004-20261111    clang-22
x86_64                randconfig-1005-20261111    clang-22
x86_64                randconfig-1006-20261111    clang-22
x86_64                randconfig-1007-20261111    clang-22
x86_64                randconfig-1008-20261111    clang-22
x86_64                randconfig-1009-20261111    clang-22
x86_64                randconfig-1010-20261111    clang-22
x86_64                randconfig-1011-20261111    clang-22
x86_64                randconfig-1012-20261111    gcc-14
x86_64                randconfig-1013-20261111    gcc-14
x86_64                randconfig-1014-20261111    gcc-14
x86_64                randconfig-1015-20261111    gcc-14
x86_64                randconfig-1016-20261111    gcc-14
x86_64                randconfig-1017-20261111    gcc-14
x86_64                randconfig-2000-20261111    clang-22
x86_64                randconfig-2001-20261111    clang-22
x86_64                randconfig-2002-20261111    clang-22
x86_64                randconfig-2003-20261111    clang-22
x86_64                randconfig-2004-20261111    clang-22
x86_64                randconfig-2005-20261111    clang-22
x86_64                randconfig-2100-20261111    clang-22   cocci
x86_64                randconfig-2101-20261111    clang-22   cocci
x86_64                randconfig-2102-20261111    clang-22   cocci
x86_64                randconfig-2103-20261111    clang-22   cocci
x86_64                randconfig-2104-20261111    clang-22   cocci
x86_64                randconfig-2105-20261111    clang-22   cocci
x86_64                randconfig-2200-20261111    gcc-14     smatch
x86_64                randconfig-2300-20261111    gcc-14     sparse
x86_64                randconfig-2301-20261111    gcc-14     sparse
x86_64                randconfig-2302-20261111    gcc-14     sparse
x86_64               randconfig-r2102-20261111    gcc-10.5.0 cocci
x86_64               randconfig-r2108-20261111    gcc-10.5.0 cocci
x86_64               randconfig-r2306-20261111    gcc-14     sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261111    gcc-16.2.0
xtensa                randconfig-1001-20261111    gcc-16.2.0
xtensa                randconfig-2000-20261111    gcc-16.2.0
xtensa                randconfig-2001-20261111    gcc-16.2.0
xtensa                randconfig-2200-20261111    gcc-8.5.0  smatch
xtensa               randconfig-r2100-20261111    gcc-8.5.0  cocci
xtensa               randconfig-r2300-20261111    clang-24   sparse
xtensa               randconfig-r2309-20261111    gcc-14     sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

