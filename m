Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F36CCF9F0
	for <kexec@archiver.kernel.org>; Thu, 30 Oct 2025 19:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KCZg9XdIhT9FlIlPKU3pvfpHXPwmXF8UsO34dNDtTuU=; b=rAegw7smDZxZsF42vs3C++ktLt
	J05qCwJEoVu4h6rkSeghHDoOf+SQZjMze/gDV0Ev60sLKn+FtJ9QBLHJ4EcYJjvq1tC0JvTocRP2J
	lx5XPENwFc3WEnIPlxi9wt7TXa7fBOsOT2SF/ikaX+7PrCmOmTtiB1H764kRkChcmzmGmkzCLd06y
	bzGHBPSJ0PgMsE20TBec7pL1Bcwn3pKolcMTUuxYS5E1bAW0N7/lhmZRuMbA9y7NPiylFozqSRNfh
	JW04hYl599DzsYHRSSCQngESFdLOSgUkHpQBujZbdkBUQoy+pOpuMUAwkuwH1NEf2bz1C1vi/9kjg
	3IkK7QgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEYCy-00000004fIh-21Oh;
	Thu, 30 Oct 2025 19:21:16 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEYCw-00000004fGF-0nfV
	for kexec@lists.infradead.org;
	Thu, 30 Oct 2025 19:21:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761852074; x=1793388074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2hocMCYlkJ7vaHYBTlrKNpsTpQLXpL7Xf2mz6194Rbw=;
  b=dXGhw+p4pV7XHq/m9V5lCaZvYP+GfSXwL+iAp1c3AbFnYOHxw5B1ayhN
   y9L7REte4KUWhttXYjnqbFsEczcSIGyCrDse7f8l/DUJeSqWntw+j9sVx
   C9KF7c9ooalu2j0GyBa2vl2/vKVXiAAxu1aknA8B85Fbu2vlGMVoVwcGq
   Z98/PkJbq8AZ4H37GJWZ2FZBL6yDiOHjzkjA2EI2CoGHEKq/rjyERLeaS
   0viAqDHjDO8YhTzg4lBOQaog7WE1GJVPCorflha+0TxiOkRUkHTyeW/oy
   KjpkwT/IK23htATUq+ASIlOnceIacuPYG+0ZMFFIp4W1zmYqHIPiNZfBj
   w==;
X-CSE-ConnectionGUID: nAVBcm3dTXqgk2Ug+tRIkQ==
X-CSE-MsgGUID: 8nSzPtrnQS2qwC8wfk6GxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="51578458"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="51578458"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 12:21:13 -0700
X-CSE-ConnectionGUID: t8XJXzNkRM+8zkg6Ha6a5Q==
X-CSE-MsgGUID: 9XWg6FwWRmiFZOFHWR4AtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="191191981"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 30 Oct 2025 12:21:12 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEYCr-000MRI-2r;
	Thu, 30 Oct 2025 19:21:09 +0000
Date: Fri, 31 Oct 2025 03:20:32 +0800
From: kernel test robot <lkp@intel.com>
To: Qiang Ma <maqianga@uniontech.com>, akpm@linux-foundation.org,
	bhe@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: Re: [PATCH] kexec: print out debugging message if required for
 kexec_load
Message-ID: <202510310332.6XrLe70K-lkp@intel.com>
References: <20251030073316.529106-1-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030073316.529106-1-maqianga@uniontech.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251030_122114_278832_8F3D6A15 
X-CRM114-Status: GOOD (  13.36  )
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

Hi Qiang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.18-rc3 next-20251030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qiang-Ma/kexec-print-out-debugging-message-if-required-for-kexec_load/20251030-153807
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251030073316.529106-1-maqianga%40uniontech.com
patch subject: [PATCH] kexec: print out debugging message if required for kexec_load
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20251031/202510310332.6XrLe70K-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251031/202510310332.6XrLe70K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510310332.6XrLe70K-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/kexec.c:160:10: warning: format specifies type 'int' but the argument has type 'unsigned long' [-Wformat]
     159 |                 kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
         |                                        ~~
         |                                        %lu
     160 |                               i, ksegment->buf, ksegment->bufsz, ksegment->mem,
         |                               ^
   include/linux/kexec.h:531:55: note: expanded from macro 'kexec_dprintk'
     531 |         do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
         |                                                ~~~    ^~~
   include/linux/printk.h:585:34: note: expanded from macro 'pr_info'
     585 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                                 ~~~     ^~~~~~~~~~~
   include/linux/printk.h:512:60: note: expanded from macro 'printk'
     512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:484:19: note: expanded from macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
   1 warning generated.


vim +160 kernel/kexec.c

   141	
   142		ret = machine_kexec_prepare(image);
   143		if (ret)
   144			goto out;
   145	
   146		/*
   147		 * Some architecture(like S390) may touch the crash memory before
   148		 * machine_kexec_prepare(), we must copy vmcoreinfo data after it.
   149		 */
   150		ret = kimage_crash_copy_vmcoreinfo(image);
   151		if (ret)
   152			goto out;
   153	
   154		kexec_dprintk("nr_segments = %lu\n", image->nr_segments);
   155		for (i = 0; i < nr_segments; i++) {
   156			struct kexec_segment *ksegment;
   157	
   158			ksegment = &image->segment[i];
   159			kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
 > 160				      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
   161				      ksegment->memsz);
   162	
   163			ret = kimage_load_segment(image, i);
   164			if (ret)
   165				goto out;
   166		}
   167	
   168		kimage_terminate(image);
   169	
   170		ret = machine_kexec_post_load(image);
   171		if (ret)
   172			goto out;
   173	
   174		kexec_dprintk("kexec_file_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
   175			      image->type, image->start, image->head, flags);
   176	
   177		/* Install the new kernel and uninstall the old */
   178		image = xchg(dest_image, image);
   179	
   180	out:
   181	#ifdef CONFIG_CRASH_DUMP
   182		if ((flags & KEXEC_ON_CRASH) && kexec_crash_image)
   183			arch_kexec_protect_crashkres();
   184	#endif
   185	
   186		kimage_free(image);
   187	out_unlock:
   188		kexec_unlock();
   189		return ret;
   190	}
   191	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

