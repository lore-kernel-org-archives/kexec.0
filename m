Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F647CD6E6B
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 07:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=28SepQle7O8hZgldH3OXg4NUtpbIb5yofovfIawvhHk=; b=sytqCNZNESy/cgSri6+7WTZocp
	/5J7VfgtimfGvX2nNgYzeitLLGcEMhHFYiC6HidnSu/TnC5dH5Kdno3Q2kowImY3Xa6t+2cRaJIKg
	6V95ri4+DaJ3qlY2aLKSS8AfSvLWQEKshCd7DY0nti4Hm9LNwjx1pvf/UyXppXLkqP5nzSMN2W/qe
	yzR+QuEbkOthgXeF6EM9r+3wT4eH7ilY/jBGUNdDnj1NPQetpr6Nsn+HPhmhHdOhVbdUo9NvPV1cg
	wghg/l3XD3RLOfiL6QBEP8WtTVHihyL6gfOligqBT8/U41U4BUeKu6nrIqzga/8oZ+g6mixhB0SRb
	z6+dpZzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVOo1-00000000Dx3-1gZn;
	Fri, 05 Jun 2026 07:17:25 +0000
Received: from mgamail.intel.com ([192.198.163.12])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVOny-00000000Dwl-3ryi
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 07:17:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780643843; x=1812179843;
  h=date:from:to:cc:subject:message-id;
  bh=rfw/aCck171KR6E/HtUbZZVrwp/Oon0a9v0zGRSsiqY=;
  b=SRxHRV0N+hfnzotPNGW1+Cpy7GuyIx6HIG0Nj/x1oq7nrkKOlgYcDdN2
   ftsQiBThJW3RylksSY+SCje7VSKlW5Bn6oBksF9H7QSi3kWG9qsYzYOfz
   NIpByH624chY2SSaZaeBI3JUL4JJXYQgUEEmHYUFQ/TonROAS2Er0gnuv
   eXHDZ+jVe6gfyfsOEl4Ih+vWpXWAuIh8zwMz8U6K3WIIXHKXIMavvUIkb
   8WlqtMA3OM8D98uX0q9ZT49DBV/oiDT7+YjEaGRtuWNjp+MM7vH9jHgxs
   O8QZ++V9+JH3S8fHxYTh66BYcbABk2tgg0vKofMy4vPaSWvRvvPTni/+/
   Q==;
X-CSE-ConnectionGUID: iHZc7qaQSkKkktJSDm41sg==
X-CSE-MsgGUID: HFFURS9ATkmgzbIbzl1Gsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85328771"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="85328771"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:17:21 -0700
X-CSE-ConnectionGUID: uiX7LQYeRzWlc8TmIwes5Q==
X-CSE-MsgGUID: DoY0wzzcR+iATnKPUq1jPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="249108724"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 05 Jun 2026 00:17:19 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wVOns-00000000Ff4-1mVx;
	Fri, 05 Jun 2026 07:17:16 +0000
Date: Fri, 05 Jun 2026 15:16:36 +0800
From: kernel test robot <lkp@intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:kexec-next] BUILD SUCCESS
 7eb5f7c5b5d58b4abe78f6a1b0817391c291f199
Message-ID: <202606051527.ebVGd2F3-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260605_001722_981219_47E54465 
X-CRM114-Status: UNSURE (   3.67  )
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
branch HEAD: 7eb5f7c5b5d58b4abe78f6a1b0817391c291f199  kexec_file: skip checksum verification when safe

elapsed time: 2068m

configs tested: 193
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-17
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260604    clang-17
arc                   randconfig-002-20260604    clang-17
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-17
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260604    clang-17
arm                   randconfig-002-20260604    clang-17
arm                   randconfig-003-20260604    clang-17
arm                   randconfig-004-20260604    clang-17
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260604    clang-17
arm64                 randconfig-002-20260604    clang-17
arm64                 randconfig-003-20260604    clang-17
arm64                 randconfig-004-20260604    clang-17
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260604    clang-17
csky                  randconfig-002-20260604    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260604    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260604    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260604    clang-20
i386        buildonly-randconfig-002-20260604    clang-20
i386        buildonly-randconfig-003-20260604    clang-20
i386        buildonly-randconfig-004-20260604    clang-20
i386        buildonly-randconfig-005-20260604    clang-20
i386        buildonly-randconfig-006-20260604    clang-20
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260604    clang-20
i386                  randconfig-002-20260604    clang-20
i386                  randconfig-003-20260604    clang-20
i386                  randconfig-004-20260604    clang-20
i386                  randconfig-005-20260604    clang-20
i386                  randconfig-006-20260604    clang-20
i386                  randconfig-007-20260604    clang-20
i386                  randconfig-011-20260604    gcc-14
i386                  randconfig-012-20260604    gcc-14
i386                  randconfig-013-20260604    gcc-14
i386                  randconfig-014-20260604    gcc-14
i386                  randconfig-015-20260604    gcc-14
i386                  randconfig-016-20260604    gcc-14
i386                  randconfig-017-20260604    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260604    gcc-11.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260604    gcc-11.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-17
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-17
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260604    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260604    gcc-11.5.0
openrisc                          allnoconfig    clang-17
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-17
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-8.5.0
parisc                randconfig-001-20260604    gcc-8.5.0
parisc                         randconfig-002    gcc-8.5.0
parisc                randconfig-002-20260604    gcc-8.5.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-17
powerpc                        randconfig-001    gcc-8.5.0
powerpc               randconfig-001-20260604    gcc-8.5.0
powerpc                        randconfig-002    gcc-8.5.0
powerpc               randconfig-002-20260604    gcc-8.5.0
powerpc64                      randconfig-001    gcc-8.5.0
powerpc64             randconfig-001-20260604    gcc-8.5.0
powerpc64                      randconfig-002    gcc-8.5.0
powerpc64             randconfig-002-20260604    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-17
riscv                            allyesconfig    clang-17
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    clang-17
riscv                 randconfig-001-20260604    clang-17
riscv                          randconfig-002    clang-17
riscv                 randconfig-002-20260604    clang-17
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-17
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    clang-17
s390                  randconfig-001-20260604    clang-17
s390                           randconfig-002    clang-17
s390                  randconfig-002-20260604    clang-17
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-17
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                             randconfig-001    clang-17
sh                    randconfig-001-20260604    clang-17
sh                             randconfig-002    clang-17
sh                    randconfig-002-20260604    clang-17
sh                          urquell_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-17
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-11.5.0
sparc                 randconfig-001-20260604    gcc-11.5.0
sparc                          randconfig-002    gcc-11.5.0
sparc                 randconfig-002-20260604    gcc-11.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-11.5.0
sparc64               randconfig-001-20260604    gcc-11.5.0
sparc64                        randconfig-002    gcc-11.5.0
sparc64               randconfig-002-20260604    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-11.5.0
um                    randconfig-001-20260604    gcc-11.5.0
um                             randconfig-002    gcc-11.5.0
um                    randconfig-002-20260604    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-17
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260604    gcc-14
x86_64      buildonly-randconfig-002-20260604    gcc-14
x86_64      buildonly-randconfig-003-20260604    gcc-14
x86_64      buildonly-randconfig-004-20260604    gcc-14
x86_64      buildonly-randconfig-005-20260604    gcc-14
x86_64      buildonly-randconfig-006-20260604    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260604    clang-20
x86_64                randconfig-002-20260604    clang-20
x86_64                randconfig-003-20260604    clang-20
x86_64                randconfig-004-20260604    clang-20
x86_64                randconfig-005-20260604    clang-20
x86_64                randconfig-006-20260604    clang-20
x86_64                randconfig-011-20260604    clang-22
x86_64                randconfig-012-20260604    clang-22
x86_64                randconfig-013-20260604    clang-22
x86_64                randconfig-014-20260604    clang-22
x86_64                randconfig-015-20260604    clang-22
x86_64                randconfig-016-20260604    clang-22
x86_64                randconfig-071-20260604    clang-22
x86_64                randconfig-072-20260604    clang-22
x86_64                randconfig-073-20260604    clang-22
x86_64                randconfig-074-20260604    clang-22
x86_64                randconfig-075-20260604    clang-22
x86_64                randconfig-076-20260604    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-17
xtensa                           allyesconfig    clang-23
xtensa                         randconfig-001    gcc-11.5.0
xtensa                randconfig-001-20260604    gcc-11.5.0
xtensa                         randconfig-002    gcc-11.5.0
xtensa                randconfig-002-20260604    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

