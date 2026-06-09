Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E78CD8CB2
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 18:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qcfo008Zm7brwkezNDYHV7n2X+7Wv1MSJej9rbrfBdw=; b=HmN8k0yAK/iBYRXy/oMVeBqI4Y
	anwr8dWSQ2Mnw6+SK8wxL34Di32Y2OdvUR8GTkSLrqlVdon/RPR6Khxrpo48AROCF808E7bWlBiZn
	ZLTX7/IDl7jL3YPHpko5xEs2x/g278JgO3n7gNfhif8HX7su0Pw6v8XIP9f5ui2TZ+OR09FYTyzcJ
	UbTvNClBjUqguK1hvIcsheQiK4HsbGu1Z9QIPIHqGEvJHaelnsWLwnEIdQ7P7T0iNF95qbOnsKgIM
	6C6EHfdCjHnWjFbnz7OmQgUgrZEv+/Ar+YDPnTWSBmqGYzw6KxI5GzPOrnxZRMk/v/iEFxV2M+0pS
	Ps/OR8SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX0tQ-00000006AaU-0ee8;
	Tue, 09 Jun 2026 18:09:40 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX0tN-00000006Aa2-0Btg
	for kexec@lists.infradead.org;
	Tue, 09 Jun 2026 18:09:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781028578; x=1812564578;
  h=date:from:to:cc:subject:message-id;
  bh=/XunfoSHNyhyM6u9e3a7WY5CHsR4sQzPpeXpGugbGzg=;
  b=eWLTtssPIK99Cjt6ttr/R7RsusH+tU/n8LuMZEFinSJi3k/hD9/L+8ij
   ioSP+at6hVijg4FRLHrr1RMs8OX6VBUQOuucT5hPewbBYY2QpINMmaYif
   KGrd7BMypyA4UHjy6/szn8W2TnkJcyQQtUmn5sZLVqbusglW/bOjl8orw
   u6VZQeCuj98kMpjYv95twZr+dynFDPVkCNShllFiTjTDLa7+gZq2+Yrxm
   01dID/AfDr+ruU1B0nMbBoSJX7wykUgBf34SEQcVC6D2h7v57V2jw5Hdc
   uTlGQFMF3Dxxrg9lX0sWzcMp+lKk3AtnaQyzW2lTq1FvNrDf2bLCHfbPu
   Q==;
X-CSE-ConnectionGUID: oB/wrGXnSwKdPIfOHXUkTA==
X-CSE-MsgGUID: 2QABAVUVRU+F1j4KI0ql6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81780195"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81780195"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 11:09:37 -0700
X-CSE-ConnectionGUID: E5pmVqTSQTiRMSdWkoYQqg==
X-CSE-MsgGUID: daHd0vi9S6uMei/xfcE8rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="242969134"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 09 Jun 2026 11:09:33 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wX0tG-00000000KOo-3hqk;
	Tue, 09 Jun 2026 18:09:30 +0000
Date: Wed, 10 Jun 2026 02:08:39 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:next] BUILD SUCCESS
 3a358c78093f98a70d84c934b7054f636bc846f2
Message-ID: <202606100230.sVvt4W2L-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_110937_126865_F30456D9 
X-CRM114-Status: UNSURE (   4.24  )
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
branch HEAD: 3a358c78093f98a70d84c934b7054f636bc846f2  docs: memfd_preservation: fix rendering of ABI documentation

elapsed time: 3616m

configs tested: 81
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha               allnoconfig    gcc-16.1.0
alpha              allyesconfig    gcc-16.1.0
arc                allmodconfig    gcc-16.1.0
arc                 allnoconfig    gcc-16.1.0
arc                allyesconfig    clang-23
arc                allyesconfig    gcc-16.1.0
arm                 allnoconfig    clang-23
arm                 allnoconfig    gcc-16.1.0
arm                allyesconfig    gcc-16.1.0
arm64              allmodconfig    clang-23
arm64               allnoconfig    gcc-16.1.0
csky               allmodconfig    gcc-16.1.0
csky                allnoconfig    gcc-16.1.0
hexagon            allmodconfig    clang-23
hexagon            allmodconfig    gcc-16.1.0
hexagon             allnoconfig    clang-23
hexagon             allnoconfig    gcc-16.1.0
i386               allmodconfig    gcc-14
i386                allnoconfig    gcc-14
i386                allnoconfig    gcc-16.1.0
i386               allyesconfig    gcc-14
loongarch          allmodconfig    clang-19
loongarch          allmodconfig    clang-23
loongarch           allnoconfig    clang-20
loongarch           allnoconfig    gcc-16.1.0
m68k               allmodconfig    gcc-16.1.0
m68k                allnoconfig    gcc-16.1.0
m68k               allyesconfig    gcc-16.1.0
microblaze          allnoconfig    gcc-16.1.0
microblaze         allyesconfig    gcc-16.1.0
mips               allmodconfig    gcc-16.1.0
mips                allnoconfig    gcc-16.1.0
mips               allyesconfig    gcc-16.1.0
nios2              allmodconfig    clang-20
nios2               allnoconfig    clang-23
nios2               allnoconfig    gcc-11.5.0
openrisc           allmodconfig    clang-20
openrisc           allmodconfig    gcc-16.1.0
openrisc            allnoconfig    clang-23
openrisc            allnoconfig    gcc-16.1.0
parisc             allmodconfig    gcc-16.1.0
parisc              allnoconfig    clang-23
parisc              allnoconfig    gcc-16.1.0
parisc             allyesconfig    gcc-16.1.0
powerpc            allmodconfig    gcc-16.1.0
powerpc             allnoconfig    clang-23
powerpc             allnoconfig    gcc-16.1.0
riscv              allmodconfig    clang-23
riscv               allnoconfig    clang-23
riscv               allnoconfig    gcc-16.1.0
riscv              allyesconfig    clang-23
s390               allmodconfig    clang-23
s390                allnoconfig    clang-23
s390               allyesconfig    gcc-16.1.0
sh                 allmodconfig    gcc-16.1.0
sh                  allnoconfig    clang-23
sh                  allnoconfig    gcc-16.1.0
sh                 allyesconfig    gcc-16.1.0
sparc               allnoconfig    clang-23
sparc               allnoconfig    gcc-16.1.0
sparc64            allmodconfig    clang-20
um                 allmodconfig    clang-23
um                  allnoconfig    clang-16
um                  allnoconfig    clang-23
um                 allyesconfig    gcc-14
um                 allyesconfig    gcc-16.1.0
x86_64             allmodconfig    clang-22
x86_64              allnoconfig    clang-22
x86_64              allnoconfig    clang-23
x86_64             allyesconfig    clang-22
x86_64                    kexec    clang-22
x86_64                 rhel-9.4    clang-22
x86_64             rhel-9.4-bpf    gcc-14
x86_64            rhel-9.4-func    clang-22
x86_64      rhel-9.4-kselftests    clang-22
x86_64           rhel-9.4-kunit    gcc-14
x86_64             rhel-9.4-ltp    gcc-14
x86_64            rhel-9.4-rust    clang-22
xtensa              allnoconfig    clang-23
xtensa              allnoconfig    gcc-16.1.0
xtensa             allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

