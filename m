Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50550EC01C0
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 10:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V/OrNILMm81yMqJLknyha56qtfnrFV9Nb4D2NaSWFUE=; b=lUUSksD8vmIeVEJiPE6mKFByWn
	O8CjDecniE/J8ZOjp0LjpY++B1VocmfHcrpNyR/ufVGoq01g6e/uyvqN8rdATrWBVfEk15IrJU1Lb
	4fMDftvmjMO9DMg5yTNae/kzSOM0VHUQv0a2sPoneqxkCSmnguJISVy1Qz7rz/PX4rVHHpg8izwqo
	I9jxKOaRXLa9ChZ2+gtxHdKnqYoyPbjtrFR3WmWt3p8zgXQbvA20vD7vrgFbD0FjZXUCrhqxaIIf4
	tVlqOEwZZnz8PHBbgqFknK5lyz2ExAehr4pi4bXICSUFLfay8YESFdWNVZ0mkQHNqAtXxrrDAUoA0
	Fz3y2kTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4cOK-0000000GUKm-3fu4;
	Mon, 23 Mar 2026 10:20:12 +0000
Received: from mgamail.intel.com ([192.198.163.18])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4cOI-0000000GUIe-0gaZ
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 10:20:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774261210; x=1805797210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yXatQ4JO8B9DvDgSV+G8n5ZDZn06+ptILBIxSJt93bs=;
  b=QfdFSlsaoaWimRTzbRAqMF8sPkL2cEJdWB87MfAptZY+yQqpIbDQWFNZ
   UFigQwRo/gd7EY765S/WMz5D/5AMeE8j8ovw6QI92NGpjrUBLMjC3/CiY
   x1jrQdeK+q5OsqkuhE+v66VYZFx/3p8BueX7U3Q3QafO/o0XqugC51YzZ
   9z/i3/MPQfaOF5GG+FbyXAkGC1oDo4tg9oD2y5hbv8rXSYz5QM8REYcmm
   WzsKza4HEVg8aOG7L89dEYNusFQS1MoC6PqhMJH3OlmFm9I1pTz3FtwDr
   Fh4jlc6gV0MDlVBmGbJPVFIPNVFnHF4dfEhnB6Xo5wjek2oD1bQck6IqT
   A==;
X-CSE-ConnectionGUID: 5czr0JGjSiS5y9KpXNB+IQ==
X-CSE-MsgGUID: 3iOFteh2SxCIh5PGySBB+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="74433432"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="74433432"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 03:20:07 -0700
X-CSE-ConnectionGUID: sdWJRHdHQlOkec0YBpFIgQ==
X-CSE-MsgGUID: nHQx2jjIRzyJoC4IQ2Koiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="228707869"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 23 Mar 2026 03:20:01 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w4cO6-000000000LJ-0Inl;
	Mon, 23 Mar 2026 10:19:58 +0000
Date: Mon, 23 Mar 2026 18:19:04 +0800
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
	bpf@vger.kernel.org, systemd-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 08/13] kexec_file: Factor out routine to find a symbol
 in ELF
Message-ID: <202603231812.ZGRRlzPe-lkp@intel.com>
References: <20260322014402.8815-9-piliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322014402.8815-9-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_032010_216638_85A204CE 
X-CRM114-Status: GOOD (  11.20  )
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
config: x86_64-randconfig-002-20260323 (https://download.01.org/0day-ci/archive/20260323/202603231812.ZGRRlzPe-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260323/202603231812.ZGRRlzPe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603231812.ZGRRlzPe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/kexec_file.c:1276:23: error: redefinition of 'kexec_purgatory_find_symbol'
    1276 | static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/kexec_file.c:958:23: note: previous definition of 'kexec_purgatory_find_symbol' with type 'const Elf64_Sym *(struct purgatory_info *, const char *)' {aka 'const struct elf64_sym *(struct purgatory_info *, const char *)'}
     958 | static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~


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

