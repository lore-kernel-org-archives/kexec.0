Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67900C624D3
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 19:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ew4As8V/ErrbcXL/1PF1a4DnyvgwkbSfqDN7cBHBGLU=; b=Ydi4BW20FD3ly/do73rla4hN5L
	jDxITUU+RNRTQqJ1SEQUTx81R+TXPxgNnDXC7QOlcI8gmU6W+aVLKmHOJedjs5r68FpSX4OfsLuPT
	R0QLIpebFSV1azl7wuvW6E14QvT0dZjnMM/0KlcVMo2C+4HJHWbW4DsDGe6y1XJoZPjcv5M/r7QQe
	+/5Z2crWKvqYGOpWuNfSPO2jpzHCvlZcEOX33U5YHFo9eJet1jj+NTIUxyyc38ChvfYOVlcyxrS94
	Sdc2eTri+3gwoiMi2AOD7aFxJnexkgQxbiW0lQVibxtWSVoecRM73JsW9MORzaoF/Jn6jzp9EDeem
	oc+FRHig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1qEW-0000000FeJ9-3hU4;
	Wed, 02 Sep 2026 19:02:52 +0000
Received: from mgamail.intel.com ([198.175.65.15])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1qEV-0000000FeIb-0GTf
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 19:02:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788375772; x=1819911772;
  h=date:from:to:cc:subject:message-id;
  bh=IEFbRIeJWaEC+gcaFFlo1gQaMegwFO3ADFWPpnMzqCY=;
  b=KApHUn3/N2twKoxvaphnAR++rtE/GINAuJJ1h9v8h50IpdN9VHhEdu+m
   HoQfzVvgZkk+NnfqQJ4FPn7uCZCAHpjJLAuON4O1gFGk0/si9nFtMGmAx
   rfLaDEyLZiKwuEjX+krTVXSvs7usiznJU6mjwJFOnOrxCnjHXWrwnGC+c
   y4oCiNb8ZdUdRAMXIcokcXV56/p2sS1elnMxsWqaydilQOiFuuQfC5ph/
   rMugfAawitOLmYuigSjTH08KAkVTWSrImHbjN0eSn2KdL5e/1nQiJdXSd
   XuWbhDUmS8fUlhTTs2WCEm6XRwysDAr99ZHkALhkobsh+4Y+ErfpI8Enr
   w==;
X-CSE-ConnectionGUID: blakgNe6SXKlv5u6/SHFOw==
X-CSE-MsgGUID: LKkWj9ryQ8yuZZnxApg7Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92547713"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92547713"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 12:02:51 -0700
X-CSE-ConnectionGUID: 1wPPrByXQaW3pYvO17nK6A==
X-CSE-MsgGUID: iyCaVk1ZTBGzfS6FXsy/QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="268951247"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 02 Sep 2026 12:02:49 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1qEQ-000000003C4-3fCm;
	Wed, 02 Sep 2026 19:02:46 +0000
Date: Thu, 03 Sep 2026 03:02:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:kexec-next] BUILD SUCCESS
 c6ed7331aad89976a37469be7be6e2f110378720
Message-ID: <202609030327.InUFDGOq-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_120251_143127_2F7D3C35 
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git kexec-next
branch HEAD: c6ed7331aad89976a37469be7be6e2f110378720  Merge branch 'kexec-7.4.hwpoison' into kexec-next

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

