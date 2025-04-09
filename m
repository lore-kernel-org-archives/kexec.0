Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5E8C369A1
	for <kexec@archiver.kernel.org>; Wed,  9 Apr 2025 09:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UmBDaO553pt5URxLsLSoARbaD4C3+jJHPjI9TVqw1p8=; b=vZUKVfZaL8i0sIKMTEXVQxaqKp
	JJqqscG4iWP+iAX4lokPir6Lt6Ba3lGDORFLupQhnrKiwg8n951iOw8mHcCiy055+ws6C4V2HnETD
	sb+hw6+oF5fcV+QEj3Ws3SPwuyfEhm8YCf7n9FP3qBmVFq5Mlj1PzQS792gOslxIAai2fNtEnhNtX
	NTss1f5EVNVXQjsu0WTHWY2lHioYBJknVYsUV/Yv99+TX6F5QVaCUP9jR0P+dXSRbbSUBJMraVfRN
	zm6TDJG3XiB8qD8/KMMKYy1jmstjWiHGvnpfQ2uLBqB4XmYbYU1NruKkd6gBncZwXLyBwsy8KU7Bi
	jr4DviZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2RXO-00000006gBc-3438;
	Wed, 09 Apr 2025 09:16:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2RX9-00000006gAD-1gPR
	for kexec@lists.infradead.org;
	Wed, 09 Apr 2025 09:15:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2E29944A95
	for <kexec@lists.infradead.org>; Wed,  9 Apr 2025 09:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC388C4CEEC
	for <kexec@lists.infradead.org>; Wed,  9 Apr 2025 09:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744190146;
	bh=Ty1pwqrmShrkkSXMYJB/5FbS4/B1OSXP3/4mT9aAsdM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U+JWoiGnB3Ltj1oq2Lf12BbJStduvwmmIbUpPwE46zLzraulDbpUgoHkBVVxSd8dR
	 xOjYR3O0gjN793iX6J5SWUKGfn+DlCd+uaXBa+XFVfRJqxVnHQLRo7nKYLq9iVeXzp
	 A/XArWDVpftzIr3pQVPG/eHPWRm3RpI0SJr9XSe0gl9SKO/KANIGVe8EcU5X7aFWTa
	 RGiQ2+2WTb/xFNL+o/t7/fYw5Du7FdwDxlEPGS/tMcK8pzaxCTKqVFYH8LIx3xs4J/
	 ErqqLr1eYv8y+gb3UwC3FHhHjttrF/dppMtlQcx4TZpLLNii5sUvwGx1x4OAmCwuw6
	 uOEeyj0DSftjA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54954fa61c9so4703134e87.1
        for <kexec@lists.infradead.org>; Wed, 09 Apr 2025 02:15:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTnNk7lKJWnLzS/mzQWrV4v1E6uw5Ft5iKViKEPSnuPO/+tOAZJ3wuu5mHA3BKTemWr9VtmA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwJhi/PCcjlDbeq/4aWbRkr311EFfvTW0ZmKVSz7aOsIVUy/4MN
	x4h++YvXSZw4XBjxa2NVhw7Tt0g6O3L6NmRSozA5bWsXD3I+U6rePgNAZiSEJm/4iK0w5GmvwJN
	VShPOCUWIybniZ8yFuQPQiTqUFQk=
X-Google-Smtp-Source: AGHT+IGr6pJEooPeND2WPKwmKzqEYbai9tqpsiAki3uL4C9w+bT2D4fnGON4jq0ew7tRiFB4rDjlDOhGc1mfiwwy2OM=
X-Received: by 2002:a05:6512:3981:b0:545:8a1:5379 with SMTP id
 2adb3069b0e04-54c44561c19mr593775e87.43.1744190145154; Wed, 09 Apr 2025
 02:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250328230814.2210230-1-ross.philipson@oracle.com>
 <20250328230814.2210230-20-ross.philipson@oracle.com> <B41D3199-8054-4B2C-94D6-508D1DE4C8B3@zytor.com>
 <886145d3-a9f2-41f3-a754-253decdb1b4f@oracle.com> <Z_WkaJhel-BYxHeW@char.us.oracle.com>
In-Reply-To: <Z_WkaJhel-BYxHeW@char.us.oracle.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 9 Apr 2025 11:15:34 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEAZS+839zmpW3WfwvTRMZmRbPYGpEoY=Xj9qFch9J7BA@mail.gmail.com>
X-Gm-Features: ATxdqUF80H-sehwytd1k_ZBdeFEl5wo_O_6zq2xvDwvr3fvlWsrlNSPU8VOuvPk
Message-ID: <CAMj1kXEAZS+839zmpW3WfwvTRMZmRbPYGpEoY=Xj9qFch9J7BA@mail.gmail.com>
Subject: Re: [PATCH v13 19/19] x86/efi: EFI stub DRTM launch support for
 Secure Launch
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: ross.philipson@oracle.com, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux.dev, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org, 
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_021548_693755_34E92702 
X-CRM114-Status: GOOD (  19.09  )
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

On Wed, 9 Apr 2025 at 00:35, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> ..snip..
> > > > @@ -925,6 +1014,11 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
> > > >           goto fail;
> > > >   }
> > > >
> > > > +#if (IS_ENABLED(CONFIG_SECURE_LAUNCH))
> > > > + /* If a Secure Launch is in progress, this never returns */
> > > > + efi_secure_launch(boot_params);
> > > > +#endif
> > > > +
> > > >   /*
> > > >    * Call the SEV init code while still running with the firmware's
> > > >    * GDT/IDT, so #VC exceptions will be handled by EFI.
> > >
> > > efi_set_u64_form()?
> > >
> > > What the heck is that? If it actually involves two u32 packed into a 64 field, why not simply do two stores?
> > >
> >
> > Well the story is this. The EFI maintainers asked me to use the
> > efi_set_u64_split() type functions (this one splits a u64 into 2 u32). I
> > went to look and there was no function that did the opposite action so I
> > added it. The original function was called efi_set_u64_split() so
> > efi_set_u64_form() was what I came up with. I can name it anything that is
> > desired.
>
> Hey Peter,
>
> Is there anything in particular that needs to be done to this patch?
>

If anyone feels strongly enough about this, we can fix it in a
follow-up patch. The code works as expected, so no need to derail this
series even further.

