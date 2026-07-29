Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EECC53200
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 23:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pQXHUGCY4ay4Y0oYL+2GoTkTRHmIQzBVtYmAxi1Y1Co=; b=cukh8T0LVWU75RS4fZjM4FmO+b
	pcw2ffhekIwywBlzTu8N7/IjEC6ZU25FgjmCBfk7vCxgx2VXW9I8pOaa/ab4UW0489radW2hCSqR/
	1V9qIsEQ2eja1kXNCHEa/21UGmUFwDReinZni7lIOKDkp1H60exuOIp3RXrZXS6JCC1SkBuAJPiI0
	pqaHfq3CMFduk63EziGZN1oZBCXLIHcY1Gji5TlhtY5XSI+EpJ2aksCPNdub1M/1CMd+2VJQktYYQ
	UdKPJ8o+b5PsNHEzkmyjxaFeQU0mnxLmNrrdXrmRhJYMFoT4jQw8UQ8OAr0/ivfNdNiVUzP95gCjX
	oOsuJR4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpDva-0000000984o-1RRZ;
	Wed, 29 Jul 2026 23:43:10 +0000
Received: from mgamail.intel.com ([198.175.65.20])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpDvY-0000000984V-18Iy
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 23:43:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785368588; x=1816904588;
  h=date:from:to:cc:subject:message-id;
  bh=l/1QGlLqkW2iTu4l5pHm39+rYaA0sr+QEVIScsV0xSM=;
  b=ca9en+FyBvGNKpLZ8bVEi3avFklIiwFCjhDPmGkEIHlPeNCWCIdi0O6j
   1L/6JimvMWfdZxAQyb9PavMO9BV28WdrmKmPiWUuI1R5VFuZDM6IbV5f0
   XYuqqwjK6hvlbh/SolIx0FKeApswsyUbK49+QzW+Rjd3eO4cjyrzxZiC/
   V8uwt6uiMa2UbFW6D6HOkDXUDa/YrybGK1Klrg3s6rVO3+AaBgl0Z2lob
   IIqWdKQwGoYktFyGytcSbvMSUtgfXlGI1cIfWAoSt+RN6WNHg5A/v7hvc
   B7Bpd/0GBq9qnwlKqyE41tSq/5KvU4OW/8BvgumV69v+7rRdi/KVRXcZ2
   A==;
X-CSE-ConnectionGUID: klfuinlPSH+P5QOxOq+/Ww==
X-CSE-MsgGUID: 5f2mhjJ8RAqPTkSUv57beA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85747734"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="85747734"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 16:43:08 -0700
X-CSE-ConnectionGUID: xr88nyDKQo2YFcT5b2G49w==
X-CSE-MsgGUID: RsEpyzfEQnOsG0+MtQbD3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="283485399"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 29 Jul 2026 16:43:05 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wpDvT-00000000fk6-1jHK;
	Wed, 29 Jul 2026 23:43:03 +0000
Date: Thu, 30 Jul 2026 07:42:42 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:next] BUILD SUCCESS
 5d2f217b8c3cd1edb89b75f835ed41ae3bf8cb37
Message-ID: <202607300726.GIyYva1U-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_164308_379996_24F24B3A 
X-CRM114-Status: UNSURE (   4.55  )
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
branch HEAD: 5d2f217b8c3cd1edb89b75f835ed41ae3bf8cb37  Merge branch 'kho-scratch' into next

elapsed time: 909m

configs tested: 171
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260729    gcc-8.5.0
arc                  randconfig-002-20260729    gcc-13.4.0
arc                  randconfig-002-20260729    gcc-8.5.0
arm                  randconfig-001-20260729    gcc-10.5.0
arm                  randconfig-001-20260729    gcc-8.5.0
arm                  randconfig-002-20260729    gcc-8.5.0
arm                  randconfig-003-20260729    clang-24
arm                  randconfig-003-20260729    gcc-8.5.0
arm                  randconfig-004-20260729    clang-18
arm                  randconfig-004-20260729    gcc-8.5.0
arm64                randconfig-001-20260729    clang-17
arm64                randconfig-001-20260729    gcc-15.2.0
arm64                randconfig-002-20260729    clang-17
arm64                randconfig-002-20260729    gcc-13.4.0
arm64                randconfig-003-20260729    clang-17
arm64                randconfig-003-20260729    gcc-11.5.0
arm64                randconfig-004-20260729    clang-17
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260729    clang-17
csky                 randconfig-001-20260729    gcc-16.1.0
csky                 randconfig-002-20260729    clang-17
csky                 randconfig-002-20260729    gcc-16.1.0
hexagon                       randconfig-001    gcc-9.5.0
hexagon              randconfig-001-20260729    clang-21
hexagon              randconfig-001-20260729    gcc-9.5.0
hexagon              randconfig-002-20260729    clang-17
hexagon              randconfig-002-20260729    gcc-9.5.0
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    gcc-14
i386       buildonly-randconfig-001-20260729    gcc-14
i386       buildonly-randconfig-002-20260729    clang-22
i386       buildonly-randconfig-002-20260729    gcc-14
i386       buildonly-randconfig-003-20260729    gcc-14
i386       buildonly-randconfig-004-20260729    clang-22
i386       buildonly-randconfig-004-20260729    gcc-14
i386       buildonly-randconfig-005-20260729    clang-22
i386       buildonly-randconfig-005-20260729    gcc-14
i386       buildonly-randconfig-006-20260729    gcc-14
i386                 randconfig-001-20260729    clang-22
i386                 randconfig-001-20260729    gcc-14
i386                 randconfig-002-20260729    clang-22
i386                 randconfig-003-20260729    clang-22
i386                 randconfig-004-20260729    clang-22
i386                 randconfig-005-20260729    clang-22
i386                 randconfig-006-20260729    clang-22
i386                 randconfig-006-20260729    gcc-14
i386                 randconfig-007-20260729    clang-22
i386                          randconfig-011    gcc-14
i386                 randconfig-011-20260729    clang-22
i386                 randconfig-011-20260729    gcc-14
i386                 randconfig-012-20260729    clang-22
i386                 randconfig-012-20260729    gcc-14
i386                 randconfig-013-20260729    clang-22
i386                 randconfig-013-20260729    gcc-14
i386                 randconfig-014-20260729    gcc-14
i386                 randconfig-015-20260729    clang-22
i386                 randconfig-015-20260729    gcc-14
i386                 randconfig-016-20260729    gcc-14
i386                 randconfig-017-20260729    clang-22
i386                 randconfig-017-20260729    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260729    clang-19
loongarch            randconfig-001-20260729    gcc-9.5.0
loongarch            randconfig-002-20260729    gcc-13.4.0
loongarch            randconfig-002-20260729    gcc-9.5.0
mips                       bcm63xx_defconfig    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260729    gcc-11.5.0
nios2                randconfig-001-20260729    gcc-9.5.0
nios2                randconfig-002-20260729    gcc-9.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260729    clang-24
parisc               randconfig-001-20260730    gcc-14.3.0
parisc               randconfig-002-20260729    clang-24
parisc               randconfig-002-20260730    gcc-14.3.0
powerpc                mpc836x_rdk_defconfig    clang-24
powerpc                 mpc866_ads_defconfig    clang-17
powerpc              randconfig-001-20260729    clang-24
powerpc              randconfig-001-20260730    gcc-14.3.0
powerpc              randconfig-002-20260729    clang-24
powerpc              randconfig-002-20260730    gcc-14.3.0
powerpc64            randconfig-001-20260729    clang-24
powerpc64            randconfig-001-20260730    gcc-14.3.0
powerpc64            randconfig-002-20260729    clang-24
powerpc64            randconfig-002-20260730    gcc-14.3.0
riscv                         randconfig-001    gcc-13.4.0
riscv                randconfig-001-20260729    gcc-15.2.0
riscv                randconfig-001-20260729    gcc-8.5.0
riscv                randconfig-002-20260729    gcc-15.2.0
riscv                randconfig-002-20260729    gcc-9.5.0
s390                 randconfig-001-20260729    clang-17
s390                 randconfig-001-20260729    gcc-15.2.0
s390                 randconfig-002-20260729    clang-24
s390                 randconfig-002-20260729    gcc-15.2.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260729    gcc-13.4.0
sh                   randconfig-001-20260729    gcc-15.2.0
sh                   randconfig-002-20260729    gcc-15.2.0
sparc                randconfig-001-20260729    gcc-10.5.0
sparc                randconfig-001-20260729    gcc-8.5.0
sparc                randconfig-002-20260729    gcc-10.5.0
sparc                randconfig-002-20260729    gcc-16.1.0
sparc64              randconfig-001-20260729    gcc-10.5.0
sparc64              randconfig-001-20260729    gcc-12.5.0
sparc64              randconfig-002-20260729    clang-21
sparc64              randconfig-002-20260729    gcc-10.5.0
um                   randconfig-001-20260729    gcc-10.5.0
um                   randconfig-001-20260729    gcc-14
um                   randconfig-002-20260729    gcc-10.5.0
um                   randconfig-002-20260729    gcc-14
x86_64     buildonly-randconfig-001-20260729    clang-22
x86_64     buildonly-randconfig-001-20260729    gcc-14
x86_64     buildonly-randconfig-001-20260730    gcc-14
x86_64     buildonly-randconfig-002-20260729    clang-22
x86_64     buildonly-randconfig-002-20260729    gcc-14
x86_64     buildonly-randconfig-002-20260730    gcc-14
x86_64     buildonly-randconfig-003-20260729    clang-22
x86_64     buildonly-randconfig-003-20260730    gcc-14
x86_64     buildonly-randconfig-004-20260729    clang-22
x86_64     buildonly-randconfig-004-20260729    gcc-14
x86_64     buildonly-randconfig-004-20260730    gcc-14
x86_64     buildonly-randconfig-005-20260729    clang-22
x86_64     buildonly-randconfig-005-20260730    gcc-14
x86_64     buildonly-randconfig-006-20260729    clang-22
x86_64     buildonly-randconfig-006-20260729    gcc-12
x86_64     buildonly-randconfig-006-20260730    gcc-14
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    clang-22
x86_64               randconfig-001-20260729    clang-22
x86_64               randconfig-002-20260729    clang-22
x86_64               randconfig-002-20260729    gcc-13
x86_64               randconfig-003-20260729    clang-22
x86_64               randconfig-004-20260729    clang-22
x86_64               randconfig-005-20260729    clang-22
x86_64               randconfig-006-20260729    clang-22
x86_64               randconfig-006-20260729    gcc-14
x86_64                        randconfig-011    gcc-14
x86_64               randconfig-011-20260729    gcc-14
x86_64               randconfig-011-20260730    clang-22
x86_64               randconfig-012-20260729    gcc-14
x86_64               randconfig-012-20260730    clang-22
x86_64               randconfig-013-20260729    gcc-14
x86_64               randconfig-013-20260730    clang-22
x86_64               randconfig-014-20260729    gcc-14
x86_64               randconfig-014-20260730    clang-22
x86_64               randconfig-015-20260729    gcc-14
x86_64               randconfig-015-20260730    clang-22
x86_64               randconfig-016-20260729    gcc-14
x86_64               randconfig-016-20260730    clang-22
x86_64               randconfig-071-20260729    clang-22
x86_64               randconfig-071-20260729    gcc-12
x86_64               randconfig-072-20260729    gcc-12
x86_64               randconfig-073-20260729    gcc-12
x86_64               randconfig-074-20260729    clang-22
x86_64               randconfig-074-20260729    gcc-12
x86_64               randconfig-075-20260729    gcc-12
x86_64               randconfig-075-20260729    gcc-14
x86_64               randconfig-076-20260729    gcc-12
x86_64               randconfig-076-20260729    gcc-14
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260729    gcc-10.5.0
xtensa               randconfig-001-20260729    gcc-12.5.0
xtensa               randconfig-002-20260729    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

