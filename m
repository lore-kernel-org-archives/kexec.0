Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91078CCA463
	for <kexec@archiver.kernel.org>; Sat, 17 Oct 2026 05:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xddC7oUbNRA3PllEzG6EhQxxQn1gnm/InMEfJPDz+LY=; b=NZdrUc3x0K9GMfnfUIloBCV6eE
	wg252G/WGKaWiDPREoGse2HVdhC4DQcJqhg/h55ITN0P3EQCbRvY0nVcqOhHqbc4bmfJdZNLWmme+
	cJAZ37ItZ92ofYavxhaG/IqI69QSGSyCt4+IYEa1QjFIvNRBLuBEhrPGOxihyE+izxQiMKdHXsQYc
	8Yx7kfBURG19/59mjcjNaXu81C/++IQPRNcYCdysgTR1rz5igNEn/0pGoxHfS+scK4vhkYQkvwPLh
	i4VttJCwJS6mnY15BqQuqLeMS/FNAWtAhDAtLIVUrvAFpwGDaWFWl8f4VsXzRGen5J3nJlasbbnZV
	RxXxje7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHwl8-00000004RJ2-4B9H;
	Sat, 17 Oct 2026 05:15:06 +0000
Received: from mgamail.intel.com ([198.175.65.14])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHwl1-00000004RHR-0RuG
	for kexec@lists.infradead.org;
	Sat, 17 Oct 2026 05:15:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792214099; x=1823750099;
  h=date:from:to:cc:subject:message-id;
  bh=EzVFRDPsgIz3AHpRdS1Vb8iBFMmIiZO3lCNxFTmuAew=;
  b=H/REcr0iWLXqSwWyhzwZgmo9Ia4f7QBsg8tamuIzUcmk+DZlGr19PP4X
   3nCnkIqDXtnshyanedG6RAPsSiQd30w5aPVrZ7rFKvbPEQQ9ZFzMCy3a2
   33nD4rW4Arw3gr8hjbLsCIFzKM1gEYo1RuqKTDpA3UD6j/eSAV8awxbbv
   J/enXDPpxlrHNeLj74xhgYe1uEVNetRjUm3Rxneyu1H6czM868RJD+U1O
   mkvOTw6Rw22QKQFnOD8qeuw3+YHdUCOgaRfTkBi33PQF2hks+7lP9N3g9
   mPYydMZQou5V3D/IJgcZR0SUz29C18jVLNPtbUQ7N8npfAjvv2PN8mtzI
   w==;
X-CSE-ConnectionGUID: nwTCO3MITV+BauGGFhidHg==
X-CSE-MsgGUID: 0VomKh+jTyCi2vr9a9bIPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="859100"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="859100"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 22:14:56 -0700
X-CSE-ConnectionGUID: uBnsQjOQTNGUEpQkIOyrxg==
X-CSE-MsgGUID: RvUBsZHwSjGnqsAddZla6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2456909"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 16 Oct 2026 22:14:54 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHwkt-00000000J6Q-2CKP;
	Sat, 17 Oct 2026 05:14:51 +0000
Date: Sat, 17 Oct 2026 13:13:53 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:next] BUILD SUCCESS
 27be83a12b246b6b3783e7d3ac5c378ff7520f25
Message-ID: <202610171350.g88pOxbm-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_221459_216925_E0691345 
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git next
branch HEAD: 27be83a12b246b6b3783e7d3ac5c378ff7520f25  Merge branch 'lu-pci-preservation' into next

elapsed time: 943m

configs tested: 280
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261017    gcc-10.5.0
arc                   randconfig-1001-20261017    gcc-10.5.0
arc                   randconfig-2000-20261015    gcc-15.2.0
arc                   randconfig-2000-20261015    gcc-9.5.0
arc                   randconfig-2001-20261015    gcc-15.2.0
arc                  randconfig-r2104-20261015    gcc-15.2.0 cocci
arc                  randconfig-r2106-20261015    gcc-15.2.0 cocci
arc                  randconfig-r2306-20261015    gcc-8.5.0  sparse
arc                  randconfig-r2309-20261015    gcc-8.5.0  sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                   randconfig-1000-20261017    gcc-10.5.0
arm                   randconfig-1001-20261017    gcc-10.5.0
arm                   randconfig-1002-20261017    gcc-10.5.0
arm                   randconfig-1003-20261017    gcc-10.5.0
arm                   randconfig-2000-20261015    gcc-11.5.0
arm                   randconfig-2000-20261015    gcc-15.2.0
arm                   randconfig-2001-20261015    gcc-15.2.0
arm                   randconfig-2001-20261015    gcc-8.5.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261017    clang-24
arm64                 randconfig-1001-20261017    clang-24
arm64                 randconfig-1002-20261017    clang-24
arm64                 randconfig-1003-20261017    clang-24
arm64                 randconfig-2000-20261015    clang-17
arm64                 randconfig-2000-20261015    gcc-16.1.0
arm64                 randconfig-2001-20261015    clang-17
arm64                 randconfig-2001-20261015    gcc-16.1.0
arm64                randconfig-r2107-20261015    gcc-15.2.0 cocci
arm64                randconfig-r2201-20261015    clang-24   smatch
arm64                randconfig-r2307-20261015    gcc-8.5.0  sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261017    clang-24
csky                  randconfig-1001-20261017    clang-24
csky                  randconfig-2000-20261015    gcc-13.4.0
csky                  randconfig-2000-20261015    gcc-16.1.0
csky                  randconfig-2001-20261015    gcc-16.1.0
csky                 randconfig-r2109-20261015    clang-19   cocci
csky                 randconfig-r2303-20261015    clang-24   sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261017    clang-21
hexagon               randconfig-1001-20261017    clang-21
hexagon               randconfig-2000-20261015    clang-19
hexagon               randconfig-2000-20261015    gcc-16.1.0
hexagon               randconfig-2001-20261015    clang-24
hexagon               randconfig-2001-20261015    gcc-16.1.0
hexagon              randconfig-r2103-20261015    clang-19   cocci
hexagon              randconfig-r2201-20261015    clang-24   smatch
hexagon              randconfig-r2302-20261015    clang-24   sparse
i386                               allnoconfig    gcc-16.1.0
i386        buildonly-randconfig-1000-20261017    gcc-14
i386        buildonly-randconfig-1001-20261017    gcc-14
i386        buildonly-randconfig-1002-20261017    gcc-14
i386        buildonly-randconfig-1003-20261017    gcc-14
i386        buildonly-randconfig-1004-20261017    gcc-14
i386        buildonly-randconfig-1005-20261017    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1007-20261017    clang-22
i386                  randconfig-1008-20261017    clang-22
i386                  randconfig-1009-20261017    clang-22
i386                  randconfig-1010-20261017    clang-22
i386                  randconfig-1011-20261017    clang-22
i386                  randconfig-1012-20261017    clang-22
i386                  randconfig-1013-20261017    clang-22
i386                  randconfig-2000-20261015    clang-22
i386                  randconfig-2000-20261015    gcc-15.2.0
i386                  randconfig-2001-20261015    clang-22
i386                  randconfig-2001-20261015    gcc-15.2.0
i386                  randconfig-2100-20261015    gcc-14     cocci
i386                  randconfig-2101-20261015    gcc-14     cocci
i386                  randconfig-2102-20261015    gcc-14     cocci
i386                  randconfig-2103-20261015    gcc-12     cocci
i386                  randconfig-2103-20261015    gcc-14     cocci
i386                  randconfig-2104-20261015    gcc-14     cocci
i386                  randconfig-2105-20261015    gcc-14     cocci
i386                  randconfig-2200-20261015    clang-22   smatch
i386                  randconfig-2300-20261015    gcc-14     sparse
i386                  randconfig-2301-20261015    gcc-14     sparse
i386                  randconfig-2302-20261015    gcc-14     sparse
i386                 randconfig-r2101-20261015    clang-22   cocci
i386                 randconfig-r2102-20261015    clang-19   cocci
i386                 randconfig-r2103-20261015    clang-22   cocci
i386                 randconfig-r2202-20261015    clang-22   smatch
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261017    clang-21
loongarch             randconfig-1001-20261017    clang-21
loongarch             randconfig-2000-20261015    clang-24
loongarch             randconfig-2000-20261015    gcc-8.5.0
loongarch             randconfig-2001-20261015    gcc-16.1.0
loongarch             randconfig-2001-20261015    gcc-8.5.0
loongarch            randconfig-r2107-20261015    clang-24   cocci
loongarch            randconfig-r2108-20261015    clang-19   cocci
loongarch            randconfig-r2311-20261015    gcc-8.5.0  sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                 randconfig-r2100-20261015    clang-19   cocci
m68k                 randconfig-r2200-20261015    gcc-8.5.0  smatch
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2105-20261015    gcc-11.5.0 cocci
microblaze           randconfig-r2108-20261015    gcc-8.5.0  cocci
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                 randconfig-r2111-20261015    gcc-15.2.0 cocci
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261017    clang-21
nios2                 randconfig-1001-20261017    clang-21
nios2                 randconfig-2000-20261015    gcc-8.5.0
nios2                 randconfig-2001-20261015    gcc-8.5.0
nios2                randconfig-r2105-20261015    gcc-15.2.0 cocci
nios2                randconfig-r2111-20261015    gcc-11.5.0 cocci
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2300-20261015    clang-24   sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261017    gcc-15.2.0
parisc                randconfig-1001-20261017    gcc-15.2.0
parisc                randconfig-2000-20261015    gcc-11.5.0
parisc                randconfig-2000-20261015    gcc-8.5.0
parisc                randconfig-2001-20261015    gcc-8.5.0
parisc               randconfig-r2106-20261015    gcc-8.5.0  cocci
parisc               randconfig-r2304-20261015    clang-24   sparse
parisc               randconfig-r2310-20261015    gcc-8.5.0  sparse
parisc64                             defconfig    clang-24
powerpc                            allnoconfig    clang-24
powerpc               randconfig-1000-20261017    gcc-15.2.0
powerpc               randconfig-1001-20261017    gcc-15.2.0
powerpc               randconfig-2000-20261015    clang-22
powerpc               randconfig-2000-20261015    clang-24
powerpc               randconfig-2001-20261015    clang-22
powerpc               randconfig-2001-20261015    gcc-10.5.0
powerpc64             randconfig-1000-20261017    gcc-15.2.0
powerpc64             randconfig-1001-20261017    gcc-15.2.0
powerpc64             randconfig-2000-20261015    clang-19
powerpc64             randconfig-2000-20261015    clang-22
powerpc64             randconfig-2001-20261015    clang-22
powerpc64             randconfig-2001-20261015    gcc-8.5.0
powerpc64            randconfig-r2109-20261015    clang-24   cocci
powerpc64            randconfig-r2305-20261015    clang-24   sparse
powerpc64            randconfig-r2307-20261015    gcc-8.5.0  sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261017    clang-19
riscv                 randconfig-1001-20261017    clang-19
riscv                 randconfig-2000-20261015    gcc-9.5.0
riscv                 randconfig-2001-20261015    gcc-9.5.0
riscv                randconfig-r2200-20261015    clang-17   smatch
riscv                randconfig-r2301-20261015    clang-24   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261017    clang-19
s390                  randconfig-1001-20261017    clang-19
s390                  randconfig-2000-20261015    gcc-9.5.0
s390                  randconfig-2001-20261015    gcc-9.5.0
s390                 randconfig-r2202-20261015    gcc-9.5.0  smatch
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261017    clang-19
sh                    randconfig-1001-20261017    clang-19
sh                    randconfig-2000-20261015    gcc-9.5.0
sh                    randconfig-2001-20261015    gcc-9.5.0
sh                   randconfig-r2110-20261015    gcc-16.1.0 cocci
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261017    gcc-15.2.0
sparc                 randconfig-1001-20261017    gcc-15.2.0
sparc                 randconfig-2000-20261015    gcc-13.4.0
sparc                 randconfig-2000-20261015    gcc-15.2.0
sparc                 randconfig-2001-20261015    gcc-15.2.0
sparc                randconfig-r2100-20261015    gcc-8.5.0  cocci
sparc                randconfig-r2309-20261015    gcc-13.4.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261017    gcc-15.2.0
sparc64               randconfig-1001-20261017    gcc-15.2.0
sparc64               randconfig-2000-20261015    clang-20
sparc64               randconfig-2000-20261015    gcc-15.2.0
sparc64               randconfig-2001-20261015    gcc-15.2.0
sparc64               randconfig-2001-20261015    gcc-8.5.0
sparc64              randconfig-r2101-20261015    clang-19   cocci
sparc64              randconfig-r2104-20261015    clang-20   cocci
sparc64              randconfig-r2110-20261015    gcc-15.2.0 cocci
sparc64              randconfig-r2310-20261015    clang-24   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261017    gcc-15.2.0
um                    randconfig-1001-20261017    gcc-15.2.0
um                    randconfig-2000-20261015    clang-24
um                    randconfig-2000-20261015    gcc-15.2.0
um                    randconfig-2001-20261015    gcc-14
um                    randconfig-2001-20261015    gcc-15.2.0
um                   randconfig-r2102-20261015    gcc-14     cocci
um                   randconfig-r2311-20261015    gcc-14     sparse
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20261017    gcc-14
x86_64      buildonly-randconfig-1001-20261017    gcc-14
x86_64      buildonly-randconfig-1002-20261017    gcc-14
x86_64      buildonly-randconfig-1003-20261017    gcc-14
x86_64      buildonly-randconfig-1004-20261017    gcc-14
x86_64      buildonly-randconfig-1005-20261017    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261017    gcc-14
x86_64                randconfig-1001-20261017    gcc-14
x86_64                randconfig-1002-20261017    gcc-14
x86_64                randconfig-1003-20261017    gcc-14
x86_64                randconfig-1004-20261017    gcc-14
x86_64                randconfig-1005-20261017    gcc-14
x86_64                randconfig-2000-20261015    clang-22
x86_64                randconfig-2000-20261015    gcc-14
x86_64                randconfig-2001-20261015    clang-22
x86_64                randconfig-2100-20261015    clang-22   cocci
x86_64                randconfig-2100-20261015    gcc-14     cocci
x86_64                randconfig-2101-20261015    clang-22   cocci
x86_64                randconfig-2102-20261015    clang-22   cocci
x86_64                randconfig-2103-20261015    clang-22   cocci
x86_64                randconfig-2104-20261015    clang-22   cocci
x86_64                randconfig-2104-20261015    gcc-14     cocci
x86_64                randconfig-2105-20261015    clang-22   cocci
x86_64                randconfig-2105-20261015    gcc-14     cocci
x86_64                randconfig-2200-20261015    clang-22   smatch
x86_64                randconfig-2300-20261015    gcc-14     sparse
x86_64                randconfig-2301-20261015    gcc-14     sparse
x86_64                randconfig-2302-20261015    gcc-14     sparse
x86_64               randconfig-r2306-20261015    gcc-13     sparse
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
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261017    gcc-15.2.0
xtensa                randconfig-1001-20261017    gcc-15.2.0
xtensa                randconfig-2000-20261015    gcc-11.5.0
xtensa                randconfig-2000-20261015    gcc-15.2.0
xtensa                randconfig-2001-20261015    gcc-15.2.0
xtensa                randconfig-2001-20261015    gcc-8.5.0
xtensa               randconfig-r2308-20261015    gcc-8.5.0  sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

