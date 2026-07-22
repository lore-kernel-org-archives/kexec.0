Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657CEC4453A
	for <kexec@archiver.kernel.org>; Wed, 22 Jul 2026 09:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Yt4fX2V41JoWb66BMZ7kuMPdFFex98Vpkx59Jis9Vms=; b=PCXgZSAvo1nHNV5pMpEhddLRse
	ywGaN2CMciP03Ajf0RE9coVE+qpHmn9w85k4VNbBFZKg0N5P1Oo12K4kCGEJ7OoYzoLIC/EXifpnW
	oM65WZXSmVFXQqb3oGc4Bt+03BWgGDGRhbmYeHgw7HB1G5f+qgh5NhQHS7A0pyY3cB/wrGKP7te3E
	RWXud89oqm31+NSBd8jafzBz1iYgIwYihuJf8jQGC2cJyXItpUB+sPIPKZPVn/g404JaszBS4Bkey
	GyRpudDgYWqmfu8ncUjtaT+9BBjCWnnw2elLhWsxRkRHkJ+y1aYAlvizCqrGVYnhSli1XhIeddUVJ
	xq+8aLPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmTFX-0000000BPji-0m45;
	Wed, 22 Jul 2026 09:28:23 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmTFU-0000000BPid-15n1
	for kexec@lists.infradead.org;
	Wed, 22 Jul 2026 09:28:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784712500; x=1816248500;
  h=date:from:to:cc:subject:message-id;
  bh=HI2t/qRUSraIX5ze3SSBzjZdFbiXgvNqFEAZejTDWSY=;
  b=Hycgh8d3jcXDYosc0eRZox1+GUWNHA9w0FhB4ONGiYjfUvF0E/ANGdYP
   da4NsA5R8TSOr8O59pXRaZgRhZsG0AJRSrUjR+zO+2InGNh8Bla524dyZ
   Xw/h96mxxNkM+/t6geFpXJudH+VGcrRbD/J16NzRtH4quNTUZAnHjwFXR
   L13xPjGNkF2m4MKaW0bzrdX3HCGzqfEv4nSCGRnB7PsQ4sXB9EFk9Eb8n
   E0kCXxs3MZ0lcdo/dol+gPdfDUHG+URZW6jXX7UsLQFmdIr/UG/FahQze
   U/wym0C7FNIjUUfnKjI0Mtk/H3MuRlOL/UqSzrHchQK+AhzK1E4BYldXO
   g==;
X-CSE-ConnectionGUID: 7lJ3gfsgTma6CAxlQMa7NA==
X-CSE-MsgGUID: sj2f+IM/Q7mlPJ0K2vRkNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="108133408"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="108133408"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 02:28:18 -0700
X-CSE-ConnectionGUID: BnYGyTpaRJe7DpurUXKCNg==
X-CSE-MsgGUID: JVGo+HrmRt2ALI2stxuzZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="261825019"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 22 Jul 2026 02:28:17 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wmTFO-00000000YcL-0VyY;
	Wed, 22 Jul 2026 09:28:14 +0000
Date: Wed, 22 Jul 2026 17:28:03 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:next] BUILD SUCCESS
 ac2e21f50db7fe435a4a3fdb8a24ec0de840035f
Message-ID: <202607221751.ThEZW7FL-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_022820_384315_66B89DEE 
X-CRM114-Status: UNSURE (   4.29  )
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
branch HEAD: ac2e21f50db7fe435a4a3fdb8a24ec0de840035f  Merge branch 'selftests-lib' into next

elapsed time: 786m

configs tested: 85
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260722    clang-24
arc                  randconfig-002-20260722    clang-24
arm                         ep93xx_defconfig    clang-24
arm                  randconfig-001-20260722    clang-24
arm                  randconfig-002-20260722    clang-24
arm                  randconfig-003-20260722    clang-24
arm                  randconfig-004-20260722    clang-24
arm64                randconfig-001-20260722    clang-17
arm64                randconfig-002-20260722    clang-17
arm64                randconfig-003-20260722    clang-17
arm64                randconfig-004-20260722    clang-17
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260722    clang-17
csky                 randconfig-002-20260722    clang-17
hexagon              randconfig-001-20260722    gcc-8.5.0
hexagon              randconfig-002-20260722    gcc-8.5.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260722    clang-22
i386       buildonly-randconfig-002-20260722    clang-22
i386       buildonly-randconfig-003-20260722    clang-22
i386       buildonly-randconfig-004-20260722    clang-22
i386       buildonly-randconfig-005-20260722    clang-22
i386       buildonly-randconfig-006-20260722    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260722    gcc-8.5.0
loongarch            randconfig-002-20260722    gcc-8.5.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260722    gcc-8.5.0
nios2                randconfig-002-20260722    gcc-8.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260722    gcc-8.5.0
parisc               randconfig-002-20260722    gcc-8.5.0
powerpc              randconfig-001-20260722    gcc-8.5.0
powerpc              randconfig-002-20260722    gcc-8.5.0
powerpc64            randconfig-001-20260722    gcc-8.5.0
powerpc64            randconfig-002-20260722    gcc-8.5.0
riscv                randconfig-001-20260722    gcc-13.4.0
riscv                randconfig-002-20260722    gcc-13.4.0
s390                 randconfig-001-20260722    gcc-13.4.0
s390                 randconfig-002-20260722    gcc-13.4.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260722    gcc-13.4.0
sh                   randconfig-002-20260722    gcc-13.4.0
sparc                randconfig-001-20260722    gcc-9.5.0
sparc                randconfig-002-20260722    gcc-9.5.0
sparc64              randconfig-001-20260722    gcc-9.5.0
sparc64              randconfig-002-20260722    gcc-9.5.0
um                   randconfig-001-20260722    gcc-9.5.0
um                   randconfig-002-20260722    gcc-9.5.0
x86_64     buildonly-randconfig-001-20260722    gcc-14
x86_64     buildonly-randconfig-002-20260722    gcc-14
x86_64     buildonly-randconfig-003-20260722    gcc-14
x86_64     buildonly-randconfig-004-20260722    gcc-14
x86_64     buildonly-randconfig-005-20260722    gcc-14
x86_64     buildonly-randconfig-006-20260722    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260722    clang-22
x86_64               randconfig-002-20260722    clang-22
x86_64               randconfig-003-20260722    clang-22
x86_64               randconfig-004-20260722    clang-22
x86_64               randconfig-005-20260722    clang-22
x86_64               randconfig-006-20260722    clang-22
x86_64               randconfig-011-20260722    clang-22
x86_64               randconfig-012-20260722    clang-22
x86_64               randconfig-013-20260722    clang-22
x86_64               randconfig-014-20260722    clang-22
x86_64               randconfig-015-20260722    clang-22
x86_64               randconfig-016-20260722    clang-22
x86_64               randconfig-071-20260722    clang-22
x86_64               randconfig-072-20260722    clang-22
x86_64               randconfig-073-20260722    clang-22
x86_64               randconfig-074-20260722    clang-22
x86_64               randconfig-075-20260722    clang-22
x86_64               randconfig-076-20260722    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260722    gcc-9.5.0
xtensa               randconfig-002-20260722    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

