Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9B9C53200
	for <kexec@archiver.kernel.org>; Thu, 30 Jul 2026 00:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JeslkEd9Ar+vzpcyimUV1iFcnD4iRNklSGmelBp4l3M=; b=y3fJj/cc1z2AqrQOcDHJJ8PHb2
	J/zd8+LvlBPqSKQuVvJNlsPkKS2rrQIYes6Io3Cgr4FFZnoNtTW+170suG5sq5qmqgMPE2DxF+o/i
	A85wmUeGyGPh8ZwfrnJJg61DoHxg50qiVQPoSQT0V+6Wpc/a7HRNA0urCNoJicjABnFKPUY/PhxWV
	XwTPDOS4sAa1Gss/4EzdQTeLQ2PKK3wJ0asB0MFn3LRNccegHJB+vReD2duNimFwEU/hx32ywi4iN
	Jtue3IiZ1GZuOfyyqvRfmYmgh9MZzWa+MdVrkqQ6BpQRy8GAFbj/urbB+1aOxq6DP9AheVlTu/AWL
	jF4A8pTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpEO4-000000099IM-177F;
	Thu, 30 Jul 2026 00:12:36 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpEO2-000000099Hp-0h0Q
	for kexec@lists.infradead.org;
	Thu, 30 Jul 2026 00:12:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785370354; x=1816906354;
  h=date:from:to:cc:subject:message-id;
  bh=PrM8JrX7FFT+gc+zj4ZUz73UsVpZa5sNECCUs/FIwlw=;
  b=hBESr1EYVLe3c8S0rq2WIfKlEGieiWKtfntK34zXW4UH9bojYabJ2bHK
   mH3KCAssAtwz/cl8fLaRwVWlIpkOLRqNv0VdyibMkWqdfBP4rnYayaVC6
   24Rbk6ThYlACwyjZUAJfa/tArq6hKhf9XKp6/V4f8q23Da+QWkzYFsEcU
   mLHBLsEb4FugvxdCxaWU3tE/t4qQSVX+DCeb/gwmDjySiQZxwWzfJoFpJ
   R8i7wEogIWLT98sYgQYwOBV6q4R2sJ8BVcp6cUN/rH3s/QU+pVD8cFr5i
   x/Fb+3OUiedqu9i74eU9uaC28A0yM67qDZDxjreH90s1ESLKTZYxpVCqB
   A==;
X-CSE-ConnectionGUID: Iv5kHQPJQoSe7EUj5JTQqg==
X-CSE-MsgGUID: h+H/bpmKTum6um8HAlNVYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="108780017"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="108780017"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 17:12:33 -0700
X-CSE-ConnectionGUID: /m/0EOpJQISJWlXZHsyu5g==
X-CSE-MsgGUID: i63imPGESVOHUUU3CeljLQ==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 29 Jul 2026 17:12:31 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wpENx-00000000fmQ-1x5N;
	Thu, 30 Jul 2026 00:12:29 +0000
Date: Thu, 30 Jul 2026 08:12:20 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:fixes] BUILD SUCCESS
 3a0b8fa2eb36afc88b62a95f33f0c77c71fa5ded
Message-ID: <202607300800.kwHw7sx6-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_171234_298247_E228FA6E 
X-CRM114-Status: UNSURE (   4.12  )
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
branch HEAD: 3a0b8fa2eb36afc88b62a95f33f0c77c71fa5ded  kho: fix size calculation in kho_preserved_memory_reserve()

elapsed time: 938m

configs tested: 216
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    gcc-8.5.0
arc                  randconfig-001-20260729    gcc-8.5.0
arc                  randconfig-001-20260730    gcc-8.5.0
arc                  randconfig-002-20260729    gcc-13.4.0
arc                  randconfig-002-20260729    gcc-8.5.0
arc                  randconfig-002-20260730    gcc-8.5.0
arm                  randconfig-001-20260729    gcc-10.5.0
arm                  randconfig-001-20260729    gcc-8.5.0
arm                  randconfig-001-20260730    gcc-8.5.0
arm                  randconfig-002-20260729    gcc-8.5.0
arm                  randconfig-002-20260730    gcc-8.5.0
arm                  randconfig-003-20260729    clang-24
arm                  randconfig-003-20260729    gcc-8.5.0
arm                  randconfig-003-20260730    gcc-8.5.0
arm                  randconfig-004-20260729    clang-18
arm                  randconfig-004-20260729    gcc-8.5.0
arm                  randconfig-004-20260730    gcc-8.5.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260729    clang-17
arm64                randconfig-001-20260729    gcc-15.2.0
arm64                randconfig-001-20260730    gcc-15.2.0
arm64                randconfig-002-20260729    clang-17
arm64                randconfig-002-20260729    gcc-13.4.0
arm64                randconfig-002-20260730    gcc-15.2.0
arm64                randconfig-003-20260729    clang-17
arm64                randconfig-003-20260729    gcc-11.5.0
arm64                randconfig-003-20260730    gcc-15.2.0
arm64                randconfig-004-20260729    clang-17
arm64                randconfig-004-20260730    gcc-15.2.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260729    clang-17
csky                 randconfig-001-20260729    gcc-16.1.0
csky                 randconfig-001-20260730    gcc-15.2.0
csky                 randconfig-002-20260729    clang-17
csky                 randconfig-002-20260729    gcc-16.1.0
csky                 randconfig-002-20260730    gcc-15.2.0
hexagon                       randconfig-001    gcc-9.5.0
hexagon              randconfig-001-20260729    clang-21
hexagon              randconfig-001-20260729    gcc-9.5.0
hexagon              randconfig-001-20260730    clang-24
hexagon              randconfig-002-20260729    clang-17
hexagon              randconfig-002-20260729    gcc-9.5.0
hexagon              randconfig-002-20260730    clang-24
i386                            allmodconfig    gcc-14
i386                buildonly-randconfig-001    gcc-14
i386       buildonly-randconfig-001-20260729    gcc-14
i386       buildonly-randconfig-001-20260730    gcc-14
i386       buildonly-randconfig-002-20260729    clang-22
i386       buildonly-randconfig-002-20260729    gcc-14
i386       buildonly-randconfig-002-20260730    gcc-14
i386       buildonly-randconfig-003-20260729    gcc-14
i386       buildonly-randconfig-003-20260730    gcc-14
i386       buildonly-randconfig-004-20260729    clang-22
i386       buildonly-randconfig-004-20260729    gcc-14
i386       buildonly-randconfig-004-20260730    gcc-14
i386       buildonly-randconfig-005-20260729    clang-22
i386       buildonly-randconfig-005-20260729    gcc-14
i386       buildonly-randconfig-005-20260730    gcc-14
i386       buildonly-randconfig-006-20260729    gcc-14
i386       buildonly-randconfig-006-20260730    gcc-14
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
i386                 randconfig-011-20260730    clang-22
i386                 randconfig-012-20260729    clang-22
i386                 randconfig-012-20260729    gcc-14
i386                 randconfig-012-20260730    clang-22
i386                 randconfig-013-20260729    clang-22
i386                 randconfig-013-20260729    gcc-14
i386                 randconfig-013-20260730    clang-22
i386                 randconfig-014-20260729    gcc-14
i386                 randconfig-014-20260730    clang-22
i386                 randconfig-015-20260729    clang-22
i386                 randconfig-015-20260729    gcc-14
i386                 randconfig-015-20260730    clang-22
i386                 randconfig-016-20260729    gcc-14
i386                 randconfig-016-20260730    clang-22
i386                 randconfig-017-20260729    clang-22
i386                 randconfig-017-20260729    gcc-14
i386                 randconfig-017-20260730    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260729    clang-19
loongarch            randconfig-001-20260729    gcc-9.5.0
loongarch            randconfig-001-20260730    clang-24
loongarch            randconfig-002-20260729    gcc-13.4.0
loongarch            randconfig-002-20260729    gcc-9.5.0
loongarch            randconfig-002-20260730    clang-24
mips                       bcm63xx_defconfig    clang-24
mips                          ip30_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260729    gcc-11.5.0
nios2                randconfig-001-20260729    gcc-9.5.0
nios2                randconfig-001-20260730    clang-24
nios2                randconfig-002-20260729    gcc-9.5.0
nios2                randconfig-002-20260730    clang-24
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260729    clang-24
parisc               randconfig-001-20260730    gcc-14.3.0
parisc               randconfig-002-20260729    clang-24
parisc               randconfig-002-20260730    gcc-14.3.0
powerpc                mpc836x_rdk_defconfig    clang-24
powerpc              randconfig-001-20260729    clang-24
powerpc              randconfig-001-20260730    gcc-14.3.0
powerpc              randconfig-002-20260729    clang-24
powerpc              randconfig-002-20260730    gcc-14.3.0
powerpc64            randconfig-001-20260729    clang-24
powerpc64            randconfig-001-20260730    gcc-14.3.0
powerpc64            randconfig-002-20260729    clang-24
powerpc64            randconfig-002-20260730    gcc-14.3.0
riscv                randconfig-001-20260729    gcc-15.2.0
riscv                randconfig-001-20260730    gcc-15.2.0
riscv                randconfig-002-20260729    gcc-15.2.0
riscv                randconfig-002-20260730    gcc-15.2.0
s390                 randconfig-001-20260729    gcc-15.2.0
s390                 randconfig-001-20260730    gcc-15.2.0
s390                 randconfig-002-20260729    gcc-15.2.0
s390                 randconfig-002-20260730    gcc-15.2.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260729    gcc-15.2.0
sh                   randconfig-001-20260730    gcc-15.2.0
sh                   randconfig-002-20260729    gcc-15.2.0
sh                   randconfig-002-20260730    gcc-15.2.0
sh                  sh7724_generic_defconfig    gcc-16.1.0
sparc                         randconfig-001    clang-24
sparc                         randconfig-001    gcc-16.1.0
sparc                randconfig-001-20260729    gcc-10.5.0
sparc                randconfig-001-20260729    gcc-8.5.0
sparc                randconfig-001-20260730    clang-24
sparc                randconfig-002-20260729    gcc-10.5.0
sparc                randconfig-002-20260729    gcc-16.1.0
sparc                randconfig-002-20260730    clang-24
sparc64              randconfig-001-20260729    gcc-10.5.0
sparc64              randconfig-001-20260729    gcc-12.5.0
sparc64              randconfig-001-20260730    clang-24
sparc64              randconfig-002-20260729    clang-21
sparc64              randconfig-002-20260729    gcc-10.5.0
sparc64              randconfig-002-20260730    clang-24
um                   randconfig-001-20260729    gcc-10.5.0
um                   randconfig-001-20260729    gcc-14
um                   randconfig-001-20260730    clang-24
um                   randconfig-002-20260729    gcc-10.5.0
um                   randconfig-002-20260729    gcc-14
um                   randconfig-002-20260730    clang-24
x86_64              buildonly-randconfig-001    gcc-12
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
x86_64               randconfig-003-20260729    clang-22
x86_64               randconfig-004-20260729    clang-22
x86_64               randconfig-005-20260729    clang-22
x86_64               randconfig-006-20260729    clang-22
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
x86_64               randconfig-071-20260729    gcc-12
x86_64               randconfig-071-20260730    gcc-12
x86_64               randconfig-072-20260729    gcc-12
x86_64               randconfig-072-20260730    gcc-12
x86_64               randconfig-073-20260729    gcc-12
x86_64               randconfig-073-20260730    gcc-12
x86_64               randconfig-074-20260729    gcc-12
x86_64               randconfig-074-20260730    gcc-12
x86_64               randconfig-075-20260729    gcc-12
x86_64               randconfig-075-20260730    gcc-12
x86_64               randconfig-076-20260729    gcc-12
x86_64               randconfig-076-20260730    gcc-12
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260729    gcc-10.5.0
xtensa               randconfig-001-20260729    gcc-12.5.0
xtensa               randconfig-001-20260730    clang-24
xtensa               randconfig-002-20260729    gcc-10.5.0
xtensa               randconfig-002-20260730    clang-24

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

