Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25607CD5BAC
	for <kexec@archiver.kernel.org>; Fri, 22 May 2026 08:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GmYPlFWr8AJ81K7xFw6f3Je9Jx32q3RRVdFVhHE3Hh8=; b=jRi4UJQYqeBvWfS457NWUExeFZ
	mkmDgsIBS1GblFYxjEiKOa1Jfvnme309zRNMNA+9lFyX0KCePsfmPifbiNNMZocmRrwtlFvRRn9jN
	XTzvH9Psh0yT2q6Ix4ckAkdtF2xxKvF3ECV5HE9Chmfgwdp3S+2ERzmS5zlMFifslOtgx9SweuLq6
	NQ2wHwXGeoKOfNrSBZ80YDM/97j2nkyIZRFs6K4BJI60bXMjGEFs2PS4+cdBwormD+mSN8NGfzRj/
	xKz6EDLEge8HA0I4ZRH5vKPp2Kt4r6nVF3rQ5sApN9cC05/d8PF3CpXz9HpOD5XDRu6eZ6zomdDr4
	297Gr0gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQLae-0000000AEvG-03qb;
	Fri, 22 May 2026 08:50:44 +0000
Received: from mgamail.intel.com ([192.198.163.12])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQLab-0000000AEug-073F
	for kexec@lists.infradead.org;
	Fri, 22 May 2026 08:50:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779439841; x=1810975841;
  h=date:from:to:cc:subject:message-id;
  bh=wDZjrMbiyzKoEPtb4YFnfd/RoL6Qb0yAi3tH0GJLhJI=;
  b=K8dbkH8k7nxiV65WMzNGKrKuPhb0p+xFRf0aEVHq0g04RAtkQn8y4Tcz
   dQgRuaI8iyIGiCbHSn6UKmWhUBDhmM8EE54xrSRY3YIynINXlN5lafEBW
   bMA+Uz1F127Cg1MO0y98ZgCDfVM8Y2rira6oW9WfCnMU41TlnYALkFPao
   +0q6UuUlSvm23smMYFa1fkzWg8KXgb0hfwNmaBNIeeXLvRPyWfM162QUk
   nHiX5olxlN3txKX/8av5TQlLuxCGc5aXtLYXvoGIBXWC4MeV2YlyqSH+/
   E4Y15EfYMWD+A6bO2Bx7YC7xXQujA9fNPPEIJDKB0MXC4T6hHd7D5eVDD
   Q==;
X-CSE-ConnectionGUID: +JvYCPB0TL602lgvu9ydhQ==
X-CSE-MsgGUID: NmMsSzfZSIaOUFdaBDCSLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="84223284"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="84223284"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 01:50:40 -0700
X-CSE-ConnectionGUID: lhlpGyARQDimqSRlj7wj8w==
X-CSE-MsgGUID: pbp8TNvcTPy4RazIPG3HRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="264391533"
Received: from lkp-server01.sh.intel.com (HELO fdb68b0ce653) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 22 May 2026 01:50:38 -0700
Received: from kbuild by fdb68b0ce653 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wQLaW-00000000249-05gp;
	Fri, 22 May 2026 08:50:36 +0000
Date: Fri, 22 May 2026 16:50:10 +0800
From: kernel test robot <lkp@intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:fixes] BUILD SUCCESS
 4129715f7ac5b71183350f1983023caf0464cb9b
Message-ID: <202605221601.ltZeGYwq-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_015041_084155_A5CD982A 
X-CRM114-Status: UNSURE (   4.04  )
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
branch HEAD: 4129715f7ac5b71183350f1983023caf0464cb9b  kho: make sure scratch size is always aligned by CMA_MIN_ALIGNMENT_BYTES

elapsed time: 827m

configs tested: 154
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260522    gcc-9.5.0
arc                   randconfig-002-20260522    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260522    gcc-8.5.0
arm                   randconfig-002-20260522    gcc-10.5.0
arm                   randconfig-003-20260522    gcc-11.5.0
arm                   randconfig-004-20260522    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260522    clang-20
arm64                 randconfig-002-20260522    gcc-14.3.0
arm64                 randconfig-003-20260522    clang-23
arm64                 randconfig-004-20260522    gcc-10.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260522    gcc-15.2.0
csky                  randconfig-002-20260522    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260522    clang-23
hexagon               randconfig-002-20260522    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260522    clang-20
i386        buildonly-randconfig-002-20260522    gcc-14
i386        buildonly-randconfig-003-20260522    clang-20
i386        buildonly-randconfig-004-20260522    gcc-14
i386        buildonly-randconfig-005-20260522    clang-20
i386        buildonly-randconfig-006-20260522    gcc-13
i386                                defconfig    clang-20
i386                  randconfig-001-20260522    gcc-14
i386                  randconfig-002-20260522    clang-20
i386                  randconfig-003-20260522    gcc-13
i386                  randconfig-004-20260522    gcc-14
i386                  randconfig-005-20260522    gcc-14
i386                  randconfig-006-20260522    clang-20
i386                  randconfig-007-20260522    gcc-13
i386                  randconfig-011-20260522    gcc-14
i386                  randconfig-012-20260522    clang-20
i386                  randconfig-013-20260522    clang-20
i386                  randconfig-014-20260522    gcc-14
i386                  randconfig-015-20260522    clang-20
i386                  randconfig-016-20260522    clang-20
i386                  randconfig-017-20260522    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260522    clang-23
loongarch             randconfig-002-20260522    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
m68k                            q40_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260522    gcc-8.5.0
nios2                 randconfig-002-20260522    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260522    gcc-14.3.0
parisc                randconfig-002-20260522    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260522    clang-20
powerpc               randconfig-002-20260522    clang-18
powerpc64             randconfig-001-20260522    gcc-10.5.0
powerpc64             randconfig-002-20260522    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260522    clang-17
riscv                 randconfig-002-20260522    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260522    clang-23
s390                  randconfig-002-20260522    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260522    gcc-10.5.0
sh                    randconfig-002-20260522    gcc-14.3.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260522    gcc-15.2.0
sparc                 randconfig-002-20260522    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260522    gcc-14.3.0
sparc64               randconfig-002-20260522    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260522    clang-23
um                    randconfig-002-20260522    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260522    clang-20
x86_64      buildonly-randconfig-002-20260522    gcc-13
x86_64      buildonly-randconfig-003-20260522    gcc-14
x86_64      buildonly-randconfig-004-20260522    clang-20
x86_64      buildonly-randconfig-005-20260522    clang-20
x86_64      buildonly-randconfig-006-20260522    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260522    clang-20
x86_64                randconfig-002-20260522    clang-20
x86_64                randconfig-003-20260522    gcc-14
x86_64                randconfig-004-20260522    gcc-14
x86_64                randconfig-005-20260522    gcc-14
x86_64                randconfig-006-20260522    gcc-14
x86_64                randconfig-071-20260522    gcc-14
x86_64                randconfig-072-20260522    gcc-14
x86_64                randconfig-073-20260522    clang-20
x86_64                randconfig-074-20260522    gcc-14
x86_64                randconfig-075-20260522    clang-20
x86_64                randconfig-076-20260522    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260522    gcc-9.5.0
xtensa                randconfig-002-20260522    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

