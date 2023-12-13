Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C84C4167D
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 11:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CRgqeE2nfg/qXBlalLIKhzPAF97sV63vCGokNOXOrMk=; b=zgqBUSeK634eVi
	pN60fNe2yq+leuC8VGdjIvlJOSchOoSgQnBLwzkdC3dJwI5qfCm90x143Kr083gIWyDuXh97x3lnC
	1bg5tUC4p3PeZBQbJOLNe4AzGsPInMrE2U/8Ah5+JZ0eKcya4GLahmSEGVEYOquadg2eNElO2sbFo
	E26KFiV55PR1O327AQZrxaOYymvHDbD2T27Pk9mcE9Ew9B9P0efgIdENDgXcuZMF+NwAqwf3KS8xJ
	APEhqAhHuY1KBJggQCInXjA8+ULviolNAneL/GRb/zqm0itvo9p9ie3oHFygAyt8SDsfhzCDGKv6a
	FIoIPEuuN4vIMQQARlvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDNKh-00ERft-1g;
	Wed, 13 Dec 2023 11:23:19 +0000
Received: from mgamail.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDNKa-00ERc3-0J;
	Wed, 13 Dec 2023 11:23:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702466592; x=1734002592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0vG05tOcWt8hNkb/0MfvDKdSwDkxJN+d9TF+RoFO0kI=;
  b=MiZtIqR+miyYS85jcAcGjyASGq0focOBre35ccJD2LPOLfl/u/+SIQ0E
   ZjfbHZpjTlf8fzcRp1DM22MjyPYJj0VT0Lyq+nmZTQGT/Ggo1yeEJbtnt
   Se0wizBdrgVElN6Ig9H994trsie3L62nvcUSixFW6ZMA00Oe3MFv/c7kW
   wvN5T92fsinq2428+Z2mTKzhx44Y3ttwKjil4K5SVJtB8YXFzFmCD2ax6
   7XoYzDZJBWS74aJk0bclFarkba7E1KFSpNuEogEl45uH5C5p7VSNIPkpP
   asTRokKNJpvv52LDU4vpVQDjAHoWf//MJ6hH//ASoLctpXPC4ZLaKj/ql
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="398793308"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="398793308"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 03:23:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="864592315"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="864592315"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Dec 2023 03:23:03 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDNKP-000KTd-1U;
	Wed, 13 Dec 2023 11:23:01 +0000
Date: Wed, 13 Dec 2023 19:22:32 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	arnd@arndb.de, pbonzini@redhat.com, madvenka@linux.microsoft.com,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 08/15] tracing: Introduce names for ring buffers
Message-ID: <202312131922.5dJORQu4-lkp@intel.com>
References: <20231213000452.88295-9-graf@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231213000452.88295-9-graf@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_032312_199144_46E42289 
X-CRM114-Status: GOOD (  14.54  )
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

Hi Alexander,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on arm64/for-next/core akpm-mm/mm-everything linus/master v6.7-rc5 next-20231213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Graf/mm-memblock-Add-support-for-scratch-memory/20231213-080941
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20231213000452.88295-9-graf%40amazon.com
patch subject: [PATCH 08/15] tracing: Introduce names for ring buffers
config: i386-buildonly-randconfig-003-20231213 (https://download.01.org/0day-ci/archive/20231213/202312131922.5dJORQu4-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231213/202312131922.5dJORQu4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312131922.5dJORQu4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/trace/ring_buffer_benchmark.c:435:53: error: too few arguments provided to function-like macro invocation
           buffer = ring_buffer_alloc(1000000, RB_FL_OVERWRITE);
                                                              ^
   include/linux/ring_buffer.h:96:9: note: macro 'ring_buffer_alloc' defined here
   #define ring_buffer_alloc(name, size, flags)                    \
           ^
>> kernel/trace/ring_buffer_benchmark.c:435:11: error: use of undeclared identifier 'ring_buffer_alloc'; did you mean '__ring_buffer_alloc'?
           buffer = ring_buffer_alloc(1000000, RB_FL_OVERWRITE);
                    ^~~~~~~~~~~~~~~~~
                    __ring_buffer_alloc
   include/linux/ring_buffer.h:88:1: note: '__ring_buffer_alloc' declared here
   __ring_buffer_alloc(const char *name, unsigned long size, unsigned flags,
   ^
   2 errors generated.
--
>> kernel/trace/ring_buffer.c:6096:65: error: too few arguments provided to function-like macro invocation
           buffer = ring_buffer_alloc(RB_TEST_BUFFER_SIZE, RB_FL_OVERWRITE);
                                                                          ^
   include/linux/ring_buffer.h:96:9: note: macro 'ring_buffer_alloc' defined here
   #define ring_buffer_alloc(name, size, flags)                    \
           ^
>> kernel/trace/ring_buffer.c:6096:11: error: use of undeclared identifier 'ring_buffer_alloc'; did you mean '__ring_buffer_alloc'?
           buffer = ring_buffer_alloc(RB_TEST_BUFFER_SIZE, RB_FL_OVERWRITE);
                    ^~~~~~~~~~~~~~~~~
                    __ring_buffer_alloc
   kernel/trace/ring_buffer.c:1873:19: note: '__ring_buffer_alloc' declared here
   EXPORT_SYMBOL_GPL(__ring_buffer_alloc);
                     ^
   2 errors generated.


vim +435 kernel/trace/ring_buffer_benchmark.c

5092dbc96f3acd Steven Rostedt 2009-05-05  429  
5092dbc96f3acd Steven Rostedt 2009-05-05  430  static int __init ring_buffer_benchmark_init(void)
5092dbc96f3acd Steven Rostedt 2009-05-05  431  {
5092dbc96f3acd Steven Rostedt 2009-05-05  432  	int ret;
5092dbc96f3acd Steven Rostedt 2009-05-05  433  
5092dbc96f3acd Steven Rostedt 2009-05-05  434  	/* make a one meg buffer in overwite mode */
5092dbc96f3acd Steven Rostedt 2009-05-05 @435  	buffer = ring_buffer_alloc(1000000, RB_FL_OVERWRITE);
5092dbc96f3acd Steven Rostedt 2009-05-05  436  	if (!buffer)
5092dbc96f3acd Steven Rostedt 2009-05-05  437  		return -ENOMEM;
5092dbc96f3acd Steven Rostedt 2009-05-05  438  
5092dbc96f3acd Steven Rostedt 2009-05-05  439  	if (!disable_reader) {
5092dbc96f3acd Steven Rostedt 2009-05-05  440  		consumer = kthread_create(ring_buffer_consumer_thread,
5092dbc96f3acd Steven Rostedt 2009-05-05  441  					  NULL, "rb_consumer");
5092dbc96f3acd Steven Rostedt 2009-05-05  442  		ret = PTR_ERR(consumer);
5092dbc96f3acd Steven Rostedt 2009-05-05  443  		if (IS_ERR(consumer))
5092dbc96f3acd Steven Rostedt 2009-05-05  444  			goto out_fail;
5092dbc96f3acd Steven Rostedt 2009-05-05  445  	}
5092dbc96f3acd Steven Rostedt 2009-05-05  446  
5092dbc96f3acd Steven Rostedt 2009-05-05  447  	producer = kthread_run(ring_buffer_producer_thread,
5092dbc96f3acd Steven Rostedt 2009-05-05  448  			       NULL, "rb_producer");
5092dbc96f3acd Steven Rostedt 2009-05-05  449  	ret = PTR_ERR(producer);
5092dbc96f3acd Steven Rostedt 2009-05-05  450  
5092dbc96f3acd Steven Rostedt 2009-05-05  451  	if (IS_ERR(producer))
5092dbc96f3acd Steven Rostedt 2009-05-05  452  		goto out_kill;
5092dbc96f3acd Steven Rostedt 2009-05-05  453  
98e4833ba3c314 Ingo Molnar    2009-11-23  454  	/*
98e4833ba3c314 Ingo Molnar    2009-11-23  455  	 * Run them as low-prio background tasks by default:
98e4833ba3c314 Ingo Molnar    2009-11-23  456  	 */
7ac07434048001 Steven Rostedt 2009-11-25  457  	if (!disable_reader) {
4fd5750af02ab7 Peter Zijlstra 2020-07-20  458  		if (consumer_fifo >= 2)
4fd5750af02ab7 Peter Zijlstra 2020-07-20  459  			sched_set_fifo(consumer);
4fd5750af02ab7 Peter Zijlstra 2020-07-20  460  		else if (consumer_fifo == 1)
4fd5750af02ab7 Peter Zijlstra 2020-07-20  461  			sched_set_fifo_low(consumer);
4fd5750af02ab7 Peter Zijlstra 2020-07-20  462  		else
7ac07434048001 Steven Rostedt 2009-11-25  463  			set_user_nice(consumer, consumer_nice);
7ac07434048001 Steven Rostedt 2009-11-25  464  	}
7ac07434048001 Steven Rostedt 2009-11-25  465  
4fd5750af02ab7 Peter Zijlstra 2020-07-20  466  	if (producer_fifo >= 2)
4fd5750af02ab7 Peter Zijlstra 2020-07-20  467  		sched_set_fifo(producer);
4fd5750af02ab7 Peter Zijlstra 2020-07-20  468  	else if (producer_fifo == 1)
4fd5750af02ab7 Peter Zijlstra 2020-07-20  469  		sched_set_fifo_low(producer);
4fd5750af02ab7 Peter Zijlstra 2020-07-20  470  	else
7ac07434048001 Steven Rostedt 2009-11-25  471  		set_user_nice(producer, producer_nice);
98e4833ba3c314 Ingo Molnar    2009-11-23  472  
5092dbc96f3acd Steven Rostedt 2009-05-05  473  	return 0;
5092dbc96f3acd Steven Rostedt 2009-05-05  474  
5092dbc96f3acd Steven Rostedt 2009-05-05  475   out_kill:
5092dbc96f3acd Steven Rostedt 2009-05-05  476  	if (consumer)
5092dbc96f3acd Steven Rostedt 2009-05-05  477  		kthread_stop(consumer);
5092dbc96f3acd Steven Rostedt 2009-05-05  478  
5092dbc96f3acd Steven Rostedt 2009-05-05  479   out_fail:
5092dbc96f3acd Steven Rostedt 2009-05-05  480  	ring_buffer_free(buffer);
5092dbc96f3acd Steven Rostedt 2009-05-05  481  	return ret;
5092dbc96f3acd Steven Rostedt 2009-05-05  482  }
5092dbc96f3acd Steven Rostedt 2009-05-05  483  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
