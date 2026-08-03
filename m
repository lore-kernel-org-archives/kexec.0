Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4ADC5516F
	for <kexec@archiver.kernel.org>; Mon,  3 Aug 2026 04:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=K+UrZnGDfn1KDrLfPMoTYVav6fUDeRki+TtlsiEKOFI=; b=1ZkzT/T90jtZSuKHUIevUFCRo6
	Erl3hKkaYHJ5nQ54KoBNpNAqNEQDc1QJm7iLCukDTStsOZ5zb0SUq8F2LjFrke/BLoqaqcodzRO6b
	PJEGK1zCR9Z3MDHxDWmB08fr64Ucu2sxiftv9RvELq1RRamRX+yPkrZEL6TIoa/3CIBFxfXQkerlU
	5Z4FXRijxSVmMVk01qK8bI/H0LNOBm/T6m+sE6x9I9aejnnMSRt3Ln5OwuY8H/R6Mw1fHCm3IP+Mk
	Vf0qmL0r5nefR/UKex8+MmyQoi6w7CkWrKI/smtDN1FyN2cR3kplu8xtykDsPCoMB+KN0sNPhl/cn
	wGnH8rWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqk9W-0000000GIxI-2E3i;
	Mon, 03 Aug 2026 04:19:50 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqk9S-0000000GIwt-2cCR
	for kexec@lists.infradead.org;
	Mon, 03 Aug 2026 04:19:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785730786; x=1817266786;
  h=date:from:to:cc:subject:message-id;
  bh=Ko/Az60qQQfPuQWv/Ihsh4ne2i2ClNeswp+odg/JZuc=;
  b=XW97vUziZhJTb6lc2yCwwKkAwvfDPy5NNZtmvDplQqCpTCzftoOzqPH1
   n5J63MNhu9cwkGpo3CXeL7uduIFpZgvMf4ODyi1fcR5DfaTwdGTe3ODgD
   dqPoGSIdYDgEQATKGybiOoAuyZFzpuNTsRzELIE85EiyFrrlXgesAkQAv
   sXIT89Hi7/2uW1i4UUKCF7kK2CAmNXVo8E8T6bwhXYVBhVqxTrjfd48HB
   kbG1dvif3KjpDFPMZqy6SgVJEo2BdJP41aUphoHfLS9hvP9Pih29aDrWp
   1GUnoOmk+WMh/bp/t9NXpNjiuyiE1pElKrawvy/t9pLrRohP+wbyQUt7G
   g==;
X-CSE-ConnectionGUID: RkoURkFWQJ2XFcLkcXQ68A==
X-CSE-MsgGUID: brHwsZl9SBi6WDNu3v9cCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="86135924"
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="86135924"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2026 21:19:46 -0700
X-CSE-ConnectionGUID: B8XMJn0TR7uNQ5AHS1LzTg==
X-CSE-MsgGUID: IEPL0eiNRCCfpK6HdrcoNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="259869049"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 02 Aug 2026 21:19:45 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wqk9O-0000000063P-0qwl;
	Mon, 03 Aug 2026 04:19:42 +0000
Date: Mon, 03 Aug 2026 12:19:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:kho-scratch] BUILD SUCCESS
 6106b1bc175dc91cc2f584bc4149411809580bc9
Message-ID: <202608031204.cCHHM7CA-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260802_211946_678351_15AF6373 
X-CRM114-Status: UNSURE (   4.20  )
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git kho-scratch
branch HEAD: 6106b1bc175dc91cc2f584bc4149411809580bc9  Merge patch series "kho: make boot time huge page allocation work nicely with KHO"

elapsed time: 748m

configs tested: 100
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260803    gcc-8.5.0
arc                  randconfig-002-20260803    gcc-8.5.0
arm                            mxs_defconfig    clang-17
arm                  randconfig-001-20260803    gcc-8.5.0
arm                  randconfig-002-20260803    gcc-8.5.0
arm                  randconfig-003-20260803    gcc-8.5.0
arm                  randconfig-004-20260803    gcc-8.5.0
arm64                randconfig-001-20260803    gcc-12.5.0
arm64                randconfig-002-20260803    gcc-12.5.0
arm64                randconfig-003-20260803    gcc-12.5.0
arm64                randconfig-004-20260803    gcc-12.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260803    gcc-12.5.0
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

