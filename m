Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F547CCA463
	for <kexec@archiver.kernel.org>; Sat, 17 Oct 2026 04:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=n3sUJrTcOtvEoQ2OiB7MpNhl51CmR5kmniO3+8bYE20=; b=ixQ8d/zAcod5Tf02rqMnkzkxMo
	SvyKxx2U0p8OaHj9jPABe1rFEM34PKsmoCcsUtg3SREesIaj+EuI0fKb4KVI8dX+P3fSqwRe/di2m
	wVJ1oJ7w6CYElZUfbvxfhEfUdXj7qNQQ/5ypr/5yckjyLYwyq2XrEHkepMR+LOeDUzWh56XQ+jcfq
	uWgS9Nsz+8F62by3QosrNaxkFHUkngcMXA7Z4oPQmgU90v4MMFkMdAgzk2iWMZWVOhYE+/9YaLjke
	W1Ai0rX0L2JWB6VBs0reQ9si9dxBn+OA9IrgIUc4nCOFP+5scgy3KMPlg/s2ikkmYtqRbukTFekXu
	iNTdAPrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHw6F-00000004Pp3-06s2;
	Sat, 17 Oct 2026 04:32:51 +0000
Received: from mgamail.intel.com ([198.175.65.17])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHw69-00000004PoN-46fG
	for kexec@lists.infradead.org;
	Sat, 17 Oct 2026 04:32:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792211567; x=1823747567;
  h=date:from:to:cc:subject:message-id;
  bh=SK/7b3yJNsW6FcuVqL89prjqnoMLlO+SKMRIM+R8XlM=;
  b=Jy1+PTaVU9Ixa4gQGaORlpATYV3k2j9+zmlPbMxy6oGIdcJPDmExQshr
   dJ31KHlWg6z60DoKFNmuyMOOXYqgS/SI8ybj4yietCNcAxUZO+lsutPkC
   lzcm43Q0eDdonOg0nZZj1nSP7ypBQKBQ61l4bKxJRIqMcBbrCGMFCK/Sv
   eTwoNui5qyFm1N3iC1+KvFH1WxwAXaAXlVWbyhiacrBia65QVc88D+XTn
   yQhse76k7nLvq9ceM2Mmb4QaQGdtKEbxBoeC7W99IhA/4vAaU5AHFdN1+
   UXOBWADlo1OIPJGYd/PrfwBdTSdLcIqHfER56nOUeizVQztrHmnYHJ08+
   Q==;
X-CSE-ConnectionGUID: 2IN2c118RB6acLpnP21hkw==
X-CSE-MsgGUID: rZYGY64rTJ2ABKcd9dyo6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="1004851"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="1004851"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 21:32:45 -0700
X-CSE-ConnectionGUID: 4lridWkGRMSuhnzoWKY5Og==
X-CSE-MsgGUID: yMZfWkaQTH2Pv06Pxdv1aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="1981949"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 16 Oct 2026 21:32:44 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHw64-00000000J4W-3vpv;
	Sat, 17 Oct 2026 04:32:40 +0000
Date: Sat, 17 Oct 2026 12:32:14 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:kexec-next] BUILD SUCCESS
 833d2b79ed9520e77c5d83eb11644e5239b2c5bb
Message-ID: <202610171211.VhGfnxQx-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_213246_087762_6BD1C3DB 
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git kexec-next
branch HEAD: 833d2b79ed9520e77c5d83eb11644e5239b2c5bb  Merge branch 'kexec-7.4' into kexec-next

elapsed time: 902m

configs tested: 350
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2304-20261016    gcc-11.5.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261017    gcc-10.5.0
arc                   randconfig-1001-20261017    gcc-10.5.0
arc                   randconfig-2000-20261015    gcc-15.2.0
arc                   randconfig-2000-20261016    gcc-8.5.0
arc                   randconfig-2001-20261015    gcc-15.2.0
arc                   randconfig-2001-20261016    gcc-8.5.0
arc                  randconfig-r2101-20261015    clang-18   cocci
arc                  randconfig-r2104-20261015    gcc-15.2.0 cocci
arc                  randconfig-r2106-20261015    gcc-15.2.0 cocci
arc                  randconfig-r2202-20261016    gcc-16.1.0 smatch
arc                  randconfig-r2306-20261015    gcc-8.5.0  sparse
arc                  randconfig-r2309-20261015    gcc-8.5.0  sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                       footbridge_defconfig    clang-24
arm                         multi_v5_defconfig    clang-24
arm                          nhk8815_defconfig    clang-24
arm                   randconfig-1000-20261017    gcc-10.5.0
arm                   randconfig-1001-20261017    gcc-10.5.0
arm                   randconfig-1002-20261017    gcc-10.5.0
arm                   randconfig-1003-20261017    gcc-10.5.0
arm                   randconfig-2000-20261015    gcc-15.2.0
arm                   randconfig-2000-20261016    gcc-8.5.0
arm                   randconfig-2001-20261015    gcc-15.2.0
arm                   randconfig-2001-20261016    gcc-8.5.0
arm                  randconfig-r2110-20261016    gcc-8.5.0  cocci
arm                  randconfig-r2305-20261016    gcc-11.5.0 sparse
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261017    clang-24
arm64                 randconfig-1001-20261017    clang-24
arm64                 randconfig-1002-20261017    clang-24
arm64                 randconfig-1003-20261017    clang-24
arm64                 randconfig-2000-20261015    gcc-16.1.0
arm64                 randconfig-2000-20261016    gcc-12.5.0
arm64                 randconfig-2001-20261015    gcc-16.1.0
arm64                 randconfig-2001-20261016    gcc-12.5.0
arm64                randconfig-r2107-20261015    gcc-15.2.0 cocci
arm64                randconfig-r2201-20261015    clang-24   smatch
arm64                randconfig-r2201-20261016    clang-24   smatch
arm64                randconfig-r2307-20261015    gcc-8.5.0  sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261017    clang-24
csky                  randconfig-1001-20261017    clang-24
csky                  randconfig-2000-20261015    gcc-16.1.0
csky                  randconfig-2000-20261016    gcc-12.5.0
csky                  randconfig-2001-20261015    gcc-16.1.0
csky                  randconfig-2001-20261016    gcc-12.5.0
csky                 randconfig-r2103-20261016    gcc-16.1.0 cocci
csky                 randconfig-r2108-20261016    gcc-16.1.0 cocci
csky                 randconfig-r2109-20261015    clang-19   cocci
csky                 randconfig-r2109-20261016    gcc-16.1.0 cocci
csky                 randconfig-r2303-20261015    clang-24   sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261017    clang-21
hexagon               randconfig-1001-20261017    clang-21
hexagon               randconfig-2000-20261015    gcc-16.1.0
hexagon               randconfig-2000-20261016    gcc-12.5.0
hexagon               randconfig-2001-20261015    gcc-16.1.0
hexagon               randconfig-2001-20261016    gcc-12.5.0
hexagon              randconfig-r2103-20261015    clang-19   cocci
hexagon              randconfig-r2106-20261016    gcc-8.5.0  cocci
hexagon              randconfig-r2202-20261015    clang-24   smatch
hexagon              randconfig-r2302-20261015    clang-24   sparse
hexagon              randconfig-r2305-20261015    gcc-16.1.0 sparse
hexagon              randconfig-r2306-20261015    clang-24   sparse
hexagon              randconfig-r2308-20261015    clang-24   sparse
i386                               allnoconfig    gcc-16.1.0
i386        buildonly-randconfig-1000-20261017    gcc-14
i386        buildonly-randconfig-1001-20261017    gcc-14
i386        buildonly-randconfig-1002-20261017    gcc-14
i386        buildonly-randconfig-1003-20261017    gcc-14
i386        buildonly-randconfig-1004-20261017    gcc-14
i386        buildonly-randconfig-1005-20261017    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261017    clang-22
i386                  randconfig-1001-20261017    clang-22
i386                  randconfig-1002-20261017    clang-22
i386                  randconfig-1003-20261017    clang-22
i386                  randconfig-1004-20261017    clang-22
i386                  randconfig-1005-20261017    clang-22
i386                  randconfig-1006-20261017    clang-22
i386                  randconfig-1007-20261017    clang-22
i386                  randconfig-1008-20261017    clang-22
i386                  randconfig-1009-20261017    clang-22
i386                  randconfig-1010-20261017    clang-22
i386                  randconfig-1011-20261017    clang-22
i386                  randconfig-1012-20261017    clang-22
i386                  randconfig-1013-20261017    clang-22
i386                  randconfig-2000-20261015    gcc-15.2.0
i386                  randconfig-2000-20261016    gcc-8.5.0
i386                  randconfig-2001-20261015    gcc-15.2.0
i386                  randconfig-2001-20261016    gcc-8.5.0
i386                  randconfig-2100-20261015    gcc-14     cocci
i386                  randconfig-2100-20261016    clang-22   cocci
i386                  randconfig-2101-20261015    gcc-14     cocci
i386                  randconfig-2101-20261016    clang-22   cocci
i386                  randconfig-2102-20261015    gcc-14     cocci
i386                  randconfig-2102-20261016    clang-22   cocci
i386                  randconfig-2103-20261015    gcc-14     cocci
i386                  randconfig-2103-20261016    clang-22   cocci
i386                  randconfig-2104-20261015    gcc-14     cocci
i386                  randconfig-2104-20261016    clang-22   cocci
i386                  randconfig-2105-20261015    gcc-14     cocci
i386                  randconfig-2105-20261016    clang-22   cocci
i386                  randconfig-2200-20261015    clang-22   smatch
i386                  randconfig-2200-20261016    clang-22   smatch
i386                  randconfig-2300-20261015    gcc-14     sparse
i386                  randconfig-2300-20261016    clang-22   sparse
i386                  randconfig-2301-20261015    gcc-14     sparse
i386                  randconfig-2301-20261016    clang-22   sparse
i386                  randconfig-2302-20261015    gcc-14     sparse
i386                  randconfig-2302-20261016    clang-22   sparse
i386                 randconfig-r2102-20261015    clang-19   cocci
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261017    clang-21
loongarch             randconfig-1001-20261017    clang-21
loongarch             randconfig-2000-20261015    gcc-8.5.0
loongarch             randconfig-2000-20261016    gcc-11.5.0
loongarch             randconfig-2001-20261015    gcc-8.5.0
loongarch             randconfig-2001-20261016    gcc-11.5.0
loongarch            randconfig-r2102-20261015    clang-18   cocci
loongarch            randconfig-r2108-20261015    clang-19   cocci
loongarch            randconfig-r2300-20261015    gcc-16.1.0 sparse
loongarch            randconfig-r2301-20261016    gcc-11.5.0 sparse
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
microblaze           randconfig-r2100-20261015    clang-18   cocci
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                            ip30_defconfig    clang-24
mips                 randconfig-r2111-20261015    gcc-15.2.0 cocci
mips                 randconfig-r2200-20261016    clang-24   smatch
mips                    sb1250_swarm_defconfig    clang-24
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261017    clang-21
nios2                 randconfig-1001-20261017    clang-21
nios2                 randconfig-2000-20261015    gcc-8.5.0
nios2                 randconfig-2000-20261016    gcc-11.5.0
nios2                 randconfig-2001-20261015    gcc-8.5.0
nios2                 randconfig-2001-20261016    gcc-11.5.0
nios2                randconfig-r2105-20261015    gcc-15.2.0 cocci
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2100-20261016    gcc-16.1.0 cocci
openrisc             randconfig-r2300-20261015    clang-24   sparse
openrisc             randconfig-r2301-20261015    gcc-16.1.0 sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261017    gcc-15.2.0
parisc                randconfig-1001-20261017    gcc-15.2.0
parisc                randconfig-2000-20261015    gcc-8.5.0
parisc                randconfig-2000-20261016    gcc-11.5.0
parisc                randconfig-2001-20261015    gcc-8.5.0
parisc                randconfig-2001-20261016    gcc-11.5.0
parisc               randconfig-r2202-20261016    gcc-8.5.0  smatch
parisc               randconfig-r2303-20261015    gcc-16.1.0 sparse
parisc               randconfig-r2304-20261015    clang-24   sparse
parisc               randconfig-r2310-20261015    gcc-8.5.0  sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                       chrp32_defconfig    clang-24
powerpc               randconfig-1000-20261017    gcc-15.2.0
powerpc               randconfig-1001-20261017    gcc-15.2.0
powerpc               randconfig-2000-20261015    clang-22
powerpc               randconfig-2001-20261015    clang-22
powerpc              randconfig-r2105-20261016    gcc-8.5.0  cocci
powerpc              randconfig-r2106-20261015    clang-24   cocci
powerpc              randconfig-r2108-20261015    clang-18   cocci
powerpc              randconfig-r2111-20261016    gcc-8.5.0  cocci
powerpc              randconfig-r2311-20261015    clang-24   sparse
powerpc64             randconfig-1000-20261017    gcc-15.2.0
powerpc64             randconfig-1001-20261017    gcc-15.2.0
powerpc64             randconfig-2000-20261015    clang-22
powerpc64             randconfig-2001-20261015    clang-22
powerpc64            randconfig-r2101-20261016    gcc-16.1.0 cocci
powerpc64            randconfig-r2103-20261015    clang-18   cocci
powerpc64            randconfig-r2305-20261015    clang-24   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261017    clang-19
riscv                 randconfig-1001-20261017    clang-19
riscv                 randconfig-2000-20261015    gcc-9.5.0
riscv                 randconfig-2000-20261016    gcc-16.1.0
riscv                 randconfig-2001-20261015    gcc-9.5.0
riscv                 randconfig-2001-20261016    gcc-16.1.0
riscv                randconfig-r2107-20261015    clang-24   cocci
riscv                randconfig-r2110-20261015    clang-24   cocci
riscv                randconfig-r2200-20261016    clang-24   smatch
riscv                randconfig-r2300-20261016    gcc-11.5.0 sparse
riscv                randconfig-r2301-20261015    clang-24   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261017    clang-19
s390                  randconfig-1001-20261017    clang-19
s390                  randconfig-2000-20261015    gcc-9.5.0
s390                  randconfig-2000-20261016    gcc-16.1.0
s390                  randconfig-2001-20261015    gcc-9.5.0
s390                  randconfig-2001-20261016    gcc-16.1.0
s390                 randconfig-r2105-20261015    clang-24   cocci
s390                 randconfig-r2201-20261015    gcc-8.5.0  smatch
s390                 randconfig-r2202-20261015    gcc-9.5.0  smatch
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                  kfr2r09-romimage_defconfig    clang-24
sh                    randconfig-1000-20261017    clang-19
sh                    randconfig-1001-20261017    clang-19
sh                    randconfig-2000-20261015    gcc-9.5.0
sh                    randconfig-2000-20261016    gcc-16.1.0
sh                    randconfig-2001-20261015    gcc-9.5.0
sh                    randconfig-2001-20261016    gcc-16.1.0
sh                   randconfig-r2309-20261015    clang-24   sparse
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261017    gcc-15.2.0
sparc                 randconfig-1001-20261017    gcc-15.2.0
sparc                 randconfig-2000-20261015    gcc-15.2.0
sparc                 randconfig-2000-20261016    gcc-12.5.0
sparc                 randconfig-2001-20261015    gcc-15.2.0
sparc                 randconfig-2001-20261016    gcc-12.5.0
sparc                randconfig-r2102-20261016    gcc-16.1.0 cocci
sparc                randconfig-r2104-20261015    clang-24   cocci
sparc                randconfig-r2310-20261015    clang-24   sparse
sparc                        sparc32_defconfig    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261017    gcc-15.2.0
sparc64               randconfig-1001-20261017    gcc-15.2.0
sparc64               randconfig-2000-20261015    gcc-15.2.0
sparc64               randconfig-2000-20261016    gcc-12.5.0
sparc64               randconfig-2001-20261015    gcc-15.2.0
sparc64               randconfig-2001-20261016    gcc-12.5.0
sparc64              randconfig-r2101-20261015    clang-19   cocci
sparc64              randconfig-r2104-20261016    gcc-8.5.0  cocci
sparc64              randconfig-r2110-20261015    gcc-15.2.0 cocci
sparc64              randconfig-r2111-20261015    clang-24   cocci
sparc64              randconfig-r2201-20261016    gcc-12.5.0 smatch
sparc64              randconfig-r2302-20261015    gcc-16.1.0 sparse
sparc64              randconfig-r2307-20261015    clang-24   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261017    gcc-15.2.0
um                    randconfig-1001-20261017    gcc-15.2.0
um                    randconfig-2000-20261015    gcc-15.2.0
um                    randconfig-2000-20261016    gcc-12.5.0
um                    randconfig-2001-20261015    gcc-15.2.0
um                    randconfig-2001-20261016    gcc-12.5.0
um                   randconfig-r2107-20261016    gcc-8.5.0  cocci
um                   randconfig-r2109-20261015    clang-18   cocci
um                   randconfig-r2304-20261015    gcc-16.1.0 sparse
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
x86_64                randconfig-2001-20261015    clang-22
x86_64                randconfig-2100-20261015    clang-22   cocci
x86_64                randconfig-2100-20261016    clang-22   cocci
x86_64                randconfig-2101-20261015    clang-22   cocci
x86_64                randconfig-2101-20261016    clang-22   cocci
x86_64                randconfig-2102-20261015    clang-22   cocci
x86_64                randconfig-2102-20261016    clang-22   cocci
x86_64                randconfig-2103-20261015    clang-22   cocci
x86_64                randconfig-2103-20261016    clang-22   cocci
x86_64                randconfig-2104-20261015    clang-22   cocci
x86_64                randconfig-2104-20261016    clang-22   cocci
x86_64                randconfig-2105-20261015    clang-22   cocci
x86_64                randconfig-2105-20261016    clang-22   cocci
x86_64                randconfig-2200-20261015    clang-22   smatch
x86_64                randconfig-2200-20261016    gcc-14     smatch
x86_64                randconfig-2300-20261015    gcc-14     sparse
x86_64                randconfig-2300-20261016    clang-22   sparse
x86_64                randconfig-2301-20261015    gcc-14     sparse
x86_64                randconfig-2301-20261016    clang-22   sparse
x86_64                randconfig-2302-20261015    gcc-14     sparse
x86_64                randconfig-2302-20261016    clang-22   sparse
x86_64               randconfig-r2200-20261015    clang-22   smatch
x86_64               randconfig-r2303-20261016    gcc-11.5.0 sparse
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
xtensa                randconfig-2000-20261015    gcc-15.2.0
xtensa                randconfig-2000-20261016    gcc-12.5.0
xtensa                randconfig-2001-20261015    gcc-15.2.0
xtensa                randconfig-2001-20261016    gcc-12.5.0
xtensa               randconfig-r2302-20261016    gcc-11.5.0 sparse
xtensa               randconfig-r2308-20261015    gcc-8.5.0  sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

