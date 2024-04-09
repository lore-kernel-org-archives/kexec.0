Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83052C67861
	for <kexec@archiver.kernel.org>; Tue,  9 Apr 2024 14:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ECRORvrWsm2W5KtINpv2gP2iNklJqTAltMxswlcJCPE=; b=yHayNmJ7quFGRdy3vZ5yMQtqsj
	Mzyx1o+KWP3pmFZseIe+SaGWoWHQ6o37LzFCBZMipz3DwCXVdbU4NYA6FmbilUprRM4A6i5tfzEWx
	j2WMkimRQbDG+z9Z9X1U4hf5pnGIHC83MTgjUoRNPUPAXh6jAo3ZLAwPS6J1MblyCOc9sghvZU/G0
	A6nUaUgky3tfyest2904No6rDnZ3MhbM3Sqj1Iln4JYx3/NM8QdhF9dZtLl9a2GRIHSOAPZxSczDv
	kpRu/jKENkP4Id+xTTTU7KjOZPan426QZ4I5MqYGYFvnQ/W/z4U/OOY/hDbdCojs8sU6LruZnfGPy
	pdxgetyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruCMp-00000002Opd-2JdP;
	Tue, 09 Apr 2024 14:22:31 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruCMm-00000002OoV-3XdZ
	for kexec@lists.infradead.org;
	Tue, 09 Apr 2024 14:22:30 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1e2a5cb5455so58053905ad.2
        for <kexec@lists.infradead.org>; Tue, 09 Apr 2024 07:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712672546; x=1713277346; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rzf284ZBrPEw96jPmf6sJWqKEUO80DMFZq6QcuaB1j4=;
        b=qm+fKzv3LVN8y00Anck1vdEhhjqsbRMD9x1dzM1UJDHBgToTpQ1094Dtx2rs+xnSdZ
         1qBavmrB0N28rTqYXB/E87jHML6ylxkNQjcxsyOWw7HmygeDjKANpqa2bsD0+AUZDdiN
         Om4a39k0zRcXYCSSfd19UzD+JeLrf6p7rAuTO95sobdCeZdF0Pes72f3BRotK6Kp/9am
         y9v4flcF1mySo1Gsye2moHu+9pC2LGvZpTaySHHR1BVNXINWJRusCD27pKkUqx4c3grl
         RRjUJguH/zGmL0atKpdEj2Miw8vvnsmTZtt3T5y+kQdJt0ZBRbrate0o9B6nMYOtJ/9d
         ygiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712672546; x=1713277346;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzf284ZBrPEw96jPmf6sJWqKEUO80DMFZq6QcuaB1j4=;
        b=g5Ff5OO7tPuXjpkN/0me5ETyC1oCdvkwCDGTWj1HvTfKig9nM6riMsXM3qDZpeMdPP
         d3nCJtSplS5SlVOmmsvFHwS78+YdleF2MbrJzYm8Lqh9KYx43JFuCvOmVuy5m+2W9Yhr
         O3K30QCnRoRIfaPv0dwXHTFIw1WGPGy/175Vw4ViaGWkfPsOOo/js2QDYnTNXinTOnQs
         Zy/I/mKsqKzYUY1uuLKSisIb1F00cPVAVJM0REFTA61ZSQ67MQSmuKSx8EulgxUBiOyn
         /6EGdG8UPA5XDv5tyzXaJqWok9wciN2I1PdpYXH8WRdjV2AEQa8v6yYMxf5bvhiHYz5l
         fJHg==
X-Forwarded-Encrypted: i=1; AJvYcCWD7XOKsHvP+n7A6gP1QGzCmuJs6DcWMpao69CaAqniKMgJnvFL1uiIQacVbW0RiMdUo3UNCPeWA5MyYKf1cUbO09KkeiTVPc4f
X-Gm-Message-State: AOJu0YxWvUcvL76HD9H+90QjXI0iMkgI8Fc5tlNx7M6b0hCReumwhtUD
	dHimPdO7q23D2PeAXR4nbrPf1JhKVhtp5LRnNbZ1q2PKxoWQqnEIWWlFXnaZxLC6B63QFDHcWsa
	YdQ==
X-Google-Smtp-Source: AGHT+IFQbZfL17SFF2bj/UJ0pxxiOljLr4AR0LD/VuM1TYSQ/VvBmRf2Ryf8KUJHwwaq9RypgUOGlGE46Kc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e807:b0:1e2:588:b5bb with SMTP id
 u7-20020a170902e80700b001e20588b5bbmr693928plg.8.1712672545971; Tue, 09 Apr
 2024 07:22:25 -0700 (PDT)
Date: Tue, 9 Apr 2024 07:22:24 -0700
In-Reply-To: <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com> <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
Message-ID: <ZhVPIDDLkjOB96fI@google.com>
Subject: Re: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for TDX guest
From: Sean Christopherson <seanjc@google.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima <jun.nakajima@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_072228_957717_085EF6A5 
X-CRM114-Status: GOOD (  16.51  )
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

On Tue, Apr 09, 2024, Kirill A. Shutemov wrote:
> Depending on setup, TDX guests might be allowed to clear CR4.MCE.
> Attempt to clear it leads to #VE.
> 
> Use alternatives to keep the flag during kexec for TDX guests.
> 
> The change doesn't affect non-TDX-guest environments.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/relocate_kernel_64.S | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 56cab1bb25f5..8e2037d78a1f 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -5,6 +5,8 @@
>   */
>  
>  #include <linux/linkage.h>
> +#include <linux/stringify.h>
> +#include <asm/alternative.h>
>  #include <asm/page_types.h>
>  #include <asm/kexec.h>
>  #include <asm/processor-flags.h>
> @@ -145,11 +147,17 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>  	 * Set cr4 to a known state:
>  	 *  - physical address extension enabled
>  	 *  - 5-level paging, if it was enabled before
> +	 *  - Machine check exception on TDX guest, if it was enabled before.
> +	 *    Clearing MCE might not allowed in TDX guests, depending on setup.
>  	 */
>  	movl	$X86_CR4_PAE, %eax
>  	testq	$X86_CR4_LA57, %r13
>  	jz	1f
>  	orl	$X86_CR4_LA57, %eax
> +1:
> +	testq	$X86_CR4_MCE, %r13
> +	jz	1f
> +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST

The TEST+Jcc+OR sequences are rather odd, and require way more instructions and
thus way more copy+paste than is necessary.

	movl	$X86_CR4_LA57, %eax
	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
	andl	%r13d, %eax
	orl	$X86_CR4_PAE, %eax
	movq	%rax, %cr4

Then preserving new bits unconditionally only requires adding the flag to the
initial move, and feature-dependent bits only need a single ALTERNATIVE line.

And there's no branches, blazing fast kexec! ;-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
