Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11252C88E77
	for <kexec@archiver.kernel.org>; Wed, 16 Sep 2026 05:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=t011KSezCPJvaXwB5p8rV1/Y9bZmI+SPrmyPqQwb0LY=; b=lNZlS/g22/vSoHTd751W2OSJcu
	AjubTN6ceSSRpm2yrmyjBjjgvLwpCnLhWyhXi/ZJw+Qrd3TSTRv2DbOOraTITwQDr7QxdmJ+dGpb5
	kMVFKTP5eQMBw2QW5nHQmTkxTqT7sEjfuVF4YsboelVsExQra8GggiUp7dISvVB0mNIkuCQllHfSF
	2NUhzIGhukWRIH9QybEr+XnIIU8FFdv/YuWd5HjfV1DhUeKiinN7+LmHWK9nV3rVbwufzMrRBSNH9
	JYrNWAvzI22kMofTdilO+PM9FxlwSAhlo5fqQ+8Bk2VL8sSYXwej6NH/+ivhSp61vMlrwORlHKOxx
	yTw0HrAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6iWv-00000008Pq0-2L9T;
	Wed, 16 Sep 2026 05:50:01 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6iWt-00000008Pp3-2Zu3
	for kexec@lists.infradead.org;
	Wed, 16 Sep 2026 05:50:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789537799; x=1821073799;
  h=date:from:to:cc:subject:message-id;
  bh=owqlOLgC2lPJvF4PYonezBeEoX28PpNVxNQqD7A6FaI=;
  b=mgHyh/HpGmK5XpxuOJ9RPB6xxVuUCFqszZCef0Ekk9Dx9FXGdZaYljTQ
   x9LacGVfxbSyrgPvDuUHhcyQecDs5T6Pf5GUD878sbOR3Uz5JFq7/dHod
   cGN7E7wIod5xGgSBbUeBuq9FG9/QBx/aIytGyj3O6o7YNKgCdWlAjzQGg
   Z4zgzpVoHRE7lwtDXSMvAC9P1oIqpIbi1aXU9eHEfRK2/LmmYQ6OBAqMl
   3/5BSEPsKDLggs2yXVwepo52lHpbmmeEcKzk1pMWmmlXf2DnokBlIRSDY
   kLtPDgWU3QYv85WcU43IVhGBskwtX9AM22BlgdjWPdEi3kZvCzejuIPGD
   Q==;
X-CSE-ConnectionGUID: OwIKN4FzSp+F6V4XZCK4fg==
X-CSE-MsgGUID: xwGvGnfDR9yqp76SvoQBgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92416421"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="92416421"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 22:49:59 -0700
X-CSE-ConnectionGUID: 1zOrqLr3RUGWjh7CjMR0XA==
X-CSE-MsgGUID: HC2qYoQrSkC9UPVtghJcpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269966898"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 15 Sep 2026 22:49:57 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x6iWo-000000005Ym-3yXI;
	Wed, 16 Sep 2026 05:49:54 +0000
Date: Wed, 16 Sep 2026 13:49:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:next] BUILD SUCCESS
 25c3605f491885d69e3d1006f02fa61ab7e0976f
Message-ID: <202609161342.iDyWF2YT-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_224959_675741_F9EB65A0 
X-CRM114-Status: UNSURE (   3.84  )
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
branch HEAD: 25c3605f491885d69e3d1006f02fa61ab7e0976f  Merge branch 'luo-internal-api' into next

elapsed time: m

configs tested: 361
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
alpha                randconfig-r061-20260914    gcc-16.1.0
alpha                randconfig-r073-20260915    gcc-14.3.0
arc                              allmodconfig    clang-24
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-24
arc                                 defconfig    gcc-16.1.0
arc                 nsimosci_hs_smp_defconfig    clang-20
arc                   randconfig-001-20260916    clang-24
arc                   randconfig-002-20260916    clang-24
arc                  randconfig-r054-20260914    gcc-8.5.0
arc                  randconfig-r063-20260914    gcc-16.1.0
arc                  randconfig-r132-20260915    gcc-12.5.0 sparse
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-24
arm                                 defconfig    gcc-16.1.0
arm                           h3600_defconfig    gcc-16.1.0
arm                            mps2_defconfig    clang-24
arm                       multi_v4t_defconfig    clang-24
arm                         nhk8815_defconfig    clang-24
arm                   randconfig-001-20260916    clang-24
arm                   randconfig-002-20260916    clang-24
arm                   randconfig-003-20260916    clang-24
arm                   randconfig-004-20260916    clang-24
arm                  randconfig-r053-20260914    clang-17
arm                  randconfig-r061-20260915    clang-22
arm                  randconfig-r111-20260916    clang-22 sparse
arm                  randconfig-r133-20260916    gcc-16.1.0 sparse
arm                           tegra_defconfig    clang-20
arm64                            allmodconfig    clang-24
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260916    gcc-16.1.0
arm64                 randconfig-002-20260916    gcc-16.1.0
arm64                 randconfig-003-20260916    gcc-16.1.0
arm64                 randconfig-004-20260916    gcc-16.1.0
arm64                randconfig-r052-20260914    gcc-11.5.0
arm64                randconfig-r052-20260914    gcc-8.5.0
arm64                randconfig-r064-20260915    clang-22
arm64                randconfig-r073-20260914    gcc-12.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260916    gcc-16.1.0
csky                  randconfig-002-20260916    gcc-16.1.0
csky                 randconfig-r052-20260914    clang-17
csky                 randconfig-r054-20260914    gcc-14
csky                 randconfig-r062-20260914    gcc-10.5.0
csky                 randconfig-r063-20260914    gcc-16.1.0
csky                 randconfig-r073-20260914    gcc-11.5.0
csky                 randconfig-r111-20260916    clang-24 sparse
csky                 randconfig-r121-20260916    clang-22 sparse
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260916    gcc-16.1.0
hexagon               randconfig-002-20260916    gcc-16.1.0
hexagon              randconfig-r052-20260914    clang-17
hexagon              randconfig-r061-20260914    clang-22
hexagon              randconfig-r071-20260914    clang-24
hexagon              randconfig-r073-20260914    clang-24
i386                              allnoconfig    gcc-16.1.0
i386        buildonly-randconfig-001-20260916    clang-22
i386        buildonly-randconfig-002-20260916    clang-22
i386        buildonly-randconfig-003-20260916    clang-22
i386        buildonly-randconfig-004-20260916    clang-22
i386        buildonly-randconfig-005-20260916    clang-22
i386        buildonly-randconfig-006-20260916    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260916    gcc-14
i386                  randconfig-002-20260916    gcc-14
i386                  randconfig-003-20260916    gcc-14
i386                  randconfig-004-20260916    gcc-14
i386                  randconfig-005-20260916    gcc-14
i386                  randconfig-006-20260916    gcc-14
i386                  randconfig-007-20260916    gcc-14
i386                  randconfig-011-20260916    clang-22
i386                  randconfig-012-20260916    clang-22
i386                  randconfig-013-20260916    clang-22
i386                  randconfig-014-20260916    clang-22
i386                  randconfig-015-20260916    clang-22
i386                  randconfig-016-20260916    clang-22
i386                  randconfig-017-20260916    clang-22
i386                  randconfig-051-20260914    clang-22
i386                  randconfig-051-20260914    gcc-14
i386                  randconfig-051-20260915    clang-22
i386                  randconfig-052-20260914    clang-22
i386                  randconfig-052-20260915    clang-22
i386                  randconfig-053-20260914    clang-22
i386                  randconfig-053-20260914    gcc-14
i386                  randconfig-053-20260915    clang-22
i386                  randconfig-054-20260914    clang-22
i386                  randconfig-054-20260914    gcc-14
i386                  randconfig-054-20260915    clang-22
i386                  randconfig-061-20260915    gcc-14 sparse
i386                  randconfig-062-20260915    gcc-14 sparse
i386                  randconfig-063-20260915    gcc-14 sparse
i386                  randconfig-141-20260914    gcc-14
i386                  randconfig-141-20260915    clang-22
i386                 randconfig-r054-20260914    clang-22
i386                 randconfig-r062-20260914    gcc-14
i386                 randconfig-r072-20260914    clang-22
i386                 randconfig-r131-20260916    gcc-16.1.0 sparse
loongarch                        allmodconfig    clang-24
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-24
loongarch             randconfig-001-20260916    gcc-16.1.0
loongarch             randconfig-002-20260916    gcc-16.1.0
loongarch            randconfig-r051-20260914    gcc-15.2.0
loongarch            randconfig-r054-20260915    clang-22
loongarch            randconfig-r062-20260914    gcc-16.1.0
loongarch            randconfig-r063-20260914    gcc-14
loongarch            randconfig-r071-20260914    clang-19
loongarch            randconfig-r072-20260914    clang-24
loongarch            randconfig-r073-20260914    clang-22
loongarch            randconfig-r111-20260916    gcc-12.5.0 sparse
loongarch            randconfig-r121-20260916    gcc-12.5.0 sparse
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-24
m68k                                defconfig    clang-24
m68k                       m5329evb_defconfig    clang-20
m68k                 randconfig-r061-20260914    gcc-9.5.0
m68k                 randconfig-r063-20260914    gcc-14
m68k                 randconfig-r064-20260914    gcc-9.5.0
m68k                 randconfig-r071-20260914    gcc-14.3.0
m68k                 randconfig-r072-20260914    gcc-8.5.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-24
microblaze           randconfig-r053-20260915    clang-22
microblaze           randconfig-r122-20260916    clang-22 sparse
microblaze           randconfig-r134-20260915    gcc-12.5.0 sparse
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                           ip22_defconfig    gcc-16.1.0
mips                 randconfig-r051-20260914    clang-22
mips                 randconfig-r064-20260914    gcc-16.1.0
mips                 randconfig-r113-20260916    clang-24 sparse
mips                 randconfig-r123-20260916    gcc-12.5.0 sparse
mips                           rs90_defconfig    gcc-16.1.0
mips                        vocore2_defconfig    clang-20
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-24
nios2                               defconfig    clang-24
nios2                 randconfig-001-20260916    gcc-16.1.0
nios2                 randconfig-002-20260916    gcc-16.1.0
nios2                randconfig-r051-20260914    gcc-11.5.0
nios2                randconfig-r053-20260914    clang-22
nios2                randconfig-r053-20260914    gcc-15.2.0
nios2                randconfig-r062-20260914    gcc-16.1.0
nios2                randconfig-r064-20260914    gcc-14
nios2                randconfig-r073-20260914    gcc-11.5.0
openrisc                         alldefconfig    clang-24
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-24
openrisc                            defconfig    gcc-16.1.0
openrisc             randconfig-r064-20260914    gcc-10.5.0
openrisc             randconfig-r133-20260915    gcc-12.5.0 sparse
openrisc             randconfig-r134-20260916    gcc-16.1.0 sparse
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-24
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260915    gcc-8.5.0
parisc                randconfig-001-20260916    clang-24
parisc                randconfig-002-20260915    gcc-8.5.0
parisc                randconfig-002-20260916    clang-24
parisc               randconfig-r062-20260914    gcc-9.5.0
parisc               randconfig-r071-20260914    gcc-13.4.0
parisc               randconfig-r072-20260915    gcc-8.5.0
parisc               randconfig-r122-20260916    gcc-12.5.0 sparse
parisc               randconfig-r123-20260916    clang-22 sparse
parisc               randconfig-r132-20260916    gcc-11.5.0 sparse
parisc64                         alldefconfig    clang-20
parisc64                            defconfig    clang-24
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-24
powerpc                        cell_defconfig    gcc-16.1.0
powerpc                   currituck_defconfig    clang-20
powerpc                 linkstation_defconfig    gcc-16.1.0
powerpc                     mpc512x_defconfig    clang-20
powerpc                 mpc836x_rdk_defconfig    clang-24
powerpc               randconfig-001-20260915    gcc-8.5.0
powerpc               randconfig-001-20260916    clang-24
powerpc               randconfig-002-20260915    gcc-8.5.0
powerpc               randconfig-002-20260916    clang-24
powerpc              randconfig-r053-20260914    gcc-11.5.0
powerpc              randconfig-r054-20260914    gcc-15.2.0
powerpc              randconfig-r063-20260914    clang-22
powerpc              randconfig-r071-20260914    clang-24
powerpc              randconfig-r072-20260914    clang-20
powerpc              randconfig-r113-20260916    gcc-12.5.0 sparse
powerpc              randconfig-r122-20260916    clang-24 sparse
powerpc                         wii_defconfig    gcc-16.1.0
powerpc64             randconfig-001-20260915    gcc-8.5.0
powerpc64             randconfig-001-20260916    clang-24
powerpc64             randconfig-002-20260915    gcc-8.5.0
powerpc64             randconfig-002-20260916    clang-24
powerpc64            randconfig-r051-20260914    gcc-8.5.0
powerpc64            randconfig-r053-20260914    gcc-8.5.0
powerpc64            randconfig-r112-20260916    clang-22 sparse
powerpc64            randconfig-r112-20260916    gcc-12.5.0 sparse
riscv                            allmodconfig    clang-24
riscv                             allnoconfig    clang-24
riscv                            allyesconfig    clang-24
riscv                               defconfig    gcc-16.1.0
riscv             nommu_k210_sdcard_defconfig    clang-24
riscv                 randconfig-001-20260916    gcc-16.1.0
riscv                 randconfig-002-20260916    gcc-16.1.0
riscv                randconfig-r061-20260914    gcc-13.4.0
riscv                randconfig-r063-20260914    gcc-9.5.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-24
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260916    gcc-16.1.0
s390                  randconfig-002-20260916    gcc-16.1.0
s390                 randconfig-r051-20260914    clang-17
s390                 randconfig-r063-20260915    clang-22
s390                 randconfig-r064-20260914    gcc-14
s390                 randconfig-r071-20260914    clang-24
s390                 randconfig-r133-20260916    gcc-11.5.0 sparse
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-24
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                          lboxre2_defconfig    gcc-16.1.0
sh                    randconfig-001-20260916    gcc-16.1.0
sh                    randconfig-002-20260916    gcc-16.1.0
sh                   randconfig-r051-20260914    clang-17
sh                   randconfig-r051-20260915    clang-22
sh                   randconfig-r052-20260914    gcc-14
sh                   randconfig-r054-20260914    clang-17
sh                   randconfig-r123-20260916    clang-24 sparse
sh                          sdk7786_defconfig    clang-20
sh                           se7751_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-24
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260915    gcc-13.4.0
sparc                 randconfig-001-20260916    gcc-14.3.0
sparc                 randconfig-002-20260915    gcc-13.4.0
sparc                 randconfig-002-20260916    gcc-14.3.0
sparc                randconfig-r052-20260914    gcc-15.2.0
sparc                randconfig-r062-20260914    gcc-14
sparc                randconfig-r064-20260914    gcc-16.1.0
sparc                randconfig-r073-20260914    gcc-15.2.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260915    gcc-13.4.0
sparc64               randconfig-001-20260916    gcc-14.3.0
sparc64               randconfig-002-20260915    gcc-13.4.0
sparc64               randconfig-002-20260916    gcc-14.3.0
sparc64              randconfig-r052-20260914    clang-22
sparc64              randconfig-r064-20260914    clang-22
sparc64              randconfig-r072-20260914    clang-24
sparc64              randconfig-r073-20260914    clang-24
sparc64              randconfig-r112-20260916    clang-24 sparse
sparc64              randconfig-r134-20260916    gcc-11.5.0 sparse
um                               allmodconfig    clang-17
um                                allnoconfig    clang-24
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260915    gcc-13.4.0
um                    randconfig-001-20260916    gcc-14.3.0
um                    randconfig-002-20260915    gcc-13.4.0
um                    randconfig-002-20260916    gcc-14.3.0
um                   randconfig-r053-20260914    gcc-14
um                   randconfig-r054-20260914    clang-24
um                   randconfig-r054-20260914    gcc-11.5.0
um                   randconfig-r121-20260916    clang-24 sparse
um                   randconfig-r131-20260915    gcc-12.5.0 sparse
um                   randconfig-r132-20260916    gcc-16.1.0 sparse
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-24
x86_64      buildonly-randconfig-001-20260915    clang-22
x86_64      buildonly-randconfig-002-20260915    clang-22
x86_64      buildonly-randconfig-003-20260915    clang-22
x86_64      buildonly-randconfig-004-20260915    clang-22
x86_64      buildonly-randconfig-005-20260915    clang-22
x86_64      buildonly-randconfig-006-20260915    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260915    clang-22
x86_64                randconfig-001-20260916    clang-22
x86_64                randconfig-002-20260915    clang-22
x86_64                randconfig-002-20260916    clang-22
x86_64                randconfig-003-20260915    clang-22
x86_64                randconfig-003-20260916    clang-22
x86_64                randconfig-004-20260915    clang-22
x86_64                randconfig-004-20260916    clang-22
x86_64                randconfig-005-20260915    clang-22
x86_64                randconfig-005-20260916    clang-22
x86_64                randconfig-006-20260915    clang-22
x86_64                randconfig-006-20260916    clang-22
x86_64                randconfig-011-20260915    gcc-14
x86_64                randconfig-011-20260916    gcc-14
x86_64                randconfig-012-20260915    gcc-14
x86_64                randconfig-012-20260916    gcc-14
x86_64                randconfig-013-20260915    gcc-14
x86_64                randconfig-013-20260916    gcc-14
x86_64                randconfig-014-20260915    gcc-14
x86_64                randconfig-014-20260916    gcc-14
x86_64                randconfig-015-20260915    gcc-14
x86_64                randconfig-015-20260916    gcc-14
x86_64                randconfig-016-20260915    gcc-14
x86_64                randconfig-016-20260916    gcc-14
x86_64                randconfig-071-20260916    gcc-14
x86_64                randconfig-072-20260916    gcc-14
x86_64                randconfig-073-20260916    gcc-14
x86_64                randconfig-074-20260916    gcc-14
x86_64                randconfig-075-20260916    gcc-14
x86_64                randconfig-076-20260916    gcc-14
x86_64                randconfig-101-20260914    gcc-14
x86_64                randconfig-101-20260915    clang-22
x86_64                randconfig-102-20260914    clang-22
x86_64                randconfig-102-20260914    gcc-14
x86_64                randconfig-102-20260915    clang-22
x86_64                randconfig-103-20260914    gcc-14
x86_64                randconfig-103-20260915    clang-22
x86_64                randconfig-104-20260914    gcc-14
x86_64                randconfig-104-20260915    clang-22
x86_64                randconfig-121-20260915    gcc-14 sparse
x86_64                randconfig-122-20260915    gcc-14 sparse
x86_64                randconfig-123-20260915    gcc-14 sparse
x86_64                randconfig-161-20260914    clang-22
x86_64                randconfig-161-20260915    clang-22
x86_64               randconfig-r051-20260914    gcc-14
x86_64               randconfig-r052-20260915    clang-22
x86_64               randconfig-r061-20260914    gcc-14
x86_64               randconfig-r062-20260914    clang-22
x86_64               randconfig-r062-20260915    clang-22
x86_64               randconfig-r063-20260914    gcc-16.1.0
x86_64               randconfig-r071-20260915    clang-22
x86_64               randconfig-r113-20260916    clang-22 sparse
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    clang-22
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-24
xtensa                           allyesconfig    clang-20
xtensa                          iss_defconfig    clang-24
xtensa                randconfig-001-20260915    gcc-13.4.0
xtensa                randconfig-001-20260916    gcc-14.3.0
xtensa                randconfig-002-20260915    gcc-13.4.0
xtensa                randconfig-002-20260916    gcc-14.3.0
xtensa               randconfig-r053-20260914    gcc-10.5.0
xtensa               randconfig-r061-20260914    gcc-16.1.0
xtensa               randconfig-r131-20260916    gcc-11.5.0 sparse
xtensa                    smp_lx200_defconfig    clang-24

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

