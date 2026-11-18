Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62803606A339
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0McvQg/M;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ChW35n69
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=S9Gl97R355eEIFdDWn8FRy/nv86gHiai7H/r2bnhqTU=; b=0McvQg/Mzz6Lhl+gMYFAKU0IB+
	RzRtBOxgaRdKLnRVeXgiN+uxEf9+0BtvOnSKbj+EbZ5OmVngaLnXrYH3eeXjSg+u+tA7Q42EYeLcT
	DJ8LB7L2e4AVZSgxmv7ti/GgtXNinB5i21YF6sdpWhK5hDLOuf20YcjJk7H5I8kPJ9Um8LXHSm8S3
	g5+YW7E4vjXjcES3J1mF0OXToCposeLR8D2OsHd4FRsBozsazjMm8wWGZPiLKSNpycLz72+c7lw1a
	HXzO9+vVa1bqfowkPQsuAsZXE//6iVVBnPoBmh9E9WxA/tn1oCO/mOR8M6qck76moOYVkukKmLEkD
	u+mIO1aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTiCB-00000009PUP-050z;
	Wed, 18 Nov 2026 16:07:39 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTiC8-00000009PTg-0pkd
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 16:07:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795018056; x=1826554056;
  h=date:from:to:cc:subject:message-id;
  bh=ebzsrhVkL3tjcgEsiSYU/6EC8TPhrJDGxeEal1TGGjM=;
  b=ChW35n699XDTV4aDdI1KxxL3aEriXx9Sj1DzZgleXaO7Jz4Ow8RKkOMt
   orJvRKIfoalqBE/0JgE6nA5fiddzrXaG3DtGueQnn7qOAzT8f2t3A5YHX
   LY/03Zg6JT6dFKZaMIxEv4yVLf1LiDdNWAxxxKrDAL/tXx8SsLzbzG2mA
   swIGHHB+Ced70IOu/H7qi0N3x4fj7WWe2i7mFoWO5pel4t3driiALi3ZG
   Od56LWwQGL8Dg/Wmn7PtWqbuT9pNNVzYw2qd3cG0RLxbxdxkqpkJX9f3n
   l1TQehWcumi3MdqHNf6jXlH+YOClFkm0jE0Ay9YbONTWj/hprR4rebUCm
   Q==;
X-CSE-ConnectionGUID: XB7ff2C3TuygbrT4rwcsCA==
X-CSE-MsgGUID: z081ku1fSQyoYwKiuTvptQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3826207"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3826207"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:07:20 -0800
X-CSE-ConnectionGUID: Y5O7lMsgQmSJRaWRGrfX5w==
X-CSE-MsgGUID: 7cUKTJbeSyuaI3wqFvhHOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10274559"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 18 Nov 2026 08:07:19 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xTiBo-00000001DmP-2LLz;
	Wed, 18 Nov 2026 16:07:16 +0000
Date: Thu, 19 Nov 2026 00:06:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:next] BUILD SUCCESS
 c615fc68e54b0e616872236831a6be173430f9d2
Message-ID: <20261119000640.hfC0i5yw-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_080736_996279_8FF2C9B9 
X-CRM114-Status: UNSURE (   4.51  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -4.4 (----)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git next
branch HEAD: c615fc68e54b0e616872236831a6be173430f9d2  Merge branch 'lu-pci-preservation' into next

elapsed time: 1507m

configs tested: 207
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261118    gcc-10.5.0
arc                   randconfig-1001-20261118    gcc-10.5.0
arc                         vdk_hs38_defconfig    clang-24
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                      am200epdkit_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                           gemini_defconfig    gcc-16.2.0
arm                            h3600_defconfig    gcc-16.2.0
arm                           ixp4xx_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261118    gcc-10.5.0
arm                   randconfig-1001-20261118    gcc-10.5.0
arm                   randconfig-1002-20261118    gcc-10.5.0
arm                   randconfig-1003-20261118    gcc-10.5.0
arm                         realview_defconfig    clang-17
arm                          s3c6400_defconfig    clang-24
arm                         spear3xx_defconfig    clang-24
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261118    gcc-16.2.0
arm64                 randconfig-1001-20261118    gcc-16.2.0
arm64                 randconfig-1002-20261118    gcc-16.2.0
arm64                 randconfig-1003-20261118    gcc-16.2.0
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261118    gcc-16.2.0
csky                  randconfig-1001-20261118    gcc-16.2.0
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261118    clang-22
hexagon               randconfig-1001-20261118    clang-22
i386                              alldefconfig    clang-17
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261118    gcc-12
i386        buildonly-randconfig-1001-20261118    gcc-12
i386        buildonly-randconfig-1002-20261118    gcc-12
i386        buildonly-randconfig-1003-20261118    gcc-12
i386        buildonly-randconfig-1004-20261118    gcc-12
i386        buildonly-randconfig-1005-20261118    gcc-12
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261118    clang-22
i386                  randconfig-1001-20261118    clang-22
i386                  randconfig-1002-20261118    clang-22
i386                  randconfig-1003-20261118    clang-22
i386                  randconfig-1004-20261118    clang-22
i386                  randconfig-1005-20261118    clang-22
i386                  randconfig-1006-20261118    clang-22
i386                  randconfig-1007-20261118    clang-22
i386                  randconfig-1008-20261118    clang-22
i386                  randconfig-1009-20261118    clang-22
i386                  randconfig-1010-20261118    clang-22
i386                  randconfig-1011-20261118    clang-22
i386                  randconfig-1012-20261118    clang-22
i386                  randconfig-1013-20261118    clang-22
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261118    clang-22
loongarch             randconfig-1001-20261118    clang-22
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                        m5249evb_defconfig    gcc-16.2.0
m68k                        m5329evb_defconfig    gcc-16.2.0
m68k                         stmark2_defconfig    clang-24
microblaze                        alldefconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                         bcm63xx_defconfig    gcc-16.2.0
mips                       bmips_stb_defconfig    gcc-16.2.0
mips                       malta_kvm_defconfig    clang-24
mips                 malta_qemu_32r6_defconfig    clang-24
mips                          rt305x_defconfig    clang-24
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261118    clang-22
nios2                 randconfig-1001-20261118    clang-22
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc                     or1ksim_defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261118    gcc-8.5.0
parisc                randconfig-1001-20261118    gcc-8.5.0
parisc64                             defconfig    clang-24
powerpc                     adder875_defconfig    clang-17
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                      asp8347_defconfig    clang-24
powerpc                         cell_defconfig    gcc-16.2.0
powerpc                    currituck_defconfig    gcc-16.2.0
powerpc                       katmai_defconfig    clang-24
powerpc                   mpc866_ads_defconfig    clang-17
powerpc                       pasemi_defconfig    clang-24
powerpc                       ppc6xx_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261118    gcc-8.5.0
powerpc               randconfig-1001-20261118    gcc-8.5.0
powerpc                      tqm8540_defconfig    clang-24
powerpc                      tqm8555_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261118    gcc-8.5.0
powerpc64             randconfig-1001-20261118    gcc-8.5.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                     nommu_k210_defconfig    clang-24
riscv                 randconfig-1000-20261118    gcc-11.5.0
riscv                 randconfig-1001-20261118    gcc-11.5.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261118    gcc-11.5.0
s390                  randconfig-1001-20261118    gcc-11.5.0
s390                        zfcpdump_defconfig    clang-24
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                         edosk7760_defconfig    gcc-16.2.0
sh                              espt_defconfig    clang-17
sh                           polaris_defconfig    clang-17
sh                    randconfig-1000-20261118    gcc-11.5.0
sh                    randconfig-1001-20261118    gcc-11.5.0
sh                           rsk7201_defconfig    gcc-16.2.0
sh                           rsk7269_defconfig    clang-24
sh                    rts7751r2dplus_defconfig    clang-17
sh                              sh03_defconfig    clang-24
sh                   sh7785lcr_32bit_defconfig    clang-17
sh                             titan_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261118    gcc-16.2.0
sparc                 randconfig-1001-20261118    gcc-16.2.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261118    gcc-16.2.0
sparc64               randconfig-1001-20261118    gcc-16.2.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261118    gcc-16.2.0
um                    randconfig-1001-20261118    gcc-16.2.0
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261118    gcc-14
x86_64      buildonly-randconfig-1001-20261118    gcc-14
x86_64      buildonly-randconfig-1002-20261118    gcc-14
x86_64      buildonly-randconfig-1003-20261118    gcc-14
x86_64      buildonly-randconfig-1004-20261118    gcc-14
x86_64      buildonly-randconfig-1005-20261118    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261118    gcc-14
x86_64                randconfig-1001-20261118    gcc-14
x86_64                randconfig-1002-20261118    gcc-14
x86_64                randconfig-1003-20261118    gcc-14
x86_64                randconfig-1004-20261118    gcc-14
x86_64                randconfig-1005-20261118    gcc-14
x86_64                randconfig-1006-20261118    gcc-14
x86_64                randconfig-1007-20261118    gcc-14
x86_64                randconfig-1008-20261118    gcc-14
x86_64                randconfig-1009-20261118    gcc-14
x86_64                randconfig-1010-20261118    gcc-14
x86_64                randconfig-1011-20261118    gcc-14
x86_64                randconfig-1012-20261118    gcc-14
x86_64                randconfig-1013-20261118    gcc-14
x86_64                randconfig-1014-20261118    gcc-14
x86_64                randconfig-1015-20261118    gcc-14
x86_64                randconfig-1016-20261118    gcc-14
x86_64                randconfig-1017-20261118    gcc-14
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261118    gcc-16.2.0
xtensa                randconfig-1001-20261118    gcc-16.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

