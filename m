Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11240606A332
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 12:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=csmf2IdQ;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gFbSFJxZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=dF1U+E1VoKrg4OI07SUtXWYlFb2BQvW0tfkvuMhCwTk=; b=csmf2IdQZDgUnvcdgPxODfaxad
	8ZU7eeAT6CEJotYu2+hFgl9E9NspzqqJv5bu6MPyNJAWG/1vXKzkDrL8orHS5pA1mQ6hTLnaKEJ7U
	BEAYwLn7y88LrG2mTZWE9JmZRpV6fcBMrLde3pKNapLDcKA6wZ9BNgQ97nupX4qd5cqCRVZyrKQ8x
	SlBOQjjDYmEaE9dS8dEY0N9JR6/YsCcMBJ0q3ISNobaR2B6w6UNZGGhWb2fcXNegzylN718efGzb8
	TKF+O/zSw9fjnHe9GguDuDDxHF+QLNorlP1Xjfqbv+1oP4HJf58zM7Cr2xtFLbyAHvIm3TPj2XnXH
	MDHZzZcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSvQ0-00000002HuL-3Gwy;
	Mon, 16 Nov 2026 12:02:40 +0000
Received: from mgamail.intel.com ([198.175.65.12])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSvPy-00000002Hsi-0ez4
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 12:02:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794830558; x=1826366558;
  h=date:from:to:cc:subject:message-id;
  bh=bTZ/bkRV09ZIgfmRl6GDUSyJooE5YM3ZCdBQOYalwvk=;
  b=gFbSFJxZ5CAhm5CDWJbT62g5snRJO7EfOvNVuGpTF8zX5tcOAVV+hvMl
   057xUc4DEMsn6IT0CoIUmpggCy6PCQdSGlE2eT8TOyM5xxN61/6pE76HN
   DX4vBepguMK9SJ7wZTvd2GYeNdxyQw3Z/XxEmAOukLmrVaH89zRXYDxsZ
   /BbSORsal58lIoIJ29xjszrvd9p8UiZEiAZ6pQAvRwjL7ICVP/zlGY7uH
   HrlxiBopJsIaeQ4WTUmkbKYXjB8HfjdDfSwP7cCN4zxhayQgDEQVb6ja+
   YLGOuKz1r3mr+GP8i88Q8PaK+n2Zd5ZxIkzQNqOj1lu8kfE+i2X6138nY
   A==;
X-CSE-ConnectionGUID: 9lyDdrTqTfGkpZVPPZ1DSA==
X-CSE-MsgGUID: W77xKLjlQKeIdCax1qFd8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3434347"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3434347"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 04:02:36 -0800
X-CSE-ConnectionGUID: JAY7sITtSEKcn+o5BvO8Rw==
X-CSE-MsgGUID: 5ZVMywt5RUG2PBn0TXRGeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9716390"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 16 Nov 2026 04:02:35 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xSvPr-000000018To-48Lz;
	Mon, 16 Nov 2026 12:02:31 +0000
Date: Mon, 16 Nov 2026 20:01:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:liveupdate-7.5] BUILD SUCCESS
 96ba3d3c772245c560521f962e253b51bbbcf7a4
Message-ID: <20261116200159.MEgRCoRc-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_040238_267314_40E85453 
X-CRM114-Status: UNSURE (   4.22  )
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git liveupdate-7.5
branch HEAD: 96ba3d3c772245c560521f962e253b51bbbcf7a4  kho: fix restore order for NUMA-split preservations

elapsed time: 918m

configs tested: 539
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261115    gcc-8.5.0
alpha                 randconfig-2000-20261116    gcc-10.5.0
alpha                 randconfig-2001-20261115    gcc-8.5.0
alpha                 randconfig-2001-20261116    gcc-10.5.0
alpha                 randconfig-2200-20261115    gcc-8.5.0  smatch
alpha                 randconfig-2200-20261116    gcc-15.3.0 smatch
alpha                randconfig-r2100-20261115    gcc-8.5.0  cocci
alpha                randconfig-r2102-20261115    gcc-8.5.0  cocci
alpha                randconfig-r2103-20261115    gcc-8.5.0  cocci
alpha                randconfig-r2105-20261115    gcc-8.5.0  cocci
alpha                randconfig-r2109-20261116    gcc-9.5.0  cocci
alpha                randconfig-r2111-20261115    gcc-13.5.0 cocci
alpha                randconfig-r2308-20261116    gcc-9.5.0  sparse
alpha                randconfig-r2310-20261115    gcc-11.5.0 sparse
alpha                randconfig-r2311-20261115    gcc-9.5.0  sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261116    gcc-8.5.0
arc                   randconfig-1001-20261116    gcc-8.5.0
arc                   randconfig-2000-20261115    gcc-8.5.0
arc                   randconfig-2000-20261116    gcc-13.5.0
arc                   randconfig-2001-20261115    gcc-8.5.0
arc                   randconfig-2001-20261116    gcc-13.5.0
arc                   randconfig-2002-20261115    gcc-8.5.0
arc                   randconfig-2002-20261116    gcc-13.5.0
arc                   randconfig-2003-20261115    gcc-8.5.0
arc                   randconfig-2003-20261116    gcc-13.5.0
arc                   randconfig-2004-20261115    gcc-8.5.0
arc                   randconfig-2004-20261116    gcc-13.5.0
arc                   randconfig-2005-20261115    gcc-8.5.0
arc                   randconfig-2005-20261116    gcc-13.5.0
arc                   randconfig-2200-20261115    gcc-16.2.0 smatch
arc                   randconfig-2200-20261116    gcc-15.3.0 smatch
arc                  randconfig-r2107-20261116    gcc-12.5.0 cocci
arc                  randconfig-r2108-20261115    gcc-13.5.0 cocci
arc                  randconfig-r2308-20261115    gcc-9.5.0  sparse
arc                  randconfig-r2311-20261115    gcc-11.5.0 sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                        imx_v4_v5_defconfig    clang-24
arm                              mxs_defconfig    clang-17
arm                   randconfig-1000-20261116    gcc-8.5.0
arm                   randconfig-1001-20261116    gcc-8.5.0
arm                   randconfig-1002-20261116    gcc-8.5.0
arm                   randconfig-1003-20261116    gcc-8.5.0
arm                   randconfig-2000-20261115    clang-24
arm                   randconfig-2000-20261116    gcc-15.3.0
arm                   randconfig-2001-20261115    clang-24
arm                   randconfig-2001-20261116    gcc-15.3.0
arm                   randconfig-2002-20261115    clang-24
arm                   randconfig-2002-20261116    gcc-15.3.0
arm                   randconfig-2200-20261115    clang-17   smatch
arm                   randconfig-2200-20261116    gcc-13.5.0 smatch
arm                  randconfig-r2101-20261115    gcc-8.5.0  cocci
arm                  randconfig-r2108-20261116    clang-17   cocci
arm                  randconfig-r2308-20261115    gcc-11.5.0 sparse
arm                         realview_defconfig    clang-17
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261116    gcc-10.5.0
arm64                 randconfig-1001-20261116    gcc-10.5.0
arm64                 randconfig-1002-20261116    gcc-10.5.0
arm64                 randconfig-1003-20261116    gcc-10.5.0
arm64                 randconfig-2000-20261115    clang-24
arm64                 randconfig-2000-20261116    gcc-15.3.0
arm64                 randconfig-2001-20261115    clang-24
arm64                 randconfig-2001-20261116    gcc-15.3.0
arm64                 randconfig-2002-20261115    clang-24
arm64                 randconfig-2002-20261116    gcc-15.3.0
arm64                 randconfig-2200-20261115    gcc-15.3.0 smatch
arm64                 randconfig-2200-20261116    gcc-8.5.0  smatch
arm64                randconfig-r2104-20261115    gcc-8.5.0  cocci
arm64                randconfig-r2106-20261115    gcc-13.5.0 cocci
arm64                randconfig-r2109-20261116    clang-17   cocci
arm64                randconfig-r2304-20261115    gcc-13.5.0 sparse
arm64                randconfig-r2307-20261115    gcc-9.5.0  sparse
arm64                randconfig-r2311-20261116    gcc-9.5.0  sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261116    gcc-10.5.0
csky                  randconfig-1001-20261116    gcc-10.5.0
csky                  randconfig-2000-20261115    gcc-14.4.0
csky                  randconfig-2000-20261116    gcc-16.2.0
csky                  randconfig-2001-20261115    gcc-14.4.0
csky                  randconfig-2001-20261116    gcc-16.2.0
csky                  randconfig-2200-20261115    gcc-12.5.0 smatch
csky                  randconfig-2200-20261116    gcc-16.2.0 smatch
csky                 randconfig-r2102-20261116    gcc-8.5.0  cocci
csky                 randconfig-r2104-20261115    gcc-8.5.0  cocci
csky                 randconfig-r2105-20261116    gcc-12.5.0 cocci
csky                 randconfig-r2109-20261115    gcc-13.5.0 cocci
csky                 randconfig-r2110-20261116    gcc-12.5.0 cocci
csky                 randconfig-r2304-20261116    gcc-8.5.0  sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261116    clang-17
hexagon               randconfig-1001-20261116    clang-17
hexagon               randconfig-2000-20261115    gcc-14.4.0
hexagon               randconfig-2000-20261116    gcc-16.2.0
hexagon               randconfig-2001-20261115    gcc-14.4.0
hexagon               randconfig-2001-20261116    gcc-16.2.0
hexagon               randconfig-2200-20261115    clang-24   smatch
hexagon               randconfig-2200-20261116    clang-17   smatch
hexagon              randconfig-r2108-20261116    gcc-12.5.0 cocci
hexagon              randconfig-r2109-20261116    gcc-12.5.0 cocci
hexagon              randconfig-r2110-20261116    clang-17   cocci
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386        buildonly-randconfig-1000-20261116    gcc-14
i386        buildonly-randconfig-1001-20261116    gcc-14
i386        buildonly-randconfig-1002-20261116    gcc-14
i386        buildonly-randconfig-1003-20261116    gcc-14
i386        buildonly-randconfig-1004-20261116    gcc-14
i386        buildonly-randconfig-1005-20261116    gcc-14
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261116    gcc-14
i386                  randconfig-1001-20261116    gcc-14
i386                  randconfig-1002-20261116    gcc-14
i386                  randconfig-1003-20261116    gcc-14
i386                  randconfig-1004-20261116    gcc-14
i386                  randconfig-1005-20261116    gcc-14
i386                  randconfig-1006-20261116    gcc-14
i386                  randconfig-2000-20261115    gcc-14
i386                  randconfig-2000-20261116    gcc-14
i386                  randconfig-2001-20261115    gcc-14
i386                  randconfig-2001-20261116    gcc-14
i386                  randconfig-2002-20261115    gcc-14
i386                  randconfig-2002-20261116    gcc-14
i386                  randconfig-2003-20261115    gcc-14
i386                  randconfig-2003-20261116    gcc-14
i386                  randconfig-2004-20261115    gcc-14
i386                  randconfig-2004-20261116    gcc-14
i386                  randconfig-2005-20261115    gcc-14
i386                  randconfig-2005-20261116    gcc-14
i386                  randconfig-2100-20261115    gcc-14     cocci
i386                  randconfig-2100-20261116    gcc-14     cocci
i386                  randconfig-2101-20261115    gcc-14     cocci
i386                  randconfig-2101-20261116    gcc-14     cocci
i386                  randconfig-2102-20261115    gcc-14     cocci
i386                  randconfig-2102-20261116    gcc-14     cocci
i386                  randconfig-2103-20261115    gcc-14     cocci
i386                  randconfig-2103-20261116    gcc-14     cocci
i386                  randconfig-2104-20261115    gcc-14     cocci
i386                  randconfig-2104-20261116    gcc-14     cocci
i386                  randconfig-2105-20261115    gcc-14     cocci
i386                  randconfig-2105-20261116    gcc-14     cocci
i386                  randconfig-2200-20261115    gcc-14     smatch
i386                  randconfig-2200-20261116    gcc-14     smatch
i386                  randconfig-2300-20261115    clang-22   sparse
i386                  randconfig-2301-20261115    clang-22   sparse
i386                  randconfig-2302-20261115    clang-22   sparse
i386                 randconfig-r2100-20261116    gcc-16.2.0 cocci
i386                 randconfig-r2102-20261116    gcc-16.2.0 cocci
i386                 randconfig-r2108-20261115    gcc-13.5.0 cocci
i386                 randconfig-r2306-20261115    gcc-9.5.0  sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261116    clang-17
loongarch             randconfig-1001-20261116    clang-17
loongarch             randconfig-2000-20261115    gcc-8.5.0
loongarch             randconfig-2000-20261116    gcc-11.5.0
loongarch             randconfig-2001-20261115    gcc-8.5.0
loongarch             randconfig-2001-20261116    gcc-11.5.0
loongarch             randconfig-2200-20261115    gcc-16.2.0 smatch
loongarch             randconfig-2200-20261116    clang-19   smatch
loongarch            randconfig-r2101-20261116    gcc-8.5.0  cocci
loongarch            randconfig-r2109-20261115    gcc-13.5.0 cocci
loongarch            randconfig-r2111-20261116    gcc-14.4.0 cocci
loongarch            randconfig-r2300-20261115    gcc-13.5.0 sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                        m5208evb_defconfig    clang-17
m68k                        m5329evb_defconfig    clang-17
m68k                  randconfig-2000-20261115    gcc-8.5.0
m68k                  randconfig-2000-20261116    gcc-10.5.0
m68k                  randconfig-2001-20261115    gcc-8.5.0
m68k                  randconfig-2001-20261116    gcc-10.5.0
m68k                  randconfig-2200-20261115    gcc-8.5.0  smatch
m68k                  randconfig-2200-20261116    gcc-14.4.0 smatch
m68k                 randconfig-r2106-20261116    gcc-9.5.0  cocci
m68k                 randconfig-r2109-20261115    gcc-15.3.0 cocci
m68k                 randconfig-r2301-20261116    gcc-8.5.0  sparse
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261115    gcc-8.5.0
microblaze            randconfig-2000-20261116    gcc-10.5.0
microblaze            randconfig-2001-20261115    gcc-8.5.0
microblaze            randconfig-2001-20261116    gcc-10.5.0
microblaze            randconfig-2200-20261115    gcc-12.5.0 smatch
microblaze            randconfig-2200-20261116    gcc-11.5.0 smatch
microblaze           randconfig-r2101-20261116    gcc-12.5.0 cocci
microblaze           randconfig-r2110-20261116    gcc-9.5.0  cocci
microblaze           randconfig-r2300-20261116    gcc-8.5.0  sparse
microblaze           randconfig-r2307-20261116    gcc-9.5.0  sparse
microblaze           randconfig-r2311-20261115    gcc-11.5.0 sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                   cavium_octeon_defconfig    clang-17
mips                  randconfig-2000-20261115    clang-17
mips                  randconfig-2000-20261115    gcc-10.5.0
mips                  randconfig-2000-20261116    gcc-13.5.0
mips                  randconfig-2001-20261115    clang-20
mips                  randconfig-2001-20261115    gcc-10.5.0
mips                  randconfig-2001-20261116    gcc-13.5.0
mips                  randconfig-2002-20261115    clang-24
mips                  randconfig-2002-20261115    gcc-10.5.0
mips                  randconfig-2002-20261116    gcc-13.5.0
mips                  randconfig-2200-20261115    clang-24   smatch
mips                  randconfig-2200-20261116    gcc-8.5.0  smatch
mips                 randconfig-r2103-20261116    gcc-12.5.0 cocci
mips                 randconfig-r2107-20261116    clang-17   cocci
mips                 randconfig-r2108-20261116    gcc-14.4.0 cocci
mips                 randconfig-r2303-20261115    gcc-13.5.0 sparse
mips                 randconfig-r2305-20261116    gcc-15.3.0 sparse
mips                 randconfig-r2306-20261115    gcc-11.5.0 sparse
mips                 randconfig-r2309-20261116    gcc-16.2.0 sparse
mips                 randconfig-r2309-20261116    gcc-9.5.0  sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261116    clang-17
nios2                 randconfig-1001-20261116    clang-17
nios2                 randconfig-2000-20261115    gcc-8.5.0
nios2                 randconfig-2000-20261116    gcc-11.5.0
nios2                 randconfig-2001-20261115    gcc-8.5.0
nios2                 randconfig-2001-20261116    gcc-11.5.0
nios2                 randconfig-2200-20261115    gcc-11.5.0 smatch
nios2                 randconfig-2200-20261116    gcc-11.5.0 smatch
nios2                randconfig-r2107-20261116    gcc-9.5.0  cocci
nios2                randconfig-r2108-20261116    gcc-9.5.0  cocci
nios2                randconfig-r2110-20261115    gcc-13.5.0 cocci
nios2                randconfig-r2300-20261115    gcc-13.5.0 sparse
nios2                randconfig-r2309-20261115    gcc-9.5.0  sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261115    gcc-10.5.0
openrisc              randconfig-2000-20261116    gcc-13.5.0
openrisc              randconfig-2001-20261115    gcc-10.5.0
openrisc              randconfig-2001-20261115    gcc-12.5.0
openrisc              randconfig-2001-20261116    gcc-13.5.0
openrisc              randconfig-2002-20261115    gcc-10.5.0
openrisc              randconfig-2002-20261116    gcc-13.5.0
openrisc              randconfig-2200-20261115    gcc-12.5.0 smatch
openrisc              randconfig-2200-20261116    gcc-15.3.0 smatch
openrisc             randconfig-r2100-20261115    gcc-8.5.0  cocci
openrisc             randconfig-r2105-20261115    gcc-8.5.0  cocci
openrisc             randconfig-r2105-20261116    gcc-8.5.0  cocci
openrisc             randconfig-r2307-20261115    gcc-11.5.0 sparse
openrisc             randconfig-r2309-20261115    gcc-11.5.0 sparse
openrisc             randconfig-r2310-20261115    gcc-9.5.0  sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-2000-20261115    gcc-8.5.0
parisc                randconfig-2000-20261116    gcc-11.5.0
parisc                randconfig-2001-20261115    gcc-8.5.0
parisc                randconfig-2001-20261116    gcc-11.5.0
parisc                randconfig-2200-20261115    gcc-10.5.0 smatch
parisc                randconfig-2200-20261116    gcc-8.5.0  smatch
parisc               randconfig-r2101-20261116    gcc-16.2.0 cocci
parisc               randconfig-r2102-20261115    gcc-8.5.0  cocci
parisc               randconfig-r2102-20261116    gcc-12.5.0 cocci
parisc               randconfig-r2106-20261115    gcc-15.3.0 cocci
parisc               randconfig-r2107-20261115    gcc-13.5.0 cocci
parisc               randconfig-r2301-20261115    gcc-13.5.0 sparse
parisc               randconfig-r2302-20261115    gcc-13.5.0 sparse
parisc               randconfig-r2305-20261116    gcc-8.5.0  sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                        eiger_defconfig    clang-17
powerpc                       ep88xc_defconfig    clang-24
powerpc                     gamecube_defconfig    clang-24
powerpc                        holly_defconfig    clang-24
powerpc                     mvme5100_defconfig    clang-24
powerpc                      powernv_defconfig    clang-24
powerpc               randconfig-2000-20261115    gcc-8.5.0
powerpc               randconfig-2000-20261116    clang-17
powerpc               randconfig-2001-20261115    gcc-8.5.0
powerpc               randconfig-2001-20261116    clang-17
powerpc               randconfig-2002-20261115    gcc-8.5.0
powerpc               randconfig-2002-20261116    clang-17
powerpc               randconfig-2200-20261115    clang-17   smatch
powerpc               randconfig-2200-20261116    clang-22   smatch
powerpc              randconfig-r2103-20261115    gcc-8.5.0  cocci
powerpc              randconfig-r2106-20261116    gcc-14.4.0 cocci
powerpc              randconfig-r2107-20261115    gcc-15.3.0 cocci
powerpc              randconfig-r2303-20261115    gcc-13.5.0 sparse
powerpc              randconfig-r2310-20261116    gcc-9.5.0  sparse
powerpc                      stx_gp3_defconfig    clang-24
powerpc                         warp_defconfig    clang-24
powerpc64             randconfig-2000-20261115    gcc-8.5.0
powerpc64             randconfig-2000-20261116    clang-17
powerpc64             randconfig-2001-20261115    gcc-8.5.0
powerpc64             randconfig-2001-20261116    clang-17
powerpc64             randconfig-2002-20261115    gcc-8.5.0
powerpc64             randconfig-2002-20261116    clang-17
powerpc64             randconfig-2200-20261115    clang-24   smatch
powerpc64             randconfig-2200-20261116    clang-19   smatch
powerpc64            randconfig-r2108-20261115    gcc-15.3.0 cocci
powerpc64            randconfig-r2305-20261115    gcc-13.5.0 sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261116    clang-17
riscv                 randconfig-1001-20261116    clang-17
riscv                 randconfig-2000-20261115    gcc-8.5.0
riscv                 randconfig-2000-20261116    clang-20
riscv                 randconfig-2001-20261115    gcc-8.5.0
riscv                 randconfig-2001-20261116    clang-20
riscv                 randconfig-2002-20261115    gcc-8.5.0
riscv                 randconfig-2002-20261116    clang-20
riscv                 randconfig-2003-20261115    gcc-8.5.0
riscv                 randconfig-2003-20261116    clang-20
riscv                 randconfig-2004-20261115    gcc-8.5.0
riscv                 randconfig-2004-20261116    clang-20
riscv                 randconfig-2005-20261115    gcc-8.5.0
riscv                 randconfig-2005-20261116    clang-20
riscv                 randconfig-2200-20261115    clang-24   smatch
riscv                 randconfig-2200-20261116    clang-24   smatch
riscv                randconfig-r2100-20261116    gcc-12.5.0 cocci
riscv                randconfig-r2106-20261115    gcc-13.5.0 cocci
riscv                randconfig-r2107-20261115    gcc-13.5.0 cocci
riscv                randconfig-r2110-20261115    gcc-15.3.0 cocci
riscv                randconfig-r2111-20261116    gcc-9.5.0  cocci
riscv                randconfig-r2304-20261116    gcc-15.3.0 sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261116    clang-17
s390                  randconfig-1001-20261116    clang-17
s390                  randconfig-2000-20261115    gcc-13.5.0
s390                  randconfig-2000-20261116    clang-17
s390                  randconfig-2001-20261115    gcc-13.5.0
s390                  randconfig-2001-20261116    clang-17
s390                  randconfig-2002-20261115    gcc-13.5.0
s390                  randconfig-2002-20261116    clang-17
s390                  randconfig-2003-20261115    gcc-13.5.0
s390                  randconfig-2003-20261116    clang-17
s390                  randconfig-2004-20261115    gcc-13.5.0
s390                  randconfig-2004-20261116    clang-17
s390                  randconfig-2005-20261115    gcc-13.5.0
s390                  randconfig-2005-20261116    clang-17
s390                  randconfig-2200-20261115    clang-24   smatch
s390                  randconfig-2200-20261116    gcc-10.5.0 smatch
s390                 randconfig-r2104-20261115    gcc-8.5.0  cocci
s390                 randconfig-r2106-20261116    clang-17   cocci
s390                 randconfig-r2110-20261115    gcc-13.5.0 cocci
s390                 randconfig-r2111-20261116    gcc-12.5.0 cocci
s390                 randconfig-r2303-20261116    gcc-8.5.0  sparse
s390                 randconfig-r2304-20261115    gcc-13.5.0 sparse
s390                 randconfig-r2306-20261116    gcc-9.5.0  sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261116    clang-17
sh                    randconfig-1001-20261116    clang-17
sh                    randconfig-2000-20261115    gcc-12.5.0
sh                    randconfig-2000-20261116    gcc-15.3.0
sh                    randconfig-2001-20261115    gcc-12.5.0
sh                    randconfig-2001-20261116    gcc-15.3.0
sh                    randconfig-2002-20261115    gcc-12.5.0
sh                    randconfig-2002-20261116    gcc-15.3.0
sh                    randconfig-2003-20261115    gcc-12.5.0
sh                    randconfig-2003-20261116    gcc-15.3.0
sh                    randconfig-2004-20261115    gcc-12.5.0
sh                    randconfig-2004-20261116    gcc-15.3.0
sh                    randconfig-2005-20261115    gcc-12.5.0
sh                    randconfig-2005-20261116    gcc-15.3.0
sh                    randconfig-2200-20261115    gcc-16.2.0 smatch
sh                    randconfig-2200-20261116    gcc-15.3.0 smatch
sh                   randconfig-r2104-20261116    gcc-16.2.0 cocci
sh                   randconfig-r2300-20261116    gcc-15.3.0 sparse
sh                   randconfig-r2301-20261116    gcc-15.3.0 sparse
sh                   randconfig-r2302-20261115    gcc-13.5.0 sparse
sh                   randconfig-r2309-20261115    gcc-11.5.0 sparse
sh                           sdk7786_defconfig    clang-17
sh                            se7206_defconfig    clang-17
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261116    gcc-16.2.0
sparc                 randconfig-1001-20261116    gcc-16.2.0
sparc                 randconfig-2000-20261115    clang-24
sparc                 randconfig-2000-20261116    gcc-14
sparc                 randconfig-2001-20261115    clang-24
sparc                 randconfig-2001-20261116    gcc-14
sparc                 randconfig-2200-20261115    gcc-16.2.0 smatch
sparc                 randconfig-2200-20261116    gcc-15.3.0 smatch
sparc                randconfig-r2101-20261115    gcc-8.5.0  cocci
sparc                randconfig-r2103-20261115    gcc-8.5.0  cocci
sparc                randconfig-r2103-20261116    gcc-8.5.0  cocci
sparc                randconfig-r2106-20261116    gcc-12.5.0 cocci
sparc                randconfig-r2107-20261116    gcc-14.4.0 cocci
sparc                randconfig-r2110-20261116    gcc-14.4.0 cocci
sparc                randconfig-r2306-20261115    gcc-11.5.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261116    gcc-16.2.0
sparc64               randconfig-1001-20261116    gcc-16.2.0
sparc64               randconfig-2000-20261115    clang-24
sparc64               randconfig-2000-20261116    gcc-14
sparc64               randconfig-2001-20261115    clang-24
sparc64               randconfig-2001-20261116    gcc-14
sparc64               randconfig-2200-20261115    gcc-13.5.0 smatch
sparc64               randconfig-2200-20261116    gcc-8.5.0  smatch
sparc64              randconfig-r2100-20261115    gcc-8.5.0  cocci
sparc64              randconfig-r2103-20261116    gcc-16.2.0 cocci
sparc64              randconfig-r2104-20261116    gcc-8.5.0  cocci
sparc64              randconfig-r2307-20261116    gcc-16.2.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261116    gcc-16.2.0
um                    randconfig-1001-20261116    gcc-16.2.0
um                    randconfig-2000-20261115    clang-24
um                    randconfig-2000-20261116    gcc-14
um                    randconfig-2001-20261115    clang-24
um                    randconfig-2001-20261116    gcc-14
um                    randconfig-2200-20261115    clang-24   smatch
um                    randconfig-2200-20261116    gcc-14     smatch
um                   randconfig-r2104-20261116    gcc-12.5.0 cocci
um                   randconfig-r2111-20261115    gcc-15.3.0 cocci
um                   randconfig-r2302-20261116    gcc-8.5.0  sparse
um                   randconfig-r2303-20261116    gcc-15.3.0 sparse
um                   randconfig-r2307-20261115    gcc-11.5.0 sparse
um                   randconfig-r2308-20261115    gcc-11.5.0 sparse
um                   randconfig-r2310-20261115    gcc-11.5.0 sparse
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261116    gcc-14
x86_64      buildonly-randconfig-1001-20261116    gcc-14
x86_64      buildonly-randconfig-1002-20261116    gcc-14
x86_64      buildonly-randconfig-1003-20261116    gcc-14
x86_64      buildonly-randconfig-1004-20261116    gcc-14
x86_64      buildonly-randconfig-1005-20261116    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261116    gcc-14
x86_64                randconfig-1001-20261116    gcc-14
x86_64                randconfig-1002-20261116    gcc-14
x86_64                randconfig-1003-20261116    gcc-14
x86_64                randconfig-1004-20261116    gcc-14
x86_64                randconfig-1005-20261116    gcc-14
x86_64                randconfig-1006-20261116    clang-22
x86_64                randconfig-1007-20261116    clang-22
x86_64                randconfig-1008-20261116    clang-22
x86_64                randconfig-1009-20261116    clang-22
x86_64                randconfig-1010-20261116    clang-22
x86_64                randconfig-1011-20261116    clang-22
x86_64                randconfig-1012-20261116    clang-22
x86_64                randconfig-1013-20261116    clang-22
x86_64                randconfig-1014-20261116    clang-22
x86_64                randconfig-1015-20261116    clang-22
x86_64                randconfig-1016-20261116    clang-22
x86_64                randconfig-1017-20261116    clang-22
x86_64                randconfig-2000-20261115    gcc-14
x86_64                randconfig-2000-20261116    gcc-14
x86_64                randconfig-2001-20261115    gcc-14
x86_64                randconfig-2001-20261116    gcc-14
x86_64                randconfig-2002-20261115    gcc-14
x86_64                randconfig-2002-20261116    gcc-14
x86_64                randconfig-2003-20261115    gcc-14
x86_64                randconfig-2003-20261116    gcc-14
x86_64                randconfig-2004-20261115    gcc-14
x86_64                randconfig-2004-20261116    gcc-14
x86_64                randconfig-2005-20261115    gcc-14
x86_64                randconfig-2005-20261116    gcc-14
x86_64                randconfig-2100-20261115    clang-22   cocci
x86_64                randconfig-2100-20261116    gcc-14     cocci
x86_64                randconfig-2101-20261115    clang-22   cocci
x86_64                randconfig-2101-20261116    gcc-14     cocci
x86_64                randconfig-2102-20261115    clang-22   cocci
x86_64                randconfig-2102-20261116    gcc-14     cocci
x86_64                randconfig-2103-20261115    clang-22   cocci
x86_64                randconfig-2103-20261116    gcc-14     cocci
x86_64                randconfig-2104-20261115    clang-22   cocci
x86_64                randconfig-2104-20261116    gcc-14     cocci
x86_64                randconfig-2105-20261115    clang-22   cocci
x86_64                randconfig-2105-20261116    gcc-14     cocci
x86_64                randconfig-2200-20261115    clang-22   smatch
x86_64                randconfig-2200-20261116    clang-22   smatch
x86_64                randconfig-2300-20261115    clang-22   sparse
x86_64                randconfig-2301-20261115    clang-22   sparse
x86_64                randconfig-2302-20261115    clang-22   sparse
x86_64               randconfig-r2101-20261115    gcc-8.5.0  cocci
x86_64               randconfig-r2105-20261116    gcc-16.2.0 cocci
x86_64               randconfig-r2111-20261115    gcc-13.5.0 cocci
x86_64               randconfig-r2301-20261115    gcc-13.5.0 sparse
x86_64               randconfig-r2302-20261116    gcc-15.3.0 sparse
x86_64               randconfig-r2305-20261115    gcc-13.5.0 sparse
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
xtensa                randconfig-1000-20261116    gcc-16.2.0
xtensa                randconfig-1001-20261116    gcc-16.2.0
xtensa                randconfig-2000-20261115    gcc-14.4.0
xtensa                randconfig-2000-20261116    gcc-16.2.0
xtensa                randconfig-2001-20261115    gcc-14.4.0
xtensa                randconfig-2001-20261116    gcc-16.2.0
xtensa                randconfig-2200-20261115    gcc-14.4.0 smatch
xtensa               randconfig-r2100-20261116    gcc-8.5.0  cocci
xtensa               randconfig-r2109-20261116    gcc-14.4.0 cocci
xtensa               randconfig-r2111-20261116    clang-17   cocci
xtensa               randconfig-r2306-20261116    gcc-16.2.0 sparse
xtensa               randconfig-r2308-20261116    gcc-16.2.0 sparse
xtensa               randconfig-r2310-20261116    gcc-16.2.0 sparse
xtensa               randconfig-r2311-20261116    gcc-16.2.0 sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

