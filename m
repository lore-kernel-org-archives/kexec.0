Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2882FC43458
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 05:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hi7bGoLtusN0blUWgp0k1O1CfpEWvXcsrRZZn47XYso=; b=wMSui/I37cIEw/2CXKn6K9xJgG
	eh5BXAcrVKzeiJHINPJDUyUJazNBs1tCJISRcarunpKhChvRTSJu13G8xVz6LYv1AG5Abtq5aq7o/
	u3dIDa+4jnmG83ed9aic4hHhYmxiktcHqpnBa2B6++NhGbo1/HpcEcHGeGgyFmGOGSiuHYwnCd83/
	6H4jxX8aIbq8mdddCwyoTOm/3dy9s7CPTudiHUrH43Qu+abAv+QRL5SDNLVAia8bCcPixZS8/std4
	TpvijpV9USVdWrhA8HILb4MIu/9Y7c3hehTRLPaXV5DhDFdCv60M0v8EAl8E4daXBWXzqiJkTuboB
	NK50w3Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjVLd-0000000AueG-3T4V;
	Tue, 14 Jul 2026 05:06:25 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjVLa-0000000Audp-2Tos
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 05:06:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784005582; x=1815541582;
  h=date:from:to:cc:subject:message-id;
  bh=0MDsrHDkYAA5CGg/WY8yrZgPpVxQC74XZ/zGyf22YLs=;
  b=E/ypXhgx9pCFdXOjuO+R1T4/7yEVicTh0f0H/lobJILD9YxA76ck0KoW
   7YDP7M1kZoQyH4U6XIGL+UMi/uXfN8COvQGEqXjhamJ0n0AaDijo5cNOT
   Cps5t4K8nRXijZu9uY82xn4VuNDR8CRlppBXUE0AlExGdmKHxWDDzxR26
   EftF/TPJaFGGeo7SAWAgVa7+p3qqe5L5Pja7U8rlwFRcl9B7Uc98JsQdV
   l+2ba6pJNcVJ+04O8+LqbXDFf7AxsylbJX13m4izZ+6Zm/YFWDkr2xgHc
   jSFIeXz6DFDrNsQGMbDIOZHoavXz3rDjDJuD6sVdp2nl6fRF8+JWmMZma
   A==;
X-CSE-ConnectionGUID: SmUnXFmWRCSDV8xiJ/197Q==
X-CSE-MsgGUID: Tjxcz2zPT3i3a6PxbbvPEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="72143712"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="72143712"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 22:06:20 -0700
X-CSE-ConnectionGUID: AhX5mA4MT3mPlXCZVDcM5g==
X-CSE-MsgGUID: RD1+Y0U8RnuZ1Lu516exSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="260624631"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 13 Jul 2026 22:06:18 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wjVLU-00000000MQJ-0hWx;
	Tue, 14 Jul 2026 05:06:16 +0000
Date: Tue, 14 Jul 2026 13:05:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:kexec-fixes] BUILD SUCCESS
 ada2e5a44e99113e08ad9b7b71396c6c572204da
Message-ID: <202607141326.mkxerhRm-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_220622_718795_4E2F51D4 
X-CRM114-Status: UNSURE (   4.11  )
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git kexec-fixes
branch HEAD: ada2e5a44e99113e08ad9b7b71396c6c572204da  crash_dump: release keyring reference at the correct time

elapsed time: 914m

configs tested: 279
configs skipped: 19

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              alldefconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    clang-23
arc                   randconfig-001-20260713    gcc-8.5.0
arc                   randconfig-001-20260714    clang-23
arc                            randconfig-002    clang-23
arc                   randconfig-002-20260713    gcc-8.5.0
arc                   randconfig-002-20260714    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                          ixp4xx_defconfig    gcc-16.1.0
arm                            randconfig-001    clang-23
arm                   randconfig-001-20260713    gcc-8.5.0
arm                   randconfig-001-20260714    clang-23
arm                            randconfig-002    clang-23
arm                   randconfig-002-20260713    gcc-8.5.0
arm                   randconfig-002-20260714    clang-23
arm                            randconfig-003    clang-23
arm                   randconfig-003-20260713    gcc-8.5.0
arm                   randconfig-003-20260714    clang-23
arm                            randconfig-004    clang-23
arm                   randconfig-004-20260713    gcc-8.5.0
arm                   randconfig-004-20260714    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260713    gcc-11.5.0
arm64                 randconfig-001-20260713    gcc-13.4.0
arm64                 randconfig-001-20260714    gcc-16.1.0
arm64                 randconfig-002-20260713    gcc-13.4.0
arm64                 randconfig-002-20260714    gcc-16.1.0
arm64                 randconfig-003-20260713    gcc-11.5.0
arm64                 randconfig-003-20260713    gcc-13.4.0
arm64                 randconfig-003-20260714    gcc-16.1.0
arm64                 randconfig-004-20260713    gcc-13.4.0
arm64                 randconfig-004-20260713    gcc-8.5.0
arm64                 randconfig-004-20260714    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260713    gcc-13.4.0
csky                  randconfig-001-20260714    gcc-16.1.0
csky                  randconfig-002-20260713    gcc-11.5.0
csky                  randconfig-002-20260713    gcc-13.4.0
csky                  randconfig-002-20260714    gcc-16.1.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260713    clang-21
hexagon               randconfig-001-20260714    gcc-16.1.0
hexagon               randconfig-002-20260713    clang-23
hexagon               randconfig-002-20260714    gcc-16.1.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260713    gcc-14
i386        buildonly-randconfig-001-20260714    clang-22
i386        buildonly-randconfig-002-20260713    gcc-14
i386        buildonly-randconfig-002-20260714    clang-22
i386        buildonly-randconfig-003-20260713    gcc-14
i386        buildonly-randconfig-003-20260714    clang-22
i386        buildonly-randconfig-004-20260713    gcc-14
i386        buildonly-randconfig-004-20260714    clang-22
i386        buildonly-randconfig-005-20260713    gcc-14
i386        buildonly-randconfig-005-20260714    clang-22
i386        buildonly-randconfig-006-20260713    gcc-14
i386        buildonly-randconfig-006-20260714    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260713    gcc-14
i386                  randconfig-001-20260714    gcc-13
i386                  randconfig-002-20260714    gcc-13
i386                  randconfig-003-20260713    gcc-14
i386                  randconfig-003-20260714    gcc-13
i386                  randconfig-004-20260713    gcc-14
i386                  randconfig-004-20260714    gcc-13
i386                  randconfig-005-20260713    gcc-14
i386                  randconfig-005-20260714    gcc-13
i386                  randconfig-006-20260713    gcc-14
i386                  randconfig-006-20260714    gcc-13
i386                  randconfig-007-20260713    gcc-14
i386                  randconfig-007-20260714    gcc-13
i386                  randconfig-011-20260714    clang-22
i386                  randconfig-012-20260714    clang-22
i386                  randconfig-013-20260714    clang-22
i386                  randconfig-014-20260714    clang-22
i386                  randconfig-015-20260714    clang-22
i386                  randconfig-016-20260714    clang-22
i386                  randconfig-017-20260714    clang-22
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260713    clang-23
loongarch             randconfig-001-20260714    gcc-16.1.0
loongarch             randconfig-002-20260713    clang-23
loongarch             randconfig-002-20260714    gcc-16.1.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260713    gcc-11.5.0
nios2                 randconfig-001-20260714    gcc-16.1.0
nios2                 randconfig-002-20260713    gcc-9.5.0
nios2                 randconfig-002-20260714    gcc-16.1.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260713    clang-23
parisc                randconfig-001-20260713    gcc-10.5.0
parisc                randconfig-001-20260714    clang-17
parisc                randconfig-002-20260713    clang-23
parisc                randconfig-002-20260713    gcc-8.5.0
parisc                randconfig-002-20260714    clang-17
parisc64                            defconfig    clang-23
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                       holly_defconfig    clang-23
powerpc               randconfig-001-20260713    clang-23
powerpc               randconfig-001-20260713    gcc-13.4.0
powerpc               randconfig-001-20260714    clang-17
powerpc               randconfig-002-20260713    clang-23
powerpc               randconfig-002-20260714    clang-17
powerpc64             randconfig-001-20260713    clang-23
powerpc64             randconfig-001-20260713    gcc-15.2.0
powerpc64             randconfig-001-20260714    clang-17
powerpc64             randconfig-002-20260713    clang-23
powerpc64             randconfig-002-20260713    gcc-13.4.0
powerpc64             randconfig-002-20260714    clang-17
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv             nommu_k210_sdcard_defconfig    gcc-16.1.0
riscv                 randconfig-001-20260713    gcc-15.2.0
riscv                 randconfig-001-20260713    gcc-16.1.0
riscv                 randconfig-001-20260714    gcc-10.5.0
riscv                 randconfig-002-20260713    clang-19
riscv                 randconfig-002-20260714    gcc-10.5.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260713    gcc-16.1.0
s390                  randconfig-001-20260714    gcc-10.5.0
s390                  randconfig-002-20260713    clang-17
s390                  randconfig-002-20260713    gcc-16.1.0
s390                  randconfig-002-20260714    gcc-10.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             espt_defconfig    gcc-16.1.0
sh                    randconfig-001-20260713    gcc-16.1.0
sh                    randconfig-001-20260714    gcc-10.5.0
sh                    randconfig-002-20260713    gcc-15.2.0
sh                    randconfig-002-20260713    gcc-16.1.0
sh                    randconfig-002-20260714    gcc-10.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260714    gcc-8.5.0
sparc                 randconfig-002-20260713    gcc-14.3.0
sparc                 randconfig-002-20260714    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260714    gcc-8.5.0
sparc64               randconfig-002-20260713    gcc-10.5.0
sparc64               randconfig-002-20260714    gcc-8.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260713    gcc-14
um                    randconfig-001-20260714    gcc-8.5.0
um                    randconfig-002-20260713    gcc-14
um                    randconfig-002-20260714    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260714    gcc-14
x86_64      buildonly-randconfig-002-20260714    gcc-14
x86_64      buildonly-randconfig-003-20260714    gcc-14
x86_64      buildonly-randconfig-004-20260714    gcc-14
x86_64      buildonly-randconfig-005-20260714    gcc-14
x86_64      buildonly-randconfig-006-20260714    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260713    gcc-14
x86_64                randconfig-001-20260714    clang-22
x86_64                randconfig-002-20260713    gcc-13
x86_64                randconfig-002-20260714    clang-22
x86_64                randconfig-003-20260713    clang-22
x86_64                randconfig-003-20260714    clang-22
x86_64                randconfig-004-20260713    clang-22
x86_64                randconfig-004-20260714    clang-22
x86_64                randconfig-005-20260713    gcc-13
x86_64                randconfig-005-20260714    clang-22
x86_64                randconfig-006-20260713    gcc-14
x86_64                randconfig-006-20260714    clang-22
x86_64                randconfig-011-20260713    gcc-14
x86_64                randconfig-011-20260714    clang-22
x86_64                randconfig-012-20260713    gcc-14
x86_64                randconfig-012-20260714    clang-22
x86_64                randconfig-013-20260713    gcc-14
x86_64                randconfig-013-20260714    clang-22
x86_64                randconfig-014-20260713    gcc-14
x86_64                randconfig-014-20260714    clang-22
x86_64                randconfig-015-20260713    gcc-14
x86_64                randconfig-015-20260714    clang-22
x86_64                randconfig-016-20260713    gcc-14
x86_64                randconfig-016-20260714    clang-22
x86_64                randconfig-071-20260714    gcc-14
x86_64                randconfig-072-20260714    gcc-14
x86_64                randconfig-073-20260713    gcc-14
x86_64                randconfig-073-20260714    gcc-14
x86_64                randconfig-074-20260713    gcc-14
x86_64                randconfig-074-20260714    gcc-14
x86_64                randconfig-075-20260713    gcc-14
x86_64                randconfig-075-20260714    gcc-14
x86_64                randconfig-076-20260713    gcc-14
x86_64                randconfig-076-20260714    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260713    gcc-12.5.0
xtensa                randconfig-001-20260714    gcc-8.5.0
xtensa                randconfig-002-20260713    gcc-14.3.0
xtensa                randconfig-002-20260714    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

