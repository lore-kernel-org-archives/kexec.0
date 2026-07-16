Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56623C43458
	for <kexec@archiver.kernel.org>; Thu, 16 Jul 2026 03:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ljRDXJsdLgkjLsOMnUHpwWeDWpHCdl+rp2/JoK+eCDA=; b=BaaoMOE3iLO1I5pWvQSRLh6HFK
	WuxX+LO9XGgwsLf1AkPHreuCQ8tqCvAFVIznof7kRZcFpCpsOaGTxd3jY+1jogO45liVJnE9dj/JT
	d6XqZZsH87sO7qT4Ju58ZUOh/QSUb+JCVkRb+N+WwRcbQiLFy5f0Y4/ARdMWJEG9lwlA55lszDKG8
	pJU2XP324yjy37SdD2RRd4sPwC+idilSl9pYVzP7nu5EvVLmfGXjiFTpReitQaKgOEIlGKeBXq5ru
	ey5vxR5ehOODemQmpRlNQSjtNn+FjAiB0GqK5ObCjO9Muk2F921envh2K/e9IG1qEp4W7RcXBGv9d
	s8b5ZE2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkCpX-0000000GLuI-1ZQd;
	Thu, 16 Jul 2026 03:32:11 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkCpU-0000000GLtr-2q4o
	for kexec@lists.infradead.org;
	Thu, 16 Jul 2026 03:32:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784172728; x=1815708728;
  h=date:from:to:cc:subject:message-id;
  bh=pz9YL38gxqiM8FeoJscwdHjuhI29U3hMufwPjrhtycE=;
  b=hoEg7SznvjH+93sIWOSmEQ/YDKAnlNwVQqfrNX3FZ+HsUnPPABH4EHQ9
   4x/tGD3cjWqOgIkLYAYtqkimYIcBEXx8biwTmxwVaZNYD9HKT+RgQlsg/
   ihOfp56v8PyIOoIc1bLUd2qKkwy29K1sfvAsN9ziVGRYsrWGSoplQZtPW
   dIIFPp6//V3puOjXfZbU13OLUOP2v9lBoX7OKeteIKXRn7m6UMaZuEGfP
   hYPQOpJGJGu18g1K0Qjt6Px4uP3PTVe9ucKMEACa9ciNjXGNXBL6HvieJ
   xABKgaauOhPPJn4IUYE5Jgvdnl4Hp/J/a3Gq0plVxjMYaacPRfuPiMFxL
   A==;
X-CSE-ConnectionGUID: A/dSEY7GQ6ifw6WFamn/Ng==
X-CSE-MsgGUID: D0I910mMQ8S/0JB+0dMvng==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="83807084"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="83807084"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 20:32:08 -0700
X-CSE-ConnectionGUID: aT7I3Q+yTd6P7E3V+L6EVQ==
X-CSE-MsgGUID: 9+QbeOQlT3abUMtjXeKe/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="257012333"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 15 Jul 2026 20:32:06 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wkCpI-00000000OHa-45Wf;
	Thu, 16 Jul 2026 03:32:01 +0000
Date: Thu, 16 Jul 2026 11:31:41 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:misc] BUILD SUCCESS
 4867ab462d8d69e73c239b9a1a98e42a222f17a2
Message-ID: <202607161129.LbOHDGTy-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260715_203208_740138_F66780FE 
X-CRM114-Status: UNSURE (   3.86  )
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git misc
branch HEAD: 4867ab462d8d69e73c239b9a1a98e42a222f17a2  liveupdate: Remove redundant INIT_LIST_HEAD in luo_session_alloc

elapsed time: 756m

configs tested: 169
configs skipped: 22

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260716    clang-23
arc                   randconfig-002-20260716    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260716    clang-23
arm                   randconfig-002-20260716    clang-23
arm                   randconfig-003-20260716    clang-23
arm                   randconfig-004-20260716    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260716    gcc-12.5.0
arm64                 randconfig-002-20260716    gcc-12.5.0
arm64                 randconfig-003-20260716    gcc-12.5.0
arm64                 randconfig-004-20260716    gcc-12.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260716    gcc-12.5.0
csky                  randconfig-002-20260716    gcc-12.5.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260716    clang-20
hexagon               randconfig-002-20260716    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260716    clang-22
i386                  randconfig-002-20260716    clang-22
i386                  randconfig-003-20260716    clang-22
i386                  randconfig-004-20260716    clang-22
i386                  randconfig-005-20260716    clang-22
i386                  randconfig-006-20260716    clang-22
i386                  randconfig-007-20260716    clang-22
i386                  randconfig-011-20260716    clang-22
i386                  randconfig-012-20260716    clang-22
i386                  randconfig-013-20260716    clang-22
i386                  randconfig-014-20260716    clang-22
i386                  randconfig-015-20260716    clang-22
i386                  randconfig-016-20260716    clang-22
i386                  randconfig-017-20260716    clang-22
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260716    clang-20
loongarch             randconfig-002-20260716    clang-20
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
nios2                 randconfig-001-20260716    clang-20
nios2                 randconfig-002-20260716    clang-20
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
parisc                randconfig-001-20260716    clang-19
parisc                randconfig-002-20260716    clang-19
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260716    clang-19
powerpc               randconfig-002-20260716    clang-19
powerpc64             randconfig-001-20260716    clang-19
powerpc64             randconfig-002-20260716    clang-19
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260716    clang-17
riscv                 randconfig-002-20260716    clang-17
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                  randconfig-001-20260716    clang-17
s390                  randconfig-002-20260716    clang-17
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260716    clang-17
sh                    randconfig-002-20260716    clang-17
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260716    gcc-13.4.0
sparc                 randconfig-002-20260716    gcc-13.4.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260716    gcc-13.4.0
sparc64               randconfig-002-20260716    gcc-13.4.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260716    gcc-13.4.0
um                    randconfig-002-20260716    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64      buildonly-randconfig-001-20260716    gcc-14
x86_64      buildonly-randconfig-002-20260716    gcc-14
x86_64      buildonly-randconfig-003-20260716    gcc-14
x86_64      buildonly-randconfig-004-20260716    gcc-14
x86_64      buildonly-randconfig-005-20260716    gcc-14
x86_64      buildonly-randconfig-006-20260716    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260716    clang-22
x86_64                randconfig-002-20260716    clang-22
x86_64                randconfig-003-20260716    clang-22
x86_64                randconfig-004-20260716    clang-22
x86_64                randconfig-005-20260716    clang-22
x86_64                randconfig-006-20260716    clang-22
x86_64                randconfig-013-20260716    gcc-14
x86_64                randconfig-016-20260716    gcc-14
x86_64                randconfig-074-20260716    gcc-14
x86_64                randconfig-076-20260716    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260716    gcc-13.4.0
xtensa                randconfig-002-20260716    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

