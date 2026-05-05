Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9C7FF8855
	for <kexec@archiver.kernel.org>; Tue,  5 May 2026 14:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QIiq2TnXV7VX9raoqze+A9x750gza/lup4FagaRDuO0=; b=pF4lh+Zq1rgEs+lgi/6N7kizyZ
	QSYbK9LKbw94/74WG5URh4l7B3aUAcShUBhbDboMhuvVduECga++FkNGty6b3eQX8Dk/gtxUE7GaK
	IDpP63AlXMjVXW03FQkhoSwbWlYWqMyTkSsFgqgVG9/g9S50kyq59a4LyEx9IBXpeJavsk4Vh4P2O
	i6oAUo5VJP/jjq4ESfUKOsxW6EGrNURPdmcWQvlmJQh6mh5pc4EMBvwJMzPmW4JU1vsvL0V9y/DKS
	Ce7WSNq+Np3G4rq2KGCxzaZt+fy+MfiZ5Ue6PFPLjbdNhL/NJeYLmgDhItFJFd+lb5S6kJDbdGBfE
	lIz9S4Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wKGyL-0000000GY1d-1lSs;
	Tue, 05 May 2026 14:42:05 +0000
Received: from mgamail.intel.com ([198.175.65.17])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wKGyJ-0000000GY0j-1XNG
	for kexec@lists.infradead.org;
	Tue, 05 May 2026 14:42:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777992124; x=1809528124;
  h=date:from:to:cc:subject:message-id;
  bh=R2l/A68HQVp3IbjqC3S9JCzt16Z0+4ii9EKlQw3R2Sw=;
  b=D9NqR0aFSFUlMGSAWGVxKqIhXduFwJmTfku2gfO22clWvtRdSPdeYFxi
   A602b5u1sJMf2pPu/0mGelSLG4Htdg2cXQtOg1+EuTgMvlSI+L8yeUz9t
   pw2i1fW7d7V+y/n7jXEf8xD0S8kqXaxJPBJqf82BzFoCQ7yL33CNc4+rI
   uLg+CVtfcc65xILir3JKVI8tyiprStzTYDYjaqzxFl4JJzmfgooZk9ybc
   32pWxcN7VXb+/uJjj55qiy18cD9LjRGvBdFAPChaz1c5pzRsSWtSCHUVR
   9Zj9NBw+Vd8YMJs5AhfByMOm5gVhIXli9vaofztvcbgjX/Z/QtkMQK3YM
   w==;
X-CSE-ConnectionGUID: f3OuvZ9hTrGrRuJHt4H6yQ==
X-CSE-MsgGUID: j0kHlZvZS7S2KfL0sZE58Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78855084"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78855084"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 07:42:03 -0700
X-CSE-ConnectionGUID: RCjeVhqjQoi5TiwzanVuCA==
X-CSE-MsgGUID: UV+39sibQL+eL5w7qFRjXw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 9ec114424ce8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 05 May 2026 07:42:01 -0700
Received: from kbuild by 9ec114424ce8 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wKGyE-000000000BP-2c1R;
	Tue, 05 May 2026 14:41:58 +0000
Date: Tue, 05 May 2026 22:41:30 +0800
From: kernel test robot <lkp@intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:fixes] BUILD SUCCESS
 7b0b68b2b95606e65594958686833e53423f58f2
Message-ID: <202605052220.9ieZmn1z-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260505_074203_505745_61A9C5DF 
X-CRM114-Status: UNSURE (   3.69  )
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
branch HEAD: 7b0b68b2b95606e65594958686833e53423f58f2  mm/memfd_luo: document preservation of file seals

elapsed time: 733m

configs tested: 221
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260505    gcc-8.5.0
arc                   randconfig-002-20260505    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                            mmp2_defconfig    gcc-15.2.0
arm                   randconfig-001-20260505    gcc-8.5.0
arm                   randconfig-002-20260505    gcc-8.5.0
arm                   randconfig-003-20260505    gcc-8.5.0
arm                   randconfig-004-20260505    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260505    gcc-14.3.0
arm64                 randconfig-002-20260505    gcc-14.3.0
arm64                 randconfig-003-20260505    gcc-14.3.0
arm64                 randconfig-004-20260505    gcc-14.3.0
csky                             alldefconfig    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260505    gcc-14.3.0
csky                  randconfig-002-20260505    gcc-14.3.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260505    clang-23
hexagon               randconfig-001-20260505    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260505    clang-23
hexagon               randconfig-002-20260505    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260505    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260505    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260505    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260505    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260505    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260505    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260505    clang-20
i386                  randconfig-002-20260505    clang-20
i386                  randconfig-003-20260505    clang-20
i386                  randconfig-004-20260505    clang-20
i386                  randconfig-005-20260505    clang-20
i386                  randconfig-006-20260505    clang-20
i386                  randconfig-007-20260505    clang-20
i386                  randconfig-011-20260505    clang-20
i386                  randconfig-012-20260505    clang-20
i386                  randconfig-013-20260505    clang-20
i386                  randconfig-014-20260505    clang-20
i386                  randconfig-015-20260505    clang-20
i386                  randconfig-016-20260505    clang-20
i386                  randconfig-017-20260505    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260505    clang-23
loongarch             randconfig-001-20260505    gcc-11.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260505    clang-23
loongarch             randconfig-002-20260505    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                  decstation_64_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260505    clang-23
nios2                 randconfig-001-20260505    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260505    clang-23
nios2                 randconfig-002-20260505    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc         de0_nano_multicore_defconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                generic-32bit_defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-14.3.0
parisc                randconfig-001-20260505    gcc-14.3.0
parisc                         randconfig-002    gcc-14.3.0
parisc                randconfig-002-20260505    gcc-14.3.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                        randconfig-001    gcc-14.3.0
powerpc               randconfig-001-20260505    gcc-14.3.0
powerpc                        randconfig-002    gcc-14.3.0
powerpc               randconfig-002-20260505    gcc-14.3.0
powerpc                     tqm8541_defconfig    clang-23
powerpc64                      randconfig-001    gcc-14.3.0
powerpc64             randconfig-001-20260505    gcc-14.3.0
powerpc64                      randconfig-002    gcc-14.3.0
powerpc64             randconfig-002-20260505    gcc-14.3.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260505    gcc-10.5.0
riscv                 randconfig-002-20260505    gcc-10.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260505    gcc-10.5.0
s390                  randconfig-002-20260505    gcc-10.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260505    gcc-10.5.0
sh                    randconfig-002-20260505    gcc-10.5.0
sh                          urquell_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-15.2.0
sparc                 randconfig-001-20260505    gcc-15.2.0
sparc                          randconfig-002    gcc-15.2.0
sparc                 randconfig-002-20260505    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-15.2.0
sparc64               randconfig-001-20260505    gcc-15.2.0
sparc64                        randconfig-002    gcc-15.2.0
sparc64               randconfig-002-20260505    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-15.2.0
um                    randconfig-001-20260505    gcc-15.2.0
um                             randconfig-002    gcc-15.2.0
um                    randconfig-002-20260505    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260505    clang-20
x86_64      buildonly-randconfig-002-20260505    clang-20
x86_64      buildonly-randconfig-003-20260505    clang-20
x86_64      buildonly-randconfig-004-20260505    clang-20
x86_64      buildonly-randconfig-005-20260505    clang-20
x86_64      buildonly-randconfig-006-20260505    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                         randconfig-001    clang-20
x86_64                randconfig-001-20260505    clang-20
x86_64                         randconfig-002    clang-20
x86_64                randconfig-002-20260505    clang-20
x86_64                         randconfig-003    clang-20
x86_64                randconfig-003-20260505    clang-20
x86_64                         randconfig-004    clang-20
x86_64                randconfig-004-20260505    clang-20
x86_64                         randconfig-005    clang-20
x86_64                randconfig-005-20260505    clang-20
x86_64                         randconfig-006    clang-20
x86_64                randconfig-006-20260505    clang-20
x86_64                         randconfig-011    clang-20
x86_64                randconfig-011-20260505    clang-20
x86_64                         randconfig-012    clang-20
x86_64                randconfig-012-20260505    clang-20
x86_64                         randconfig-013    clang-20
x86_64                randconfig-013-20260505    clang-20
x86_64                         randconfig-014    clang-20
x86_64                randconfig-014-20260505    clang-20
x86_64                         randconfig-015    clang-20
x86_64                randconfig-015-20260505    clang-20
x86_64                         randconfig-016    clang-20
x86_64                randconfig-016-20260505    clang-20
x86_64                randconfig-071-20260505    clang-20
x86_64                randconfig-071-20260505    gcc-14
x86_64                randconfig-072-20260505    clang-20
x86_64                randconfig-073-20260505    clang-20
x86_64                randconfig-073-20260505    gcc-14
x86_64                randconfig-074-20260505    clang-20
x86_64                randconfig-074-20260505    gcc-14
x86_64                randconfig-075-20260505    clang-20
x86_64                randconfig-076-20260505    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                         randconfig-001    gcc-15.2.0
xtensa                randconfig-001-20260505    gcc-15.2.0
xtensa                         randconfig-002    gcc-15.2.0
xtensa                randconfig-002-20260505    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

