Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873D2ECD6F8
	for <kexec@archiver.kernel.org>; Wed, 11 Feb 2026 22:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Eu5WXcIuBe88Xd8eCDaS+uTqxUL8W+UWJopLy1W8/I=; b=2BaA87gStNmt19pYcpOu287TPe
	Ez38oxhU4IESYhLjygYW28dslIIAJRMlfjiD6uE3eUJ/JEaYjVOBhmcZtBrBXTflctqRr6sNdzUaz
	8klOodHU6nMxJeE3LvuC3hLtfdsYi80Lx56+zoKoroQSKpQMdAOat96QmRCkf2w6v1UlG8J/oYwFD
	C0JfMOggYEFqI4CkbNRZtsoI+4LtSpW32vHEqwgnghNAiZM3peCgLJNDIqKWxEDf28fiMzbd2Db4C
	tYckuHCvPCf3d3z6OOQKCUCXUGc6JkFYxlzxrmpk+1TYs5kg70V3deNlILhjln5cnoyjW7FdfQJVn
	yiBvoqfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqIpT-000000018Yi-2m6A;
	Wed, 11 Feb 2026 22:37:03 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqIpQ-000000018YA-3Rvo;
	Wed, 11 Feb 2026 22:37:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770849421; x=1802385421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5lBrMrSUEvT4lx29b/VzGz7vn6FI2f6WHH0Xp1tO82E=;
  b=H9IFnpqib5B5sQaUWQazzfPAnodGsQHfyaN4C7EBwhanVSDCozvTM+ce
   CAF3v27b0p0XkUqhwcv29wd+MoxtKQx6h3zXuH8GzjUlqzZLPdfaz0ndd
   i8hcElhZrMDmnYMyl1gccgq9uw4AVyy/EEoGmj9Qk2Ersi+LqT3MIHnG4
   DCAt/8OTck5zzG/RjI8mvpef2t8oSqv2Jv4uLspBkY+JRPODjJFd9zs6+
   gPjyPutn4LVTpYw3DGUzAO5h+v27DPEAUgzjlsTONUdJbdA5nAUAi1whb
   rbZSBUP0D1RMSUr8OgAReMmbn6/5pYzf/Cx63XyGVXpPsTeO7t9xPRXH6
   Q==;
X-CSE-ConnectionGUID: shQmGESnRPaJRrLZ8OCtoA==
X-CSE-MsgGUID: rrsHFh4ETnmS1oW67Ermuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71911091"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="71911091"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 14:36:59 -0800
X-CSE-ConnectionGUID: ZabLUBVpQsqUdFupslNNvQ==
X-CSE-MsgGUID: MSBEmk28TJaeA0OfdScegg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="212403937"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 11 Feb 2026 14:36:53 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vqIpH-00000000qRi-0j3G;
	Wed, 11 Feb 2026 22:36:51 +0000
Date: Thu, 12 Feb 2026 06:35:52 +0800
From: kernel test robot <lkp@intel.com>
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>,
	Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
	Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Thomas Staudt <tstaudt@de.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] arm64,ppc64le/kdump: pass dm-crypt keys to kdump
 kernel
Message-ID: <202602120648.RgQALnnI-lkp@intel.com>
References: <20260211082401.2407853-3-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211082401.2407853-3-coxu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_143700_933993_FD5AFC58 
X-CRM114-Status: GOOD (  15.12  )
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

Hi Coiby,

kernel test robot noticed the following build errors:

[auto build test ERROR on 2619c62b7ef2f463bcbbb34af122689c09855c23]

url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/crash_dump-dm-crypt-Don-t-print-in-arch-specific-code/20260211-162729
base:   2619c62b7ef2f463bcbbb34af122689c09855c23
patch link:    https://lore.kernel.org/r/20260211082401.2407853-3-coxu%40redhat.com
patch subject: [PATCH v4 2/2] arm64,ppc64le/kdump: pass dm-crypt keys to kdump kernel
config: powerpc64-randconfig-r111-20260212 (https://download.01.org/0day-ci/archive/20260212/202602120648.RgQALnnI-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260212/202602120648.RgQALnnI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602120648.RgQALnnI-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/kexec/elf_64.c: In function 'elf64_load':
>> arch/powerpc/kexec/elf_64.c:82:23: error: implicit declaration of function 'crash_load_dm_crypt_keys' [-Werror=implicit-function-declaration]
      82 |                 ret = crash_load_dm_crypt_keys(image);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/crash_load_dm_crypt_keys +82 arch/powerpc/kexec/elf_64.c

    27	
    28	static void *elf64_load(struct kimage *image, char *kernel_buf,
    29				unsigned long kernel_len, char *initrd,
    30				unsigned long initrd_len, char *cmdline,
    31				unsigned long cmdline_len)
    32	{
    33		int ret;
    34		unsigned long kernel_load_addr;
    35		unsigned long initrd_load_addr = 0, fdt_load_addr;
    36		void *fdt;
    37		const void *slave_code;
    38		struct elfhdr ehdr;
    39		char *modified_cmdline = NULL;
    40		struct crash_mem *rmem = NULL;
    41		struct kexec_elf_info elf_info;
    42		struct kexec_buf kbuf = { .image = image, .buf_min = 0,
    43					  .buf_max = ppc64_rma_size };
    44		struct kexec_buf pbuf = { .image = image, .buf_min = 0,
    45					  .buf_max = ppc64_rma_size, .top_down = true,
    46					  .mem = KEXEC_BUF_MEM_UNKNOWN };
    47	
    48		ret = kexec_build_elf_info(kernel_buf, kernel_len, &ehdr, &elf_info);
    49		if (ret)
    50			return ERR_PTR(ret);
    51	
    52		if (IS_ENABLED(CONFIG_CRASH_DUMP) && image->type == KEXEC_TYPE_CRASH) {
    53			/* min & max buffer values for kdump case */
    54			kbuf.buf_min = pbuf.buf_min = crashk_res.start;
    55			kbuf.buf_max = pbuf.buf_max =
    56					((crashk_res.end < ppc64_rma_size) ?
    57					 crashk_res.end : (ppc64_rma_size - 1));
    58		}
    59	
    60		ret = kexec_elf_load(image, &ehdr, &elf_info, &kbuf, &kernel_load_addr);
    61		if (ret)
    62			goto out;
    63	
    64		kexec_dprintk("Loaded the kernel at 0x%lx\n", kernel_load_addr);
    65	
    66		ret = kexec_load_purgatory(image, &pbuf);
    67		if (ret) {
    68			pr_err("Loading purgatory failed.\n");
    69			goto out;
    70		}
    71	
    72		kexec_dprintk("Loaded purgatory at 0x%lx\n", pbuf.mem);
    73	
    74		/* Load additional segments needed for panic kernel */
    75		if (IS_ENABLED(CONFIG_CRASH_DUMP) && image->type == KEXEC_TYPE_CRASH) {
    76			ret = load_crashdump_segments_ppc64(image, &kbuf);
    77			if (ret) {
    78				pr_err("Failed to load kdump kernel segments\n");
    79				goto out;
    80			}
    81	
  > 82			ret = crash_load_dm_crypt_keys(image);
    83			if (ret)
    84				goto out;
    85	
    86			/* Setup cmdline for kdump kernel case */
    87			modified_cmdline = setup_kdump_cmdline(image, cmdline,
    88							       cmdline_len);
    89			if (!modified_cmdline) {
    90				pr_err("Setting up cmdline for kdump kernel failed\n");
    91				ret = -EINVAL;
    92				goto out;
    93			}
    94			cmdline = modified_cmdline;
    95		}
    96	
    97		if (initrd != NULL) {
    98			kbuf.buffer = initrd;
    99			kbuf.bufsz = kbuf.memsz = initrd_len;
   100			kbuf.buf_align = PAGE_SIZE;
   101			kbuf.top_down = false;
   102			kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
   103			ret = kexec_add_buffer(&kbuf);
   104			if (ret)
   105				goto out;
   106			initrd_load_addr = kbuf.mem;
   107	
   108			kexec_dprintk("Loaded initrd at 0x%lx\n", initrd_load_addr);
   109		}
   110	
   111		ret = get_reserved_memory_ranges(&rmem);
   112		if (ret)
   113			goto out;
   114	
   115		fdt = of_kexec_alloc_and_setup_fdt(image, initrd_load_addr,
   116						   initrd_len, cmdline,
   117						   kexec_extra_fdt_size_ppc64(image, rmem));
   118		if (!fdt) {
   119			pr_err("Error setting up the new device tree.\n");
   120			ret = -EINVAL;
   121			goto out;
   122		}
   123	
   124		ret = setup_new_fdt_ppc64(image, fdt, rmem);
   125		if (ret)
   126			goto out_free_fdt;
   127	
   128		if (!IS_ENABLED(CONFIG_CRASH_HOTPLUG) || image->type != KEXEC_TYPE_CRASH)
   129			fdt_pack(fdt);
   130	
   131		kbuf.buffer = fdt;
   132		kbuf.bufsz = kbuf.memsz = fdt_totalsize(fdt);
   133		kbuf.buf_align = PAGE_SIZE;
   134		kbuf.top_down = true;
   135		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
   136		ret = kexec_add_buffer(&kbuf);
   137		if (ret)
   138			goto out_free_fdt;
   139	
   140		/* FDT will be freed in arch_kimage_file_post_load_cleanup */
   141		image->arch.fdt = fdt;
   142	
   143		fdt_load_addr = kbuf.mem;
   144	
   145		kexec_dprintk("Loaded device tree at 0x%lx\n", fdt_load_addr);
   146	
   147		slave_code = elf_info.buffer + elf_info.proghdrs[0].p_offset;
   148		ret = setup_purgatory_ppc64(image, slave_code, fdt, kernel_load_addr,
   149					    fdt_load_addr);
   150		if (ret)
   151			pr_err("Error setting up the purgatory.\n");
   152	
   153		goto out;
   154	
   155	out_free_fdt:
   156		kvfree(fdt);
   157	out:
   158		kfree(rmem);
   159		kfree(modified_cmdline);
   160		kexec_free_elf_info(&elf_info);
   161	
   162		return ret ? ERR_PTR(ret) : NULL;
   163	}
   164	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

