Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFA6C83F27
	for <kexec@archiver.kernel.org>; Tue, 22 Jul 2025 17:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gLbXCw0F2QvZ7bBY7GP88H5v/+ABMtOq6lHh/3EqNic=; b=Dyp3/Ge3HPSnztJsYowUkVE2B/
	tFc/gj9MVyxiMkBpxbDj6RYR3Fh9pHeHoYVyGNfLIoL1G4sycLUnMlFsACjYMtPuEtnPtvpjfWlsx
	D9w4fvxhVfN7yiSEWuptl0GzSBF3998s2wEAZM0E4MY3ywALNx+bOgxwwPAVRRwBr/Sf+j6Lx38B4
	zSbJ/jvNAmv3ZANixLfVqfpZgw3VjY1PUlEfaTCv1+cjXxJhJLXmDuBSsSUyXSaEDlTXoXpQHho+U
	StJvOM5WXGDFCYYE64ewSGZ7Cqx9kqSoh6mn1yFccRsuNo5m1Vyc+K14VCxIWJ1+Ob6dOFhT36eSK
	aug4csFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueGiG-0000000382S-3rA6;
	Tue, 22 Jul 2025 17:23:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueGiF-0000000381f-3Ya4
	for kexec@bombadil.infradead.org;
	Tue, 22 Jul 2025 17:23:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gLbXCw0F2QvZ7bBY7GP88H5v/+ABMtOq6lHh/3EqNic=; b=cyFYZUD85FVFz0142Rx1r6wc2L
	6QruZ2PBcrmmSQl+XFGHmLYDmGrpdP8WfONlBNHI5QsQCDLsNP0jnb27jmFQwnVUBNv3ZmbfiD+BB
	D7LdXpiyf1CBO9Z6aE79N2CIfoESoKu0zu7OLxtpAFxORQ+hF490lSfxGLUyFE+P4i5a7Zi/Im7dE
	3S3cpiX+5iIDhniH21ucG9/hnOZa68vRrq2b8/xFK8rDzrhvKim5u9ua59zzt6pWzPVieNiX25BVA
	8FMuEpPvb38QazAzszdcnyt+Ap8+ZoDbWZuKkjSXuLzHX8ZHvLw/i+NWyD8BItkA1Q16c4690EfMw
	KhWDOzww==;
Received: from mgamail.intel.com ([192.198.163.15])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueGiC-0000000BK5F-0T11
	for kexec@lists.infradead.org;
	Tue, 22 Jul 2025 17:23:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753205012; x=1784741012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8tLBsgDMoKYn/cmEEtG36C5Re6c2A8hBzfa0rJS9qf8=;
  b=a/J4TcnEDdNRiosxpUTEhKzHF9x43e3LuhOxTBROsDH3Ji3CW1Ig5TuP
   kw+Dt16horXr1jwpwiDE279NyV/qcc5aH1xn0b3GE8E7mDK+L81+8aX3m
   nogKye0s+3L+mXfH2WCZE5/2w5hEYmpPepLkzi5gQYeST5nvH6fy9wm8L
   oVgvuiuM+0tk2WmpKZVd+iE/IoikxMXbc29TVR0ezVFtN8pc5kVaheoVj
   rmZlPfcOyr7k92Oqjbxnc3JC8DzHFB8dNV1Tz207cVXb3E60nuxWoNNny
   bYcNsXyW/SaKymEQe/r8t9RtVc2ZPBYrWO2m3vwg8ciHPuBfzWT5waLJe
   A==;
X-CSE-ConnectionGUID: tmLQdlLsR7GmgKJDvxw6dg==
X-CSE-MsgGUID: IL0w0HS2Rk2NnXThGtMzsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55617281"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="55617281"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 10:23:23 -0700
X-CSE-ConnectionGUID: T62YgRhbStu03UHmIKqpvQ==
X-CSE-MsgGUID: vlVplxbJSAyI/3mxscLURw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="158503142"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 22 Jul 2025 10:23:17 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueGhv-000IaD-1j;
	Tue, 22 Jul 2025 17:23:15 +0000
Date: Wed, 23 Jul 2025 01:22:56 +0800
From: kernel test robot <lkp@intel.com>
To: Pingfan Liu <piliu@redhat.com>, kexec@lists.infradead.org
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
	bpf@vger.kernel.org
Subject: Re: [PATCHv4 08/12] kexec: Factor out routine to find a symbol in ELF
Message-ID: <202507230016.NQ1WXqwG-lkp@intel.com>
References: <20250722020319.5837-9-piliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722020319.5837-9-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250722_182332_659415_4ACFB963 
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

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]
[also build test ERROR on bpf/master arm64/for-next/core linus/master v6.16-rc7]
[cannot apply to bpf-next/master next-20250722]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pingfan-Liu/kexec_file-Make-kexec_image_load_default-global-visible/20250722-100843
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20250722020319.5837-9-piliu%40redhat.com
patch subject: [PATCHv4 08/12] kexec: Factor out routine to find a symbol in ELF
config: x86_64-buildonly-randconfig-006-20250722 (https://download.01.org/0day-ci/archive/20250723/202507230016.NQ1WXqwG-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250723/202507230016.NQ1WXqwG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507230016.NQ1WXqwG-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/crash_dump.h:5,
                    from drivers/of/fdt.c:11:
>> include/linux/kexec.h:544:7: error: unknown type name 'Elf_Sym'
     544 | const Elf_Sym *elf_find_symbol(const Elf_Ehdr *ehdr, const char *name);
         |       ^~~~~~~
>> include/linux/kexec.h:544:38: error: unknown type name 'Elf_Ehdr'
     544 | const Elf_Sym *elf_find_symbol(const Elf_Ehdr *ehdr, const char *name);
         |                                      ^~~~~~~~


vim +/Elf_Sym +544 include/linux/kexec.h

   542	
   543	#if defined(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) || defined(CONFIG_KEXEC_PE_IMAGE)
 > 544	const Elf_Sym *elf_find_symbol(const Elf_Ehdr *ehdr, const char *name);
   545	#endif
   546	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

