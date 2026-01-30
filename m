Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49302D49C92
	for <kexec@archiver.kernel.org>; Fri, 30 Jan 2026 10:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pKF8X3pE882cWr/4cWrmRouYmpeno5NPBDdmWMasVKE=; b=dKChimcnEssm+fsDj/eblz4VUH
	mbRbD/rBapvTU6Y+v22DhC6FYJ13NLSprklcBrFoIe8F02F3OZ4dBdsPBiboSCIjKpHFhqNdTXCS0
	fZGv52XoQidmOVBcJH+TLjrQcp6z4bzxuJFJtnLlGBNsDnlwH+J6QJyU5iPvrZmEWMgDuRAqluFmO
	TFGktgUFKvEHLqOy2cm4iYP7dv5Pro/Z0lcEDyFeB2FM20Zq4dz5JKQcKJtnSuA9Gu0mVp37s5Ojg
	oJFWC70++9ne2bgtZ6JE/rVeALnj9lx3e5ADQEJf+Jdt02hyDm1gR57+JLzgUt1exO3BsfUifO1E6
	27VY/pTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vllkW-00000001KIB-1H4L;
	Fri, 30 Jan 2026 10:29:12 +0000
Received: from mgamail.intel.com ([198.175.65.17])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vllkT-00000001KHY-387o
	for kexec@lists.infradead.org;
	Fri, 30 Jan 2026 10:29:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769768950; x=1801304950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FHGMwOuDMyqUbdmwF7i7VTLEoZIkyO/zzJwWJ2VhDBI=;
  b=TFzeGrKGmuFJy7j42Sjn8/5eboD9NVWohRy83ZLs+44GF9+5mJpX9Q8b
   nX0vEajvkAKhcPwWuX05xy8NqC+1iwIvVEZ3jg5cLgQ1+oJwn3hYYif/j
   cUAdEgxlkNOQAJDOHHNPRkCvK1Kr/4CSQ0Md7CFzUmyHWBAsFG6WyV0vm
   N5SJPNauZjMxlS4iLHRjV+N5kJ5QxxXSJ4O82SF6q63pvydHQsQ3fPm4b
   kxIAq1eMNbzmm7GXwbY3L3EokB2ZVQC5hKynSODa/wr5UtFAiT99R+Mnw
   1Dt2pTy6tBSRq3hicJMtHlgpsVHWBkBrIrHiTuXmqEcXsXCsa9VY8thDP
   w==;
X-CSE-ConnectionGUID: orUlenrlQ0i4GjVqRhVjig==
X-CSE-MsgGUID: tiW5OGjNTdS1yelnU2CoPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70996999"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="70996999"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 02:29:09 -0800
X-CSE-ConnectionGUID: map7TzjeSMuclFBRztNn6Q==
X-CSE-MsgGUID: vo+SFuKvQPyHGzrU5yiCCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="208418862"
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by fmviesa007.fm.intel.com with ESMTP; 30 Jan 2026 02:29:05 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vllkN-000000002Tv-1g7X;
	Fri, 30 Jan 2026 10:29:03 +0000
Date: Fri, 30 Jan 2026 11:28:47 +0100
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
Subject: Re: [PATCH v8 1/2] kho: Adopt radix tree for preserved memory
 tracking
Message-ID: <202601301107.1CQsWeRT-lkp@intel.com>
References: <20260130005739.3163049-2-jasonmiu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130005739.3163049-2-jasonmiu@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_022909_862614_87D5A885 
X-CRM114-Status: UNSURE (   8.54  )
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

Hi Jason,

kernel test robot noticed the following build errors:

[auto build test ERROR on 33a647c659ffa5bdb94abc345c8c86768ff96215]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Miu/kho-Adopt-radix-tree-for-preserved-memory-tracking/20260130-090027
base:   33a647c659ffa5bdb94abc345c8c86768ff96215
patch link:    https://lore.kernel.org/r/20260130005739.3163049-2-jasonmiu%40google.com
patch subject: [PATCH v8 1/2] kho: Adopt radix tree for preserved memory tracking
reproduce: (https://download.01.org/0day-ci/archive/20260130/202601301107.1CQsWeRT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601301107.1CQsWeRT-lkp@intel.com/

All errors (new ones prefixed by >>):

   WARNING: No kernel-doc for file ./include/linux/kho/abi/kexec_handover.h
   ERROR: Cannot find file ./include/linux/kho/abi/memblock.h
   WARNING: No kernel-doc for file ./include/linux/kho/abi/memblock.h
   ERROR: Cannot find file ./include/linux/kho/abi/kexec_handover.h
   WARNING: No kernel-doc for file ./include/linux/kho/abi/kexec_handover.h
>> ERROR: Cannot find file ./include/linux/kho_radix_tree.h
   WARNING: No kernel-doc for file ./include/linux/kho_radix_tree.h
   ERROR: Cannot find file ./include/linux/kref.h
   WARNING: No kernel-doc for file ./include/linux/kref.h
   ERROR: Cannot find file ./include/linux/rslib.h
   ERROR: Cannot find file ./include/linux/rslib.h

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

