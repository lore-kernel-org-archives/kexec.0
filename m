Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C763C4452B
	for <kexec@archiver.kernel.org>; Wed, 22 Jul 2026 01:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PWJPdQbgXvN1BKtJTPS9Ptqk6cPm9qINg5SGGwWRji0=; b=bKx7CbvdElijnbuRXEbKNqXMC8
	Rzx7cAQOlNRlx3h9b9Qz/FS5Avhh8gaNjMLnTzePouAjZq6W2QzaYwwPNQluiYjLpEYn+l4BTmHoY
	Rn+DeTSrmMXw6hs+guN9d1fDCyNhc7A/c4m2VxpF1+mHY2fQp/egZZ/b640aRFksd+ldjj5CZUYil
	eU6pXSBAEwjye7XDjownVfwr8j6yzEcFBbCoScBvIZVk4TmWs5M5qAA/KSd85gj0H1Cmv+lAPQ+bK
	TqDuN4htf2EjsfW7U283eEZgmPLXakW9uo9zSwZ5vMpjBa2iK8ie+tc6v//lOK202kUjzsf2NcVgr
	kV2LL+Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmLkO-0000000AiU0-03th;
	Wed, 22 Jul 2026 01:27:44 +0000
Received: from mgamail.intel.com ([198.175.65.13])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmLkK-0000000AiTU-3KVv
	for kexec@lists.infradead.org;
	Wed, 22 Jul 2026 01:27:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784683661; x=1816219661;
  h=date:from:to:cc:subject:message-id;
  bh=+ktUOjNWgU31FC1PNdcMRJWm4mIRl3z8cEzhuOmsECs=;
  b=XaOigbvQda1KNa4z5FM9yWIpIj1zrUmXS9CN4IwkKc19UaDy699Jhiq6
   IiwmRObfz8P1BztFck5vZqsi8Q+mqUbFgLwZc/ny6xBXgX9Bmytfq2Tge
   EjzVW5ioWbxKLzJX1yAbOgInV5vRbXc2vMxuubGiccCdH2p/IM50tjq2K
   Evt2VxQkHrYCi0msNMjOv+e4CQnYejVCQQU03nZOHsdpvR0vGWNU1hUWp
   iP/APUB/hde+XWVDaaCRWDjWgEsroX0Q5SYLuFGwK5MT+O6W5eG4MeODE
   oUzC3E/KOS6bLXV9/yYaU7uJLZ5qZxCQqmoGy91bj4wN8NTt6OQzsVJ/9
   A==;
X-CSE-ConnectionGUID: tgg6CVAKS4yQYGBmdGD26g==
X-CSE-MsgGUID: mB4qBlIdRdiJzw2NSd2VBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="96441515"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="96441515"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 18:27:39 -0700
X-CSE-ConnectionGUID: uboJCTdkSw6HJ/vrYDdkdA==
X-CSE-MsgGUID: AD7ImNyKSjG6MdW8rZV4Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="254532462"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 21 Jul 2026 18:27:36 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wmLkD-00000000YH7-3cxz;
	Wed, 22 Jul 2026 01:27:33 +0000
Date: Wed, 22 Jul 2026 09:27:08 +0800
From: kernel test robot <lkp@intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:fixes] BUILD SUCCESS
 b9eef6dba737731021234ca64dbb7cd5fb267da4
Message-ID: <202607220949.u6k6M5v8-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_182740_937889_8DFB8466 
X-CRM114-Status: UNSURE (   4.44  )
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
branch HEAD: b9eef6dba737731021234ca64dbb7cd5fb267da4  liveupdate: Remember FLB retrieve() status

elapsed time: 1536m

configs tested: 42
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                  allnoconfig    gcc-16.1.0
alpha                 allyesconfig    gcc-16.1.0
alpha                    defconfig    gcc-16.1.0
arc                   allmodconfig    gcc-16.1.0
arc                   allyesconfig    gcc-16.1.0
arc        randconfig-001-20260722    clang-24
arc        randconfig-002-20260722    clang-24
arm               ep93xx_defconfig    clang-24
arm        randconfig-001-20260722    clang-24
arm        randconfig-002-20260722    clang-24
arm        randconfig-003-20260722    clang-24
arm        randconfig-004-20260722    clang-24
csky                  allmodconfig    gcc-16.1.0
hexagon    randconfig-001-20260722    gcc-8.5.0
hexagon    randconfig-002-20260722    gcc-8.5.0
i386                  allmodconfig    gcc-14
loongarch                defconfig    clang-24
loongarch  randconfig-001-20260722    gcc-8.5.0
loongarch  randconfig-002-20260722    gcc-8.5.0
nios2                 allmodconfig    gcc-11.5.0
nios2                  allnoconfig    gcc-11.5.0
nios2      randconfig-001-20260722    gcc-8.5.0
nios2      randconfig-002-20260722    gcc-8.5.0
parisc                allmodconfig    gcc-16.1.0
parisc                allyesconfig    gcc-16.1.0
parisc                   defconfig    gcc-16.1.0
riscv      randconfig-001-20260722    gcc-13.4.0
riscv      randconfig-002-20260722    gcc-13.4.0
s390       randconfig-001-20260722    gcc-13.4.0
s390       randconfig-002-20260722    gcc-13.4.0
sh                       defconfig    gcc-16.1.0
sh         randconfig-001-20260722    gcc-13.4.0
sh         randconfig-002-20260722    gcc-13.4.0
sparc      randconfig-001-20260722    gcc-9.5.0
sparc      randconfig-002-20260722    gcc-9.5.0
sparc64    randconfig-001-20260722    gcc-9.5.0
sparc64    randconfig-002-20260722    gcc-9.5.0
um         randconfig-001-20260722    gcc-9.5.0
um         randconfig-002-20260722    gcc-9.5.0
x86_64                rhel-9.4-bpf    gcc-14
xtensa     randconfig-001-20260722    gcc-9.5.0
xtensa     randconfig-002-20260722    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

