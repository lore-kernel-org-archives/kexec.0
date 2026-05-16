Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C4DCD4851
	for <kexec@archiver.kernel.org>; Sat, 16 May 2026 22:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HD55c+qAN3scKLRr4VL+hTStdeEbN6NM+P+9GxHJNkQ=; b=XD8+ZoO2dWkinMT/5BdDG+obkq
	yhoerb6dwzRlv0vQeexPr0Cv1WRY7oAs+XmZwij73uTr4UtU8/UiL3lswwQbWubIRAQzvmaGJygjD
	lKJ2qn3vmh2JtoBFdLaffIuAfl6oOYphngSpbP5PdPUrB6f5c+O29XAzu4aVNdgKA/32USkLZ9FwN
	GxlFViZtwtJEajejeE/vF6EoU54O908JH2W6N880B6qcZ1YqQzaeg1NN6cjkcPgK//ITW7ozoP8KF
	drkGJN07hxL6fPdtsFDw+FB1+r/+AzQPHaj5XFb0utBbSgpOWvKc1CzL7N7z/0BCcOevDN3LpSj3z
	fNKUhDTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wONcD-0000000Bdx5-1UbZ;
	Sat, 16 May 2026 22:36:13 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wONc5-0000000Bdwa-3b7h
	for kexec@lists.infradead.org;
	Sat, 16 May 2026 22:36:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778970966; x=1810506966;
  h=date:from:to:cc:subject:message-id;
  bh=+PxpPAXuzVDG1H+PcMzcIrZ/psz5PJO/hX9CgtAPods=;
  b=LwhzvZTytHhkSNGztpgrdfa+N02C0FJYu5+6vCsQyTLxed2EUEdSM/uq
   6bqs23oXV08PtlXqef2sF0lZXtv86FNvSWM6lPzg+rzHnUf4u7ZO4l3OL
   c8d6DsI46NkPeyNaHQpUut+jSlA4F2iDvf60p8N9MMsqiYW9XIf38IHd/
   j75XtXG6wRUw7QZYM8tO41Z24X0feAH1XDx6W/k1NYjVu/PlzI8VVCig9
   3wb5ZPPdOC3CkEpxWqeZERMVkgFhphGESqu5aV+MschE8wMJluRNoZxAS
   2CJNRIfMGFPEp0YKLbuK3+yZ7eaDVz8CjpcL6x7hipWWqNvMtYqCN8lc4
   w==;
X-CSE-ConnectionGUID: V0SrJi4pTWWMm3G8nRDDqg==
X-CSE-MsgGUID: vAaERxkWTFiRC/kfh/uf9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="67407486"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="67407486"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 15:36:05 -0700
X-CSE-ConnectionGUID: nyQ7zuILS3mFNj8VebYkIw==
X-CSE-MsgGUID: TurjKGUhQnG4Pax0SWLAMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="238053365"
Received: from lkp-server01.sh.intel.com (HELO d94e5e629b2d) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 16 May 2026 15:36:04 -0700
Received: from kbuild by d94e5e629b2d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wONc1-000000001BC-0O2s;
	Sat, 16 May 2026 22:36:01 +0000
Date: Sun, 17 May 2026 06:35:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:fixes] BUILD SUCCESS
 d13dfb48dfa369fb2745116c0bc6f215517a351f
Message-ID: <202605170621.Ktc3oHd5-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260516_153605_948188_D19FAA38 
X-CRM114-Status: UNSURE (   3.80  )
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
branch HEAD: d13dfb48dfa369fb2745116c0bc6f215517a351f  kho: fix KHO_TREE_MAX_DEPTH for non-4KB page sizes

elapsed time: 813m

configs tested: 325
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                        nsimosci_defconfig    gcc-15.2.0
arc                   randconfig-001-20260516    gcc-8.5.0
arc                   randconfig-001-20260517    gcc-13.4.0
arc                   randconfig-002-20260516    gcc-8.5.0
arc                   randconfig-002-20260517    gcc-13.4.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                          pxa910_defconfig    gcc-15.2.0
arm                   randconfig-001-20260516    gcc-8.5.0
arm                   randconfig-001-20260517    gcc-13.4.0
arm                   randconfig-002-20260516    gcc-8.5.0
arm                   randconfig-002-20260517    gcc-13.4.0
arm                   randconfig-003-20260516    gcc-8.5.0
arm                   randconfig-003-20260517    gcc-13.4.0
arm                   randconfig-004-20260516    gcc-8.5.0
arm                   randconfig-004-20260517    gcc-13.4.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260516    clang-23
arm64                 randconfig-001-20260516    gcc-9.5.0
arm64                 randconfig-001-20260517    clang-23
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260516    clang-23
arm64                 randconfig-002-20260516    gcc-9.5.0
arm64                 randconfig-002-20260517    clang-23
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260516    clang-23
arm64                 randconfig-003-20260516    gcc-9.5.0
arm64                 randconfig-003-20260517    clang-23
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260516    clang-23
arm64                 randconfig-004-20260516    gcc-9.5.0
arm64                 randconfig-004-20260517    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260516    clang-23
csky                  randconfig-001-20260516    gcc-9.5.0
csky                  randconfig-001-20260517    clang-23
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260516    clang-23
csky                  randconfig-002-20260516    gcc-9.5.0
csky                  randconfig-002-20260517    clang-23
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260516    gcc-11.5.0
hexagon               randconfig-001-20260517    gcc-9.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260516    gcc-11.5.0
hexagon               randconfig-002-20260517    gcc-9.5.0
i386                             alldefconfig    gcc-14
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                 buildonly-randconfig-001    clang-20
i386        buildonly-randconfig-001-20260516    clang-20
i386        buildonly-randconfig-001-20260517    gcc-14
i386                 buildonly-randconfig-002    clang-20
i386        buildonly-randconfig-002-20260516    clang-20
i386        buildonly-randconfig-002-20260517    gcc-14
i386                 buildonly-randconfig-003    clang-20
i386        buildonly-randconfig-003-20260516    clang-20
i386        buildonly-randconfig-003-20260517    gcc-14
i386                 buildonly-randconfig-004    clang-20
i386        buildonly-randconfig-004-20260516    clang-20
i386        buildonly-randconfig-004-20260517    gcc-14
i386                 buildonly-randconfig-005    clang-20
i386        buildonly-randconfig-005-20260516    clang-20
i386        buildonly-randconfig-005-20260517    gcc-14
i386                 buildonly-randconfig-006    clang-20
i386        buildonly-randconfig-006-20260516    clang-20
i386        buildonly-randconfig-006-20260517    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260516    clang-20
i386                  randconfig-001-20260517    gcc-14
i386                  randconfig-002-20260516    clang-20
i386                  randconfig-002-20260517    gcc-14
i386                  randconfig-003-20260516    clang-20
i386                  randconfig-003-20260517    gcc-14
i386                  randconfig-004-20260516    clang-20
i386                  randconfig-004-20260517    gcc-14
i386                  randconfig-005-20260516    clang-20
i386                  randconfig-005-20260517    gcc-14
i386                  randconfig-006-20260516    clang-20
i386                  randconfig-006-20260517    gcc-14
i386                  randconfig-007-20260516    clang-20
i386                  randconfig-007-20260517    gcc-14
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260516    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260516    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260516    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260516    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260516    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260516    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260516    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260516    gcc-11.5.0
loongarch             randconfig-001-20260517    gcc-9.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260516    gcc-11.5.0
loongarch             randconfig-002-20260517    gcc-9.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260516    gcc-11.5.0
nios2                 randconfig-001-20260517    gcc-9.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260516    gcc-11.5.0
nios2                 randconfig-002-20260517    gcc-9.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-12.5.0
parisc                randconfig-001-20260516    gcc-12.5.0
parisc                randconfig-001-20260517    gcc-10.5.0
parisc                         randconfig-002    gcc-12.5.0
parisc                randconfig-002-20260516    gcc-12.5.0
parisc                randconfig-002-20260517    gcc-10.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                      ppc44x_defconfig    clang-23
powerpc                        randconfig-001    gcc-12.5.0
powerpc               randconfig-001-20260516    gcc-12.5.0
powerpc               randconfig-001-20260517    gcc-10.5.0
powerpc                        randconfig-002    gcc-12.5.0
powerpc               randconfig-002-20260516    gcc-12.5.0
powerpc               randconfig-002-20260517    gcc-10.5.0
powerpc64                      randconfig-001    gcc-12.5.0
powerpc64             randconfig-001-20260516    gcc-12.5.0
powerpc64             randconfig-001-20260517    gcc-10.5.0
powerpc64                      randconfig-002    gcc-12.5.0
powerpc64             randconfig-002-20260516    gcc-12.5.0
powerpc64             randconfig-002-20260517    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_k210_defconfig    clang-23
riscv                          randconfig-001    gcc-15.2.0
riscv                 randconfig-001-20260516    gcc-15.2.0
riscv                 randconfig-001-20260517    gcc-10.5.0
riscv                          randconfig-002    gcc-15.2.0
riscv                 randconfig-002-20260516    gcc-15.2.0
riscv                 randconfig-002-20260517    gcc-10.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                           randconfig-001    gcc-15.2.0
s390                  randconfig-001-20260516    gcc-15.2.0
s390                  randconfig-001-20260517    gcc-10.5.0
s390                           randconfig-002    gcc-15.2.0
s390                  randconfig-002-20260516    gcc-15.2.0
s390                  randconfig-002-20260517    gcc-10.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                             randconfig-001    gcc-15.2.0
sh                    randconfig-001-20260516    gcc-15.2.0
sh                    randconfig-001-20260517    gcc-10.5.0
sh                             randconfig-002    gcc-15.2.0
sh                    randconfig-002-20260516    gcc-15.2.0
sh                    randconfig-002-20260517    gcc-10.5.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-8.5.0
sparc                 randconfig-001-20260516    gcc-8.5.0
sparc                 randconfig-001-20260517    gcc-8.5.0
sparc                          randconfig-002    gcc-8.5.0
sparc                 randconfig-002-20260516    gcc-8.5.0
sparc                 randconfig-002-20260517    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-8.5.0
sparc64               randconfig-001-20260516    gcc-8.5.0
sparc64               randconfig-001-20260517    gcc-8.5.0
sparc64                        randconfig-002    gcc-8.5.0
sparc64               randconfig-002-20260516    gcc-8.5.0
sparc64               randconfig-002-20260517    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-8.5.0
um                    randconfig-001-20260516    gcc-8.5.0
um                    randconfig-001-20260517    gcc-8.5.0
um                             randconfig-002    gcc-8.5.0
um                    randconfig-002-20260516    gcc-8.5.0
um                    randconfig-002-20260517    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260516    gcc-14
x86_64      buildonly-randconfig-001-20260517    gcc-14
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260516    gcc-14
x86_64      buildonly-randconfig-002-20260517    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260516    gcc-14
x86_64      buildonly-randconfig-003-20260517    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260516    gcc-14
x86_64      buildonly-randconfig-004-20260517    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260516    gcc-14
x86_64      buildonly-randconfig-005-20260517    gcc-14
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260516    gcc-14
x86_64      buildonly-randconfig-006-20260517    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                         randconfig-001    gcc-14
x86_64                randconfig-001-20260516    gcc-14
x86_64                randconfig-001-20260517    clang-20
x86_64                         randconfig-002    gcc-14
x86_64                randconfig-002-20260516    gcc-14
x86_64                randconfig-002-20260517    clang-20
x86_64                         randconfig-003    gcc-14
x86_64                randconfig-003-20260516    gcc-14
x86_64                randconfig-003-20260517    clang-20
x86_64                         randconfig-004    gcc-14
x86_64                randconfig-004-20260516    gcc-14
x86_64                randconfig-004-20260517    clang-20
x86_64                         randconfig-005    gcc-14
x86_64                randconfig-005-20260516    gcc-14
x86_64                randconfig-005-20260517    clang-20
x86_64                         randconfig-006    gcc-14
x86_64                randconfig-006-20260516    gcc-14
x86_64                randconfig-006-20260517    clang-20
x86_64                         randconfig-011    clang-20
x86_64                randconfig-011-20260516    clang-20
x86_64                randconfig-011-20260517    gcc-14
x86_64                         randconfig-012    clang-20
x86_64                randconfig-012-20260516    clang-20
x86_64                randconfig-012-20260517    gcc-14
x86_64                         randconfig-013    clang-20
x86_64                randconfig-013-20260516    clang-20
x86_64                randconfig-013-20260517    gcc-14
x86_64                         randconfig-014    clang-20
x86_64                randconfig-014-20260516    clang-20
x86_64                randconfig-014-20260517    gcc-14
x86_64                         randconfig-015    clang-20
x86_64                randconfig-015-20260516    clang-20
x86_64                randconfig-015-20260517    gcc-14
x86_64                         randconfig-016    clang-20
x86_64                randconfig-016-20260516    clang-20
x86_64                randconfig-016-20260517    gcc-14
x86_64                         randconfig-071    gcc-14
x86_64                randconfig-071-20260516    gcc-14
x86_64                randconfig-071-20260517    clang-20
x86_64                         randconfig-072    gcc-14
x86_64                randconfig-072-20260516    gcc-14
x86_64                randconfig-072-20260517    clang-20
x86_64                         randconfig-073    gcc-14
x86_64                randconfig-073-20260516    gcc-14
x86_64                randconfig-073-20260517    clang-20
x86_64                         randconfig-074    gcc-14
x86_64                randconfig-074-20260516    gcc-14
x86_64                randconfig-074-20260517    clang-20
x86_64                         randconfig-075    gcc-14
x86_64                randconfig-075-20260516    gcc-14
x86_64                randconfig-075-20260517    clang-20
x86_64                         randconfig-076    gcc-14
x86_64                randconfig-076-20260516    gcc-14
x86_64                randconfig-076-20260517    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                         randconfig-001    gcc-8.5.0
xtensa                randconfig-001-20260516    gcc-8.5.0
xtensa                randconfig-001-20260517    gcc-8.5.0
xtensa                         randconfig-002    gcc-8.5.0
xtensa                randconfig-002-20260516    gcc-8.5.0
xtensa                randconfig-002-20260517    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

