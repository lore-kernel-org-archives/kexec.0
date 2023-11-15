Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279F1C54FB9
	for <kexec@archiver.kernel.org>; Wed, 15 Nov 2023 17:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2UkwmdrWzFnUyuDIGbCUciEg9fb0rgBWBxO5IHdgvQY=; b=KIG/8oHlaPz6Mc
	9swpbc6Uh2VgA/VG7WQd0AD/rLBpMR1Cn47RcgQTm9g5HzQEzOxpQZxbI6vywGYHcbbc2BnPJnpTd
	2+ousxetNnF+jFqrQKMjDxRhLMpGRZBr0/ojqLLf4h7bQ/AyRs+9QoCF8UF8YkNbmg/B5BAUCpR1k
	0MTP2MvGvo6+CSN8Gs+X2uz6OtYKZYMVyus2ayPYZ2B8XndIyi+6+k3B2ntTzV1lY/87OHbHdQN5b
	gW67jKsp+PSQI71N4NdkAjwAbin3fgDqHHcFory4B6oYr6bkRTfTjqKoS1Kz59wlsv6W9LV3OMNRA
	dH3oV0QhLapU38NL+AyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3JF6-001Ntp-2z;
	Wed, 15 Nov 2023 16:59:56 +0000
Received: from mgamail.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3JF3-001NtD-2w;
	Wed, 15 Nov 2023 16:59:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700067593; x=1731603593;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9uKcFY4QauvFYKvl+Sytq0IYlA4lqNfQ+9TYosW5GMY=;
  b=eOlVg1yUlxy04G8kdmFVkwz9pOoVC/S4lNN9Fd3+vdWmkWJP2+WDuPze
   FJ2srh12iuYX5gk6cg6KzC79orv0eg/OE4s09HtSog1i0Wtd5DF4B63Dc
   mrP7+iSZrxND7lnIMvghQCFkJ67E6dfeS2sQLApvoDNAMdSEud/N8L25e
   idZbygIhvRyacG2NPtie9HJ6cuj7TJFPaJ0XMytM9YFJYHNwUxvxiRsfX
   qrDr1sQagOQF/iHt5Np7pituaG97hvJiljCQc1QGo2X3b9xfqpFiyChWY
   6KoRwFyu1CIidygmMERWajb/hqJjD3HgBGoguVjVS0CIPbHwCnoye4vKh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="375952892"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="375952892"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 08:59:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="6220123"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 15 Nov 2023 08:59:30 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r3JEe-0000c8-0k;
	Wed, 15 Nov 2023 16:59:28 +0000
Date: Thu, 16 Nov 2023 00:58:29 +0800
From: kernel test robot <lkp@intel.com>
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kexec@lists.infradead.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-parisc@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 4/7] kexec_file, arm64: print out debugging message if
 required
Message-ID: <202311160022.QM6xJYSy-lkp@intel.com>
References: <20231114153253.241262-5-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231114153253.241262-5-bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231115_085954_062420_F49741F7 
X-CRM114-Status: GOOD (  11.49  )
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

Hi Baoquan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on tip/x86/core powerpc/next powerpc/fixes linus/master v6.7-rc1 next-20231115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/kexec_file-add-kexec_file-flag-to-control-debug-printing/20231114-234003
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20231114153253.241262-5-bhe%40redhat.com
patch subject: [PATCH 4/7] kexec_file, arm64: print out debugging message if required
config: arm64-randconfig-001-20231115 (https://download.01.org/0day-ci/archive/20231116/202311160022.QM6xJYSy-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160022.QM6xJYSy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160022.QM6xJYSy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/arm64/kernel/machine_kexec.c: In function '_kexec_image_info':
>> arch/arm64/kernel/machine_kexec.c:35:23: warning: unused variable 'i' [-Wunused-variable]
      35 |         unsigned long i;
         |                       ^


vim +/i +35 arch/arm64/kernel/machine_kexec.c

d28f6df1305a86 Geoff Levand 2016-06-23  27  
221f2c770e10d3 Geoff Levand 2016-06-23  28  /**
221f2c770e10d3 Geoff Levand 2016-06-23  29   * kexec_image_info - For debugging output.
221f2c770e10d3 Geoff Levand 2016-06-23  30   */
221f2c770e10d3 Geoff Levand 2016-06-23  31  #define kexec_image_info(_i) _kexec_image_info(__func__, __LINE__, _i)
221f2c770e10d3 Geoff Levand 2016-06-23  32  static void _kexec_image_info(const char *func, int line,
221f2c770e10d3 Geoff Levand 2016-06-23  33  	const struct kimage *kimage)
221f2c770e10d3 Geoff Levand 2016-06-23  34  {
221f2c770e10d3 Geoff Levand 2016-06-23 @35  	unsigned long i;
221f2c770e10d3 Geoff Levand 2016-06-23  36  
f24d07b8c8e272 Baoquan He   2023-11-14  37  	kexec_dprintk("%s:%d:\n", func, line);
f24d07b8c8e272 Baoquan He   2023-11-14  38  	kexec_dprintk("  kexec kimage info:\n");
f24d07b8c8e272 Baoquan He   2023-11-14  39  	kexec_dprintk("    type:        %d\n", kimage->type);
f24d07b8c8e272 Baoquan He   2023-11-14  40  	kexec_dprintk("    head:        %lx\n", kimage->head);
f24d07b8c8e272 Baoquan He   2023-11-14  41  	kexec_dprintk("    kern_reloc: %pa\n", &kimage->arch.kern_reloc);
f24d07b8c8e272 Baoquan He   2023-11-14  42  	kexec_dprintk("    el2_vectors: %pa\n", &kimage->arch.el2_vectors);
221f2c770e10d3 Geoff Levand 2016-06-23  43  }
221f2c770e10d3 Geoff Levand 2016-06-23  44  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
