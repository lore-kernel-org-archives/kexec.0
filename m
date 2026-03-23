Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E09D58CDC
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 07:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LVQsD2O0qghSgK+rqUALDAR7d8NzlSIi53UHyplYAF8=; b=NbNXCoB+pbup7+6VnsDj6hyZ4t
	KC61eUgsuPNKWH/3sowwFhIqPVanHKsi+27wJU8ZH2AlsKOvASbV8luNJHQeqDHN1lPCq1AJMciML
	rditSyOTH6bIo100wbvH3uh23+SS+g14bpQOZDvmj7VMHfgpuyZPfgR/Cvl0b+r0inL2xHrE79hdk
	1y5tCiZraU7Fnr7D/rcSurmMLy91JNNDoRp07fNWUhqyLiiFuP6FAYjB3jG11BMbJeC57xzglr1Mw
	Sz6l7rPY3jBXNHGPKXHX4cB8iB+2w/Xo0ZkZYKUAMFtcB1Wrc8zp3va5+BKHL6jmQbvxKXGI+SGUI
	2mLQdbFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ZOW-0000000GANQ-06u8;
	Mon, 23 Mar 2026 07:08:12 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ZOT-0000000GAMr-0KEH
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 07:08:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774249689; x=1805785689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RCpk62n3AYbYiVU8MLmHxHTP0ibiZw4A4+CXyOIQstk=;
  b=TBIe6ECBaG7YbtyvMgl4zH9374wdggctey17zDE9OTHh5Kpzhki3sSEX
   CLMJ5WSeTb7Uudlb2LdyTGXjAlr0DU2HjW0mcl0mv7maXIhuy8/e2Xoao
   it3g5ddyMJVWaZoOhqc6Q5D83K83RvQV5GldDMsyuqDiBFDJNoWtTL5oR
   oj9laSEUTAXSCBD6cVR+RYsqYi5MJ269SV8x45NuuS6Rih5TwwMwOBAfK
   820Z/6d/x4GBp6N366mp/yf6Er8U2v8rlj6/siuEK7GWWKp+93GrXyqp1
   lhRQK1ofy1Y+oGKyPs5MPN8DhIQaf+NZre3vB+hiwaDqJQsobGXXezdJ4
   w==;
X-CSE-ConnectionGUID: hJ17tCaAShmQ7xqT2IgUCQ==
X-CSE-MsgGUID: QQ1DW0ESSeqdNDgW29BmIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="77851861"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="77851861"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 00:08:08 -0700
X-CSE-ConnectionGUID: kRJ1g0y0QDaExnkxhsB7Kg==
X-CSE-MsgGUID: badPk84/Tv+lneKFJzNajg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="219142609"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa006.fm.intel.com with ESMTP; 23 Mar 2026 00:08:03 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w4ZOK-000000006Zt-2URK;
	Mon, 23 Mar 2026 07:08:00 +0000
Date: Mon, 23 Mar 2026 08:07:28 +0100
From: kernel test robot <lkp@intel.com>
To: Pingfan Liu <piliu@redhat.com>, kexec@lists.infradead.org
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
	bpf@vger.kernel.org, systemd-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 08/13] kexec_file: Factor out routine to find a symbol
 in ELF
Message-ID: <202603230851.qOD27RaS-lkp@intel.com>
References: <20260322014402.8815-9-piliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322014402.8815-9-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_000809_168676_3BB124BD 
X-CRM114-Status: GOOD (  10.87  )
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
[also build test ERROR on bpf-next/master bpf/master akpm-mm/mm-nonmm-unstable linus/master v7.0-rc5 next-20260320]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pingfan-Liu/bpf-Introduce-kfuncs-to-parser-buffer-content/20260323-084500
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20260322014402.8815-9-piliu%40redhat.com
patch subject: [PATCHv7 08/13] kexec_file: Factor out routine to find a symbol in ELF
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260323/202603230851.qOD27RaS-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260323/202603230851.qOD27RaS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603230851.qOD27RaS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/kexec_file.c:1276:23: error: redefinition of 'kexec_purgatory_find_symbol'
    1276 | static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
         |                       ^
   kernel/kexec_file.c:958:23: note: previous definition is here
     958 | static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
         |                       ^
   1 error generated.


vim +/kexec_purgatory_find_symbol +1276 kernel/kexec_file.c

  1268	
  1269	/*
  1270	 * kexec_purgatory_find_symbol - find a symbol in the purgatory
  1271	 * @pi:		Purgatory to search in.
  1272	 * @name:	Name of the symbol.
  1273	 *
  1274	 * Return: pointer to symbol in read-only symtab on success, NULL on error.
  1275	 */
> 1276	static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
  1277							  const char *name)
  1278	{
  1279		if (!pi->ehdr)
  1280			return NULL;
  1281	
  1282		return elf_find_symbol(pi->ehdr, name);
  1283	}
  1284	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

