Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C42CD11DD
	for <kexec@archiver.kernel.org>; Fri, 29 Mar 2024 15:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1wojckPq99NrmaYh4SgaGHaoMBemMhcbq0i8uW3Jj1Y=; b=m7JtURBxDDiqCB
	M761tuj2V5CZ3pSEozd6rWhCrfX7NxbBEyDLYwYfZ8ILXiystxeoRyW0O1EM7+cY4cttiFU8t1mOh
	ZK2YfyHm15eXoo6kOtJak/Isbk6gPL2KWbz7EELuenz9lqjrfVbYS7nolU6Ss+2JNYSIX9mLBJRSL
	XWyC8W+D42CYhFdWXvgWxDMbf/xiup/kY6OaV+XPUwMDbYfZFF+KcTRw+Ki16H0XpXo0oPbLp0eUc
	NTHbLQRG5Y1awxjbXK/uW2Pi61oRraJBK+mPyBNoqA9JqQ8qE6n2oI1F7n7AKbEN8LgyZTv6/eVoJ
	xlvXyUwV1IqiCYQQ9o6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqE3B-000000018SS-1bJA;
	Fri, 29 Mar 2024 15:21:49 +0000
Received: from mgamail.intel.com ([198.175.65.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqE38-000000018R6-2ARj
	for kexec@lists.infradead.org;
	Fri, 29 Mar 2024 15:21:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711725707; x=1743261707;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xIhz1fc0gd8bUoWk1Yba/XGwSpCgbpumuPmPXecDCog=;
  b=bcDIdf+I9u8R5fcPT0PRVr5znnS65mXM0BovaElEIRWi8TMYUMYu0iBd
   Y6gvJu3Hhilar/4aEyPKQQN4VczRUBc8sa0K0cPVU4MTZpRIp3/E9uF9y
   t2K5HkySvVD/i28Xz47FA8Kx9YiCaPUy6mLpI+NS5wYItdzga+GuKf1+y
   Evy62oJK6BsIwzpIsAOheJieIRLLdN/7g60gSEQ8Ibz6PSEUxQ3+Xjdy8
   ag7/rH4W01pEYuyGl++9pVPNXxVYLyv8TxaBN4/jP5ZnDGH1UolafB6Md
   qhv8gUIxQQ5BrHaimgKbEtsnBZVulItZPZf8SRxQyKFqL24M8bPA8+1G4
   g==;
X-CSE-ConnectionGUID: uHpwIEdsSJuDVwxkNzS0Og==
X-CSE-MsgGUID: EDG9obP5QfShyE2TaTIM6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="17472617"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="17472617"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 08:21:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="17636665"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.224.7]) ([10.124.224.7])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 08:21:36 -0700
Message-ID: <b94c81ef-50f2-4e66-9533-461791777d10@intel.com>
Date: Fri, 29 Mar 2024 23:21:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 05/17] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <20240325103911.2651793-6-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240325103911.2651793-6-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240329_082146_637908_91C61174 
X-CRM114-Status: GOOD (  14.93  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 3/25/2024 6:38 PM, Kirill A. Shutemov wrote:
> TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
> to #VE.

Will we consider making it more safe and compatible for future to guard 
against X86_FEATURE_MCE as well?

If in the future, MCE becomes configurable for TD guest, then CR4.MCE 
might not be fixed1.

> Use alternatives to keep the flag during kexec for TDX guests.
> 
> The change doesn't affect non-TDX-guest environments.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/kernel/relocate_kernel_64.S | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 56cab1bb25f5..e144bcf60cbe 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -5,6 +5,8 @@
>    */
>   
>   #include <linux/linkage.h>
> +#include <linux/stringify.h>
> +#include <asm/alternative.h>
>   #include <asm/page_types.h>
>   #include <asm/kexec.h>
>   #include <asm/processor-flags.h>
> @@ -145,12 +147,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>   	 * Set cr4 to a known state:
>   	 *  - physical address extension enabled
>   	 *  - 5-level paging, if it was enabled before
> +	 *  - Machine check exception on TDX guest. Clearing MCE is not allowed
> +	 *    in TDX guests.
>   	 */
>   	movl	$X86_CR4_PAE, %eax
>   	testq	$X86_CR4_LA57, %r13
>   	jz	1f
>   	orl	$X86_CR4_LA57, %eax
>   1:
> +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
>   	movq	%rax, %cr4
>   
>   	jmp 1f


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
