Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C46F9D0CE
	for <kexec@archiver.kernel.org>; Wed, 15 Apr 2026 03:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4tZtfPotxl8kfqhlcellANwp2kwmi1pimXdRirEPd8U=; b=0/vT/+CaKU4e1CaW+bHfg+43m6
	QhBFXo5N0D9IpPBVdfziNAO531BJpC0qIA9oszi5/gHn4JqgB9ENOflFJ2DDABsKwPNLqH2iLlTSC
	QutYNR0eIJ4Eoa5/v+KU6W2Zp8vJ6+xhErTY7XCdskgfr+LSHXj1S3Jku/XdfUhi/FbStBnxXouEO
	yK39dC97Oj1rwwLLtTrj4WxtWv/5wLemArXn3FvFvU3YAbKLyzCc/y9cXUsTNcZgri96CvUJL/JQD
	EDIEVHJRvpg0UV/sSKp+fsiWAWluyoI3LekkSwSwIs/doAeYQTdwbAgPqUS1+Q6TxlVPbQggEljwj
	yuXqYfbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCqlu-00000000Vrl-3Ols;
	Wed, 15 Apr 2026 03:18:34 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCqls-00000000VrN-0Wsn
	for kexec@lists.infradead.org;
	Wed, 15 Apr 2026 03:18:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776223112; x=1807759112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pN4vBEp6nfcqXNrQLkmLldYUzKj2XXj7ZHPiuukhJLg=;
  b=ND2CLi4ZQGV75/+CsNsfvReESg0aINLLHoP065fEZKqSou0NU1HrZaJk
   tKn6qTOp6hOMOOk1iq31jP+JtMt1fs0PQQZvWWEiSiI/ou5YajOtJZxxt
   sIfT1xbQgDexMbGWVoJjOMMSGvAZ2++Jru+PIcQIPkbEaZF4vPTyWNEPt
   H10gFo888+jPtsZ/hTi8rJXGiXLctrbesgll8WnICueTS6asNvI2NiJBR
   t3UN00UevptuNuTfuXq8A3Fsh/0jHZQ83seGm8IH8xb/Qxs0nGobxw6XE
   vwTfn8Jb4w7J5JwCjG/h1lyKm+pC/rkShvefAj/qqqhm7Zkc+CAsuwhPp
   Q==;
X-CSE-ConnectionGUID: 5BALn9L9RVWdv8FFhrbsHQ==
X-CSE-MsgGUID: sXIgcYbkRq6MsVRGqF6EPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="76224292"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="76224292"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 20:18:29 -0700
X-CSE-ConnectionGUID: hRHIx42nTce3zJplxlFpbg==
X-CSE-MsgGUID: 36SwFOnOTKqLOuqoFusQfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="223780958"
Received: from lkp-server01.sh.intel.com (HELO 7f3b36e5d6a5) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 14 Apr 2026 20:18:26 -0700
Received: from kbuild by 7f3b36e5d6a5 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wCqlj-0000000005h-0rLu;
	Wed, 15 Apr 2026 03:18:23 +0000
Date: Wed, 15 Apr 2026 11:17:53 +0800
From: kernel test robot <lkp@intel.com>
To: Youling Tang <youling.tang@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH] crash: Support high memory reservation for range syntax
Message-ID: <202604151100.7wbci6vo-lkp@intel.com>
References: <20260404074103.506793-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404074103.506793-1-youling.tang@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_201832_231873_D810C6C5 
X-CRM114-Status: GOOD (  14.77  )
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
config: mips-randconfig-r061-20260415 (https://download.01.org/0day-ci/archive/20260415/202604151100.7wbci6vo-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260415/202604151100.7wbci6vo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604151100.7wbci6vo-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/crash_reserve.c: In function '__parse_crashkernel':
>> kernel/crash_reserve.c:324:37: error: 'DEFAULT_CRASH_KERNEL_LOW_SIZE' undeclared (first use in this function)
     324 |                         *low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/crash_reserve.c:324:37: note: each undeclared identifier is reported only once for each function it appears in


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

