Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6ADC531D0
	for <kexec@archiver.kernel.org>; Sat, 25 Jul 2026 13:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3oeWZYCZSmNsrcP88hT1CfWHIQfNFuHVVx9K+jHtOLM=; b=IKX1emSt80AJ3PhMMkQYZ0cocO
	IwBFzdxaAGQVovWQBFlwcnr4qAMXt5n3yWDAiHXuIcc4vvxVkanywJ/6V9G3uvWjV/IU9adiy7YTU
	YhHNQcUCXxH5WCMwFzdUNSbLjo9dHwTmjYZ7C5JR9x2n1jbzpBWHWd6U3i6UtEKz1b4PHYnEJKm0z
	/3sfrE1ReDmjiE8ngRrWrMaEHBRG/ZLXTuzGQ/J/AKr2m8wn4a+Hw2C+gIczBpunw7lD4bM9ZcRAQ
	+ghp7uxP/EDzHSBPk9c2fNtuN2yuK+K4SBBsBGr+0wWKbnAr//th16JY3EZHEZwsr1k4lXGzuiFOC
	LAGsfl5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnch9-00000000Ofv-49m6;
	Sat, 25 Jul 2026 13:45:39 +0000
Received: from mgamail.intel.com ([198.175.65.11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnch7-00000000Ofa-1ukH
	for kexec@lists.infradead.org;
	Sat, 25 Jul 2026 13:45:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784987138; x=1816523138;
  h=date:from:to:cc:subject:message-id;
  bh=zb91v2+iVPsSPyW7EfK7jsKf+TA0Fu/hKripvUpni5o=;
  b=XqYvbNFzXJZTQCBdt/43c/Uiiw/CoyI7iYzRFmKPrDTIcj4OM1CVrLB5
   5cMGQYt/D38LLNlQm0TypC6E6TJ/7z4uIslr6eGXCX3R6Ar3xkYF+LYwI
   TtWMMrkq151AwLG/+/+6WlF6nRndZvvAMIygcrpgNv5WvZquVoPAg4m1W
   DQ0gbeVNLM0q9BA8ZEf2xXKHcd1dYtqUAIidqhWh/bPELyi6iJixq+Nem
   iu1peD3kSftHxH31ov4q8GfadYvP3sW2POqF9pJpjmY3P7tQEKBwHsQib
   eqi0WV5vStG1Yo1qVpNQeFDIrIK1zp2etpJsdgC3AIA5XNGSlZHSeJLy1
   Q==;
X-CSE-ConnectionGUID: kLQmTtUZSLq4sVV2nuRLEg==
X-CSE-MsgGUID: 7PAUI5N1Rsq2fioK2rEpKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11856"; a="95984773"
X-IronPort-AV: E=Sophos;i="6.25,184,1779174000"; 
   d="scan'208";a="95984773"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2026 06:45:36 -0700
X-CSE-ConnectionGUID: dwWe7Q7iRWy2Nss0p7udIQ==
X-CSE-MsgGUID: p1DefRDhR0W/YQoFAluvfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,184,1779174000"; 
   d="scan'208";a="255609343"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 25 Jul 2026 06:45:34 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wnch2-00000000bhy-0URr;
	Sat, 25 Jul 2026 13:45:32 +0000
Date: Sat, 25 Jul 2026 21:45:19 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:next] BUILD SUCCESS
 cecfb90c5f2cc0622b363c2291b69d6cad272897
Message-ID: <202607252107.lb9u76t7-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260725_064537_541849_B803FC01 
X-CRM114-Status: UNSURE (   3.95  )
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
branch HEAD: cecfb90c5f2cc0622b363c2291b69d6cad272897  Merge branch 'selftests-lib' into next

elapsed time: 1413m

configs tested: 24
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                  allnoconfig    gcc-16.1.0
alpha                 allyesconfig    gcc-16.1.0
alpha                    defconfig    gcc-16.1.0
arc                   allmodconfig    gcc-16.1.0
arc                   allyesconfig    gcc-16.1.0
csky                  allmodconfig    gcc-16.1.0
hexagon             randconfig-001    gcc-9.5.0
hexagon    randconfig-001-20260725    gcc-9.5.0
hexagon    randconfig-002-20260725    gcc-9.5.0
i386                  allmodconfig    gcc-14
loongarch                defconfig    clang-24
loongarch  randconfig-001-20260725    gcc-9.5.0
loongarch  randconfig-002-20260725    gcc-9.5.0
nios2                 allmodconfig    gcc-11.5.0
nios2                  allnoconfig    gcc-11.5.0
nios2      randconfig-001-20260725    gcc-9.5.0
nios2      randconfig-002-20260725    gcc-9.5.0
parisc                allmodconfig    gcc-16.1.0
parisc                allyesconfig    gcc-16.1.0
parisc                   defconfig    gcc-16.1.0
sh                       defconfig    gcc-16.1.0
sh             edosk7760_defconfig    gcc-16.1.0
x86_64                       kexec    clang-22
x86_64                rhel-9.4-bpf    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

