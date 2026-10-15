Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998B8CC6B2D
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 02:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2g2C4BS2vVnJ/5HJ0kHY891/3e+u0vFXQiQkK/U+Vks=; b=rimPEUDX8LIpfUlO5jOPCz2s+2
	bpgnmB3fIlnZxQGNVc8yMZlsCJxE1GIMcDGhMjuvHKNuqnDXpuiNnhHPkP4qrNw5T4NJjjyXUSWV2
	0+LfXYynRDSty460s7lLX2dzUUwvd9qjaaI+P/tYQorok1+Ui1iWQSxbtzBUBdmdPDTqij/8bANcF
	/YadHUMaXszyX47+T/ySTEcMQ69JM7WmZ4Ox6rSL9+8O1jzFyUVhWD/sUnp+gg+4zYsZPzbGObJSK
	V/P1IxDN9ozHEH+jYIai1JfXfpekOpn73zzwKNxUjUAsz4OWl4oms7sHj4++oIUF3RFGoWepnN3kV
	wC5I1uBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHBYL-0000000GhHz-3I7H;
	Thu, 15 Oct 2026 02:50:45 +0000
Received: from mgamail.intel.com ([198.175.65.21])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHBYJ-0000000GhHZ-0Grb
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 02:50:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792032643; x=1823568643;
  h=date:from:to:cc:subject:message-id;
  bh=VekEz5NpI+oXT5Yjo+yMN1SB6gsE8g6imx4bDVWJWc8=;
  b=WDEuPhMZ08rbodQruGG/VucwZ909SYBSCmreOyVBtrFIDLQBNc672+Zj
   SZGVBO4DBtzCFHHOxe15ExvBDN3zZEGi/XYlVxfb846SsJ6zT7KSGEdWD
   bdbMqeheUJFQEXID/C221sbplE/ZuyZTKi+gbiop0BI3B8qzuz+tTP+tg
   YB9P2gaRVotCzcbR3+qS1IjqMo+NJ013pKYlhXCFUPQlqU+E+5uOuej2E
   4Pf0H6e+g8nPVA5DzcLPGwWA5vKyAJ6MkpPSltGNjqu3vEkjVSP9/g9Y0
   tb0az93+wOyzP9eUgFEmh7qZ732qhe7BQT2qkdvUH1TmXfQofRpnjU4NL
   Q==;
X-CSE-ConnectionGUID: YKp/yc3FQRS5CXNF9JPcJg==
X-CSE-MsgGUID: /1O0u3BrSzWPNCaA99sJEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="897600"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="897600"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 19:50:42 -0700
X-CSE-ConnectionGUID: sk2LxjzKT/6oqifKDOs+ag==
X-CSE-MsgGUID: SsG01VzXTYOrXoSSi3Ewhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1544377"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 14 Oct 2026 19:50:40 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHBYE-00000000FbH-0UQY;
	Thu, 15 Oct 2026 02:50:38 +0000
Date: Thu, 15 Oct 2026 10:49:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:liveupdate-7.4] BUILD SUCCESS
 48e6e4202e12af36671c6479b9ebcb8212d37cbb
Message-ID: <202610151055.BANH6TTV-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_195043_189104_89E4FCE9 
X-CRM114-Status: UNSURE (   3.64  )
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
branch HEAD: 48e6e4202e12af36671c6479b9ebcb8212d37cbb  selftests/liveupdate: Prefer KVM and HVF over TCG in vmtest.sh

elapsed time: 2035m

configs tested: 268
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                     allnoconfig    gcc-16.1.0
alpha                    allyesconfig    gcc-16.1.0
alpha       randconfig-r2100-20261014    gcc-8.5.0  cocci
alpha       randconfig-r2308-20261014    gcc-14.3.0 sparse
arc                      allmodconfig    gcc-16.1.0
arc                       allnoconfig    gcc-16.1.0
arc                      allyesconfig    gcc-16.1.0
arc          randconfig-2000-20261013    gcc-8.5.0
arc          randconfig-2000-20261014    gcc-10.5.0
arc          randconfig-2001-20261013    gcc-8.5.0
arc          randconfig-2001-20261014    gcc-10.5.0
arc         randconfig-r2102-20261014    gcc-8.5.0  cocci
arc         randconfig-r2109-20261013    clang-24   cocci
arm                       allnoconfig    clang-17
arm                      allyesconfig    gcc-16.1.0
arm          randconfig-2000-20261013    gcc-8.5.0
arm          randconfig-2000-20261014    gcc-10.5.0
arm          randconfig-2001-20261013    gcc-8.5.0
arm          randconfig-2001-20261014    gcc-10.5.0
arm         randconfig-r2300-20261013    clang-17   sparse
arm         randconfig-r2311-20261013    gcc-13.4.0 sparse
arm64                    allmodconfig    clang-24
arm64                     allnoconfig    gcc-16.1.0
arm64        randconfig-2000-20261013    gcc-9.5.0
arm64        randconfig-2000-20261014    gcc-16.1.0
arm64        randconfig-2001-20261013    gcc-9.5.0
arm64        randconfig-2001-20261014    gcc-16.1.0
arm64       randconfig-r2101-20261014    gcc-11.5.0 cocci
arm64       randconfig-r2104-20261014    gcc-10.5.0 cocci
arm64       randconfig-r2105-20261014    gcc-8.5.0  cocci
arm64       randconfig-r2200-20261013    gcc-8.5.0  smatch
arm64       randconfig-r2201-20261013    gcc-11.5.0 smatch
arm64       randconfig-r2305-20261014    clang-24   sparse
csky                     allmodconfig    gcc-16.1.0
csky                      allnoconfig    gcc-16.1.0
csky         randconfig-2000-20261013    gcc-9.5.0
csky         randconfig-2000-20261014    gcc-16.1.0
csky         randconfig-2001-20261013    gcc-9.5.0
csky         randconfig-2001-20261014    gcc-16.1.0
csky        randconfig-r2102-20261013    gcc-14.3.0 cocci
csky        randconfig-r2106-20261014    gcc-10.5.0 cocci
csky        randconfig-r2109-20261013    gcc-16.1.0 cocci
csky        randconfig-r2201-20261014    gcc-14.3.0 smatch
csky        randconfig-r2300-20261013    gcc-16.1.0 sparse
csky        randconfig-r2302-20261014    clang-24   sparse
csky        randconfig-r2303-20261013    gcc-16.1.0 sparse
csky        randconfig-r2304-20261013    gcc-16.1.0 sparse
csky        randconfig-r2309-20261014    gcc-14.3.0 sparse
hexagon                  allmodconfig    clang-24
hexagon                   allnoconfig    clang-24
hexagon      randconfig-2000-20261013    gcc-9.5.0
hexagon      randconfig-2000-20261014    gcc-16.1.0
hexagon      randconfig-2001-20261013    gcc-9.5.0
hexagon      randconfig-2001-20261014    gcc-16.1.0
hexagon     randconfig-r2103-20261014    gcc-11.5.0 cocci
hexagon     randconfig-r2107-20261013    clang-24   cocci
hexagon     randconfig-r2304-20261014    clang-24   sparse
hexagon     randconfig-r2305-20261013    clang-17   sparse
i386                     allmodconfig    gcc-14
i386                      allnoconfig    gcc-14
i386         randconfig-1004-20261015    clang-22
i386         randconfig-1005-20261015    gcc-14
i386         randconfig-2000-20261013    gcc-8.5.0
i386         randconfig-2000-20261014    gcc-10.5.0
i386         randconfig-2001-20261013    gcc-8.5.0
i386         randconfig-2001-20261014    gcc-10.5.0
i386         randconfig-2100-20261013    gcc-14     cocci
i386         randconfig-2100-20261014    gcc-13     cocci
i386         randconfig-2101-20261013    gcc-14     cocci
i386         randconfig-2101-20261014    gcc-13     cocci
i386         randconfig-2102-20261013    gcc-14     cocci
i386         randconfig-2102-20261014    gcc-13     cocci
i386         randconfig-2103-20261013    gcc-14     cocci
i386         randconfig-2103-20261014    gcc-13     cocci
i386         randconfig-2104-20261013    gcc-14     cocci
i386         randconfig-2104-20261014    gcc-13     cocci
i386         randconfig-2105-20261013    gcc-14     cocci
i386         randconfig-2105-20261014    gcc-13     cocci
i386         randconfig-2200-20261013    gcc-14     smatch
i386         randconfig-2200-20261014    clang-22   smatch
i386         randconfig-2300-20261013    gcc-14     sparse
i386         randconfig-2300-20261014    clang-22   sparse
i386         randconfig-2301-20261013    gcc-14     sparse
i386         randconfig-2301-20261014    clang-22   sparse
i386         randconfig-2302-20261013    gcc-14     sparse
i386         randconfig-2302-20261014    clang-22   sparse
i386        randconfig-r2110-20261013    clang-24   cocci
i386        randconfig-r2110-20261014    gcc-10.5.0 cocci
i386        randconfig-r2111-20261014    gcc-8.5.0  cocci
i386        randconfig-r2300-20261014    clang-24   sparse
loongarch                allmodconfig    clang-19
loongarch                 allnoconfig    clang-20
loongarch    randconfig-2000-20261013    gcc-11.5.0
loongarch    randconfig-2000-20261014    gcc-8.5.0
loongarch    randconfig-2001-20261013    gcc-11.5.0
loongarch    randconfig-2001-20261014    gcc-8.5.0
loongarch   randconfig-r2101-20261013    clang-24   cocci
loongarch   randconfig-r2104-20261014    gcc-8.5.0  cocci
loongarch   randconfig-r2108-20261013    gcc-16.1.0 cocci
loongarch   randconfig-r2111-20261014    gcc-10.5.0 cocci
loongarch   randconfig-r2303-20261013    gcc-16.1.0 sparse
loongarch   randconfig-r2305-20261014    clang-24   sparse
m68k                     allmodconfig    gcc-16.1.0
m68k                      allnoconfig    gcc-16.1.0
m68k                     allyesconfig    gcc-16.1.0
m68k        randconfig-r2100-20261013    clang-24   cocci
m68k        randconfig-r2107-20261014    gcc-10.5.0 cocci
m68k        randconfig-r2108-20261013    clang-24   cocci
m68k        randconfig-r2200-20261014    gcc-9.5.0  smatch
microblaze                allnoconfig    gcc-16.1.0
microblaze               allyesconfig    gcc-16.1.0
microblaze  randconfig-r2101-20261014    gcc-8.5.0  cocci
microblaze  randconfig-r2105-20261014    gcc-10.5.0 cocci
microblaze  randconfig-r2301-20261013    gcc-16.1.0 sparse
microblaze  randconfig-r2310-20261014    gcc-14.3.0 sparse
mips                     allmodconfig    gcc-16.1.0
mips                      allnoconfig    gcc-16.1.0
mips                     allyesconfig    gcc-16.1.0
mips        randconfig-r2103-20261013    clang-24   cocci
mips        randconfig-r2103-20261014    gcc-8.5.0  cocci
mips        randconfig-r2111-20261013    clang-24   cocci
mips        randconfig-r2201-20261014    clang-24   smatch
mips        randconfig-r2302-20261013    clang-24   sparse
mips        randconfig-r2307-20261014    gcc-14     sparse
mips        randconfig-r2307-20261014    gcc-14.3.0 sparse
nios2                     allnoconfig    gcc-11.5.0
nios2        randconfig-2000-20261013    gcc-11.5.0
nios2        randconfig-2000-20261014    gcc-8.5.0
nios2        randconfig-2001-20261013    gcc-11.5.0
nios2        randconfig-2001-20261014    gcc-8.5.0
nios2       randconfig-r2102-20261014    gcc-11.5.0 cocci
nios2       randconfig-r2308-20261013    gcc-13.4.0 sparse
openrisc                 allmodconfig    gcc-16.1.0
openrisc                  allnoconfig    gcc-16.1.0
openrisc    randconfig-r2108-20261014    gcc-11.5.0 cocci
openrisc    randconfig-r2310-20261013    gcc-13.4.0 sparse
parisc                   allmodconfig    gcc-16.1.0
parisc                    allnoconfig    gcc-16.1.0
parisc                   allyesconfig    gcc-16.1.0
parisc       randconfig-2000-20261013    gcc-11.5.0
parisc       randconfig-2000-20261014    gcc-8.5.0
parisc       randconfig-2001-20261013    gcc-11.5.0
parisc       randconfig-2001-20261014    gcc-8.5.0
parisc      randconfig-r2108-20261014    gcc-8.5.0  cocci
parisc      randconfig-r2202-20261014    gcc-12.5.0 smatch
parisc      randconfig-r2305-20261013    gcc-16.1.0 sparse
powerpc                  allmodconfig    gcc-16.1.0
powerpc                   allnoconfig    gcc-16.1.0
powerpc      randconfig-2000-20261013    gcc-14
powerpc      randconfig-2000-20261014    clang-22
powerpc      randconfig-2001-20261013    gcc-14
powerpc      randconfig-2001-20261014    clang-22
powerpc     randconfig-r2107-20261014    gcc-8.5.0  cocci
powerpc     randconfig-r2300-20261014    clang-24   sparse
powerpc     randconfig-r2301-20261013    gcc-16.1.0 sparse
powerpc     randconfig-r2302-20261013    gcc-16.1.0 sparse
powerpc64    randconfig-2000-20261013    gcc-14
powerpc64    randconfig-2000-20261014    clang-22
powerpc64    randconfig-2001-20261013    gcc-14
powerpc64    randconfig-2001-20261014    clang-22
powerpc64   randconfig-r2106-20261013    clang-24   cocci
powerpc64   randconfig-r2301-20261014    clang-24   sparse
powerpc64   randconfig-r2306-20261014    gcc-14.3.0 sparse
riscv                    allmodconfig    clang-24
riscv                     allnoconfig    gcc-16.1.0
riscv                    allyesconfig    clang-24
riscv        randconfig-2000-20261013    gcc-15.2.0
riscv        randconfig-2000-20261014    gcc-16.1.0
riscv        randconfig-2001-20261013    gcc-15.2.0
riscv        randconfig-2001-20261014    gcc-16.1.0
riscv       randconfig-r2307-20261013    gcc-13.4.0 sparse
s390                     allmodconfig    clang-24
s390                      allnoconfig    clang-24
s390                     allyesconfig    gcc-16.1.0
s390         randconfig-2000-20261013    gcc-15.2.0
s390         randconfig-2000-20261014    gcc-16.1.0
s390         randconfig-2001-20261013    gcc-15.2.0
s390         randconfig-2001-20261014    gcc-16.1.0
s390        randconfig-r2101-20261013    clang-24   cocci
s390        randconfig-r2106-20261014    gcc-8.5.0  cocci
s390        randconfig-r2200-20261014    gcc-8.5.0  smatch
s390        randconfig-r2311-20261014    gcc-14.3.0 sparse
sh                       allmodconfig    gcc-16.1.0
sh                        allnoconfig    gcc-16.1.0
sh                       allyesconfig    gcc-16.1.0
sh           randconfig-2000-20261013    gcc-15.2.0
sh           randconfig-2000-20261014    gcc-16.1.0
sh           randconfig-2001-20261013    gcc-15.2.0
sh           randconfig-2001-20261014    gcc-16.1.0
sh          randconfig-r2311-20261014    gcc-14     sparse
sparc                     allnoconfig    gcc-16.1.0
sparc        randconfig-2000-20261013    gcc-16.1.0
sparc        randconfig-2000-20261014    gcc-14.3.0
sparc        randconfig-2001-20261013    gcc-16.1.0
sparc        randconfig-2001-20261014    gcc-14.3.0
sparc       randconfig-r2103-20261013    clang-24   cocci
sparc       randconfig-r2110-20261014    gcc-8.5.0  cocci
sparc       randconfig-r2303-20261014    clang-24   sparse
sparc       randconfig-r2304-20261014    clang-24   sparse
sparc       randconfig-r2306-20261013    gcc-13.4.0 sparse
sparc       randconfig-r2309-20261014    gcc-14     sparse
sparc64                  allmodconfig    clang-20
sparc64      randconfig-2000-20261013    gcc-16.1.0
sparc64      randconfig-2000-20261014    gcc-14.3.0
sparc64      randconfig-2001-20261013    gcc-16.1.0
sparc64      randconfig-2001-20261014    gcc-14.3.0
sparc64     randconfig-r2105-20261013    clang-24   cocci
sparc64     randconfig-r2310-20261014    gcc-14     sparse
um                       allmodconfig    clang-17
um                        allnoconfig    clang-17
um                       allyesconfig    gcc-14
um           randconfig-2000-20261013    gcc-16.1.0
um           randconfig-2000-20261014    gcc-14.3.0
um           randconfig-2001-20261013    gcc-16.1.0
um           randconfig-2001-20261014    gcc-14.3.0
um          randconfig-r2102-20261013    clang-24   cocci
um          randconfig-r2104-20261013    clang-24   cocci
um          randconfig-r2109-20261014    gcc-8.5.0  cocci
um          randconfig-r2302-20261014    clang-24   sparse
um          randconfig-r2308-20261014    gcc-14     sparse
x86_64                    allnoconfig    clang-22
x86_64                          kexec    clang-22
x86_64       randconfig-2000-20261013    gcc-14
x86_64       randconfig-2000-20261014    clang-22
x86_64       randconfig-2001-20261013    gcc-14
x86_64       randconfig-2001-20261014    clang-22
x86_64       randconfig-2100-20261013    clang-22   cocci
x86_64       randconfig-2100-20261014    clang-22   cocci
x86_64       randconfig-2101-20261013    clang-22   cocci
x86_64       randconfig-2101-20261014    clang-22   cocci
x86_64       randconfig-2102-20261013    clang-22   cocci
x86_64       randconfig-2102-20261014    clang-22   cocci
x86_64       randconfig-2103-20261013    clang-22   cocci
x86_64       randconfig-2103-20261014    clang-22   cocci
x86_64       randconfig-2104-20261013    clang-22   cocci
x86_64       randconfig-2104-20261014    clang-22   cocci
x86_64       randconfig-2105-20261013    clang-22   cocci
x86_64       randconfig-2105-20261014    clang-22   cocci
x86_64       randconfig-2200-20261013    gcc-13     smatch
x86_64       randconfig-2200-20261014    clang-22   smatch
x86_64       randconfig-2300-20261013    gcc-14     sparse
x86_64       randconfig-2300-20261014    clang-22   sparse
x86_64       randconfig-2301-20261013    gcc-14     sparse
x86_64       randconfig-2301-20261014    clang-22   sparse
x86_64       randconfig-2302-20261013    gcc-14     sparse
x86_64       randconfig-2302-20261014    clang-22   sparse
x86_64      randconfig-r2100-20261013    gcc-14     cocci
x86_64      randconfig-r2109-20261014    gcc-11.5.0 cocci
x86_64      randconfig-r2202-20261013    gcc-14     smatch
x86_64      randconfig-r2202-20261014    clang-22   smatch
x86_64      randconfig-r2306-20261014    gcc-14     sparse
x86_64                       rhel-9.4    clang-22
x86_64                   rhel-9.4-bpf    clang-22
x86_64                  rhel-9.4-func    clang-22
x86_64            rhel-9.4-kselftests    clang-22
x86_64                 rhel-9.4-kunit    clang-22
x86_64                   rhel-9.4-ltp    clang-22
x86_64                  rhel-9.4-rust    clang-22
x86_64                  rhel-9.4-rust    clang-22
xtensa                    allnoconfig    gcc-16.1.0
xtensa                   allyesconfig    gcc-16.1.0
xtensa       randconfig-2000-20261013    gcc-16.1.0
xtensa       randconfig-2000-20261014    gcc-14.3.0
xtensa       randconfig-2001-20261013    gcc-16.1.0
xtensa       randconfig-2001-20261014    gcc-14.3.0
xtensa      randconfig-r2100-20261014    gcc-11.5.0 cocci
xtensa      randconfig-r2303-20261014    clang-24   sparse
xtensa      randconfig-r2309-20261013    gcc-13.4.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

