Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C631C83F1A
	for <kexec@archiver.kernel.org>; Wed, 23 Jul 2025 00:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H/yVOebopCKz7Q2ng99Hh4CSN57XYcgYqrFuQZ+lEa4=; b=WOa3kSZi7Bnl8BcfPcdu29AJPV
	hSYvcoPJwnUDgD4FN5BqZWlDERYhNKEvGFc9TbEuMqt3eAGhvftBxhXXSzUGw6mquYTh31VzfbKRz
	0vMv1roHtR2tsjIW9Lgqvcu4dG6R5ghkqke63MqWd4hwLP/YgIDw19E0aAn3ubNshHUIOyHUUpLxs
	3WNAd1yOphH543SVX7gDC3x6KDkzHHbAreTY5+nRfPoNhnDr+JN7Rwt9pPts2iwBOoqgiXh+NKR5j
	9V3f/bXYnP2m6J07oSI9JLtQtS1VRLfUgdKfsPrbTla0rkbZf7pON+J00kTOIj50FZPYIIQlDG9FF
	L3ND9tjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueNbh-00000003jtf-3jTO;
	Wed, 23 Jul 2025 00:45:17 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueNbe-00000003jsp-3HOV
	for kexec@lists.infradead.org;
	Wed, 23 Jul 2025 00:45:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753231515; x=1784767515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m426WV1lDKEaPLng1dxGfobPDwFUytLJjSu785UlQ7E=;
  b=G5wgyuDqSaiUGMCwmYw6o7r+N16pyi6ipH4l1vo/zrQlIVc3VfvcgiMT
   L2CNE60FEFeHw1+A4EzDff0f2pTM1+5WCpcFDGC/tF6ZpRIw5Q3+fKY+K
   +1Fk8yVIO4Y/jiUMZLCmHE6ggSIcs329fEIdGTTv3JEAqRkRGHW5pY/aE
   d30zx9c/7PYCWSGgJr16ZiqlxziAhmih59MwrIFQNcruOiaL1oGvzx3b2
   4zDIyvubOTZM3j8ymd0z4mY0BGPYHLotY2wMHdk8knRYnemXp/vGi9hW+
   fcH0U1uQzZCmQkZP0mIcoqHaoHNYQ3SgUYf8xq7kkkBcrp5ACNC/AUyC8
   Q==;
X-CSE-ConnectionGUID: Q5yTTSYoS4G5i39bzNzdig==
X-CSE-MsgGUID: QlQbY23NTamdVLKDrofL/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55348825"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55348825"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 17:45:11 -0700
X-CSE-ConnectionGUID: 706r2HHuRv625sILRACQ3Q==
X-CSE-MsgGUID: Uv2GzgKdTpedaycps3ofeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159038253"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 22 Jul 2025 17:45:04 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueNbR-000IpT-1V;
	Wed, 23 Jul 2025 00:45:01 +0000
Date: Wed, 23 Jul 2025 08:44:58 +0800
From: kernel test robot <lkp@intel.com>
To: Pingfan Liu <piliu@redhat.com>, bpf@vger.kernel.org
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
	kexec@lists.infradead.org, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCHv4 04/12] bpf: Introduce decompressor kfunc
Message-ID: <202507230813.M1tmyREU-lkp@intel.com>
References: <20250722020319.5837-5-piliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722020319.5837-5-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250722_174514_895250_89D741C3 
X-CRM114-Status: GOOD (  10.21  )
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
[also build test WARNING on bpf/master arm64/for-next/core linus/master v6.16-rc7]
[cannot apply to bpf-next/master next-20250722]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pingfan-Liu/kexec_file-Make-kexec_image_load_default-global-visible/20250722-100843
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250722020319.5837-5-piliu%40redhat.com
patch subject: [PATCHv4 04/12] bpf: Introduce decompressor kfunc
config: arm-randconfig-004-20250723 (https://download.01.org/0day-ci/archive/20250723/202507230813.M1tmyREU-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 853c343b45b3e83cc5eeef5a52fc8cc9d8a09252)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250723/202507230813.M1tmyREU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507230813.M1tmyREU-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: bpf_decompress+0xbc (section: .text.bpf_decompress) -> decompress_method (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

