Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B33C531C9
	for <kexec@archiver.kernel.org>; Sat, 25 Jul 2026 14:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=k+OB7tYDL71HrWRR6TsfZLJcNNzXSQc4LKv1N4+i7nM=; b=BsKdNwDQh4LhdbBf4W24YtX0pK
	7zrknXOsy7Ax1WyR/+ZoSe1P0jxGlXpOuJlq2zG+o3cbeByvH31PqtiUxtXOCRaYBN0sy7BQACOYW
	oMw85/htyLXu7Of7lnMe7C1nL7He3U+Q3xgWVlTsiyZj45ed0+742H6MGhR1eioB4CBQE7qJ4kT2J
	v0u6rPL80dncDiJ+CzIcsV9skrhRtnfzeh/R5rbwS/Jp/1hktIeJtHHqzBT5aDi1juryBe3LTT21z
	LVs93cUGoGB7jXQGaEDZBJk6orH9yuLiis9ISZEeQxAk7ChhCwTIxeKJH9dy3W/dFYTYfiYfd9wkY
	IXCoONaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnd9m-00000000QfC-3G9J;
	Sat, 25 Jul 2026 14:15:14 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnd9j-00000000Qei-3ykT
	for kexec@lists.infradead.org;
	Sat, 25 Jul 2026 14:15:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784988912; x=1816524912;
  h=date:from:to:cc:subject:message-id;
  bh=cSjkcf2rj5eQ4xZW7EsZdatjripgh+3uJubA+4k4RJs=;
  b=aSVk7BtS5BezWowF9ONyxDvCxbNrAXILq5EReUj9wR6xqR+NWeA54AmI
   juwrVVLUU5GSESxVJ/EorrEkbwjnmMrpfRq49QoVAztpfuM3QB5YBrhQC
   Y8CnSTXY90Va5zjb4OWSZSyjq7b77wNPhl1gDs8ADOndDFHkiDEza8r4I
   X6KzGTaaD4Ll+IRzT9Wpr/195oh8s48GuC1zzkP21SXGRhNwxU/JjdJyT
   kF67y/2qn3vOcpaisZ2DkWnQ4vcxpUZ7uyc+At55TdGRR+z/GOWg/n5zK
   Qm4jRIUFEz7T5sDwAV5v3ZMqbwrclzruof/srhGAPchRQQUMbiOzpVH5L
   w==;
X-CSE-ConnectionGUID: JcmDLUhaTA+B0TOaf02g/w==
X-CSE-MsgGUID: 25k2ImsPTOGlmC1iDi0sEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11856"; a="111172518"
X-IronPort-AV: E=Sophos;i="6.25,184,1779174000"; 
   d="scan'208";a="111172518"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2026 07:15:11 -0700
X-CSE-ConnectionGUID: B6Pj8qh1Ra+mZykadUA4/A==
X-CSE-MsgGUID: 8jM3kwu9T36Tb8DrvKKWyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,184,1779174000"; 
   d="scan'208";a="256312853"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 25 Jul 2026 07:15:10 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wnd9f-00000000bjW-3Nbb;
	Sat, 25 Jul 2026 14:15:07 +0000
Date: Sat, 25 Jul 2026 22:14:54 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:fixes] BUILD SUCCESS
 b44889cbaada8acedf68c75e5eb2d095b30e508c
Message-ID: <202607252211.x8MHqZqx-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260725_071512_022936_A00BE202 
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git fixes
branch HEAD: b44889cbaada8acedf68c75e5eb2d095b30e508c  liveupdate: Remember FLB retrieve() status

elapsed time: 1444m

configs tested: 30
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
riscv      randconfig-001-20260725    gcc-10.5.0
riscv      randconfig-002-20260725    gcc-10.5.0
s390       randconfig-001-20260725    gcc-10.5.0
s390       randconfig-002-20260725    gcc-10.5.0
sh                       defconfig    gcc-16.1.0
sh             edosk7760_defconfig    gcc-16.1.0
sh         randconfig-001-20260725    gcc-10.5.0
sh         randconfig-002-20260725    gcc-10.5.0
x86_64                       kexec    clang-22
x86_64                rhel-9.4-bpf    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

