Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BCDC43458
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 05:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Bg4KmGCZH0579n9S1aBknVGEBXU3r1iPitU3v4VCWpg=; b=Kq/aTIrqC7r4BDW0b+hrCby3BO
	xbvtkBnBajWhnplPnT+Oxc2MwdNWXgcGZn38NrnPYku8wfbU/mcnzJhNf9zvfqO6t5DeAlvA5QDSL
	DB4tazwiKI2vjQUpXXCgYVJ35qkm5l6yICnFXgtMDg6gsbxHhAM4uBIvKqqGiaGKVYbe520AThxKX
	Pkmv8fpwafg/3W/15e2jWJxFKlOeTzLahx1WyXzvlZKUEX/UzcRABPL43KWu9efZ/MLrEwKR/1Jt8
	hCdV5qntBaByQvCcVXd6snjiQtyGzgeYHYPJ4bmTVf5qNlhadZCIJeut86S1Pz7s4N0UdOU41Vvxv
	MEBY/AgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whKvJ-0000000GMwa-1By4;
	Wed, 08 Jul 2026 05:34:17 +0000
Received: from mgamail.intel.com ([198.175.65.13])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whKvC-0000000GMw2-2sdl
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 05:34:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783488851; x=1815024851;
  h=date:from:to:cc:subject:message-id;
  bh=DJMNrTfZSq4gm74UKTsV0vk87lE829IYCOT4WmPQP5Q=;
  b=JbDWmtBY0qIzaMPymEbWUMLf5CF5pPPG8TGNzvu04ttTnc/jdiUhRxca
   PAgYmaIza1Fh2M3l4kU8WH+naUu0OuOdo/2vy1WxSmMzpzXoIFHAGvejk
   Rc0eLJJFU2hU566uQ4l2nFvu2G+gdibK1qk9Pf1m7RziyElSSkhQY6Srs
   cSaYcMbvzw3R6QR39OVPXzqkHnMQXm5huSPvY7BHC0kev+D39mkqtylgd
   bk9QqoZ/VLxEwqM8zbFQoL7etKhPAHjoYsX16ZQ7KNpaVnXauJ0U1Me1k
   +A8HAOAw8x0H8og7OLGAkEYBISLYFDKHDAauAbV3DSFmTJiGklzQDEkxr
   w==;
X-CSE-ConnectionGUID: PoOZV7o4QNKq3Q3+If0RBQ==
X-CSE-MsgGUID: MHnbfoSrQ0mIOlyg+px9tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="95299891"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="95299891"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 22:34:10 -0700
X-CSE-ConnectionGUID: nUyU3XzcQCCSCXAEFU0TZg==
X-CSE-MsgGUID: xcLyzBn/QOSjrXuReD4akg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="254265045"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 07 Jul 2026 22:34:08 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1whKv7-00000000G4B-0xB4;
	Wed, 08 Jul 2026 05:34:05 +0000
Date: Wed, 08 Jul 2026 13:33:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:kho-scratch] BUILD SUCCESS
 08412b8c707fdbccb7bf2116f0554fe09113cd53
Message-ID: <202607081338.hkmfYnLi-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260707_223410_976740_489F8BDD 
X-CRM114-Status: UNSURE (   4.84  )
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git kho-scratch
branch HEAD: 08412b8c707fdbccb7bf2116f0554fe09113cd53  x86/setup: do not include kexec_handover.h from asm/setup.h

elapsed time: 1398m

configs tested: 204
configs skipped: 3

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
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                         haps_hs_defconfig    gcc-16.1.0
arc                   randconfig-001-20260708    gcc-13.4.0
arc                   randconfig-002-20260708    gcc-13.4.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260708    gcc-13.4.0
arm                   randconfig-002-20260708    gcc-13.4.0
arm                   randconfig-003-20260708    gcc-13.4.0
arm                   randconfig-004-20260708    gcc-13.4.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260708    gcc-9.5.0
arm64                 randconfig-002-20260708    gcc-9.5.0
arm64                 randconfig-003-20260708    gcc-9.5.0
arm64                 randconfig-004-20260708    gcc-9.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260708    gcc-9.5.0
csky                  randconfig-002-20260708    gcc-9.5.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260708    gcc-13.4.0
hexagon               randconfig-002-20260708    gcc-13.4.0
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260708    clang-22
i386        buildonly-randconfig-002-20260708    clang-22
i386        buildonly-randconfig-003-20260708    clang-22
i386        buildonly-randconfig-004-20260708    clang-22
i386        buildonly-randconfig-005-20260708    clang-22
i386        buildonly-randconfig-006-20260708    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260708    clang-22
i386                  randconfig-002-20260708    clang-22
i386                  randconfig-003-20260708    clang-22
i386                  randconfig-004-20260708    clang-22
i386                  randconfig-005-20260708    clang-22
i386                  randconfig-006-20260708    clang-22
i386                  randconfig-007-20260708    clang-22
i386                  randconfig-011-20260708    gcc-14
i386                  randconfig-012-20260708    gcc-14
i386                  randconfig-013-20260708    gcc-14
i386                  randconfig-014-20260708    gcc-14
i386                  randconfig-015-20260708    gcc-14
i386                  randconfig-016-20260708    gcc-14
i386                  randconfig-017-20260708    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260708    gcc-13.4.0
loongarch             randconfig-002-20260708    gcc-13.4.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260708    gcc-13.4.0
nios2                 randconfig-002-20260708    gcc-13.4.0
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
parisc                randconfig-001-20260708    clang-22
parisc                randconfig-002-20260708    clang-22
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260708    clang-22
powerpc               randconfig-002-20260708    clang-22
powerpc64             randconfig-001-20260708    clang-22
powerpc64             randconfig-002-20260708    clang-22
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260708    clang-23
riscv                 randconfig-002-20260708    clang-23
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260708    clang-23
s390                  randconfig-002-20260708    clang-23
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260708    clang-23
sh                    randconfig-002-20260708    clang-23
sh                           se7206_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260708    gcc-8.5.0
sparc                 randconfig-002-20260708    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260708    gcc-8.5.0
sparc64               randconfig-002-20260708    gcc-8.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260708    gcc-8.5.0
um                    randconfig-002-20260708    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    gcc-12
x86_64      buildonly-randconfig-001-20260708    gcc-12
x86_64               buildonly-randconfig-002    gcc-12
x86_64      buildonly-randconfig-002-20260708    gcc-12
x86_64               buildonly-randconfig-003    gcc-12
x86_64      buildonly-randconfig-003-20260708    gcc-12
x86_64               buildonly-randconfig-004    gcc-12
x86_64      buildonly-randconfig-004-20260708    gcc-12
x86_64               buildonly-randconfig-005    gcc-12
x86_64      buildonly-randconfig-005-20260708    gcc-12
x86_64               buildonly-randconfig-006    gcc-12
x86_64      buildonly-randconfig-006-20260708    gcc-12
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260708    gcc-14
x86_64                randconfig-002-20260708    gcc-14
x86_64                randconfig-003-20260708    gcc-14
x86_64                randconfig-004-20260708    gcc-14
x86_64                randconfig-005-20260708    gcc-14
x86_64                randconfig-006-20260708    gcc-14
x86_64                randconfig-011-20260708    clang-22
x86_64                randconfig-012-20260708    clang-22
x86_64                randconfig-013-20260708    clang-22
x86_64                randconfig-014-20260708    clang-22
x86_64                randconfig-015-20260708    clang-22
x86_64                randconfig-016-20260708    clang-22
x86_64                randconfig-071-20260708    clang-22
x86_64                randconfig-072-20260708    clang-22
x86_64                randconfig-073-20260708    clang-22
x86_64                randconfig-074-20260708    clang-22
x86_64                randconfig-075-20260708    clang-22
x86_64                randconfig-076-20260708    clang-22
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
xtensa                randconfig-001-20260708    gcc-8.5.0
xtensa                randconfig-002-20260708    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

