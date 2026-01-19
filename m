Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E01CA5FFF
	for <kexec@archiver.kernel.org>; Mon, 19 Jan 2026 08:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bKJijYo++8zcbEKhMHwvqGK3GQboq6DGUl0Qp8eOuZ4=; b=Cn4dc8EVEIKJfTdwdZbMkxwroe
	uAstx1x2GcuaG8FPn3vuRsglxVeAPnoYTBkiPVuAs4gQx+Upn8pAweBfEhnXszTO1RUDLOPge9O77
	U+AyKR2oE0nqZQSDKDxBC4BgVyc6M/B9vLBR7nUQWJoeBHB+qaH/y2HGhOn3WxQt6UssGPZc3eGb0
	MiW1XSuaU4HF/tA0gcWcNYZcbZjfpWZmnZJaGl4kwJUF1ICdaFz1mqBuQKxUp9a4B4096C7bamYzV
	BhoLJrFkjfesGlLxAjQtPm17Jl1TrBCdZmIi+Vz3iCRUekQH7K8WVWtAaKSffoIaJ+r3TIL3yVWGi
	OQzZlhXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhkYt-00000001YRR-490W;
	Mon, 19 Jan 2026 08:24:35 +0000
Received: from mgamail.intel.com ([192.198.163.18])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhkYl-00000001YPL-27cf;
	Mon, 19 Jan 2026 08:24:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768811068; x=1800347068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3UoClJcJDW2uoWng1yw1//FZOmo69ZVnggpsjcysDfk=;
  b=UvhcB2TI6UTD1Jhf0M6lvgRbZDb/cVyiE87WvM13Ehwkk7bqb8jMOfcL
   bjP2vjLVHPqcE4koG4dh0tBHY05JlEOYqarlC2cNDiwh3l8JfGTP7YpKO
   lKpRURiv1wShUOP82D39tiqrri2WYpz5BuXF9LetRtUC5bRsCbTB7HLaa
   a8+wmGQcNMWuTX+gcKwx6VgN19kbuZHr7YuTZ/fWr8SilCvttnfjZzMiL
   1GqXmF3YMvCDHWriowPc0PZ8M8UhmmtnDx7E+ipxOcjoDftAU6S2nUZNS
   105qLFsuxYwHgzcO1Jfm5HGo7XKtHkLiegpgowvCTqjpjj+0QgAUba4ZY
   w==;
X-CSE-ConnectionGUID: F4N5sY8+RzC4tIwrfGONiw==
X-CSE-MsgGUID: kKIFfQt9QfSjGhEtoa11kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="69217488"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="69217488"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 00:24:25 -0800
X-CSE-ConnectionGUID: 6JrKYD8FQiOuYUMvH+ySjQ==
X-CSE-MsgGUID: qEu6BI5JSmWE3xRAdt9Yxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="228742759"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 19 Jan 2026 00:24:18 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vhkYa-00000000Naz-080r;
	Mon, 19 Jan 2026 08:24:16 +0000
Date: Mon, 19 Jan 2026 16:23:31 +0800
From: kernel test robot <lkp@intel.com>
To: Pingfan Liu <piliu@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Pingfan Liu <piliu@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
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
	kexec@lists.infradead.org, bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 11/13] arm64/kexec: Select KEXEC_BPF to support
 UEFI-style kernel image
Message-ID: <202601191626.CUD61tIS-lkp@intel.com>
References: <20260119032424.10781-12-piliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119032424.10781-12-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260119_002427_554614_A077F751 
X-CRM114-Status: GOOD (  12.61  )
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/net]
[also build test WARNING on bpf-next/master bpf/master akpm-mm/mm-nonmm-unstable linus/master v6.19-rc6 next-20260116]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pingfan-Liu/bpf-Introduce-kfuncs-to-parser-buffer-content/20260119-112939
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20260119032424.10781-12-piliu%40redhat.com
patch subject: [PATCHv6 11/13] arm64/kexec: Select KEXEC_BPF to support UEFI-style kernel image
config: arm64-randconfig-004-20260119 (https://download.01.org/0day-ci/archive/20260119/202601191626.CUD61tIS-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260119/202601191626.CUD61tIS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601191626.CUD61tIS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/kexec_bpf_loader.c:103:22: warning: unknown attribute 'optimize' ignored [-Wunknown-attributes]
     103 | __attribute__((used, optimize("O0"))) void kexec_image_parser_anchor(
         |                      ^~~~~~~~~~~~~~
   1 warning generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for KEXEC_BPF
   Depends on [n]: KEXEC_FILE [=y] && DEBUG_INFO_BTF [=y] && BPF_SYSCALL [=y] && KEEP_DECOMPRESSOR [=n]
   Selected by [y]:
   - ARCH_SELECTS_KEXEC_FILE [=y] && KEXEC_FILE [=y] && DEBUG_INFO_BTF [=y] && BPF_SYSCALL [=y]


vim +/optimize +103 kernel/kexec_bpf_loader.c

e683ae405ea0458 Pingfan Liu 2026-01-19   93  
e683ae405ea0458 Pingfan Liu 2026-01-19   94  void kexec_image_parser_anchor(struct kexec_context *context,
e683ae405ea0458 Pingfan Liu 2026-01-19   95  		unsigned long parser_id);
e683ae405ea0458 Pingfan Liu 2026-01-19   96  
e683ae405ea0458 Pingfan Liu 2026-01-19   97  /*
e683ae405ea0458 Pingfan Liu 2026-01-19   98   * optimize("O0") prevents inline, compiler constant propagation
e683ae405ea0458 Pingfan Liu 2026-01-19   99   *
e683ae405ea0458 Pingfan Liu 2026-01-19  100   * Let bpf be the program context pointer so that it will not be spilled into
e683ae405ea0458 Pingfan Liu 2026-01-19  101   * stack.
e683ae405ea0458 Pingfan Liu 2026-01-19  102   */
e683ae405ea0458 Pingfan Liu 2026-01-19 @103  __attribute__((used, optimize("O0"))) void kexec_image_parser_anchor(
e683ae405ea0458 Pingfan Liu 2026-01-19  104  		struct kexec_context *context,
e683ae405ea0458 Pingfan Liu 2026-01-19  105  		unsigned long parser_id)
e683ae405ea0458 Pingfan Liu 2026-01-19  106  {
e683ae405ea0458 Pingfan Liu 2026-01-19  107  	/*
e683ae405ea0458 Pingfan Liu 2026-01-19  108  	 * To prevent linker from Identical Code Folding (ICF) with kexec_image_parser_anchor,
e683ae405ea0458 Pingfan Liu 2026-01-19  109  	 * making them have different code.
e683ae405ea0458 Pingfan Liu 2026-01-19  110  	 */
e683ae405ea0458 Pingfan Liu 2026-01-19  111  	volatile int dummy = 0;
e683ae405ea0458 Pingfan Liu 2026-01-19  112  
e683ae405ea0458 Pingfan Liu 2026-01-19  113  	dummy += 1;
e683ae405ea0458 Pingfan Liu 2026-01-19  114  }
e683ae405ea0458 Pingfan Liu 2026-01-19  115  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

