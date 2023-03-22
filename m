Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A4BC6FD1F
	for <kexec@archiver.kernel.org>; Wed, 22 Mar 2023 20:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v9EqSTSwmkrrlFRk7Qlc/+OS9b57DTW8aVZw+ELhGyk=; b=rT27haVcGbnzMB
	LwUKJtp1qh93EPUcMhSa47FNhGJYtW9ozMZyn6c8XYw2KV06ntCQJvbVkyEcSMyNoomt+0X9Qh2wp
	JCe7WiQatlA5q4GVY2RaHG+oTx4nB14CmKefOUMDERkFLC7yaJ0JT5gkSQOL8OLbU/Q+p61Dxao1Z
	/bXzKhCoSI+QjnblE3TyAs8Zdnb+VM9oLo3hn+2IhHYysquKxKC0NODWrwAgZTIsX/+M0HZr8qXNW
	nTcoQMSbK+zz4tFqRBxvkx7fKkYFCXryzse6vD6q72qoGg8ueDY71BDitD/U1nMxllmRWseOIdWmP
	G0kYPTTwJAn4VgnRYfUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pf5Wl-00HP9Q-0n;
	Wed, 22 Mar 2023 20:57:47 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pf5Wj-00HP7j-03
	for kexec@lists.infradead.org;
	Wed, 22 Mar 2023 20:57:46 +0000
Received: by mail-pg1-x52a.google.com with SMTP id h14so11173768pgj.7
        for <kexec@lists.infradead.org>; Wed, 22 Mar 2023 13:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679518661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SWUgefOoTtNi3gmeeAtf1bvYzy9AkdsHRyOlhL+jM08=;
        b=Yhd1yrx0b4txAe0mKga9eIzMZjv6Ac0IA742m2F2UwJmtSwssQ3wEyuVYlfzIlL6ZB
         DmXCGMM4V9rHlco2Sis4m8J93/i7uzCuvWG2gj41DFWk+46Qs7LX11fjdNptN/KWSAJ8
         SSNX5DpHUMNjAaGRueMHyYPx+yLDMMXxFZCnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679518661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWUgefOoTtNi3gmeeAtf1bvYzy9AkdsHRyOlhL+jM08=;
        b=DTZmk9oB/lRdoL/821blaTf6e36KDjCxoIycUdWxReMhgca2cY5Awt/xYbp7pIg52I
         f2xWZi3y55CtBPLm5G8s9YRFEeAL+8g3C/KGLKfSvT2qjwVQv5J1ONf+1cXdy6UYgHD+
         T9p4vzWXxT1m62iCGYYzYhWDZ6an1NjO5HjkRGzjJJ6GQcBG/crfNvvk8klf7CyFiqKK
         fYahCuUfbhMiL7NeuSlKgWsN+XbHHHg6J1dmWcNOwxbvJhtz7biUEo5/FnHlB33NFSZP
         okHZ/awtEe1GPD0w+tLRUmVmJCYkTQk0iac4Ibsj3DfmyNehSKeIhLoUlkAM3wgduxGo
         +gyA==
X-Gm-Message-State: AO0yUKXMQt3MKsrqlqoSphLJYrWDY5VATRwc7CUZq9nUflPoJEESgmvS
	Hl4qQ2Qi1mO6y4HhGXHFwyCm/dUguwYaJxHq3RjVFA==
X-Google-Smtp-Source: AK7set/859Z4/FqCbHyYaZHD+qlpnz6QRMkMbNmiuxnB04LAeoJpCoihe2csfNzDUOTLee0vyqeEdQ==
X-Received: by 2002:aa7:9619:0:b0:627:eb0a:56e9 with SMTP id q25-20020aa79619000000b00627eb0a56e9mr4101256pfg.29.1679518661294;
        Wed, 22 Mar 2023 13:57:41 -0700 (PDT)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com. [209.85.214.182])
        by smtp.gmail.com with ESMTPSA id g6-20020aa78186000000b00592417157f2sm10817810pfi.148.2023.03.22.13.57.40
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 13:57:40 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id w4so12351055plg.9
        for <kexec@lists.infradead.org>; Wed, 22 Mar 2023 13:57:40 -0700 (PDT)
X-Received: by 2002:a17:90a:5ac7:b0:23b:3d0b:f162 with SMTP id
 n65-20020a17090a5ac700b0023b3d0bf162mr1549778pji.7.1679518659894; Wed, 22 Mar
 2023 13:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v3-0-5f016c8d0e87@chromium.org> <20230322204217.GA3076000@google.com>
In-Reply-To: <20230322204217.GA3076000@google.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 22 Mar 2023 21:57:28 +0100
X-Gmail-Original-Message-ID: <CANiDSCvTMmqGxQSYcs+p7v6y-aoE0HSZLuKkHWQA1O-dpkKxqQ@mail.gmail.com>
Message-ID: <CANiDSCvTMmqGxQSYcs+p7v6y-aoE0HSZLuKkHWQA1O-dpkKxqQ@mail.gmail.com>
Subject: Re: [PATCH v3] kexec: Support purgatories with .text.hot sections
To: Ross Zwisler <zwisler@google.com>
Cc: Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_135745_083920_311947E3 
X-CRM114-Status: GOOD (  34.41  )
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

HI Ross

Thanks for your review.

I think we should backport this one, in case people use old kernels
with new compilers.
If there is a v4 i will resend it with your tag and the stable tag.

Thanks!

On Wed, 22 Mar 2023 at 21:42, Ross Zwisler <zwisler@google.com> wrote:
>
> On Wed, Mar 22, 2023 at 08:09:21PM +0100, Ricardo Ribalda wrote:
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
>
> Reviewed-by: Ross Zwisler <zwisler@google.com>

Cc: stable@vger.kernel.org
>
> > ---
> > kexec: Fix kexec_file_load for llvm16
> >
> > When upreving llvm I realised that kexec stopped working on my test
> > platform. This patch fixes it.
> >
> > To: Eric Biederman <ebiederm@xmission.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Philipp Rudo <prudo@redhat.com>
> > Cc: kexec@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> > Changes in v3:
> > - Fix initial value. Thanks Ross!
> > - Link to v2: https://lore.kernel.org/r/20230321-kexec_clang16-v2-0-d10e5d517869@chromium.org
> >
> > Changes in v2:
> > - Fix if condition. Thanks Steven!.
> > - Update Philipp email. Thanks Baoquan.
> > - Link to v1: https://lore.kernel.org/r/20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org
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
> > +              * (Eg: .text.hot), they are generally after the main .text
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
