Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC94C433EF
	for <kexec@archiver.kernel.org>; Fri, 22 Jul 2022 09:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/VsRmE6mXLLgylM+b2TX1boeBt/Kg7TZ2OMKZmJQ5Nw=; b=YM95GnshUrSH5S
	jq5nCpxNs66cY4Bc5924cH52TpTQTbe9yQHB0pWivgCFVxmqK4LHO2Sj+jKaeCRvHfIGJMXPhpyaq
	Tz3aaf7xpazVPQiA7iyQz4qTFLRg/lL0TFM7qN4tHaROKs8zo8iExDu2LPw8kSOi6gbZyRTNgQxqM
	g9VPrQ4YKFLs0JpTY1/INr2GG0PFvKKS3W30XZFt6mtmfb50LRHmQfDN6gP9NOc9JAY7eytyHfMyd
	9Xh7YbTapLvCJTBideSy68mwiapD5CMAtxv70O9KjMExcTHigi16KpE9P14Hy2hi1nuHv8JOMWDpL
	3+M8XUHnuQLP6zyTCe6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEpD0-001w3L-2f; Fri, 22 Jul 2022 09:44:34 +0000
Received: from mail-qt1-f179.google.com ([209.85.160.179])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEpCw-001w0O-Mn
	for kexec@lists.infradead.org; Fri, 22 Jul 2022 09:44:32 +0000
Received: by mail-qt1-f179.google.com with SMTP id bz13so3114397qtb.7
        for <kexec@lists.infradead.org>; Fri, 22 Jul 2022 02:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njvi007IPZLoUToBw/3oPRzvfKBBxiE1LtWmOJ0CDkM=;
        b=ZwkR4imV0mWlNvQqKCuxYTeqNWUbtvL4Wc82RVqvhpI2dFUfjIsq2zu2Vxz88gsU3n
         gicfAgptXoDE5Y3UJrsR2Tc6yln0hAygycdj7nKkLZYNqM2Dx0HeoS7sc0UvI4XoR8bf
         Z0ONs1RfcrVRdJ3c/SS04UQMLJyjZQu1yBMrb8xa1r141a+z0gqN8gISYplH/05qGsJA
         /0RYLtjxdAkQbUKy/sp8GX/qtRWySf2yLDBja0KOtotP+NPbigIgnyp42ioUqW6AJGxN
         CzFcMnqsbR7O+pyJA0NOq+aKsfusSjbxIP9k4OagK3hYXTj4iFjv7TkSFqWYNyw6GvZq
         amlA==
X-Gm-Message-State: AJIora+nFfxzQ5XnG8PMEfRvQKMtn+psoGqai+m4TcbcL249ofYp+iHJ
	Z6ZWLTjXfKUnoy6s0hFLfZtpcYRvWoLMdg==
X-Google-Smtp-Source: AGRyM1vJXmjPBleGxiEvMMRnaj+Zh+mhprQTkgAx0EDhrL1AuFjXYsQouqnHLgO74czihJ1sbK+7HA==
X-Received: by 2002:ac8:5987:0:b0:31e:ec6c:9b64 with SMTP id e7-20020ac85987000000b0031eec6c9b64mr2197835qte.520.1658483067347;
        Fri, 22 Jul 2022 02:44:27 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id r6-20020a05620a298600b006a787380a5csm3247252qkp.67.2022.07.22.02.44.26
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 02:44:26 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id c131so7120326ybf.9
        for <kexec@lists.infradead.org>; Fri, 22 Jul 2022 02:44:26 -0700 (PDT)
X-Received: by 2002:a05:6902:38c:b0:670:b6bc:6ed5 with SMTP id
 f12-20020a056902038c00b00670b6bc6ed5mr2008042ybs.604.1658483065858; Fri, 22
 Jul 2022 02:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220721015605.20651-1-slark_xiao@163.com> <20220721154110.fqp7n6f7ij22vayp@kafai-mbp.dhcp.thefacebook.com>
 <21cac0ea.18f.182218041f7.Coremail.slark_xiao@163.com> <874jzamhxe.fsf@meer.lwn.net>
 <6ca59494-cc64-d85c-98e8-e9bef2a04c15@infradead.org>
In-Reply-To: <6ca59494-cc64-d85c-98e8-e9bef2a04c15@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 Jul 2022 11:44:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWSCHW4WzXPr95SyAQ3OnMdyO9_PNLAMA_38osV2LMt=Q@mail.gmail.com>
Message-ID: <CAMuHMdWSCHW4WzXPr95SyAQ3OnMdyO9_PNLAMA_38osV2LMt=Q@mail.gmail.com>
Subject: Re: [PATCH v2] docs: Fix typo in comment
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Slark Xiao <slark_xiao@163.com>, kafai <kafai@fb.com>, 
	Baoquan He <bhe@redhat.com>, vgoyal <vgoyal@redhat.com>, dyoung <dyoung@redhat.com>, 
	ast <ast@kernel.org>, daniel <daniel@iogearbox.net>, andrii <andrii@kernel.org>, 
	"martin.lau" <martin.lau@linux.dev>, song <song@kernel.org>, yhs <yhs@fb.com>, 
	"john.fastabend" <john.fastabend@gmail.com>, kpsingh <kpsingh@kernel.org>, sdf <sdf@google.com>, 
	haoluo <haoluo@google.com>, jolsa <jolsa@kernel.org>, 
	"william.gray" <william.gray@linaro.org>, dhowells <dhowells@redhat.com>, 
	peterz <peterz@infradead.org>, mingo <mingo@redhat.com>, will <will@kernel.org>, 
	longman <longman@redhat.com>, "boqun.feng" <boqun.feng@gmail.com>, tglx <tglx@linutronix.de>, 
	bigeasy <bigeasy@linutronix.de>, kexec <kexec@lists.infradead.org>, 
	linux-doc <linux-doc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, linux-cachefs <linux-cachefs@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_024430_777055_8CCD7AD5 
X-CRM114-Status: GOOD (  28.11  )
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

On Thu, Jul 21, 2022 at 8:52 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 7/21/22 11:36, Jonathan Corbet wrote:
> > "Slark Xiao" <slark_xiao@163.com> writes:
> >
> >> May I know the maintainer of one subsystem could merge the changes
> >> contains lots of subsystem?  I also know this could be filtered by
> >> grep and sed command, but that patch would have dozens of maintainers
> >> and reviewers.
> >
> > Certainly I don't think I can merge a patch touching 166 files across
> > the tree.  This will need to be broken down by subsystem, and you may
> > well find that there are some maintainers who don't want to deal with
> > this type of minor fix.
>
> We have also seen cases where "the the" should be replaced by "then the"
> or some other pair of words, so some of these changes could fall into
> that category.

Yes we have:

    --- a/arch/m68k/coldfire/intc-2.c
    +++ b/arch/m68k/coldfire/intc-2.c
    @@ -7,7 +7,7 @@
      * family, the 5270, 5271, 5274, 5275, and the 528x family which
have two such
      * controllers, and the 547x and 548x families which have only one of them.
      *
    - * The external 7 fixed interrupts are part the the Edge Port unit of these
    + * The external 7 fixed interrupts are part the Edge Port unit of these
      * ColdFire parts. They can be configured as level or edge triggered.
      *
      * (C) Copyright 2009-2011, Greg Ungerer <gerg@snapgear.com>

And that's already been fixed
https://lore.kernel.org/lkml/6fe2468a-9664-30f7-7f17-9093289eb4b6@linux-m68k.org

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
