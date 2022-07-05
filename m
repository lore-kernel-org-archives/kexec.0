Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747C1C43334
	for <kexec@archiver.kernel.org>; Tue,  5 Jul 2022 14:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xWfze6FLlbYi9bqTTkCKvtn8rHi5ab1x5iGCdKlRHJM=; b=xLYBEGfkAuI5Yf
	CKaFJhz0L0mSLNUjliqEJkJgRS3qy7qU8LSyq66cXz7CeB4c9/L6VQ7fxR66YVPuzxRx692y42BLj
	BCtAjRTUlK+ba1rlTt/dkKFy2Tz8osj7XX1d6nOBxdEJrPeBqEqSymnhbKVEH+wTJTssr0P+ldN+I
	eN38QEldd1YaQQyimWNOh0liUaJyumpWwvPYlqo+vmkR6XQ35uuMjFZR6qj+dr6QrhuBQ1SIYWJbs
	GWYXzOvCrrSw2HfBY5Vvirlud5folN6SGsBmoUCRA7MglCkQNRiEVhNObB0WCHTTQEebLUx/5Bv+W
	tm3rmnhX4sa3/dWHfObw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8jIi-000k6D-14; Tue, 05 Jul 2022 14:13:16 +0000
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8jIf-000k3g-99; Tue, 05 Jul 2022 14:13:15 +0000
Received: by mail-oi1-x22f.google.com with SMTP id be10so16271065oib.7;
        Tue, 05 Jul 2022 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QI3B1vIlvYkplD/OGFLDNG9KjTXHUoGMSflSfPKXG5I=;
        b=DfVQLNy96aUWYf+Jt0CfmE7H2lYMo7TQ0F5goqxT/ODcU4vuDqq+EKv0pC/J4mrPhK
         ckjbHfhDcM5wrntYgLzgf4zdR7zfyhv8EjVmBawbawurUni6XstEXFQUYxjf1NYyODD6
         JPzGBSjXAh7267svFQP1/88rAhJ9b46HIRC+vRsLsjkfBpF4DE0b+rjSZsyAN1p5kBe7
         r30gzYYQP8a2ucHu2cTDVoEVEYJ3nmw3FmEew6OWMWC8nTEOWbFg2aiYec8ekbJVaFTy
         +0Gqw+CHRpYHpNyO8unp5PRDhpgUZuluMmI8VlZbN3j3LhiyufpNrFpy5akiSIhVBsNi
         PTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QI3B1vIlvYkplD/OGFLDNG9KjTXHUoGMSflSfPKXG5I=;
        b=GHwvjhp9Ag9tFkypaw3vGz8WmN57uWXEEzDtOuTfLsp1m6mXy5TQQJ87NYlB1PcjUY
         3L0ZjHkCFK56oZp3BExkPgTRMaT/7Y06UALICUuIarCCz+8acmsQjPjRZ9yslb+yTSXy
         Oqqf9ogdMu52gPJr94gqMt83ZniAivcUjMNhs+YBisLZ14WHOk6o/Fs1laUoD+DDAeOp
         wKBIv4EaApC/l257LM5/qKuoa5oBFm9xH4wOq2d4WXXhkEf17n0n7gJdPkac5opVLO3Y
         dQwELiYno9uYtB5gQmn0SuBz2LWEZdUTyOQ8LRWOfOIUReetMjroXJSPkW9WaqzbsflD
         stbQ==
X-Gm-Message-State: AJIora/Bwums7yJ6uCONiIESSYAgYe2FfoithKvxypejQHQ2l0AzOLKw
	5kIN//JBhOoWA+khBbfOvALDedKXVcwY6OXNdJC7y1ERBIg=
X-Google-Smtp-Source: AGRyM1uKWnxIsrOjuSrESBMFHOOIgp08dNiqIPuvwPDUKe/GYZCd8M/st/cAl0YrkegNHZK4GxiYvRIkoO4isGqxnes=
X-Received: by 2002:a05:6808:2099:b0:335:1606:2504 with SMTP id
 s25-20020a056808209900b0033516062504mr19434401oiw.110.1657030389377; Tue, 05
 Jul 2022 07:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <00c521b5b872b06c9350145c7d39fe7c@mailhost.ics.forth.gr>
 <CA+zEjCs0n8KA_oaFKJbaP6kNohDA=qJHvUKhePUK+hDFJSbHig@mail.gmail.com>
 <CA+zEjCscL1dWASm7u20p1B7-JeJaGTXiWG=K1XiWtZj=VFX+WQ@mail.gmail.com>
 <d75edc49681473bf8b88e474ae61b524@mailhost.ics.forth.gr> <CA+zEjCsc60mxPynL7DDGxfaUz7uif3uXPx3atnHbvM3ei_TETA@mail.gmail.com>
 <2ec74f4bd0e7b7cb4b579e9e042fc035@mailhost.ics.forth.gr> <CALecT5gdqW9Na_s9PiFAZt0u=_uPCu0zYdUCb4UfuSV6fM_Q+w@mail.gmail.com>
 <75409de5-2351-3ab2-5162-33ebd8d30749@ics.forth.gr>
In-Reply-To: <75409de5-2351-3ab2-5162-33ebd8d30749@ics.forth.gr>
From: Yixun Lan <yixun.lan@gmail.com>
Date: Tue, 5 Jul 2022 14:12:58 +0000
Message-ID: <CALecT5gA-h7p__BZT=okWJCANz9oHE8R4kwHC6hJOPKGMe+Fkg@mail.gmail.com>
Subject: Re: RISC-V: patched kexec-tools on github for review/testing
To: Nick Kossifidis <mick@ics.forth.gr>
Cc: Alexandre Ghiti <alexandre.ghiti@canonical.com>, ebiederm@xmission.com, 
	kexec@lists.infradead.org, linux-riscv <linux-riscv@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, Alexandre ghiti <alex@ghiti.fr>, 
	Mike Rapoport <rppt@kernel.org>, geert+renesas@glider.be, 
	Stephano Cetola <scetola@linuxfoundation.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup.patel@wdc.com>, 
	Atish Patra <atish.patra@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_071313_355354_73006727 
X-CRM114-Status: GOOD (  13.19  )
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

HI Nick

On Tue, Jul 5, 2022 at 12:24 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> Hello Yixun,
>
> On 7/2/22 14:35, Yixun Lan wrote:
> > hi Nick
> >
> > ping, any update for this? any new patch for kexec-tools?
> >
> > I'd also like to try kexec on unmatched board, and encounter the same error
> > as Alexandre Ghiti reported, generally I'm using almost same cmdline
> >
> > Yixun Lan
>
> The kernel-side patches have already been merged upstream, for
> kexec-tools there are some people working on fixes, I'm expecting pull
> requests on the github before I do a pull request upstream. You should
> be able to use kexec without initrd.
>
> Regards,
> Nick

Thanks for the reply and updated information
I was looking forward to use "--initrd" in order to boot a complicated OS,

Anyway, I will try kexec without initrd, and please keep me posted
when there is PR

Regards

Yixun Lan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
