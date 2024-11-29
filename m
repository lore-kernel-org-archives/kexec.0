Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAC3D6EBE2
	for <kexec@archiver.kernel.org>; Fri, 29 Nov 2024 07:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FWT0OxMsEzDV+GInq5dR2gW9nX3HUCC+dF6QXlOVL+E=; b=ihg8QHV1vuxlqC5TGJ8OiZbO4R
	Jx7aMZSnuqQ6+eoh6LTdonCFR1k8Vk/PAJdiZzyAWAsQP6EzbSBxeg47tR3rB6yYP8sSZqJXDUtze
	fRk+fmUtPI16uuJWwG+2BQw/JD+ac0l75okOK3vKtTYiDITjDLweUa5rpOKVpZUtu7B+wauAkuURT
	PrV+3CVvInCcrQufrYUEzuPyILpLvpWyPSkqGK0CrJrfasRsQms4NQlWPyuL4J9WNX6LP84uB3uen
	d3Ops6uVjPcC1nJL8sp5m76umnZvjZgVdiW4KBPQxjsNjp3cqwysMZn0Yc1Nv+mblGAK7zqt0u7rE
	j7ww2K3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGvAJ-0000000H3Rj-0pgv;
	Fri, 29 Nov 2024 07:11:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGvAF-0000000H3R6-23aB
	for kexec@lists.infradead.org;
	Fri, 29 Nov 2024 07:11:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732864301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWT0OxMsEzDV+GInq5dR2gW9nX3HUCC+dF6QXlOVL+E=;
	b=Ur5LtPlItrV9wlHqzFlObVfsUJP1Ixx4MvHW+4rdigr/mu59S6PGa1x+j3EHvjb5XIr++4
	MuPEJtMNkN6dxlwUh2s1pEDiyqHMYrQib5wFbBvKI93jyz4ibS9BL7td2cb+sETFSR3ND7
	GBC3l5Swh2r7nuQHmFz9jqNMSYVWcz0=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-mFiq-zEsOQCQwRDax1_8iA-1; Fri, 29 Nov 2024 02:11:39 -0500
X-MC-Unique: mFiq-zEsOQCQwRDax1_8iA-1
X-Mimecast-MFC-AGG-ID: mFiq-zEsOQCQwRDax1_8iA
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83e5dd390bfso185842639f.1
        for <kexec@lists.infradead.org>; Thu, 28 Nov 2024 23:11:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732864298; x=1733469098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWT0OxMsEzDV+GInq5dR2gW9nX3HUCC+dF6QXlOVL+E=;
        b=Hjcv9ijIqxFdZRy/Apt5K+iiEYRYv8JC/X3QsQVrr7MIb0sGwSYVVxzs79c5cJEjdS
         2EZ53VCe+TN2l0yFDNnHlKvuBeEfYEZyc5HBXJu3YRAKuGLeSwpTDLkGGTx0uJfZC4v/
         i07YzEInXxv4+uIHN/fvXfk6OF+YyPEEHGPycyk2Ck4NdE2WXBFR6Z6sGp/MX4UrLk8z
         CU0C/M03VUOTpCUKWMlzD6qbMkGQ8paPExnHWG6UbAFPiMdy5CUQZM9SKAqumKCh8ocE
         KwKVzBHbva6k/5goeWNtOjXKI8/pUVcYcX5RznV6WYaxlfBslQBhbnkIUPK7oAgKRLoe
         hnJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjlpoyFmaOgkBpUTf+g5XxBeM5Q/MTIQpmY0kPL7H1ONTSFoPJ3lfS+wc4Md85Aa6LT6ZEEw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxbriLdUsKOu6cZM+m0G8msDziVHJUmwA2jmAxdFhRmmf646mWp
	1uEfKuJcaS9oYL0A4r8bSbhvVwJYH1Bm8ZViFPA/p6cOJB//PiSZzf9axOj/DYrr5HgksgIMShy
	gxFYZOpVb+pA0Q4mPw+fMC9zIV9chdKC8OeGrXyEWeZ4MtyaHoL4Qlie+KaBHW+2mtCmvGjAc+T
	+308f4aPYwSL6EwAJDj+ImQWA+LR6dvn3E
X-Gm-Gg: ASbGncvBCIzfTdQt1r7+4x58aN9CkqLznQCoW6KK/s+kEslv8DGTYhYBxm+CMIz+w8i
	M6wfdtYBqjHJlBME4JObVb3C3pNwgA/le
X-Received: by 2002:a05:6e02:1b01:b0:3a7:9b16:7b6c with SMTP id e9e14a558f8ab-3a7cbd45e72mr58232355ab.9.1732864298354;
        Thu, 28 Nov 2024 23:11:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaJIDjEubmCy0aOLU9g/LdsGvxQayrOWZjhM4HHxnHxAtqspZGb5f7pNvetVWe16XLz7C0JNOwniYKeQx8YGA=
X-Received: by 2002:a05:6e02:1b01:b0:3a7:9b16:7b6c with SMTP id
 e9e14a558f8ab-3a7cbd45e72mr58232215ab.9.1732864298121; Thu, 28 Nov 2024
 23:11:38 -0800 (PST)
MIME-Version: 1.0
References: <20241112185217.48792-1-nsaenz@amazon.com> <20241112185217.48792-2-nsaenz@amazon.com>
 <CALu+AoTnrPPFkRZpYDpYxt1gAoQuo_O7YZeLvTZO4qztxgSXHw@mail.gmail.com> <D5XXP2PU3PUK.3HN27QB1GEW09@amazon.com>
In-Reply-To: <D5XXP2PU3PUK.3HN27QB1GEW09@amazon.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 29 Nov 2024 15:11:33 +0800
Message-ID: <CALu+AoSDY6tmD-1nzqBoUh53-9C+Yr1dOktc0eaeSx+uYYEnzw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/efi: Apply EFI Memory Attributes after kexec
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stanspas@amazon.de, nh-open-source@amazon.com, 
	stable@vger.kernel.org, kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AM_bI56IVzqnE-04s_OpmuU8NeNtSAcIKjtA5Rh4A7o_1732864298
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_231143_628746_3CA36496 
X-CRM114-Status: GOOD (  21.44  )
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

Hi Nicolas,

On Thu, 28 Nov 2024 at 23:58, Nicolas Saenz Julienne <nsaenz@amazon.com> wrote:
>
> Hi Dave,
>
> On Fri Nov 22, 2024 at 1:03 PM UTC, Dave Young wrote:
> > On Wed, 13 Nov 2024 at 02:53, Nicolas Saenz Julienne <nsaenz@amazon.com> wrote:
> >>
> >> Kexec bypasses EFI's switch to virtual mode. In exchange, it has its own
> >> routine, kexec_enter_virtual_mode(), which replays the mappings made by
> >> the original kernel. Unfortunately, that function fails to reinstate
> >> EFI's memory attributes, which would've otherwise been set after
> >> entering virtual mode. Remediate this by calling
> >> efi_runtime_update_mappings() within kexec's routine.
> >
> > In the function __map_region(), there are playing with the flags
> > similar to the efi_runtime_update_mappings though it looks a little
> > different.  Is this extra callback really necessary?
>
> EFI Memory attributes aren't tracked through
> `/sys/firmware/efi/runtime-map`, and as such, whatever happens in
> `__map_region()` after kexec will not honor them.

From the comment below the reason to do the mappings update is that
firmware could perform some fixups.  But for kexec case I think doing
the mapping correctly in the mapping code would be good enough.

        /*
         * Apply more restrictive page table mapping attributes now that
         * SVAM() has been called and the firmware has performed all
         * necessary relocation fixups for the new virtual addresses.
         */
        efi_runtime_update_mappings();

Otherwise /sys/firmware/efi/runtime-map is a copy for kexec-tools to
create the virtual efi memmap,  but I think the __map_region is called
after kexecing into the 2nd kernel, so I feel that at that time the
mem attr table should be usable.

Anyway thanks for explaining about this.  It is indeed something to
improve.  I have no strong opinion as your code will also work.


>
> > Have you seen a real bug happened?
>
> If lowered security posture after kexec counts as a bug, yes. The system
> remains stable otherwise.
>
> Nicolas
>

Thanks
Dave


