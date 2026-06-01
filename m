Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD1ECD5BD1
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 21:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CmjSJpDRXTi9tO/e49T/yyPpf13Lz/Cf1kZ8WkKTQb0=; b=W+mEa1gX84bJ16GI4RbXlVCBlR
	cDkpwJ+e8I+vZEhh/mkqrtO7BMcr0fcsClzQuMCYhXvs9hcVEpKVziptAumm6UFYontDzrHxbKt+V
	8B26q0a4cVwlKyJi0ryrpKUytQbIvudITGnTQtAko8iAMfsfvY5rQ3vnZrtojxn2yiy+TpvZYiE74
	KFyCozSyOfL0Ons50Ts5Vg8LbEXpHWhgL6xz3+2OQ4zOfRyxSuPhayTMgNSo8S0ClFGybVkXm1i4b
	oOfPH3K4nR8P5ZU7cCY1FDJiO/u03WbYDz6n3Tm7nazUIY62OQKwJWL+OAdPZyBVz8MUCEgt8lcI9
	OvczV+8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU9uB-0000000BqmG-1zwi;
	Mon, 01 Jun 2026 21:10:39 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU9u8-0000000Bqlv-3H5y
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 21:10:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780348237; x=1811884237;
  h=date:from:to:cc:subject:message-id;
  bh=1TCpKz00zuS3htNuYVqwAbfPfc7VppQEaNFo31REqUY=;
  b=TtheEDv/m29LFKn9AlXuyOeoIMRyJC/VYMhJnS6R3YlhcWnmEXvJnWAt
   eqlE6U/ER17/PfRJdf8k11R7tXmLsC+xv/djT4jredEScYiDOcGlHpRd1
   yyHiVaPwUaaKUs2360ffxizx3fx/84OyCXYvkWCF7jsmePaf5YDAti7vV
   LvlrNfEtw7/6ONc4/C4jUZj+2spLGLTaKKKAKfnqgPP8yZjqLuLnJFlcY
   +3LEEH/02rtY43krOYN9Uivhf/u7H5mPaOhT6VfFaB9eDxdMYO6/F21lv
   CldFbNcS7Ka0CQfNGIFcBIiQfqJ+X0RscC2G60htIzdkUNHm2/xEj2rjy
   g==;
X-CSE-ConnectionGUID: 1IF3l6Q+SDa9ev6rCkhSWg==
X-CSE-MsgGUID: F41wPaZgQF2blI4W26Hlag==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="98536147"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="98536147"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 14:10:37 -0700
X-CSE-ConnectionGUID: dqxKuwRvQqajJpIOyBj/eQ==
X-CSE-MsgGUID: UPw5hOIyQLGvi3bv7myyLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="248613869"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 01 Jun 2026 14:10:34 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wU9u3-00000000B5e-3sYs;
	Mon, 01 Jun 2026 21:10:31 +0000
Date: Tue, 02 Jun 2026 05:10:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:next] BUILD SUCCESS
 2935777b418d2bfcbfe96705bb2c0fa6c0d94e18
Message-ID: <202606020552.pcMaifmj-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_141036_924586_F82C1E42 
X-CRM114-Status: UNSURE (   4.41  )
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
branch HEAD: 2935777b418d2bfcbfe96705bb2c0fa6c0d94e18  liveupdate: Remove unused ser field from struct luo_session

elapsed time: 859m

configs tested: 360
configs skipped: 5

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
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260601    clang-23
arc                   randconfig-001-20260601    gcc-8.5.0
arc                   randconfig-001-20260602    gcc-10.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260601    clang-23
arc                   randconfig-002-20260601    gcc-8.5.0
arc                   randconfig-002-20260602    gcc-10.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                           h3600_defconfig    gcc-15.2.0
arm                        mvebu_v7_defconfig    clang-23
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260601    clang-23
arm                   randconfig-001-20260601    gcc-8.5.0
arm                   randconfig-001-20260602    gcc-10.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260601    clang-23
arm                   randconfig-002-20260601    gcc-8.5.0
arm                   randconfig-002-20260602    gcc-10.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260601    clang-23
arm                   randconfig-003-20260601    gcc-8.5.0
arm                   randconfig-003-20260602    gcc-10.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260601    clang-23
arm                   randconfig-004-20260601    gcc-8.5.0
arm                   randconfig-004-20260602    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    gcc-8.5.0
arm64                 randconfig-001-20260601    gcc-14.3.0
arm64                 randconfig-001-20260601    gcc-8.5.0
arm64                 randconfig-001-20260602    gcc-15.2.0
arm64                          randconfig-002    gcc-14.3.0
arm64                 randconfig-002-20260601    gcc-8.5.0
arm64                 randconfig-002-20260602    gcc-15.2.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260601    gcc-15.2.0
arm64                 randconfig-003-20260601    gcc-8.5.0
arm64                 randconfig-003-20260602    gcc-15.2.0
arm64                 randconfig-004-20260601    gcc-14.3.0
arm64                 randconfig-004-20260601    gcc-8.5.0
arm64                 randconfig-004-20260602    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    gcc-10.5.0
csky                  randconfig-001-20260601    gcc-14.3.0
csky                  randconfig-001-20260601    gcc-8.5.0
csky                  randconfig-001-20260602    gcc-15.2.0
csky                           randconfig-002    gcc-10.5.0
csky                  randconfig-002-20260601    gcc-16.1.0
csky                  randconfig-002-20260601    gcc-8.5.0
csky                  randconfig-002-20260602    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260601    gcc-11.5.0
hexagon               randconfig-001-20260601    gcc-8.5.0
hexagon               randconfig-001-20260602    gcc-8.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260601    gcc-11.5.0
hexagon               randconfig-002-20260601    gcc-8.5.0
hexagon               randconfig-002-20260602    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-12
i386        buildonly-randconfig-001-20260601    gcc-12
i386        buildonly-randconfig-001-20260601    gcc-14
i386        buildonly-randconfig-001-20260602    clang-20
i386                 buildonly-randconfig-002    gcc-12
i386        buildonly-randconfig-002-20260601    clang-20
i386        buildonly-randconfig-002-20260601    gcc-12
i386        buildonly-randconfig-002-20260602    clang-20
i386                 buildonly-randconfig-003    gcc-12
i386        buildonly-randconfig-003-20260601    gcc-12
i386        buildonly-randconfig-003-20260601    gcc-14
i386        buildonly-randconfig-003-20260602    clang-20
i386                 buildonly-randconfig-004    gcc-12
i386        buildonly-randconfig-004-20260601    clang-20
i386        buildonly-randconfig-004-20260601    gcc-12
i386        buildonly-randconfig-004-20260602    clang-20
i386                 buildonly-randconfig-005    gcc-12
i386        buildonly-randconfig-005-20260601    gcc-12
i386        buildonly-randconfig-005-20260601    gcc-14
i386        buildonly-randconfig-005-20260602    clang-20
i386                 buildonly-randconfig-006    gcc-12
i386        buildonly-randconfig-006-20260601    gcc-12
i386        buildonly-randconfig-006-20260602    clang-20
i386                                defconfig    gcc-15.2.0
i386                           randconfig-001    gcc-14
i386                  randconfig-001-20260601    gcc-14
i386                  randconfig-001-20260602    gcc-14
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260601    gcc-14
i386                  randconfig-002-20260602    gcc-14
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260601    gcc-14
i386                  randconfig-003-20260602    gcc-14
i386                           randconfig-004    gcc-14
i386                  randconfig-004-20260601    gcc-14
i386                  randconfig-004-20260602    gcc-14
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260601    gcc-14
i386                  randconfig-005-20260602    gcc-14
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260601    gcc-14
i386                  randconfig-006-20260602    gcc-14
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260601    gcc-14
i386                  randconfig-007-20260602    gcc-14
i386                  randconfig-011-20260602    clang-20
i386                  randconfig-012-20260602    clang-20
i386                  randconfig-013-20260602    clang-20
i386                  randconfig-014-20260602    clang-20
i386                  randconfig-015-20260602    clang-20
i386                  randconfig-016-20260602    clang-20
i386                  randconfig-017-20260602    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260601    gcc-11.5.0
loongarch             randconfig-001-20260601    gcc-8.5.0
loongarch             randconfig-001-20260602    gcc-8.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260601    gcc-11.5.0
loongarch             randconfig-002-20260601    gcc-8.5.0
loongarch             randconfig-002-20260602    gcc-8.5.0
m68k                             alldefconfig    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           gcw0_defconfig    clang-23
mips                           rs90_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260601    gcc-11.5.0
nios2                 randconfig-001-20260601    gcc-8.5.0
nios2                 randconfig-001-20260602    gcc-8.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260601    gcc-11.5.0
nios2                 randconfig-002-20260601    gcc-8.5.0
nios2                 randconfig-002-20260602    gcc-8.5.0
openrisc                         allmodconfig    clang-23
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
parisc                         randconfig-001    gcc-10.5.0
parisc                randconfig-001-20260601    gcc-10.5.0
parisc                randconfig-001-20260602    gcc-12.5.0
parisc                         randconfig-002    gcc-10.5.0
parisc                randconfig-002-20260601    gcc-10.5.0
parisc                randconfig-002-20260602    gcc-12.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      arches_defconfig    gcc-15.2.0
powerpc                        randconfig-001    gcc-10.5.0
powerpc               randconfig-001-20260601    gcc-10.5.0
powerpc               randconfig-001-20260602    gcc-12.5.0
powerpc                        randconfig-002    gcc-10.5.0
powerpc               randconfig-002-20260601    gcc-10.5.0
powerpc               randconfig-002-20260602    gcc-12.5.0
powerpc                     tqm8560_defconfig    gcc-15.2.0
powerpc64                      randconfig-001    gcc-10.5.0
powerpc64             randconfig-001-20260601    gcc-10.5.0
powerpc64             randconfig-001-20260602    gcc-12.5.0
powerpc64                      randconfig-002    gcc-10.5.0
powerpc64             randconfig-002-20260601    gcc-10.5.0
powerpc64             randconfig-002-20260602    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                          randconfig-001    clang-23
riscv                 randconfig-001-20260601    clang-23
riscv                 randconfig-001-20260602    gcc-8.5.0
riscv                          randconfig-002    clang-23
riscv                 randconfig-002-20260601    clang-23
riscv                 randconfig-002-20260602    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                           randconfig-001    clang-23
s390                  randconfig-001-20260601    clang-23
s390                  randconfig-001-20260602    gcc-8.5.0
s390                           randconfig-002    clang-23
s390                  randconfig-002-20260601    clang-23
s390                  randconfig-002-20260602    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                             randconfig-001    clang-23
sh                    randconfig-001-20260601    clang-23
sh                    randconfig-001-20260602    gcc-8.5.0
sh                             randconfig-002    clang-23
sh                    randconfig-002-20260601    clang-23
sh                    randconfig-002-20260602    gcc-8.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-8.5.0
sparc                 randconfig-001-20260601    gcc-15.2.0
sparc                 randconfig-001-20260601    gcc-8.5.0
sparc                          randconfig-002    gcc-8.5.0
sparc                 randconfig-002-20260601    gcc-15.2.0
sparc                 randconfig-002-20260601    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-8.5.0
sparc64               randconfig-001-20260601    clang-20
sparc64               randconfig-001-20260601    gcc-15.2.0
sparc64               randconfig-001-20260601    gcc-8.5.0
sparc64                        randconfig-002    gcc-8.5.0
sparc64               randconfig-002-20260601    clang-23
sparc64               randconfig-002-20260601    gcc-15.2.0
sparc64               randconfig-002-20260601    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-8.5.0
um                    randconfig-001-20260601    gcc-14
um                    randconfig-001-20260601    gcc-15.2.0
um                    randconfig-001-20260601    gcc-8.5.0
um                             randconfig-002    gcc-8.5.0
um                    randconfig-002-20260601    gcc-14
um                    randconfig-002-20260601    gcc-15.2.0
um                    randconfig-002-20260601    gcc-8.5.0
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260601    clang-20
x86_64      buildonly-randconfig-001-20260602    gcc-14
x86_64      buildonly-randconfig-002-20260601    clang-20
x86_64      buildonly-randconfig-002-20260602    gcc-14
x86_64      buildonly-randconfig-003-20260601    clang-20
x86_64      buildonly-randconfig-003-20260602    gcc-14
x86_64      buildonly-randconfig-004-20260601    clang-20
x86_64      buildonly-randconfig-004-20260602    gcc-14
x86_64      buildonly-randconfig-005-20260601    clang-20
x86_64      buildonly-randconfig-005-20260602    gcc-14
x86_64      buildonly-randconfig-006-20260601    clang-20
x86_64      buildonly-randconfig-006-20260602    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260601    clang-20
x86_64                randconfig-001-20260601    gcc-14
x86_64                randconfig-002-20260601    clang-20
x86_64                randconfig-002-20260601    gcc-14
x86_64                randconfig-003-20260601    clang-20
x86_64                randconfig-004-20260601    clang-20
x86_64                randconfig-005-20260601    clang-20
x86_64                randconfig-006-20260601    clang-20
x86_64                randconfig-011-20260601    clang-20
x86_64                randconfig-011-20260602    clang-20
x86_64                randconfig-012-20260601    clang-20
x86_64                randconfig-012-20260602    clang-20
x86_64                randconfig-013-20260601    clang-20
x86_64                randconfig-013-20260602    clang-20
x86_64                randconfig-014-20260601    clang-20
x86_64                randconfig-014-20260602    clang-20
x86_64                randconfig-015-20260601    clang-20
x86_64                randconfig-015-20260602    clang-20
x86_64                randconfig-016-20260601    clang-20
x86_64                randconfig-016-20260602    clang-20
x86_64                         randconfig-071    gcc-14
x86_64                randconfig-071-20260601    gcc-14
x86_64                randconfig-071-20260602    clang-20
x86_64                         randconfig-072    gcc-14
x86_64                randconfig-072-20260601    gcc-14
x86_64                randconfig-072-20260602    clang-20
x86_64                         randconfig-073    gcc-14
x86_64                randconfig-073-20260601    gcc-14
x86_64                randconfig-073-20260602    clang-20
x86_64                         randconfig-074    gcc-14
x86_64                randconfig-074-20260601    gcc-14
x86_64                randconfig-074-20260602    clang-20
x86_64                         randconfig-075    gcc-14
x86_64                randconfig-075-20260601    gcc-14
x86_64                randconfig-075-20260602    clang-20
x86_64                         randconfig-076    gcc-14
x86_64                randconfig-076-20260601    gcc-14
x86_64                randconfig-076-20260602    clang-20
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
xtensa                           allyesconfig    gcc-15.2.0
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260601    gcc-15.2.0
xtensa                randconfig-001-20260601    gcc-8.5.0
xtensa                         randconfig-002    gcc-8.5.0
xtensa                randconfig-002-20260601    gcc-15.2.0
xtensa                randconfig-002-20260601    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

