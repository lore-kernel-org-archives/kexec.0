Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68014CCFA13
	for <kexec@archiver.kernel.org>; Sun,  9 Nov 2025 13:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cr2114I01ec/abmyNG7RpEXZ1LzjDm/1lTsSiym6iAk=; b=DsG2t5lHnV0LAJA+G+9e0sRC/A
	NoCfka570aum6bSHzXNVEoYXNiPZHJMQgrpU5vkckASyJEezV1zW3L9O6s8Uaq3MUwTlS2mSytN4Q
	I+LgryGzNq/9f8abkiqgsPXg+lahyd/bUO2LdQxxywqazdCtFGGz+5pk2Ihs80/Y9jlQ1fCXhYRg+
	4jv1Ejk9izRMuKHBlIqgJakWbxem/FK7IeFY9iSh+x20uQlE/0xMny9/7GxJMPyz6hUrg7KlUMlhH
	5Uf6QlIe4ZSb/XDQiE8q99SiZVKxQ8P9OED/ixs5wwH+e/XjYjHcFAxY0u9fxJPUTyidouvMDwwMh
	8eJp4y9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vI5dG-000000042df-02Ff;
	Sun, 09 Nov 2025 13:39:02 +0000
Received: from mgamail.intel.com ([198.175.65.21])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vI5dB-000000042dB-2Sba
	for kexec@lists.infradead.org;
	Sun, 09 Nov 2025 13:38:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762695538; x=1794231538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1x+Mo9nWh2WXI6lONcFe9DSrRcVoSKddorvdA0ovrps=;
  b=OLpY5t4vgxtqoYfmuKSDp2R6m6tEswL0nhIkTYIRmO8wwWi118Z8qZlr
   yxIA6nVloRlZt0gMM+FAHZwIJxGOynlCWvqeQyUsPJ8iY0Mn3TIZi+v9l
   0V3KFoCHgMoRV6TGcWCB8w4VFt8mpxbH7k2FCQ7zDe3iUb9Om9aUfFBKv
   qGHOtE3q0qMfyBisxJVtwASfZxTkzikgfUSfrEa80F8psgtjBBcgEkHc0
   bzjPPA6Um9iD8f06Q2F0uA3Lo9DHxxtSYODxYBiZzqR+e0Ye25YeHQk+2
   JAcJqkbrrawzPjVmoiVwUM4u3VwHvBBMlqk/k6IaAZzPPecwMwHFrAU3Q
   w==;
X-CSE-ConnectionGUID: T4mMCLdlRNWDqRc6mNYeMw==
X-CSE-MsgGUID: wbF1c6iwSAa0vmVk6cBpHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64678372"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64678372"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 05:38:53 -0800
X-CSE-ConnectionGUID: ifjZIU4pSdODEVFMem63lw==
X-CSE-MsgGUID: JRKtoAiyTRuSZxiMKKrPuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="192570350"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 09 Nov 2025 05:38:49 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vI5d0-00022F-1d;
	Sun, 09 Nov 2025 13:38:46 +0000
Date: Sun, 9 Nov 2025 21:38:19 +0800
From: kernel test robot <lkp@intel.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Sourabh Jain <sourabhjain@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>, Jiri Bohac <jbohac@suse.cz>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shivang Upadhyay <shivangu@linux.ibm.com>,
	Vivek Goyal <vgoyal@redhat.com>, linuxppc-dev@lists.ozlabs.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v2 2/5] kexec: move sysfs entries to /sys/kernel/kexec
Message-ID: <202511092102.Qi35GqrR-lkp@intel.com>
References: <20251106045107.17813-3-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106045107.17813-3-sourabhjain@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251109_053857_870292_E6333E8A 
X-CRM114-Status: GOOD (  11.37  )
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

Hi Sourabh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.18-rc4 next-20251107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sourabh-Jain/Documentation-ABI-add-kexec-and-kdump-sysfs-interface/20251106-125243
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251106045107.17813-3-sourabhjain%40linux.ibm.com
patch subject: [PATCH v2 2/5] kexec: move sysfs entries to /sys/kernel/kexec
config: s390-randconfig-r131-20251109 (https://download.01.org/0day-ci/archive/20251109/202511092102.Qi35GqrR-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251109/202511092102.Qi35GqrR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511092102.Qi35GqrR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/kexec_core.c:1315:16: sparse: sparse: symbol 'kexec_kobj' was not declared. Should it be static?

vim +/kexec_kobj +1315 kernel/kexec_core.c

  1314	
> 1315	struct kobject *kexec_kobj;
  1316	ATTRIBUTE_GROUPS(kexec);
  1317	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

