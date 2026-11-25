Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D5A606A681
	for <kexec@archiver.kernel.org>; Wed, 25 Nov 2026 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Lgig7Li2;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T0vg3E9a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=zMIlOptPKJ9RJVZQ4/Z6nX5nGsm7PMIUrLZ9pQwp5oU=; b=Lgig7Li2VF0GU81qLUNeUjRmRu
	fSKU8d/KURosC7pSJwvAqE1YlZc4gm0Q4YT111mDG73YfaK+dzWIBxFXiHaqUkkHFCCzXFQNVwFGA
	ZDNday0yoNnLh/0kKSZ0RFERhSWvwOjbTYaJEv4Fz+O3lPSOOf91d32j67gWIelTQ3TR0puidxauK
	NT9bh8/s1ICFgw/hgcJvZ/qo92ehWKKa6MvBiVWooAi5H63m4BD7Y85Jd8VnrXXq6R5Dr+TKB7t4T
	SwSd11WwaVOXqucFELLp0Lod5QgpO3UqYKj8TDtzXQ1l9lw+ZaZdH+sXDyNvqt0M0hYmGuE6RcI8I
	HYK4am6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9D4-00000009GZs-2qR3;
	Wed, 25 Nov 2026 09:22:38 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9Cy-00000009GYi-1OqE
	for kexec@lists.infradead.org;
	Wed, 25 Nov 2026 09:22:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795598553; x=1827134553;
  h=date:from:to:cc:subject:message-id;
  bh=+4Calrp3RkUvx8OEY0hd2VlE3TlfDXiNYcbKQJF4Yf0=;
  b=T0vg3E9aEU7CPF1MFhpqQEXmg3CMOzrD6PZuWgjAfzcnN31m7sR1J4mJ
   aqA9MikAnGsyI1nKYl0+pbNlKdKspwUV1wg0bwPtkvCbZb4/G7dIV6j9Y
   R6CowHn9NlYiM5Uqdc6uZ6XkMipnsFwMV8CgbAnlpyVa5ZmAYm45XQJkG
   WwQAKg2TA//sXhMp6AOFmhrIENpGhzvYyfy/IaEJQ60v1zdQZfQrJr2Ri
   nfOxvI4fhPl9uNzyrYnxsPax1ALM7ACQs2one4tXuxTkOYR1RWuCkCwm6
   WfNVhh0gSQS6OhSh7UQHTj2GMLi2U0uCERL4yD2k+EqQUsZRj+FdVfdU/
   Q==;
X-CSE-ConnectionGUID: QThRu8lZQCSTAvXg/Y6T+A==
X-CSE-MsgGUID: DMS+A7ocRWy+yJdPoyr9Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4529105"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4529105"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 01:21:45 -0800
X-CSE-ConnectionGUID: +NTXyCf+Q8uZVYyIofMRZA==
X-CSE-MsgGUID: LT0r5n4iRdKymVJzHcV1LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11940948"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 25 Nov 2026 01:21:43 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xW9C8-00000001RGU-1wIY;
	Wed, 25 Nov 2026 09:21:40 +0000
Date: Wed, 25 Nov 2026 17:21:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:kexec-next] BUILD SUCCESS
 732dd77a4e6f1814c0f9ab6929d11f4dab1675c0
Message-ID: <20261125172116.zhECatuB-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_012233_322557_558FD51A 
X-CRM114-Status: UNSURE (   4.54  )
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git kexec-next
branch HEAD: 732dd77a4e6f1814c0f9ab6929d11f4dab1675c0  Merge branch 'kexec-7.5' into kexec-next

elapsed time: 963m

configs tested: 610
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261124    gcc-11.5.0
alpha                 randconfig-2001-20261124    gcc-11.5.0
alpha                 randconfig-2200-20261124    gcc-8.5.0  smatch
alpha                randconfig-r2101-20261124    clang-22   cocci
alpha                randconfig-r2103-20261124    gcc-9.5.0  cocci
alpha                randconfig-r2111-20261125    gcc-13.5.0 cocci
alpha                randconfig-r2300-20261124    gcc-14.4.0 sparse
alpha                randconfig-r2300-20261124    gcc-16.2.0 sparse
alpha                randconfig-r2302-20261124    clang-17   sparse
alpha                randconfig-r2306-20261124    gcc-16.2.0 sparse
alpha                randconfig-r2310-20261124    gcc-16.2.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                          haps_hs_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261125    gcc-8.5.0
arc                   randconfig-1001-20261125    gcc-8.5.0
arc                   randconfig-2000-20261124    gcc-11.5.0
arc                   randconfig-2000-20261125    gcc-10.5.0
arc                   randconfig-2001-20261124    gcc-11.5.0
arc                   randconfig-2001-20261125    gcc-10.5.0
arc                   randconfig-2002-20261124    gcc-11.5.0
arc                   randconfig-2002-20261125    gcc-10.5.0
arc                   randconfig-2003-20261124    gcc-11.5.0
arc                   randconfig-2003-20261125    gcc-10.5.0
arc                   randconfig-2004-20261124    gcc-11.5.0
arc                   randconfig-2004-20261125    gcc-10.5.0
arc                   randconfig-2005-20261124    gcc-11.5.0
arc                   randconfig-2005-20261125    gcc-10.5.0
arc                   randconfig-2200-20261124    gcc-8.5.0  smatch
arc                  randconfig-r2101-20261124    gcc-16.2.0 cocci
arc                  randconfig-r2106-20261124    clang-24   cocci
arc                  randconfig-r2107-20261124    gcc-8.5.0  cocci
arc                  randconfig-r2107-20261125    gcc-13.5.0 cocci
arc                  randconfig-r2109-20261124    gcc-15.3.0 cocci
arc                  randconfig-r2110-20261124    clang-24   cocci
arc                  randconfig-r2300-20261124    clang-17   sparse
arc                  randconfig-r2300-20261124    gcc-16.2.0 sparse
arc                  randconfig-r2301-20261124    gcc-14.4.0 sparse
arc                  randconfig-r2304-20261124    gcc-16.2.0 sparse
arc                  randconfig-r2307-20261124    clang-24   sparse
arc                  randconfig-r2311-20261124    gcc-9.5.0  sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                          assabet_defconfig    gcc-16.2.0
arm                          axm55xx_defconfig    gcc-16.2.0
arm                          bcm2835_defconfig    clang-17
arm                         clps711x_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                          lpc18xx_defconfig    clang-17
arm                          lpc32xx_defconfig    clang-17
arm                           moxart_defconfig    clang-17
arm                           moxart_defconfig    clang-24
arm                          mv78xx0_defconfig    clang-17
arm                          mv78xx0_defconfig    gcc-16.2.0
arm                           pxa168_defconfig    clang-17
arm                           pxa168_defconfig    gcc-16.2.0
arm                           pxa3xx_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261125    gcc-8.5.0
arm                   randconfig-1001-20261125    gcc-8.5.0
arm                   randconfig-1002-20261125    gcc-8.5.0
arm                   randconfig-1003-20261125    gcc-8.5.0
arm                   randconfig-2000-20261124    clang-17
arm                   randconfig-2000-20261125    clang-22
arm                   randconfig-2001-20261124    clang-17
arm                   randconfig-2001-20261125    clang-22
arm                   randconfig-2002-20261124    clang-17
arm                   randconfig-2002-20261125    clang-22
arm                   randconfig-2200-20261124    clang-17   smatch
arm                  randconfig-r2100-20261124    clang-24   cocci
arm                  randconfig-r2100-20261124    gcc-16.2.0 cocci
arm                  randconfig-r2102-20261124    gcc-14.4.0 cocci
arm                  randconfig-r2103-20261124    gcc-16.2.0 cocci
arm                  randconfig-r2105-20261124    gcc-16.2.0 cocci
arm                  randconfig-r2107-20261124    gcc-15.3.0 cocci
arm                  randconfig-r2110-20261124    clang-24   cocci
arm                  randconfig-r2300-20261124    clang-22   sparse
arm                  randconfig-r2300-20261124    gcc-16.2.0 sparse
arm                  randconfig-r2300-20261125    gcc-12.5.0 sparse
arm                  randconfig-r2302-20261124    clang-18   sparse
arm                  randconfig-r2302-20261124    gcc-14.4.0 sparse
arm                  randconfig-r2303-20261124    gcc-16.2.0 sparse
arm                  randconfig-r2304-20261124    gcc-16.2.0 sparse
arm                  randconfig-r2305-20261124    gcc-14.4.0 sparse
arm                  randconfig-r2307-20261124    gcc-9.5.0  sparse
arm                  randconfig-r2311-20261124    clang-24   sparse
arm                            sama7_defconfig    clang-17
arm                          socfpga_defconfig    clang-17
arm                           sp7021_defconfig    clang-24
arm                           sp7021_defconfig    gcc-16.2.0
arm                            u8500_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261125    clang-24
arm64                 randconfig-1001-20261125    clang-24
arm64                 randconfig-1002-20261125    clang-24
arm64                 randconfig-1003-20261125    clang-24
arm64                 randconfig-2000-20261124    clang-17
arm64                 randconfig-2000-20261125    clang-22
arm64                 randconfig-2001-20261124    clang-17
arm64                 randconfig-2001-20261125    clang-22
arm64                 randconfig-2002-20261124    clang-17
arm64                 randconfig-2002-20261125    clang-22
arm64                 randconfig-2200-20261124    gcc-16.2.0 smatch
arm64                randconfig-r2101-20261124    clang-24   cocci
arm64                randconfig-r2105-20261124    gcc-8.5.0  cocci
arm64                randconfig-r2107-20261124    clang-24   cocci
arm64                randconfig-r2109-20261124    clang-24   cocci
arm64                randconfig-r2111-20261124    gcc-15.3.0 cocci
arm64                randconfig-r2300-20261124    gcc-16.2.0 sparse
arm64                randconfig-r2305-20261125    gcc-12.5.0 sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261125    clang-24
csky                  randconfig-1001-20261125    clang-24
csky                  randconfig-2000-20261124    gcc-16.2.0
csky                  randconfig-2001-20261124    gcc-16.2.0
csky                  randconfig-2200-20261124    gcc-15.3.0 smatch
csky                 randconfig-r2101-20261124    gcc-8.5.0  cocci
csky                 randconfig-r2104-20261124    gcc-8.5.0  cocci
csky                 randconfig-r2105-20261124    clang-22   cocci
csky                 randconfig-r2302-20261124    gcc-14.4.0 sparse
csky                 randconfig-r2303-20261124    gcc-14.4.0 sparse
csky                 randconfig-r2304-20261124    gcc-16.2.0 sparse
csky                 randconfig-r2306-20261125    gcc-16.2.0 sparse
csky                 randconfig-r2307-20261125    gcc-16.2.0 sparse
csky                 randconfig-r2309-20261124    clang-24   sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261125    gcc-11.5.0
hexagon               randconfig-1001-20261125    gcc-11.5.0
hexagon               randconfig-2000-20261124    gcc-16.2.0
hexagon               randconfig-2001-20261124    gcc-16.2.0
hexagon               randconfig-2200-20261125    clang-17   smatch
hexagon              randconfig-r2103-20261124    clang-22   cocci
hexagon              randconfig-r2103-20261124    clang-24   cocci
hexagon              randconfig-r2106-20261124    gcc-16.2.0 cocci
hexagon              randconfig-r2107-20261124    clang-24   cocci
hexagon              randconfig-r2107-20261124    gcc-14     cocci
hexagon              randconfig-r2110-20261124    gcc-16.2.0 cocci
hexagon              randconfig-r2302-20261124    gcc-16.2.0 sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261125    clang-22
i386        buildonly-randconfig-1001-20261125    clang-22
i386        buildonly-randconfig-1002-20261125    clang-22
i386        buildonly-randconfig-1003-20261125    clang-22
i386        buildonly-randconfig-1004-20261125    clang-22
i386        buildonly-randconfig-1005-20261125    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261125    clang-22
i386                  randconfig-1001-20261125    clang-22
i386                  randconfig-1002-20261125    clang-22
i386                  randconfig-1003-20261125    clang-22
i386                  randconfig-1004-20261125    clang-22
i386                  randconfig-1005-20261125    clang-22
i386                  randconfig-1006-20261125    clang-22
i386                  randconfig-2000-20261124    gcc-14
i386                  randconfig-2001-20261124    gcc-14
i386                  randconfig-2002-20261124    gcc-14
i386                  randconfig-2003-20261124    gcc-14
i386                  randconfig-2004-20261124    gcc-14
i386                  randconfig-2005-20261124    gcc-14
i386                  randconfig-2100-20261124    gcc-14     cocci
i386                  randconfig-2101-20261124    gcc-14     cocci
i386                  randconfig-2102-20261124    gcc-14     cocci
i386                  randconfig-2103-20261124    gcc-14     cocci
i386                  randconfig-2104-20261124    gcc-14     cocci
i386                  randconfig-2105-20261124    gcc-14     cocci
i386                  randconfig-2200-20261124    clang-22   smatch
i386                  randconfig-2300-20261124    gcc-14     sparse
i386                  randconfig-2301-20261124    gcc-14     sparse
i386                  randconfig-2302-20261124    gcc-14     sparse
i386                 randconfig-r2101-20261124    clang-24   cocci
i386                 randconfig-r2102-20261124    gcc-8.5.0  cocci
i386                 randconfig-r2103-20261124    gcc-16.2.0 cocci
i386                 randconfig-r2104-20261124    clang-22   cocci
i386                 randconfig-r2109-20261124    gcc-14     cocci
i386                 randconfig-r2110-20261124    gcc-11.5.0 cocci
i386                 randconfig-r2110-20261124    gcc-15.3.0 cocci
i386                 randconfig-r2111-20261124    gcc-11.5.0 cocci
i386                 randconfig-r2300-20261124    clang-18   sparse
i386                 randconfig-r2300-20261124    gcc-14.4.0 sparse
i386                 randconfig-r2301-20261124    gcc-16.2.0 sparse
i386                 randconfig-r2303-20261124    clang-22   sparse
i386                 randconfig-r2303-20261124    gcc-14.4.0 sparse
i386                 randconfig-r2305-20261124    gcc-16.2.0 sparse
i386                 randconfig-r2306-20261124    clang-24   sparse
i386                 randconfig-r2307-20261124    gcc-8.5.0  sparse
i386                 randconfig-r2308-20261124    gcc-16.2.0 sparse
i386                 randconfig-r2311-20261124    gcc-16.2.0 sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261125    gcc-11.5.0
loongarch             randconfig-1001-20261125    gcc-11.5.0
loongarch             randconfig-2000-20261124    clang-18
loongarch             randconfig-2001-20261124    clang-18
loongarch             randconfig-2200-20261124    gcc-16.2.0 smatch
loongarch            randconfig-r2100-20261124    gcc-16.2.0 cocci
loongarch            randconfig-r2100-20261124    gcc-9.5.0  cocci
loongarch            randconfig-r2105-20261124    gcc-14.4.0 cocci
loongarch            randconfig-r2106-20261124    gcc-15.3.0 cocci
loongarch            randconfig-r2302-20261125    gcc-12.5.0 sparse
loongarch            randconfig-r2304-20261124    gcc-14.4.0 sparse
loongarch            randconfig-r2309-20261124    gcc-16.2.0 sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                        m5235evb_defconfig    gcc-16.2.0
m68k                  randconfig-2000-20261124    gcc-11.5.0
m68k                  randconfig-2001-20261124    gcc-11.5.0
m68k                  randconfig-2200-20261124    gcc-10.5.0 smatch
m68k                  randconfig-2200-20261125    gcc-15.3.0 smatch
m68k                 randconfig-r2101-20261124    gcc-8.5.0  cocci
m68k                 randconfig-r2102-20261124    gcc-9.5.0  cocci
m68k                 randconfig-r2107-20261124    clang-20   cocci
m68k                 randconfig-r2107-20261124    gcc-11.5.0 cocci
m68k                 randconfig-r2111-20261124    gcc-8.5.0  cocci
m68k                 randconfig-r2300-20261124    gcc-15.3.0 sparse
m68k                 randconfig-r2308-20261124    gcc-9.5.0  sparse
m68k                           sun3x_defconfig    clang-17
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261124    gcc-11.5.0
microblaze            randconfig-2001-20261124    gcc-11.5.0
microblaze            randconfig-2200-20261124    gcc-8.5.0  smatch
microblaze           randconfig-r2100-20261124    gcc-14.4.0 cocci
microblaze           randconfig-r2101-20261124    gcc-14.4.0 cocci
microblaze           randconfig-r2105-20261124    gcc-8.5.0  cocci
microblaze           randconfig-r2106-20261125    gcc-13.5.0 cocci
microblaze           randconfig-r2107-20261124    gcc-11.5.0 cocci
microblaze           randconfig-r2108-20261124    gcc-15.3.0 cocci
microblaze           randconfig-r2108-20261125    gcc-13.5.0 cocci
microblaze           randconfig-r2110-20261124    gcc-8.5.0  cocci
microblaze           randconfig-r2301-20261124    gcc-14.4.0 sparse
microblaze           randconfig-r2302-20261124    gcc-16.2.0 sparse
microblaze           randconfig-r2305-20261124    clang-17   sparse
microblaze           randconfig-r2307-20261124    gcc-9.5.0  sparse
microblaze           randconfig-r2309-20261124    gcc-9.5.0  sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                           ath79_defconfig    clang-17
mips                        bmips_be_defconfig    gcc-16.2.0
mips                      decstation_defconfig    clang-17
mips                  decstation_r4k_defconfig    clang-17
mips                            gcw0_defconfig    clang-24
mips                            ip30_defconfig    clang-17
mips                            ip30_defconfig    gcc-16.2.0
mips                       maltasmvp_defconfig    gcc-16.2.0
mips                       pic32mzda_defconfig    clang-24
mips                  randconfig-2000-20261124    gcc-16.2.0
mips                  randconfig-2001-20261124    gcc-16.2.0
mips                  randconfig-2002-20261124    gcc-16.2.0
mips                  randconfig-2200-20261124    clang-20   smatch
mips                 randconfig-r2100-20261124    gcc-16.2.0 cocci
mips                 randconfig-r2100-20261124    gcc-8.5.0  cocci
mips                 randconfig-r2101-20261124    gcc-16.2.0 cocci
mips                 randconfig-r2102-20261124    clang-24   cocci
mips                 randconfig-r2110-20261124    gcc-14     cocci
mips                 randconfig-r2311-20261125    gcc-16.2.0 sparse
mips                          rt305x_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261125    gcc-11.5.0
nios2                 randconfig-1001-20261125    gcc-11.5.0
nios2                 randconfig-2000-20261124    clang-18
nios2                 randconfig-2001-20261124    clang-18
nios2                 randconfig-2200-20261124    gcc-11.5.0 smatch
nios2                 randconfig-2200-20261125    gcc-8.5.0  smatch
nios2                randconfig-r2100-20261124    clang-22   cocci
nios2                randconfig-r2103-20261124    gcc-8.5.0  cocci
nios2                randconfig-r2104-20261124    gcc-16.2.0 cocci
nios2                randconfig-r2104-20261124    gcc-9.5.0  cocci
nios2                randconfig-r2108-20261124    clang-20   cocci
nios2                randconfig-r2108-20261124    gcc-8.5.0  cocci
nios2                randconfig-r2109-20261124    gcc-11.5.0 cocci
nios2                randconfig-r2109-20261125    gcc-13.5.0 cocci
nios2                randconfig-r2111-20261124    clang-24   cocci
nios2                randconfig-r2111-20261124    gcc-14     cocci
nios2                randconfig-r2304-20261124    clang-22   sparse
nios2                randconfig-r2305-20261124    clang-22   sparse
nios2                randconfig-r2305-20261124    gcc-15.3.0 sparse
nios2                randconfig-r2306-20261124    gcc-9.5.0  sparse
nios2                randconfig-r2307-20261124    clang-20   sparse
nios2                randconfig-r2308-20261125    gcc-16.2.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261124    gcc-16.2.0
openrisc              randconfig-2001-20261124    gcc-16.2.0
openrisc              randconfig-2002-20261124    gcc-16.2.0
openrisc              randconfig-2200-20261124    gcc-11.5.0 smatch
openrisc             randconfig-r2102-20261124    clang-22   cocci
openrisc             randconfig-r2103-20261124    gcc-8.5.0  cocci
openrisc             randconfig-r2104-20261124    gcc-16.2.0 cocci
openrisc             randconfig-r2105-20261124    gcc-16.2.0 cocci
openrisc             randconfig-r2106-20261124    gcc-15.3.0 cocci
openrisc             randconfig-r2108-20261124    gcc-16.2.0 cocci
openrisc             randconfig-r2111-20261124    clang-24   cocci
openrisc             randconfig-r2111-20261124    gcc-11.5.0 cocci
openrisc             randconfig-r2304-20261124    clang-17   sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261125    clang-24
parisc                randconfig-1001-20261125    clang-24
parisc                randconfig-2000-20261124    clang-18
parisc                randconfig-2001-20261124    clang-18
parisc                randconfig-2200-20261124    gcc-9.5.0  smatch
parisc               randconfig-r2105-20261124    clang-24   cocci
parisc               randconfig-r2109-20261124    gcc-8.5.0  cocci
parisc               randconfig-r2301-20261124    gcc-15.3.0 sparse
parisc               randconfig-r2301-20261125    gcc-12.5.0 sparse
parisc               randconfig-r2303-20261124    gcc-16.2.0 sparse
parisc               randconfig-r2304-20261125    gcc-12.5.0 sparse
parisc               randconfig-r2305-20261124    gcc-16.2.0 sparse
parisc               randconfig-r2308-20261124    gcc-9.5.0  sparse
parisc               randconfig-r2311-20261124    clang-24   sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                      asp8347_defconfig    clang-24
powerpc                  canyonlands_defconfig    gcc-16.2.0
powerpc                  mpc836x_rdk_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261125    clang-24
powerpc               randconfig-1001-20261125    clang-24
powerpc               randconfig-2000-20261124    clang-24
powerpc               randconfig-2000-20261125    gcc-9.5.0
powerpc               randconfig-2001-20261124    clang-24
powerpc               randconfig-2001-20261125    gcc-9.5.0
powerpc               randconfig-2002-20261124    clang-24
powerpc               randconfig-2002-20261125    gcc-9.5.0
powerpc               randconfig-2200-20261124    clang-21   smatch
powerpc              randconfig-r2100-20261124    gcc-8.5.0  cocci
powerpc              randconfig-r2102-20261124    clang-22   cocci
powerpc              randconfig-r2102-20261124    gcc-16.2.0 cocci
powerpc              randconfig-r2104-20261124    gcc-16.2.0 cocci
powerpc              randconfig-r2104-20261124    gcc-8.5.0  cocci
powerpc              randconfig-r2105-20261124    clang-24   cocci
powerpc              randconfig-r2106-20261124    clang-20   cocci
powerpc              randconfig-r2106-20261124    clang-24   cocci
powerpc              randconfig-r2301-20261124    clang-18   sparse
powerpc              randconfig-r2302-20261124    clang-22   sparse
powerpc              randconfig-r2304-20261124    gcc-15.3.0 sparse
powerpc                      tqm8555_defconfig    clang-17
powerpc                          wii_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261125    clang-24
powerpc64             randconfig-1001-20261125    clang-24
powerpc64             randconfig-2000-20261124    clang-24
powerpc64             randconfig-2000-20261125    gcc-9.5.0
powerpc64             randconfig-2001-20261124    clang-24
powerpc64             randconfig-2001-20261125    gcc-9.5.0
powerpc64             randconfig-2002-20261124    clang-24
powerpc64             randconfig-2002-20261125    gcc-9.5.0
powerpc64             randconfig-2200-20261124    gcc-12.5.0 smatch
powerpc64            randconfig-r2101-20261124    clang-22   cocci
powerpc64            randconfig-r2102-20261124    gcc-8.5.0  cocci
powerpc64            randconfig-r2103-20261124    gcc-14.4.0 cocci
powerpc64            randconfig-r2105-20261124    clang-22   cocci
powerpc64            randconfig-r2105-20261124    gcc-16.2.0 cocci
powerpc64            randconfig-r2108-20261124    clang-24   cocci
powerpc64            randconfig-r2110-20261124    clang-24   cocci
powerpc64            randconfig-r2302-20261124    gcc-16.2.0 sparse
powerpc64            randconfig-r2303-20261124    clang-17   sparse
powerpc64            randconfig-r2308-20261124    clang-20   sparse
powerpc64            randconfig-r2310-20261124    clang-24   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv              nommu_k210_sdcard_defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261125    gcc-8.5.0
riscv                 randconfig-1001-20261125    gcc-8.5.0
riscv                 randconfig-2000-20261124    gcc-16.2.0
riscv                 randconfig-2001-20261124    gcc-16.2.0
riscv                 randconfig-2002-20261124    gcc-16.2.0
riscv                 randconfig-2003-20261124    gcc-16.2.0
riscv                 randconfig-2004-20261124    gcc-16.2.0
riscv                 randconfig-2005-20261124    gcc-16.2.0
riscv                 randconfig-2200-20261124    gcc-14.4.0 smatch
riscv                randconfig-r2102-20261124    gcc-16.2.0 cocci
riscv                randconfig-r2105-20261124    gcc-16.2.0 cocci
riscv                randconfig-r2106-20261124    clang-24   cocci
riscv                randconfig-r2107-20261124    clang-24   cocci
riscv                randconfig-r2110-20261124    gcc-11.5.0 cocci
riscv                randconfig-r2111-20261124    clang-20   cocci
riscv                randconfig-r2303-20261124    gcc-15.3.0 sparse
riscv                randconfig-r2305-20261124    clang-18   sparse
riscv                randconfig-r2305-20261124    gcc-16.2.0 sparse
riscv                randconfig-r2306-20261124    clang-24   sparse
riscv                randconfig-r2308-20261124    clang-24   sparse
riscv                randconfig-r2311-20261124    gcc-9.5.0  sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261125    gcc-8.5.0
s390                  randconfig-1001-20261125    gcc-8.5.0
s390                  randconfig-2000-20261124    clang-24
s390                  randconfig-2000-20261125    clang-24
s390                  randconfig-2001-20261124    clang-24
s390                  randconfig-2001-20261125    clang-24
s390                  randconfig-2002-20261124    clang-24
s390                  randconfig-2002-20261125    clang-24
s390                  randconfig-2003-20261124    clang-24
s390                  randconfig-2003-20261125    clang-24
s390                  randconfig-2004-20261124    clang-24
s390                  randconfig-2004-20261125    clang-24
s390                  randconfig-2005-20261124    clang-24
s390                  randconfig-2005-20261125    clang-24
s390                  randconfig-2200-20261124    clang-24   smatch
s390                 randconfig-r2102-20261124    gcc-16.2.0 cocci
s390                 randconfig-r2104-20261124    clang-24   cocci
s390                 randconfig-r2106-20261124    gcc-14     cocci
s390                 randconfig-r2110-20261124    clang-20   cocci
s390                 randconfig-r2111-20261124    gcc-16.2.0 cocci
s390                 randconfig-r2303-20261124    clang-18   sparse
s390                 randconfig-r2310-20261124    gcc-8.5.0  sparse
s390                 randconfig-r2310-20261124    gcc-9.5.0  sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                              espt_defconfig    clang-24
sh                    randconfig-1000-20261125    gcc-8.5.0
sh                    randconfig-1001-20261125    gcc-8.5.0
sh                    randconfig-2000-20261124    gcc-11.5.0
sh                    randconfig-2001-20261124    gcc-11.5.0
sh                    randconfig-2002-20261124    gcc-11.5.0
sh                    randconfig-2003-20261124    gcc-11.5.0
sh                    randconfig-2004-20261124    gcc-11.5.0
sh                    randconfig-2005-20261124    gcc-11.5.0
sh                    randconfig-2200-20261124    gcc-16.2.0 smatch
sh                    randconfig-2200-20261125    gcc-14.4.0 smatch
sh                   randconfig-r2101-20261124    gcc-16.2.0 cocci
sh                   randconfig-r2103-20261124    clang-22   cocci
sh                   randconfig-r2106-20261124    gcc-11.5.0 cocci
sh                   randconfig-r2107-20261124    gcc-15.3.0 cocci
sh                   randconfig-r2108-20261124    gcc-11.5.0 cocci
sh                   randconfig-r2109-20261124    gcc-11.5.0 cocci
sh                   randconfig-r2302-20261124    gcc-15.3.0 sparse
sh                   randconfig-r2303-20261125    gcc-12.5.0 sparse
sh                   randconfig-r2305-20261124    gcc-16.2.0 sparse
sh                   randconfig-r2307-20261124    clang-24   sparse
sh                   randconfig-r2309-20261124    gcc-9.5.0  sparse
sh                   randconfig-r2309-20261125    gcc-16.2.0 sparse
sh                   randconfig-r2311-20261124    gcc-8.5.0  sparse
sh                            se7343_defconfig    gcc-16.2.0
sh                            se7780_defconfig    gcc-16.2.0
sh                         sh7757lcr_defconfig    gcc-16.2.0
sh                             shmin_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261125    gcc-12
sparc                 randconfig-1001-20261125    gcc-12
sparc                 randconfig-2000-20261124    gcc-8.5.0
sparc                 randconfig-2000-20261125    gcc-8.5.0
sparc                 randconfig-2001-20261124    gcc-8.5.0
sparc                 randconfig-2001-20261125    gcc-8.5.0
sparc                 randconfig-2200-20261124    gcc-11.5.0 smatch
sparc                randconfig-r2102-20261124    gcc-16.2.0 cocci
sparc                randconfig-r2103-20261124    clang-24   cocci
sparc                randconfig-r2103-20261124    gcc-16.2.0 cocci
sparc                randconfig-r2104-20261124    gcc-16.2.0 cocci
sparc                randconfig-r2108-20261124    clang-24   cocci
sparc                randconfig-r2109-20261124    clang-24   cocci
sparc                randconfig-r2109-20261124    gcc-16.2.0 cocci
sparc                randconfig-r2301-20261124    gcc-16.2.0 sparse
sparc                randconfig-r2303-20261124    gcc-16.2.0 sparse
sparc                randconfig-r2304-20261124    gcc-14.4.0 sparse
sparc                randconfig-r2306-20261124    gcc-8.5.0  sparse
sparc                randconfig-r2307-20261124    gcc-16.2.0 sparse
sparc                randconfig-r2308-20261124    gcc-8.5.0  sparse
sparc                randconfig-r2309-20261124    clang-20   sparse
sparc                randconfig-r2309-20261124    clang-24   sparse
sparc                randconfig-r2310-20261124    clang-24   sparse
sparc                randconfig-r2311-20261124    clang-20   sparse
sparc64                           alldefconfig    clang-24
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261125    gcc-12
sparc64               randconfig-1001-20261125    gcc-12
sparc64               randconfig-2000-20261124    gcc-8.5.0
sparc64               randconfig-2000-20261125    gcc-8.5.0
sparc64               randconfig-2001-20261124    gcc-8.5.0
sparc64               randconfig-2001-20261125    gcc-8.5.0
sparc64               randconfig-2200-20261124    clang-24   smatch
sparc64              randconfig-r2104-20261124    clang-24   cocci
sparc64              randconfig-r2105-20261124    gcc-9.5.0  cocci
sparc64              randconfig-r2106-20261124    gcc-11.5.0 cocci
sparc64              randconfig-r2108-20261124    gcc-14     cocci
sparc64              randconfig-r2109-20261124    clang-20   cocci
sparc64              randconfig-r2109-20261124    gcc-15.3.0 cocci
sparc64              randconfig-r2306-20261124    gcc-9.5.0  sparse
sparc64              randconfig-r2310-20261124    clang-20   sparse
sparc64              randconfig-r2310-20261124    gcc-9.5.0  sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261125    gcc-12
um                    randconfig-1001-20261125    gcc-12
um                    randconfig-2000-20261124    gcc-8.5.0
um                    randconfig-2000-20261125    gcc-8.5.0
um                    randconfig-2001-20261124    gcc-8.5.0
um                    randconfig-2001-20261125    gcc-8.5.0
um                    randconfig-2200-20261124    gcc-14     smatch
um                   randconfig-r2100-20261124    clang-22   cocci
um                   randconfig-r2100-20261124    clang-24   cocci
um                   randconfig-r2101-20261124    gcc-9.5.0  cocci
um                   randconfig-r2102-20261124    clang-24   cocci
um                   randconfig-r2103-20261124    gcc-16.2.0 cocci
um                   randconfig-r2301-20261124    gcc-16.2.0 sparse
um                   randconfig-r2304-20261124    clang-18   sparse
um                   randconfig-r2305-20261124    gcc-14.4.0 sparse
um                   randconfig-r2306-20261124    clang-20   sparse
um                   randconfig-r2308-20261124    clang-24   sparse
um                   randconfig-r2309-20261124    gcc-8.5.0  sparse
um                   randconfig-r2310-20261125    gcc-16.2.0 sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261125    clang-22
x86_64      buildonly-randconfig-1001-20261125    clang-22
x86_64      buildonly-randconfig-1002-20261125    clang-22
x86_64      buildonly-randconfig-1003-20261125    clang-22
x86_64      buildonly-randconfig-1004-20261125    clang-22
x86_64      buildonly-randconfig-1005-20261125    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261125    clang-22
x86_64                randconfig-1001-20261125    clang-22
x86_64                randconfig-1002-20261125    clang-22
x86_64                randconfig-1003-20261125    clang-22
x86_64                randconfig-1004-20261125    clang-22
x86_64                randconfig-1005-20261125    clang-22
x86_64                randconfig-2000-20261124    gcc-14
x86_64                randconfig-2000-20261125    gcc-14
x86_64                randconfig-2001-20261124    gcc-14
x86_64                randconfig-2001-20261125    gcc-14
x86_64                randconfig-2002-20261124    gcc-14
x86_64                randconfig-2002-20261125    gcc-14
x86_64                randconfig-2003-20261124    gcc-14
x86_64                randconfig-2003-20261125    gcc-14
x86_64                randconfig-2004-20261124    gcc-14
x86_64                randconfig-2004-20261125    gcc-14
x86_64                randconfig-2005-20261124    gcc-14
x86_64                randconfig-2005-20261125    gcc-14
x86_64                randconfig-2100-20261124    gcc-14     cocci
x86_64                randconfig-2101-20261124    gcc-14     cocci
x86_64                randconfig-2102-20261124    gcc-14     cocci
x86_64                randconfig-2103-20261124    gcc-14     cocci
x86_64                randconfig-2104-20261124    gcc-14     cocci
x86_64                randconfig-2105-20261124    gcc-14     cocci
x86_64                randconfig-2200-20261124    gcc-14     smatch
x86_64                randconfig-2200-20261125    gcc-14     smatch
x86_64                randconfig-2300-20261124    gcc-14     sparse
x86_64                randconfig-2301-20261124    gcc-14     sparse
x86_64                randconfig-2302-20261124    gcc-14     sparse
x86_64               randconfig-r2106-20261124    gcc-8.5.0  cocci
x86_64               randconfig-r2109-20261124    clang-24   cocci
x86_64               randconfig-r2110-20261124    gcc-15.3.0 cocci
x86_64               randconfig-r2301-20261124    clang-22   sparse
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
xtensa                   audio_kc705_defconfig    clang-17
xtensa                           iss_defconfig    gcc-16.2.0
xtensa                randconfig-1000-20261125    gcc-12
xtensa                randconfig-1001-20261125    gcc-12
xtensa                randconfig-2000-20261124    gcc-16.2.0
xtensa                randconfig-2001-20261124    gcc-16.2.0
xtensa                randconfig-2200-20261124    gcc-9.5.0  smatch
xtensa                randconfig-2200-20261125    gcc-16.2.0 smatch
xtensa               randconfig-r2100-20261124    gcc-16.2.0 cocci
xtensa               randconfig-r2101-20261124    gcc-16.2.0 cocci
xtensa               randconfig-r2104-20261124    gcc-14.4.0 cocci
xtensa               randconfig-r2107-20261124    gcc-16.2.0 cocci
xtensa               randconfig-r2108-20261124    clang-24   cocci
xtensa               randconfig-r2108-20261124    gcc-11.5.0 cocci
xtensa               randconfig-r2110-20261125    gcc-13.5.0 cocci
xtensa               randconfig-r2111-20261124    clang-24   cocci
xtensa               randconfig-r2301-20261124    clang-17   sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

