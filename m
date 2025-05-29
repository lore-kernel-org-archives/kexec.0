Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1216C5B549
	for <kexec@archiver.kernel.org>; Thu, 29 May 2025 13:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AUjkhu3+yN/wubdzqZgJlzUByhVL3tldr6sR8fCw7Xw=; b=Z5M3DogRuYloe0RvdrSQcgqgrX
	zOqABerA8J5u5O8o4IeSO2tW3oXccl6rQlnBFlRZVYIyvQI/TDSDTp+McMLU+UIT61kKtX7O6NvaD
	s3LpGIv3AahOYyLkNvv/BRsgA7jK9qasGZTFvL7/e/7Ns46yKUI/HMvpJYzj03UzJVgyGyTnGFcga
	msEE20Ho2Fy/ixjwIAD2UvSVYX95oa/xKpsRO+1fD3ko7a7NFBrAE5/dZcJX2ZI6nvwg6Dny7UQuf
	Wz2ixAmm9dhmkD39Amx8nIdZ9rz8ft9bXY1pjZ0QDfldNKn4d4khTNnqLgPA6bfD8GlCpEYjj5mn8
	jYisk3Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKcrq-0000000Fo8S-11JK;
	Thu, 29 May 2025 13:00:18 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKcQl-0000000Fjqd-3ElH
	for kexec@lists.infradead.org;
	Thu, 29 May 2025 12:32:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748521939; x=1780057939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5tczT80Nk/8Jz8ap+tBGVsKedTDSvW5dC/vIjC8PZ00=;
  b=ipIyWenhoJgByabIMmJv/ZbpHOY3H8vrWKsN6CGzWJwgp2eTXer3Pw3/
   jn7yUGaNcHnpJCC/l6DzCf1TrThxU6I6OVW3yVjx3KNThfm0RLi3gWzzH
   mufDCo1N85s+hHCGDKFxRfyRBUU5gYm//aBX5Y1u3XMa0+qL1mGeZZwjJ
   1/SCtPH4CzUirMX0dwQ7fjuQYKLTZmqsu335encRfbKgTzTFxi/Cov7wB
   /Dw5N+o2AbKDL8cQoJSd+k8V12UFVRnYyrs/k6u8qZiAc4+Yg9xzLxLNP
   +urNBG9vNflHAYnNsb9zU9MAVig38kZ1u8Ty/7uEN05Z6aU29rHaLXzo2
   g==;
X-CSE-ConnectionGUID: QGP8iT4gRpyc1/s8nUs7IA==
X-CSE-MsgGUID: YBp0mEesR4qgf8qPJ8teKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="75970818"
X-IronPort-AV: E=Sophos;i="6.16,192,1744095600"; 
   d="scan'208";a="75970818"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 05:32:14 -0700
X-CSE-ConnectionGUID: WkcTx/cnS2OQsxC2aU7ELg==
X-CSE-MsgGUID: fo1jR2L4RsWuDT0fS/uhww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,192,1744095600"; 
   d="scan'208";a="143526206"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 29 May 2025 05:32:09 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKcQY-000Wfy-1Y;
	Thu, 29 May 2025 12:32:06 +0000
Date: Thu, 29 May 2025 20:31:28 +0800
From: kernel test robot <lkp@intel.com>
To: Pingfan Liu <piliu@redhat.com>, bpf@vger.kernel.org
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
	kexec@lists.infradead.org, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCHv3 4/9] bpf: Introduce decompressor kfunc
Message-ID: <202505292046.qJy6UU9z-lkp@intel.com>
References: <20250529041744.16458-5-piliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529041744.16458-5-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_053219_821583_BB11EEC9 
X-CRM114-Status: GOOD (  10.55  )
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
[also build test WARNING on bpf/master arm64/for-next/core v6.15]
[cannot apply to bpf-next/master linus/master next-20250529]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pingfan-Liu/kexec_file-Make-kexec_image_load_default-global-visible/20250529-122124
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250529041744.16458-5-piliu%40redhat.com
patch subject: [PATCHv3 4/9] bpf: Introduce decompressor kfunc
config: s390-randconfig-002-20250529 (https://download.01.org/0day-ci/archive/20250529/202505292046.qJy6UU9z-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250529/202505292046.qJy6UU9z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505292046.qJy6UU9z-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: bpf_decompress+0x36e (section: .text) -> decompress_method (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

