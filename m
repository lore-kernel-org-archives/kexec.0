Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3991CCA0FED
	for <kexec@archiver.kernel.org>; Tue,  9 Sep 2025 06:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mZnvajWuIphnkOKjBnp0sF7qUJwZiX+WZVB1irJu2mI=; b=P1/rXREj+r8I4f0I5a5gACJ2tg
	tAqLI2hXzxh1PWCcfCsRXU9sHyG5vIYL1j6Oead5J/pnoyZhCoXkuERbdSeHA8VjDDWfU2zq6JF7J
	4aEnfxpl9YTEKgCEkgmM0F4CbLxDgRmH/XHfXhjATO6tEEmVY6LVm6vbLfWpRHElKhKJ58LjprpCQ
	sP+wft0kb6Hv7r+L/MAmrzIR3/nnMe05DDhpaCDIrDqUCJV54zWQbM98PS/k4xDAQpH5m9sV/xfkL
	GntoEnC2bwGDo93+AdiO2YWz1/Y7eKKHOLQpctDpQ/XMb8UJoiQd+FiDcPbZKy5On3gDaIjNvZzy4
	C1T7VCcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvsCC-00000004py0-3wAq;
	Tue, 09 Sep 2025 06:51:16 +0000
Received: from mgamail.intel.com ([192.198.163.9])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvjN8-00000002S6w-3cL0
	for kexec@lists.infradead.org;
	Mon, 08 Sep 2025 21:26:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757366759; x=1788902759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fu8+aayxVNZCT/oRSmjlPZbESme4v7nIzu2hac/jq2E=;
  b=nosowTNNam0hBcYORrSZI9zZ/NL3rpVrm463WSUx2rLUJd2aUm2aHWWA
   mgqs5fQkweQmxplDhdd0cqgUUO27JSOkl86CBKLMla6j/KAoTnOGBznBm
   cho+0fthfCjCXTiYjC3GRDkJW4e3E2LMTu1OoHPXotshDe+5nftNFaRdw
   2BF0VGuFMLBlL1EL6s4dP3WlX8Mqbtkb92p/eq8cekeGoYeCudkiK3boA
   4UtQA5JgHGJXXg78SVPdbHEAAvK4hWDQQF1W52MBEkJMCANzfA/S4Hzsp
   GcMur1TyZ2ovsEXwMGyqIUw8CAjkeeSLV6s4rx7CZHQOTneZC2hvfH7wd
   w==;
X-CSE-ConnectionGUID: GljDYrc1Q22HdKE1KaKvBw==
X-CSE-MsgGUID: t811ANMbTr+3ee6WLUPZKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70337127"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="70337127"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 14:25:53 -0700
X-CSE-ConnectionGUID: HtjZveYrRG2X2LOIsBwwEg==
X-CSE-MsgGUID: 2TFM5I92RN2w0wCE+oqhEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="203884073"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 08 Sep 2025 14:25:51 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvjMy-0004Ad-30;
	Mon, 08 Sep 2025 21:25:48 +0000
Date: Tue, 9 Sep 2025 05:25:17 +0800
From: kernel test robot <lkp@intel.com>
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	fuqiang wang <fuqiang.wang@easystack.cn>, x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] crash: Add KUnit tests for crash_exclude_mem_range
Message-ID: <202509090415.cOytgte4-lkp@intel.com>
References: <20250904093855.1180154-2-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904093855.1180154-2-coxu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_142558_908437_90F6D17C 
X-CRM114-Status: UNSURE (   9.24  )
X-CRM114-Notice: Please train this message.
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

Hi Coiby,

kernel test robot noticed the following build errors:

[auto build test ERROR on b320789d6883cc00ac78ce83bccbfe7ed58afcf0]

url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/crash-Add-KUnit-tests-for-crash_exclude_mem_range/20250904-174105
base:   b320789d6883cc00ac78ce83bccbfe7ed58afcf0
patch link:    https://lore.kernel.org/r/20250904093855.1180154-2-coxu%40redhat.com
patch subject: [PATCH v6 2/2] crash: Add KUnit tests for crash_exclude_mem_range
config: x86_64-randconfig-073-20250908 (https://download.01.org/0day-ci/archive/20250909/202509090415.cOytgte4-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250909/202509090415.cOytgte4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509090415.cOytgte4-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "crash_exclude_mem_range" [kernel/crash_core_test.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

