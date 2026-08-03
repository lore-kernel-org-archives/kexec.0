Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FBEC55162
	for <kexec@archiver.kernel.org>; Mon,  3 Aug 2026 04:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=28zMJJmQ3uHak88wBMc+1rbRXBTa87WEI+8W21akOOk=; b=VYXjahawicWKiTuZlUmfCn/5JG
	c1SE86Ym1AgpWSoL69agmwCrPJb3CUJEjpFUYQsfhoa3IdINW9vEl8V8P/byya6tSIQOU5XSiTecb
	KI827Mn8SQkq1Hbi9Tymhs29eW9xeRkX+k4eo3qb76uKwV3/0SKeCzr/M/zH7ExIypIVDwwZ9bhB7
	4O6UCl7/1F7Ik7jEM4TmTgCPeamsSpsz5rQONRPE/5kzgLiyXFx8hgFLWebQGIu8Pu5RVqoWx3b4e
	A6/D8vEiFLeZLslZVuHW+kiASdHJ9u2HD3HZFooIaFjiDRqRNu9oWOpKhs/CHbVfDVJE+tPowGo7W
	MoQEKXhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqkAU-0000000GJ7d-3VUL;
	Mon, 03 Aug 2026 04:20:50 +0000
Received: from mgamail.intel.com ([192.198.163.14])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqkAS-0000000GJ6m-0eJ5
	for kexec@lists.infradead.org;
	Mon, 03 Aug 2026 04:20:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785730848; x=1817266848;
  h=date:from:to:cc:subject:message-id;
  bh=3jhZD8RTIBmOZx5xIeBO75FllwaW92d9zvSq+trx998=;
  b=EOwPU7v0Xhd4X/nJ58MvO14+hXhBVmqZm3ef44+txLha5v+ylDq2j8kd
   /NiRELOC0GtGq4MusuOKV9LCFRdPQ2mmDDmbk4A+3yB4zW9OruOz1Bz9G
   nWjOBUHEhr2D/v6FAgh65FLQhW4aF+hfnJaRI+YbsrrIXUX6b65Bm+Aw5
   g7DFEFk69O4ZSJMXoYiXG7dDuY2L4Ritvi0mF91Qm5I+Y0EIoaShnq04e
   3jii6s9T23l7cYhINXPn3hxlBnINtd6d0GbFIzBmLLqOMQ4gvnQWXbKZb
   4/4oDUvegOLm/bQ/Wl+ZzRBUz97nUEudrL+VuN4RGv58d2dawSRUH5DPb
   g==;
X-CSE-ConnectionGUID: U1ptd92oSZyrqPjS+5q4HA==
X-CSE-MsgGUID: SqCdRviBQVSYrV69gpt8vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="86295066"
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="86295066"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2026 21:20:47 -0700
X-CSE-ConnectionGUID: LMlTShfOTcqLYzEiF6UucQ==
X-CSE-MsgGUID: w5Q400HcR0GKC5VSmipFLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="264931438"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 02 Aug 2026 21:20:46 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wqkAN-0000000063f-3Eg7;
	Mon, 03 Aug 2026 04:20:43 +0000
Date: Mon, 03 Aug 2026 12:20:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:next] BUILD SUCCESS
 5ab8d80d42bd2bd95865bd7b94790bd9c8d1450e
Message-ID: <202608031201.U8woju0Q-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260802_212048_205433_BDFAB132 
X-CRM114-Status: UNSURE (   3.99  )
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
branch HEAD: 5ab8d80d42bd2bd95865bd7b94790bd9c8d1450e  Merge branch 'kho-scratch' into next

elapsed time: 749m

configs tested: 113
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260802    gcc-8.5.0
arc                  randconfig-001-20260803    gcc-8.5.0
arc                  randconfig-002-20260802    gcc-15.2.0
arc                  randconfig-002-20260803    gcc-8.5.0
arm                            mxs_defconfig    clang-17
arm                  randconfig-001-20260802    gcc-11.5.0
arm                  randconfig-001-20260803    gcc-8.5.0
arm                  randconfig-002-20260802    gcc-13.4.0
arm                  randconfig-002-20260803    gcc-8.5.0
arm                  randconfig-003-20260802    clang-24
arm                  randconfig-003-20260803    gcc-8.5.0
arm                  randconfig-004-20260802    gcc-13.4.0
arm                  randconfig-004-20260803    gcc-8.5.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260802    clang-18
arm64                randconfig-001-20260803    gcc-12.5.0
arm64                randconfig-002-20260802    gcc-15.2.0
arm64                randconfig-002-20260803    gcc-12.5.0
arm64                randconfig-003-20260802    gcc-13.4.0
arm64                randconfig-003-20260803    gcc-12.5.0
arm64                randconfig-004-20260802    gcc-8.5.0
arm64                randconfig-004-20260803    gcc-12.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260802    gcc-11.5.0
csky                 randconfig-001-20260803    gcc-12.5.0
csky                 randconfig-002-20260802    gcc-9.5.0
csky                 randconfig-002-20260803    gcc-12.5.0
hexagon              randconfig-001-20260803    clang-18
hexagon              randconfig-002-20260803    clang-18
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260803    clang-22
i386       buildonly-randconfig-002-20260803    clang-22
i386       buildonly-randconfig-003-20260803    clang-22
i386       buildonly-randconfig-004-20260803    clang-22
i386       buildonly-randconfig-005-20260803    clang-22
i386       buildonly-randconfig-006-20260803    clang-22
i386                 randconfig-001-20260803    gcc-13
i386                 randconfig-002-20260803    gcc-13
i386                 randconfig-003-20260803    gcc-13
i386                 randconfig-004-20260803    gcc-13
i386                 randconfig-005-20260803    gcc-13
i386                 randconfig-006-20260803    gcc-13
i386                 randconfig-007-20260803    gcc-13
i386                 randconfig-011-20260803    clang-22
i386                 randconfig-012-20260803    clang-22
i386                 randconfig-013-20260803    clang-22
i386                 randconfig-014-20260803    clang-22
i386                 randconfig-015-20260803    clang-22
i386                 randconfig-016-20260803    clang-22
i386                 randconfig-017-20260803    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260803    clang-18
loongarch            randconfig-002-20260803    clang-18
mips                          ci20_defconfig    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260803    clang-18
nios2                randconfig-002-20260803    clang-18
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260803    gcc-15.2.0
parisc               randconfig-002-20260803    gcc-15.2.0
powerpc              randconfig-001-20260803    gcc-15.2.0
powerpc              randconfig-002-20260803    gcc-15.2.0
powerpc64            randconfig-001-20260803    gcc-15.2.0
powerpc64            randconfig-002-20260803    gcc-15.2.0
riscv                randconfig-001-20260803    gcc-8.5.0
riscv                randconfig-002-20260803    gcc-8.5.0
s390                 randconfig-001-20260803    gcc-8.5.0
s390                 randconfig-002-20260803    gcc-8.5.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260803    gcc-8.5.0
sh                   randconfig-002-20260803    gcc-8.5.0
sparc                randconfig-001-20260803    gcc-16.1.0
sparc                randconfig-002-20260803    gcc-16.1.0
sparc64              randconfig-001-20260803    gcc-16.1.0
sparc64              randconfig-002-20260803    gcc-16.1.0
um                   randconfig-001-20260803    gcc-16.1.0
um                   randconfig-002-20260803    gcc-16.1.0
x86_64     buildonly-randconfig-001-20260803    clang-22
x86_64     buildonly-randconfig-002-20260803    clang-22
x86_64     buildonly-randconfig-003-20260803    clang-22
x86_64     buildonly-randconfig-004-20260803    clang-22
x86_64     buildonly-randconfig-005-20260803    clang-22
x86_64     buildonly-randconfig-006-20260803    clang-22
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260803    gcc-14
x86_64               randconfig-002-20260803    gcc-14
x86_64               randconfig-003-20260803    gcc-14
x86_64               randconfig-004-20260803    gcc-14
x86_64               randconfig-005-20260803    gcc-14
x86_64               randconfig-006-20260803    gcc-14
x86_64               randconfig-011-20260803    gcc-14
x86_64               randconfig-012-20260803    gcc-14
x86_64               randconfig-013-20260803    gcc-14
x86_64               randconfig-014-20260803    gcc-14
x86_64               randconfig-015-20260803    gcc-14
x86_64               randconfig-016-20260803    gcc-14
x86_64               randconfig-071-20260803    clang-22
x86_64               randconfig-072-20260803    clang-22
x86_64               randconfig-073-20260803    clang-22
x86_64               randconfig-074-20260803    clang-22
x86_64               randconfig-075-20260803    clang-22
x86_64               randconfig-076-20260803    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260803    gcc-16.1.0
xtensa               randconfig-002-20260803    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

