Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98C7C88E45
	for <kexec@archiver.kernel.org>; Fri, 11 Sep 2026 07:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EQHNPtC1njm0BJb++hebni4wCt1vRhLVWoCmA2EdbUg=; b=uXBqNRNRdB14zP4Z48TJHju7yz
	1OEr714qzIap7k0jo9qq9m8gWfIxtunP/aDQtnw6BXA1wEo4WLN/HWS8kLBtVZ3GrRDfZEuAbM/A8
	iCtf2nU1A9qH8HmBBeLgTT63EaIfphAwTByvSAdKgM9S3oV527B99sSSUCtTawQhMDEAk5jGWuf8H
	ySoTZpXkjFRRw3sk0YUvda+ZLcrMNg9rycXMxm9h9FXY/dAQQsFEPDTqpouwRciA0LLJSUwfFAol3
	AjPbHUBYSZHhwMCOEv7lEGRAv3gVxC0+xJFWAPwVyR6IvLHm6kvYoH/2qRo4Mcv7QOrB8Njo0/D3d
	Dbza3EEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4vvV-0000000G3dn-3SMK;
	Fri, 11 Sep 2026 07:44:01 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4vvS-0000000G3cv-0UwO
	for kexec@lists.infradead.org;
	Fri, 11 Sep 2026 07:44:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789112638; x=1820648638;
  h=date:from:to:cc:subject:message-id;
  bh=Fa5N1j++9OgmNh+C9kdMmPNpjr1UCpUX2PE46D/xvZ8=;
  b=AZvIDjjT3vG9uAT5+40dDWGg+yKl1DI4H8g1DmnDRTaKUBjgYkQge2Z0
   tXPUXeSHwg5ion/zcWFniziuZz84YpTlys62ifIjbLCB3jgTMoSwVBn00
   A3B0SEs/Z9lr9xBupK81MgzCJcrmgKuTY2emD+7KDh7PTbbsolMXsx9pw
   1irlbRX7V3Q5lN2dGZ0sVHEbwx+zP4jikldcF+g0ypSFXXWaQwYvIsVUZ
   PqZchTg3yOw04L7zeGMJDR2RRGgZQxi1UBFFBGW4IlnxsDx1SGOzol9rf
   2U8afG87BoeVw+nHJ/6P95DEP21REhMz9XU7uuZrKJDaPh2a0+t5b6LeE
   A==;
X-CSE-ConnectionGUID: chRQmjDCTCKo9rb+Rn3vnw==
X-CSE-MsgGUID: D1dkHhd9T/GpS++gn2/MiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="88516414"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="88516414"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 00:43:58 -0700
X-CSE-ConnectionGUID: 9jwjh1VsST+mZS0aS1efUg==
X-CSE-MsgGUID: A47FJ3fDRFa3vYUEwYqaNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="275622177"
Received: from lkp-server02.sh.intel.com (HELO 0a3643a6ed9d) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 11 Sep 2026 00:43:55 -0700
Received: from kbuild by 0a3643a6ed9d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x4vvD-000000001FF-2OhP;
	Fri, 11 Sep 2026 07:43:48 +0000
Date: Fri, 11 Sep 2026 15:40:42 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:liveupdate-7.4] BUILD SUCCESS
 dc645f2db7539352404525dd1b80236520fb39eb
Message-ID: <202609111538.75zNDSWU-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_004358_173160_AB03482E 
X-CRM114-Status: UNSURE (   3.75  )
X-CRM114-Notice: Please train this message.
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git liveupdate-7.4
branch HEAD: dc645f2db7539352404525dd1b80236520fb39eb  kho: docs: fix scratch_phys debugfs cross-reference

elapsed time: 1168m

configs tested: 187
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-24
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-24
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260911    clang-24
arc                   randconfig-002-20260911    clang-24
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-24
arm                       aspeed_g5_defconfig    clang-20
arm                         assabet_defconfig    clang-20
arm                                 defconfig    gcc-16.1.0
arm                          exynos_defconfig    clang-20
arm                   randconfig-001-20260911    clang-24
arm                   randconfig-002-20260911    clang-24
arm                   randconfig-003-20260911    clang-24
arm                   randconfig-004-20260911    clang-24
arm                           sama5_defconfig    gcc-16.1.0
arm64                            allmodconfig    clang-24
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260911    gcc-16.1.0
arm64                 randconfig-002-20260911    gcc-16.1.0
arm64                 randconfig-003-20260911    gcc-16.1.0
arm64                 randconfig-004-20260911    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260911    gcc-16.1.0
csky                  randconfig-002-20260911    gcc-16.1.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-24
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260911    gcc-12.5.0
hexagon               randconfig-002-20260911    gcc-12.5.0
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260911    clang-22
i386        buildonly-randconfig-002-20260911    clang-22
i386        buildonly-randconfig-003-20260911    clang-22
i386        buildonly-randconfig-004-20260911    clang-22
i386        buildonly-randconfig-005-20260911    clang-22
i386        buildonly-randconfig-006-20260911    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260911    clang-22
i386                  randconfig-002-20260911    clang-22
i386                  randconfig-003-20260911    clang-22
i386                  randconfig-004-20260911    clang-22
i386                  randconfig-005-20260911    clang-22
i386                  randconfig-006-20260911    clang-22
i386                  randconfig-007-20260911    clang-22
i386                  randconfig-011-20260911    clang-22
i386                  randconfig-012-20260911    clang-22
i386                  randconfig-013-20260911    clang-22
i386                  randconfig-014-20260911    clang-22
i386                  randconfig-015-20260911    clang-22
i386                  randconfig-016-20260911    clang-22
i386                  randconfig-017-20260911    clang-22
loongarch                        allmodconfig    clang-24
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-24
loongarch             randconfig-001-20260911    gcc-12.5.0
loongarch             randconfig-002-20260911    gcc-12.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-24
m68k                                defconfig    clang-24
m68k                       m5249evb_defconfig    gcc-16.1.0
m68k                       m5275evb_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-24
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                        vocore2_defconfig    clang-20
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-24
nios2                               defconfig    clang-24
nios2                 randconfig-001-20260911    gcc-12.5.0
nios2                 randconfig-002-20260911    gcc-12.5.0
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-24
openrisc                            defconfig    gcc-16.1.0
parisc                           alldefconfig    clang-20
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-24
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260911    gcc-8.5.0
parisc                randconfig-002-20260911    gcc-8.5.0
parisc64                            defconfig    clang-24
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-24
powerpc                 mpc836x_rdk_defconfig    clang-20
powerpc               randconfig-001-20260911    gcc-8.5.0
powerpc               randconfig-002-20260911    gcc-8.5.0
powerpc64             randconfig-001-20260911    gcc-8.5.0
powerpc64             randconfig-002-20260911    gcc-8.5.0
riscv                            allmodconfig    clang-24
riscv                             allnoconfig    clang-24
riscv                            allyesconfig    clang-24
riscv                               defconfig    gcc-16.1.0
riscv                    nommu_k210_defconfig    gcc-16.1.0
riscv                 randconfig-001-20260911    gcc-16.1.0
riscv                 randconfig-002-20260911    gcc-16.1.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-24
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260911    gcc-16.1.0
s390                  randconfig-002-20260911    gcc-16.1.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-24
sh                               allyesconfig    clang-17
sh                        apsh4ad0a_defconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260911    gcc-16.1.0
sh                    randconfig-002-20260911    gcc-16.1.0
sh                           se7619_defconfig    gcc-16.1.0
sh                   sh7770_generic_defconfig    gcc-16.1.0
sh                            shmin_defconfig    clang-20
sh                          urquell_defconfig    clang-20
sparc                             allnoconfig    clang-24
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260911    gcc-13.4.0
sparc                 randconfig-002-20260911    gcc-13.4.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260911    gcc-13.4.0
sparc64               randconfig-002-20260911    gcc-13.4.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-24
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260911    gcc-13.4.0
um                    randconfig-002-20260911    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-24
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260911    gcc-14
x86_64      buildonly-randconfig-002-20260911    gcc-14
x86_64      buildonly-randconfig-003-20260911    gcc-14
x86_64      buildonly-randconfig-004-20260911    gcc-14
x86_64      buildonly-randconfig-005-20260911    gcc-14
x86_64      buildonly-randconfig-006-20260911    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260911    clang-22
x86_64                randconfig-002-20260911    clang-22
x86_64                randconfig-003-20260911    clang-22
x86_64                randconfig-004-20260911    clang-22
x86_64                randconfig-005-20260911    clang-22
x86_64                randconfig-006-20260911    clang-22
x86_64                randconfig-011-20260911    gcc-14
x86_64                randconfig-012-20260911    gcc-14
x86_64                randconfig-013-20260911    gcc-14
x86_64                randconfig-014-20260911    gcc-14
x86_64                randconfig-015-20260911    gcc-14
x86_64                randconfig-016-20260911    gcc-14
x86_64                randconfig-071-20260911    gcc-14
x86_64                randconfig-072-20260911    gcc-14
x86_64                randconfig-073-20260911    gcc-14
x86_64                randconfig-074-20260911    gcc-14
x86_64                randconfig-075-20260911    gcc-14
x86_64                randconfig-076-20260911    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-24
xtensa                           allyesconfig    clang-20
xtensa                generic_kc705_defconfig    gcc-16.1.0
xtensa                randconfig-001-20260911    gcc-13.4.0
xtensa                randconfig-002-20260911    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

