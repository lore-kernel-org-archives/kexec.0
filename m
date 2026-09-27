Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E7BC9830E
	for <kexec@archiver.kernel.org>; Sun, 27 Sep 2026 08:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yg8RT/G89rinLwy5rZCMNwd56g687yCE1z/AuNoAwYI=; b=zR5EOD22MSv9xMN+DGO3k3uAIb
	/O7C7WONLGhnDuEs46B+rqzgsfrlkVSK/MyoESGUZHjM2soQ6LlTZqlSqV8hsNY7yZHC0rNSPgYpB
	lzcHTF1AXK5BQgvQo9+gADL0MoEp3UvOJkMd19cK64lObXerOSc12W4/nv1usv6EwLcpCx5fCDW+B
	2z/3suT4zVVpJ6nxYahL3f38NyPPJZGUZrRd7wy04nsDl2h8Zmv3e27NQHFYQ6Wz5gqY0fW4+lz5n
	i0qA5nieF23ENCqB9R//WblbTq779S/LviIVjq2rcLgOolBzDaEkJzaSRy1PXBDBNV+6fWMn6vt6u
	ft/Nc+rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAk70-0000000G8PD-1Ubk;
	Sun, 27 Sep 2026 08:19:54 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAk6x-0000000G8Os-3Geb
	for kexec@lists.infradead.org;
	Sun, 27 Sep 2026 08:19:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790497192; x=1822033192;
  h=date:from:to:cc:subject:message-id;
  bh=7OfX15oa3/5Suh45oY/ULo4AI88S63AJpZWeCA7o8pY=;
  b=l4Sr8iNDrD4bS1nHB5z+sz6OwbgHHFKM8WGtZeMfnHCtmTxOwCWLcI1U
   cE0H5QO3fd7PJ5HxgzY4ojoLwqUZshQL8pG2H6TM1xWMJoaGD7xaQGYDt
   uH9w66swklyWebMR2JNTiTwS6TJq0DKRNYX1owj1+dl6Q74egwTvT1PGR
   ZERf/9hGDmszXvTOoFpTVsZ8Sz5rWV3MuLSg7Nh4RPMu/0vTrECmpKbLp
   l/xWJ+8pauotDuLad/SX6mbGpMWxvqiIL5NvYiO2nh0K6MOsYEFpr6uTn
   lVsr1BKcnGcSnNW5Wxx3c2PH7lYhEUGoTXY87yZR79LTp3Wozl2HWj4/P
   w==;
X-CSE-ConnectionGUID: NuiNRrH2T3WCtgzzWzKTQQ==
X-CSE-MsgGUID: 1i7hzMbHSSul7SmzObgRAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11917"; a="107603019"
X-IronPort-AV: E=Sophos;i="6.27,126,1787036400"; 
   d="scan'208";a="107603019"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 01:19:51 -0700
X-CSE-ConnectionGUID: UOYN5M1RR4yAiPVaGQY7mw==
X-CSE-MsgGUID: hQxYJAmkR3OGyhB9DYwoRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,126,1787036400"; 
   d="scan'208";a="282832480"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 27 Sep 2026 01:19:48 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xAk6r-00000000Mh7-14Ac;
	Sun, 27 Sep 2026 08:19:45 +0000
Date: Sun, 27 Sep 2026 16:19:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:kho-bootmem] BUILD SUCCESS
 091d47139cdb3b54269083345e3f884b2c16f8dd
Message-ID: <202609271609.meAFLpGD-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260927_011951_937632_34B032D6 
X-CRM114-Status: UNSURE (   4.05  )
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git kho-bootmem
branch HEAD: 091d47139cdb3b54269083345e3f884b2c16f8dd  Merge patch series "kho: rename "scratch" to "bootmem""

elapsed time: 3844m

configs tested: 231
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260927    gcc-11.5.0
arc                   randconfig-1000-20260927    gcc-15.2.0
arc                   randconfig-1001-20260927    gcc-11.5.0
arc                   randconfig-1001-20260927    gcc-8.5.0
arc                     vdk_hs38_smp_defconfig    gcc-16.1.0
arm                                allnoconfig    clang-17
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                               allyesconfig    gcc-16.1.0
arm                          assabet_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                          nhk8815_defconfig    clang-24
arm                   randconfig-1000-20260927    gcc-10.5.0
arm                   randconfig-1000-20260927    gcc-11.5.0
arm                   randconfig-1001-20260927    gcc-11.5.0
arm                   randconfig-1002-20260927    gcc-11.5.0
arm                   randconfig-1002-20260927    gcc-13.4.0
arm                   randconfig-1003-20260927    gcc-11.5.0
arm                   randconfig-1003-20260927    gcc-15.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260927    clang-17
arm64                 randconfig-1001-20260927    clang-17
arm64                 randconfig-1002-20260927    clang-17
arm64                 randconfig-1003-20260927    clang-17
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260927    clang-17
csky                  randconfig-1001-20260927    clang-17
hexagon                           allmodconfig    clang-24
hexagon                            allnoconfig    clang-24
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260927    clang-24
hexagon               randconfig-1000-20260927    gcc-11.5.0
hexagon               randconfig-1001-20260927    clang-22
hexagon               randconfig-1001-20260927    gcc-11.5.0
i386                               allnoconfig    gcc-14
i386                               allnoconfig    gcc-16.1.0
i386        buildonly-randconfig-1000-20260927    clang-22
i386        buildonly-randconfig-1001-20260927    clang-22
i386        buildonly-randconfig-1001-20260927    gcc-14
i386        buildonly-randconfig-1002-20260927    clang-22
i386        buildonly-randconfig-1003-20260927    clang-22
i386        buildonly-randconfig-1004-20260927    clang-22
i386        buildonly-randconfig-1005-20260927    clang-22
i386        buildonly-randconfig-1005-20260927    gcc-13
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260927    clang-22
i386                  randconfig-1001-20260927    clang-22
i386                  randconfig-1002-20260927    clang-22
i386                  randconfig-1003-20260927    clang-22
i386                  randconfig-1004-20260927    clang-22
i386                  randconfig-1005-20260927    clang-22
i386                  randconfig-1006-20260927    clang-22
i386                  randconfig-1007-20260927    gcc-14
i386                  randconfig-1008-20260927    gcc-14
i386                  randconfig-1009-20260927    gcc-14
i386                  randconfig-1010-20260927    gcc-14
i386                  randconfig-1011-20260927    gcc-14
i386                  randconfig-1012-20260927    gcc-14
i386                  randconfig-1013-20260927    gcc-14
loongarch                         allmodconfig    clang-19
loongarch                          allnoconfig    clang-20
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260927    gcc-11.5.0
loongarch             randconfig-1000-20260927    gcc-16.1.0
loongarch             randconfig-1001-20260927    clang-24
loongarch             randconfig-1001-20260927    gcc-11.5.0
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                                 defconfig    gcc-16.1.0
m68k                         m5272c3_defconfig    gcc-16.1.0
m68k                            sun3_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze                           defconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                           ath79_defconfig    gcc-16.1.0
mips                         bcm63xx_defconfig    clang-24
mips                          db1xxx_defconfig    gcc-16.1.0
mips                           eyeq6_defconfig    gcc-16.1.0
mips                      eyeq6lplus_defconfig    gcc-16.1.0
nios2                             allmodconfig    clang-20
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    clang-24
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    clang-24
nios2                                defconfig    gcc-11.5.0
nios2                 randconfig-1000-20260927    gcc-11.5.0
nios2                 randconfig-1001-20260927    gcc-11.5.0
openrisc                          allmodconfig    clang-20
openrisc                          allmodconfig    gcc-16.1.0
openrisc                           allnoconfig    clang-24
openrisc                           allnoconfig    gcc-16.1.0
openrisc                             defconfig    gcc-16.1.0
openrisc                     or1ksim_defconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                             allnoconfig    gcc-16.1.0
parisc                            allyesconfig    clang-17
parisc                            allyesconfig    gcc-16.1.0
parisc                               defconfig    gcc-16.1.0
parisc                 generic-64bit_defconfig    gcc-16.1.0
parisc                randconfig-1000-20260927    clang-24
parisc                randconfig-1000-20260927    gcc-9.5.0
parisc                randconfig-1001-20260927    clang-24
parisc                randconfig-1001-20260927    gcc-11.5.0
parisc64                             defconfig    clang-24
parisc64                             defconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                            allnoconfig    gcc-16.1.0
powerpc                         cell_defconfig    gcc-16.1.0
powerpc                       pcm030_defconfig    clang-24
powerpc               randconfig-1000-20260927    clang-24
powerpc               randconfig-1001-20260927    clang-24
powerpc               randconfig-1001-20260927    gcc-16.1.0
powerpc64             randconfig-1000-20260927    clang-24
powerpc64             randconfig-1001-20260927    clang-17
powerpc64             randconfig-1001-20260927    clang-24
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                              allnoconfig    gcc-16.1.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260927    gcc-16.1.0
riscv                 randconfig-1001-20260927    gcc-16.1.0
s390                              allmodconfig    clang-17
s390                              allmodconfig    clang-24
s390                               allnoconfig    clang-24
s390                                 defconfig    clang-18
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260927    gcc-16.1.0
s390                  randconfig-1001-20260927    gcc-16.1.0
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                 allnoconfig    gcc-16.1.0
sh                                allyesconfig    clang-17
sh                                allyesconfig    gcc-16.1.0
sh                                   defconfig    gcc-14
sh                                   defconfig    gcc-16.1.0
sh                           polaris_defconfig    gcc-16.1.0
sh                    randconfig-1000-20260927    gcc-16.1.0
sh                    randconfig-1001-20260927    gcc-16.1.0
sh                             titan_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                              allnoconfig    gcc-16.1.0
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260927    clang-24
sparc                 randconfig-1000-20260927    gcc-11.5.0
sparc                 randconfig-1001-20260927    clang-24
sparc                 randconfig-1001-20260927    gcc-16.1.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    clang-24
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260927    clang-20
sparc64               randconfig-1000-20260927    clang-24
sparc64               randconfig-1001-20260927    clang-24
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-14
um                                   defconfig    clang-24
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260927    clang-24
um                    randconfig-1001-20260927    clang-24
um                    randconfig-1001-20260927    gcc-14
um                            x86_64_defconfig    clang-24
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20260927    gcc-14
x86_64      buildonly-randconfig-1001-20260927    clang-22
x86_64      buildonly-randconfig-1001-20260927    gcc-14
x86_64      buildonly-randconfig-1002-20260927    clang-22
x86_64      buildonly-randconfig-1002-20260927    gcc-14
x86_64      buildonly-randconfig-1003-20260927    gcc-14
x86_64      buildonly-randconfig-1004-20260927    gcc-14
x86_64      buildonly-randconfig-1005-20260927    gcc-13
x86_64      buildonly-randconfig-1005-20260927    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260927    clang-22
x86_64                randconfig-1001-20260927    clang-22
x86_64                randconfig-1002-20260927    clang-22
x86_64                randconfig-1003-20260927    clang-22
x86_64                randconfig-1004-20260927    clang-22
x86_64                randconfig-1005-20260927    clang-22
x86_64                randconfig-1005-20260927    gcc-14
x86_64                randconfig-1006-20260927    clang-22
x86_64                randconfig-1007-20260927    clang-22
x86_64                randconfig-1008-20260927    clang-22
x86_64                randconfig-1009-20260927    clang-22
x86_64                randconfig-1010-20260927    clang-22
x86_64                randconfig-1011-20260927    clang-22
x86_64                randconfig-1012-20260927    clang-22
x86_64                randconfig-1012-20260927    gcc-14
x86_64                randconfig-1013-20260927    clang-22
x86_64                randconfig-1014-20260927    clang-22
x86_64                randconfig-1015-20260927    clang-22
x86_64                randconfig-1015-20260927    gcc-14
x86_64                randconfig-1016-20260927    clang-22
x86_64                randconfig-1017-20260927    clang-22
x86_64                                rhel-9.4    clang-22
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                             allnoconfig    gcc-16.1.0
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20260927    clang-24
xtensa                randconfig-1000-20260927    gcc-13.4.0
xtensa                randconfig-1001-20260927    clang-24
xtensa                randconfig-1001-20260927    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

