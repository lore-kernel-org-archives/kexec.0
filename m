Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E72EE14AA
	for <kexec@archiver.kernel.org>; Sat,  9 Sep 2023 18:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DwjTIntiPvd+MLBFBauneYn6DErcBKaFFloMw3Vih9k=; b=laKwVYU6DH6jyo
	q2RKp220J/KIA9pGZ2rAnTT3Gw9GavuVg1OWA/9LmVZv3A8VGyeLxcr7FZYSki8XFQTWXNKO7Ya4T
	5w4ex7xVB/KLxkH+qqBFDx47eOHRESOt16lMq6fQR1DtTSxcuB2O1NkUbcLtRMZ3vqDfVBRepIoUs
	6dLepMXXv3UHGV5pldmza6A76bUCz9EDv0S6wsoZ+DpV4bTlnVdDGslKLhauKZaZLy4vGzIWD3hem
	QPB6+XlTTCqi02lyVzQL8ehYgZKleC8AO4DTzeDAiMsGqbcJJfoH73JUvh7IWgnD++AryY+0PC47B
	mGvkyTQm2sbIiFHJumlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qf2PU-00Fgh1-0G;
	Sat, 09 Sep 2023 18:10:20 +0000
Received: from mail-oa1-f45.google.com ([209.85.160.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qf2PR-00FggM-2P
	for kexec@lists.infradead.org;
	Sat, 09 Sep 2023 18:10:19 +0000
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1d4c9494b42so2261044fac.0
        for <kexec@lists.infradead.org>; Sat, 09 Sep 2023 11:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694283013; x=1694887813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7stfKXPrGgmPuohhEH9AzgMJornHPnvxS8cyO4wLhws=;
        b=ls5ciFL8l+94t67bdo07ThGKucTLIbtR3P9yFhaEXXUIPIxY6YOitEND1NODZhjlWo
         qQbveCaaZ1BiiUce4bcL5aM/oea8Ie1mn9b7RAFbf1GNIKNyMGSJcAem6OlKlP9SBzWb
         nlzIg7zeJluVpU7nffCqqe3nsjR679h/mlR8DtKXFZ0PaIHJaBKa9z4cKsYiVPtqAVgA
         gJUwZHUyQzz7y4nu+/iuS4/65DY8Ft8P0RAQSF5yPaBjPzBTGMnzgNsO1bP7zA+aWZQx
         yj89qufkxCoLPod2nRIFnY4uJ4OhB+F3oYzNNBqMlFbG90fBuOOUEviKuBq/SDcUp9zS
         zXEw==
X-Gm-Message-State: AOJu0YwqMYmWatljZcJTBXeRqc4pBXk88J0MnosJ2mjx0Us2nPIMBqJe
	qZZQYHOte8DazVDxhVfVhxyKmpm1KqGjGg==
X-Google-Smtp-Source: AGHT+IFBUY4J8L0qXisOx/YRH5VjFBBpr/2L75Cas5WVRr2CG7izl6IPjUEDguG9K5ciusngy0pAXg==
X-Received: by 2002:a05:6870:f14e:b0:1b0:5141:4c6e with SMTP id l14-20020a056870f14e00b001b051414c6emr7013233oac.26.1694283013101;
        Sat, 09 Sep 2023 11:10:13 -0700 (PDT)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id i5-20020a056870864500b001cc970f3b00sm2238846oal.50.2023.09.09.11.10.12
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 11:10:12 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-57128297bd7so2002098eaf.0
        for <kexec@lists.infradead.org>; Sat, 09 Sep 2023 11:10:12 -0700 (PDT)
X-Received: by 2002:a05:6358:7249:b0:134:cb65:fbbe with SMTP id
 i9-20020a056358724900b00134cb65fbbemr8198881rwa.13.1694283012561; Sat, 09 Sep
 2023 11:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230909161851.223627-1-kernel@jfarr.cc> <CAMw=ZnT-Ck-Y4i-MZAf99U5nzgDaj-q8UPRH_c00JgGMtUy_QA@mail.gmail.com>
 <5c94f7f4-697f-4388-9243-009c0c2d745f@app.fastmail.com>
In-Reply-To: <5c94f7f4-697f-4388-9243-009c0c2d745f@app.fastmail.com>
From: Luca Boccassi <bluca@debian.org>
Date: Sat, 9 Sep 2023 19:10:01 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnShMzqH_yiXCS0-O+yR0RZs7+sSm0rqSYwpoygcYdg6hA@mail.gmail.com>
Message-ID: <CAMw=ZnShMzqH_yiXCS0-O+yR0RZs7+sSm0rqSYwpoygcYdg6hA@mail.gmail.com>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org, 
	tglx@linutronix.de, dhowells@redhat.com, vgoyal@redhat.com, 
	keyrings@vger.kernel.org, akpm@linux-foundation.org, bhe@redhat.com, 
	bhelgaas@google.com, lennart@poettering.net, 
	systemd-devel@lists.freedesktop.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230909_111017_784027_DF03FC69 
X-CRM114-Status: GOOD (  23.24  )
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

On Sat, 9 Sept 2023 at 18:58, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
>
> > - the cmdline section is actually optional, just like it's optional to
> > pass it on a traditional kexec load, so it should be used if present,
> > but skipped if not
>
> Should be an easy fix.
>
> This should be updated in the UKI documentation as for other optional sections it's explicitly marked. I assumed that in the case of an empty cmdline the section would still be included but empty. Or is that semantically different: empty .cmdline section -> no cmdline allowed, no .cmdline section -> user can specify cmdline in bootloader?

Yeah the doc is wrong, tools handle it as optional, fixing the docs:
https://github.com/uapi-group/specifications/pull/72

> > - the dtb section also is optional but supported, and given kexec
> > supports loading a new dtb I think this change should support it too
> > immediately.  Moreover, we are adding support for multiple DTBs in a
> > single UKI (by simply having multiple .dtb sections, and picking the
> > one that matches the firmware), as a stretch goal would be nice to
> > support that too, but it can also come later
>
> As far as I know dtb is not supported by kexec_file_load at all at the moment. Maybe someone here knows more about this. I'll look into it.

Not sure about the specific syscalls, but I definitely use kexec
--load --dtb on arm64 with existing released versions of
kernel/tooling

> > - also what would it take to support arm64, which is the other major UEFI arch?
>
> I'm not familiar with UEFI on arm64, but I can certainly look into it. I assume it's not gonna be that difficult.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
