Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DCFC5ACB2
	for <kexec@archiver.kernel.org>; Wed, 15 Nov 2023 21:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5eq6IQ1DHubxJWEaeuplD5J8PNOjI4G0OrsDT6ZBX/E=; b=l0KqNt8Wkm50K6
	8yPnuTylOyju686RHh2bdRSpV/cIJmt7/SFAlc79IXmKLZIvgX0zWwgRGPsNeAmtQo2vUw2dnxuiP
	iO0I2uU/1WZIlob9hTiSpx8z3NpT0k710VuYV4ZfDm0DvpODmIqkTqfNALyC15o3/FDO2cEfd/DpB
	LErgymVr2LaFj9LloQnRtr6KaZzbYXHDSRU91B81SCT5tIzZb6PHOIaL7zuTNDiOOfLOHnHnxOptx
	ctNRHhTWieJZhI7nsxvjO22nYjra1ybrKn+fLcwHJjMgbOf1yuJ/786PXJV8FbBcTlkOwF+Ik1EXp
	CUUOCYNMmbEVuGj6r8/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3Nu2-001oY1-15;
	Wed, 15 Nov 2023 21:58:30 +0000
Received: from mgamail.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3Ntz-001oWw-1O;
	Wed, 15 Nov 2023 21:58:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700085507; x=1731621507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Td6rqxMaLlzRdRD/IYOyHFFg+IU/kkNOBGZuEnKora0=;
  b=WZtVEQDGoNqPQSXZOOLH8A9cgVRqbA+dPqy5xUIKmPZXO2Eb+X2yPYuq
   2sJtcUEoPrf/fw2PW99fkQAlj+h95El8JQRCpppKHey+ljoD+Guorzqke
   asx/SrUxZIrGZNQa/1HhWHjnujgewl8TYpmJ7KC52IxMf4hYhDC36mRGt
   Mmd6Z4UXCnilvzH9P0m/sru41Lfyagwh3amteHh4YaYyGup8VbrQFSLee
   lIwxaknmRWIYD0zBr7T2XcMZItC7CyefKc23pPzqD/uUAzXkG0dhDO3PT
   Ep+7f/E1w85SnQQhT4+5YguyAQyx2PmAsDO6Kvo8N+U+qQLcBcMiiXLQn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="390756840"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="390756840"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 13:58:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="882525588"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="882525588"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 15 Nov 2023 13:58:24 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r3Ntu-0000t2-0q;
	Wed, 15 Nov 2023 21:58:22 +0000
Date: Thu, 16 Nov 2023 05:57:47 +0800
From: kernel test robot <lkp@intel.com>
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kexec@lists.infradead.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-parisc@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 2/7] kexec_file: print out debugging message if required
Message-ID: <202311160502.jnu7b8KF-lkp@intel.com>
References: <20231114153253.241262-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231114153253.241262-3-bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231115_135827_487169_AD44AB8F 
X-CRM114-Status: GOOD (  17.26  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Baoquan,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on tip/x86/core powerpc/next powerpc/fixes linus/master v6.7-rc1 next-20231115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/kexec_file-add-kexec_file-flag-to-control-debug-printing/20231114-234003
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20231114153253.241262-3-bhe%40redhat.com
patch subject: [PATCH 2/7] kexec_file: print out debugging message if required
config: x86_64-randconfig-002-20231115 (https://download.01.org/0day-ci/archive/20231116/202311160502.jnu7b8KF-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160502.jnu7b8KF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160502.jnu7b8KF-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/crash_core.c: In function 'crash_prepare_elf64_headers':
>> kernel/crash_core.c:412:17: error: implicit declaration of function 'kexec_dprintk'; did you mean '_dev_printk'? [-Werror=implicit-function-declaration]
     412 |                 kexec_dprintk("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, "
         |                 ^~~~~~~~~~~~~
         |                 _dev_printk
   cc1: some warnings being treated as errors


vim +412 kernel/crash_core.c

   323	
   324	int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
   325				  void **addr, unsigned long *sz)
   326	{
   327		Elf64_Ehdr *ehdr;
   328		Elf64_Phdr *phdr;
   329		unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
   330		unsigned char *buf;
   331		unsigned int cpu, i;
   332		unsigned long long notes_addr;
   333		unsigned long mstart, mend;
   334	
   335		/* extra phdr for vmcoreinfo ELF note */
   336		nr_phdr = nr_cpus + 1;
   337		nr_phdr += mem->nr_ranges;
   338	
   339		/*
   340		 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
   341		 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
   342		 * I think this is required by tools like gdb. So same physical
   343		 * memory will be mapped in two ELF headers. One will contain kernel
   344		 * text virtual addresses and other will have __va(physical) addresses.
   345		 */
   346	
   347		nr_phdr++;
   348		elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
   349		elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
   350	
   351		buf = vzalloc(elf_sz);
   352		if (!buf)
   353			return -ENOMEM;
   354	
   355		ehdr = (Elf64_Ehdr *)buf;
   356		phdr = (Elf64_Phdr *)(ehdr + 1);
   357		memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
   358		ehdr->e_ident[EI_CLASS] = ELFCLASS64;
   359		ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
   360		ehdr->e_ident[EI_VERSION] = EV_CURRENT;
   361		ehdr->e_ident[EI_OSABI] = ELF_OSABI;
   362		memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
   363		ehdr->e_type = ET_CORE;
   364		ehdr->e_machine = ELF_ARCH;
   365		ehdr->e_version = EV_CURRENT;
   366		ehdr->e_phoff = sizeof(Elf64_Ehdr);
   367		ehdr->e_ehsize = sizeof(Elf64_Ehdr);
   368		ehdr->e_phentsize = sizeof(Elf64_Phdr);
   369	
   370		/* Prepare one phdr of type PT_NOTE for each possible CPU */
   371		for_each_possible_cpu(cpu) {
   372			phdr->p_type = PT_NOTE;
   373			notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
   374			phdr->p_offset = phdr->p_paddr = notes_addr;
   375			phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
   376			(ehdr->e_phnum)++;
   377			phdr++;
   378		}
   379	
   380		/* Prepare one PT_NOTE header for vmcoreinfo */
   381		phdr->p_type = PT_NOTE;
   382		phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
   383		phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
   384		(ehdr->e_phnum)++;
   385		phdr++;
   386	
   387		/* Prepare PT_LOAD type program header for kernel text region */
   388		if (need_kernel_map) {
   389			phdr->p_type = PT_LOAD;
   390			phdr->p_flags = PF_R|PF_W|PF_X;
   391			phdr->p_vaddr = (unsigned long) _text;
   392			phdr->p_filesz = phdr->p_memsz = _end - _text;
   393			phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
   394			ehdr->e_phnum++;
   395			phdr++;
   396		}
   397	
   398		/* Go through all the ranges in mem->ranges[] and prepare phdr */
   399		for (i = 0; i < mem->nr_ranges; i++) {
   400			mstart = mem->ranges[i].start;
   401			mend = mem->ranges[i].end;
   402	
   403			phdr->p_type = PT_LOAD;
   404			phdr->p_flags = PF_R|PF_W|PF_X;
   405			phdr->p_offset  = mstart;
   406	
   407			phdr->p_paddr = mstart;
   408			phdr->p_vaddr = (unsigned long) __va(mstart);
   409			phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
   410			phdr->p_align = 0;
   411			ehdr->e_phnum++;
 > 412			kexec_dprintk("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, "
   413				"sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
   414				phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
   415				ehdr->e_phnum, phdr->p_offset);
   416			phdr++;
   417		}
   418	
   419		*addr = buf;
   420		*sz = elf_sz;
   421		return 0;
   422	}
   423	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
