Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FD1606A335
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 11:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gesyHpvl;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kH6kTpAi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=30J4sbOlYJiNq7Z4tRszcjWu8hBcWrg7tEn3jlctPwo=; b=gesyHpvlKe1ikfpIucqcnRmpUB
	DhPAYYdo0mEEO5wlKtm/sPksFiUjIJToxQDtVvvdsw/9H8TYGAuotOQCjloAcks/YVon+6l0cbZKc
	bROv/HAHwvmkUc0Dhy1m0n0qAvefjSKAT8sR6N1M/3qjUvzFvIul36F69iEG9iBH9otXBuXWeUkmw
	HvJEfgKfDKAZXC822k4osijlu3ORGiXBni5zGAq2YLZNI4ZiQittIU0DMlq/kaY8bLPoil7RPt/js
	tz1OtrmbTRFEiM0Egr14cwgA8yao5ws+BLEZZtHImWMF5JolPokO9RmLWm80e+OURYg+roddk8vN0
	n9BVmZZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOvlz-00000008fs0-0Wsm;
	Thu, 05 Nov 2026 11:36:51 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOvll-00000008fgl-2Cu2;
	Thu, 05 Nov 2026 11:36:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793878598; x=1825414598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J9dOmPMshDIpYmZ/TrqPMjz7mHsp3Z6+Ou1qHQ88q2c=;
  b=kH6kTpAiQCWPXNnHfol4Ir8+s9VJjZqKUrEiOYYXZ519D9v6B5xP2gry
   GnxiwbeLFhRczydH6mZJ0OLOiGGGZE6rGnuWsdi7YptLDmfnzWYK9ipH0
   dFC+58sXrURL/5et1b81u3MYRwTIazl4W9H6PFyG6JrBjGDynR8P86946
   XGW7UEKjEwT0v0iPok/BKikScign00RZapSIvNNIiIqAoLcjFjvBcwcNF
   mL/HcsTXXDUec0Erc9ynncQVAqW6Z3TJ/1Z9sXlIVcBTPVZLkkuPAbbCG
   vltsW6FpoPg9oXfRHm1xluCStSwpy0jt6Dfl66lBwsO3byRFQOjk4dw6n
   g==;
X-CSE-ConnectionGUID: MnK2oyOyR5GL2nPOvprT4Q==
X-CSE-MsgGUID: e4YSEWZKTTiEEKZbLmoQAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2547432"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2547432"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 03:36:37 -0800
X-CSE-ConnectionGUID: NU49M+y7SoqJQQ7rq8Z1Cw==
X-CSE-MsgGUID: /gbM1bnkQwynnPU6B2caeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7163862"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 05 Nov 2026 03:36:29 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOvlZ-00000000m7v-0S9w;
	Thu, 05 Nov 2026 11:36:25 +0000
Date: Thu, 5 Nov 2026 19:35:46 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jann Horn <jannh@google.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <chris.mason@fusionio.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Eric Dumazet <edumazet@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>,
	Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Granados <joel.granados@kernel.org>,
	Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org,
	coreteam@netfilter.org, kexec@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND v2 01/51] alloc_tag: don't remove /proc/allocinfo
 under the codetag module lock
Message-ID: <202611051923.pLSSWWkA-lkp@intel.com>
References: <20261104-work-procfs-bugfixes-v2-1-021c84d852e0@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-work-procfs-bugfixes-v2-1-021c84d852e0@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_033637_578379_9E7B2DDB 
X-CRM114-Status: GOOD (  12.75  )
X-Spam-Score: -4.4 (----)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Brauner/alloc_tag-don-t-remove-proc-allocinfo-under-the-codetag-module-lock/20261104-200606
base:   6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
patch link:    https://lore.kernel.org/r/20261104-work-procfs-bugfixes-v2-1-021c84d852e0%40kernel.org
patch subject: [PATCH RESEND v2 01/51] alloc_tag: don't remove /proc/allocinfo under the codetag module lock
config: sh-randconfig-1001-20261105 (https://download.01.org/0day-ci/archive/20261105/202611051923.pLSSWWkA-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611051923.pLSSWWkA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611051923.pLSSWWkA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/alloc_tag.c:620:13: warning: 'shutdown_mem_profiling_async' defined but not used [-Wunused-function]
     620 | static void shutdown_mem_profiling_async(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/shutdown_mem_profiling_async +620 mm/alloc_tag.c

   613	
   614	/*
   615	 * A module's tags are reserved with the codetag module lock held for
   616	 * writing, and a reader of /proc/allocinfo takes that lock with the entry
   617	 * pinned. Removing the entry there would wait for that reader for good, so
   618	 * let a work item do it.
   619	 */
 > 620	static void shutdown_mem_profiling_async(void)
   621	{
   622		if (!mem_profiling_support)
   623			return;
   624		shutdown_mem_profiling(false);
   625		schedule_work(&remove_allocinfo_work);
   626	}
   627	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

