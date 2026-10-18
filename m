Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DA2CCF2C4
	for <kexec@archiver.kernel.org>; Sun, 18 Oct 2026 20:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kp7PYm/X46EyZSp2H6Opi2AulZM6xGxiIQnSpKR+t80=; b=HMBCjBZmvNSnxq+3j+OCqQmNgy
	VxNFDI39vajDWXCIMQMTzgGHjg9tLt/yRjyksX+gITkh/b+YOhtNKGja3ne65K1kUvabmMduLUGMT
	S1A9+WHvqNqDWvltW4gY7+xm7KkoLV+AaRtkXdLfONbfbBH3KR24sZ9vOeMcS7I/qclLY/IEhLiw2
	sZ+W6Off14z9T0EuiHwi1ZydOAnMbGMOIh6jslgfebApKzSTKSlO6rHigNqbE4ljbPTBimjVT32fX
	brHIkFhSL0D6BftAZ2Zx9TMPzMPvzSZEBri/BWv9vYUu71sqiCf6DVAwHNshKBHTR5K7q3pJsHniS
	lHQchlpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIXgW-00000006DVs-0PR6;
	Sun, 18 Oct 2026 20:40:48 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIXgS-00000006DVY-2WBl
	for kexec@lists.infradead.org;
	Sun, 18 Oct 2026 20:40:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792356044; x=1823892044;
  h=date:from:to:cc:subject:message-id;
  bh=bNtw+Xzw6T3ZmrgNb9JTg3xV/2L4XDAqRy3qhc2s/eM=;
  b=J5dD1F+uOW5X7oscsSp/dqvQc6TEDKbdap8rzG6hQ/IFqs/l9hefiRj6
   YLggCfwSykS3BRbbF/WIiHW/BWLZRg/jL500lwTxSr0dBD8/YaCZPLmA5
   RK7KZkrTeOCQv9mtanavy7KlVuAd5Xbfo1N1i0G6FGxCDsYbg0lhpupjJ
   yqhkguopiEQRLDldCs5TsVY+bcHIAR/5ALJPXcmSHOHRX1+z9rQJ3dgsU
   62exSp0KqJjdt+g6dIYsLJLU5NcKeymihbym7lSULctW6haGcUKgLAbzV
   6ezD9IUSQyYjaPSa28Z4ZjCLd7k0JdPAlznz3bdV8NDxzD6LCnBdKURlz
   g==;
X-CSE-ConnectionGUID: EHbGsUe7QdahIfXGo+sUCw==
X-CSE-MsgGUID: jMCEoT6gRy2q3b0L6dEf7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="928554"
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="928554"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 13:40:30 -0700
X-CSE-ConnectionGUID: 4sAkWuMtSYe981kPeDRVew==
X-CSE-MsgGUID: UKpxBqjBRyiwz9J6yObs2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="4126333"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa012.fm.intel.com with ESMTP; 18 Oct 2026 13:40:28 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xIXg9-00000000Kp0-1MLR;
	Sun, 18 Oct 2026 20:40:25 +0000
Date: Mon, 19 Oct 2026 04:40:15 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:liveupdate-7.4] BUILD SUCCESS
 9a6a70aefe77f6fb9ff2b3037dcf87f6dff65c8c
Message-ID: <202610190412.TPOhZUeG-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_134044_730841_648C98E0 
X-CRM114-Status: UNSURE (   4.21  )
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git liveupdate-7.4
branch HEAD: 9a6a70aefe77f6fb9ff2b3037dcf87f6dff65c8c  kho: do not reserve empty per-node bootmem areas

elapsed time: 3310m

configs tested: 102
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                     allnoconfig    gcc-16.1.0
alpha                    allyesconfig    gcc-16.1.0
alpha       randconfig-r2100-20261015    gcc-9.5.0  cocci
arc                      allmodconfig    gcc-16.1.0
arc                       allnoconfig    gcc-16.1.0
arc                      allyesconfig    gcc-16.1.0
arc          randconfig-2000-20261015    gcc-9.5.0
arc          randconfig-2001-20261015    gcc-15.2.0
arc         randconfig-r2101-20261015    gcc-8.5.0  cocci
arm                       allnoconfig    clang-17
arm                      allyesconfig    gcc-16.1.0
arm          randconfig-2000-20261015    gcc-11.5.0
arm          randconfig-2001-20261015    gcc-8.5.0
arm         randconfig-r2103-20261015    clang-24   cocci
arm64                    allmodconfig    clang-24
arm64                     allnoconfig    gcc-16.1.0
csky                     allmodconfig    gcc-16.1.0
csky                      allnoconfig    gcc-16.1.0
hexagon                  allmodconfig    clang-24
hexagon                   allnoconfig    clang-24
i386                      allnoconfig    gcc-14
i386         randconfig-2000-20261015    clang-22
i386         randconfig-2001-20261015    clang-22
i386         randconfig-2200-20261015    clang-22   smatch
i386         randconfig-2300-20261015    clang-22   sparse
i386         randconfig-2301-20261015    gcc-14     sparse
i386         randconfig-2302-20261015    gcc-14     sparse
i386        randconfig-r2104-20261015    gcc-14     cocci
i386        randconfig-r2107-20261015    gcc-14     cocci
i386        randconfig-r2110-20261015    gcc-14     cocci
i386        randconfig-r2201-20261015    clang-22   smatch
loongarch                allmodconfig    clang-19
loongarch                 allnoconfig    clang-20
loongarch    randconfig-2000-20261015    clang-24
loongarch    randconfig-2001-20261015    gcc-16.1.0
loongarch   randconfig-r2105-20261015    gcc-14.3.0 cocci
m68k                     allmodconfig    gcc-16.1.0
m68k                      allnoconfig    gcc-16.1.0
m68k                     allyesconfig    gcc-16.1.0
m68k        randconfig-r2102-20261015    gcc-8.5.0  cocci
microblaze                allnoconfig    gcc-16.1.0
microblaze               allyesconfig    gcc-16.1.0
microblaze  randconfig-r2108-20261015    gcc-8.5.0  cocci
mips                     allmodconfig    gcc-16.1.0
mips                      allnoconfig    gcc-16.1.0
mips                     allyesconfig    gcc-16.1.0
mips        randconfig-r2111-20261015    gcc-15.2.0 cocci
nios2                    allmodconfig    gcc-11.5.0
nios2                     allnoconfig    gcc-11.5.0
nios2        randconfig-2000-20261015    gcc-8.5.0
nios2        randconfig-2001-20261015    gcc-8.5.0
openrisc                 allmodconfig    gcc-16.1.0
openrisc                  allnoconfig    gcc-16.1.0
openrisc    randconfig-r2202-20261015    gcc-16.1.0 smatch
parisc                   allmodconfig    gcc-16.1.0
parisc                    allnoconfig    gcc-16.1.0
parisc       randconfig-2000-20261015    gcc-11.5.0
parisc       randconfig-2001-20261015    gcc-8.5.0
powerpc                  allmodconfig    gcc-16.1.0
powerpc                   allnoconfig    gcc-16.1.0
powerpc      randconfig-2000-20261015    clang-24
powerpc      randconfig-2001-20261015    gcc-10.5.0
powerpc64    randconfig-2000-20261015    clang-19
powerpc64    randconfig-2001-20261015    gcc-8.5.0
riscv                    allmodconfig    clang-24
riscv                     allnoconfig    gcc-16.1.0
riscv                    allyesconfig    clang-24
riscv       randconfig-r2106-20261015    gcc-8.5.0  cocci
s390                      allnoconfig    clang-24
s390                     allyesconfig    gcc-16.1.0
sh                       allmodconfig    gcc-16.1.0
sh                        allnoconfig    gcc-16.1.0
sh                       allyesconfig    gcc-16.1.0
sparc                     allnoconfig    gcc-16.1.0
sparc        randconfig-2000-20261015    gcc-13.4.0
sparc        randconfig-2001-20261015    gcc-15.2.0
sparc64                  allmodconfig    clang-20
sparc64      randconfig-2000-20261015    clang-20
sparc64      randconfig-2001-20261015    gcc-8.5.0
um                        allnoconfig    clang-17
um                       allyesconfig    gcc-14
um           randconfig-2000-20261015    clang-24
um           randconfig-2001-20261015    gcc-14
x86_64                    allnoconfig    clang-22
x86_64       randconfig-2000-20261015    gcc-14
x86_64       randconfig-2001-20261015    clang-22
x86_64       randconfig-2100-20261015    gcc-14     cocci
x86_64       randconfig-2101-20261015    clang-22   cocci
x86_64       randconfig-2102-20261015    clang-22   cocci
x86_64       randconfig-2103-20261015    clang-22   cocci
x86_64       randconfig-2104-20261015    gcc-14     cocci
x86_64       randconfig-2105-20261015    gcc-14     cocci
x86_64       randconfig-2200-20261015    clang-22   smatch
x86_64       randconfig-2300-20261015    clang-22   sparse
x86_64       randconfig-2301-20261015    clang-22   sparse
x86_64       randconfig-2302-20261015    gcc-12     sparse
x86_64                  rhel-9.4-rust    clang-22
xtensa                    allnoconfig    gcc-16.1.0
xtensa                   allyesconfig    gcc-16.1.0
xtensa       randconfig-2000-20261015    gcc-11.5.0
xtensa       randconfig-2001-20261015    gcc-8.5.0
xtensa      randconfig-r2109-20261015    gcc-12.5.0 cocci

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

