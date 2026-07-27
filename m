Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D30C531D0
	for <kexec@archiver.kernel.org>; Mon, 27 Jul 2026 16:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=enqkElDNV1Owv+2SV4yKkaNsZTjOn0C9Zf4KBCNwvYc=; b=Xplwpq6a9HP5wgQnFVeKmwyiVv
	7o4apnwUoO/PNRTNBbnqWPw3zfUP7pTQAhUq1J/zcISMEOvv/0Xt9ygZd6Cwdy8ePCIu8DBUyTkBd
	urxR7OwMwpHlD4P8KGv0i8tB/Lb4Re+wai8ri77U8Q7nN6cb/QfAlCBvtrIo0NwmgcIWAY2sCMKlg
	6GUIkTomcrGv9h3SGJlFztGeqZkihLr8NIZu85OmNr9mSTFA1VeGcKkwN5VUvC/P+cJhlUKiw2Yog
	McIGY2cKFThW2XEc4+pVPaLsxVJ4AGM5L7OSic8SU0lsDOw+zFJfa09P8w5yso05FjoOzUeJeVTAD
	CXbbKIfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woOOw-00000003QTo-1OdL;
	Mon, 27 Jul 2026 16:42:02 +0000
Received: from mgamail.intel.com ([198.175.65.14])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woOOu-00000003QT7-0DsG
	for kexec@lists.infradead.org;
	Mon, 27 Jul 2026 16:42:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785170520; x=1816706520;
  h=date:from:to:cc:subject:message-id;
  bh=Mke9m7n85+397ly1wLspu3MCwHw8Qy01/xmIFR+pyM0=;
  b=db4VyaiNkVYCOgb5xWei3gSiQDOlY7HkTPON0u3VuG1Rv0rH2WZGF9Bb
   m8Y+0O96b1c5x+rCcYf5fVkq4BYSyx9ckUTFod1O4PGnITPtjieGJ/kWd
   MESgBMB8xtPfWVb7mzI7A/7DtkG8t0nnuo9FI9QFiSCySH29gkGAvq3Gc
   BoevzYe8DEXq62HngJMWQXJn9DHGPmHP7YLEmG6eHa1xJuk8O4SX4LsG6
   euPeJGrnF8CjXJYT19If4PrOdK8YeE6bjXZzdf8MXwpsAgUQM8BHsh/+0
   JJi9YAl76QE+gtyunbnpADSl6qtWa2xUt9jCohY3vSuIEt1Dl9QmTVWDl
   Q==;
X-CSE-ConnectionGUID: wJ3R3KypQfyuLM8VooqArA==
X-CSE-MsgGUID: wEqdGfSlSrWyi+bBGAaDAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="89634798"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="89634798"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 09:41:59 -0700
X-CSE-ConnectionGUID: 0gcw+IT2QsOxFTqB16LiEA==
X-CSE-MsgGUID: tN2ITlvkReOiYwfaAgkKcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="261428388"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 27 Jul 2026 09:41:57 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1woOOo-00000000dJw-2UIT;
	Mon, 27 Jul 2026 16:41:54 +0000
Date: Tue, 28 Jul 2026 00:41:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:selftests-lib] BUILD SUCCESS
 ccf287a39bd1288f534cf531f6bd4e57dbc716b7
Message-ID: <202607280022.xpe1rDZm-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_094200_127464_28703F5C 
X-CRM114-Status: UNSURE (   4.19  )
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git selftests-lib
branch HEAD: ccf287a39bd1288f534cf531f6bd4e57dbc716b7  Merge patch series "Make liveupdate selftests library"

elapsed time: 896m

configs tested: 97
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260727    gcc-8.5.0
arc                  randconfig-002-20260727    gcc-8.5.0
arm                  randconfig-001-20260727    gcc-8.5.0
arm                  randconfig-002-20260727    gcc-8.5.0
arm                  randconfig-003-20260727    gcc-8.5.0
arm                  randconfig-004-20260727    clang-20
arm64                randconfig-001-20260727    gcc-9.5.0
arm64                randconfig-002-20260727    gcc-8.5.0
arm64                randconfig-003-20260727    gcc-8.5.0
arm64                randconfig-004-20260727    gcc-15.2.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260727    gcc-11.5.0
csky                 randconfig-002-20260727    gcc-9.5.0
hexagon              randconfig-001-20260727    clang-22
hexagon              randconfig-002-20260727    clang-24
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260727    gcc-14
i386       buildonly-randconfig-002-20260727    gcc-14
i386       buildonly-randconfig-003-20260727    gcc-14
i386       buildonly-randconfig-004-20260727    clang-22
i386       buildonly-randconfig-005-20260727    clang-22
i386       buildonly-randconfig-006-20260727    gcc-14
i386                 randconfig-001-20260727    clang-22
i386                 randconfig-002-20260727    gcc-14
i386                 randconfig-003-20260727    clang-22
i386                 randconfig-004-20260727    gcc-14
i386                 randconfig-005-20260727    gcc-12
i386                 randconfig-006-20260727    clang-22
i386                 randconfig-007-20260727    clang-22
i386                 randconfig-011-20260727    clang-22
i386                 randconfig-012-20260727    clang-22
i386                 randconfig-013-20260727    clang-22
i386                 randconfig-014-20260727    clang-22
i386                 randconfig-015-20260727    clang-22
i386                 randconfig-016-20260727    gcc-14
i386                 randconfig-017-20260727    gcc-13
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260727    gcc-16.1.0
loongarch            randconfig-002-20260727    gcc-15.2.0
nios2                           alldefconfig    gcc-11.5.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260727    gcc-8.5.0
nios2                randconfig-002-20260727    gcc-11.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260727    gcc-12.5.0
parisc               randconfig-002-20260727    gcc-8.5.0
powerpc              randconfig-001-20260727    gcc-11.5.0
powerpc              randconfig-002-20260727    gcc-8.5.0
powerpc64            randconfig-001-20260727    gcc-8.5.0
powerpc64            randconfig-002-20260727    clang-18
riscv                randconfig-001-20260727    gcc-9.5.0
riscv                randconfig-002-20260727    gcc-11.5.0
s390                 randconfig-001-20260727    clang-24
s390                 randconfig-002-20260727    gcc-8.5.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260727    gcc-15.2.0
sh                   randconfig-002-20260727    gcc-16.1.0
sparc                randconfig-001-20260727    gcc-16.1.0
sparc                randconfig-002-20260727    gcc-8.5.0
sparc64              randconfig-001-20260727    gcc-10.5.0
sparc64              randconfig-002-20260727    gcc-12.5.0
um                   randconfig-001-20260727    gcc-14
um                   randconfig-002-20260727    clang-21
x86_64     buildonly-randconfig-001-20260727    gcc-14
x86_64     buildonly-randconfig-002-20260727    gcc-14
x86_64     buildonly-randconfig-003-20260727    clang-22
x86_64     buildonly-randconfig-004-20260727    clang-22
x86_64     buildonly-randconfig-005-20260727    gcc-14
x86_64     buildonly-randconfig-006-20260727    gcc-14
x86_64               randconfig-001-20260727    gcc-13
x86_64               randconfig-002-20260727    clang-22
x86_64               randconfig-003-20260727    gcc-14
x86_64               randconfig-004-20260727    clang-22
x86_64               randconfig-005-20260727    clang-22
x86_64               randconfig-006-20260727    clang-22
x86_64               randconfig-011-20260727    gcc-14
x86_64               randconfig-012-20260727    gcc-14
x86_64               randconfig-013-20260727    clang-22
x86_64               randconfig-014-20260727    clang-22
x86_64               randconfig-015-20260727    gcc-14
x86_64               randconfig-016-20260727    clang-22
x86_64               randconfig-071-20260727    gcc-12
x86_64               randconfig-072-20260727    gcc-14
x86_64               randconfig-073-20260727    gcc-14
x86_64               randconfig-074-20260727    clang-22
x86_64               randconfig-075-20260727    gcc-12
x86_64               randconfig-076-20260727    gcc-14
xtensa               randconfig-001-20260727    gcc-14.3.0
xtensa               randconfig-002-20260727    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

