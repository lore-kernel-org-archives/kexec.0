Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA62ECAC58E
	for <kexec@archiver.kernel.org>; Thu, 11 Sep 2025 13:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1bgzj1FibOhcu93jpOSuac8l4sB947S6RkPDa3rAbOQ=; b=MO7RfYHiigXQokQU6COZiYIyRw
	f939ZgMTHNsIXNhX8h74I9Dq9ocyfkMc+QL8M5/Q9NmTPrrhsds83XH0uJSqvHiSFmL3EXzxhO60U
	Dx2qzJx2CbcvKd1kTjSOZG88QrM2Wq7PGYD4jnbLDwTkXUHU3nsUJYCJd5RdzSlCgbPIk70TG0cNx
	Cz1fmW2qNCMO7CW4RR9sh1pwZPvq9X1hpNmcxc4HprcEGuZwpsPV92fa98sxhbq9gybkq1xIuxvch
	TpaXTB6ypJbSIRDKpU+EOkrtjZmpY9tHBG8ujomRE0vEq8JTja3o8SRwIzZDBFvV89Sjj5FtGV5g8
	pqCz+ekA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwhIF-00000003Ddw-3RjP;
	Thu, 11 Sep 2025 13:24:55 +0000
Received: from mgamail.intel.com ([198.175.65.14])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwhIC-00000003Dd2-3mLf
	for kexec@lists.infradead.org;
	Thu, 11 Sep 2025 13:24:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757597093; x=1789133093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+AsJA3fwN7ebjrzACnOVJAO4yIltEC73u1ZO5SGyLdo=;
  b=nglXQFAA8y1OWgfyUstOC5/7/xIry/AfWiGI3W6buLK2C/jM9q/n56Qw
   2oNjrut3miHGMQUt3yJVcZZpQR5BMr+MBFYatoczVofXnbE3TzJHDcetR
   52v0Zc3YYdqCmlqqPLefMPXU8wleX4U3iwDjrOVdGB/O85/4Tn+R6dOAo
   9sU9GcHzusT+IS1N6pn7BKDTnae6g6eK2d20ex7UkPK0b3JNglG6QKw+D
   2+rwDAqxg1befLN4O/rSgb/MWODiIVH7S/fYKQVztQijjy7zCQATfRFH9
   neBwwm5MzE2IYxDmAMoIuN9wP1NC4F7l+qzA2kcSim+S9UP9JPBpC4Xun
   Q==;
X-CSE-ConnectionGUID: pVC/cXuyRxSof3VznUdwCA==
X-CSE-MsgGUID: YZKTxH+1SEWT7fySRObMMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63753558"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63753558"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 06:24:51 -0700
X-CSE-ConnectionGUID: MR/LBW95QSWzZ6cAFa+EDg==
X-CSE-MsgGUID: qie/tJ+bRQy6g6/ytI3+2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="173763974"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 11 Sep 2025 06:24:47 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwhI3-0000Lu-13;
	Thu, 11 Sep 2025 13:24:43 +0000
Date: Thu, 11 Sep 2025 21:24:23 +0800
From: kernel test robot <lkp@intel.com>
To: Justinien Bouron <jbouron@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Petr Mladek <pmladek@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Gunnar Kudrjavets <gunnarku@amazon.com>
Subject: Re: [PATCH] kexec_core: Remove superfluous page offset handling in
 segment loading
Message-ID: <202509112118.1NElSKNk-lkp@intel.com>
References: <20250910163116.49148-1-jbouron@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910163116.49148-1-jbouron@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_062452_980634_C8AB2333 
X-CRM114-Status: GOOD (  12.96  )
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

Hi Justinien,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.17-rc5 next-20250911]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Justinien-Bouron/kexec_core-Remove-superfluous-page-offset-handling-in-segment-loading/20250911-003354
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250910163116.49148-1-jbouron%40amazon.com
patch subject: [PATCH] kexec_core: Remove superfluous page offset handling in segment loading
config: x86_64-buildonly-randconfig-004-20250911 (https://download.01.org/0day-ci/archive/20250911/202509112118.1NElSKNk-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250911/202509112118.1NElSKNk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509112118.1NElSKNk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/kexec_core.c:745:16: warning: variable 'maddr' set but not used [-Wunused-but-set-variable]
     745 |         unsigned long maddr;
         |                       ^
   1 warning generated.


vim +/maddr +745 kernel/kexec_core.c

2965faa5e03d1e Dave Young       2015-09-09  739  
07d24902977e47 Alexander Graf   2025-06-10  740  static int kimage_load_cma_segment(struct kimage *image, int idx)
07d24902977e47 Alexander Graf   2025-06-10  741  {
07d24902977e47 Alexander Graf   2025-06-10  742  	struct kexec_segment *segment = &image->segment[idx];
07d24902977e47 Alexander Graf   2025-06-10  743  	struct page *cma = image->segment_cma[idx];
07d24902977e47 Alexander Graf   2025-06-10  744  	char *ptr = page_address(cma);
07d24902977e47 Alexander Graf   2025-06-10 @745  	unsigned long maddr;
07d24902977e47 Alexander Graf   2025-06-10  746  	size_t ubytes, mbytes;
07d24902977e47 Alexander Graf   2025-06-10  747  	int result = 0;
07d24902977e47 Alexander Graf   2025-06-10  748  	unsigned char __user *buf = NULL;
07d24902977e47 Alexander Graf   2025-06-10  749  	unsigned char *kbuf = NULL;
07d24902977e47 Alexander Graf   2025-06-10  750  
07d24902977e47 Alexander Graf   2025-06-10  751  	if (image->file_mode)
07d24902977e47 Alexander Graf   2025-06-10  752  		kbuf = segment->kbuf;
07d24902977e47 Alexander Graf   2025-06-10  753  	else
07d24902977e47 Alexander Graf   2025-06-10  754  		buf = segment->buf;
07d24902977e47 Alexander Graf   2025-06-10  755  	ubytes = segment->bufsz;
07d24902977e47 Alexander Graf   2025-06-10  756  	mbytes = segment->memsz;
07d24902977e47 Alexander Graf   2025-06-10  757  	maddr = segment->mem;
07d24902977e47 Alexander Graf   2025-06-10  758  
07d24902977e47 Alexander Graf   2025-06-10  759  	/* Then copy from source buffer to the CMA one */
07d24902977e47 Alexander Graf   2025-06-10  760  	while (mbytes) {
07d24902977e47 Alexander Graf   2025-06-10  761  		size_t uchunk, mchunk;
07d24902977e47 Alexander Graf   2025-06-10  762  
b4cdefb6ef1453 Justinien Bouron 2025-09-10  763  		mchunk = min_t(size_t, mbytes, PAGE_SIZE);
07d24902977e47 Alexander Graf   2025-06-10  764  		uchunk = min(ubytes, mchunk);
07d24902977e47 Alexander Graf   2025-06-10  765  
07d24902977e47 Alexander Graf   2025-06-10  766  		if (uchunk) {
07d24902977e47 Alexander Graf   2025-06-10  767  			/* For file based kexec, source pages are in kernel memory */
07d24902977e47 Alexander Graf   2025-06-10  768  			if (image->file_mode)
07d24902977e47 Alexander Graf   2025-06-10  769  				memcpy(ptr, kbuf, uchunk);
07d24902977e47 Alexander Graf   2025-06-10  770  			else
07d24902977e47 Alexander Graf   2025-06-10  771  				result = copy_from_user(ptr, buf, uchunk);
07d24902977e47 Alexander Graf   2025-06-10  772  			ubytes -= uchunk;
07d24902977e47 Alexander Graf   2025-06-10  773  			if (image->file_mode)
07d24902977e47 Alexander Graf   2025-06-10  774  				kbuf += uchunk;
07d24902977e47 Alexander Graf   2025-06-10  775  			else
07d24902977e47 Alexander Graf   2025-06-10  776  				buf += uchunk;
07d24902977e47 Alexander Graf   2025-06-10  777  		}
07d24902977e47 Alexander Graf   2025-06-10  778  
07d24902977e47 Alexander Graf   2025-06-10  779  		if (result) {
07d24902977e47 Alexander Graf   2025-06-10  780  			result = -EFAULT;
07d24902977e47 Alexander Graf   2025-06-10  781  			goto out;
07d24902977e47 Alexander Graf   2025-06-10  782  		}
07d24902977e47 Alexander Graf   2025-06-10  783  
07d24902977e47 Alexander Graf   2025-06-10  784  		ptr    += mchunk;
07d24902977e47 Alexander Graf   2025-06-10  785  		maddr  += mchunk;
07d24902977e47 Alexander Graf   2025-06-10  786  		mbytes -= mchunk;
07d24902977e47 Alexander Graf   2025-06-10  787  
07d24902977e47 Alexander Graf   2025-06-10  788  		cond_resched();
07d24902977e47 Alexander Graf   2025-06-10  789  	}
07d24902977e47 Alexander Graf   2025-06-10  790  
07d24902977e47 Alexander Graf   2025-06-10  791  	/* Clear any remainder */
07d24902977e47 Alexander Graf   2025-06-10  792  	memset(ptr, 0, mbytes);
07d24902977e47 Alexander Graf   2025-06-10  793  
07d24902977e47 Alexander Graf   2025-06-10  794  out:
07d24902977e47 Alexander Graf   2025-06-10  795  	return result;
07d24902977e47 Alexander Graf   2025-06-10  796  }
07d24902977e47 Alexander Graf   2025-06-10  797  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

