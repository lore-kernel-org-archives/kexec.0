Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0209C6FD1C
	for <kexec@archiver.kernel.org>; Wed, 22 Mar 2023 14:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bVJBmfRpHRx7dCraGMEa9k9pvCqu0p6Z5/9Y6nn6NLI=; b=UfGPocqP4m1Uf8
	CRmHB1++1GfcEkDVWOo41OGcannWwSxlRFYei13zgCYUrIDgUSYnyXC3d99EI9L+hKafKhZ6GvUGD
	d/9cyBRS6NdQhA6W2usU+DcKOmgAk+zrmok1mFUMRhTM7a9wLXsm+IiHhG7CyMUgfk8Sm5YSBctlC
	vSogm/DYV5odW1YuLMYBQFP1ajO2pQ3TbpgbbLGE4hKlTuDzyFsyUvw0waNuZdWfOTDfpES8RRY5X
	MBjrnpEsz4BhmsXyDG6HxWO5Da/NvWM//apDsBNMvCZVZ6gevub/VMMs7gHHGBwgKOgj5W5pwiumF
	7H5bGe3Gku3CET5uER1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pezff-00GLJ2-28;
	Wed, 22 Mar 2023 14:42:35 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pezfY-00GLG1-2d
	for kexec@lists.infradead.org;
	Wed, 22 Mar 2023 14:42:34 +0000
Received: by mail-pj1-x1033.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so19385891pjz.1
        for <kexec@lists.infradead.org>; Wed, 22 Mar 2023 07:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679496146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pxwmBSFcZVlKRN2o7xTs6FmPgfGh/hUZt2I0jJI4Uzw=;
        b=nHKTXN4ONTE5iPdtK6bxzX88vvCyUHpzjWcZpb/oXwtbjMkfcTZLR0gkqIK7+vXLdf
         Hx/QT20vdO4irmqHBlZVajzXeMeuc6Oipd2W710G9yAWPzTv9cgjKaRypicvvGqjUEst
         7hmHt8UoW4P40d9IKBN3+QkZuznkhsk4SGg9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679496146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxwmBSFcZVlKRN2o7xTs6FmPgfGh/hUZt2I0jJI4Uzw=;
        b=A+YFWg/46RRhHV4nXUpDh2dvprnUWe5bn2oqwvPv6x0J03zW3+A5Kn5NL9IUppwUQv
         nUfRZkIVefD8kmRc0se2SBVxtZo14BtS6rLLaopUkiN8/gCFwFcaKanVqjE+TwhS5UZn
         Wr+CSMrCDbfpKZJGpv9cp/N4sd9jofEgSJEkWRuN9lQiz3Ofqw3OBFKUtSYm6QzJCQRi
         4JzHUw4DfX/PjRaid+z7bU8px+2J6k/WWxEro1HSarrap7z46lDlnfgbpScm7OFuRXbf
         gb7zK2MNLLzr3kuHo1x/b5bfvx9jGi5AdlO3y6kJ2IatH3/popaSzGGHhda/Vw6SXFbw
         0eKg==
X-Gm-Message-State: AO0yUKXzX1ZZpOj6hJpLS2Qpj75QAndqVR1aL2NcAFCInqqGhqi5gKY9
	UKAyRuiDEdjudh4GW3QDQoMWuaehJmqh13ufyPo=
X-Google-Smtp-Source: AK7set9+hgw65vGCK0M6fWspmeNpL07zJDgXuewGxjiOJJxyTxpKHwqKR99lZn7hgYEL1ImgOLdUgA==
X-Received: by 2002:a05:6a20:49a4:b0:d0:76e3:16ec with SMTP id fs36-20020a056a2049a400b000d076e316ecmr6398225pzb.13.1679496146307;
        Wed, 22 Mar 2023 07:42:26 -0700 (PDT)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com. [209.85.210.176])
        by smtp.gmail.com with ESMTPSA id c17-20020aa78c11000000b005a84de344a6sm10592706pfd.14.2023.03.22.07.42.25
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 07:42:25 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id fb38so6335257pfb.7
        for <kexec@lists.infradead.org>; Wed, 22 Mar 2023 07:42:25 -0700 (PDT)
X-Received: by 2002:a65:4308:0:b0:50f:76fb:84b7 with SMTP id
 j8-20020a654308000000b0050f76fb84b7mr856636pgq.6.1679496145212; Wed, 22 Mar
 2023 07:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org> <ZBsSBr87al9ccG96@home.goodmis.org>
In-Reply-To: <ZBsSBr87al9ccG96@home.goodmis.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 22 Mar 2023 15:42:14 +0100
X-Gmail-Original-Message-ID: <CANiDSCt_wvaHBq-Yss0QaKTtefBhWwtahFO8_jw6CPSvBwbbMg@mail.gmail.com>
Message-ID: <CANiDSCt_wvaHBq-Yss0QaKTtefBhWwtahFO8_jw6CPSvBwbbMg@mail.gmail.com>
Subject: Re: [PATCH] kexec: Support purgatories with .text.hot sections
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Philipp Rudo <prudo@linux.vnet.ibm.com>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_074228_882661_6624EF31 
X-CRM114-Status: GOOD (  29.46  )
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

Hi Steven

On Wed, 22 Mar 2023 at 15:34, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, Mar 21, 2023 at 12:49:08PM +0100, Ricardo Ribalda wrote:
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
> >
> > kexec_core: Starting new kernel
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > To: Eric Biederman <ebiederm@xmission.com>
> > Cc: Philipp Rudo <prudo@linux.vnet.ibm.com>
> > Cc: kexec@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  kernel/kexec_file.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index f1a0e4e3fb5c..b1a25d97d5e2 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -904,7 +904,8 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
> >               if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
> >                   pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
> >                   pi->ehdr->e_entry < (sechdrs[i].sh_addr
> > -                                      + sechdrs[i].sh_size)) {
> > +                                      + sechdrs[i].sh_size) &&
> > +                 kbuf->image->start != pi->ehdr->e_shnum) {
>
> Shouldn't this be: kbuf->image->start == pi->ehdr->e_shnum) {

You are absolutely right, I screwed up when I ported the code from my
test tree to the tree that I use for upstreaming.
Instead of removing all the printks I wrote code.

:S

Will resend the patch

>
> ?
>
> As you want to only do this update when it's not equal to the initial value.
> If this did work, then you may want to make sure that was the initial value.
>
> Also, please add a comment about why you are doing this check.
>
> Thanks!
>
> -- Steve
>
> >                       kbuf->image->start -= sechdrs[i].sh_addr;
> >                       kbuf->image->start += kbuf->mem + offset;
> >               }
> >
> > ---
> > base-commit: 17214b70a159c6547df9ae204a6275d983146f6b
> > change-id: 20230321-kexec_clang16-4510c23d129c
> >
> > Best regards,
> > --
> > Ricardo Ribalda <ribalda@chromium.org>



-- 
Ricardo Ribalda

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
