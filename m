Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F52D6EBE3
	for <kexec@archiver.kernel.org>; Fri, 29 Nov 2024 07:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=znTNIV4yiUpsXZL1w3uAqvfGDGwGUOkw2J9EURHxCtI=; b=HNZN6guIzwO5+VnVb9VhQKTx3E
	ggYSyO1NI/TyzsaJhYZ5h4BKFPH9yqn8KH1fCv2CDeZrh6yPrlsiXPHxFpuZ81MSm7If02Oo2woTR
	wAKbZyB4bnBe6aM4rpA+3sdIbjhfQYq13Q0hX2fSYeyP7UdenkSqPevZCXNbGJMEOMPgk2+o1c0uX
	G4XHJaaBJfpVftt11eCxgr/qiNlQZTnr4dpB8999Q1nrjjzDkcKIuO59aiYY5obabrriLZzHC1jFA
	1mdyic+jZitMwbfZ2n0Xw57HDMXZjnwsDuzktcraPHGxAK7mbBJxoiRP5Und0nFOUVPE80AOQAvJ3
	28Fp+Fgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGvTv-0000000H51X-1z7i;
	Fri, 29 Nov 2024 07:32:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGvTs-0000000H50y-2Orc
	for kexec@lists.infradead.org;
	Fri, 29 Nov 2024 07:32:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732865518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=znTNIV4yiUpsXZL1w3uAqvfGDGwGUOkw2J9EURHxCtI=;
	b=hAjwKXoZ+/cE2gi5EJAdsbbIaH9GRzTYiHAEz3VJC1/R9T1JAOJjAyR6zDO6yEond9HUo0
	0J3miv09ERLBP3gfy9DNneH/LtHq54/DRRKui8AmVD4lp2angVGMDJf3cnTsaGy9tH/Zrr
	cnMQWQxuGi37cr+5L3z9yiaHsvybyks=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-dyEKsDi5OUOzlDFc5OupOQ-1; Fri, 29 Nov 2024 02:31:57 -0500
X-MC-Unique: dyEKsDi5OUOzlDFc5OupOQ-1
X-Mimecast-MFC-AGG-ID: dyEKsDi5OUOzlDFc5OupOQ
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-211fcbd2325so17199305ad.1
        for <kexec@lists.infradead.org>; Thu, 28 Nov 2024 23:31:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732865516; x=1733470316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znTNIV4yiUpsXZL1w3uAqvfGDGwGUOkw2J9EURHxCtI=;
        b=qCuIwvG7TsSpFB20tLadkBPhYaHvF/EEDAMB/vDAYkl/+YUTyueY42gbdPdK/LwzWw
         DJfVGSp5PzeAz8l8Hca7FODzr4ZEIfURIXLQVnyHvV0rdGRQAtnDxg+ebY9/ifXspJf6
         3uy7chrBTL4HAmIO+/VLUh+bQlC2RTYpXqiYvot49i23KZoXAhhxMheB3sXcrYz2a0kn
         srYg/tYkYkL9zU52S/Pry2GXoDzCT7QrPAz2Ekm52XYinlKWWLUXc2mlG9NXvg9G9sM2
         VeekByX6Vmpf+fDlXKlYSTxEN7ZKJmZdJHgWZbESJk62JaUMkYFt4RxSMQkGbbPn+syb
         L1OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw68SjBEpsT5OAw2/QctPr4GH4sfRQu1F+vgM4NvbEl0qC6ypYimgqfKKCgZIlM1zRAgLYOw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwoH66nw8AWp1UEhaKYyejJDa3I2HJqlPoQ2F6RGDAL3dbiyvDO
	pZe4sB5ZC/rJ0FShM8ytQ1kYmSJXv6InBDk9354YXE96B7vuMjoPhFlagQ+ghbEOe8iTvP3R5d9
	67JQuJMxpkZmkwLhLY1npJk6Q3hMknnfzs1JmQuviIkWOrChKO1udK5VxyQp0tolVK83v4POASu
	OQWppXuk52M08GFngDKsId93EX8iZBEwxC
X-Gm-Gg: ASbGnctSiM57vTOss8yM83OHR5RnmX+G8kpcvSkuTV0RCdXyrHeogzd/fxiNO1Qubj1
	RQ6LsNyfxmptUGmX02GKFnUnUVTr4HqEn
X-Received: by 2002:a17:902:d551:b0:211:f8c8:372c with SMTP id d9443c01a7336-21501381ba1mr114779845ad.21.1732865516085;
        Thu, 28 Nov 2024 23:31:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh9PVUdRddFYSNm3UAC8iohKaFfKlk5Hz1e9QnkR2ed+tnFKg6KvsdnxD7bVahLsd/3R//CZpc/mtOTZkKAJE=
X-Received: by 2002:a17:902:d551:b0:211:f8c8:372c with SMTP id
 d9443c01a7336-21501381ba1mr114779725ad.21.1732865515779; Thu, 28 Nov 2024
 23:31:55 -0800 (PST)
MIME-Version: 1.0
References: <20241112185217.48792-1-nsaenz@amazon.com> <20241112185217.48792-2-nsaenz@amazon.com>
 <CALu+AoTnrPPFkRZpYDpYxt1gAoQuo_O7YZeLvTZO4qztxgSXHw@mail.gmail.com>
 <D5XXP2PU3PUK.3HN27QB1GEW09@amazon.com> <CALu+AoSDY6tmD-1nzqBoUh53-9C+Yr1dOktc0eaeSx+uYYEnzw@mail.gmail.com>
In-Reply-To: <CALu+AoSDY6tmD-1nzqBoUh53-9C+Yr1dOktc0eaeSx+uYYEnzw@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 29 Nov 2024 15:31:50 +0800
Message-ID: <CALu+AoTAQ_v7SL-_c_F74TfXWmwYMNV_MRD9zWVyiHuXfa6WtA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/efi: Apply EFI Memory Attributes after kexec
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stanspas@amazon.de, nh-open-source@amazon.com, 
	stable@vger.kernel.org, kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NPyM0b0IZWEUzSBTAypPK9UhQZ-YaJxiZjw7enSPpM4_1732865516
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_233200_697880_48FD070E 
X-CRM114-Status: GOOD (  27.45  )
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

On Fri, 29 Nov 2024 at 15:11, Dave Young <dyoung@redhat.com> wrote:
>
> Hi Nicolas,
>
> On Thu, 28 Nov 2024 at 23:58, Nicolas Saenz Julienne <nsaenz@amazon.com> wrote:
> >
> > Hi Dave,
> >
> > On Fri Nov 22, 2024 at 1:03 PM UTC, Dave Young wrote:
> > > On Wed, 13 Nov 2024 at 02:53, Nicolas Saenz Julienne <nsaenz@amazon.com> wrote:
> > >>
> > >> Kexec bypasses EFI's switch to virtual mode. In exchange, it has its own
> > >> routine, kexec_enter_virtual_mode(), which replays the mappings made by
> > >> the original kernel. Unfortunately, that function fails to reinstate
> > >> EFI's memory attributes, which would've otherwise been set after
> > >> entering virtual mode. Remediate this by calling
> > >> efi_runtime_update_mappings() within kexec's routine.
> > >
> > > In the function __map_region(), there are playing with the flags
> > > similar to the efi_runtime_update_mappings though it looks a little
> > > different.  Is this extra callback really necessary?
> >
> > EFI Memory attributes aren't tracked through
> > `/sys/firmware/efi/runtime-map`, and as such, whatever happens in
> > `__map_region()` after kexec will not honor them.
>
> From the comment below the reason to do the mappings update is that
> firmware could perform some fixups.  But for kexec case I think doing
> the mapping correctly in the mapping code would be good enough.
>
>         /*
>          * Apply more restrictive page table mapping attributes now that
>          * SVAM() has been called and the firmware has performed all
>          * necessary relocation fixups for the new virtual addresses.
>          */
>         efi_runtime_update_mappings();
>
> Otherwise /sys/firmware/efi/runtime-map is a copy for kexec-tools to
> create the virtual efi memmap,  but I think the __map_region is called
> after kexecing into the 2nd kernel, so I feel that at that time the
> mem attr table should be usable.

Another thing I'm not sure why the updated mem attr is not stored in
the memmap md descriptor "attribute" field, if that is possible then
the runtime-map will carry them,  anyway, the __map_region still needs
tweaking to use the attribute.

>
> Anyway thanks for explaining about this.  It is indeed something to
> improve.  I have no strong opinion as your code will also work.
>
>
> >
> > > Have you seen a real bug happened?
> >
> > If lowered security posture after kexec counts as a bug, yes. The system
> > remains stable otherwise.
> >
> > Nicolas
> >
>
> Thanks
> Dave


