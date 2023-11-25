Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96207C61D9D
	for <kexec@archiver.kernel.org>; Sat, 25 Nov 2023 07:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S0j2gAczGNq1XsvdoDBouJp7wGVC0Z6BMc+JD9LudwM=; b=ffsSBIDgQYv27s
	7qZV+7gGpJTDPMfCaZ4xdcdPqBoISLmst7/scYmikiMSxPoydV1JQRQWBxPir+icgycGz5cAlXlB2
	9nOAItPfjeR7fwxqCkilc/GekmMPk6af+1kmcHDwTiEXsASvdtj+eQ/ftzPDblV8N3jZNTtGxNSOQ
	QeHZnLl8vEkZJrLepy5W6N+xX9nN5vAYLxoe64kn8D2GyxJP76BSVQ4JB3byj+D/lZu0eRSkV/mPB
	k9vb/0do2Yas/hOtfZ4W92nMtrBydWJpy3DLt2RkvtW3KA1koWEpLx9BYjcbrqvyLjfAj/OcnLg/h
	J6+9OptvV0O85kw6EeYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6n2B-008lgN-0Z;
	Sat, 25 Nov 2023 07:24:59 +0000
Received: from mgamail.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6n28-008len-2Y
	for kexec@lists.infradead.org;
	Sat, 25 Nov 2023 07:24:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700897096; x=1732433096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EKXobDNAisJFES+aua3AQTfSzZ0E5+bKj+a4rhFGrPo=;
  b=gelCVGKj3T2knbeMx6ZdUKRTcuzB1M62fPlboFdqRr38rLSXhOLZjTpI
   MeTLHD3nYPNxoDG7LEHBKiyQiW2BzIFRCBH3TfTt/NTnwQqYvMarmLYku
   ry6bwtTlMWdElgbvVSFCyokB5Ip3idG562Pvt+3sTEaJwCUKXiSGF3n2J
   6svrsMyQT4y1YYKdOPf5DURGbnbmke/yLVMbr/8YcMEUgec2SMSATziDa
   YEc0zK2rxG2ULo3sRzG1UDqXEH5Y5ERacTbPLWJR2IIBNaZmpRFqPcLda
   UURBUkPQB4a1osVpTFJHj/bv8TIFjQ/YJn4FkK7lXN81K3aqbLkvizdhg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="372655170"
X-IronPort-AV: E=Sophos;i="6.04,225,1695711600"; 
   d="scan'208";a="372655170"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 23:24:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="1015075370"
X-IronPort-AV: E=Sophos;i="6.04,225,1695711600"; 
   d="scan'208";a="1015075370"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 24 Nov 2023 23:24:31 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r6n1h-0003jB-2l;
	Sat, 25 Nov 2023 07:24:29 +0000
Date: Sat, 25 Nov 2023 15:24:22 +0800
From: kernel test robot <lkp@intel.com>
To: Jiri Bohac <jbohac@suse.cz>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	mhocko@suse.cz
Subject: Re: [PATCH 1/4] kdump: add crashkernel cma suffix
Message-ID: <202311251303.71yrbT6l-lkp@intel.com>
References: <ZWEAPXiCCgAf1WrY@dwarf.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZWEAPXiCCgAf1WrY@dwarf.suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231124_232456_867384_124803EB 
X-CRM114-Status: GOOD (  14.36  )
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

Hi Jiri,

kernel test robot noticed the following build warnings:

[auto build test WARNING on powerpc/next]
[also build test WARNING on powerpc/fixes s390/features linus/master v6.7-rc2 next-20231124]
[cannot apply to tip/x86/core arm64/for-next/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiri-Bohac/kdump-implement-reserve_crashkernel_cma/20231125-082724
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/ZWEAPXiCCgAf1WrY%40dwarf.suse.cz
patch subject: [PATCH 1/4] kdump: add crashkernel cma suffix
config: alpha-randconfig-r081-20231125 (https://download.01.org/0day-ci/archive/20231125/202311251303.71yrbT6l-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231125/202311251303.71yrbT6l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311251303.71yrbT6l-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/crash_core.c: In function 'parse_crashkernel':
>> kernel/crash_core.c:319:28: warning: unused variable 'cma_base' [-Wunused-variable]
     319 |         unsigned long long cma_base;
         |                            ^~~~~~~~


vim +/cma_base +319 kernel/crash_core.c

   302	
   303	/*
   304	 * That function is the entry point for command line parsing and should be
   305	 * called from the arch-specific code.
   306	 *
   307	 * If crashkernel=,high|low is supported on architecture, non-NULL values
   308	 * should be passed to parameters 'low_size' and 'high'.
   309	 */
   310	int __init parse_crashkernel(char *cmdline,
   311				     unsigned long long system_ram,
   312				     unsigned long long *crash_size,
   313				     unsigned long long *crash_base,
   314				     unsigned long long *low_size,
   315				     unsigned long long *cma_size,
   316				     bool *high)
   317	{
   318		int ret;
 > 319		unsigned long long cma_base;
   320	
   321		/* crashkernel=X[@offset] */
   322		ret = __parse_crashkernel(cmdline, system_ram, crash_size,
   323					crash_base, NULL);
   324	#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
   325		/*
   326		 * If non-NULL 'high' passed in and no normal crashkernel
   327		 * setting detected, try parsing crashkernel=,high|low.
   328		 */
   329		if (high && ret == -ENOENT) {
   330			ret = __parse_crashkernel(cmdline, 0, crash_size,
   331					crash_base, suffix_tbl[SUFFIX_HIGH]);
   332			if (ret || !*crash_size)
   333				return -EINVAL;
   334	
   335			/*
   336			 * crashkernel=Y,low can be specified or not, but invalid value
   337			 * is not allowed.
   338			 */
   339			ret = __parse_crashkernel(cmdline, 0, low_size,
   340					crash_base, suffix_tbl[SUFFIX_LOW]);
   341			if (ret == -ENOENT) {
   342				*low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
   343				ret = 0;
   344			} else if (ret) {
   345				return ret;
   346			}
   347	
   348			*high = true;
   349		}
   350	
   351		/*
   352		* optional CMA reservation
   353		* cma_base is ignored
   354		*/
   355		if (cma_size)
   356			__parse_crashkernel(cmdline, 0, cma_size,
   357				&cma_base, suffix_tbl[SUFFIX_CMA]);
   358	#endif
   359		if (!*crash_size)
   360			ret = -EINVAL;
   361	
   362		return ret;
   363	}
   364	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
