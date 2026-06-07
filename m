Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784FBCD8C88
	for <kexec@archiver.kernel.org>; Sun,  7 Jun 2026 00:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LsVnAb3M6ghY8IfcgDFFyEWPxQ2Ma8V9L0a8RkeT7IM=; b=0hggh0KQWgt9WASEHVUOsa++NL
	ixLHNtpeKasQRt+25lg6yQYYEgQTkEjF/WE+xSHv8OMfRqsxSaTNoYn/zLv6Q5oAdMPWzr88djeQ0
	liXJqZ3VLHwDXYJrvSqw+YL+JvTTp/yDXTIpg8NUW6RiSdB7/fbf7HDpAC7ZBN69y6hJ31p/zja0M
	/8J1tLVyIZTGeMRqVZctaz0CGIasDZTQxxHIzwFe2B85reWXuf9SRiTlMKWPsUj4V5eQUs3k+6p5t
	XQEkgIO+ZwxGnaTOOSjpn+Or2bsxuhmyU8804Oild0RlRO6Kvh93qrwb46LJnHsqUyATmJUMhUTwb
	sF28RXog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wW1BU-00000001uNw-1vA4;
	Sun, 07 Jun 2026 00:16:12 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wW1BR-00000001uNW-2yAM
	for kexec@lists.infradead.org;
	Sun, 07 Jun 2026 00:16:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780791369; x=1812327369;
  h=date:from:to:cc:subject:message-id;
  bh=kxfLynBRYBbULw25p42nxKNsZLUNihwxc4yaZRBAXP0=;
  b=HixJz+3QdmjVVMqulFqDQLKosYf15PbhApmvQMEGrAEP6qzrFxeHmHIo
   C3b+QfCS0g+d8sr3fqh7PQTouby06tIq1brtC2be0kJXGUONOXWA2uqGP
   VDdCdTB0h0z6KWvW3vsbCV/4Kk79cG3NNLHcYov4NKKc53/Vf5bajWbBF
   DlBdaIb2SBaAgLHah9rjN0+pVJx7+CTE9fKDCqq0K26BjF3DDFb+G1pZl
   rzc/PBbNObW8fzm7YBNxG+pwtUGnY2uHk1U2NqIdpnfEtiTxXu5tixLSC
   o3jxH4vwJmOnTvyrVXPWapvwmsx9yVFjNrVoX+W+XVgJBwvQCFkahyZA5
   g==;
X-CSE-ConnectionGUID: qSt4dDJdTZ2z+/X8Hm0RfA==
X-CSE-MsgGUID: siMOjBaiQWaLQkZHPpS1kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11809"; a="92960011"
X-IronPort-AV: E=Sophos;i="6.24,191,1774335600"; 
   d="scan'208";a="92960011"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2026 17:16:07 -0700
X-CSE-ConnectionGUID: SONaG1zFRY+z0uTW6yJkJA==
X-CSE-MsgGUID: q8RlKgzkQQOtuNL58JIFMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,191,1774335600"; 
   d="scan'208";a="244318159"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 06 Jun 2026 17:16:06 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wW1BK-00000000HUM-480J;
	Sun, 07 Jun 2026 00:16:02 +0000
Date: Sun, 07 Jun 2026 08:15:31 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:next] BUILD SUCCESS
 5fb813ae0009d97fc414f08ad73286f562e9a123
Message-ID: <202606070821.m6pqKPAo-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260606_171609_796818_C377837B 
X-CRM114-Status: UNSURE (   4.09  )
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git next
branch HEAD: 5fb813ae0009d97fc414f08ad73286f562e9a123  Merge patch series "liveupdate: Remove limits on sessions and files"

elapsed time: 4526m

configs tested: 191
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-17
arc                               allnoconfig    gcc-15.2.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260606    clang-23
arc                   randconfig-002-20260606    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-17
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260606    clang-23
arm                   randconfig-002-20260606    clang-23
arm                   randconfig-003-20260606    clang-23
arm                   randconfig-004-20260606    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260606    clang-23
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260606    clang-23
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260606    clang-23
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260606    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260606    clang-23
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260606    clang-23
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260606    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260606    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260606    gcc-13
i386        buildonly-randconfig-002-20260606    gcc-13
i386        buildonly-randconfig-003-20260606    gcc-13
i386        buildonly-randconfig-004-20260606    gcc-13
i386        buildonly-randconfig-005-20260606    gcc-13
i386        buildonly-randconfig-006-20260606    gcc-13
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260606    clang-20
i386                  randconfig-002-20260606    clang-20
i386                  randconfig-003-20260606    clang-20
i386                  randconfig-004-20260606    clang-20
i386                  randconfig-005-20260606    clang-20
i386                  randconfig-006-20260606    clang-20
i386                  randconfig-007-20260606    clang-20
i386                           randconfig-011    clang-20
i386                  randconfig-011-20260606    clang-20
i386                           randconfig-012    clang-20
i386                  randconfig-012-20260606    clang-20
i386                           randconfig-013    clang-20
i386                  randconfig-013-20260606    clang-20
i386                           randconfig-014    clang-20
i386                  randconfig-014-20260606    clang-20
i386                           randconfig-015    clang-20
i386                  randconfig-015-20260606    clang-20
i386                           randconfig-016    clang-20
i386                  randconfig-016-20260606    clang-20
i386                           randconfig-017    clang-20
i386                  randconfig-017-20260606    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260606    gcc-11.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260606    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-17
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                      malta_kvm_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-17
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260606    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260606    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-17
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-17
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260606    gcc-8.5.0
parisc                randconfig-002-20260606    gcc-8.5.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-17
powerpc               randconfig-001-20260606    gcc-8.5.0
powerpc               randconfig-002-20260606    gcc-8.5.0
powerpc64             randconfig-001-20260606    gcc-8.5.0
powerpc64             randconfig-002-20260606    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-17
riscv                            allyesconfig    clang-17
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    gcc-8.5.0
riscv                 randconfig-001-20260606    gcc-8.5.0
riscv                          randconfig-002    gcc-8.5.0
riscv                 randconfig-002-20260606    gcc-8.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-17
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    gcc-8.5.0
s390                  randconfig-001-20260606    gcc-8.5.0
s390                           randconfig-002    gcc-8.5.0
s390                  randconfig-002-20260606    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-17
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-8.5.0
sh                    randconfig-001-20260606    gcc-8.5.0
sh                             randconfig-002    gcc-8.5.0
sh                    randconfig-002-20260606    gcc-8.5.0
sparc                             allnoconfig    clang-17
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260606    gcc-11.5.0
sparc                 randconfig-002-20260606    gcc-11.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260606    gcc-11.5.0
sparc64               randconfig-002-20260606    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260606    gcc-11.5.0
um                    randconfig-002-20260606    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-17
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260606    gcc-14
x86_64      buildonly-randconfig-002-20260606    gcc-14
x86_64      buildonly-randconfig-003-20260606    gcc-14
x86_64      buildonly-randconfig-004-20260606    gcc-14
x86_64      buildonly-randconfig-005-20260606    gcc-14
x86_64      buildonly-randconfig-006-20260606    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260606    gcc-14
x86_64                randconfig-002-20260606    gcc-14
x86_64                randconfig-003-20260606    gcc-14
x86_64                randconfig-004-20260606    gcc-14
x86_64                randconfig-005-20260606    gcc-14
x86_64                randconfig-006-20260606    gcc-14
x86_64                randconfig-011-20260606    gcc-14
x86_64                randconfig-012-20260606    gcc-14
x86_64                randconfig-013-20260606    gcc-14
x86_64                randconfig-014-20260606    gcc-14
x86_64                randconfig-015-20260606    gcc-14
x86_64                randconfig-016-20260606    gcc-14
x86_64                randconfig-071-20260607    clang-22
x86_64                randconfig-072-20260607    clang-22
x86_64                randconfig-073-20260607    clang-22
x86_64                randconfig-074-20260607    clang-22
x86_64                randconfig-075-20260607    clang-22
x86_64                randconfig-076-20260607    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-17
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260606    gcc-11.5.0
xtensa                randconfig-002-20260606    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

