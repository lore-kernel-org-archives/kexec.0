Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDB8CCA470
	for <kexec@archiver.kernel.org>; Wed,  1 Oct 2025 16:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8NO5Cox1O1/W54mk1qS/tzDDi0dYt0a/DUjYAb9Uhc8=; b=2CIrXnKKt2YqMMyplwoD41fqz8
	oUqy2nz+HKd6n5/Tz8iipXDuu2V0alzdWnFtJ5omKr81Qy06IJ10oge0cbSt6+FxEOVuSgThXF/ou
	41sYa+tHKPKdZBs15YruFDQEIQ/LGHxMXpRTqq8/od4gSh0KpNXexJQhNWzBb+kOJyGWnVs2VhXl8
	Hxsp9I/KedVq0qbaU4CKQyMy00L8lsYNpq+/paabu1qNaR+BRPQhaOWaS2O3rsduNlC7Y3wnK4/IX
	7rQNd3MkY9TJ6165aLd4OnpivdkHWQVzLiCIUrzLsfWCUTtUfeZV23FcrVi8grtzzP6XS5NTqCAwT
	q4qWsr2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3zoe-00000008XEZ-1ydm;
	Wed, 01 Oct 2025 16:36:32 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3zob-00000008XDt-2zy1
	for kexec@lists.infradead.org;
	Wed, 01 Oct 2025 16:36:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759336590; x=1790872590;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HSLm25QXTpkKM7aT1hm4htROq4qR0UuimjxRvDGXd0s=;
  b=bzHb3qjwOftKuh925q4rsEchRIjVKL8WLlarjujzCRDoNBJ0zPRzM3Qp
   x8s+rIpqz7V2GBKmLSOOHcgtKZLIJZ1RhP1C7mZpzO+oWHx+09X4QIN10
   MVW07MRmqTZqokyxcZeUd4YsNCDMb7OCxoGbXmQpBgAe5wRPI+o0cP84N
   sASTpEf/83JvkP3UhneYO+A8c7KeYR6GNW0Mm/H3G4fI8Cihr3SJF2z79
   FF8n1BV06UeWnxrRQk38R80y18iiraNI/Pv6UZQt01h9Rfe3HB+nocinT
   D6/jVC8MzLh0GRp1YoLjRBGyfPOjo95vtL1NvhCyxU9DQHSdstSDzsUDu
   w==;
X-CSE-ConnectionGUID: lK4WHzr3R4eUU9J2Y49l2A==
X-CSE-MsgGUID: sfXLJxGSSeeOeNoTYXJZkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61506584"
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="61506584"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 09:36:26 -0700
X-CSE-ConnectionGUID: TwRkw5L8S9qMFlhUI5AWtQ==
X-CSE-MsgGUID: OPt0fZOnSpGgCizH7DihNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="183116776"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 01 Oct 2025 09:36:22 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v3zoR-0003B5-26;
	Wed, 01 Oct 2025 16:36:19 +0000
Date: Thu, 2 Oct 2025 00:35:48 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v1 2/3] memblock: Remove KHO notifier usage
Message-ID: <202510020000.IIPFcxsW-lkp@intel.com>
References: <20251001011941.1513050-3-jasonmiu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001011941.1513050-3-jasonmiu@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251001_093629_794124_48B5C850 
X-CRM114-Status: GOOD (  12.90  )
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

[auto build test ERROR on rppt-memblock/for-next]
[also build test ERROR on linus/master v6.17]
[cannot apply to rppt-memblock/fixes akpm-mm/mm-everything next-20250929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Miu/kho-Adopt-KHO-radix-tree-data-structures/20251001-092230
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git for-next
patch link:    https://lore.kernel.org/r/20251001011941.1513050-3-jasonmiu%40google.com
patch subject: [PATCH v1 2/3] memblock: Remove KHO notifier usage
config: x86_64-randconfig-003-20251001 (https://download.01.org/0day-ci/archive/20251002/202510020000.IIPFcxsW-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251002/202510020000.IIPFcxsW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510020000.IIPFcxsW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/test_kho.c:59:44: error: too many arguments to function call, expected 2, have 3
      59 |         err |= kho_add_subtree(ser, KHO_TEST_FDT, folio_address(state->fdt));
         |                ~~~~~~~~~~~~~~~                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kexec_handover.h:30:5: note: 'kho_add_subtree' declared here
      30 | int kho_add_subtree(const char *name, void *fdt);
         |     ^               ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +59 lib/test_kho.c

b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  40) 
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  41) static int kho_test_notifier(struct notifier_block *self, unsigned long cmd,
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  42) 			     void *v)
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  43) {
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  44) 	struct kho_test_state *state = &kho_test_state;
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  45) 	struct kho_serialization *ser = v;
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  46) 	int err = 0;
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  47) 
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  48) 	switch (cmd) {
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  49) 	case KEXEC_KHO_ABORT:
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  50) 		return NOTIFY_DONE;
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  51) 	case KEXEC_KHO_FINALIZE:
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  52) 		/* Handled below */
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  53) 		break;
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  54) 	default:
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  55) 		return NOTIFY_BAD;
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  56) 	}
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  57) 
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  58) 	err |= kho_preserve_folio(state->fdt);
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27 @59) 	err |= kho_add_subtree(ser, KHO_TEST_FDT, folio_address(state->fdt));
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  60) 
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  61) 	return err ? NOTIFY_BAD : NOTIFY_DONE;
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  62) }
b753522bed0b7e Mike Rapoport (Microsoft  2025-07-27  63) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

