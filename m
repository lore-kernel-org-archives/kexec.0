Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7BECD98C7
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 01:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=t4hlyOKQmuwmIi1Ov486qHCEjUMlBeEONoRZKE/OLJM=; b=h+DN+Nol/ETEdMwvlGrltiFIjE
	fd2elLlmxmrcRD24wfqax7b0LXhYH4dVAUybOacaPqDIaBo4uAH5nlKPe/chz1/71vNA0WSQEyhIE
	9mEnyxALT8I/BvUYIo9SCir39l1DXZBx7Qg0y3CTUinjJVAtPOuZZuRkQeb43OBC6KVYwvd1Jxdx2
	RG9Jp+B0LUDgnY0TPcUKx9S+7aeSM3lheVd+dsbA96uqpTJZklWEYJU68OJs0dLb/V9BoapnImURZ
	FPUz7UGzglKyohrvlzASRJgRlCJdNldq3num0tI7NLiVqc+cn9n6fcC9YJaFZSxTa3kprxY+dgqHc
	vXy1MKdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXqyM-0000000AGYl-0yLZ;
	Fri, 12 Jun 2026 01:46:14 +0000
Received: from mgamail.intel.com ([198.175.65.21])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXqyJ-0000000AGYG-2MPy
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 01:46:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781228772; x=1812764772;
  h=date:from:to:cc:subject:message-id;
  bh=81UtjhNbEXKvc/5Vw1NmBuVHN17N9dTM/84pDO1kWCA=;
  b=AT3KJpfuqWwLS2vKvoxHkeyYeJZsBYqD1qO5/lX/yiCo5yddtVnLzAfD
   3f1z2Dz4c+Nt/AQmpv+NQSVkWnXm3YzvC3J2fSfyDck9lThqfhy3wKH4P
   gGhDTPv/Mp/Si3uNg8piQ6eHdBTzHFa3APamcUZUW9n42uHrgHlun5Kfn
   XnrGSDiQ1+ifvzfhaFbgYMDGA8WDQG+WEt8cBHV79eXitPvA969dz8sNU
   viIeWcf22XjSaDuWZpc5uz5YCsJwrBv2gYzHLX8dRCjBkVwTx+/DMn60F
   DwBBfqIq3H12+vVJbWjwBKnE4sWG3+goh7LfsP8GjFwyernGhGW81OdEa
   g==;
X-CSE-ConnectionGUID: InOvoU1aS/STw7oKhWTjEw==
X-CSE-MsgGUID: 5LRe1ea8THa8aLLtqEldMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81965357"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="81965357"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 18:46:11 -0700
X-CSE-ConnectionGUID: 1ec3zzSQSLy66KrZyxRnPA==
X-CSE-MsgGUID: yn7//X5rSOOoUUkMZBMINA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="250611220"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 11 Jun 2026 18:46:10 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXqyE-00000000O80-14rl;
	Fri, 12 Jun 2026 01:46:06 +0000
Date: Fri, 12 Jun 2026 09:45:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:next] BUILD SUCCESS
 e98a9c61721c14bcd29f11f4802e52e908701f7a
Message-ID: <202606120948.EI7QuUub-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260611_184611_687712_C3161984 
X-CRM114-Status: UNSURE (   3.85  )
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
branch HEAD: e98a9c61721c14bcd29f11f4802e52e908701f7a  liveupdate: Document that retrieve failure is permanent

elapsed time: 772m

configs tested: 191
configs skipped: 2

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
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-13.4.0
arc                   randconfig-001-20260612    gcc-13.4.0
arc                            randconfig-002    gcc-13.4.0
arc                   randconfig-002-20260612    gcc-13.4.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                         at91_dt_defconfig    clang-17
arm                                 defconfig    gcc-16.1.0
arm                            randconfig-001    gcc-13.4.0
arm                   randconfig-001-20260612    gcc-13.4.0
arm                            randconfig-002    gcc-13.4.0
arm                   randconfig-002-20260612    gcc-13.4.0
arm                            randconfig-003    gcc-13.4.0
arm                   randconfig-003-20260612    gcc-13.4.0
arm                            randconfig-004    gcc-13.4.0
arm                   randconfig-004-20260612    gcc-13.4.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260612    gcc-13.4.0
arm64                 randconfig-002-20260612    gcc-13.4.0
arm64                 randconfig-003-20260612    gcc-13.4.0
arm64                 randconfig-004-20260612    gcc-13.4.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260612    gcc-13.4.0
csky                  randconfig-002-20260612    gcc-13.4.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260612    clang-23
hexagon               randconfig-002-20260612    clang-23
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260612    gcc-14
i386        buildonly-randconfig-002-20260612    gcc-14
i386        buildonly-randconfig-003-20260612    gcc-14
i386        buildonly-randconfig-004-20260612    gcc-14
i386        buildonly-randconfig-005-20260612    gcc-14
i386        buildonly-randconfig-006-20260612    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260612    clang-22
i386                  randconfig-002-20260612    clang-22
i386                  randconfig-003-20260612    clang-22
i386                  randconfig-004-20260612    clang-22
i386                  randconfig-005-20260612    clang-22
i386                  randconfig-006-20260612    clang-22
i386                  randconfig-007-20260612    clang-22
i386                  randconfig-011-20260612    clang-22
i386                  randconfig-012-20260612    clang-22
i386                  randconfig-013-20260612    clang-22
i386                  randconfig-014-20260612    clang-22
i386                  randconfig-015-20260612    clang-22
i386                  randconfig-016-20260612    clang-22
i386                  randconfig-017-20260612    clang-22
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260612    clang-23
loongarch             randconfig-002-20260612    clang-23
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                        m5272c3_defconfig    gcc-16.1.0
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
nios2                 randconfig-001-20260612    clang-23
nios2                 randconfig-002-20260612    clang-23
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
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260612    gcc-11.5.0
riscv                 randconfig-002-20260612    gcc-11.5.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260612    gcc-11.5.0
s390                  randconfig-002-20260612    gcc-11.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260612    gcc-11.5.0
sh                    randconfig-002-20260612    gcc-11.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260612    gcc-8.5.0
sparc                 randconfig-002-20260612    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260612    gcc-8.5.0
sparc64               randconfig-002-20260612    gcc-8.5.0
um                               allmodconfig    clang-17
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260612    gcc-8.5.0
um                    randconfig-002-20260612    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260612    gcc-14
x86_64      buildonly-randconfig-002-20260612    gcc-14
x86_64      buildonly-randconfig-003-20260612    gcc-14
x86_64      buildonly-randconfig-004-20260612    gcc-14
x86_64      buildonly-randconfig-005-20260612    gcc-14
x86_64      buildonly-randconfig-006-20260612    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260612    clang-22
x86_64                randconfig-002-20260612    clang-22
x86_64                randconfig-003-20260612    clang-22
x86_64                randconfig-004-20260612    clang-22
x86_64                randconfig-005-20260612    clang-22
x86_64                randconfig-006-20260612    clang-22
x86_64                randconfig-071-20260612    gcc-14
x86_64                randconfig-072-20260612    gcc-14
x86_64                randconfig-073-20260612    gcc-14
x86_64                randconfig-074-20260612    gcc-14
x86_64                randconfig-075-20260612    gcc-14
x86_64                randconfig-076-20260612    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260612    gcc-8.5.0
xtensa                randconfig-002-20260612    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

