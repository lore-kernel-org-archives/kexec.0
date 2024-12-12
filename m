Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477DCE7717D
	for <kexec@archiver.kernel.org>; Thu, 12 Dec 2024 03:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XQkmT1yPjCtnHFbt7EIihUB6ImRKXJuV2L2GBasoOjw=; b=aLh0G7jiEJhfpMOqgOR0g1E/vO
	j18bN1uKId1oW6xfwm5EVA4mFbSaiiCD7dZoCteL4wEUaTY2MV8ZuP1oHBPdXGB4Y+7OvGXyYiz6j
	TjSUyFqigsNv6U0DT11qk4ptuErmKysXdP7nrT1ZaSL8y7ppvlJzBfZG6QkxDwMIOBwglnNhn7kMs
	P2blwWX3uxlai36Egr6AeoP8oL/colMa6EKeBZTduJvFmFKKtG9usZ36Ii9kE1gYLCTLf2lFSMc29
	GkLL/83qnp72z6PU7Mj3SiUz1US6X0MsV3DVkI5yUsO32ergIT+0LkKiUqLr5zMAIZ0YU4dpOcTRI
	vI2dZhdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLZUy-0000000Gml6-4BLC;
	Thu, 12 Dec 2024 03:04:20 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLZUw-0000000Gmkb-2MSf
	for kexec@lists.infradead.org;
	Thu, 12 Dec 2024 03:04:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733972659; x=1765508659;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hrq+a6WXW51XWWS3wLmGanfVMJdQWcnIUm/Pwg0Okgg=;
  b=iqmoZF8giKfUG4/mENMCvL8Jd7dtEltH3cXkdSWXZzSeD0lPWlbbAXLS
   porl4Ongeoi+nevuqYTCXjKglwZ2/6bv9ltLF0YdA8gLPyVbOuAVEcj/A
   0MHV+I4xJXC8ojlUZ2EPHlYw/ZxvUnjjZWAJyrnVWYi1wnjedzKE5OpXY
   Vh7H86iti8sDsRZI/r2JZveh/AGvyb8PX9siI40f/ZDsDq2zzquEprYd0
   uq3+gVA0d6Nbkb6cs2GRRZaZXDjf6lx6kFmjYAYon3TRTuleSG6wfwAGD
   X5rymOFva39aL3EZrf13F0IGYlMxchyChC05Ng9OyHcFA07qRnXfnT03J
   w==;
X-CSE-ConnectionGUID: 9OCgDk5FRo+tVh+VtWXMHg==
X-CSE-MsgGUID: 8ZmfQdN+S/2vRFS063WZ3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="51790973"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="51790973"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 19:04:17 -0800
X-CSE-ConnectionGUID: galIJQFwT1iXUCWiYm5vaA==
X-CSE-MsgGUID: K9ut+D3ZSEGSLA9BXwX4ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96517966"
Received: from unknown (HELO [10.238.1.173]) ([10.238.1.173])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 19:04:12 -0800
Message-ID: <5bb26488-f5fb-4186-92c3-de6a07631f91@linux.intel.com>
Date: Thu, 12 Dec 2024 11:03:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/20] x86/kexec: Mark relocate_kernel page as ROX
 instead of RWX
To: David Woodhouse <dwmw2@infradead.org>, kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 David Woodhouse <dwmw@amazon.co.uk>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 jpoimboe@kernel.org, bsz@amazon.de
References: <20241205153343.3275139-1-dwmw2@infradead.org>
 <20241205153343.3275139-14-dwmw2@infradead.org>
Content-Language: en-US
From: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
In-Reply-To: <20241205153343.3275139-14-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_190418_686724_6ADCBC28 
X-CRM114-Status: GOOD (  17.77  )
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



On 2024/12/5 23:05, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> All writes to the page now happen before it gets marked as executable
> (or after it's already switched to the identmap page tables where it's
> OK to be RWX).
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   arch/x86/kernel/machine_kexec_64.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index c9fd60f8f806..9232ad1562c8 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -323,7 +323,7 @@ int machine_kexec_prepare(struct kimage *image)
>   
>   	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
>   
> -	set_memory_x((unsigned long)control_page, 1);
> +	set_memory_rox((unsigned long)control_page, 1);
>   
>   	return 0;
>   }
> @@ -333,6 +333,7 @@ void machine_kexec_cleanup(struct kimage *image)
>   	void *control_page = page_address(image->control_code_page);
>   
>   	set_memory_nx((unsigned long)control_page, 1);
> +	set_memory_rw((unsigned long)control_page, 1);
>   
>   	free_transition_pgtable(image);
>   }

Hi David,

I've hit some kdump/kexec regression issue for guest kernel in KVM/QEMU 
based VM and reported in https://bugzilla.kernel.org/show_bug.cgi?id=219592.

based on further git bisect, it seems to be related with this commit, 
would you help to take a look?

