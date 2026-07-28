Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF5DC53219
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 10:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6RHtDpE11lUIUE9uV57ajHVXbZNwavy4YshvyFpCEQY=; b=NXFk2SCydJlvdVCMm/XQd1HXo/
	zLRYBAyLybpstc9/QhOVBKiS7O17WW0nPG8HpG2VX0St8MHYvo5a4WE7gOcSltg09RzyjXr7Vkxsg
	uTMxznkwnCBR1tZ/oJjHpHyz/R7ChJ+9aHaBoIkMI1cP6W7HISolI7P4aAGtA0tRyd8VYl5XqGwgP
	FSfyWEsxj2k/3vrWAsERxRzrR8uyD7ndFcZhd5QKK6inf9fNp2WkDliWGxim5qwr+8ryMPskUdGrd
	oS0DZaH6gMEIgmD5+jAJeS04VGQZUmNwnuuXc9pt6VnR4P47Ofh365w9TzLWaBEt3/eJpw3tM8+NG
	OWcgeNrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wof16-00000004xdT-37aM;
	Tue, 28 Jul 2026 10:26:32 +0000
Received: from mgamail.intel.com ([198.175.65.17])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wof14-00000004xcx-0quE
	for kexec@lists.infradead.org;
	Tue, 28 Jul 2026 10:26:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785234390; x=1816770390;
  h=date:from:to:cc:subject:message-id;
  bh=Jvwi+zsjVg8g9g+h3g/xxKA+IwwtfYO3d/jY2B8a2x0=;
  b=JZMsgLigxxhz4hzzfMy4eEstqPTBd0HXQVHP1uFMGFzt4/rruM/tyQD3
   uKn40HG8c9+RxB30GA1eRY5SJN/bhFpLiyhT0AlznFxn4DVMwV8+oMibT
   5xvL1+IUQraMgQ0cSyLTU74Kq32HTHqjrlUBDs9fErfs2BI62QASnjI2t
   pVD0u/6Aflp6LGu8oEUzOGJYiIpZ/BQ+DhVOLn/ocRbpJuGE6R+1UAbCu
   9XRL/txiCOFuTidpvkl++566n7YAdO8V+GoBuunD1s10xmRYi+7J4CYZD
   baQqy/btjQp5LVkuZpVGBr2z/hmsxxGC0xf4GLciKcH2sXON4k0BzuVAR
   g==;
X-CSE-ConnectionGUID: EX1wx7N3TY6No8AkWMilIw==
X-CSE-MsgGUID: OhjrPfRkRKCSJJ4Po5AsHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85827908"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="85827908"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 03:26:29 -0700
X-CSE-ConnectionGUID: Jw1er71mRyqCbM0WLcmikg==
X-CSE-MsgGUID: 2F3v1bOvSLahWrojN71Baw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="257861881"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 28 Jul 2026 03:26:28 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wof0z-00000000eF5-3zU1;
	Tue, 28 Jul 2026 10:26:25 +0000
Date: Tue, 28 Jul 2026 18:25:25 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:fixes] BUILD SUCCESS
 5c4a03afcb21783987ffc64562b76ddd5a21b12b
Message-ID: <202607281813.mXEIjgYd-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_032630_284516_FD270E1C 
X-CRM114-Status: UNSURE (   4.09  )
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
branch HEAD: 5c4a03afcb21783987ffc64562b76ddd5a21b12b  liveupdate: Remember FLB retrieve() status

elapsed time: 878m

configs tested: 102
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260728    gcc-8.5.0
arc                  randconfig-002-20260728    gcc-8.5.0
arm                      imx_v6_v7_defconfig    clang-24
arm                  randconfig-001-20260728    gcc-8.5.0
arm                  randconfig-002-20260728    gcc-8.5.0
arm                  randconfig-003-20260728    gcc-8.5.0
arm                  randconfig-004-20260728    gcc-8.5.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260728    gcc-14.3.0
arm64                randconfig-002-20260728    gcc-14.3.0
arm64                randconfig-003-20260728    gcc-14.3.0
arm64                randconfig-004-20260728    gcc-14.3.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260728    gcc-14.3.0
csky                 randconfig-002-20260728    gcc-14.3.0
hexagon              randconfig-001-20260728    gcc-11.5.0
hexagon              randconfig-002-20260728    gcc-11.5.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260728    gcc-14
i386       buildonly-randconfig-002-20260728    gcc-14
i386       buildonly-randconfig-003-20260728    gcc-14
i386       buildonly-randconfig-004-20260728    gcc-14
i386       buildonly-randconfig-005-20260728    gcc-14
i386       buildonly-randconfig-006-20260728    gcc-14
i386                 randconfig-001-20260728    gcc-14
i386                 randconfig-002-20260728    gcc-14
i386                 randconfig-003-20260728    gcc-14
i386                 randconfig-004-20260728    gcc-14
i386                 randconfig-005-20260728    gcc-14
i386                 randconfig-006-20260728    gcc-14
i386                 randconfig-007-20260728    gcc-14
i386                          randconfig-011    gcc-14
i386                 randconfig-011-20260728    gcc-14
i386                 randconfig-012-20260728    gcc-14
i386                 randconfig-013-20260728    gcc-14
i386                 randconfig-014-20260728    gcc-14
i386                 randconfig-015-20260728    gcc-14
i386                 randconfig-016-20260728    gcc-14
i386                 randconfig-017-20260728    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260728    gcc-11.5.0
loongarch            randconfig-002-20260728    gcc-11.5.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260728    gcc-11.5.0
nios2                randconfig-002-20260728    gcc-11.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260728    gcc-10.5.0
parisc               randconfig-002-20260728    gcc-10.5.0
powerpc              randconfig-001-20260728    gcc-10.5.0
powerpc              randconfig-002-20260728    gcc-10.5.0
powerpc64            randconfig-001-20260728    gcc-10.5.0
powerpc64            randconfig-002-20260728    gcc-10.5.0
riscv                randconfig-001-20260728    gcc-14.3.0
riscv                randconfig-002-20260728    gcc-14.3.0
s390                 randconfig-001-20260728    gcc-14.3.0
s390                 randconfig-002-20260728    gcc-14.3.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260728    gcc-14.3.0
sh                   randconfig-002-20260728    gcc-14.3.0
sparc                         randconfig-001    gcc-11.5.0
sparc                randconfig-001-20260728    gcc-11.5.0
sparc                randconfig-002-20260728    gcc-11.5.0
sparc64              randconfig-001-20260728    gcc-11.5.0
sparc64              randconfig-002-20260728    gcc-11.5.0
um                   randconfig-001-20260728    gcc-11.5.0
um                   randconfig-002-20260728    gcc-11.5.0
x86_64     buildonly-randconfig-001-20260728    clang-22
x86_64     buildonly-randconfig-002-20260728    clang-22
x86_64     buildonly-randconfig-003-20260728    clang-22
x86_64     buildonly-randconfig-004-20260728    clang-22
x86_64     buildonly-randconfig-005-20260728    clang-22
x86_64     buildonly-randconfig-006-20260728    clang-22
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260728    gcc-12
x86_64               randconfig-002-20260728    gcc-12
x86_64               randconfig-003-20260728    gcc-12
x86_64               randconfig-004-20260728    gcc-12
x86_64               randconfig-005-20260728    gcc-12
x86_64               randconfig-006-20260728    gcc-12
x86_64               randconfig-011-20260728    clang-22
x86_64               randconfig-012-20260728    clang-22
x86_64               randconfig-013-20260728    clang-22
x86_64               randconfig-014-20260728    clang-22
x86_64               randconfig-015-20260728    clang-22
x86_64               randconfig-016-20260728    clang-22
x86_64               randconfig-071-20260728    clang-22
x86_64               randconfig-072-20260728    clang-22
x86_64               randconfig-073-20260728    clang-22
x86_64               randconfig-074-20260728    clang-22
x86_64               randconfig-075-20260728    clang-22
x86_64               randconfig-076-20260728    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260728    gcc-11.5.0
xtensa               randconfig-002-20260728    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

