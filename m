Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D004C53219
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 05:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ik2VbfvHJp90Rf1SivGj7BL36CHUgDuLrI5IHWXJIP0=; b=jufq3k9eS5fDqsyuEWgvvgGNbW
	LffhnvlnbJIYoCFWW7wcLVE5OEUWvhEv6lYsiEkEL5GHjRTrcyKPCXiVpYpobZ9xKHJY5TjEnmjt1
	tYN/2gvW/mae+AXGWY7nA1YMo/pmBFgUauMdOEy62ZfLFsFImT9vfzNkHsSpfg8mAjF/xtVLK/2cA
	kHNmTYplz0tnEBXpgW3X9MfZLly33nVL0jlSBtAyr8suR43yu+IkaZDTm9iQLhhajkz4RZQYdfq6w
	GBxHbRF7AotSMbeDL6lnusrFu/1UdKpioChPrRYZ96XvjgYNC7TAQU0bPwFp++iACBksmq3if41Gu
	kV48kpwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woa52-00000004QZe-3TNW;
	Tue, 28 Jul 2026 05:10:16 +0000
Received: from mgamail.intel.com ([198.175.65.17])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woa4z-00000004QYs-3xiE
	for kexec@lists.infradead.org;
	Tue, 28 Jul 2026 05:10:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785215415; x=1816751415;
  h=date:from:to:cc:subject:message-id;
  bh=dUQh00TnzWGcPA1Wwnrns+vxG9wwrr/b5SVpsFq7iK8=;
  b=eV8Av9UAUwF3rYXd4qfw08gR8LH3uFIfQAsS8WoGfYfKAIuGLkjMNyGW
   qvC3XKqVD+K6CcI4Wd+2h1rMPtDz7KSSCkYn0tnQXZjsUQZ0RYPsd8Tna
   BVO4QbaUUtNHjTrYv+CD2f7OhoQiQyZItY2Wyeyk7oQu8EFKV5z0TrslZ
   VEly1rWivUx3fWAuBgbLlzZ/tbWzEKu4zut5Rqn8xJS3rJwlZiSUYK0ae
   FaYMJNK44N5IWaSkLG1x7eGWzsyxzDvfZASF2KDcCL/cy6jxShynf2gid
   YgU2YkEeDhG82rl9g9W/4EKNTR9wxlgSjNSs7JLTPkv3ju4xMWuMkQBNN
   Q==;
X-CSE-ConnectionGUID: Pymm7SXTTDKyr8y4DQ+34w==
X-CSE-MsgGUID: 1IG/b4c+TnKlEPgvYLqWfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85803843"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="85803843"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 22:10:12 -0700
X-CSE-ConnectionGUID: ViNtua9nRlimpBHPTfPulw==
X-CSE-MsgGUID: nd5PLyDxTGqNcKu/JrdGQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="289564239"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 27 Jul 2026 22:10:10 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1woa4r-00000000e1L-3Tbq;
	Tue, 28 Jul 2026 05:10:06 +0000
Date: Tue, 28 Jul 2026 13:09:23 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: [liveupdate:kho-scratch] BUILD SUCCESS
 eb7145b5cb2a5e981860eaf80ae4417a9666c301
Message-ID: <202607281301.qTZ4WckM-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_221014_023153_24DE014D 
X-CRM114-Status: UNSURE (   4.14  )
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git kho-scratch
branch HEAD: eb7145b5cb2a5e981860eaf80ae4417a9666c301  Merge patch series "kho: make boot time huge page allocation work nicely with KHO"

elapsed time: 1645m

configs tested: 14
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha       allnoconfig    gcc-16.1.0
alpha      allyesconfig    gcc-16.1.0
alpha         defconfig    gcc-16.1.0
arc        allmodconfig    gcc-16.1.0
arc        allyesconfig    gcc-16.1.0
csky       allmodconfig    gcc-16.1.0
i386       allmodconfig    gcc-14
loongarch     defconfig    clang-24
nios2      allmodconfig    gcc-11.5.0
nios2       allnoconfig    gcc-11.5.0
parisc     allmodconfig    gcc-16.1.0
parisc     allyesconfig    gcc-16.1.0
parisc        defconfig    gcc-16.1.0
sh            defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

