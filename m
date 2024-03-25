Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA39EC54E64
	for <kexec@archiver.kernel.org>; Mon, 25 Mar 2024 15:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yfpnL4ISwNVVxk10CGj2Xnid9RWVOackRK4in0OPoxo=; b=fiOUdjnowIxwGR
	zeI8S5gEqjRRCczmjqtQr5pOfCiM62CTY7lk/jwfbER9DQwCAnUx2QlQhHGEc91ggjuaQwuZhPoQu
	LzfNO9w2Ecw23TmUbD3seP1Q1HDzMLTbcWoXU24QJPK3PcwNvOhEUgKYPDdHXInyi/PdSefM3o3SP
	WByr7BkCZSG+ntTZ6GZTO+s6M+xVlmFDuXDcgRUoa6WEB/212K9vRFOweBPzu8KFiJkf4mxkXSBIi
	yto9NsrwswpNM2bs5y5yGKDY32nrBYHK6W8Gktjg5ivGe63rI0mBbG5LVckK4scrU3FbZZKw3VLIT
	ZwNEidQhqe8sVPy9kO0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1romUW-00000000Z5Z-1vvZ;
	Mon, 25 Mar 2024 15:44:04 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1romUS-00000000Z2w-2E9j
	for kexec@lists.infradead.org;
	Mon, 25 Mar 2024 15:44:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711381440; x=1742917440;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kHE0zX1DU3TTa6UNYPRNZ7cQSTALakcksyGuk61DVw0=;
  b=cWr26lZLh4rNlYZKBlK3nT9SD9F+LEo46h48wmliVsRMm+/Oh+ol+jF6
   xqP8Xfe9WqwUuB/qyEdXsLcWwB00VzPyIqOvzihTPG0Z8Dd7kr7hgXpEb
   V8zNh65iCUdrqdGHaooLi46Ekf/ug/q1OnKCHV/XJw6EUM3WSxCD6Pnfl
   wPfoCjUdRnv2IoYRMEWCBV9yImNoYUo7yOSg21pScOMHuO5YJfiF82pe3
   +DLyxpVlI9agPuKdrXZbCI2d8PM9aEz4o5ExMrKyQNXWe+jFKOtlwV964
   7xfXiqTlw2d3ZTNQDT2KLVjEQReCxHLsgA9RpkyRhBFG8EgNmPB2kfUuA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="23877006"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="23877006"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:43:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="15526038"
Received: from dvidmant-mobl.amr.corp.intel.com (HELO [10.209.80.233]) ([10.209.80.233])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:43:58 -0700
Message-ID: <f71223cb-2de9-4872-8a68-09eb43215789@linux.intel.com>
Date: Mon, 25 Mar 2024 08:43:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 08/17] x86/tdx: Account shared memory
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <20240325103911.2651793-9-kirill.shutemov@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240325103911.2651793-9-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240325_084400_654220_8E38666C 
X-CRM114-Status: GOOD (  19.80  )
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


On 3/25/24 3:39 AM, Kirill A. Shutemov wrote:
> The kernel will convert all shared memory back to private during kexec.
> The direct mapping page tables will provide information on which memory
> is shared.
>
> It is extremely important to convert all shared memory. If a page is
> missed, it will cause the second kernel to crash when it accesses it.
>
> Keep track of the number of shared pages. This will allow for
> cross-checking against the shared information in the direct mapping and
> reporting if the shared bit is lost.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  arch/x86/coco/tdx/tdx.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 26fa47db5782..979891e97d83 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -38,6 +38,8 @@
>  
>  #define TDREPORT_SUBTYPE_0	0
>  
> +static atomic_long_t nr_shared;
> +
>  /* Called from __tdx_hypercall() for unrecoverable failure */
>  noinstr void __noreturn __tdx_hypercall_failed(void)
>  {
> @@ -821,6 +823,11 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
>  	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc))
>  		return -EIO;
>  
> +	if (enc)
> +		atomic_long_sub(numpages, &nr_shared);
> +	else
> +		atomic_long_add(numpages, &nr_shared);
> +
>  	return 0;
>  }
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
