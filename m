Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84504F9D0CE
	for <kexec@archiver.kernel.org>; Wed, 15 Apr 2026 01:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Bl7WGpmLYIApMfuS1TwMShkQjfWUQ5qudg2RkqIKY0=; b=mdZLMot/BMV+fklqfOy5DtBIbH
	dVKLiO/E4UKryBOs411+LEP6nt45Gir1zUNYUojYq7vrb1d2culec9TgeOhP52mFDCdhAcHBdcq7j
	8tzaDeRWWWyrUY8a0WWKqHIZvaFBioEwTUIW5eCO/tvRhZiyLFtQaGJUXK6PK0gOtwUsM4+WBEdcQ
	PK1yiUjEthomLZVlTTZxHodPZd3yq1QE/aHaU4b6AoxgTi5VUWi8PadHklYJC8gtjKoQm98tetpQd
	4E8D8/bj/Fsl7/k8aL6UvbgKtP6kfATyx7zIxLIr5NKsth6PVAw1sQ4qCTzUxYVNMp8zs6cbMGjid
	sUHhGsow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCpHz-00000000RDm-3e2u;
	Wed, 15 Apr 2026 01:43:35 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCpHx-00000000RDL-1KGs
	for kexec@lists.infradead.org;
	Wed, 15 Apr 2026 01:43:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776217413; x=1807753413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KJ1dmm7JBQS8tm37XInqKorcvhoHPQHM2ZL56cx+0tc=;
  b=Ct++P5XsUBJCz7JhMzvZ3nfAX/zU+GXjhBdXvJPFBZKI0igDRwv6xV8l
   FJcmfmd31z0n2FoiNnUJovxN5b2uhY+KmPi0a41pmjBkAhXa+3MgKKFzt
   jkhMkJvRQoOrsAIjqLu3/ueLQcZMNlr5jq54SqV3pRS9p88r2X30UtZOY
   TWXYH5MbuQ3EboqQmqNzhBbh5f6GystlI+x8jBJzh3oFJluwYrlrPq0HH
   oFDCaZIHjHKekDN4d/kCXRXGh3z9wC3NeJn3fhgZTwiJxi8CqwAwCeyHl
   TDxsD9Ool4xpVQuAvhrd3ajeZX9PoEgA0/KzYnsurpKlEyYtaaYjEzbNo
   g==;
X-CSE-ConnectionGUID: LYijg4WKRA+lT7o0dOAaGQ==
X-CSE-MsgGUID: D8vl3lBnQ96j1nF23TFpvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77092850"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77092850"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 18:43:31 -0700
X-CSE-ConnectionGUID: xDnDgNgmQHylQE5TEFOqqQ==
X-CSE-MsgGUID: 0K3ensgWS3ubo6LrqDE3yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229401197"
Received: from lkp-server01.sh.intel.com (HELO 7b0b59b3a0d4) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 14 Apr 2026 18:43:28 -0700
Received: from kbuild by 7b0b59b3a0d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wCpHp-0000000023N-1IVW;
	Wed, 15 Apr 2026 01:43:25 +0000
Date: Wed, 15 Apr 2026 09:43:06 +0800
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
Message-ID: <202604150941.oDguaP7A-lkp@intel.com>
References: <20260404074103.506793-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404074103.506793-1-youling.tang@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_184333_436697_CAC29C03 
X-CRM114-Status: GOOD (  11.60  )
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

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v7.0 next-20260414]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Youling-Tang/crash-Support-high-memory-reservation-for-range-syntax/20260414-205035
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260404074103.506793-1-youling.tang%40linux.dev
patch subject: [PATCH] crash: Support high memory reservation for range syntax
config: s390-defconfig (https://download.01.org/0day-ci/archive/20260415/202604150941.oDguaP7A-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260415/202604150941.oDguaP7A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604150941.oDguaP7A-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/crash_reserve.c:264:19: warning: expression which evaluates to zero treated as a null pointer constant of type 'char *' [-Wnon-literal-null-conversion]
     264 |         char *first_gt = false;
         |                          ^~~~~
>> kernel/crash_reserve.c:324:16: error: use of undeclared identifier 'DEFAULT_CRASH_KERNEL_LOW_SIZE'
     324 |                         *low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +/DEFAULT_CRASH_KERNEL_LOW_SIZE +324 kernel/crash_reserve.c

   282	
   283	static int __init __parse_crashkernel(char *cmdline,
   284				     unsigned long long system_ram,
   285				     unsigned long long *crash_size,
   286				     unsigned long long *crash_base,
   287				     const char *suffix,
   288				     bool *high,
   289				     unsigned long long *low_size)
   290	{
   291		char *first_colon, *first_space;
   292		char *ck_cmdline;
   293		char *name = "crashkernel=";
   294		unsigned long long boundary = 0;
   295		int ret;
   296	
   297		BUG_ON(!crash_size || !crash_base);
   298		*crash_size = 0;
   299		*crash_base = 0;
   300	
   301		ck_cmdline = get_last_crashkernel(cmdline, name, suffix);
   302		if (!ck_cmdline)
   303			return -ENOENT;
   304	
   305		ck_cmdline += strlen(name);
   306	
   307		if (suffix)
   308			return parse_crashkernel_suffix(ck_cmdline, crash_size,
   309					suffix);
   310		/*
   311		 * if the commandline contains a ':', then that's the extended
   312		 * syntax -- if not, it must be the classic syntax
   313		 */
   314		first_colon = strchr(ck_cmdline, ':');
   315		first_space = strchr(ck_cmdline, ' ');
   316		if (first_colon && (!first_space || first_colon < first_space)) {
   317			ret = parse_crashkernel_mem(ck_cmdline, system_ram,
   318					crash_size, crash_base);
   319	
   320			/* Handle optional ',>boundary' condition for range ':' syntax only. */
   321			parse_crashkernel_boundary(ck_cmdline, &boundary);
   322			if (!ret && *crash_size > boundary) {
   323				*high = true;
 > 324				*low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
   325			}
   326	
   327			return ret;
   328		}
   329	
   330		return parse_crashkernel_simple(ck_cmdline, crash_size, crash_base);
   331	}
   332	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

