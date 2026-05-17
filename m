Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AB5CD4F3D
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 22:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=B3KsEYmpdpKp1JuKJy6QidsL90ei8SSM5YsYxv2FeKU=; b=2SylSxgJ69XI/zTYrwf1CeXg+i
	GttiL6UUMPDqAZuk8vXUt/UnBXsuEJsNCWo2E8RbOrkmBY5mRK5+ZLhna3k9We+mdOe/Vjdu0lbUg
	8bS2qbgnoUPaDrko2ogdRCMmFIIpiglDF6YwDEg2oomO5iHDHUu29TXSXcwoUlEXnak7e7yi/haxq
	H5sHbzgu463MuzBnbFhVseLz07tkeFL/BIFs18OrKK2TxCHzKb9kvwG3Yy5W7t6v5LYPagS7yy9w4
	qHYVKwTjGLNJlD1HjtmfGRg2fXUHaIEbBgbtUxgCvTa1LBWwkCYRm90naBUH6vbfbUNRMHQ6wBOh8
	RmiCzV7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOjyp-0000000DaTo-2zqm;
	Sun, 17 May 2026 22:29:03 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOjyn-0000000DaTC-0A83
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 22:29:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779056941; x=1810592941;
  h=date:from:to:cc:subject:message-id;
  bh=f+ap5zlcKQ44JpNQal9Rs6reFbgPG9QRjrhgopVYaI4=;
  b=UkRW6OWzTAtUHmSHL54gPzncarD0lqu8Ci+bkvQahuyEUgby2uAbj0BB
   gdbbLwYubnJwEB5YCNTkx65gEtSLbLpUa3hhF99m9AclyKSAcjTG/z8m4
   rGscxynZPLKMKhFou4cV6jbIJiWLi2Y8qXbeHxfN+HEx2tbTWMPAI/5kl
   9nncxc+OIOrMxqVzD1HdHULT9qSIOmMSl8TCIhlJsJUDeKniDms2Kh5lp
   z2BRRdSrAgCRjeKIGzAkgMxR5U18dnyZwgR5JCSTB6nrO9wSUoM89qKT0
   97xSOSB1U6n+mHYHHU1XNXd8QHs8OTSmzCpZg1VslJ7MI3ovuSyMB5EuA
   g==;
X-CSE-ConnectionGUID: Et90+3+aREubckoiPwXGZg==
X-CSE-MsgGUID: iD9+toqtT+ed49d1v8x4MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="102586088"
X-IronPort-AV: E=Sophos;i="6.23,240,1770624000"; 
   d="scan'208";a="102586088"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 15:29:00 -0700
X-CSE-ConnectionGUID: XiPrwJq7RiO3RBev53L/uA==
X-CSE-MsgGUID: mBhcKEohSR+/ampMyvG7pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,240,1770624000"; 
   d="scan'208";a="234794665"
Received: from lkp-server01.sh.intel.com (HELO d94e5e629b2d) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 17 May 2026 15:28:58 -0700
Received: from kbuild by d94e5e629b2d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wOjyh-000000001zu-1KhY;
	Sun, 17 May 2026 22:28:55 +0000
Date: Mon, 18 May 2026 06:28:09 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:fixes] BUILD SUCCESS
 b1378127003b61930ce30064328640503ad3ef6d
Message-ID: <202605180658.Z1cvyCQu-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260517_152901_178853_0FA2D803 
X-CRM114-Status: UNSURE (   4.03  )
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
branch HEAD: b1378127003b61930ce30064328640503ad3ef6d  kho: docs: fix typo in ABI documentation

elapsed time: 805m

configs tested: 374
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
arc                   randconfig-001-20260517    gcc-13.4.0
arc                   randconfig-001-20260517    gcc-8.5.0
arc                   randconfig-001-20260518    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260517    gcc-13.4.0
arc                   randconfig-002-20260517    gcc-8.5.0
arc                   randconfig-002-20260518    gcc-8.5.0
arm                              alldefconfig    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                           h3600_defconfig    gcc-15.2.0
arm                        neponset_defconfig    gcc-15.2.0
arm                         nhk8815_defconfig    clang-23
arm                             pxa_defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260517    gcc-13.4.0
arm                   randconfig-001-20260517    gcc-8.5.0
arm                   randconfig-001-20260518    gcc-8.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260517    gcc-13.4.0
arm                   randconfig-002-20260517    gcc-8.5.0
arm                   randconfig-002-20260518    gcc-8.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260517    gcc-13.4.0
arm                   randconfig-003-20260517    gcc-8.5.0
arm                   randconfig-003-20260518    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260517    gcc-13.4.0
arm                   randconfig-004-20260517    gcc-8.5.0
arm                   randconfig-004-20260518    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260517    clang-23
arm64                 randconfig-001-20260518    gcc-15.2.0
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260517    clang-23
arm64                 randconfig-002-20260518    gcc-15.2.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260517    clang-23
arm64                 randconfig-003-20260518    gcc-15.2.0
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260517    clang-23
arm64                 randconfig-004-20260518    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260517    clang-23
csky                  randconfig-001-20260518    gcc-15.2.0
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260517    clang-23
csky                  randconfig-002-20260518    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260517    gcc-11.5.0
hexagon               randconfig-001-20260517    gcc-9.5.0
hexagon               randconfig-001-20260518    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260517    gcc-11.5.0
hexagon               randconfig-002-20260517    gcc-9.5.0
hexagon               randconfig-002-20260518    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260517    gcc-14
i386        buildonly-randconfig-001-20260518    clang-20
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260517    gcc-14
i386        buildonly-randconfig-002-20260518    clang-20
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260517    gcc-14
i386        buildonly-randconfig-003-20260518    clang-20
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260517    gcc-14
i386        buildonly-randconfig-004-20260518    clang-20
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260517    gcc-14
i386        buildonly-randconfig-005-20260518    clang-20
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260517    gcc-14
i386        buildonly-randconfig-006-20260518    clang-20
i386                                defconfig    gcc-15.2.0
i386                           randconfig-001    gcc-14
i386                  randconfig-001-20260517    gcc-14
i386                  randconfig-001-20260518    gcc-14
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260517    gcc-14
i386                  randconfig-002-20260518    gcc-14
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260517    gcc-14
i386                  randconfig-003-20260518    gcc-14
i386                           randconfig-004    gcc-14
i386                  randconfig-004-20260517    gcc-14
i386                  randconfig-004-20260518    gcc-14
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260517    gcc-14
i386                  randconfig-005-20260518    gcc-14
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260517    gcc-14
i386                  randconfig-006-20260518    gcc-14
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260517    gcc-14
i386                  randconfig-007-20260518    gcc-14
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260517    gcc-14
i386                  randconfig-011-20260518    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260517    gcc-14
i386                  randconfig-012-20260518    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260517    gcc-14
i386                  randconfig-013-20260518    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260517    gcc-14
i386                  randconfig-014-20260518    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260517    gcc-14
i386                  randconfig-015-20260518    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260517    gcc-14
i386                  randconfig-016-20260518    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260517    gcc-14
i386                  randconfig-017-20260518    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260517    gcc-11.5.0
loongarch             randconfig-001-20260517    gcc-9.5.0
loongarch             randconfig-001-20260518    gcc-11.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260517    gcc-11.5.0
loongarch             randconfig-002-20260517    gcc-9.5.0
loongarch             randconfig-002-20260518    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                       m5275evb_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260517    gcc-11.5.0
nios2                 randconfig-001-20260517    gcc-9.5.0
nios2                 randconfig-001-20260518    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260517    gcc-11.5.0
nios2                 randconfig-002-20260517    gcc-9.5.0
nios2                 randconfig-002-20260518    gcc-11.5.0
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
parisc                randconfig-001-20260517    gcc-10.5.0
parisc                randconfig-001-20260518    clang-23
parisc                         randconfig-002    gcc-10.5.0
parisc                randconfig-002-20260517    gcc-10.5.0
parisc                randconfig-002-20260518    clang-23
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                     powernv_defconfig    gcc-15.2.0
powerpc                        randconfig-001    gcc-10.5.0
powerpc               randconfig-001-20260517    gcc-10.5.0
powerpc               randconfig-001-20260518    clang-23
powerpc                        randconfig-002    gcc-10.5.0
powerpc               randconfig-002-20260517    gcc-10.5.0
powerpc               randconfig-002-20260518    clang-23
powerpc64                      randconfig-001    gcc-10.5.0
powerpc64             randconfig-001-20260517    gcc-10.5.0
powerpc64             randconfig-001-20260518    clang-23
powerpc64                      randconfig-002    gcc-10.5.0
powerpc64             randconfig-002-20260517    gcc-10.5.0
powerpc64             randconfig-002-20260518    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                          randconfig-001    gcc-10.5.0
riscv                 randconfig-001-20260517    gcc-10.5.0
riscv                 randconfig-001-20260518    gcc-11.5.0
riscv                          randconfig-002    gcc-10.5.0
riscv                 randconfig-002-20260517    gcc-10.5.0
riscv                 randconfig-002-20260518    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                           randconfig-001    gcc-10.5.0
s390                  randconfig-001-20260517    gcc-10.5.0
s390                  randconfig-001-20260518    gcc-11.5.0
s390                           randconfig-002    gcc-10.5.0
s390                  randconfig-002-20260517    gcc-10.5.0
s390                  randconfig-002-20260518    gcc-11.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                          landisk_defconfig    gcc-15.2.0
sh                             randconfig-001    gcc-10.5.0
sh                    randconfig-001-20260517    gcc-10.5.0
sh                    randconfig-001-20260518    gcc-11.5.0
sh                             randconfig-002    gcc-10.5.0
sh                    randconfig-002-20260517    gcc-10.5.0
sh                    randconfig-002-20260518    gcc-11.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-8.5.0
sparc                 randconfig-001-20260517    gcc-8.5.0
sparc                 randconfig-001-20260518    gcc-15.2.0
sparc                          randconfig-002    gcc-8.5.0
sparc                 randconfig-002-20260517    gcc-8.5.0
sparc                 randconfig-002-20260518    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-8.5.0
sparc64               randconfig-001-20260517    gcc-8.5.0
sparc64               randconfig-001-20260518    gcc-15.2.0
sparc64                        randconfig-002    gcc-8.5.0
sparc64               randconfig-002-20260517    gcc-8.5.0
sparc64               randconfig-002-20260518    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-8.5.0
um                    randconfig-001-20260517    gcc-8.5.0
um                    randconfig-001-20260518    gcc-15.2.0
um                             randconfig-002    gcc-8.5.0
um                    randconfig-002-20260517    gcc-8.5.0
um                    randconfig-002-20260518    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260517    gcc-14
x86_64      buildonly-randconfig-001-20260518    gcc-14
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260517    gcc-14
x86_64      buildonly-randconfig-002-20260518    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260517    gcc-14
x86_64      buildonly-randconfig-003-20260518    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260517    gcc-14
x86_64      buildonly-randconfig-004-20260518    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260517    gcc-14
x86_64      buildonly-randconfig-005-20260518    gcc-14
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260517    gcc-14
x86_64      buildonly-randconfig-006-20260518    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                         randconfig-001    clang-20
x86_64                randconfig-001-20260517    clang-20
x86_64                         randconfig-002    clang-20
x86_64                randconfig-002-20260517    clang-20
x86_64                         randconfig-003    clang-20
x86_64                randconfig-003-20260517    clang-20
x86_64                         randconfig-004    clang-20
x86_64                randconfig-004-20260517    clang-20
x86_64                         randconfig-005    clang-20
x86_64                randconfig-005-20260517    clang-20
x86_64                         randconfig-006    clang-20
x86_64                randconfig-006-20260517    clang-20
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260517    gcc-14
x86_64                randconfig-011-20260518    gcc-14
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260517    gcc-14
x86_64                randconfig-012-20260518    gcc-14
x86_64                         randconfig-013    gcc-14
x86_64                randconfig-013-20260517    gcc-14
x86_64                randconfig-013-20260518    gcc-14
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260517    gcc-14
x86_64                randconfig-014-20260518    gcc-14
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260517    gcc-14
x86_64                randconfig-015-20260518    gcc-14
x86_64                         randconfig-016    gcc-14
x86_64                randconfig-016-20260517    gcc-14
x86_64                randconfig-016-20260518    gcc-14
x86_64                         randconfig-071    clang-20
x86_64                randconfig-071-20260517    clang-20
x86_64                randconfig-071-20260518    clang-20
x86_64                         randconfig-072    clang-20
x86_64                randconfig-072-20260517    clang-20
x86_64                randconfig-072-20260518    clang-20
x86_64                         randconfig-073    clang-20
x86_64                randconfig-073-20260517    clang-20
x86_64                randconfig-073-20260518    clang-20
x86_64                         randconfig-074    clang-20
x86_64                randconfig-074-20260517    clang-20
x86_64                randconfig-074-20260518    clang-20
x86_64                         randconfig-075    clang-20
x86_64                randconfig-075-20260517    clang-20
x86_64                randconfig-075-20260518    clang-20
x86_64                         randconfig-076    clang-20
x86_64                randconfig-076-20260517    clang-20
x86_64                randconfig-076-20260518    clang-20
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
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260517    gcc-8.5.0
xtensa                randconfig-001-20260518    gcc-15.2.0
xtensa                         randconfig-002    gcc-8.5.0
xtensa                randconfig-002-20260517    gcc-8.5.0
xtensa                randconfig-002-20260518    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

