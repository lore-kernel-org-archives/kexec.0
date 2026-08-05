Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4CCC55ABA
	for <kexec@archiver.kernel.org>; Wed,  5 Aug 2026 11:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mpu9QU2Ll61p4KXpmqTdmsabQGU48NQ/FcGPxkrR1d4=; b=VTrQpFpLHKZ8mrn+2WgbPPdHmU
	uN1GrI/WqT+IMrapvA0qfmkOqMIjLryH6fttNukFaOpYjB6yj98BKuzN1OUEYs7/ncIGiXalosSzT
	a/WOQQFAkHw6+Vm29mpV3BnODikKbwvYzB6E+G71vDP2d5yXX0Kimka3jqoOFI9Bdf9KvSkN77CvU
	99zVQCMgDFAL/wFB4mXyvB3WeVMqlAwkt/uFaNepaSyPNJQTOgAGZJ87dSezc3S6Mi26q8Ya4pAvP
	2dNLP4Ot3Oy/Kxuga5EKH4nnUQix2rJwHt7AkDRpFEVpZw1dPIIy9gh6hIUmBLgoOQWXHhvZyusSO
	cTEoEarA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wraG6-00000003qMe-13xx;
	Wed, 05 Aug 2026 11:58:06 +0000
Received: from mgamail.intel.com ([198.175.65.11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wraG3-00000003qKH-2iMp
	for kexec@lists.infradead.org;
	Wed, 05 Aug 2026 11:58:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785931084; x=1817467084;
  h=date:from:to:cc:subject:message-id;
  bh=HaGb8+teKOc8NgR8BmmPKt6+MKFMBKgd/WZZ57XCTcY=;
  b=exdKUkFrvUzimkuiFT6yU7k455JSUUJ6LVb21ZDfypmtDg16xi4R+38i
   YZ0JR/gVfjr+V6rSZt+YAfbVmvexR0PKNNRY43OEod+3lOPIOiebCsg/R
   vYZcTlqyXxIE11ifUArLixwaiE4LEs7DPtowK16bkd9s0Ygp0s9auTFB/
   ppK1FI+hUYco2sAi6KeYyhwgt41TB2xtph1ckxozyzakdb1sVd7uTXNUK
   RBKfuD167fxwJgCznlZlGJaSJc9QL0If8l470U9hu0IwRKezTGdxagc1F
   KME7Gjd1H2gPx8or4S4rMYlPAMwXC0m1mFHT0/7u8+tCHeDKQM8N9lIjg
   w==;
X-CSE-ConnectionGUID: h9OI1CYmScaxyE4+ND47kA==
X-CSE-MsgGUID: 5a0ajac3TQmeTquezEbZRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96855712"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="96855712"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 04:58:03 -0700
X-CSE-ConnectionGUID: XMVozn+rRUGMtltZYW3Itw==
X-CSE-MsgGUID: ZaDfCrInQIWstSYkDX7DWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="266913115"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 05 Aug 2026 04:58:00 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wraFy-00000000CKt-1yXy;
	Wed, 05 Aug 2026 11:57:58 +0000
Date: Wed, 05 Aug 2026 19:57:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:kexec-next] BUILD SUCCESS
 9d50f7c5ad5b4b031c9b85f9a43c626d8268ab51
Message-ID: <202608051931.Br4YKNA9-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_045803_746860_283ADA1E 
X-CRM114-Status: UNSURE (   3.83  )
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
branch HEAD: 9d50f7c5ad5b4b031c9b85f9a43c626d8268ab51  Merge branch 'crashkernel-cma' into kexec-next

elapsed time: 1528m

configs tested: 197
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    gcc-12.5.0
arc                  randconfig-001-20260804    gcc-8.5.0
arc                  randconfig-001-20260805    gcc-12.5.0
arc                  randconfig-002-20260804    gcc-8.5.0
arc                  randconfig-002-20260805    gcc-12.5.0
arm                       multi_v7_defconfig    gcc-16.1.0
arm                  randconfig-001-20260804    gcc-8.5.0
arm                  randconfig-001-20260805    gcc-12.5.0
arm                  randconfig-002-20260804    gcc-8.5.0
arm                  randconfig-002-20260805    gcc-12.5.0
arm                  randconfig-003-20260804    gcc-8.5.0
arm                  randconfig-003-20260805    gcc-12.5.0
arm                  randconfig-004-20260804    gcc-8.5.0
arm                  randconfig-004-20260805    gcc-12.5.0
arm64                         randconfig-001    gcc-10.5.0
arm64                         randconfig-001    gcc-11.5.0
arm64                randconfig-001-20260804    gcc-11.5.0
arm64                randconfig-001-20260805    gcc-10.5.0
arm64                randconfig-002-20260804    gcc-11.5.0
arm64                randconfig-002-20260805    gcc-10.5.0
arm64                randconfig-003-20260804    gcc-11.5.0
arm64                randconfig-003-20260805    gcc-10.5.0
arm64                randconfig-004-20260804    gcc-11.5.0
arm64                randconfig-004-20260805    gcc-10.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260804    gcc-11.5.0
csky                 randconfig-001-20260805    gcc-10.5.0
csky                 randconfig-002-20260804    gcc-11.5.0
csky                 randconfig-002-20260805    gcc-10.5.0
hexagon                       randconfig-001    clang-18
hexagon              randconfig-001-20260804    gcc-16.1.0
hexagon              randconfig-001-20260805    clang-18
hexagon              randconfig-002-20260804    gcc-16.1.0
hexagon              randconfig-002-20260805    clang-18
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260804    gcc-14
i386       buildonly-randconfig-001-20260805    clang-22
i386       buildonly-randconfig-002-20260804    gcc-14
i386       buildonly-randconfig-002-20260805    clang-22
i386       buildonly-randconfig-003-20260804    gcc-14
i386       buildonly-randconfig-003-20260805    clang-22
i386       buildonly-randconfig-004-20260804    gcc-14
i386       buildonly-randconfig-004-20260805    clang-22
i386       buildonly-randconfig-005-20260804    gcc-14
i386       buildonly-randconfig-005-20260805    clang-22
i386       buildonly-randconfig-006-20260804    gcc-14
i386       buildonly-randconfig-006-20260805    clang-22
i386                 randconfig-001-20260804    clang-22
i386                 randconfig-001-20260805    gcc-13
i386                 randconfig-002-20260804    clang-22
i386                 randconfig-002-20260805    gcc-13
i386                 randconfig-003-20260804    clang-22
i386                 randconfig-003-20260805    gcc-13
i386                 randconfig-004-20260804    clang-22
i386                 randconfig-004-20260805    gcc-13
i386                 randconfig-005-20260804    clang-22
i386                 randconfig-005-20260805    gcc-13
i386                 randconfig-006-20260804    clang-22
i386                 randconfig-006-20260805    gcc-13
i386                 randconfig-007-20260804    clang-22
i386                 randconfig-007-20260805    gcc-13
i386                          randconfig-011    gcc-13
i386                          randconfig-011    gcc-14
i386                 randconfig-011-20260804    gcc-13
i386                 randconfig-011-20260805    gcc-14
i386                 randconfig-012-20260804    gcc-13
i386                 randconfig-012-20260805    gcc-14
i386                 randconfig-013-20260804    gcc-13
i386                 randconfig-013-20260805    gcc-14
i386                 randconfig-014-20260804    gcc-13
i386                 randconfig-014-20260805    gcc-14
i386                 randconfig-015-20260804    gcc-13
i386                 randconfig-015-20260805    gcc-14
i386                 randconfig-016-20260804    gcc-13
i386                 randconfig-016-20260805    gcc-14
i386                 randconfig-017-20260804    gcc-13
i386                 randconfig-017-20260805    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260804    gcc-16.1.0
loongarch            randconfig-001-20260805    clang-18
loongarch            randconfig-002-20260804    gcc-16.1.0
loongarch            randconfig-002-20260805    clang-18
mips                         ath79_defconfig    gcc-16.1.0
mips                          jazz_defconfig    clang-24
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260804    gcc-16.1.0
nios2                randconfig-001-20260805    clang-18
nios2                randconfig-002-20260804    gcc-16.1.0
nios2                randconfig-002-20260805    clang-18
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-8.5.0
parisc                        randconfig-001    gcc-9.5.0
parisc               randconfig-001-20260804    gcc-8.5.0
parisc               randconfig-001-20260805    gcc-9.5.0
parisc               randconfig-002-20260804    gcc-8.5.0
parisc               randconfig-002-20260805    gcc-9.5.0
powerpc                    ppa8548_defconfig    gcc-16.1.0
powerpc              randconfig-001-20260804    gcc-8.5.0
powerpc              randconfig-001-20260805    gcc-9.5.0
powerpc              randconfig-002-20260804    gcc-8.5.0
powerpc              randconfig-002-20260805    gcc-9.5.0
powerpc64            randconfig-001-20260804    gcc-8.5.0
powerpc64            randconfig-001-20260805    gcc-9.5.0
powerpc64            randconfig-002-20260804    gcc-8.5.0
powerpc64            randconfig-002-20260805    gcc-9.5.0
riscv                         randconfig-001    gcc-8.5.0
riscv                randconfig-001-20260805    gcc-8.5.0
riscv                randconfig-002-20260804    clang-21
riscv                randconfig-002-20260805    gcc-8.5.0
s390                 randconfig-001-20260804    clang-21
s390                 randconfig-001-20260805    gcc-8.5.0
s390                 randconfig-002-20260804    clang-21
s390                 randconfig-002-20260805    gcc-8.5.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260804    clang-21
sh                   randconfig-001-20260805    gcc-8.5.0
sh                   randconfig-002-20260804    clang-21
sh                   randconfig-002-20260805    gcc-8.5.0
sh                          se7705_defconfig    gcc-16.1.0
sh                            shx3_defconfig    gcc-16.1.0
sparc                randconfig-001-20260804    gcc-16.1.0
sparc                randconfig-001-20260805    gcc-11.5.0
sparc                randconfig-002-20260804    gcc-16.1.0
sparc                randconfig-002-20260805    gcc-11.5.0
sparc64              randconfig-001-20260804    gcc-16.1.0
sparc64              randconfig-001-20260805    gcc-11.5.0
sparc64              randconfig-002-20260804    gcc-16.1.0
sparc64              randconfig-002-20260805    gcc-11.5.0
um                   randconfig-001-20260804    gcc-16.1.0
um                   randconfig-001-20260805    gcc-11.5.0
um                   randconfig-002-20260804    gcc-16.1.0
um                   randconfig-002-20260805    gcc-11.5.0
x86_64              buildonly-randconfig-001    gcc-14
x86_64     buildonly-randconfig-001-20260804    gcc-14
x86_64     buildonly-randconfig-001-20260805    gcc-14
x86_64     buildonly-randconfig-002-20260804    gcc-14
x86_64     buildonly-randconfig-002-20260805    gcc-14
x86_64     buildonly-randconfig-003-20260804    gcc-14
x86_64     buildonly-randconfig-003-20260805    gcc-14
x86_64     buildonly-randconfig-004-20260804    gcc-14
x86_64     buildonly-randconfig-004-20260805    gcc-14
x86_64     buildonly-randconfig-005-20260804    gcc-14
x86_64     buildonly-randconfig-005-20260805    gcc-14
x86_64     buildonly-randconfig-006-20260804    gcc-14
x86_64     buildonly-randconfig-006-20260805    gcc-14
x86_64                                 kexec    clang-22
x86_64                        randconfig-001    gcc-14
x86_64               randconfig-001-20260804    gcc-14
x86_64               randconfig-001-20260805    gcc-14
x86_64               randconfig-002-20260804    gcc-14
x86_64               randconfig-002-20260805    gcc-14
x86_64               randconfig-003-20260804    gcc-14
x86_64               randconfig-003-20260805    gcc-14
x86_64               randconfig-004-20260804    gcc-14
x86_64               randconfig-004-20260805    gcc-14
x86_64               randconfig-005-20260804    gcc-14
x86_64               randconfig-005-20260805    gcc-14
x86_64               randconfig-006-20260804    gcc-14
x86_64               randconfig-006-20260805    gcc-14
x86_64               randconfig-011-20260804    clang-22
x86_64               randconfig-011-20260805    gcc-14
x86_64               randconfig-012-20260804    clang-22
x86_64               randconfig-012-20260805    gcc-14
x86_64               randconfig-013-20260804    clang-22
x86_64               randconfig-013-20260805    gcc-14
x86_64               randconfig-014-20260804    clang-22
x86_64               randconfig-014-20260805    gcc-14
x86_64               randconfig-015-20260804    clang-22
x86_64               randconfig-015-20260805    gcc-14
x86_64               randconfig-016-20260804    clang-22
x86_64               randconfig-016-20260805    gcc-14
x86_64                        randconfig-071    clang-22
x86_64               randconfig-071-20260804    clang-22
x86_64               randconfig-071-20260805    clang-22
x86_64               randconfig-072-20260804    clang-22
x86_64               randconfig-072-20260805    clang-22
x86_64               randconfig-073-20260804    clang-22
x86_64               randconfig-073-20260805    clang-22
x86_64               randconfig-074-20260804    clang-22
x86_64               randconfig-074-20260805    clang-22
x86_64               randconfig-075-20260804    clang-22
x86_64               randconfig-075-20260805    clang-22
x86_64               randconfig-076-20260804    clang-22
x86_64               randconfig-076-20260805    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260804    gcc-16.1.0
xtensa               randconfig-001-20260805    gcc-11.5.0
xtensa               randconfig-002-20260804    gcc-16.1.0
xtensa               randconfig-002-20260805    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

