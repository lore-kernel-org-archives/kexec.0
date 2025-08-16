Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DDCCA0EE4
	for <kexec@archiver.kernel.org>; Sat, 16 Aug 2025 05:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=14S8XPm6zgRdQkl/RX8nqZrdBjV6yIZBYrOsola0XDw=; b=tC989L1GHKVZmBdvd5jIZSpGYT
	ib799evy/bCnVC7gw6JuEERko4fze7YrLQHYnF6xBX95Q5vAUEqPMXiHxujDk/M04IJ1HC+0Rh3cE
	4vRzAFL5MdSyzvIfPbQVkehktdnXolaRWAXD0zGEkrHNnAA5E617ggvIJaRD2MZpmFIAUpJT0xmSC
	N3P1JL7vOUME5D9Ss1qmk0AlksX56Ux/rBUpmxYepcOfI4e9BdvA1RssKpIauHqtlm0+MiE/jSKAq
	DCcs7PbtouqNcc1ariJVmDL1bRq6UPg13k56cV1ohz0xNy5wUgH6T6+J/Dy+PjtxGFTRiuul1qfp4
	d4kro1xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1un9cm-000000046Os-1oaz;
	Sat, 16 Aug 2025 05:38:40 +0000
Received: from mgamail.intel.com ([198.175.65.14])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1un9cj-000000046OV-1Fgt
	for kexec@lists.infradead.org;
	Sat, 16 Aug 2025 05:38:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755322717; x=1786858717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RmFXkF27XLwgOi3sq9GPdq023gAeh1eLeY2QmR9xnAo=;
  b=ZHve2UFEswWav+Ub6/QGUUb0t6EfIoW9p5/bPA67AYR30XafXGz4vIGe
   e1Bcl8uSylyTwQqv/PERGqeAE5BQZW4MAph7yqrw/EH5KslRg46sQjI8+
   2kBPPDhi9iKKmzSIKgRLrHM5ICb/8/UPwYx8ciVV9UJPqHU814Z6+bDBx
   1rQa501DSSeI9PSez8bssBpZ8UMo6Ur0aDybj+XtavRAu5QxMrZUOo1W7
   YLDDZUexorYcgNpvg0QlRFUZpZXhb6s8QE8xQy1D8LCwWRNnIU9bVRAHA
   cYAMvXrCWDoHvtB+eGSyqZzOH2ctsztVDLyqMjf5seqwt24u+LGcwNbgu
   w==;
X-CSE-ConnectionGUID: 8KiAW1OFSYKJhY3wkUoJxA==
X-CSE-MsgGUID: IPCw/s0nTb2rn4aIMfvZ0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="61472918"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="61472918"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 22:38:34 -0700
X-CSE-ConnectionGUID: ok76rYeETKqqt5ErORr8TQ==
X-CSE-MsgGUID: RlIhM0uUTo2qwLWtC+kHcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167544025"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 15 Aug 2025 22:38:32 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1un9cY-000CcO-0Y;
	Sat, 16 Aug 2025 05:38:27 +0000
Date: Sat, 16 Aug 2025 13:37:33 +0800
From: kernel test robot <lkp@intel.com>
To: Youling Tang <youling.tang@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
	youling.tang@linux.dev, Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 2/6] LoongArch: Add kexec_file support
Message-ID: <202508161329.M5Axl1XA-lkp@intel.com>
References: <20250811092659.14903-3-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811092659.14903-3-youling.tang@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250815_223837_408282_3C13F566 
X-CRM114-Status: GOOD (  10.63  )
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

Hi Youling,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.17-rc1 next-20250815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Youling-Tang/LoongArch-Add-struct-loongarch_image_header-for-kernel-image/20250811-174725
base:   linus/master
patch link:    https://lore.kernel.org/r/20250811092659.14903-3-youling.tang%40linux.dev
patch subject: [PATCH 2/6] LoongArch: Add kexec_file support
config: loongarch-randconfig-r121-20250816 (https://download.01.org/0day-ci/archive/20250816/202508161329.M5Axl1XA-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.1.0
reproduce: (https://download.01.org/0day-ci/archive/20250816/202508161329.M5Axl1XA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508161329.M5Axl1XA-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/loongarch/kernel/kexec_image.c:19:
>> arch/loongarch/include/asm/image.h:40:22: warning: 'loongarch_pe_machtype' defined but not used [-Wunused-const-variable=]
      40 | static const uint8_t loongarch_pe_machtype[6] = {'P', 'E', 0x0, 0x0, 0x64, 0x62};
         |                      ^~~~~~~~~~~~~~~~~~~~~

sparse warnings: (new ones prefixed by >>)
>> arch/loongarch/kernel/kexec_image.c:63:22: sparse: sparse: cast to restricted __le64
   arch/loongarch/kernel/kexec_image.c:64:23: sparse: sparse: cast to restricted __le64

vim +/loongarch_pe_machtype +40 arch/loongarch/include/asm/image.h

    38	
    39	static const uint8_t loongarch_image_pe_sig[2] = {'M', 'Z'};
  > 40	static const uint8_t loongarch_pe_machtype[6] = {'P', 'E', 0x0, 0x0, 0x64, 0x62};
    41	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

