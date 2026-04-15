Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEBCF9D0FD
	for <kexec@archiver.kernel.org>; Wed, 15 Apr 2026 00:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pEDguHnuRGv9AHdE8EEWVJP9Dcq2OUA6BfBG51qwd5U=; b=izr+uFCtFfZp/Ka+4DHIcbXwfh
	D/X884+aSte8DsVDVK5CyDIVECF/Fuv54B04F2dkzyUA6KXiMdiaLV1Km3jBwRUM2IU1sfw9ptffp
	6Z3Zcu27nIGYvf5IOruMs+MHly07APtG6YrNr+1KtmmsdK3eAMmbEy7xfZlZy4TJtBGjMjiTrW5Qx
	GlG+KYmdiuPRCNuf6MI7gthW+7FKBJ6Q5GQIb7cEIYEX2dvf2grBWWRWA9ryfrQDEjFMRqrsP4d4Q
	aoDENaFGdZLBLvS/UtCCt28DnNd1KarcSjA8p71kpdySUV8czp6943uyUbsElybEAx0FEnvjA4hEw
	iF24QsMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCo7N-00000000NXs-0FdR;
	Wed, 15 Apr 2026 00:28:33 +0000
Received: from mgamail.intel.com ([198.175.65.15])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCo7J-00000000NWu-2Pzk
	for kexec@lists.infradead.org;
	Wed, 15 Apr 2026 00:28:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776212909; x=1807748909;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6qHIjl1O8jAt7kVac/CbZAb3DjdrN8WLJAUZQIMMWFY=;
  b=BYXY1q5NJ5IQSFWtQ1NlOHTpP2SHVHmNVgELP7W/WNy79rgBNwqas12b
   OPZYY+d8QRykQzbsLCGljrRuptklqPw6ePQ6XeCe4F9b8mFfLfPWkn0pn
   t+kKpj7yyT4DQlcYWuGo5F+IOxbFYcH56zvd76hiaucZjhbyGieD1307E
   fCa7GWij9IHMvmXwrXZa88Lo5Mfl8mq9ztbRUddqAsC53ChXisQdTzlOW
   D3tMb54WjWX3ONxtfHVEOl8tk8ydc4CT9ZVXjHDH3KM3oTe+RutVsoAue
   OuYbdsFL0CJ3qbxi8BZxxi1DGcdKEJFxkOmaWUcsAgS8G8qvJaXrhAJel
   g==;
X-CSE-ConnectionGUID: 7vIvM9FyQwKP/khMTf3bkg==
X-CSE-MsgGUID: qc43iyAfQVa6TCXLDxZ/rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="80779744"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="80779744"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 17:28:27 -0700
X-CSE-ConnectionGUID: pv1YhFHyTPi2jlKw00PuVA==
X-CSE-MsgGUID: vp30E1BLR7KBAu3RJOAVWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="230103404"
Received: from lkp-server01.sh.intel.com (HELO 7b0b59b3a0d4) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 14 Apr 2026 17:28:25 -0700
Received: from kbuild by 7b0b59b3a0d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wCo7A-00000000217-0hXH;
	Wed, 15 Apr 2026 00:28:20 +0000
Date: Wed, 15 Apr 2026 08:28:15 +0800
From: kernel test robot <lkp@intel.com>
To: Youling Tang <youling.tang@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH] crash: Support high memory reservation for range syntax
Message-ID: <202604150808.7HxFp5b4-lkp@intel.com>
References: <20260404074103.506793-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404074103.506793-1-youling.tang@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_172829_708023_43A7EAEF 
X-CRM114-Status: GOOD (  12.00  )
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

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v7.0 next-20260414]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Youling-Tang/crash-Support-high-memory-reservation-for-range-syntax/20260414-205035
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260404074103.506793-1-youling.tang%40linux.dev
patch subject: [PATCH] crash: Support high memory reservation for range syntax
config: loongarch-randconfig-001-20260415 (https://download.01.org/0day-ci/archive/20260415/202604150808.7HxFp5b4-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260415/202604150808.7HxFp5b4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604150808.7HxFp5b4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/crash_reserve.c:264:19: warning: expression which evaluates to zero treated as a null pointer constant of type 'char *' [-Wnon-literal-null-conversion]
     264 |         char *first_gt = false;
         |                          ^~~~~
   1 warning generated.


vim +264 kernel/crash_reserve.c

   254	
   255	/*
   256	 * This function parses command lines in the format
   257	 *
   258	 *   crashkernel=ramsize-range:size[,...][@offset],>boundary
   259	 */
   260	static void __init parse_crashkernel_boundary(char *ck_cmdline,
   261						unsigned long long *boundary)
   262	{
   263		char *cur = ck_cmdline, *next;
 > 264		char *first_gt = false;
   265	
   266		first_gt = strchr(cur, '>');
   267		if (!first_gt)
   268			return;
   269	
   270		cur = first_gt + 1;
   271		if (*cur == '\0' || *cur == ' ' || *cur == ',') {
   272			pr_warn("crashkernel: '>' specified without boundary size, ignoring\n");
   273			return;
   274		}
   275	
   276		*boundary = memparse(cur, &next);
   277		if (cur == next) {
   278			pr_warn("crashkernel: invalid boundary size after '>'\n");
   279			return;
   280		}
   281	}
   282	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

