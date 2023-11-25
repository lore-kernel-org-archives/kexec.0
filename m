Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A796C4167B
	for <kexec@archiver.kernel.org>; Sat, 25 Nov 2023 21:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LuzaF1GVoKo8xjlE3FjTrO5AUKcUNoG92CGjGAWbo2E=; b=ouMunFvhcnqzbH
	osHJVh1wnU8uXPpAsxOR4kEoHXj4wDSh2qP2+krcuxpeb1ehVMoMyVEOyYTvNb54KGutCpQKWYYHZ
	uPiPJjQeWwulUdthcFUBYBGuuqASVGtV1ASgvk1MbrTTAvMZeF8KoKZSn3DR6UCkebm6lO6pV3Uy5
	XLOv5vMM6T6PFA514+beRy05va9c2YrKUZstCjsNlxDfvV/MVi7e+ikQLqh7iDK25DkY5fPicma/M
	6EEIxOe3e6fqOBwM5iHftGvmiLzf844Ez/uysId0BbS0sivAfD6C6aUU+ggSF5+N4cgLXg/yLM1Oi
	JS1X891r41UryiKJwXpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r70Bi-009pXp-2X;
	Sat, 25 Nov 2023 21:27:42 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r70Be-009pXB-1y;
	Sat, 25 Nov 2023 21:27:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700947658; x=1732483658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2msMvypUB/fdSacdfq9Xd4cZCJy1Df5Vy8rcx7wAbvU=;
  b=ZMk/S1qeHSKcX+mWViGYXioMOKJRIU99fJAvsrzRXhCDmkiHrGn3Husb
   wr2oovuKtojdfIUHFaHz9cRLkR7vTtADlSkE5vrpqMxnI8BRHEF+denVu
   iC2R1ugHwFN3btFkwoi3UzJO5A4UncMLGTHrwOBvklW+/q1rqctejJ221
   9GLCee4BebUF93Rx7wLEOFKrhaxDJXb7xrTXNE8vah9cJCTSFjInJgqQX
   lZ6N0rboOe08sXIuRcpm6+Sz+5+2j7uLug2MjNYIymtpFLqSemMtcj3cq
   PGfwW9HaJlyQKtyC09i+uWuPbXbAxFVfVGAgfQCvDLvR7qZOUWHv6fZcj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="5698986"
X-IronPort-AV: E=Sophos;i="6.04,227,1695711600"; 
   d="scan'208";a="5698986"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2023 13:27:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="761258825"
X-IronPort-AV: E=Sophos;i="6.04,227,1695711600"; 
   d="scan'208";a="761258825"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Nov 2023 13:27:04 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r70B3-0004RK-3B;
	Sat, 25 Nov 2023 21:27:01 +0000
Date: Sun, 26 Nov 2023 05:26:14 +0800
From: kernel test robot <lkp@intel.com>
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kexec@lists.infradead.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-parisc@vger.kernel.org, akpm@linux-foundation.org,
	joe@perches.com, nathan@kernel.org, yujie.liu@intel.com,
	Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 4/7] kexec_file, arm64: print out debugging message if
 required
Message-ID: <202311260548.1HaxcDnE-lkp@intel.com>
References: <20231124033642.520686-5-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231124033642.520686-5-bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231125_132738_685623_EBCB33DD 
X-CRM114-Status: GOOD (  10.87  )
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

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on tip/x86/core powerpc/next powerpc/fixes linus/master v6.7-rc2 next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/kexec_file-add-kexec_file-flag-to-control-debug-printing/20231124-113942
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20231124033642.520686-5-bhe%40redhat.com
patch subject: [PATCH v2 4/7] kexec_file, arm64: print out debugging message if required
config: arm64-randconfig-001-20231126 (https://download.01.org/0day-ci/archive/20231126/202311260548.1HaxcDnE-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231126/202311260548.1HaxcDnE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311260548.1HaxcDnE-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/arm64/kernel/machine_kexec.c:35:2: error: implicit declaration of function 'kexec_dprintk' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           kexec_dprintk("%s:%d:\n", func, line);
           ^
   1 error generated.


vim +/kexec_dprintk +35 arch/arm64/kernel/machine_kexec.c

    27	
    28	/**
    29	 * kexec_image_info - For debugging output.
    30	 */
    31	#define kexec_image_info(_i) _kexec_image_info(__func__, __LINE__, _i)
    32	static void _kexec_image_info(const char *func, int line,
    33		const struct kimage *kimage)
    34	{
  > 35		kexec_dprintk("%s:%d:\n", func, line);
    36		kexec_dprintk("  kexec kimage info:\n");
    37		kexec_dprintk("    type:        %d\n", kimage->type);
    38		kexec_dprintk("    head:        %lx\n", kimage->head);
    39		kexec_dprintk("    kern_reloc: %pa\n", &kimage->arch.kern_reloc);
    40		kexec_dprintk("    el2_vectors: %pa\n", &kimage->arch.el2_vectors);
    41	}
    42	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
