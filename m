Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BABC282EC
	for <kexec@archiver.kernel.org>; Tue, 11 Mar 2025 11:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2S7J75ioEQf5j+mrR+hGMyBT53/iTxjv1FPkZemc36s=; b=3QOINdbZcuTtLnOmjYYMbG431t
	C+iS25iOlNruwlfmWcZD8jHUFujpSUIFvlILNxnLs5lzqDe8Mp1BjsLTipdne3xjXoIjHOrfm9FeS
	iwPzFzPDfN/16yCWzDmZLjuE7LFFBJhA4FkvNwainIMVwcDwXNRYL5R2DJ1fmkDNnZHyXrxXvDkTR
	rUvLRhVs15zk/yEnKmyOaGJuwq32H8GUJ2f5pbCp7gULfZ8w/swtTFjl+bZZCP73KJzphQTcLcTST
	2OaTZHIlpzwBsAU9K0/ruIkFlykDrUJtufTWWl7z5uqN5vlGuJi+sm5+aCmi5gOLmFe2UxJE3cQGO
	HYfZYajA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trxsu-00000005UM8-3lIy;
	Tue, 11 Mar 2025 11:34:56 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trxpn-00000005TYE-2vJe
	for kexec@lists.infradead.org;
	Tue, 11 Mar 2025 11:31:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741692704; x=1773228704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0tsQsh3zhZV4peIz77XXKqRoGd4Q7VV6Rr61QE3yElU=;
  b=U3TfXIcUngk35Xm8qr/QChtoPWf0b+05cwCXMMmp+1mW0XmE2hIZ65H4
   wSS7y3K+1LRVtMas0S4Q4u3pH8OJhWx5bZLUK63HcE/HRRZuLsvqoLruR
   4MIS2PTFYKCRW4Z7wjPEyxBka3Re71MsOZV4yblcEMUPYMAmxCoszHH5Z
   Md6M4TIpgB1kAoxhQQwpl0uq+e/ZqsZ+WA5fECr77vviD36yH+sRJ6Oxq
   ZKBmC/43iBCGiakyhTDi3TQeX62ksrsXNnJm3KZ8FgBIBpMGWHAk7qr57
   u2Q5wwXDPscSufzfvfriCEZ09WP3vMjaSmmh/KVSo/w4K90d0w0jq/qwB
   w==;
X-CSE-ConnectionGUID: mj/2UMgCQ/aXcBTCIwQumw==
X-CSE-MsgGUID: r6TyaaYbTkC243uRDOaIlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="65182180"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="65182180"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 04:31:41 -0700
X-CSE-ConnectionGUID: saD4g5O3RZC3b8rSV/pfXw==
X-CSE-MsgGUID: cabz44ZsQo6Mwgwk+BYESQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="124897106"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 11 Mar 2025 04:31:36 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trxpd-0006c0-2r;
	Tue, 11 Mar 2025 11:31:33 +0000
Date: Tue, 11 Mar 2025 19:31:24 +0800
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
Message-ID: <202503111944.pfx9UdvP-lkp@intel.com>
References: <20250310120318.2124-5-arbn@yandex-team.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310120318.2124-5-arbn@yandex-team.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_043143_775957_8E77612D 
X-CRM114-Status: GOOD (  12.27  )
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
config: i386-buildonly-randconfig-003-20250311 (https://download.01.org/0day-ci/archive/20250311/202503111944.pfx9UdvP-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250311/202503111944.pfx9UdvP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503111944.pfx9UdvP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/vmcore_info.c:24:
>> kernel/kexec_internal.h:39:43: error: incomplete definition of type 'struct kimage'
      39 |         return IS_ENABLED(CONFIG_KSTATE) && image->file_mode &&
         |                                             ~~~~~^
   kernel/kexec_internal.h:9:8: note: forward declaration of 'struct kimage'
       9 | struct kimage *do_kimage_alloc_init(void);
         |        ^
   kernel/kexec_internal.h:40:9: error: incomplete definition of type 'struct kimage'
      40 |                 (image->type == KEXEC_TYPE_DEFAULT);
         |                  ~~~~~^
   kernel/kexec_internal.h:9:8: note: forward declaration of 'struct kimage'
       9 | struct kimage *do_kimage_alloc_init(void);
         |        ^
>> kernel/kexec_internal.h:40:19: error: use of undeclared identifier 'KEXEC_TYPE_DEFAULT'
      40 |                 (image->type == KEXEC_TYPE_DEFAULT);
         |                                 ^
   3 errors generated.


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

