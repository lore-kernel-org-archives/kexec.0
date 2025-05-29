Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E9EC5AD49
	for <kexec@archiver.kernel.org>; Thu, 29 May 2025 15:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=914ioYTBrQrx2PypTshl4Y0e5nj206dcoNXuwOvgkyg=; b=gVS8QfuRF2ZiD7kq/69UZ2sdNQ
	f9yshIlCxjsJPbaKn63NvJh3gmNA1upfRjUyTQnPso/A027p6T3f2BWMNy0UIR+y/jNavS/M5VJad
	sx4uaNzUNk4CxsPZLqXdhhaKh/tqSxKhKH4FP9S7vgX1EDA4Qb8NqUYXVXzuFP1SUQ2NDS7VsE5He
	hLDAWMxBjuJ1w6Xg7eaBZw8ldQMa5WE4wMXBgwgo5gjn0ITviSJqsRUkyQOnvEsUEyh8Ul6GCgoHm
	MDRwB16CE55aRQPnIVHRnVcrZpfSCNYMQbJvn6dldi5IOXOpMRMZqpXnloXtVGzHFGDV89iPbpwzE
	wIlh9azg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKfKU-0000000G5yW-0zNa;
	Thu, 29 May 2025 15:38:02 +0000
Received: from mgamail.intel.com ([198.175.65.20])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKfIG-0000000G5ea-1zEV;
	Thu, 29 May 2025 15:35:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748532945; x=1780068945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GPdqafqU2tPrO3Kwr1heLn8rpZD1wUwbKicBkAIdz60=;
  b=OGc0FvTY9ShVbHD44XIAyC0V/Qsmq57bwilebHX/U+PyNASwnjjKkAvD
   zqsuEGR9itlIUjOZ98gXM0BIjHHf7hg4pR+MiquKBoyoaqK6hFCaBgmcw
   njatS5ye09FyDQNV7L8ZkRNIPs1wUPLoN0VTlbmRQ2xJwrEaYf26QbQgG
   AkXSXX7JwVjkBNYBMOHQHsh2vJ3fQYCdvYEHMbRbVK8zSwvToM22CwwrX
   VbGv0IhA7eNGJdYDfIsw4154etEpFy49uqR0i1vR/Ij/1ll5Y+skKmXlO
   5jJHhJ6fYV2zi9BGGxObqxZVHl1CZJn2kM4mDd5bytltXQeQr/KNnEszA
   A==;
X-CSE-ConnectionGUID: GurwNw5eTGe/vieQfFt8dg==
X-CSE-MsgGUID: FeoDSDM8RTKiFiW4eor3Xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50302770"
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="50302770"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 08:35:32 -0700
X-CSE-ConnectionGUID: W1hnYaAwS2CKSIOXxah0vw==
X-CSE-MsgGUID: Hz/Y3PS0ShSJB8EDBEqtNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="148887384"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 29 May 2025 08:35:26 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKfHv-000WpE-2L;
	Thu, 29 May 2025 15:35:23 +0000
Date: Thu, 29 May 2025 23:34:48 +0800
From: kernel test robot <lkp@intel.com>
To: Pingfan Liu <piliu@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Pingfan Liu <piliu@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>, Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	kexec@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCHv3 9/9] arm64/kexec: Add PE image format support
Message-ID: <202505292305.zHTx5StD-lkp@intel.com>
References: <20250529041744.16458-10-piliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529041744.16458-10-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_083544_553033_4CCA1295 
X-CRM114-Status: GOOD (  13.09  )
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

Hi Pingfan,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]
[also build test ERROR on bpf/master arm64/for-next/core v6.15]
[cannot apply to bpf-next/master linus/master next-20250529]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pingfan-Liu/kexec_file-Make-kexec_image_load_default-global-visible/20250529-122124
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250529041744.16458-10-piliu%40redhat.com
patch subject: [PATCHv3 9/9] arm64/kexec: Add PE image format support
config: arm64-randconfig-004-20250529 (https://download.01.org/0day-ci/archive/20250529/202505292305.zHTx5StD-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250529/202505292305.zHTx5StD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505292305.zHTx5StD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h:6,
                    from kernel/kexec_pe_image.c:25:
   tools/lib/bpf/skel_internal.h: In function 'skel_finalize_map_data':
   tools/lib/bpf/skel_internal.h:155:15: error: implicit declaration of function 'bpf_map_get'; did you mean 'bpf_map_put'? [-Werror=implicit-function-declaration]
     155 |         map = bpf_map_get(fd);
         |               ^~~~~~~~~~~
         |               bpf_map_put
   tools/lib/bpf/skel_internal.h:155:13: warning: assignment to 'struct bpf_map *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     155 |         map = bpf_map_get(fd);
         |             ^
   kernel/kexec_pe_image.c: In function 'kexec_bpf_prog_run_init':
>> kernel/kexec_pe_image.c:283:16: error: implicit declaration of function 'register_btf_fmodret_id_set'; did you mean 'register_btf_kfunc_id_set'? [-Werror=implicit-function-declaration]
     283 |         return register_btf_fmodret_id_set(&kexec_modify_return_set);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                register_btf_kfunc_id_set
   kernel/kexec_pe_image.c: In function 'pe_image_load':
   kernel/kexec_pe_image.c:325:44: warning: variable 'cmdline_sz' set but not used [-Wunused-but-set-variable]
     325 |         unsigned long linux_sz, initrd_sz, cmdline_sz, bpf_sz;
         |                                            ^~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for KEXEC_PE_IMAGE
   Depends on [n]: KEXEC_FILE [=y] && DEBUG_INFO_BTF [=n] && BPF_SYSCALL [=n]
   Selected by [y]:
   - ARCH_SELECTS_KEXEC_FILE [=y] && KEXEC_FILE [=y]


vim +283 kernel/kexec_pe_image.c

536de0ba3b982c Pingfan Liu 2025-05-29  280  
536de0ba3b982c Pingfan Liu 2025-05-29  281  static int __init kexec_bpf_prog_run_init(void)
536de0ba3b982c Pingfan Liu 2025-05-29  282  {
536de0ba3b982c Pingfan Liu 2025-05-29 @283  	return register_btf_fmodret_id_set(&kexec_modify_return_set);
536de0ba3b982c Pingfan Liu 2025-05-29  284  }
536de0ba3b982c Pingfan Liu 2025-05-29  285  late_initcall(kexec_bpf_prog_run_init);
536de0ba3b982c Pingfan Liu 2025-05-29  286  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

