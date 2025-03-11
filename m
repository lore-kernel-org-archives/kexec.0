Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CC3C282EC
	for <kexec@archiver.kernel.org>; Tue, 11 Mar 2025 12:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i52GKoEDODV/gHbYsnqpSBgJKxCP/29gwzHwW7BAPZA=; b=fTmKP3uw4EHpuReiG25vIW3p/O
	RNhmMuZW3EzBsEqvOaycbXuhvNwAj9fkmMKDr6C6yppKSG/qOeQ7TB9rHuZRYsPwyyAA2LN9k9PCl
	mDbtOdUCvVKItN76a1GEoF8Np+gtSzmfEVgj3kidg0T7sOkzJ2Whxa1C+uYJfmI1BvesAzmqGT9F0
	aBX3KxsesbO01y531b9fJIB9MmJeRBjSjFW8foYnL1aVp8MWvCgv8xJJrhTplLZXvz8+0fOOsqojA
	9cVzIzW4Nxy80Viek6KB9bzY+xoXVBqDusM3HymZB3GrPLwx0VK/5M817iKes5SuLeQ8LjbyjeJGU
	ERFd8mzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tryvc-00000005h3I-46nS;
	Tue, 11 Mar 2025 12:41:48 +0000
Received: from [198.175.65.13] (helo=mgamail.intel.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tryhy-00000005dko-1urF
	for kexec@lists.infradead.org;
	Tue, 11 Mar 2025 12:27:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741696062; x=1773232062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yuEZANfTnGK5pY1juUhwdi+Le7nChzttBTelQJpEB/s=;
  b=CwXXiA70wDt+iNI2C5bFaqXwQMqVbztx2fyeDan/8FL2jS/axM/1zxLN
   O7ZaBLAauY83xb6SwoeMX1rYcQpQSRGdyy+9ptcibu+jk0G0SGljDuR5R
   Tli5ubYvg6iBWJv4aWnDqc0oXTPI7nBZFiWn5LqK4AFkNsBVL64z9r0L3
   ZQ0U5vxYwCaeklOVy2mqw8AZZT3ZjIc3Zp16s2nI2FPKr/Dm0djHvLYh5
   QrLsy/7tGY/D2Q3gcUhMEL+g3aPArT9WuLujYcTh0nW7z6VJkB0uQWKTg
   zy3TCuk5vJf7IrfSkj+gCl6AoLmKovgauxy9pnGXDbjLJ8lqtqRK3fgVu
   g==;
X-CSE-ConnectionGUID: eSMh4Z3aQ5m4VEEjWHcMLw==
X-CSE-MsgGUID: f32m3n3PSleKay5PhjiaSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="53723978"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="53723978"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 05:27:42 -0700
X-CSE-ConnectionGUID: fMJhh8eOTEuvXIAfwSyEgg==
X-CSE-MsgGUID: jNHp/5gqRz2QcvkDniWcQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="125356807"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 11 Mar 2025 05:27:37 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tryh4-0006eG-31;
	Tue, 11 Mar 2025 12:26:56 +0000
Date: Tue, 11 Mar 2025 20:25:59 +0800
From: kernel test robot <lkp@intel.com>
To: Andrey Ryabinin <arbn@yandex-team.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexander Graf <graf@amazon.com>, James Gowans <jgowans@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	Pratyush Yadav <ptyadav@amazon.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: Re: [PATCH v2 4/7] kexec, kstate: delay loading of kexec segments
Message-ID: <202503112016.VZt1HD9v-lkp@intel.com>
References: <20250310120318.2124-5-arbn@yandex-team.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310120318.2124-5-arbn@yandex-team.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_052742_564258_74E2A82C 
X-CRM114-Status: GOOD (  15.76  )
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

Hi Andrey,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on akpm-mm/mm-nonmm-unstable akpm-mm/mm-everything linus/master v6.14-rc6 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrey-Ryabinin/kstate-Add-kstate-a-mechanism-to-describe-and-migrate-kernel-state-across-kexec/20250310-200803
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20250310120318.2124-5-arbn%40yandex-team.com
patch subject: [PATCH v2 4/7] kexec, kstate: delay loading of kexec segments
config: riscv-randconfig-002-20250311 (https://download.01.org/0day-ci/archive/20250311/202503112016.VZt1HD9v-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250311/202503112016.VZt1HD9v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503112016.VZt1HD9v-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/vmcore_info.c:24:
   kernel/kexec_internal.h: In function 'kexec_late_load':
>> kernel/kexec_internal.h:39:50: error: invalid use of undefined type 'struct kimage'
      39 |         return IS_ENABLED(CONFIG_KSTATE) && image->file_mode &&
         |                                                  ^~
   kernel/kexec_internal.h:40:23: error: invalid use of undefined type 'struct kimage'
      40 |                 (image->type == KEXEC_TYPE_DEFAULT);
         |                       ^~
>> kernel/kexec_internal.h:40:33: error: 'KEXEC_TYPE_DEFAULT' undeclared (first use in this function); did you mean 'KEXEC_ARCH_DEFAULT'?
      40 |                 (image->type == KEXEC_TYPE_DEFAULT);
         |                                 ^~~~~~~~~~~~~~~~~~
         |                                 KEXEC_ARCH_DEFAULT
   kernel/kexec_internal.h:40:33: note: each undeclared identifier is reported only once for each function it appears in


vim +39 kernel/kexec_internal.h

    36	
    37	static inline bool kexec_late_load(struct kimage *image)
    38	{
  > 39		return IS_ENABLED(CONFIG_KSTATE) && image->file_mode &&
  > 40			(image->type == KEXEC_TYPE_DEFAULT);
    41	}
    42	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

