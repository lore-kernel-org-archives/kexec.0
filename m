Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B11606A31A
	for <kexec@archiver.kernel.org>; Sun,  8 Nov 2026 02:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VFGZYmUY;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KohT8W+H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=Sc+2ilUGy+40BeqQHkjUXzmmU9dDGAKM6G/rkiIApSk=; b=VFGZYmUYVpV6hN7EnUZ4pM0acq
	H1ad3+A7tNy6PldlvqAzgzZ1rtTFZ0Qzo89STfK4B4MWAQg3JCVRmtAbjmkdBQXUBC33Tc+Q52PT0
	Zv9eiNLYqbpy0glw0C2l8YMC5ZXAweao7J844LtUBKa5JttLYP9sTc9YmIdXCSboESMu7iX0XDnrg
	fpFujqUx1pzjXCKRHEf7vSIQvC4xLTx9OogW5XjGM0IpB8hCulaJ9y9i3UhZrQK8OB1jCRpuOx5GP
	Uc3lbHJ7CF7DUizTIs6l7HCeqSMCM+h0xq9uCbEN7W6CqTaK4Ec2z/LzvE7leLN9d20y4WfEamv3B
	k8XcDqmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPsI0-0000000Fard-2iAH;
	Sun, 08 Nov 2026 02:05:48 +0000
Received: from mgamail.intel.com ([198.175.65.16])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPsHx-0000000Far2-2MGW
	for kexec@lists.infradead.org;
	Sun, 08 Nov 2026 02:05:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794103546; x=1825639546;
  h=date:from:to:cc:subject:message-id;
  bh=N5xAGJ7r+xutXmRcy8s//FEuOcl5EY/ADHnVFZCsUTo=;
  b=KohT8W+HxeDQNDij1Qg9grQnDbPsLI9dASlf6uq1CON9kIxaD1Pa/dh/
   CivmvqWobRal1TozodVb/4xIhAlvMmlRzBRfxCnAsa3EB1/QMrOnCYTe+
   OSXHxUS0TmxiPqhMqwQPpJJNILtkWv0erYxhfAaOIsFzTOvBZRO76r785
   QluZON8cxkR/JUfyYts5sR5Nd2Apx5rZl6Mi4oVZUTEZVVPBXbu0IpCS2
   KNSnJ3XhrU/Nj63b6xiG1b8KwlK32pdIqqOH5rbdzIeZdR33tHBVvT2yL
   Jny/HxV70fl3YxcDX0OjRvxAH5H8n3zILhF4Dmkj+hykPj2Zk+vKxCfpc
   Q==;
X-CSE-ConnectionGUID: +SXdJHFSRSG/4QsOh0kHyQ==
X-CSE-MsgGUID: /PU1FSvIT+aYkVSPwPDMcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2865260"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2865260"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2026 18:05:44 -0800
X-CSE-ConnectionGUID: xgMJvkMlTme5HTpChOyB+Q==
X-CSE-MsgGUID: mlGZ55lnQGuJvbTSgcxqDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7913574"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 07 Nov 2026 18:05:41 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPsHr-00000000rv1-1tuM;
	Sun, 08 Nov 2026 02:05:39 +0000
Date: Sun, 08 Nov 2026 10:05:25 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:kexec-7.5] BUILD SUCCESS
 941aef93e9e1df74f0ef0fa8653c435613131243
Message-ID: <20261108100525.4k8eLjkK-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261107_180545_710928_6EEEC5DE 
X-CRM114-Status: UNSURE (   4.08  )
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git kexec-7.5
branch HEAD: 941aef93e9e1df74f0ef0fa8653c435613131243  kdump: Give crashkernel CMA areas unique names

elapsed time: 906m

configs tested: 283
configs skipped: 2

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
arc                      haps_hs_smp_defconfig    clang-17
arc                   randconfig-1000-20261107    gcc-12.5.0
arc                   randconfig-1000-20261108    gcc-11.5.0
arc                   randconfig-1001-20261107    gcc-12.5.0
arc                   randconfig-1001-20261108    gcc-11.5.0
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                   randconfig-1000-20261107    gcc-12.5.0
arm                   randconfig-1000-20261108    gcc-11.5.0
arm                   randconfig-1001-20261107    gcc-12.5.0
arm                   randconfig-1001-20261108    gcc-11.5.0
arm                   randconfig-1002-20261107    gcc-12.5.0
arm                   randconfig-1002-20261108    gcc-11.5.0
arm                   randconfig-1003-20261107    gcc-12.5.0
arm                   randconfig-1003-20261108    gcc-11.5.0
arm                              rpc_defconfig    gcc-16.2.0
arm                            u8500_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261107    gcc-11.5.0
arm64                 randconfig-1000-20261108    clang-24
arm64                 randconfig-1001-20261107    gcc-11.5.0
arm64                 randconfig-1001-20261108    clang-24
arm64                 randconfig-1002-20261107    gcc-11.5.0
arm64                 randconfig-1002-20261108    clang-24
arm64                 randconfig-1003-20261107    gcc-11.5.0
arm64                 randconfig-1003-20261108    clang-24
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261107    gcc-11.5.0
csky                  randconfig-1000-20261108    clang-24
csky                  randconfig-1001-20261107    gcc-11.5.0
csky                  randconfig-1001-20261108    clang-24
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261107    clang-18
hexagon               randconfig-1000-20261108    gcc-16.2.0
hexagon               randconfig-1001-20261107    clang-18
hexagon               randconfig-1001-20261108    gcc-16.2.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261107    gcc-14
i386        buildonly-randconfig-1000-20261108    clang-22
i386        buildonly-randconfig-1001-20261107    gcc-14
i386        buildonly-randconfig-1001-20261108    clang-22
i386        buildonly-randconfig-1002-20261107    gcc-14
i386        buildonly-randconfig-1002-20261108    clang-22
i386        buildonly-randconfig-1003-20261107    gcc-14
i386        buildonly-randconfig-1003-20261108    clang-22
i386        buildonly-randconfig-1004-20261107    gcc-14
i386        buildonly-randconfig-1004-20261108    clang-22
i386        buildonly-randconfig-1005-20261107    gcc-14
i386        buildonly-randconfig-1005-20261108    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261107    clang-22
i386                  randconfig-1000-20261108    gcc-14
i386                  randconfig-1001-20261107    clang-22
i386                  randconfig-1001-20261108    gcc-14
i386                  randconfig-1002-20261107    clang-22
i386                  randconfig-1002-20261108    gcc-14
i386                  randconfig-1003-20261107    clang-22
i386                  randconfig-1003-20261108    gcc-14
i386                  randconfig-1004-20261107    clang-22
i386                  randconfig-1004-20261108    gcc-14
i386                  randconfig-1005-20261107    clang-22
i386                  randconfig-1005-20261108    gcc-14
i386                  randconfig-1006-20261107    clang-22
i386                  randconfig-1006-20261108    gcc-14
i386                  randconfig-1007-20261107    clang-22
i386                  randconfig-1007-20261108    clang-22
i386                  randconfig-1008-20261107    clang-22
i386                  randconfig-1008-20261108    clang-22
i386                  randconfig-1009-20261107    clang-22
i386                  randconfig-1009-20261108    clang-22
i386                  randconfig-1010-20261107    clang-22
i386                  randconfig-1010-20261108    clang-22
i386                  randconfig-1011-20261107    clang-22
i386                  randconfig-1011-20261108    clang-22
i386                  randconfig-1012-20261107    clang-22
i386                  randconfig-1012-20261108    clang-22
i386                  randconfig-1013-20261107    clang-22
i386                  randconfig-1013-20261108    clang-22
loongarch                         alldefconfig    gcc-16.2.0
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261107    clang-18
loongarch             randconfig-1000-20261108    gcc-16.2.0
loongarch             randconfig-1001-20261107    clang-18
loongarch             randconfig-1001-20261108    gcc-16.2.0
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                             q40_defconfig    gcc-16.2.0
m68k                            sun3_defconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                       bmips_stb_defconfig    clang-17
mips                      cu1000-neo_defconfig    clang-24
mips                   decstation_64_defconfig    gcc-16.2.0
mips                           malta_defconfig    clang-17
mips                       malta_kvm_defconfig    clang-17
mips                   maltasmvp_eva_defconfig    gcc-16.2.0
mips                         maltaup_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261107    clang-18
nios2                 randconfig-1000-20261108    gcc-16.2.0
nios2                 randconfig-1001-20261107    clang-18
nios2                 randconfig-1001-20261108    gcc-16.2.0
openrisc                          alldefconfig    gcc-16.2.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc                     or1ksim_defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261107    clang-24
parisc                randconfig-1000-20261108    clang-24
parisc                randconfig-1001-20261107    clang-24
parisc                randconfig-1001-20261108    clang-24
parisc64                             defconfig    clang-24
powerpc                      akebono_defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                    microwatt_defconfig    gcc-16.2.0
powerpc                      mpc5200_defconfig    clang-24
powerpc                      mpc83xx_defconfig    gcc-16.2.0
powerpc                     mvme5100_defconfig    gcc-16.2.0
powerpc                       pcm030_defconfig    gcc-16.2.0
powerpc                      rainier_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261107    clang-24
powerpc               randconfig-1000-20261108    clang-24
powerpc               randconfig-1001-20261107    clang-24
powerpc               randconfig-1001-20261108    clang-24
powerpc                     sam440ep_defconfig    gcc-16.2.0
powerpc                      tqm8548_defconfig    clang-24
powerpc                      tqm8555_defconfig    gcc-16.2.0
powerpc                          wii_defconfig    clang-24
powerpc64             randconfig-1000-20261107    clang-24
powerpc64             randconfig-1000-20261108    clang-24
powerpc64             randconfig-1001-20261107    clang-24
powerpc64             randconfig-1001-20261108    clang-24
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    clang-17
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261107    gcc-11.5.0
riscv                 randconfig-1000-20261108    gcc-12.5.0
riscv                 randconfig-1001-20261107    gcc-11.5.0
riscv                 randconfig-1001-20261108    gcc-12.5.0
s390                              alldefconfig    clang-17
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261107    gcc-11.5.0
s390                  randconfig-1000-20261108    gcc-12.5.0
s390                  randconfig-1001-20261107    gcc-11.5.0
s390                  randconfig-1001-20261108    gcc-12.5.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                              espt_defconfig    clang-24
sh                                j2_defconfig    clang-24
sh                                j2_defconfig    gcc-16.2.0
sh                           r7780mp_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261107    gcc-11.5.0
sh                    randconfig-1000-20261108    gcc-12.5.0
sh                    randconfig-1001-20261107    gcc-11.5.0
sh                    randconfig-1001-20261108    gcc-12.5.0
sh                           rsk7264_defconfig    gcc-16.2.0
sh                           rsk7269_defconfig    clang-17
sh                           sdk7786_defconfig    clang-24
sh                            se7705_defconfig    gcc-16.2.0
sh                            se7722_defconfig    gcc-16.2.0
sh                              sh03_defconfig    clang-17
sh                              sh03_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261107    gcc-10.5.0
sparc                 randconfig-1000-20261108    gcc-8.5.0
sparc                 randconfig-1001-20261107    gcc-10.5.0
sparc                 randconfig-1001-20261108    gcc-8.5.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261107    gcc-10.5.0
sparc64               randconfig-1000-20261108    gcc-8.5.0
sparc64               randconfig-1001-20261107    gcc-10.5.0
sparc64               randconfig-1001-20261108    gcc-8.5.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261107    gcc-10.5.0
um                    randconfig-1000-20261108    gcc-8.5.0
um                    randconfig-1001-20261107    gcc-10.5.0
um                    randconfig-1001-20261108    gcc-8.5.0
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261107    gcc-14
x86_64      buildonly-randconfig-1000-20261108    gcc-14
x86_64      buildonly-randconfig-1001-20261107    gcc-14
x86_64      buildonly-randconfig-1001-20261108    gcc-14
x86_64      buildonly-randconfig-1002-20261107    gcc-14
x86_64      buildonly-randconfig-1002-20261108    gcc-14
x86_64      buildonly-randconfig-1003-20261107    gcc-14
x86_64      buildonly-randconfig-1003-20261108    gcc-14
x86_64      buildonly-randconfig-1004-20261107    gcc-14
x86_64      buildonly-randconfig-1004-20261108    gcc-14
x86_64      buildonly-randconfig-1005-20261107    gcc-14
x86_64      buildonly-randconfig-1005-20261108    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261108    gcc-14
x86_64                randconfig-1001-20261108    gcc-14
x86_64                randconfig-1002-20261108    gcc-14
x86_64                randconfig-1003-20261108    gcc-14
x86_64                randconfig-1004-20261108    gcc-14
x86_64                randconfig-1005-20261108    gcc-14
x86_64                randconfig-1006-20261107    gcc-13
x86_64                randconfig-1006-20261108    clang-22
x86_64                randconfig-1007-20261107    gcc-13
x86_64                randconfig-1007-20261108    clang-22
x86_64                randconfig-1008-20261107    gcc-13
x86_64                randconfig-1008-20261108    clang-22
x86_64                randconfig-1009-20261107    gcc-13
x86_64                randconfig-1009-20261108    clang-22
x86_64                randconfig-1010-20261107    gcc-13
x86_64                randconfig-1010-20261108    clang-22
x86_64                randconfig-1011-20261107    gcc-13
x86_64                randconfig-1011-20261108    clang-22
x86_64                randconfig-1012-20261107    clang-22
x86_64                randconfig-1012-20261108    clang-22
x86_64                randconfig-1013-20261107    clang-22
x86_64                randconfig-1013-20261108    clang-22
x86_64                randconfig-1014-20261107    clang-22
x86_64                randconfig-1014-20261108    clang-22
x86_64                randconfig-1015-20261107    clang-22
x86_64                randconfig-1015-20261108    clang-22
x86_64                randconfig-1016-20261107    clang-22
x86_64                randconfig-1016-20261108    clang-22
x86_64                randconfig-1017-20261107    clang-22
x86_64                randconfig-1017-20261108    clang-22
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261107    gcc-10.5.0
xtensa                randconfig-1000-20261108    gcc-8.5.0
xtensa                randconfig-1001-20261107    gcc-10.5.0
xtensa                randconfig-1001-20261108    gcc-8.5.0
xtensa                     xip_kc705_defconfig    gcc-16.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

