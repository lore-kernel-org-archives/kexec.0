Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DF5CA0FE7
	for <kexec@archiver.kernel.org>; Tue, 26 Aug 2025 01:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6LzBm17CJA/inAQl3OaTuXX9bkDclgfUFnowLXnRJC0=; b=lEz9LxoKOMJdqlJNUzSLx2eWb8
	JgIwLdpu97qdQ+bPT7QJ4OXyGI2cZ9tj6Gl0hb5xjPF2hOQmsVAelbmkl/vBMhP6g6yZDJ1hRpN9f
	SpQ4Vzn4DZyRe5q5+qttZjuTmDIPpQJA4zin2VINvJdVGZ7wHp4UmgRGA+0/pUmFe6lOL2tSSpKSb
	5TN5A2LtKWXARQAysuSzjk6wu+IN0UXrxQaO2yhSLIVe9UHBrNH3lJWZQNXzoJKXZLTDGkiA9x4pi
	IgY2uGxBaP5vjfVu9HsKacsFaOo3tNNxzNkJQnPXN9YrUicF8sQO65GcIB/IUv6DTlUMO3Dsu0ztR
	v2MGB5WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqiuR-0000000AJVw-3Aze;
	Tue, 26 Aug 2025 01:55:39 +0000
Received: from mgamail.intel.com ([198.175.65.12])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqiuO-0000000AJVW-3kdG
	for kexec@lists.infradead.org;
	Tue, 26 Aug 2025 01:55:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756173337; x=1787709337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4hB1Ohdsu3e3OwOT9KZUcuu3uI7kLzVe0w65yF8+ZXY=;
  b=KQVHgb1Pw4zchhR7/r59uCTWch8ml0AF3jcYPh48WMGKens4tzUav1Qs
   NnJryiHVrc2lUhbSZFgxbzDG868wxBBwqWxeMvlX01kFTcWM+J/gfSMy0
   PWYJIoopwxSfpN9ZTTt7yDn58NLqhG6FFPxLj4pevMBSP4s4u0qbzko/B
   21Y7WvtXEIHUzJGejk1dEEBbK1D7Ac3hcrnpHJKOpmjV03gdGWWoS31N5
   3xedYFd594JNzxJ7xlF56jFO+ujX1ZUBZHTa22l8A4TMi0xAivEVKG8dr
   ecIL4Tj3nUrLq1ZFVxPT1asxD/i3N80DkjyT0zTJbIgmgY1oYJEUpRilZ
   A==;
X-CSE-ConnectionGUID: zhrf387EQdidiFPnof8xbQ==
X-CSE-MsgGUID: RH74YVp2RyWHYso6+EgnmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="69832649"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69832649"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 18:55:36 -0700
X-CSE-ConnectionGUID: I8sPxLP7SFOCw2ef/84AXw==
X-CSE-MsgGUID: /LdffSHCTy2Cb9DFe9vTrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200396304"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 25 Aug 2025 18:55:33 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqiuJ-000O9f-0S;
	Tue, 26 Aug 2025 01:55:31 +0000
Date: Tue, 26 Aug 2025 09:55:13 +0800
From: kernel test robot <lkp@intel.com>
To: Youling Tang <youling.tang@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>, Yao Zi <ziyao@disroot.org>,
	kexec@lists.infradead.org, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH v2 2/5] LoongArch: Add kexec_file support
Message-ID: <202508260914.Bjz2YQwS-lkp@intel.com>
References: <20250820055700.24344-3-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820055700.24344-3-youling.tang@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_185537_018974_328FA8B8 
X-CRM114-Status: GOOD (  14.13  )
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

Hi Youling,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.17-rc3 next-20250825]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Youling-Tang/LoongArch-Add-struct-loongarch_image_header-for-kernel-image/20250820-140025
base:   linus/master
patch link:    https://lore.kernel.org/r/20250820055700.24344-3-youling.tang%40linux.dev
patch subject: [PATCH v2 2/5] LoongArch: Add kexec_file support
config: loongarch-randconfig-r121-20250826 (https://download.01.org/0day-ci/archive/20250826/202508260914.Bjz2YQwS-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce: (https://download.01.org/0day-ci/archive/20250826/202508260914.Bjz2YQwS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508260914.Bjz2YQwS-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/loongarch/kernel/kexec_efi.c:61:22: sparse: sparse: cast to restricted __le64
   arch/loongarch/kernel/kexec_efi.c:62:23: sparse: sparse: cast to restricted __le64

vim +61 arch/loongarch/kernel/kexec_efi.c

    37	
    38	static void *efi_kexec_load(struct kimage *image,
    39					char *kernel, unsigned long kernel_len,
    40					char *initrd, unsigned long initrd_len,
    41					char *cmdline, unsigned long cmdline_len)
    42	{
    43		struct loongarch_image_header *h;
    44		struct kexec_buf kbuf;
    45		unsigned long text_offset, kernel_segment_number;
    46		struct kexec_segment *kernel_segment;
    47		int ret;
    48	
    49		h = (struct loongarch_image_header *)kernel;
    50		if (!h->image_size)
    51			return ERR_PTR(-EINVAL);
    52	
    53		/* Load the kernel */
    54		kbuf.image = image;
    55		kbuf.buf_max = ULONG_MAX;
    56		kbuf.top_down = false;
    57	
    58		kbuf.buffer = kernel;
    59		kbuf.bufsz = kernel_len;
    60		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
  > 61		kbuf.memsz = le64_to_cpu(h->image_size);
    62		text_offset = le64_to_cpu(h->text_offset);
    63		kbuf.buf_min = text_offset;
    64		kbuf.buf_align = SZ_2M;
    65	
    66		kernel_segment_number = image->nr_segments;
    67	
    68		/*
    69		 * The location of the kernel segment may make it impossible to satisfy
    70		 * the other segment requirements, so we try repeatedly to find a
    71		 * location that will work.
    72		 */
    73		while ((ret = kexec_add_buffer(&kbuf)) == 0) {
    74			/* Try to load additional data */
    75			kernel_segment = &image->segment[kernel_segment_number];
    76			ret = load_other_segments(image, kernel_segment->mem,
    77						  kernel_segment->memsz, initrd,
    78						  initrd_len, cmdline, cmdline_len);
    79			if (!ret)
    80				break;
    81	
    82			/*
    83			 * We couldn't find space for the other segments; erase the
    84			 * kernel segment and try the next available hole.
    85			 */
    86			image->nr_segments -= 1;
    87			kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
    88			kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
    89		}
    90	
    91		if (ret) {
    92			pr_err("Could not find any suitable kernel location!");
    93			return ERR_PTR(ret);
    94		}
    95	
    96		kernel_segment = &image->segment[kernel_segment_number];
    97	
    98		/* Make sure the second kernel jumps to the correct "kernel_entry". */
    99		image->start = kernel_segment->mem + h->kernel_entry - text_offset;
   100	
   101		kexec_dprintk("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
   102			      kernel_segment->mem, kbuf.bufsz,
   103			      kernel_segment->memsz);
   104	
   105		return NULL;
   106	}
   107	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

