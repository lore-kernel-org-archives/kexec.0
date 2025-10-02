Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAFDCAC5B0
	for <kexec@archiver.kernel.org>; Thu,  2 Oct 2025 04:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NHF6h4Ls4dHg3uTjT8RkkFkU4hLoyL8d6PtCtHg7MP4=; b=SZu931Z1yPBpMrBy7WkPJQX98W
	ej5exRNr5iXD6So5FX6euug0541Jki6x4ypDhXpouEtq7AWtYDmNa3dypBpwYm8JhJKsgOQzUHUmW
	WChLicIZfcbk0NXmsG9Jb+6hmq+G8ws8Mj5wANcgmJmqVBFdgaFn4zeoy+EUNWDeb9vc2N9jhilWT
	Zs+LX8ssGqJ8C8sEKqtzw0QwvGiQuB2JEPjo7cKSvExxpV1tiP/X4t4+v7jonV4xDLhn+6diPohmi
	PLsQywOorYFyasSiKgAfBEiU0xkhV5dtXlUYAqxSdp3mAy0xvxsavyAqbR10K1z0+EKyKar0PF4d3
	dM1p59Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4Awc-00000009arQ-34nu;
	Thu, 02 Oct 2025 04:29:30 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4Awa-00000009aqp-0Ug7
	for kexec@lists.infradead.org;
	Thu, 02 Oct 2025 04:29:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759379368; x=1790915368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9f+HXNcD7IOFZER/ertfy9YqZjvmxhL5wyEiNgnR4kw=;
  b=KakNZo8Nm5MBSPsRMzysa2vYGD2i3OvF8k6GGJMDAeViSKCabs7kPxiV
   CrgICdi4ivOObCVlajUH9sUe2dSUIlEfSgt8DoB6cJRoZNCM9V7Cp66v6
   nPFG4HXX+z/J0MENcT5FeShukkA4GiD61Gh+yDw9vmL8c9Xm82wzfIWcV
   sPm8d/Qf4V4G2AqJJihALIWbWLF9qyhc5JKStRSaRvtAWiZIX8uYV0u/o
   2omFc9CKbQXKsD0IfK8QA5wZiPKMcD0LK9BfXN9UchxhtcgilamyAhQEU
   wskjedL7fwtLWMFUoSzju2RChS0g60j77m5UprYWmIdwlg/BQOJP+5rph
   w==;
X-CSE-ConnectionGUID: qqU76AtdTeG23VsHTRs0ZQ==
X-CSE-MsgGUID: HEdQImhZTvidi85dAQ3gIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="73016726"
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="73016726"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 21:29:24 -0700
X-CSE-ConnectionGUID: LZEq29e4Tqu8t5/Q3RYwFw==
X-CSE-MsgGUID: wbDqmC1RT0KGjEqOh3Vncg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="179734321"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 01 Oct 2025 21:29:21 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v4AwR-0003Z5-0K;
	Thu, 02 Oct 2025 04:29:19 +0000
Date: Thu, 2 Oct 2025 12:29:15 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Miu <jasonmiu@google.com>, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v1 1/3] kho: Adopt KHO radix tree data structures
Message-ID: <202510021229.mKL5i2Vt-lkp@intel.com>
References: <20251001011941.1513050-2-jasonmiu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001011941.1513050-2-jasonmiu@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251001_212928_198593_AA6B6BD3 
X-CRM114-Status: GOOD (  11.24  )
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

Hi Jason,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rppt-memblock/for-next]
[also build test WARNING on linus/master v6.17]
[cannot apply to rppt-memblock/fixes akpm-mm/mm-everything next-20250929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Miu/kho-Adopt-KHO-radix-tree-data-structures/20251001-092230
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git for-next
patch link:    https://lore.kernel.org/r/20251001011941.1513050-2-jasonmiu%40google.com
patch subject: [PATCH v1 1/3] kho: Adopt KHO radix tree data structures
config: x86_64-randconfig-005-20251001 (https://download.01.org/0day-ci/archive/20251002/202510021229.mKL5i2Vt-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251002/202510021229.mKL5i2Vt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510021229.mKL5i2Vt-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: kho_radix_walk_trees_callback+0x83 (section: .text) -> __memblock_reserve (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: kho_radix_walk_trees_callback+0x91 (section: .text) -> memblock_reserved_mark_noinit (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

