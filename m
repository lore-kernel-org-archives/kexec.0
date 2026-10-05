Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55703CA5FFC
	for <kexec@archiver.kernel.org>; Mon,  5 Oct 2026 15:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gFei3iCnQnbGH44HOHq2P+1T9939WKoyi/nrt7xpw/U=; b=zNyFhu5nf0O7IqXiqGsqfgfDXV
	qW96broFVJyZNCrng3+/RcDgSVe5hkTDdYGXk050cyY8UtCHg4xSNTm4dMtxNJUFlZr9PRz3pKV3d
	SYOFJrAQmeAQNKJqfuiyf611Kln40DwDfwE/uAKxuRxEACFPYhu5tgiKeLY0a9+YXaFG04z8L8D/0
	ZrzArS+sAqEgqdE6L0Ze+WLXySQyTYfhsTBidiuQ53576Tu26COe+LUv07ATsPwkemXqdK1vp2nvn
	PskNYxR9JaKiq4KiEYUkCAys7tZ1Gjnz/xq+L5AHmN4k6R0ZnXCAotCLgEnJK2PCZ2Xntzz6ndqiy
	Zrx8cnlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDkK5-0000000GjPq-3FV3;
	Mon, 05 Oct 2026 15:09:49 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDkK0-0000000GjPP-1uXa
	for kexec@lists.infradead.org;
	Mon, 05 Oct 2026 15:09:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791212985; x=1822748985;
  h=date:from:to:cc:subject:message-id;
  bh=xPw/HCLYixgzPDlKFaXb0ad5OHI+rnhW/cBp8u+um4I=;
  b=RJTOhEqnLno3jIc9JJebiplHWEPGLWEtMhFnNEKHxKMpuKUWChH6u463
   VaR4emFXzf6OX/e16rqpDW82La6ujU4vDHddb/kIcnavVNKkJ8kSFm2Li
   G75HpHxnoFOysD07zyqiDnAWaGs7DuNIWBoH/BfEoRpBnYWcC8A+kuDPu
   QYqU9y68Icdc8Y5Ap8OjesDm3VbNd6quzqNzK6S3HAcv0qRxnCnX8GzUa
   Fr+6z7Wk5UDHbLQFB6NQDlt8PRhScYGB7yDuNf4Ot3fBabFRNoWFpuBei
   nE/7vNONn+6ROZ75AitmkVbQv7NYW7TDiRBlCLIQQmBohaxtIO4E/B8LD
   A==;
X-CSE-ConnectionGUID: YVYm4LC0RCK5x5EgnAlTIQ==
X-CSE-MsgGUID: viP+0eIdR5K7SoV6pSm37A==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="102465465"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="102465465"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 08:09:43 -0700
X-CSE-ConnectionGUID: RSUrWHF3S7OJgoI8Dz4uTg==
X-CSE-MsgGUID: ql0knPJBRvynw96IRG+iLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="276393064"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 05 Oct 2026 08:09:42 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xDkJv-000000000TT-0ve0;
	Mon, 05 Oct 2026 15:09:39 +0000
Date: Mon, 05 Oct 2026 23:09:20 +0800
From: kernel test robot <lkp@intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:next] BUILD SUCCESS
 80cf37169daef112b6bea9ae7d9808355a045475
Message-ID: <202610052316.8nVkhynu-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261005_080944_558363_93A944B6 
X-CRM114-Status: UNSURE (   3.94  )
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
branch HEAD: 80cf37169daef112b6bea9ae7d9808355a045475  Merge branch 'kho-bootmem' into next

elapsed time: 1289m

configs tested: 278
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             alldefconfig    gcc-16.1.0
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261005    gcc-8.5.0
arc                   randconfig-1001-20261005    gcc-8.5.0
arc                  randconfig-r2300-20261005    gcc-11.5.0 sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                         mvebu_v7_defconfig    gcc-16.1.0
arm                   randconfig-1000-20261005    gcc-8.5.0
arm                   randconfig-1001-20261005    gcc-8.5.0
arm                   randconfig-1002-20261005    gcc-8.5.0
arm                   randconfig-1003-20261005    gcc-8.5.0
arm                  randconfig-r2103-20261004    clang-18   cocci
arm                  randconfig-r2103-20261005    clang-24   cocci
arm                  randconfig-r2201-20261005    clang-24   smatch
arm                         vexpress_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261005    gcc-16.1.0
arm64                 randconfig-1001-20261005    gcc-16.1.0
arm64                 randconfig-1002-20261005    gcc-16.1.0
arm64                 randconfig-1003-20261005    gcc-16.1.0
arm64                randconfig-r2102-20261005    clang-24   cocci
arm64                randconfig-r2104-20261005    gcc-15.2.0 cocci
arm64                randconfig-r2107-20261004    clang-17   cocci
arm64                randconfig-r2302-20261004    gcc-12.5.0 sparse
arm64                randconfig-r2304-20261004    clang-24   sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261005    gcc-16.1.0
csky                  randconfig-1001-20261005    gcc-16.1.0
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261005    gcc-16.1.0
hexagon               randconfig-1001-20261005    gcc-16.1.0
hexagon              randconfig-r2100-20261004    clang-24   cocci
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261005    clang-22
i386        buildonly-randconfig-1001-20261005    clang-22
i386        buildonly-randconfig-1002-20261005    clang-22
i386        buildonly-randconfig-1003-20261005    clang-22
i386        buildonly-randconfig-1004-20261005    clang-22
i386        buildonly-randconfig-1005-20261005    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261005    clang-22
i386                  randconfig-1001-20261005    clang-22
i386                  randconfig-1002-20261005    clang-22
i386                  randconfig-1003-20261005    clang-22
i386                  randconfig-1004-20261005    clang-22
i386                  randconfig-1005-20261005    clang-22
i386                  randconfig-1006-20261005    clang-22
i386                  randconfig-1007-20261005    clang-22
i386                  randconfig-1008-20261005    clang-22
i386                  randconfig-1009-20261005    clang-22
i386                  randconfig-1010-20261005    clang-22
i386                  randconfig-1011-20261005    clang-22
i386                  randconfig-1012-20261005    clang-22
i386                  randconfig-1013-20261005    clang-22
i386                  randconfig-2100-20261004    clang-22   cocci
i386                  randconfig-2100-20261005    gcc-14     cocci
i386                  randconfig-2101-20261004    gcc-14     cocci
i386                  randconfig-2101-20261005    gcc-14     cocci
i386                  randconfig-2102-20261004    gcc-14     cocci
i386                  randconfig-2102-20261005    gcc-14     cocci
i386                  randconfig-2103-20261004    gcc-14     cocci
i386                  randconfig-2103-20261005    gcc-14     cocci
i386                  randconfig-2200-20261004    clang-22   smatch
i386                  randconfig-2200-20261005    gcc-14     smatch
i386                  randconfig-2300-20261004    clang-22   sparse
i386                  randconfig-2300-20261005    clang-22   sparse
i386                  randconfig-2301-20261004    gcc-14     sparse
i386                  randconfig-2301-20261005    clang-22   sparse
i386                  randconfig-2302-20261004    gcc-14     sparse
i386                  randconfig-2302-20261005    clang-22   sparse
i386                 randconfig-r2308-20261004    gcc-14     sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261005    gcc-16.1.0
loongarch             randconfig-1001-20261005    gcc-16.1.0
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                             q40_defconfig    gcc-16.1.0
m68k                 randconfig-r2301-20261005    gcc-11.5.0 sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2100-20261005    clang-24   cocci
microblaze           randconfig-r2101-20261005    clang-24   cocci
microblaze           randconfig-r2107-20261005    gcc-15.2.0 cocci
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                 randconfig-r2106-20261004    gcc-14.3.0 cocci
mips                 randconfig-r2303-20261005    gcc-11.5.0 sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261005    gcc-16.1.0
nios2                 randconfig-1001-20261005    gcc-16.1.0
nios2                randconfig-r2106-20261005    gcc-15.2.0 cocci
nios2                randconfig-r2201-20261004    gcc-11.5.0 smatch
nios2                randconfig-r2301-20261004    gcc-11.5.0 sparse
nios2                randconfig-r2309-20261005    gcc-8.5.0  sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2102-20261004    gcc-14.3.0 cocci
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261005    gcc-8.5.0
parisc                randconfig-1001-20261005    gcc-8.5.0
parisc               randconfig-r2105-20261005    gcc-15.2.0 cocci
parisc               randconfig-r2307-20261005    gcc-8.5.0  sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                    bluestone_defconfig    gcc-16.1.0
powerpc                         cell_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20261005    gcc-8.5.0
powerpc               randconfig-1001-20261005    gcc-8.5.0
powerpc              randconfig-r2302-20261005    gcc-11.5.0 sparse
powerpc              randconfig-r2303-20261004    gcc-8.5.0  sparse
powerpc              randconfig-r2306-20261004    clang-24   sparse
powerpc              randconfig-r2309-20261004    clang-24   sparse
powerpc64             randconfig-1000-20261005    gcc-8.5.0
powerpc64             randconfig-1001-20261005    gcc-8.5.0
powerpc64            randconfig-r2200-20261004    clang-24   smatch
powerpc64            randconfig-r2200-20261005    gcc-12.5.0 smatch
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261005    clang-17
riscv                 randconfig-1001-20261005    clang-17
riscv                 randconfig-2000-20261004    clang-24
riscv                 randconfig-2000-20261005    gcc-16.1.0
riscv                 randconfig-2001-20261004    clang-24
riscv                 randconfig-2001-20261005    gcc-16.1.0
riscv                randconfig-r2306-20261005    gcc-8.5.0  sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261005    clang-17
s390                  randconfig-1001-20261005    clang-17
s390                  randconfig-2000-20261004    clang-24
s390                  randconfig-2000-20261005    gcc-16.1.0
s390                  randconfig-2001-20261004    gcc-10.5.0
s390                  randconfig-2001-20261005    gcc-16.1.0
s390                 randconfig-r2105-20261004    clang-24   cocci
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261005    clang-17
sh                    randconfig-1001-20261005    clang-17
sh                    randconfig-2000-20261004    gcc-13.4.0
sh                    randconfig-2000-20261005    gcc-16.1.0
sh                    randconfig-2001-20261004    gcc-11.5.0
sh                    randconfig-2001-20261005    gcc-16.1.0
sh                   randconfig-r2305-20261004    gcc-13.4.0 sparse
sh                           urquell_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261005    clang-24
sparc                 randconfig-1001-20261005    clang-24
sparc                 randconfig-2000-20261004    gcc-8.5.0
sparc                 randconfig-2000-20261005    clang-17
sparc                 randconfig-2001-20261004    gcc-15.2.0
sparc                 randconfig-2001-20261005    clang-17
sparc                randconfig-r2300-20261004    gcc-11.5.0 sparse
sparc                randconfig-r2304-20261005    gcc-11.5.0 sparse
sparc                randconfig-r2308-20261005    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261005    clang-24
sparc64               randconfig-1001-20261005    clang-24
sparc64               randconfig-2000-20261004    clang-20
sparc64               randconfig-2000-20261005    clang-17
sparc64               randconfig-2001-20261004    gcc-10.5.0
sparc64               randconfig-2001-20261005    clang-17
sparc64              randconfig-r2202-20261004    clang-20   smatch
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261005    clang-24
um                    randconfig-1001-20261005    clang-24
um                    randconfig-2000-20261004    gcc-14
um                    randconfig-2000-20261005    clang-17
um                    randconfig-2001-20261004    clang-17
um                    randconfig-2001-20261005    clang-17
um                   randconfig-r2305-20261005    gcc-11.5.0 sparse
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20261005    gcc-13
x86_64      buildonly-randconfig-1001-20261005    gcc-13
x86_64      buildonly-randconfig-1002-20261005    gcc-13
x86_64      buildonly-randconfig-1003-20261005    gcc-13
x86_64      buildonly-randconfig-1004-20261005    gcc-13
x86_64      buildonly-randconfig-1005-20261005    gcc-13
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261005    gcc-14
x86_64                randconfig-1001-20261005    gcc-14
x86_64                randconfig-1002-20261005    gcc-14
x86_64                randconfig-1003-20261005    gcc-14
x86_64                randconfig-1004-20261005    gcc-14
x86_64                randconfig-1005-20261005    gcc-14
x86_64                randconfig-1006-20261005    gcc-14
x86_64                randconfig-1007-20261005    gcc-14
x86_64                randconfig-1008-20261005    gcc-14
x86_64                randconfig-1009-20261005    gcc-14
x86_64                randconfig-1010-20261005    gcc-14
x86_64                randconfig-1011-20261005    gcc-14
x86_64                randconfig-1012-20261005    gcc-14
x86_64                randconfig-1013-20261005    gcc-14
x86_64                randconfig-1014-20261005    gcc-14
x86_64                randconfig-1015-20261005    gcc-14
x86_64                randconfig-1016-20261005    gcc-14
x86_64                randconfig-1017-20261005    gcc-14
x86_64                randconfig-2100-20261004    gcc-14     cocci
x86_64                randconfig-2100-20261005    clang-22   cocci
x86_64                randconfig-2101-20261004    clang-22   cocci
x86_64                randconfig-2101-20261005    clang-22   cocci
x86_64                randconfig-2102-20261004    gcc-14     cocci
x86_64                randconfig-2102-20261005    clang-22   cocci
x86_64                randconfig-2103-20261004    gcc-14     cocci
x86_64                randconfig-2103-20261005    clang-22   cocci
x86_64                randconfig-2200-20261004    gcc-14     smatch
x86_64                randconfig-2200-20261005    clang-22   smatch
x86_64                randconfig-2300-20261004    gcc-14     sparse
x86_64                randconfig-2300-20261005    clang-22   sparse
x86_64                randconfig-2301-20261004    gcc-14     sparse
x86_64                randconfig-2301-20261005    clang-22   sparse
x86_64                randconfig-2302-20261004    clang-22   sparse
x86_64                randconfig-2302-20261005    clang-22   sparse
x86_64               randconfig-r2104-20261004    clang-22   cocci
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261005    clang-24
xtensa                randconfig-1001-20261005    clang-24
xtensa                randconfig-2000-20261004    gcc-8.5.0
xtensa                randconfig-2000-20261005    clang-17
xtensa                randconfig-2001-20261004    gcc-9.5.0
xtensa                randconfig-2001-20261005    clang-17
xtensa               randconfig-r2101-20261004    gcc-16.1.0 cocci
xtensa               randconfig-r2202-20261005    gcc-10.5.0 smatch
xtensa               randconfig-r2307-20261004    gcc-14.3.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

