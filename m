Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E838C624D3
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 19:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+Ds1CN7wyBj0/WD3A2+TCEoFvSmR/wlQd0q1DEgmO68=; b=gi3LfsKI5lAMrS6UBSUI+/FKyp
	HOYBJCOOKWFKQbT5J76jzni2aPxMyRTzZeM9GCuPaZVo1SV/jdYeqkZoGyg4x31750QuQXollew2a
	BZambXAwlVjJ55muubDyd+0OxxiQd3rLIAFVOAVfPYFbAj5ZbIcguKdyxmztKQ9ajra01YT91KJA5
	GQ3hhONACzH5EkkT9hCpgpKDGqmxT1Ta4UG+VPMPbDV3NVcfGXzkoXipnYlxVf3hSDcsCF8xP0Z25
	n60cFn+rIAqSNeim/wcke3EO0Cku0nCcCLTPU1QYRaFrVC4XNyw0nW/qhVNFIch49TwvKPGncdWgG
	mmX1LyUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1qFW-0000000FeUB-07CZ;
	Wed, 02 Sep 2026 19:03:54 +0000
Received: from mgamail.intel.com ([198.175.65.16])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1qFT-0000000FeTW-1eTB
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 19:03:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788375832; x=1819911832;
  h=date:from:to:cc:subject:message-id;
  bh=MZiB87hgpszJdY4Lc7Q0El+74BQGAHaSj1QLOdLBHA0=;
  b=CtZxvopVJ4Ky8pzaRE1NykI2tEcg3Gi8gZ5+HeuFUi3yoo5s6KIjPoHm
   CCKnNisw6dxTLt/SxeQ88NHGgTHe+iBlOT4UYqyIJ4JlgyrJ0XC7hiyI9
   ox/ctvAEOBiCy6cVepb4yrM8W4l7jnWEvRYFXFOCDwZfMG5cZyglkLQo+
   AY5+o8BK52qZNnt99gCmYeA3l9pTXVC+xstwjJwpPGlKlSrk5eW9+uFdx
   YrPXTfrkqXkyTHDbcG5Mvy8s/qy6AiJ+A5m/VHQh6Dae50Ihc4VfjBPro
   F5nBHPc8el1yYaNhaw8mh+Uwsib8M0BPyXQUA8MKfANFNKPsAEcUXqcLP
   g==;
X-CSE-ConnectionGUID: zizYLqkbSk2z0XMYy2q05A==
X-CSE-MsgGUID: Rd4dNt2BRPaUR79zj4Lauw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="89057143"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="89057143"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 12:03:51 -0700
X-CSE-ConnectionGUID: rtMcp61zSxWFaJS4X6YyUw==
X-CSE-MsgGUID: nDk0159OQxeYdjP5Mh2mow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="273655138"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 02 Sep 2026 12:03:50 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1qFO-000000003CK-4BO3;
	Wed, 02 Sep 2026 19:03:46 +0000
Date: Thu, 03 Sep 2026 03:02:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:next] BUILD SUCCESS
 c65687600ed075d237a204755d99ad538db34b47
Message-ID: <202609030343.GkSvz1hb-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_120351_466760_79BC71EB 
X-CRM114-Status: UNSURE (   4.45  )
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
branch HEAD: c65687600ed075d237a204755d99ad538db34b47  Merge branch 'luo-internal-api' into next

elapsed time: 847m

configs tested: 59
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    clang-24
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arm           allnoconfig    clang-17
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    clang-24
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    gcc-16.1.0
hexagon       allnoconfig    clang-24
hexagon       allnoconfig    gcc-16.1.0
i386         allmodconfig    clang-22
i386          allnoconfig    gcc-14
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    clang-22
loongarch    allmodconfig    clang-24
loongarch     allnoconfig    clang-20
loongarch     allnoconfig    gcc-16.1.0
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    clang-24
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    clang-20
nios2         allnoconfig    clang-24
openrisc     allmodconfig    clang-20
openrisc      allnoconfig    clang-24
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    clang-24
parisc       allyesconfig    clang-17
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh           allyesconfig    clang-17
sparc         allnoconfig    clang-24
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-24
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa       allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

