Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD2FCA5FF0
	for <kexec@archiver.kernel.org>; Mon,  5 Oct 2026 09:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1NxQ5Xy3f00ZzZwD2ro+SgGyVTPQ37s/4oKKn94dflA=; b=EitgSVNwvC9BEaGBrUEos3YArs
	SBJClSM+onA0R+NcSK9XqPfKxu3/DQVSpkhvq1KqNDT0L30vNdWDzuUn/cf8DRW7Mi5kjpraxFCmt
	txPPM1hXT/Him/x23abKDSFPxwGy/4oaj9Cr12vzkP8uacBkH1naEj2bW3iiUMBe8g6+n02h+lj+q
	OlCnpX1/WHlr6QjhLleiybmMExkPhk+F2JxI8sragoKW77WW9RLoz+vBDl81dmHwiUU1uDB9tLbaw
	7Xl2X4XUqhOskQjbL+I0MSRamr7sP+Y5BxBUw4ZbcmvlPegKHtWF4SUE8+RhuAgBkaA9y8bunIO8F
	9O01y5OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDf8j-0000000G1G4-1Xw5;
	Mon, 05 Oct 2026 09:37:45 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDf8g-0000000G1Fj-2vu1
	for kexec@lists.infradead.org;
	Mon, 05 Oct 2026 09:37:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791193062; x=1822729062;
  h=date:from:to:cc:subject:message-id;
  bh=zfwH3cyYqlPJ9NwAD1SA+YG9qUsez1eUcWRWy/cIlrg=;
  b=btVKxYnDPnpiSgUf0EM7RPriC8/mDLQKsiyahzcalbgKBrhfXTiD5WSq
   51RU0f555NYjGl0LRayNZFCXAgGiAx7aBZ3D3kvLDNC8eHcW7vG11K32/
   lWn2LctihxNenysJ91BRkEPEBktcXrwmkcgyfuih+ebNS2sVqt4/3GgA3
   qW5yDJR+/HxaYubhtFvoJKsPk+8cAUtY0Va3GsuHDxmAIHRA0VgBKXmyy
   cw4vBD4t9IxAeknxmVJP4qicqhXvJwxckDikP1PePW/029PmeM+sdO4Pc
   qjwCZDnDpGiyoRojBr9qtOJ8yRwKYBoTY18LGDd+UPRL77bHpwNs7Z+Ev
   w==;
X-CSE-ConnectionGUID: /CVYxkv/TWmzk4yA74IPEw==
X-CSE-MsgGUID: VMyxPVTLQD2eFsaqdtvQfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="102439029"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="102439029"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 02:37:21 -0700
X-CSE-ConnectionGUID: 4benYfJuTTaPpMGaUdhEqQ==
X-CSE-MsgGUID: HSj1HbqrQNO4k5C/DSdysA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="280045824"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 05 Oct 2026 02:37:19 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xDf8G-00000000085-1rBX;
	Mon, 05 Oct 2026 09:37:16 +0000
Date: Mon, 05 Oct 2026 17:37:14 +0800
From: kernel test robot <lkp@intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:lu-pci-preservation] BUILD SUCCESS
 15f2d6b187221596f01ecd413fe14deeeedf83a4
Message-ID: <202610051710.24A0fd14-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261005_023742_805530_59E75E31 
X-CRM114-Status: UNSURE (   4.24  )
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git lu-pci-preservation
branch HEAD: 15f2d6b187221596f01ecd413fe14deeeedf83a4  Merge patch series "PCI: liveupdate: PCI core support for Live Update"

elapsed time: 957m

configs tested: 373
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             alldefconfig    gcc-16.1.0
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                         nsimosci_defconfig    gcc-16.1.0
arc                   randconfig-1000-20261005    gcc-8.5.0
arc                   randconfig-1001-20261005    gcc-8.5.0
arc                  randconfig-r2300-20261005    gcc-11.5.0 sparse
arc                  randconfig-r2301-20261004    clang-24   sparse
arc                  randconfig-r2306-20261004    gcc-12.5.0 sparse
arc                  randconfig-r2308-20261005    gcc-14.3.0 sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                          bcm2835_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                        imx_v4_v5_defconfig    gcc-16.1.0
arm                         keystone_defconfig    gcc-16.1.0
arm                         mvebu_v7_defconfig    gcc-16.1.0
arm                   randconfig-1000-20261005    gcc-8.5.0
arm                   randconfig-1001-20261005    gcc-8.5.0
arm                   randconfig-1002-20261005    gcc-8.5.0
arm                   randconfig-1003-20261005    gcc-8.5.0
arm                  randconfig-r2102-20261005    gcc-13.4.0 cocci
arm                  randconfig-r2103-20261005    clang-24   cocci
arm                  randconfig-r2201-20261005    clang-24   smatch
arm                  randconfig-r2303-20261005    gcc-11.5.0 sparse
arm                         spear6xx_defconfig    gcc-16.1.0
arm                         vexpress_defconfig    gcc-16.1.0
arm                          wpcm450_defconfig    gcc-16.1.0
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261005    gcc-16.1.0
arm64                 randconfig-1001-20261005    gcc-16.1.0
arm64                 randconfig-1002-20261005    gcc-16.1.0
arm64                 randconfig-1003-20261005    gcc-16.1.0
arm64                randconfig-r2102-20261005    clang-24   cocci
arm64                randconfig-r2104-20261005    gcc-15.2.0 cocci
arm64                randconfig-r2202-20261005    clang-24   smatch
arm64                randconfig-r2306-20261005    gcc-8.5.0  sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261005    gcc-16.1.0
csky                  randconfig-1001-20261005    gcc-16.1.0
csky                 randconfig-r2102-20261005    gcc-16.1.0 cocci
csky                 randconfig-r2201-20261005    gcc-10.5.0 smatch
csky                 randconfig-r2300-20261005    gcc-11.5.0 sparse
csky                 randconfig-r2307-20261004    clang-18   sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261005    gcc-16.1.0
hexagon               randconfig-1001-20261005    gcc-16.1.0
hexagon              randconfig-r2100-20261005    gcc-16.1.0 cocci
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261005    clang-22
i386        buildonly-randconfig-1001-20261005    clang-22
i386        buildonly-randconfig-1002-20261005    clang-22
i386        buildonly-randconfig-1003-20261005    clang-22
i386        buildonly-randconfig-1004-20261005    clang-22
i386        buildonly-randconfig-1005-20261005    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261005    clang-22
i386                  randconfig-1001-20261005    clang-22
i386                  randconfig-1002-20261005    clang-22
i386                  randconfig-1003-20261005    clang-22
i386                  randconfig-1004-20261005    clang-22
i386                  randconfig-1005-20261005    clang-22
i386                  randconfig-1006-20261005    clang-22
i386                  randconfig-1007-20261005    clang-22
i386                  randconfig-1008-20261005    clang-22
i386                  randconfig-1009-20261005    clang-22
i386                  randconfig-1010-20261005    clang-22
i386                  randconfig-1011-20261005    clang-22
i386                  randconfig-1012-20261005    clang-22
i386                  randconfig-1013-20261005    clang-22
i386                  randconfig-2100-20261004    clang-22   cocci
i386                  randconfig-2100-20261005    gcc-14     cocci
i386                  randconfig-2101-20261004    clang-22   cocci
i386                  randconfig-2101-20261005    gcc-14     cocci
i386                  randconfig-2102-20261004    clang-22   cocci
i386                  randconfig-2102-20261005    gcc-14     cocci
i386                  randconfig-2103-20261004    clang-22   cocci
i386                  randconfig-2103-20261005    gcc-14     cocci
i386                  randconfig-2200-20261005    gcc-14     smatch
i386                  randconfig-2300-20261004    clang-22   sparse
i386                  randconfig-2300-20261005    clang-22   sparse
i386                  randconfig-2301-20261004    gcc-14     sparse
i386                  randconfig-2301-20261005    clang-22   sparse
i386                  randconfig-2302-20261004    gcc-14     sparse
i386                  randconfig-2302-20261005    clang-22   sparse
i386                 randconfig-r2100-20261005    gcc-13.4.0 cocci
i386                 randconfig-r2103-20261005    gcc-16.1.0 cocci
i386                 randconfig-r2107-20261005    gcc-8.5.0  cocci
i386                 randconfig-r2200-20261005    clang-22   smatch
i386                 randconfig-r2202-20261005    clang-22   smatch
i386                 randconfig-r2304-20261005    gcc-11.5.0 sparse
i386                 randconfig-r2307-20261004    gcc-14.3.0 sparse
i386                 randconfig-r2308-20261004    gcc-14.3.0 sparse
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261005    gcc-16.1.0
loongarch             randconfig-1001-20261005    gcc-16.1.0
loongarch            randconfig-r2105-20261004    gcc-16.1.0 cocci
loongarch            randconfig-r2106-20261005    gcc-16.1.0 cocci
loongarch            randconfig-r2305-20261004    clang-24   sparse
loongarch            randconfig-r2306-20261004    gcc-14.3.0 sparse
loongarch            randconfig-r2307-20261004    clang-24   sparse
loongarch            randconfig-r2309-20261004    clang-18   sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                         mvme16x_defconfig    gcc-16.1.0
m68k                             q40_defconfig    gcc-16.1.0
m68k                 randconfig-r2102-20261004    gcc-16.1.0 cocci
m68k                 randconfig-r2102-20261005    gcc-16.1.0 cocci
m68k                 randconfig-r2105-20261005    gcc-8.5.0  cocci
m68k                 randconfig-r2106-20261005    gcc-8.5.0  cocci
m68k                 randconfig-r2300-20261004    clang-24   sparse
m68k                 randconfig-r2301-20261005    gcc-11.5.0 sparse
m68k                 randconfig-r2306-20261005    gcc-14.3.0 sparse
m68k                 randconfig-r2307-20261005    gcc-8.5.0  sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze                       mmu_defconfig    gcc-16.1.0
microblaze           randconfig-r2100-20261005    clang-24   cocci
microblaze           randconfig-r2101-20261005    clang-24   cocci
microblaze           randconfig-r2104-20261004    gcc-10.5.0 cocci
microblaze           randconfig-r2104-20261005    gcc-16.1.0 cocci
microblaze           randconfig-r2107-20261005    gcc-15.2.0 cocci
microblaze           randconfig-r2200-20261005    gcc-9.5.0  smatch
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                         maltaup_defconfig    gcc-16.1.0
mips                 randconfig-r2103-20261004    gcc-16.1.0 cocci
mips                 randconfig-r2105-20261005    gcc-16.1.0 cocci
mips                 randconfig-r2200-20261004    gcc-15.2.0 smatch
mips                 randconfig-r2303-20261005    gcc-11.5.0 sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261005    gcc-16.1.0
nios2                 randconfig-1001-20261005    gcc-16.1.0
nios2                randconfig-r2103-20261005    gcc-16.1.0 cocci
nios2                randconfig-r2104-20261005    gcc-8.5.0  cocci
nios2                randconfig-r2106-20261005    gcc-15.2.0 cocci
nios2                randconfig-r2201-20261004    gcc-11.5.0 smatch
nios2                randconfig-r2202-20261005    gcc-11.5.0 smatch
nios2                randconfig-r2302-20261005    gcc-11.5.0 sparse
nios2                randconfig-r2303-20261005    clang-24   sparse
nios2                randconfig-r2303-20261005    gcc-9.5.0  sparse
nios2                randconfig-r2309-20261004    gcc-14.3.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2104-20261004    gcc-16.1.0 cocci
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261005    gcc-8.5.0
parisc                randconfig-1001-20261005    gcc-8.5.0
parisc               randconfig-r2100-20261004    gcc-16.1.0 cocci
parisc               randconfig-r2101-20261005    gcc-16.1.0 cocci
parisc               randconfig-r2105-20261005    gcc-15.2.0 cocci
parisc               randconfig-r2106-20261004    gcc-16.1.0 cocci
parisc               randconfig-r2300-20261005    gcc-9.5.0  sparse
parisc               randconfig-r2303-20261004    clang-24   sparse
parisc               randconfig-r2308-20261004    clang-18   sparse
parisc               randconfig-r2308-20261004    gcc-8.5.0  sparse
parisc64                             defconfig    clang-24
powerpc                     adder875_defconfig    gcc-16.1.0
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                       arches_defconfig    gcc-16.1.0
powerpc                    bluestone_defconfig    gcc-16.1.0
powerpc                         cell_defconfig    gcc-16.1.0
powerpc                       katmai_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20261005    gcc-8.5.0
powerpc               randconfig-1001-20261005    gcc-8.5.0
powerpc              randconfig-r2101-20261005    gcc-16.1.0 cocci
powerpc              randconfig-r2107-20261005    gcc-16.1.0 cocci
powerpc              randconfig-r2300-20261005    clang-24   sparse
powerpc              randconfig-r2301-20261005    clang-24   sparse
powerpc              randconfig-r2302-20261005    gcc-11.5.0 sparse
powerpc              randconfig-r2308-20261005    gcc-8.5.0  sparse
powerpc                     sam440ep_defconfig    gcc-16.1.0
powerpc                      tqm8540_defconfig    gcc-16.1.0
powerpc                      tqm8555_defconfig    gcc-16.1.0
powerpc64                         alldefconfig    gcc-16.1.0
powerpc64             randconfig-1000-20261005    gcc-8.5.0
powerpc64             randconfig-1001-20261005    gcc-8.5.0
powerpc64            randconfig-r2200-20261005    gcc-12.5.0 smatch
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv              nommu_k210_sdcard_defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261005    clang-17
riscv                 randconfig-1001-20261005    clang-17
riscv                 randconfig-2000-20261004    gcc-11.5.0
riscv                 randconfig-2000-20261005    gcc-16.1.0
riscv                 randconfig-2001-20261004    gcc-11.5.0
riscv                 randconfig-2001-20261005    gcc-16.1.0
riscv                randconfig-r2100-20261005    gcc-13.4.0 cocci
riscv                randconfig-r2101-20261005    gcc-13.4.0 cocci
riscv                randconfig-r2102-20261005    gcc-13.4.0 cocci
riscv                randconfig-r2200-20261004    gcc-11.5.0 smatch
riscv                randconfig-r2202-20261004    clang-17   smatch
riscv                randconfig-r2202-20261005    clang-24   smatch
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261005    clang-17
s390                  randconfig-1001-20261005    clang-17
s390                  randconfig-2000-20261004    gcc-11.5.0
s390                  randconfig-2000-20261005    gcc-16.1.0
s390                  randconfig-2001-20261004    gcc-11.5.0
s390                  randconfig-2001-20261005    gcc-16.1.0
s390                 randconfig-r2305-20261005    clang-24   sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                         edosk7705_defconfig    gcc-16.1.0
sh                    randconfig-1000-20261005    clang-17
sh                    randconfig-1001-20261005    clang-17
sh                    randconfig-2000-20261004    gcc-11.5.0
sh                    randconfig-2000-20261005    gcc-16.1.0
sh                    randconfig-2001-20261004    gcc-11.5.0
sh                    randconfig-2001-20261005    gcc-16.1.0
sh                   randconfig-r2100-20261005    gcc-16.1.0 cocci
sh                   randconfig-r2101-20261004    gcc-16.1.0 cocci
sh                   randconfig-r2301-20261005    gcc-9.5.0  sparse
sh                   randconfig-r2302-20261005    gcc-9.5.0  sparse
sh                   randconfig-r2305-20261005    gcc-11.5.0 sparse
sh                   randconfig-r2309-20261005    gcc-8.5.0  sparse
sh                           rsk7201_defconfig    gcc-16.1.0
sh                       rts7751r2d1_defconfig    gcc-16.1.0
sh                            se7750_defconfig    gcc-16.1.0
sh                               ul2_defconfig    gcc-16.1.0
sh                           urquell_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261005    clang-24
sparc                 randconfig-1001-20261005    clang-24
sparc                 randconfig-2000-20261004    clang-17
sparc                 randconfig-2000-20261004    gcc-8.5.0
sparc                 randconfig-2000-20261005    clang-17
sparc                 randconfig-2001-20261004    clang-17
sparc                 randconfig-2001-20261004    gcc-15.2.0
sparc                 randconfig-2001-20261005    clang-17
sparc                randconfig-r2201-20261005    gcc-15.2.0 smatch
sparc                randconfig-r2301-20261005    gcc-11.5.0 sparse
sparc                randconfig-r2302-20261005    clang-24   sparse
sparc                randconfig-r2304-20261005    gcc-11.5.0 sparse
sparc                randconfig-r2309-20261005    gcc-14.3.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261005    clang-24
sparc64               randconfig-1001-20261005    clang-24
sparc64               randconfig-2000-20261004    clang-17
sparc64               randconfig-2000-20261004    clang-20
sparc64               randconfig-2000-20261005    clang-17
sparc64               randconfig-2001-20261004    clang-17
sparc64               randconfig-2001-20261004    gcc-10.5.0
sparc64               randconfig-2001-20261005    clang-17
sparc64              randconfig-r2101-20261005    gcc-13.4.0 cocci
sparc64              randconfig-r2107-20261004    gcc-10.5.0 cocci
sparc64              randconfig-r2304-20261005    clang-24   sparse
sparc64              randconfig-r2306-20261004    clang-18   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261005    clang-24
um                    randconfig-1001-20261005    clang-24
um                    randconfig-2000-20261004    clang-17
um                    randconfig-2000-20261004    gcc-14
um                    randconfig-2000-20261005    clang-17
um                    randconfig-2001-20261004    clang-17
um                    randconfig-2001-20261005    clang-17
um                   randconfig-r2105-20261004    gcc-10.5.0 cocci
um                   randconfig-r2304-20261004    clang-24   sparse
um                   randconfig-r2304-20261005    gcc-9.5.0  sparse
um                   randconfig-r2305-20261005    gcc-11.5.0 sparse
um                   randconfig-r2307-20261005    gcc-14.3.0 sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261005    gcc-13
x86_64      buildonly-randconfig-1001-20261005    gcc-13
x86_64      buildonly-randconfig-1002-20261005    gcc-13
x86_64      buildonly-randconfig-1003-20261005    gcc-13
x86_64      buildonly-randconfig-1004-20261005    gcc-13
x86_64      buildonly-randconfig-1005-20261005    gcc-13
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261005    gcc-14
x86_64                randconfig-1001-20261005    gcc-14
x86_64                randconfig-1002-20261005    gcc-14
x86_64                randconfig-1003-20261005    gcc-14
x86_64                randconfig-1004-20261005    gcc-14
x86_64                randconfig-1005-20261005    gcc-14
x86_64                randconfig-1006-20261005    gcc-14
x86_64                randconfig-1007-20261005    gcc-14
x86_64                randconfig-1008-20261005    gcc-14
x86_64                randconfig-1009-20261005    gcc-14
x86_64                randconfig-1010-20261005    gcc-14
x86_64                randconfig-1011-20261005    gcc-14
x86_64                randconfig-1012-20261005    gcc-14
x86_64                randconfig-1013-20261005    gcc-14
x86_64                randconfig-1014-20261005    gcc-14
x86_64                randconfig-1015-20261005    gcc-14
x86_64                randconfig-1016-20261005    gcc-14
x86_64                randconfig-1017-20261005    gcc-14
x86_64                randconfig-2100-20261004    gcc-14     cocci
x86_64                randconfig-2100-20261005    clang-22   cocci
x86_64                randconfig-2101-20261004    clang-22   cocci
x86_64                randconfig-2101-20261004    gcc-14     cocci
x86_64                randconfig-2101-20261005    clang-22   cocci
x86_64                randconfig-2102-20261004    gcc-14     cocci
x86_64                randconfig-2102-20261005    clang-22   cocci
x86_64                randconfig-2103-20261004    gcc-14     cocci
x86_64                randconfig-2103-20261005    clang-22   cocci
x86_64                randconfig-2200-20261004    gcc-14     smatch
x86_64                randconfig-2200-20261005    clang-22   smatch
x86_64                randconfig-2300-20261005    clang-22   sparse
x86_64                randconfig-2301-20261004    gcc-14     sparse
x86_64                randconfig-2301-20261005    clang-22   sparse
x86_64                randconfig-2302-20261004    clang-22   sparse
x86_64                randconfig-2302-20261005    clang-22   sparse
x86_64               randconfig-r2103-20261005    gcc-13.4.0 cocci
x86_64               randconfig-r2305-20261005    gcc-9.5.0  sparse
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
xtensa                randconfig-1000-20261005    clang-24
xtensa                randconfig-1001-20261005    clang-24
xtensa                randconfig-2000-20261004    clang-17
xtensa                randconfig-2000-20261004    gcc-8.5.0
xtensa                randconfig-2000-20261005    clang-17
xtensa                randconfig-2001-20261004    clang-17
xtensa                randconfig-2001-20261004    gcc-9.5.0
xtensa                randconfig-2001-20261005    clang-17
xtensa               randconfig-r2103-20261005    gcc-13.4.0 cocci
xtensa               randconfig-r2106-20261004    gcc-10.5.0 cocci
xtensa               randconfig-r2107-20261004    gcc-16.1.0 cocci
xtensa               randconfig-r2201-20261004    gcc-13.4.0 smatch
xtensa               randconfig-r2202-20261005    gcc-10.5.0 smatch
xtensa               randconfig-r2302-20261004    clang-24   sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

