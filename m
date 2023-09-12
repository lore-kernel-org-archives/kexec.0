Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98F9EE3F0C
	for <kexec@archiver.kernel.org>; Tue, 12 Sep 2023 18:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xQYUB6OPcz0WjbAlTmUp9Mu9TT9u8heaj3pL05h7gak=; b=WNTvY7ypnITxoP
	apSZ3xKaoYOyGPYVkf4csFtVH/YCmEB2/uScdm5GtPEeDCQJYQByBpqi3cfcwUB7jvXfO3dtpwQYL
	5tJi66wQktDg/K0ZvMNVQPb75vRjFkXFSXR4JhYIaXxdWapp3pPZRamiG5Mzkbi60zzTpGA2P4LhM
	RujFOHUtKg9+pWcS7rWQkjhThQq7iYs2X++Ck5FP4J4IxsfBojAiwCON1/p6pwOUy85QBwfsRlMrP
	ybrrZ5PuxYMK9MZ5l3aTbQw/TnbpVZMBOJpgPGNRdpRtNZmlMcI1X87sOrEclmM6Q+xcaYavKFS8W
	+pdQKp3RrG+9TW7KOKDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg8Tu-0040o2-02;
	Tue, 12 Sep 2023 18:51:26 +0000
Received: from mgamail.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg8Tq-0040nd-33
	for kexec@lists.infradead.org;
	Tue, 12 Sep 2023 18:51:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694544682; x=1726080682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m4ArRUJq81IoQwOUurgDTOz0S2e8/xwn1JxXLNRgGXc=;
  b=hPcpbJVc4c+v8/Q0KjpPr/Yc4RTZinlWWJ0Lh13abAeD8TdG/RalZ4JY
   CFvQgZCdlC8ikI7arwmaz92sokD5o1C7yBbPQKjhgXXAKECwEwuryem9s
   HVsyzPq9Zdsgk2Dv51pwcvGaeVfZbW+O47clQu/qzgNqaSbX4TdLlJl6t
   DHS+XI+WPVOIN4M1a4eAXCwJaCItWNH7xuO066ePsDb5t0TcNivw9M4e+
   83urUl7qgZ3JGzFemESnIKtuC8/hCTKILAafJRy5Lhi2KYOE/4o3VcbYH
   VQsjkDzT48mlKgypwGznJ1k7kcQ6gWHHyEPZ2lCChFdOPbjiw5AAJdm/O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="382272923"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="382272923"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 11:51:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="887041629"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="887041629"
Received: from lkp-server02.sh.intel.com (HELO 47e905db7d2b) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 12 Sep 2023 11:50:45 -0700
Received: from kbuild by 47e905db7d2b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qg8Tf-00008v-17;
	Tue, 12 Sep 2023 18:51:11 +0000
Date: Wed, 13 Sep 2023 02:50:29 +0800
From: kernel test robot <lkp@intel.com>
To: Pingfan Liu <piliu@redhat.com>, linuxppc-dev@lists.ozlabs.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Baoquan He <bhe@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	kexec@lists.infradead.org, Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Ming Lei <ming.lei@redhat.com>, Wen Xiong <wenxiong@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCHv6 1/3] powerpc/setup: Loosen the mapping between cpu
 logical id and its seq in dt
Message-ID: <202309130232.N2REwHBv-lkp@intel.com>
References: <20230911131855.40738-2-piliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230911131855.40738-2-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_115123_078760_3EAB35CB 
X-CRM114-Status: GOOD (  11.90  )
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

Hi Pingfan,

kernel test robot noticed the following build errors:

[auto build test ERROR on powerpc/fixes]
[also build test ERROR on linus/master v6.6-rc1 next-20230912]
[cannot apply to powerpc/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pingfan-Liu/powerpc-setup-Loosen-the-mapping-between-cpu-logical-id-and-its-seq-in-dt/20230911-213042
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git fixes
patch link:    https://lore.kernel.org/r/20230911131855.40738-2-piliu%40redhat.com
patch subject: [PATCHv6 1/3] powerpc/setup: Loosen the mapping between cpu logical id and its seq in dt
config: powerpc-randconfig-r032-20230912 (https://download.01.org/0day-ci/archive/20230913/202309130232.N2REwHBv-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309130232.N2REwHBv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309130232.N2REwHBv-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: boot_cpu_hwid
   >>> referenced by setup-common.c:0 (arch/powerpc/kernel/setup-common.c:0)
   >>>               arch/powerpc/kernel/setup-common.o:(smp_setup_cpu_maps) in archive vmlinux.a
   >>> referenced by setup-common.c:0 (arch/powerpc/kernel/setup-common.c:0)
   >>>               arch/powerpc/kernel/setup-common.o:(smp_setup_cpu_maps) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
