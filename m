Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F4AC5AD49
	for <kexec@archiver.kernel.org>; Thu, 29 May 2025 12:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kCrAtG8Cc8Fj6pxkxSj8yUWGpvKhU5ppzUUQdwV/7aw=; b=SHWpFRqpazvusXNze0yk3jrL0M
	JJBTrK/TXfoEaVTSar70827/lW0Geovsi/Qmfn0GStUXQhoC+yiysPBN/kpMRYRj1U+neOrP17C9o
	fVxcQTd+YEjsp3lzqzjfgKbl8sfPahbbWoRZIAJ16U/lt4PshmxPdegqoLa/u/spxmyE+vM40W+I+
	VncI29fv6CYmt6MgHuHY/w3T+pCdtNIQfSOzqUY7lzSqWJKqy3tYmMj3wj5ncwN0ppbRjFCodtOYd
	TJhd6z7DKAA5Epx8nlX8FrOVLHFD10GXl3dn62rt8+aVB23954mw4u6nIKMkWJgeMQL1gQU0EnUP5
	b/f6SO2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKcd9-0000000FlUr-2AzS;
	Thu, 29 May 2025 12:45:07 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKbl6-0000000Fg6z-2II3
	for kexec@lists.infradead.org;
	Thu, 29 May 2025 11:49:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748519357; x=1780055357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H/g6G0UUP2aDkMTBwJX39GplxH+iRsfNl0krSoShu58=;
  b=ID1GwmG301ShEVpdfAVi35O+YSPXBFRDjL3juwBl02St9xPlcOeLIwTZ
   Q73Fp2VKRSw60zPXqrncsj68odfAHAgE01n2gMfXtb+g43lAMTKrecBW/
   Kkwo2Z+0trofTh+UHVP2q05E8t7KhbKdclDTEPVDZ2tVFOq195c8aYALW
   vHiHmbff+qnh3iOsEJK/3vwckvSnkTH2v93jyOCHgy3h/JdQ9186R0+2Y
   i59eaPy2aBY5pjUwd79tYMkJtNqHBiJeT8URRGjZVPwct2Re3CNGGh5QA
   yQ5jCX6mK11Fhnduoiac5YyKkxS7nUVSq1775GDXDDOn2aVvrj3+eFchB
   A==;
X-CSE-ConnectionGUID: GK/83kQzRAuBCTEjw5l0Ew==
X-CSE-MsgGUID: jTjzHIsRRE+OudDB0YINuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50460240"
X-IronPort-AV: E=Sophos;i="6.16,192,1744095600"; 
   d="scan'208";a="50460240"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 04:49:12 -0700
X-CSE-ConnectionGUID: r0azC2JsRlSw+C0pHSivfg==
X-CSE-MsgGUID: go+CU1wGQLCTdOmejBtmWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,192,1744095600"; 
   d="scan'208";a="143880900"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 29 May 2025 04:49:04 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKbks-000We8-1x;
	Thu, 29 May 2025 11:49:02 +0000
Date: Thu, 29 May 2025 19:48:17 +0800
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
Subject: Re: [PATCHv3 3/9] bpf: Introduce bpf_copy_to_kernel() to buffer the
 content from bpf-prog
Message-ID: <202505291926.IPUSqCEj-lkp@intel.com>
References: <20250529041744.16458-4-piliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529041744.16458-4-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_044916_628679_1C88AE96 
X-CRM114-Status: GOOD (  15.69  )
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
[also build test WARNING on bpf-next/master bpf/master arm64/for-next/core linus/master v6.15 next-20250529]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pingfan-Liu/kexec_file-Make-kexec_image_load_default-global-visible/20250529-122124
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250529041744.16458-4-piliu%40redhat.com
patch subject: [PATCHv3 3/9] bpf: Introduce bpf_copy_to_kernel() to buffer the content from bpf-prog
config: riscv-randconfig-001-20250529 (https://download.01.org/0day-ci/archive/20250529/202505291926.IPUSqCEj-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250529/202505291926.IPUSqCEj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505291926.IPUSqCEj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/helpers_carrier.c:74:17: warning: no previous prototype for function 'bpf_mem_range_result_put' [-Wmissing-prototypes]
      74 | __bpf_kfunc int bpf_mem_range_result_put(struct mem_range_result *result)
         |                 ^
   kernel/bpf/helpers_carrier.c:74:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
      74 | __bpf_kfunc int bpf_mem_range_result_put(struct mem_range_result *result)
         |             ^
         |             static 
   kernel/bpf/helpers_carrier.c:88:7: warning: variable 'kmalloc' set but not used [-Wunused-but-set-variable]
      88 |         bool kmalloc;
         |              ^
>> kernel/bpf/helpers_carrier.c:82:17: warning: no previous prototype for function 'bpf_copy_to_kernel' [-Wmissing-prototypes]
      82 | __bpf_kfunc int bpf_copy_to_kernel(const char *name, char *buf, int size)
         |                 ^
   kernel/bpf/helpers_carrier.c:82:13: note: declare 'static' if the function is not intended to be used outside of this translation unit
      82 | __bpf_kfunc int bpf_copy_to_kernel(const char *name, char *buf, int size)
         |             ^
         |             static 
>> kernel/bpf/helpers_carrier.c:165:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     165 |         if (!find_listener(item->str)) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers_carrier.c:174:9: note: uninitialized use occurs here
     174 |         return ret;
         |                ^~~
   kernel/bpf/helpers_carrier.c:165:2: note: remove the 'if' if its condition is always false
     165 |         if (!find_listener(item->str)) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     166 |                 hash_add(str_listeners, &item->node, hash);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     167 |         } else {
         |         ~~~~~~
   kernel/bpf/helpers_carrier.c:149:9: note: initialize the variable 'ret' to silence this warning
     149 |         int ret;
         |                ^
         |                 = 0
   4 warnings generated.


vim +/bpf_mem_range_result_put +74 kernel/bpf/helpers_carrier.c

    73	
  > 74	__bpf_kfunc int bpf_mem_range_result_put(struct mem_range_result *result)
    75	{
    76		return mem_range_result_put(result);
    77	}
    78	
    79	/*
    80	 * Cache the content in @buf into kernel
    81	 */
  > 82	__bpf_kfunc int bpf_copy_to_kernel(const char *name, char *buf, int size)
    83	{
    84		struct mem_range_result *range;
    85		struct mem_cgroup *memcg, *old_memcg;
    86		struct str_listener *item;
    87		resource_handler handler;
    88		bool kmalloc;
    89		char *kbuf;
    90		int id, ret = 0;
    91	
    92		id = srcu_read_lock(&srcu);
    93		item = find_listener(name);
    94		if (!item) {
    95			srcu_read_unlock(&srcu, id);
    96			return -EINVAL;
    97		}
    98		kmalloc = item->kmalloc;
    99		handler = item->handler;
   100		srcu_read_unlock(&srcu, id);
   101		memcg = get_mem_cgroup_from_current();
   102		old_memcg = set_active_memcg(memcg);
   103		range = kmalloc(sizeof(struct mem_range_result), GFP_KERNEL);
   104		if (!range) {
   105			pr_err("fail to allocate mem_range_result\n");
   106			ret = -ENOMEM;
   107			goto err;
   108		}
   109	
   110		kref_init(&range->ref);
   111		if (item->kmalloc)
   112			kbuf = kmalloc(size, GFP_KERNEL | __GFP_ACCOUNT);
   113		else
   114			kbuf = __vmalloc(size, GFP_KERNEL | __GFP_ACCOUNT);
   115		if (!kbuf) {
   116			kfree(range);
   117			ret = -ENOMEM;
   118			goto err;
   119		}
   120		ret = copy_from_kernel_nofault(kbuf, buf, size);
   121		if (unlikely(ret < 0)) {
   122			kfree(range);
   123			if (item->kmalloc)
   124				kfree(kbuf);
   125			else
   126				vfree(kbuf);
   127			ret = -EINVAL;
   128			goto err;
   129		}
   130		range->kmalloc = item->kmalloc;
   131		range->buf = kbuf;
   132		range->buf_sz = size;
   133		range->data_sz = size;
   134		range->memcg = memcg;
   135		mem_cgroup_tryget(memcg);
   136		range->status = 0;
   137		ret = handler(name, range);
   138		mem_range_result_put(range);
   139	err:
   140		set_active_memcg(old_memcg);
   141		mem_cgroup_put(memcg);
   142		return ret;
   143	}
   144	
   145	int register_carrier_listener(struct carrier_listener *listener)
   146	{
   147		struct str_listener *item;
   148		unsigned int hash;
   149		int ret;
   150	
   151		if (!listener->name)
   152			return -EINVAL;
   153		item = kmalloc(sizeof(*item), GFP_KERNEL);
   154		if (!item)
   155			return -ENOMEM;
   156		item->str = kstrdup(listener->name, GFP_KERNEL);
   157		if (!item->str) {
   158			kfree(item);
   159			return -ENOMEM;
   160		}
   161		item->handler = listener->handler;
   162		item->kmalloc = listener->kmalloc;
   163		hash = jhash(item->str, strlen(item->str), 0);
   164		mutex_lock(&str_listeners_mutex);
 > 165		if (!find_listener(item->str)) {
   166			hash_add(str_listeners, &item->node, hash);
   167		} else {
   168			kfree(item->str);
   169			kfree(item);
   170			ret = -EBUSY;
   171		}
   172		mutex_unlock(&str_listeners_mutex);
   173	
   174		return ret;
   175	}
   176	EXPORT_SYMBOL(register_carrier_listener);
   177	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

