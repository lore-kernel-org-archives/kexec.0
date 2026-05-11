Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1554DCD37B7
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 04:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=igcIJ5hMoedm6mdBGPE0CqqSB8cDI+NRA3h7m8tdYUI=; b=PwvjdlNDtWfajpO17kjJEpJUHL
	OZ5bnQxnYYbWMR1D6a4HCCZ+g5CMih5MW+plS4Eui3QsarQ0qFCNwfIWO6ZlisN1QlXbpO/rwFnET
	5udtNGBHMPTuuz7j+AQzQm1ebQ9qGRdCvKUJGT34rlDq1V4YVlO+YoqCiCKklDaWVpF5/I+X+IfCz
	JGPatmL/XYqdTeKyY7XjSUvkNPzeewhwv+TINI8UIZR+SzQpwNVt8OJ2rpvh/nT/zwxSDSujQNqwC
	P735SqAzpzCJMrhYX1ia34wuEOgGEgy7uxxknginm+mzyzrrrM2IjuBJ24F3MyPiKdxIFlHBa7F88
	pgCYp1rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMIk3-0000000CJxl-03ux;
	Mon, 11 May 2026 04:59:43 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMIjs-0000000CJvd-0Hce
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 04:59:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778475573; x=1810011573;
  h=date:from:to:cc:subject:message-id;
  bh=th6o4e2lqENKz8JLqMVm+UGoUZTtIUVz9Kj8yEEm/LU=;
  b=RuW9NfD5Udi/g5eqQMsz2xQfdiKTtAp6kTw30ME6XbUKBO1w7oclrE1Z
   J0c0Xs/X3A/1hCeS3BvBnqPB1YB9xfjf6ddK4JDNCJ3dM0hPYE8fC3VUB
   fruUXYebgX+zYfBy16ZcC6avGcRFOvvACZBbhYfS3/GjFXaKZYLf2pUhG
   I2fhpUy5bNTKKZPBoo/pyUq8pShESz1FL3sX7xd8xSH5T6ZO+vvCr/GPA
   UK53E4cgxCufMjZWe3z8khShWkfYj+6mle4UtIZ3cPwso8/g/QCAPqi/x
   /3qKPRTT3fg4yYNQ5qUQfYc/myEjBH1FmyWHMyECxKXik64rNgr+CNaZJ
   w==;
X-CSE-ConnectionGUID: x0QyzjRpSfuLNEjKP/K0Vw==
X-CSE-MsgGUID: FlHJ+ESwRMa70rGpKnbGNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="96779620"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="96779620"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 21:59:31 -0700
X-CSE-ConnectionGUID: YaMv+QWMQKOsOG12HcMYgA==
X-CSE-MsgGUID: 2dW3VBg1RK2M71lPlTH/hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="242319364"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 10 May 2026 21:59:29 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMIjm-000000000B5-34rC;
	Mon, 11 May 2026 04:59:26 +0000
Date: Mon, 11 May 2026 12:58:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:fixes] BUILD SUCCESS
 eaf3933ec58da601cf0008afbcca7cf5433321e8
Message-ID: <202605111249.6D0dS0yW-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_215932_190613_C1F1889D 
X-CRM114-Status: UNSURE (   3.79  )
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git fixes
branch HEAD: eaf3933ec58da601cf0008afbcca7cf5433321e8  kho: fix KHO_TREE_MAX_DEPTH for non-4KB page sizes

elapsed time: 771m

configs tested: 275
configs skipped: 47

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260511    gcc-10.5.0
arc                   randconfig-002-20260511    gcc-10.5.0
arc                        vdk_hs38_defconfig    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                        clps711x_defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                            hisi_defconfig    gcc-15.2.0
arm                   randconfig-001-20260511    gcc-10.5.0
arm                   randconfig-002-20260511    gcc-10.5.0
arm                   randconfig-003-20260511    gcc-10.5.0
arm                   randconfig-004-20260511    gcc-10.5.0
arm                         wpcm450_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260511    clang-17
arm64                 randconfig-001-20260511    gcc-15.2.0
arm64                 randconfig-002-20260511    clang-17
arm64                 randconfig-002-20260511    gcc-15.2.0
arm64                 randconfig-003-20260511    clang-17
arm64                 randconfig-004-20260511    clang-17
arm64                 randconfig-004-20260511    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260511    clang-17
csky                  randconfig-001-20260511    gcc-15.2.0
csky                  randconfig-002-20260511    clang-17
csky                  randconfig-002-20260511    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260511    gcc-8.5.0
hexagon               randconfig-002-20260511    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260511    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260511    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260511    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260511    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260511    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260511    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260511    gcc-12
i386                  randconfig-002-20260511    gcc-12
i386                  randconfig-003-20260511    gcc-12
i386                  randconfig-004-20260511    gcc-12
i386                  randconfig-005-20260511    gcc-12
i386                  randconfig-006-20260511    gcc-12
i386                  randconfig-007-20260511    gcc-12
i386                           randconfig-011    clang-20
i386                  randconfig-011-20260511    clang-20
i386                  randconfig-011-20260511    gcc-14
i386                           randconfig-012    clang-20
i386                  randconfig-012-20260511    clang-20
i386                  randconfig-012-20260511    gcc-14
i386                           randconfig-013    clang-20
i386                  randconfig-013-20260511    clang-20
i386                           randconfig-014    clang-20
i386                  randconfig-014-20260511    clang-20
i386                           randconfig-015    clang-20
i386                  randconfig-015-20260511    clang-20
i386                  randconfig-015-20260511    gcc-13
i386                  randconfig-015-20260511    gcc-14
i386                           randconfig-016    clang-20
i386                  randconfig-016-20260511    clang-20
i386                           randconfig-017    clang-20
i386                  randconfig-017-20260511    clang-20
i386                  randconfig-017-20260511    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260511    gcc-8.5.0
loongarch             randconfig-002-20260511    gcc-8.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                malta_qemu_32r6_defconfig    gcc-15.2.0
mips                    maltaup_xpa_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.2.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260511    gcc-8.5.0
nios2                 randconfig-002-20260511    gcc-8.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260511    clang-20
parisc                randconfig-001-20260511    gcc-8.5.0
parisc                randconfig-002-20260511    clang-20
parisc                randconfig-002-20260511    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260511    clang-20
powerpc               randconfig-001-20260511    gcc-8.5.0
powerpc               randconfig-002-20260511    clang-20
powerpc64             randconfig-001-20260511    clang-20
powerpc64             randconfig-001-20260511    gcc-8.5.0
powerpc64             randconfig-002-20260511    clang-20
powerpc64             randconfig-002-20260511    gcc-14.3.0
powerpc64             randconfig-002-20260511    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                          randconfig-001    gcc-12.5.0
riscv                 randconfig-001-20260511    gcc-10.5.0
riscv                 randconfig-001-20260511    gcc-12.5.0
riscv                          randconfig-002    gcc-12.5.0
riscv                 randconfig-002-20260511    gcc-12.5.0
riscv                 randconfig-002-20260511    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                           randconfig-001    gcc-12.5.0
s390                  randconfig-001-20260511    gcc-12.5.0
s390                  randconfig-001-20260511    gcc-8.5.0
s390                           randconfig-002    gcc-12.5.0
s390                  randconfig-002-20260511    gcc-12.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-12.5.0
sh                    randconfig-001-20260511    gcc-12.5.0
sh                    randconfig-001-20260511    gcc-14.3.0
sh                             randconfig-002    gcc-12.5.0
sh                    randconfig-002-20260511    gcc-12.5.0
sh                           se7722_defconfig    gcc-15.2.0
sh                           se7751_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260511    gcc-8.5.0
sparc                 randconfig-002-20260511    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260511    gcc-8.5.0
sparc64               randconfig-002-20260511    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260511    gcc-8.5.0
um                    randconfig-002-20260511    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260511    gcc-14
x86_64      buildonly-randconfig-002-20260511    gcc-14
x86_64      buildonly-randconfig-003-20260511    clang-20
x86_64      buildonly-randconfig-003-20260511    gcc-14
x86_64      buildonly-randconfig-004-20260511    clang-20
x86_64      buildonly-randconfig-004-20260511    gcc-14
x86_64      buildonly-randconfig-005-20260511    gcc-14
x86_64      buildonly-randconfig-006-20260511    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260511    clang-20
x86_64                randconfig-001-20260511    gcc-14
x86_64                randconfig-002-20260511    clang-20
x86_64                randconfig-002-20260511    gcc-14
x86_64                randconfig-003-20260511    clang-20
x86_64                randconfig-004-20260511    clang-20
x86_64                randconfig-005-20260511    clang-20
x86_64                randconfig-006-20260511    clang-20
x86_64                         randconfig-011    clang-20
x86_64                randconfig-011-20260511    clang-20
x86_64                randconfig-011-20260511    gcc-14
x86_64                         randconfig-012    clang-20
x86_64                randconfig-012-20260511    clang-20
x86_64                randconfig-012-20260511    gcc-14
x86_64                         randconfig-013    clang-20
x86_64                randconfig-013-20260511    clang-20
x86_64                         randconfig-014    clang-20
x86_64                randconfig-014-20260511    clang-20
x86_64                randconfig-014-20260511    gcc-14
x86_64                         randconfig-015    clang-20
x86_64                randconfig-015-20260511    clang-20
x86_64                randconfig-015-20260511    gcc-14
x86_64                         randconfig-016    clang-20
x86_64                randconfig-016-20260511    clang-20
x86_64                randconfig-016-20260511    gcc-14
x86_64                         randconfig-071    clang-20
x86_64                randconfig-071-20260511    clang-20
x86_64                         randconfig-072    clang-20
x86_64                randconfig-072-20260511    clang-20
x86_64                randconfig-072-20260511    gcc-14
x86_64                         randconfig-073    clang-20
x86_64                randconfig-073-20260511    clang-20
x86_64                randconfig-073-20260511    gcc-14
x86_64                         randconfig-074    clang-20
x86_64                randconfig-074-20260511    clang-20
x86_64                randconfig-074-20260511    gcc-14
x86_64                         randconfig-075    clang-20
x86_64                randconfig-075-20260511    clang-20
x86_64                         randconfig-076    clang-20
x86_64                randconfig-076-20260511    clang-20
x86_64                randconfig-076-20260511    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-11.5.0
xtensa                randconfig-001-20260511    gcc-8.5.0
xtensa                randconfig-002-20260511    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

