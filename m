Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6ECDC072A2
	for <kexec@archiver.kernel.org>; Wed, 15 Nov 2023 21:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/NwoufT2R36oZjnN3DbzHS1xSE2Luisw36D5NPpvAyc=; b=U6xBgRdYB6q8Mb
	RTGdynBPXXLJBLxNaa2WRhMN1o2dKi724f696EszjW6WVftS9bJW3ar9Ygyu8hoZHnF9w1tVu9oqJ
	JW22Q8gDD6hqvRGH7LKve6MCWQw2JqRLwbqmG4eTJ2GF/789FOOS/VEfbIKcRNw4aoZZXaek1aIwA
	HKO6D1ilS5fldPV+IlCZXpUPuLs9YRhA+oUkx17vsWjHqI/OqKZEHz/uUH1xFzCRney6DZmKw3kcA
	UxabFiJSNwm9qd0ibqsI8eRKYwybqdQKnln/MrRYAi3HdUM8Y3WCtwTUp7a80+fXj52+Irbftmfqg
	HDVLrTnFP0jNEnVRRiTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3N4X-001jxP-0e;
	Wed, 15 Nov 2023 21:05:17 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3N4U-001jvx-1F;
	Wed, 15 Nov 2023 21:05:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700082315; x=1731618315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HZaP63qR51WdI944Jzx+qswTuQEwasjcvHgL6QGSQhs=;
  b=CPs+xqeEYQ6PzrNzeK6Kw8TucW+bT3m+HPswn1EbrNXWLxUe6+9xNWKK
   4rYXxA3s8oMG+2X1MgoSggo8oewHqvyyL1y1qW5HiUes/+X496JaqKmrq
   D9UGZco9IXC4WQo743h1yioRn5tH7GjsWocl+Vb7Xkr/hMsaaeBZlblLc
   AYaQAWbHvvppRbuJmVUiLUd3vB5PFD6Q3irem8CNWesxyT/gRtKYI94g4
   WyJVXEyeQ5vm1lo0tABn4pg6wNeG1F8PiNR0wvFFFrK/2PoMo5mFxvE/K
   negPURyRyxYnRZ4OPeOJfg0QWaVzJsW9Yvk4tbWXcUuTjuwNwfzzVsyRb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="4032595"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="4032595"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 13:05:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="888699475"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="888699475"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Nov 2023 13:05:08 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r3N4M-0000p6-1l;
	Wed, 15 Nov 2023 21:05:06 +0000
Date: Thu, 16 Nov 2023 05:04:43 +0800
From: kernel test robot <lkp@intel.com>
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kexec@lists.infradead.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-parisc@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 2/7] kexec_file: print out debugging message if required
Message-ID: <202311160431.BXPc7NO9-lkp@intel.com>
References: <20231114153253.241262-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231114153253.241262-3-bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231115_130514_440210_45AD735A 
X-CRM114-Status: GOOD (  16.18  )
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
config: hexagon-comet_defconfig (https://download.01.org/0day-ci/archive/20231116/202311160431.BXPc7NO9-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160431.BXPc7NO9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160431.BXPc7NO9-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/crash_core.c:13:
   In file included from include/linux/kexec.h:19:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from kernel/crash_core.c:13:
   In file included from include/linux/kexec.h:19:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from kernel/crash_core.c:13:
   In file included from include/linux/kexec.h:19:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> kernel/crash_core.c:412:3: error: call to undeclared function 'kexec_dprintk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   kexec_dprintk("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, "
                   ^
   6 warnings and 1 error generated.


vim +/kexec_dprintk +412 kernel/crash_core.c

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
