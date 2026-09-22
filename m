Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6158FC98302
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 19:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=u9E5x/FfD+0jEg90xYjPFkqo5uFO1/usAbSa4iwW4Ac=; b=d0hJUtgRVAYW8ienHSD9DDFb46
	K9o4Vl026ApGDTDNmMqtXCqjtgs5L5kTkcqquw5JCO8wP6YvH5s/qEduZ0WsLC+C9BzTTXiTEnJ7o
	0xuebIWEN2koY/MBHcdEh+IcVUTdtJmBxo7tbZsV5NV4da5Dj28u7IOWjCRJRvihKPKtz1nyxM0JM
	IXQVtygMRgIbNjLglfYMUBm9Gb1BSaPSC+65EDTm8HJZCcYY4FZuQTWfb2Pa9ahHB1JovKezbfGl7
	b69mUTIOYhIfb1B1DfdzqqbcfYQ/D74yyVN5MEv3e6aBxbsg5jPMxjXp2mlTbdgKyyCbzTI8FOGrk
	k931wq3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x968U-00000006PWr-3eY0;
	Tue, 22 Sep 2026 19:26:38 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x968T-00000006PWa-0MXy
	for kexec@bombadil.infradead.org;
	Tue, 22 Sep 2026 19:26:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=u9E5x/FfD+0jEg90xYjPFkqo5uFO1/usAbSa4iwW4Ac=; b=b4WdHqFQh0tGysYRnvGM1pFQaf
	iAxuX1EsTTnGaaU01Z+50ZCTMgHi/n9VXdGOyqHLzy3rt4XBN/RxECCB2VBD/194VRX54Fty7mSDD
	4k8/LhcfddNVko6RHR21I1T+QQFGhn2wrOclidx2c0wIFWAaUSKFTtBz55vCQUwaS738HL10kmvjO
	NxYBqOnfeMn2W0TOp1EXVeOkL75OFti/wjVEbAnf6BBz9BvinsqXox9fTJfnXCVBq1MC6O4CII0Sm
	BwvUgApx0+hWMXgtSNrVjeUYEMH5kexODj6tDmbwnnTdvtB2lQ3mIOsFEOAIS2w5Wn94sT2vzLYxs
	0MUPLBPQ==;
Received: from mgamail.intel.com ([192.198.163.15])
	by casper.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x968P-0000000A9No-1Fhe
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 19:26:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790105193; x=1821641193;
  h=date:from:to:cc:subject:message-id;
  bh=vORfgnFh2aqRk1acG+SuIAxjINGWFw7GR00VU7DdgO8=;
  b=P7Pd7RlxsyOmGkmpaEQo1T0ykr3xU4FN8/L6i2tHdw4hYuRQ500qyoaS
   sRFEWY5QnRe/HMNKjTraBUBIICxy39YLA7XbzYHeoP2XcFKsrCjPZB/V4
   ahCDjUZXxpFoPbhVaooclVzPatMOGmAz/+lW3OkIVfR2A9CNhu4/mF7c6
   uOISWXb9TqDpG4gSGks8MRIp85YixPpr9kmvrtUFw3cJOLdQtlXQvtyKd
   P04ftMRnJVGW26KSIF43zTiP5mdq45CLSQnx0MpDaue5qDsNqYe0Ww/ky
   6ak1+k+TvVQsVFBDEDvwflBf0+fJ0P1yht652o/nQctLEA/cd96xL/bLX
   Q==;
X-CSE-ConnectionGUID: ijGBtn63SZq9A+58IzgR9w==
X-CSE-MsgGUID: FkkgAmvCTBCY4JSSU6qaVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90858487"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="90858487"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 12:26:04 -0700
X-CSE-ConnectionGUID: evtxYEh7Sl6KgFfz/72cNQ==
X-CSE-MsgGUID: h6k1WHY+RQOUTPH8RsUNZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="4284381"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa012.fm.intel.com with ESMTP; 22 Sep 2026 12:26:01 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x967q-00000000Fz2-2tT3;
	Tue, 22 Sep 2026 19:25:58 +0000
Date: Wed, 23 Sep 2026 03:25:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:next] BUILD SUCCESS
 db3db4c33a1cf89a201ad1a11c63f503b248ee32
Message-ID: <202609230303.Vvh4XYbK-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_202633_848338_3AB74AE8 
X-CRM114-Status: UNSURE (   3.55  )
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
branch HEAD: db3db4c33a1cf89a201ad1a11c63f503b248ee32  Merge branch 'lu-pci-preservation' into next

elapsed time: 4573m

configs tested: 288
configs skipped: 16

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2101-20260918    clang-22   cocci
arc                               allmodconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260922    gcc-8.5.0
arc                   randconfig-1001-20260922    gcc-16.1.0
arc                  randconfig-r2105-20260917    gcc-8.5.0  cocci
arc                  randconfig-r2107-20260918    clang-24   cocci
arm                                allnoconfig    clang-17
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    gcc-16.1.0
arm                        aspeed_g4_defconfig    clang-20
arm                           collie_defconfig    gcc-16.1.0
arm                                  defconfig    clang-24
arm                           moxart_defconfig    gcc-16.1.0
arm                         multi_v7_defconfig    clang-20
arm                          nhk8815_defconfig    clang-24
arm                   randconfig-1000-20260922    gcc-16.1.0
arm                   randconfig-1001-20260922    gcc-10.5.0
arm                   randconfig-1002-20260922    clang-24
arm                   randconfig-1003-20260922    gcc-8.5.0
arm                         spear3xx_defconfig    clang-20
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260922    clang-24
arm64                 randconfig-1001-20260922    gcc-11.5.0
arm64                 randconfig-1002-20260922    gcc-9.5.0
arm64                 randconfig-1003-20260922    gcc-11.5.0
arm64                randconfig-r2104-20260917    clang-24   cocci
arm64                randconfig-r2105-20260918    gcc-11.5.0 cocci
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260922    gcc-16.1.0
csky                  randconfig-1001-20260922    gcc-12.5.0
csky                 randconfig-r1300-20260922    gcc-9.5.0  sparse
hexagon                           allmodconfig    clang-24
hexagon                            allnoconfig    clang-24
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    clang-24
hexagon               randconfig-1000-20260922    clang-17
hexagon               randconfig-1001-20260922    clang-17
hexagon              randconfig-r1309-20260922    clang-24   sparse
i386                               allnoconfig    gcc-14
i386                               allnoconfig    gcc-16.1.0
i386        buildonly-randconfig-1000-20260922    clang-22
i386        buildonly-randconfig-1001-20260922    clang-22
i386        buildonly-randconfig-1002-20260922    gcc-14
i386        buildonly-randconfig-1003-20260922    gcc-14
i386        buildonly-randconfig-1004-20260922    gcc-14
i386        buildonly-randconfig-1005-20260922    gcc-12
i386                                 defconfig    clang-22
i386                  randconfig-1000-20260922    clang-22
i386                  randconfig-1001-20260922    clang-22
i386                  randconfig-1002-20260922    clang-22
i386                  randconfig-1003-20260922    gcc-14
i386                  randconfig-1004-20260922    gcc-14
i386                  randconfig-1005-20260922    gcc-14
i386                  randconfig-1006-20260922    gcc-14
i386                  randconfig-1007-20260922    clang-22
i386                  randconfig-1008-20260922    gcc-14
i386                  randconfig-1009-20260922    gcc-14
i386                  randconfig-1010-20260922    clang-22
i386                  randconfig-1011-20260922    gcc-14
i386                  randconfig-1012-20260922    gcc-13
i386                  randconfig-1013-20260922    gcc-14
i386                  randconfig-1300-20260922    clang-22   sparse
i386                  randconfig-1301-20260922    clang-22   sparse
i386                  randconfig-1302-20260922    gcc-14     sparse
i386                  randconfig-2100-20260918    clang-22   cocci
i386                  randconfig-2101-20260918    clang-22   cocci
i386                  randconfig-2102-20260918    clang-22   cocci
i386                  randconfig-2103-20260918    clang-22   cocci
i386                  randconfig-2200-20260918    clang-22   smatch
loongarch                         allmodconfig    clang-19
loongarch                          allnoconfig    clang-20
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260922    gcc-16.1.0
loongarch             randconfig-1001-20260922    clang-18
loongarch            randconfig-r2107-20260918    gcc-11.5.0 cocci
loongarch            randconfig-r2200-20260917    clang-19   smatch
loongarch            randconfig-r2201-20260917    clang-24   smatch
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                                 defconfig    gcc-16.1.0
m68k                         m5272c3_defconfig    gcc-16.1.0
m68k                        m5282evb_defconfig    gcc-16.1.0
m68k                        m5475evb_defconfig    clang-20
m68k                 randconfig-r1304-20260922    gcc-8.5.0  sparse
microblaze                        alldefconfig    clang-24
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze                           defconfig    gcc-16.1.0
microblaze           randconfig-r1306-20260922    gcc-12.5.0 sparse
microblaze           randconfig-r2100-20260918    clang-24   cocci
microblaze           randconfig-r2106-20260917    gcc-8.5.0  cocci
microblaze           randconfig-r2202-20260917    gcc-15.2.0 smatch
microblaze           randconfig-r2202-20260918    gcc-12.5.0 smatch
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                         bcm47xx_defconfig    clang-24
mips                       malta_kvm_defconfig    gcc-16.1.0
mips                         qi_lb60_defconfig    clang-24
mips                 randconfig-r1302-20260922    clang-24   sparse
mips                 randconfig-r2103-20260918    clang-24   cocci
mips                 randconfig-r2202-20260918    gcc-15.2.0 smatch
mips                    sb1250_swarm_defconfig    clang-24
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    clang-24
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    clang-24
nios2                                defconfig    gcc-11.5.0
nios2                 randconfig-1000-20260922    gcc-10.5.0
nios2                 randconfig-1001-20260922    gcc-11.5.0
nios2                randconfig-r2106-20260918    gcc-11.5.0 cocci
openrisc                          allmodconfig    gcc-16.1.0
openrisc                           allnoconfig    clang-24
openrisc                           allnoconfig    gcc-16.1.0
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2101-20260918    clang-24   cocci
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                             allnoconfig    gcc-16.1.0
parisc                            allyesconfig    gcc-16.1.0
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260922    gcc-12.5.0
parisc                randconfig-1000-20260923    clang-22
parisc                randconfig-1001-20260922    gcc-10.5.0
parisc                randconfig-1001-20260923    clang-22
parisc64                             defconfig    clang-24
parisc64                             defconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                            allnoconfig    gcc-16.1.0
powerpc                      mpc83xx_defconfig    clang-24
powerpc               randconfig-1000-20260922    gcc-11.5.0
powerpc               randconfig-1000-20260923    clang-22
powerpc               randconfig-1001-20260922    gcc-8.5.0
powerpc               randconfig-1001-20260923    clang-22
powerpc              randconfig-r2105-20260918    clang-24   cocci
powerpc              randconfig-r2107-20260917    gcc-8.5.0  cocci
powerpc                     socrates_defconfig    clang-24
powerpc                   storcenter_defconfig    clang-20
powerpc                       tqm8xx_defconfig    clang-20
powerpc64             randconfig-1000-20260922    gcc-8.5.0
powerpc64             randconfig-1000-20260923    clang-22
powerpc64             randconfig-1001-20260922    gcc-11.5.0
powerpc64             randconfig-1001-20260923    clang-22
powerpc64            randconfig-r1308-20260922    gcc-10.5.0 sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                              allnoconfig    gcc-16.1.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
riscv                 randconfig-1000-20260922    gcc-8.5.0
riscv                 randconfig-1001-20260922    gcc-13.4.0
riscv                 randconfig-2000-20260917    clang-24
riscv                 randconfig-2000-20260918    gcc-13.4.0
riscv                 randconfig-2001-20260917    clang-17
riscv                 randconfig-2001-20260918    gcc-13.4.0
riscv                randconfig-r1307-20260922    clang-17   sparse
riscv                randconfig-r2102-20260918    clang-22   cocci
s390                              allmodconfig    clang-24
s390                               allnoconfig    clang-24
s390                                 defconfig    clang-18
s390                  randconfig-1000-20260922    clang-19
s390                  randconfig-1001-20260922    clang-21
s390                  randconfig-2000-20260917    clang-17
s390                  randconfig-2000-20260918    gcc-13.4.0
s390                  randconfig-2001-20260917    clang-24
s390                  randconfig-2001-20260918    gcc-13.4.0
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                 allnoconfig    gcc-16.1.0
sh                                allyesconfig    gcc-16.1.0
sh                                   defconfig    gcc-16.1.0
sh                          ecovec24_defconfig    clang-24
sh                         edosk7760_defconfig    gcc-16.1.0
sh                           r7785rp_defconfig    clang-20
sh                    randconfig-1000-20260922    gcc-10.5.0
sh                    randconfig-1001-20260922    gcc-16.1.0
sh                    randconfig-2000-20260917    gcc-14.3.0
sh                    randconfig-2000-20260918    gcc-13.4.0
sh                    randconfig-2001-20260917    gcc-16.1.0
sh                    randconfig-2001-20260918    gcc-13.4.0
sh                   randconfig-r1301-20260922    gcc-14.3.0 sparse
sh                   randconfig-r1303-20260922    gcc-10.5.0 sparse
sh                   randconfig-r1305-20260922    gcc-16.1.0 sparse
sh                   randconfig-r2200-20260918    gcc-16.1.0 smatch
sh                            se7343_defconfig    clang-20
sparc                             alldefconfig    clang-20
sparc                              allnoconfig    clang-24
sparc                              allnoconfig    gcc-16.1.0
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260922    gcc-14.3.0
sparc                 randconfig-1001-20260922    gcc-8.5.0
sparc                 randconfig-2000-20260917    gcc-16.1.0
sparc                 randconfig-2000-20260918    gcc-14
sparc                 randconfig-2001-20260917    gcc-12.5.0
sparc                 randconfig-2001-20260918    gcc-14
sparc                randconfig-r2104-20260918    clang-24   cocci
sparc                randconfig-r2106-20260918    clang-24   cocci
sparc                randconfig-r2200-20260918    gcc-8.5.0  smatch
sparc64                           alldefconfig    gcc-16.1.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    clang-24
sparc64               randconfig-1000-20260922    gcc-15.2.0
sparc64               randconfig-1001-20260922    clang-20
sparc64               randconfig-2000-20260917    clang-20
sparc64               randconfig-2000-20260918    gcc-14
sparc64               randconfig-2001-20260917    clang-20
sparc64               randconfig-2001-20260918    gcc-14
sparc64              randconfig-r2102-20260918    clang-24   cocci
sparc64              randconfig-r2103-20260918    clang-22   cocci
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-14
um                                   defconfig    clang-24
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260922    gcc-14
um                    randconfig-1001-20260922    clang-17
um                    randconfig-2000-20260917    clang-20
um                    randconfig-2000-20260918    gcc-14
um                    randconfig-2001-20260917    clang-17
um                    randconfig-2001-20260918    gcc-14
um                   randconfig-r2104-20260918    gcc-11.5.0 cocci
um                   randconfig-r2201-20260918    gcc-14     smatch
um                            x86_64_defconfig    clang-24
x86_64                             allnoconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20260922    gcc-14
x86_64      buildonly-randconfig-1001-20260922    gcc-14
x86_64      buildonly-randconfig-1002-20260922    gcc-14
x86_64      buildonly-randconfig-1003-20260922    clang-22
x86_64      buildonly-randconfig-1004-20260922    clang-22
x86_64      buildonly-randconfig-1005-20260922    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260922    gcc-12
x86_64                randconfig-1001-20260922    clang-22
x86_64                randconfig-1002-20260922    clang-22
x86_64                randconfig-1003-20260922    clang-22
x86_64                randconfig-1004-20260922    clang-22
x86_64                randconfig-1005-20260922    gcc-14
x86_64                randconfig-1006-20260922    clang-22
x86_64                randconfig-1007-20260922    gcc-14
x86_64                randconfig-1008-20260922    clang-22
x86_64                randconfig-1009-20260922    clang-22
x86_64                randconfig-1010-20260922    gcc-14
x86_64                randconfig-1011-20260922    clang-22
x86_64                randconfig-1300-20260922    gcc-13     sparse
x86_64                randconfig-1301-20260922    gcc-13     sparse
x86_64                randconfig-1302-20260922    clang-22   sparse
x86_64                randconfig-2100-20260917    clang-22   cocci
x86_64                randconfig-2100-20260918    clang-22   cocci
x86_64                randconfig-2101-20260917    gcc-14     cocci
x86_64                randconfig-2101-20260918    clang-22   cocci
x86_64                randconfig-2102-20260917    gcc-14     cocci
x86_64                randconfig-2102-20260918    clang-22   cocci
x86_64                randconfig-2103-20260917    gcc-13     cocci
x86_64                randconfig-2103-20260918    clang-22   cocci
x86_64                randconfig-2200-20260918    gcc-14     smatch
x86_64               randconfig-r2100-20260918    clang-22   cocci
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                            rhel-9.4-ltp    clang-22
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                             allnoconfig    gcc-16.1.0
xtensa                            allyesconfig    gcc-16.1.0
xtensa                randconfig-1000-20260922    gcc-12.5.0
xtensa                randconfig-1001-20260922    gcc-10.5.0
xtensa                randconfig-2000-20260917    gcc-8.5.0
xtensa                randconfig-2000-20260918    gcc-14
xtensa                randconfig-2001-20260918    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

