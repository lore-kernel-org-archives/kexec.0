Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85999CA0EF5
	for <kexec@archiver.kernel.org>; Tue, 19 Aug 2025 20:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RzUmwEYUX2Otvu38EhlbxtKO/chP2XGZHBpqa0NPilk=; b=F6mTijPQxw8OWpK6IBeWAKSASG
	TVxWKYsF25lWzuMCwjuEtZVPby0IUnDNHnlWQqkySzNjRoNHcLyNDyahNCGT9Jgkg05hf/+rhUpe0
	msl4M6k0h2M8iXGzTZfj/sonp1frJHG9q52ojx4psWMgyjjBFQSQPj8Xj8rM5L5WdxB8pyqyIePsf
	0Sii8jCv0XMNsXVSa3aNIJpWbP5EWCDszA5WLcELPL1IkjWm3Gjb9VmW7YupYkoU7ZuyFE9LBVID7
	ECbLKHSZm5za97ZCKd0OO9FJc/Q220Aob31EZb+WVNF0m/YDCcDwXBXdNoySCAiy5rU0nubpLkeTW
	rDx9Vufw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoTAM-0000000BYmj-2T5H;
	Tue, 19 Aug 2025 20:42:46 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoQzY-0000000BHZK-1ux6;
	Tue, 19 Aug 2025 18:23:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755627808; x=1787163808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X6TNDKntPbZtJQzM/AErcLByk3qrqJsaEa3eWLo9xcY=;
  b=DBOllamKluLZ9vuhvhx/HXTQxQjkRq3B8ElA9BZEUk89tUVLSezDOhjy
   2ThZl7Ddxg4NZRiDQGfMAkYgqlFUZag/2jLelTotIl1lj4WyU9+dhNGRw
   4VyFs1FES1W93MqR6rQrTFhbWUDznhF5pCQgyOhQQhM26M9ENiw1he21b
   vKCR0QDLiGYZZh1H1feuPioMgS5aHDxZzrd0iRoJkO3RzkIgsHrDtm9II
   3WVsLIhaeWeK294c6RyDh+lTOP7ayBYtdVkGTnPNlE/gJkIxyceHyFnn3
   /9FRzBqpON7NBeWz1GNIqSBiAlGbqDVeu2vF83vPmxbJ/CjOI9RnmYiUw
   A==;
X-CSE-ConnectionGUID: mwCohHzDTL6eqGuK3MhDWQ==
X-CSE-MsgGUID: DVJfjYnYSy+75vf0NyZv8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57810841"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57810841"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 11:23:28 -0700
X-CSE-ConnectionGUID: JDvgk7qFQq2x4WO42Pd+VA==
X-CSE-MsgGUID: uvCyzmnMS4WkH1iDNjxp4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167874532"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 19 Aug 2025 11:23:22 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uoQzP-000HG3-1M;
	Tue, 19 Aug 2025 18:23:19 +0000
Date: Wed, 20 Aug 2025 02:23:12 +0800
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
	kexec@lists.infradead.org, bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org
Subject: Re: [PATCHv5 10/12] arm64/kexec: Add PE image format support
Message-ID: <202508200205.qEn1adEu-lkp@intel.com>
References: <20250819012428.6217-11-piliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819012428.6217-11-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_112328_508909_973A7517 
X-CRM114-Status: GOOD (  11.19  )
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

[auto build test ERROR on c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9]

url:    https://github.com/intel-lab-lkp/linux/commits/Pingfan-Liu/kexec_file-Make-kexec_image_load_default-global-visible/20250819-093420
base:   c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
patch link:    https://lore.kernel.org/r/20250819012428.6217-11-piliu%40redhat.com
patch subject: [PATCHv5 10/12] arm64/kexec: Add PE image format support
config: arm64-randconfig-001-20250819 (https://download.01.org/0day-ci/archive/20250820/202508200205.qEn1adEu-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250820/202508200205.qEn1adEu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508200205.qEn1adEu-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h:6,
                    from kernel/kexec_pe_image.c:25:
   tools/lib/bpf/skel_internal.h: In function 'skel_finalize_map_data':
   tools/lib/bpf/skel_internal.h:155:15: error: implicit declaration of function 'bpf_map_get'; did you mean 'bpf_map_put'? [-Wimplicit-function-declaration]
     155 |         map = bpf_map_get(fd);
         |               ^~~~~~~~~~~
         |               bpf_map_put
>> tools/lib/bpf/skel_internal.h:155:13: error: assignment to 'struct bpf_map *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     155 |         map = bpf_map_get(fd);
         |             ^
   kernel/kexec_pe_image.c: In function 'kexec_bpf_prog_run_init':
   kernel/kexec_pe_image.c:267:16: error: implicit declaration of function 'register_btf_fmodret_id_set'; did you mean 'register_btf_kfunc_id_set'? [-Wimplicit-function-declaration]
     267 |         return register_btf_fmodret_id_set(&kexec_modify_return_set);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                register_btf_kfunc_id_set
   kernel/kexec_pe_image.c: In function 'pe_image_load':
   kernel/kexec_pe_image.c:312:44: warning: variable 'cmdline_sz' set but not used [-Wunused-but-set-variable]
     312 |         unsigned long linux_sz, initrd_sz, cmdline_sz, bpf_sz;
         |                                            ^~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for KEXEC_PE_IMAGE
   Depends on [n]: KEXEC_FILE [=y] && DEBUG_INFO_BTF [=n] && BPF_SYSCALL [=n]
   Selected by [y]:
   - ARCH_SELECTS_KEXEC_FILE [=y] && KEXEC_FILE [=y]


vim +155 tools/lib/bpf/skel_internal.h

67234743736a6a Alexei Starovoitov 2021-05-13  143  
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09  144  static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int flags, int fd)
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09  145  {
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09  146  	struct bpf_map *map;
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09  147  	void *addr = NULL;
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09  148  
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09  149  	kvfree((void *) (long) *init_val);
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09  150  	*init_val = ~0ULL;
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09  151  
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09  152  	/* At this point bpf_load_and_run() finished without error and
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09  153  	 * 'fd' is a valid bpf map FD. All sanity checks below should succeed.
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09  154  	 */
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09 @155  	map = bpf_map_get(fd);
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09  156  	if (IS_ERR(map))
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09  157  		return NULL;
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09  158  	if (map->map_type != BPF_MAP_TYPE_ARRAY)
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09  159  		goto out;
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09  160  	addr = ((struct bpf_array *)map)->value;
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09  161  	/* the addr stays valid, since FD is not closed */
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09  162  out:
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09  163  	bpf_map_put(map);
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09  164  	return addr;
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09  165  }
6fe65f1b4db3ff Alexei Starovoitov 2022-02-09  166  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

