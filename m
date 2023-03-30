Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1753C77B60
	for <kexec@archiver.kernel.org>; Thu, 30 Mar 2023 09:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7dp0xo3ddwjdu31hR6KPS1RwskIzhfHUFSa6Uv9bTRc=; b=1oNnvlDkKWPNUR
	J2AhiF88CEFCbMFv3Lj2YwSNNA9S6tXb0sHJXHVKNNBPFJywQQOedXmIrm8fzkSYlvUJ+TobThgv6
	qc++PQooBCGIfGB++Ui8Yf3IBoHKJHsFRVR61HgAGg2NF8jjb3dS+vsX52NKtBig4ln56+DXpYGYM
	Ou3/Y9Gv8if5L61GnB0Q5qqwmlcu1UgcNKOKKAzKNNPC7C4n6RaVH1gCEEbiqu2Y8XAAngMAmPGCi
	tV9zrUTU7//IzXuv1uDIFWVeAjrdvAkAvi8cgI418ATLYv+YyORDieo8nxNmfoBvGkGhH14irEp7q
	z7u69ytruUDDNHvIogvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phosX-003L0h-2S;
	Thu, 30 Mar 2023 09:47:33 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phosV-003Kyo-04
	for kexec@lists.infradead.org;
	Thu, 30 Mar 2023 09:47:32 +0000
Received: by mail-pj1-x102f.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so19012857pjz.1
        for <kexec@lists.infradead.org>; Thu, 30 Mar 2023 02:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680169647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OdosBDolGQNzQB/45PIpdghJGHYdgirOF9Wp82woz8M=;
        b=DzY3/3o26OIw7qcpZgeVcNxZuUJ5S5Hh2cq7op2GiHG/qGCmRrKe7/N+OfJAji7oq8
         QJPrDLRHfhipXnJ+dBbB4+BuUxhwlHXYHrfSQevBnmY+1/uHTzJd01Pu7e+5XI8LX5rF
         EAaCmJc0LDsxQhhTCiA03yQHOAGcbec4WI2dU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680169647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OdosBDolGQNzQB/45PIpdghJGHYdgirOF9Wp82woz8M=;
        b=gfBoaya5ezIouSuuAuAEieNnbkUE9INS8o292+fvTX7bFxfG0Y27I+sBC59rxI9GyQ
         f/kOw4Nqq8JKFYXcCUkVZocyGSaP7A9tRO6DQmuS2isZ+4jG9vQTeik1uuPMQSGObrwB
         Vp+t8vGkmWAYGkvKIYcC0pzS6Cp6lpyS2ekkZbYC+CLgLvtXG6nlJxyPB05eTF+oZqhO
         RVPw36ZQxiS+PJ3tSIfn8Llmh9tns7YwGWy2/bhN+oJhZUapzQHfwcwVQhStllDDRn4y
         xpQGSnR0ggg6cFL3OlHX5QBZw5KUKV30Hjq2eeHg1UP8sWksdd/YcwtDMQPgD0ZH92dh
         6USg==
X-Gm-Message-State: AAQBX9dshrjUbiHBYx8lMq0f8OrRRw2eaWLgmUrqT3/C4mv6Ou22TN1S
	+wclG71o7PZBa5rDWvFwHfkG4f+jew2Zgho9C0QXNg==
X-Google-Smtp-Source: AKy350ZeNl8nt/eMSUyg5lQgrgxXbfr9IkW+LgtHJNEde+xI1HxW8s1Qpdt8cWa8qlm2waNYNXVYpQ==
X-Received: by 2002:a17:90b:4ace:b0:237:d2d8:3256 with SMTP id mh14-20020a17090b4ace00b00237d2d83256mr24969755pjb.20.1680169647038;
        Thu, 30 Mar 2023 02:47:27 -0700 (PDT)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com. [209.85.214.179])
        by smtp.gmail.com with ESMTPSA id hv19-20020a17090ae41300b0023f8bdc4a7fsm2841236pjb.14.2023.03.30.02.47.26
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 02:47:26 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id o11so17578808ple.1
        for <kexec@lists.infradead.org>; Thu, 30 Mar 2023 02:47:26 -0700 (PDT)
X-Received: by 2002:a17:90b:2d82:b0:23b:349d:a159 with SMTP id
 sj2-20020a17090b2d8200b0023b349da159mr2215812pjb.3.1680169645576; Thu, 30 Mar
 2023 02:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v4-0-1340518f98e9@chromium.org>
 <20230321-kexec_clang16-v4-1-1340518f98e9@chromium.org> <ZCU+63H7GzPlL6QJ@kernel.org>
In-Reply-To: <ZCU+63H7GzPlL6QJ@kernel.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 30 Mar 2023 11:47:14 +0200
X-Gmail-Original-Message-ID: <CANiDSCsbmmkfRGC-GvhX-RSZGU0CT7ZqLo6Z=RmccoM7zbPcsA@mail.gmail.com>
Message-ID: <CANiDSCsbmmkfRGC-GvhX-RSZGU0CT7ZqLo6Z=RmccoM7zbPcsA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kexec: Support purgatories with .text.hot sections
To: Simon Horman <horms@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	Baoquan He <bhe@redhat.com>, stable@vger.kernel.org, Ross Zwisler <zwisler@google.com>, 
	Philipp Rudo <prudo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_024731_098306_9A9C24FC 
X-CRM114-Status: GOOD (  33.41  )
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

Hi Simon

Thanks for your review!

On Thu, 30 Mar 2023 at 09:49, Simon Horman <horms@kernel.org> wrote:
>
> On Mon, Mar 27, 2023 at 05:06:53PM +0200, Ricardo Ribalda wrote:
> > Clang16 links the purgatory text in two sections:
> >
> >   [ 1] .text             PROGBITS         0000000000000000  00000040
> >        00000000000011a1  0000000000000000  AX       0     0     16
> >   [ 2] .rela.text        RELA             0000000000000000  00003498
> >        0000000000000648  0000000000000018   I      24     1     8
> >   ...
> >   [17] .text.hot.        PROGBITS         0000000000000000  00003220
> >        000000000000020b  0000000000000000  AX       0     0     1
> >   [18] .rela.text.hot.   RELA             0000000000000000  00004428
> >        0000000000000078  0000000000000018   I      24    17     8
> >
> > And both of them have their range [sh_addr ... sh_addr+sh_size] on the
> > area pointed by `e_entry`.
> >
> > This causes that image->start is calculated twice, once for .text and
> > another time for .text.hot. The second calculation leaves image->start
> > in a random location.
> >
> > Because of this, the system crashes inmediatly after:
>
> s/inmediatly/immediately/
>
> >
> > kexec_core: Starting new kernel
> >
> > Cc: stable@vger.kernel.org
>
> Maybe a fixes tag is warranted here.
>
> > Reviewed-by: Ross Zwisler <zwisler@google.com>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  kernel/kexec_file.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index f1a0e4e3fb5c..25a37d8f113a 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -901,10 +901,21 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
> >               }
> >
> >               offset = ALIGN(offset, align);
> > +
> > +             /*
> > +              * Check if the segment contains the entry point, if so,
> > +              * calculate the value of image->start based on it.
> > +              * If the compiler has produced more than one .text sections
>
> nit: s/sections/section/
>
> > +              * (Eg: .text.hot), they are generally after the main .text
>
> If this is the general case, then are there cases where this doesn't hold?

When looking at this issue, I have only seen .text.hot after .text.
But I cannot warantee that future versions of llvm or gcc decide to
swap the order.

I am going to add a WARN whenever there are two overlapping .text
sections so the user has the chance to update their linker script.

>
> > +              * section, and they shall not be used to calculate
> > +              * image->start. So do not re-calculate image->start if it
> > +              * is not set to the initial value.
> > +              */
> >               if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
> >                   pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
> >                   pi->ehdr->e_entry < (sechdrs[i].sh_addr
> > -                                      + sechdrs[i].sh_size)) {
> > +                                      + sechdrs[i].sh_size) &&
> > +                 kbuf->image->start == pi->ehdr->e_entry) {
> >                       kbuf->image->start -= sechdrs[i].sh_addr;
> >                       kbuf->image->start += kbuf->mem + offset;
> >               }
> >
> > --
> > 2.40.0.348.gf938b09366-goog-b4-0.11.0-dev-696ae
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> >



--
Ricardo Ribalda

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
