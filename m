Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49065E77188
	for <kexec@archiver.kernel.org>; Fri, 10 Jan 2025 06:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iUXNEHN4dNmZLXlza2GuNZGvUfLQlPXhRlKE6lFZBXA=; b=IGyXI7NS2yYoOr68Vq1HfWDwnd
	HJWIfhqe45ohqq0Wue0w9UHycxRNwiK415pHRP/jJeRUfh3kQnBKO7jHHcLqudMY1VTCFfVQaJQ02
	8r/NtCyPmNisMjSd/nQNMmi43rlkuparJzAnspw4bVIDrtRKt2zI/moQOmXOmfhzyetTolG2hxm8j
	xN7PGngi+Lr3SeRDd/hqlxNno1pLfePFgBdBzUsclze4zeTAj+sDRGRFgsjaLtT9nNm3UqWt8MBmJ
	zFOuGQXR0xpyOJs3Vzu1ryrCiQafFAlV9ZfRFKVpGvQYgPMX1FTMGoX1cXOR3vF67HL9O0cps4WrP
	o+ckUDFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tW8id-0000000EHr5-44ZQ;
	Fri, 10 Jan 2025 06:42:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tW8Oz-0000000EEnn-0lKF
	for kexec@lists.infradead.org;
	Fri, 10 Jan 2025 06:21:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736490107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iUXNEHN4dNmZLXlza2GuNZGvUfLQlPXhRlKE6lFZBXA=;
	b=GHOboUujkFjMMLrIvUx0V7sGC8aC6wmF3xP574jiKM9vOhoYE+yMvqpFwzlITaS1Bf2OV8
	M3ma3J+tzojIRDAYdba7GFB2p4OE81nBjcRE0bZC2H4gSX0JUzo9fXIkfmIme8mzecrpGL
	HYQEctMNfgWr7QhQxC9MHHoAtKLyNvE=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-TE4X2WQtOtm4p6vEv81LAA-1; Fri, 10 Jan 2025 01:21:43 -0500
X-MC-Unique: TE4X2WQtOtm4p6vEv81LAA-1
X-Mimecast-MFC-AGG-ID: TE4X2WQtOtm4p6vEv81LAA
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7e0d5899bso34739095ab.0
        for <kexec@lists.infradead.org>; Thu, 09 Jan 2025 22:21:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736490103; x=1737094903;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iUXNEHN4dNmZLXlza2GuNZGvUfLQlPXhRlKE6lFZBXA=;
        b=rv1omoQ9GNc0gVQmbLfmEG1wExbnZK8Ile1uQxSH6G/DmFf6C4Xhv3mZeag3oTBPQq
         fmbbfU0IBktyXUdGBJ/ojAbs0bWKEIjRG4dfEtyKpm+yoYvFYQIwi7gpA2045MIxapQM
         fM1YMLGBR1RXJP92gm2NQ6ySGw7HivTHrO4IbSaqtCV3O0m2ajdbBHeM8OQSmLDaxNno
         DlgzH6J+92BK0u5082/R7wA1ccC08aDx9nfNPBurb077Cvt6tRvaDZJMFEPpOl5fofJS
         37KUvgaJzbaeeJrQLqlRTSXIxxz4OPyGjXTKmBG1HL4zHQYA4tvp52FvQZFIDruLEZaO
         IFxw==
X-Forwarded-Encrypted: i=1; AJvYcCWejf6Vcj+SjEAgbOa8FDnL0aJKkB8ZIGvNlDhb3H/BWh+Se9MkjAogivX6gyEnOomfbDCqog==@lists.infradead.org
X-Gm-Message-State: AOJu0YxHmfpRHGRUO0X+2NWFai8gS+e3EXkCT1btv2qsA/i8NOyLbAjl
	S5bUtUDvygeAgnOxl62zeK6KJlGSzvYFefncEEku8mqZnjS/OJAKvFemSAGhu0OA21pYTUAKzvg
	KtZ+xip1AV4DG/e7FRDgR3ccmbtVXXINEhocO1SdhzUL4CE5GIWUn0E7kuOdvIrQT1wEGC7sibx
	Q0cGxQKTAocSU0VqK0VY1TTG72g3oZNw7i
X-Gm-Gg: ASbGnctppVRvEXh3DScxSo2rZmTX6NeRl+7/QgFGpf+9jg7PFtd9UhJ8kG3XH6dhV1m
	6Pat2jgq99zXP/O7mTxD56oxX5ntSllpse9RNcj8=
X-Received: by 2002:a05:6e02:1a82:b0:3a7:d7dd:e70f with SMTP id e9e14a558f8ab-3ce3a88a4a1mr83322935ab.12.1736490102813;
        Thu, 09 Jan 2025 22:21:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGS8AmdTRTjwQ6JLer40WoTrm1JfQ8Yz3/JsT8Lf89GsLG0bu5jdpu1EdFnY1HiwcCOf1QQppmxO31T6uA7OZ4=
X-Received: by 2002:a05:6e02:1a82:b0:3a7:d7dd:e70f with SMTP id
 e9e14a558f8ab-3ce3a88a4a1mr83322835ab.12.1736490102578; Thu, 09 Jan 2025
 22:21:42 -0800 (PST)
MIME-Version: 1.0
References: <ZuVxlJ77V2_U0HPM@darkstar.users.ipa.redhat.com> <ZvoUXjWmojyNs6dx@MiWiFi-R3L-srv>
In-Reply-To: <ZvoUXjWmojyNs6dx@MiWiFi-R3L-srv>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 10 Jan 2025 14:21:48 +0800
X-Gm-Features: AbW1kvbk_zbrTsam3cr6gte0x-Q2COBO8S0mUCphH1bcKwAodj2YNISYaK_hYVw
Message-ID: <CALu+AoTecXOZkP81QE5Fb49sHE63B+Xo2-7RTSuRNjtWWcP28Q@mail.gmail.com>
Subject: Re: [PATCH] x86/e820: update code comment about e820_table_kexec
To: Baoquan He <bhe@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TuX_mKxwW-j7mdVzPsTpp3iNhwFpZW7KkjnQ8nCmVVs_1736490103
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_222149_286775_013317FF 
X-CRM114-Status: GOOD (  19.10  )
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

On Mon, 30 Sept 2024 at 11:00, Baoquan He <bhe@redhat.com> wrote:
>
> On 09/14/24 at 07:20pm, Dave Young wrote:
> > The setup_data ranges are not reserved for kexec any more after
> > commit fc7f27cda843 ("x86/kexec: Do not update E820 kexec table
> > for setup_data"), so update the code comment here.
> >
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> >  arch/x86/kernel/e820.c |    6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > Index: linux-x86/arch/x86/kernel/e820.c
> > ===================================================================
> > --- linux-x86.orig/arch/x86/kernel/e820.c     2024-09-14 10:39:57.423551301 +0800
> > +++ linux-x86/arch/x86/kernel/e820.c  2024-09-14 18:56:30.158316496 +0800
> > @@ -36,10 +36,8 @@
> >   *
> >   * - 'e820_table_kexec': a slightly modified (by the kernel) firmware version
> >   *   passed to us by the bootloader - the major difference between
> > - *   e820_table_firmware[] and this one is that, the latter marks the setup_data
> > - *   list created by the EFI boot stub as reserved, so that kexec can reuse the
> > - *   setup_data information in the second kernel. Besides, e820_table_kexec[]
> > - *   might also be modified by the kexec itself to fake a mptable.
> > + *   e820_table_firmware[] and this one is that e820_table_kexec[]
> > + *   might be modified by the kexec itself to fake a mptable.
> >   *   We use this to:
>
> LGTM,
>
> Acked-by: Baoquan He <bhe@redhat.com>

Ping.  I forgot this patch.    Can x86 maintainers take this one?

Thanks
Dave


