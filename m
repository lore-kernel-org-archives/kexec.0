Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF95C98306
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 19:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FSe4JpIXfvsGmRLI/OraFimZ2DIqJWxMJumOwGaXd88=; b=f6gg8mga27ihHs+5NUpd8qdNmG
	rB6dRiIuF7ZMGbeZ8w4sI4UDef44TWoz81w6a1WEHCZMFJarc3BkgmV0Fx2X8voyGADWLpRHH247E
	Kmm3e0Nvyt4FS3PpI1XOKpcxczQlqTUW6FdyO54O7WqWG1OFUvfMM2VwD8JG+6aOXKun2YdGxODcI
	uJbz+MJFfJ9EBrfdTOxKJ4IELWbXEmIKzEMCYLkIZorJgTPcuTdtpHbvXyB1vThBii+OeOid5GAAV
	hAZmcSnRfA1cTWhuqVVajiwUdi3eyFbud8tG99KcfXfjnFBsfaaHuvvkI68jWa9bDVvAfKRBJ4d4Y
	lxVvqLFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9675-00000006P3D-45mi;
	Tue, 22 Sep 2026 19:25:11 +0000
Received: from mgamail.intel.com ([192.198.163.15])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9672-00000006P1N-3eJR
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 19:25:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790105109; x=1821641109;
  h=date:from:to:cc:subject:message-id;
  bh=EbqnkDgvNfyxDoVMKlHYETGoX9L6d6RiUhs8kQqumSs=;
  b=i+241NsCmu8BM/Rk38oSsrZTVYBapXtDr/lS/nwfGeqi+WTag3L/mlGN
   qIQUyTM3qy5/3kInvyB+ejGjUKbjH5RSr9v4352PuefhLOYCRS08xTyir
   zBGS1K5XuKuZbTkQAxlLpWtlC5hxgi/XdoW0I10FsscsBqLd9pV/HKewf
   b6dCwt1slf98ERBCBie7sgc6rxSJj7Rdq1BapMeqKxXphHXTzDJvoFOjw
   fL3rnuVBDF/8bukxGm4KuOTJ/NFyPcdvkk8KbWPf2ymxZCH0wWiYEDCmc
   dtzoMhaorvsm0b+2imGqm9zaknsu+Gz0+9pM7vwnV9oPJTkghD3qIbQR8
   Q==;
X-CSE-ConnectionGUID: fp0jYfkuQ/ihfC+ZLhlf6Q==
X-CSE-MsgGUID: oCZOg13GSliLGs3vX6C7sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90858110"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="90858110"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 12:25:03 -0700
X-CSE-ConnectionGUID: zO/y+uP1QzmBjq2agLsNEg==
X-CSE-MsgGUID: lJEnA6sAQG27SdLrCtXY2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="4283446"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa012.fm.intel.com with ESMTP; 22 Sep 2026 12:25:01 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x966s-00000000Fyw-2J73;
	Tue, 22 Sep 2026 19:24:58 +0000
Date: Wed, 23 Sep 2026 03:24:47 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:kexec-next] BUILD SUCCESS
 336ecc11f05b02b130e364a10336e17dac111404
Message-ID: <202609230339.R0BCGlJt-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_122508_964371_3F779BCE 
X-CRM114-Status: UNSURE (   3.98  )
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
branch HEAD: 336ecc11f05b02b130e364a10336e17dac111404  Merge branch 'kexec-7.4' into kexec-next

elapsed time: 4572m

configs tested: 268
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r1308-20260922    gcc-12.5.0 sparse
alpha                randconfig-r2101-20260918    clang-22   cocci
arc                               allmodconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260922    gcc-8.5.0
arc                   randconfig-1001-20260922    gcc-16.1.0
arc                  randconfig-r2107-20260918    clang-24   cocci
arm                                allnoconfig    clang-17
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    gcc-16.1.0
arm                                  defconfig    clang-24
arm                         multi_v5_defconfig    gcc-16.1.0
arm                         multi_v7_defconfig    clang-20
arm                          nhk8815_defconfig    clang-24
arm                   randconfig-1000-20260922    gcc-16.1.0
arm                   randconfig-1001-20260922    gcc-10.5.0
arm                   randconfig-1002-20260922    clang-24
arm                   randconfig-1003-20260922    gcc-8.5.0
arm                         spear3xx_defconfig    clang-20
arm                         vexpress_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260922    clang-24
arm64                 randconfig-1001-20260922    gcc-11.5.0
arm64                 randconfig-1002-20260922    gcc-9.5.0
arm64                 randconfig-1003-20260922    gcc-11.5.0
arm64                randconfig-r1309-20260922    clang-17   sparse
arm64                randconfig-r2105-20260918    gcc-11.5.0 cocci
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260922    gcc-16.1.0
csky                  randconfig-1001-20260922    gcc-12.5.0
csky                 randconfig-r1303-20260922    gcc-16.1.0 sparse
hexagon                           allmodconfig    clang-24
hexagon                            allnoconfig    clang-24
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    clang-24
hexagon               randconfig-1000-20260922    clang-17
hexagon               randconfig-1001-20260922    clang-17
hexagon              randconfig-r1305-20260922    clang-19   sparse
i386                              allmodconfig    gcc-14
i386                               allnoconfig    gcc-14
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    gcc-14
i386        buildonly-randconfig-1000-20260922    clang-22
i386        buildonly-randconfig-1001-20260922    clang-22
i386        buildonly-randconfig-1002-20260922    gcc-14
i386        buildonly-randconfig-1003-20260922    gcc-14
i386        buildonly-randconfig-1004-20260922    gcc-14
i386        buildonly-randconfig-1005-20260922    gcc-12
i386                                 defconfig    clang-22
i386                  randconfig-1000-20260922    clang-22
i386                  randconfig-1001-20260922    clang-22
i386                  randconfig-1002-20260922    clang-22
i386                  randconfig-1003-20260922    gcc-14
i386                  randconfig-1004-20260922    gcc-14
i386                  randconfig-1005-20260922    gcc-14
i386                  randconfig-1006-20260922    gcc-14
i386                  randconfig-1007-20260922    clang-22
i386                  randconfig-1008-20260922    gcc-14
i386                  randconfig-1009-20260922    gcc-14
i386                  randconfig-1010-20260922    clang-22
i386                  randconfig-1011-20260922    gcc-14
i386                  randconfig-1012-20260922    gcc-13
i386                  randconfig-1013-20260922    gcc-14
i386                  randconfig-2100-20260918    clang-22   cocci
i386                  randconfig-2101-20260918    clang-22   cocci
i386                  randconfig-2102-20260918    clang-22   cocci
i386                  randconfig-2103-20260918    clang-22   cocci
i386                  randconfig-2200-20260918    clang-22   smatch
loongarch                         allmodconfig    clang-19
loongarch                          allnoconfig    clang-20
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260922    gcc-16.1.0
loongarch             randconfig-1001-20260922    clang-18
loongarch            randconfig-r2107-20260918    gcc-11.5.0 cocci
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                                 defconfig    gcc-16.1.0
m68k                        m5475evb_defconfig    clang-20
m68k                 randconfig-r1300-20260922    gcc-12.5.0 sparse
microblaze                        alldefconfig    clang-24
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze                           defconfig    gcc-16.1.0
microblaze           randconfig-r2100-20260918    clang-24   cocci
microblaze           randconfig-r2202-20260918    gcc-12.5.0 smatch
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                         bcm47xx_defconfig    clang-24
mips                            mtx1_defconfig    clang-19
mips                         qi_lb60_defconfig    clang-24
mips                 randconfig-r2103-20260918    clang-24   cocci
mips                 randconfig-r2202-20260918    gcc-15.2.0 smatch
mips                    sb1250_swarm_defconfig    clang-24
nios2                             allmodconfig    gcc-11.5.0
nios2                              allnoconfig    clang-24
nios2                              allnoconfig    gcc-11.5.0
nios2                                defconfig    clang-24
nios2                                defconfig    gcc-11.5.0
nios2                 randconfig-1000-20260922    gcc-10.5.0
nios2                 randconfig-1001-20260922    gcc-11.5.0
nios2                randconfig-r1304-20260922    gcc-11.5.0 sparse
nios2                randconfig-r2106-20260918    gcc-11.5.0 cocci
openrisc                          allmodconfig    gcc-16.1.0
openrisc                           allnoconfig    clang-24
openrisc                           allnoconfig    gcc-16.1.0
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2101-20260918    clang-24   cocci
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                             allnoconfig    gcc-16.1.0
parisc                            allyesconfig    gcc-16.1.0
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260922    gcc-12.5.0
parisc                randconfig-1000-20260923    clang-22
parisc                randconfig-1001-20260922    gcc-10.5.0
parisc                randconfig-1001-20260923    clang-22
parisc               randconfig-r1307-20260922    gcc-15.2.0 sparse
parisc64                             defconfig    clang-24
parisc64                             defconfig    gcc-16.1.0
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                            allnoconfig    gcc-16.1.0
powerpc                      mpc83xx_defconfig    clang-24
powerpc               randconfig-1000-20260922    gcc-11.5.0
powerpc               randconfig-1000-20260923    clang-22
powerpc               randconfig-1001-20260922    gcc-8.5.0
powerpc               randconfig-1001-20260923    clang-22
powerpc              randconfig-r2105-20260918    clang-24   cocci
powerpc                     socrates_defconfig    clang-24
powerpc                   storcenter_defconfig    clang-20
powerpc                       tqm8xx_defconfig    clang-20
powerpc64             randconfig-1000-20260922    gcc-8.5.0
powerpc64             randconfig-1000-20260923    clang-22
powerpc64             randconfig-1001-20260922    gcc-11.5.0
powerpc64             randconfig-1001-20260923    clang-22
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                              allnoconfig    gcc-16.1.0
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-24
riscv                 randconfig-1000-20260922    gcc-8.5.0
riscv                 randconfig-1001-20260922    gcc-13.4.0
riscv                 randconfig-2000-20260918    gcc-13.4.0
riscv                 randconfig-2001-20260918    gcc-13.4.0
riscv                randconfig-r2102-20260918    clang-22   cocci
s390                              allmodconfig    clang-24
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    clang-18
s390                  randconfig-1000-20260922    clang-19
s390                  randconfig-1001-20260922    clang-21
s390                  randconfig-2000-20260918    gcc-13.4.0
s390                  randconfig-2001-20260918    gcc-13.4.0
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                 allnoconfig    gcc-16.1.0
sh                                allyesconfig    gcc-16.1.0
sh                                   defconfig    gcc-16.1.0
sh                          ecovec24_defconfig    clang-24
sh                           r7785rp_defconfig    clang-20
sh                    randconfig-1000-20260922    gcc-10.5.0
sh                    randconfig-1001-20260922    gcc-16.1.0
sh                    randconfig-2000-20260918    gcc-13.4.0
sh                    randconfig-2001-20260918    gcc-13.4.0
sh                   randconfig-r2200-20260918    gcc-16.1.0 smatch
sh                            se7343_defconfig    clang-20
sh                            se7619_defconfig    gcc-16.1.0
sh                            se7751_defconfig    gcc-16.1.0
sh                             titan_defconfig    gcc-16.1.0
sh                           urquell_defconfig    gcc-16.1.0
sparc                             alldefconfig    clang-20
sparc                              allnoconfig    clang-24
sparc                              allnoconfig    gcc-16.1.0
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260922    gcc-14.3.0
sparc                 randconfig-1001-20260922    gcc-8.5.0
sparc                 randconfig-2000-20260918    gcc-14
sparc                 randconfig-2001-20260918    gcc-14
sparc                randconfig-r2104-20260918    clang-24   cocci
sparc                randconfig-r2106-20260918    clang-24   cocci
sparc                randconfig-r2200-20260918    gcc-8.5.0  smatch
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    clang-24
sparc64               randconfig-1000-20260922    gcc-15.2.0
sparc64               randconfig-1001-20260922    clang-20
sparc64               randconfig-2000-20260918    gcc-14
sparc64               randconfig-2001-20260918    gcc-14
sparc64              randconfig-r1301-20260922    clang-20   sparse
sparc64              randconfig-r2102-20260918    clang-24   cocci
sparc64              randconfig-r2103-20260918    clang-22   cocci
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-14
um                                   defconfig    clang-24
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260922    gcc-14
um                    randconfig-1001-20260922    clang-17
um                    randconfig-2000-20260918    gcc-14
um                    randconfig-2001-20260918    gcc-14
um                   randconfig-r2104-20260918    gcc-11.5.0 cocci
um                   randconfig-r2201-20260918    gcc-14     smatch
um                            x86_64_defconfig    clang-24
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20260922    gcc-14
x86_64      buildonly-randconfig-1001-20260922    gcc-14
x86_64      buildonly-randconfig-1002-20260922    gcc-14
x86_64      buildonly-randconfig-1003-20260922    clang-22
x86_64      buildonly-randconfig-1004-20260922    clang-22
x86_64      buildonly-randconfig-1005-20260922    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260922    gcc-12
x86_64                randconfig-1001-20260922    clang-22
x86_64                randconfig-1002-20260922    clang-22
x86_64                randconfig-1003-20260922    clang-22
x86_64                randconfig-1004-20260922    clang-22
x86_64                randconfig-1005-20260922    gcc-14
x86_64                randconfig-1006-20260922    clang-22
x86_64                randconfig-1007-20260922    gcc-14
x86_64                randconfig-1008-20260922    clang-22
x86_64                randconfig-1009-20260922    clang-22
x86_64                randconfig-1010-20260922    gcc-14
x86_64                randconfig-1011-20260922    clang-22
x86_64                randconfig-1012-20260922    clang-22
x86_64                randconfig-1013-20260922    gcc-14
x86_64                randconfig-1014-20260922    clang-22
x86_64                randconfig-1015-20260922    clang-22
x86_64                randconfig-1016-20260922    gcc-14
x86_64                randconfig-1017-20260922    clang-22
x86_64                randconfig-2100-20260918    clang-22   cocci
x86_64                randconfig-2101-20260918    clang-22   cocci
x86_64                randconfig-2102-20260918    clang-22   cocci
x86_64                randconfig-2103-20260918    clang-22   cocci
x86_64                randconfig-2200-20260918    gcc-14     smatch
x86_64               randconfig-r1302-20260922    gcc-14     sparse
x86_64               randconfig-r1306-20260922    gcc-14     sparse
x86_64               randconfig-r2100-20260918    clang-22   cocci
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                            rhel-9.4-ltp    clang-22
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                             allnoconfig    gcc-16.1.0
xtensa                            allyesconfig    gcc-16.1.0
xtensa                randconfig-1000-20260922    gcc-12.5.0
xtensa                randconfig-1001-20260922    gcc-10.5.0
xtensa                randconfig-2000-20260918    gcc-14
xtensa                randconfig-2001-20260918    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

