Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C45BC4167B
	for <kexec@archiver.kernel.org>; Fri, 10 Nov 2023 23:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=K3yNYPabB/8uCju7hcuKWoO79Kjg4qQLgKb6xjxZ5HA=; b=vwNJufbQlJgBnrFpjfFRheGiY6
	nkJHY1+nrqesHSUfZn6DhUAG0LH921VlHKHu9Q7A/AE/1SDmHhBJ0xJVVEqOmB+Emn5RC8TsWpfT+
	gGdQ/PvEFNDNfhBPtYuMZjjNbJGkY+2XtMV3SNCx2B2SlW3xedG273Vbkj8kZQe0c9goLfe/xwPVr
	uaEEUtjYiOfAjvSZEorMcTJE5KUFAPoe2KDV2B+4zNjFLzhbv7o8Z/bKWwq4gjJ1oyE9a8iQuggQL
	9r7/sXeNTAYIdn63vdSgsNn0EaRphhbVgrP/4I9xpOgN0lvJmA1gf6LSyc/Ze+W9e6+CL76Zr0oG6
	+1l9fOdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1b8K-009e7y-1k;
	Fri, 10 Nov 2023 23:41:52 +0000
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1b8H-009e7Y-0B
	for kexec@lists.infradead.org;
	Fri, 10 Nov 2023 23:41:50 +0000
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da307fb7752so3218287276.0
        for <kexec@lists.infradead.org>; Fri, 10 Nov 2023 15:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699659707; x=1700264507; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ltVk616BPyOUD6M/e4/KeQLo/53b8eRdyGVgEa8ceQ=;
        b=rwztZvSUH92g5OSPmjFJZzrqbV4auzRornV4KRSztX9AHO40l4ZP4VFKtQq1IcDVwl
         uaXrmm3JiVaeRvd/rKGNlpII+eOa4uVPa3a+EcAezOGZFRraZsQYgl9EH2HLmuONdQcz
         ++zCjyyAlqLieHwiqQIgSzEFCJXD8KXbYa+LRDHrYMouBjceDI0EBr1nzhKUz/Yo/Seh
         /FgE5xJ+/MB/ASUJ0DLADOTBlmGwKklNndE9RWv3+Wind+jDc+2vayUWuRMVbZQjmlAL
         i9ryqKqFRvoq0hcjhZU/MPyl+piGvGVNRVAFxmV3hV+hB5lCrBMae1K0atiHHthticvd
         3ZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699659707; x=1700264507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ltVk616BPyOUD6M/e4/KeQLo/53b8eRdyGVgEa8ceQ=;
        b=rBYaxVVq6iA1HtGACw6dYXBPxkPW++cHlhidtrHqr7gSOp2BocSZGxeVREwJcavCVD
         SFqLeq3XT6DwMAjTsNXiy2tDJd9msnQvKZj5Ov2lEe5RMII6frPOvWsDF8azX54jRD5a
         vGuwi8HAYQXggASM6LAVFIIPqrzTZe2oPqhZNOtuKJSqTEZL/7pAsjPE0GDSS675o9AB
         DnSIVgEXI+ZVtcs2hcQTjlvbpG9yBrGvGJ2WPyqU6WzCpT+ZzdPkRFdcf4xrRVeKmA9x
         O+HxeT7qae7tq5IvdeyCbiDGClpDtFV6+w7zp1t0xvjHERn7VWv8EtFoLLHinhLHuy9a
         WWPg==
X-Gm-Message-State: AOJu0YzLKv3jsyrXYcvOATJ/RW0anCt3NeYbBcNIbLqZNPfLR9t1f3lU
	BHlyYLRyDSbVJeiZ3eKwsBaKu445A8M=
X-Google-Smtp-Source: AGHT+IGBsfnu9DDfS0QMrc7xY+SRPf/NS4ruISrqsheEvpErABAEKuj1dLba039RzL2yA5d0Qtqev7ecdb8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:182:b0:d9a:ec95:9687 with SMTP id
 t2-20020a056902018200b00d9aec959687mr15566ybh.11.1699659706873; Fri, 10 Nov
 2023 15:41:46 -0800 (PST)
Date: Fri, 10 Nov 2023 15:41:45 -0800
In-Reply-To: <20231110222751.219836-11-ross.philipson@oracle.com>
Mime-Version: 1.0
References: <20231110222751.219836-1-ross.philipson@oracle.com> <20231110222751.219836-11-ross.philipson@oracle.com>
Message-ID: <ZU6_uUe45qAx52mI@google.com>
Subject: Re: [PATCH v7 10/13] kexec: Secure Launch kexec SEXIT support
From: Sean Christopherson <seanjc@google.com>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, luto@amacapital.net, 
	nivedita@alum.mit.edu, kanth.ghatraju@oracle.com, 
	trenchboot-devel@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_154149_136670_1F4AB6D5 
X-CRM114-Status: GOOD (  18.07  )
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

On Fri, Nov 10, 2023, Ross Philipson wrote:
> Prior to running the next kernel via kexec, the Secure Launch code
> closes down private SMX resources and does an SEXIT. This allows the
> next kernel to start normally without any issues starting the APs etc.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/kernel/slaunch.c | 73 +++++++++++++++++++++++++++++++++++++++
>  kernel/kexec_core.c       |  4 +++
>  2 files changed, 77 insertions(+)
> 
> diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
> index cd5aa34e395c..32b0c24a6484 100644
> --- a/arch/x86/kernel/slaunch.c
> +++ b/arch/x86/kernel/slaunch.c
> @@ -523,3 +523,76 @@ void __init slaunch_setup_txt(void)
>  
>  	pr_info("Intel TXT setup complete\n");
>  }
> +
> +static inline void smx_getsec_sexit(void)
> +{
> +	asm volatile (".byte 0x0f,0x37\n"
> +		      : : "a" (SMX_X86_GETSEC_SEXIT));

SMX has been around for what, two decades?  Is open coding getsec actually necessary?

> +	/* Disable SMX mode */

Heh, the code and the comment don't really agree.  I'm guessing the intent of the
comment is referring to leaving the measured environment, but it looks odd.   If
manually setting SMXE is necessary, I'd just delete this comment, or maybe move
it to above SEXIT.

> +	cr4_set_bits(X86_CR4_SMXE);

Is it actually legal to clear CR4.SMXE while post-SENTER?  I don't see anything
in the SDM that says it's illegal, but allowing software to clear SMXE in that
case seems all kinds of odd.

> +
> +	/* Do the SEXIT SMX operation */
> +	smx_getsec_sexit();
> +
> +	pr_info("TXT SEXIT complete.\n");
> +}

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
