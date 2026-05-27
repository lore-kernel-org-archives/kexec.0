Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33449CD5BD0
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 17:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rBSXiIFXNgXvoNV6rzPUz8xexiPcAz++SKcaTtvcXf4=; b=XOSAZP4Y8TwlzvsrJgN0FQbQEv
	a+G7Ya03pKffoMhnIxbDLIbl8s1+v1+rZ1tGeNVQGdM0CM+lt/4Avu/PGgHzRj7/xWuCTVZbaGtnM
	yGrv+1hujJWvmvC2/JrYIuHpJ98QCTmrQGTBVfi8nx3txMMKp+NL/Vr3kke0q1fWXA0nn3/KydcVM
	5cWtx0Y/HboW+9ploncQCIrjG2TYvIGeftW4oo19uTCS06NPsIhARSnboN5s+3GIQPx2LxCempkBF
	iL6SHyjOsjR9WaEsSKAJryguGd58uzidSpqfMAEljNX5cfkonRtOZq4M/DwnpCgVMQ0yTnmpE1FRQ
	b9N3FSJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSHvo-00000004Zjt-3Dwy;
	Wed, 27 May 2026 17:20:36 +0000
Received: from mgamail.intel.com ([192.198.163.14])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSHvm-00000004Zj6-0GLx
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 17:20:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779902434; x=1811438434;
  h=date:from:to:cc:subject:message-id;
  bh=qQjUoE6OT9W8V8CpecDNqQPpXP+1el1WW3Sge8+xgeY=;
  b=XAsRXhB5ATOhzEsA016I7Ziciq7pYK77aaxO8o1abC4YhlJNLgD1cFkO
   aH3RKtFJ/dX/VaTDCybk29zGYVSQjxfJQRTqnlY0qU2e2i0aqTJyCzdnd
   0mEzFcM3xNCQWuF8ej2hDQlebc03KiKg+GNzb8xDXYutaGyDrAA5g6Lhy
   py6xuDcSm0iHH0Q54JEIyi1g7W18aCVFNfE/NvXbDy2wKkeaMup4sGpew
   3LACPsi7Bp+zK/9/swalxIl5dtAXrOridAl4Dq8iygUw0uRQ4doTfeyhy
   t5ck/pXaB2Tq8GR43SdbEdY1AntGfKgrUQYZSJklnWGxiBRSuFnyq+LjP
   Q==;
X-CSE-ConnectionGUID: jUhCOEO6R0SpRrZ8SqcN9w==
X-CSE-MsgGUID: UzxI68F9Qp2BhkzPcpqq+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80772563"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="80772563"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 10:20:32 -0700
X-CSE-ConnectionGUID: 0O4rotYEQPaIuNUJqI0Isg==
X-CSE-MsgGUID: wk5p3MMtRj6O6p+iOE4eFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="242451572"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 27 May 2026 10:20:31 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSHvf-000000004GE-12G1;
	Wed, 27 May 2026 17:20:27 +0000
Date: Thu, 28 May 2026 01:19:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:fixes] BUILD SUCCESS
 3a29a9841f4bfb79840f7d1f8115cc7b25e744e3
Message-ID: <202605280143.Rnjk00YT-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_102034_115148_656BF9DA 
X-CRM114-Status: UNSURE (   4.08  )
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
branch HEAD: 3a29a9841f4bfb79840f7d1f8115cc7b25e744e3  kho: make sure scratch size is always aligned by CMA_MIN_ALIGNMENT_BYTES

elapsed time: 1514m

configs tested: 63
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha            allnoconfig    gcc-15.2.0
alpha           allyesconfig    gcc-15.2.0
arc             allmodconfig    gcc-15.2.0
arc              allnoconfig    gcc-15.2.0
arc             allyesconfig    gcc-15.2.0
arm              allnoconfig    clang-23
arm             allyesconfig    gcc-15.2.0
arm64           allmodconfig    clang-19
arm64            allnoconfig    gcc-15.2.0
csky            allmodconfig    gcc-15.2.0
csky             allnoconfig    gcc-15.2.0
hexagon         allmodconfig    clang-17
hexagon          allnoconfig    clang-23
i386            allmodconfig    gcc-14
i386             allnoconfig    gcc-14
i386            allyesconfig    gcc-14
loongarch       allmodconfig    clang-19
loongarch        allnoconfig    clang-23
m68k            allmodconfig    gcc-15.2.0
m68k             allnoconfig    gcc-15.2.0
m68k            allyesconfig    gcc-15.2.0
microblaze       allnoconfig    gcc-15.2.0
microblaze      allyesconfig    gcc-15.2.0
mips            allmodconfig    gcc-15.2.0
mips             allnoconfig    gcc-15.2.0
mips            allyesconfig    gcc-15.2.0
nios2           allmodconfig    gcc-11.5.0
nios2            allnoconfig    gcc-11.5.0
openrisc        allmodconfig    gcc-15.2.0
openrisc         allnoconfig    gcc-15.2.0
openrisc           defconfig    gcc-15.2.0
parisc          allmodconfig    gcc-15.2.0
parisc           allnoconfig    gcc-15.2.0
parisc          allyesconfig    gcc-15.2.0
powerpc         allmodconfig    gcc-15.2.0
powerpc          allnoconfig    gcc-15.2.0
powerpc     arches_defconfig    gcc-15.2.0
riscv           allmodconfig    clang-23
riscv            allnoconfig    gcc-15.2.0
riscv           allyesconfig    clang-16
s390            allmodconfig    clang-18
s390             allnoconfig    clang-23
s390            allyesconfig    gcc-15.2.0
sh              allmodconfig    gcc-15.2.0
sh               allnoconfig    gcc-15.2.0
sh              allyesconfig    gcc-15.2.0
sh                 defconfig    gcc-15.2.0
sparc            allnoconfig    gcc-15.2.0
sparc              defconfig    gcc-15.2.0
sparc64         allmodconfig    clang-23
sparc64            defconfig    clang-20
um              allmodconfig    clang-19
um               allnoconfig    clang-23
um              allyesconfig    gcc-14
um                 defconfig    clang-23
um            i386_defconfig    gcc-14
um          x86_64_defconfig    clang-23
x86_64          allmodconfig    clang-20
x86_64           allnoconfig    clang-20
x86_64          allyesconfig    clang-20
x86_64             defconfig    gcc-14
x86_64         rhel-9.4-rust    clang-20
xtensa           allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

