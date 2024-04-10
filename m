Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C42CD128A
	for <kexec@archiver.kernel.org>; Wed, 10 Apr 2024 14:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ooi04R73ucJQLJSgI4nayBSZz54R1fGZDLJ1w6l/Z/A=; b=PWvRV5elfJiwaa
	4rGWMi+H9a+t3HOC16deD8LPvIa3T2toUxOGa/bykswEYk0JiuIrMxpyKtGq3US3kCyeGVKEMBW4W
	eRHdkHkbtJVTSIp+Ci8lx2k6n79LoVa2Pb82rt/VaO8/I8ovdJ7uSSLiYEBY7wO+5DNzXhR4bCC0s
	L1J7OOFBscZ2pedH4Wrud3GRDZlU0HJ6KpAd8rZkndzk2jIj1NqwsKm2eR9/lYMQss5AWoEspW6y9
	EiIOdeQmAAd6wrvQIb+Z9YrBm7ch1rhvuPV4gu9uZcQzxDr96wE3KT81qp9HXfqFcfs/mE/66ugtz
	utp47dnXZhZqZEPfcKTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruYmL-00000007QVK-3jCP;
	Wed, 10 Apr 2024 14:18:21 +0000
Received: from mgamail.intel.com ([198.175.65.18])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruYmI-00000007QUR-00Yd
	for kexec@lists.infradead.org;
	Wed, 10 Apr 2024 14:18:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712758698; x=1744294698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FznTubYp6w0r5q/3QmPodUzEX1aM7IcFEf7XrPzXaes=;
  b=XBPXOjef6hJ8EX957x8TSuGmgYg3RqwiwuKrkqtChgGU71B+OA5pfNho
   ocbxq1toldr5vX+ZWTrCfP2NCkOHoAeWVWTvxno+c0O1E/eZ+rxzLFsM+
   bFLeAi9UXt1tURVYLTDywMSfbAkTgu5vDwwEXVal3EU9zxyX8Sm8eAceG
   SpbmQi3wur9MC4cFuH0mulMViGjApl/wxuuFBNYYjCvE5t3qFn5hF0ZU+
   fmeSRgEIZEX2oG0rk4ONglP5asXc311Zlbwu2G3xHjeVnb2sLRHR1AWYc
   BOP5y1JmXecUeAMMQ/C/ME5BPOMBiByLUY3JC2cjbtNO+cYFZEEyTsY6+
   g==;
X-CSE-ConnectionGUID: /wPybhwUQBi9zR/0cPBa6A==
X-CSE-MsgGUID: ZJ44MWCJTZKOgoXRgEBtAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8286837"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8286837"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 07:18:17 -0700
X-CSE-ConnectionGUID: BUWEHUgZRwyulQxO+uFnOg==
X-CSE-MsgGUID: ahXft4hoT/KZOy0wF0d8Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="51550060"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Apr 2024 07:18:10 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruYm8-0007U8-0L;
	Wed, 10 Apr 2024 14:18:08 +0000
Date: Wed, 10 Apr 2024 22:17:12 +0800
From: kernel test robot <lkp@intel.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, rafael@kernel.org,
	peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] x86/snp: Convert shared memory back to private on
 kexec
Message-ID: <202404102232.UKwWHSTE-lkp@intel.com>
References: <b24885f5495f6b8ba2f9e825fda9188fcbf28231.1712694667.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b24885f5495f6b8ba2f9e825fda9188fcbf28231.1712694667.git.ashish.kalra@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240410_071818_328992_9924D847 
X-CRM114-Status: GOOD (  13.87  )
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

Hi Ashish,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/master]
[also build test ERROR on linus/master next-20240410]
[cannot apply to tip/x86/core tip/x86/mm tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ashish-Kalra/efi-x86-skip-efi_arch_mem_reserve-in-case-of-kexec/20240410-044512
base:   tip/master
patch link:    https://lore.kernel.org/r/b24885f5495f6b8ba2f9e825fda9188fcbf28231.1712694667.git.ashish.kalra%40amd.com
patch subject: [PATCH v4 4/4] x86/snp: Convert shared memory back to private on kexec
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240410/202404102232.UKwWHSTE-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240410/202404102232.UKwWHSTE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404102232.UKwWHSTE-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/kernel/sev.c:993:14: error: call to undeclared function 'pte_decrypted'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     993 |                 if (pte && pte_decrypted(*pte) && !pte_none(*pte)) {
         |                            ^
   arch/x86/kernel/sev.c:1021:16: error: call to undeclared function 'pte_decrypted'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1021 |                 if (!pte || !pte_decrypted(*pte) || pte_none(*pte))
         |                              ^
>> arch/x86/kernel/sev.c:1041:7: error: call to undeclared function 'stop_memory_enc_conversion'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1041 |         if (!stop_memory_enc_conversion(wait_for_lock))
         |              ^
   3 errors generated.
--
>> arch/x86/mm/mem_encrypt_amd.c:471:21: error: no member named 'enc_kexec_stop_conversion' in 'struct x86_guest'
     471 |         x86_platform.guest.enc_kexec_stop_conversion = snp_kexec_stop_conversion;
         |         ~~~~~~~~~~~~~~~~~~ ^
>> arch/x86/mm/mem_encrypt_amd.c:472:21: error: no member named 'enc_kexec_unshare_mem' in 'struct x86_guest'
     472 |         x86_platform.guest.enc_kexec_unshare_mem     = snp_kexec_unshare_mem;
         |         ~~~~~~~~~~~~~~~~~~ ^
   2 errors generated.


vim +/pte_decrypted +993 arch/x86/kernel/sev.c

   970	
   971	static void unshare_all_memory(void)
   972	{
   973		unsigned long addr, end;
   974	
   975		/*
   976		 * Walk direct mapping and convert all shared memory back to private,
   977		 */
   978	
   979		addr = PAGE_OFFSET;
   980		end  = PAGE_OFFSET + get_max_mapped();
   981	
   982		while (addr < end) {
   983			unsigned long size;
   984			unsigned int level;
   985			pte_t *pte;
   986	
   987			pte = lookup_address(addr, &level);
   988			size = page_level_size(level);
   989	
   990			/*
   991			 * pte_none() check is required to skip physical memory holes in direct mapped.
   992			 */
 > 993			if (pte && pte_decrypted(*pte) && !pte_none(*pte)) {
   994				int pages = size / PAGE_SIZE;
   995	
   996				if (!make_pte_private(pte, addr, pages, level)) {
   997					pr_err("Failed to unshare range %#lx-%#lx\n",
   998					       addr, addr + size);
   999				}
  1000	
  1001			}
  1002	
  1003			addr += size;
  1004		}
  1005		__flush_tlb_all();
  1006	
  1007	}
  1008	
  1009	static void unshare_all_bss_decrypted_memory(void)
  1010	{
  1011		unsigned long vaddr, vaddr_end;
  1012		unsigned int level;
  1013		unsigned int npages;
  1014		pte_t *pte;
  1015	
  1016		vaddr = (unsigned long)__start_bss_decrypted;
  1017		vaddr_end = (unsigned long)__start_bss_decrypted_unused;
  1018		npages = (vaddr_end - vaddr) >> PAGE_SHIFT;
  1019		for (; vaddr < vaddr_end; vaddr += PAGE_SIZE) {
  1020			pte = lookup_address(vaddr, &level);
  1021			if (!pte || !pte_decrypted(*pte) || pte_none(*pte))
  1022				continue;
  1023	
  1024			set_pte_enc(pte, level, (void *)vaddr);
  1025		}
  1026		vaddr = (unsigned long)__start_bss_decrypted;
  1027		snp_set_memory_private(vaddr, npages);
  1028	}
  1029	
  1030	/* Stop new private<->shared conversions */
  1031	void snp_kexec_stop_conversion(bool crash)
  1032	{
  1033		/*
  1034		 * Crash kernel reaches here with interrupts disabled: can't wait for
  1035		 * conversions to finish.
  1036		 *
  1037		 * If race happened, just report and proceed.
  1038		 */
  1039		bool wait_for_lock = !crash;
  1040	
> 1041		if (!stop_memory_enc_conversion(wait_for_lock))
  1042			pr_warn("Failed to finish shared<->private conversions\n");
  1043	}
  1044	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
