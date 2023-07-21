Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED88EB64DD
	for <kexec@archiver.kernel.org>; Fri, 21 Jul 2023 21:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wZuGlEo46sKpFDSVkeA/oTKJ/JvSCCJdhq0IWkSbGNM=; b=o0dg9083ptAnjj
	iLcvSh1UObGFdzGDH5NaF6oKPh65EvQdWT3/rR60Ng37e1Poe4EP8leWVfnykEf8Kfi3WP3yRotp8
	N7p2F/wG8zok06LRRod6EnbT8OObIgNlDsWd1UIn/3wpdFVHolTsBir8SRDQRSFBAAGePKoI2CNTZ
	cIL4HqJsrGrdcuF2bDAxx0c4j8p2LdXw2vv5d+U1dOo/BenaLEpZRLL4nkALFIuKslnpqlPB02lXk
	tDBq3qnPWqrJwlwVwG7rwJBVfoINyl2b3NGOcLlcB05+2omOTPQQ4NYguI7BItWInkumHG+dyZ4PU
	5X/q+3lJ2c0quOfZ3/dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMxac-00F9HU-2D;
	Fri, 21 Jul 2023 21:23:06 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMxaZ-00F9Fu-0r;
	Fri, 21 Jul 2023 21:23:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689974583; x=1721510583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+l8avb+Up5dj5lQ+lm2WQ7/323A6EvT04ucY7c/xtj4=;
  b=KHS75eaKORwjwLMA/AloK3OhnPyvruIsUvJ+0gykHcydT8otRTmULOVl
   JxwxBXJx4inCQiqfYU41PSweNU4ofrxO+fXARvIp4CzXHcSno8C8XlVsg
   gqEk/ARUKNZ07bMKS1+C6ioZM2/ZRt4YIhpaDJa/KXo1UkHTkuWjsmtoi
   9QgZMpFHlZFkj19+Pb/OOLA93oO15nM9grkTfQRRXNz+lFb1MhqYm5zLd
   e/sGu3GLOVT5FxOzmq0JXo2l7A6ol7XM2x2kuuXglcJwgjR7szDzAuEp8
   PqYg9jjTYiSTbW04w+mgp9GmS9I/irol3x9P5vAU4Ghx8YY55xiGvC/F6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="357116639"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="357116639"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 14:22:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="702166598"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="702166598"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 21 Jul 2023 14:22:55 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qMxa9-0007fl-00;
	Fri, 21 Jul 2023 21:22:39 +0000
Date: Sat, 22 Jul 2023 05:22:36 +0800
From: kernel test robot <lkp@intel.com>
To: thunder.leizhen@huaweicloud.com, Dave Young <dyoung@redhat.com>,
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/3] arm64: kdump: Allocate crash low memory in the
 bottom-up direction
Message-ID: <202307220500.1I73fZ5Z-lkp@intel.com>
References: <20230721081726.882-2-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230721081726.882-2-thunder.leizhen@huaweicloud.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230721_142303_379366_FD3D783A 
X-CRM114-Status: GOOD (  13.07  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on linus/master v6.5-rc2 next-20230721]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/thunder-leizhen-huaweicloud-com/arm64-kdump-Allocate-crash-low-memory-in-the-bottom-up-direction/20230721-162312
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20230721081726.882-2-thunder.leizhen%40huaweicloud.com
patch subject: [PATCH 1/3] arm64: kdump: Allocate crash low memory in the bottom-up direction
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20230722/202307220500.1I73fZ5Z-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230722/202307220500.1I73fZ5Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307220500.1I73fZ5Z-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: arch/arm64/mm/init.o: in function `late_reserve_crashkernel':
>> init.c:(.init.text+0x58): undefined reference to `crashk_res'
   aarch64-linux-ld: arch/arm64/mm/init.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `crashk_res' which may bind externally can not be used when making a shared object; recompile with -fPIC
   init.c:(.init.text+0x58): dangerous relocation: unsupported relocation
>> aarch64-linux-ld: init.c:(.init.text+0x5c): undefined reference to `crashk_res'
>> aarch64-linux-ld: init.c:(.init.text+0x88): undefined reference to `crashk_low_res'
   aarch64-linux-ld: arch/arm64/mm/init.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `crashk_low_res' which may bind externally can not be used when making a shared object; recompile with -fPIC
   init.c:(.init.text+0x88): dangerous relocation: unsupported relocation
   aarch64-linux-ld: init.c:(.init.text+0x90): undefined reference to `crashk_res'
   aarch64-linux-ld: init.c:(.init.text+0x9c): undefined reference to `crashk_low_res'
   aarch64-linux-ld: init.c:(.init.text+0xd0): undefined reference to `crashk_res'
   aarch64-linux-ld: init.c:(.init.text+0x13c): undefined reference to `crashk_res'
   aarch64-linux-ld: init.c:(.init.text+0x150): undefined reference to `crashk_res'
   aarch64-linux-ld: init.c:(.init.text+0x18c): undefined reference to `crashk_low_res'
   aarch64-linux-ld: init.c:(.init.text+0x1b0): undefined reference to `crashk_low_res'
   aarch64-linux-ld: init.c:(.init.text+0x204): undefined reference to `crashk_low_res'
   aarch64-linux-ld: init.c:(.init.text+0x234): undefined reference to `crashk_low_res'
   aarch64-linux-ld: init.c:(.init.text+0x248): undefined reference to `crashk_low_res'
   aarch64-linux-ld: arch/arm64/mm/init.o:init.c:(.init.text+0x25c): more undefined references to `crashk_low_res' follow

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
