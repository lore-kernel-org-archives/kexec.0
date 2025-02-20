Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9DDC021B0
	for <kexec@archiver.kernel.org>; Thu, 20 Feb 2025 00:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hz+bDR58Mw0kpihNuBZkR2f/j8rc3VxjOC1S2g28+Gg=; b=qUOV9rxRQ4BSMF+SY/ACZTiiQn
	Pyqsz99Prxsql1OhpzVA5wqfKmbvK5Y8E+Y55fM8fQqGU+d3QPV3MjycsMWSIy1/x1jXZd+WL/Pmx
	7iWf8s+zb1f458431hhRim0Q5NrB02zgKuvrK2UqblahdMqiZyuBR66T5qR+1V7jL4xzhVd2zJ+HE
	dr+wWnuypVla2okyUASM+7ZKJTaKXaSb/arKIsg69TPpg0T1loGAHa/+3DSrUW2GG7zrtKsA3fZBa
	TblgETJJ1ZjfmU+eBmLJ1sQGbEeVFVx5TKUVY2zhxxaNowoKmhp2YlF83ObIYze3YhzTYpdIxhcI2
	jCyrRvdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkupy-0000000FzN1-0u01;
	Thu, 20 Feb 2025 00:54:46 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkupu-0000000FzLa-2wm5
	for kexec@lists.infradead.org;
	Thu, 20 Feb 2025 00:54:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740012883; x=1771548883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hwUtCzqyh6aH1mIHsXsfvOdcnu0WliYUJzQAHSkkG70=;
  b=IK/lSSctVuwyLlFVZFn7VODGu2qRbF5h1eW6EyPwv49WECZpq7OHfe5m
   Ra2a8bzECFuo0ZVAk+Q3+OkDXnP4vYCFsBAbLN18HqMz8X+feGvYCsjBG
   30+YD1E5Sn62AIUAuY/1e7/sonoSxeU/ImR7gayJWs3kz+fS+7/8eLnyJ
   BFcIUvAVRBUWbU+7GLfrvChIZGlT4olafBYrshAI1W+NNe6wRzQYnM5My
   xOINrnDGw25uewPZ1oPeRl0BjU6SZuArhx5nZ0xKQVwwjl28fc+2ngJ9p
   TjLDf9ORjVTCbexWjDzJ2KfqWi4fjCJkNflg76F/1QWMxyYJjy8CIJqWq
   Q==;
X-CSE-ConnectionGUID: liZ+cv8cSlyLXRZrAkIelw==
X-CSE-MsgGUID: 4U1LUprHTs21w0ikusvXcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52209155"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52209155"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 16:54:39 -0800
X-CSE-ConnectionGUID: qeMsjbubQyOQIon3FZs7uQ==
X-CSE-MsgGUID: 4Mqc+Lu2SYmP5XegMdo/+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115785521"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 19 Feb 2025 16:54:34 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkupg-0003hv-13;
	Thu, 20 Feb 2025 00:54:29 +0000
Date: Thu, 20 Feb 2025 08:53:48 +0800
From: kernel test robot <lkp@intel.com>
To: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
	stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com, eric.snowberg@oracle.com,
	ebiederm@xmission.com, paul@paul-moore.com, code@tyhicks.com,
	bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, madvenka@linux.microsoft.com,
	nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
	bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com
Subject: Re: [PATCH v8 2/7] kexec: define functions to map and unmap segments
Message-ID: <202502200848.MJEuphR1-lkp@intel.com>
References: <20250218225502.747963-3-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218225502.747963-3-chenste@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250219_165442_784115_4AD74231 
X-CRM114-Status: GOOD (  13.10  )
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

Hi steven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.14-rc3 next-20250219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/steven-chen/ima-define-and-call-ima_alloc_kexec_file_buf/20250219-065931
base:   linus/master
patch link:    https://lore.kernel.org/r/20250218225502.747963-3-chenste%40linux.microsoft.com
patch subject: [PATCH v8 2/7] kexec: define functions to map and unmap segments
config: x86_64-buildonly-randconfig-004-20250220 (https://download.01.org/0day-ci/archive/20250220/202502200848.MJEuphR1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250220/202502200848.MJEuphR1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502200848.MJEuphR1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/crash_dump.h:5,
                    from mm/mm_init.c:30:
>> include/linux/kexec.h:479:47: warning: 'struct kimage' declared inside parameter list will not be visible outside of this definition or declaration
     479 | static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
         |                                               ^~~~~~


vim +479 include/linux/kexec.h

   466	
   467	#define kexec_dprintk(fmt, arg...) \
   468	        do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
   469	
   470	extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
   471	extern void kimage_unmap_segment(void *buffer);
   472	#else /* !CONFIG_KEXEC_CORE */
   473	struct pt_regs;
   474	struct task_struct;
   475	static inline void __crash_kexec(struct pt_regs *regs) { }
   476	static inline void crash_kexec(struct pt_regs *regs) { }
   477	static inline int kexec_should_crash(struct task_struct *p) { return 0; }
   478	static inline int kexec_crash_loaded(void) { return 0; }
 > 479	static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
   480	{ return NULL; }
   481	static inline void kimage_unmap_segment(void *buffer) { }
   482	#define kexec_in_progress false
   483	#endif /* CONFIG_KEXEC_CORE */
   484	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

