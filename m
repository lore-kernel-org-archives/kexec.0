Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF78EC83F1A
	for <kexec@archiver.kernel.org>; Fri, 11 Jul 2025 10:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o9x5MPLdowi93FE6PQSktLtoA4irsz+iTi+ao4nMAu0=; b=K3R48uG05Te9RgRX/YqmINi7FX
	bSuUyj8JYK3hsVhVK+4M7ZHhxhUMIAh8HPU+f1rWgWiV1Sl/dycFNCzqZoPkqStJUFk5xCgzvyNvJ
	H5evXj1oENw9dFMn9fX5mbDUtdQGDV5dv9ivW+qirNZeGXEE0og62KK6Fu2NUwnTsThaZT2MHsQh7
	9sxo6psRQ/478jkF6ui72mdwgMMlqeXM36nZ4OeQmP7SKwccXoQrfMnwewxb6rmgMNwFGX59WtxOS
	RqdCJuu3C5kBJn9jVJBq56Dx+Uzvt5HUIuBwvhvZ98WVB8c5g4LeU0FDhvZgJxEpoczl+cCiRTDXK
	SCg2Bkzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaAfX-0000000ERbh-4AvO;
	Fri, 11 Jul 2025 10:07:51 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaA4B-0000000EJ6N-3TcH
	for kexec@lists.infradead.org;
	Fri, 11 Jul 2025 09:29:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7C3AD4538E
	for <kexec@lists.infradead.org>; Fri, 11 Jul 2025 09:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C47BC4CEF6
	for <kexec@lists.infradead.org>; Fri, 11 Jul 2025 09:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752226155;
	bh=iHZmzvg1Z0/oUDVf3XnhzHYjBdXj4X/zANqYMwOOwVY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AmQ+EmKZ1CODy6GzLrc59sIDMGTEHOQOG/x0L8Nvv5ntyCOJluBRy+it6EBQTyZ17
	 KgXewm3SlJ2afz53g+03Q0APObEz5AkRN8tNJ30S2O5x0FgEg2CC/BXz7rrLU1BvWx
	 +u+yQY6S3Ix16J+mhEV3XlzSzQWfXLI9t2faqtr4kUTwMThkfBEUgnP7jM0VVEoHon
	 15WiUVymJ2T9tADURQCynOYWg7+8LS4MWxh00TCO8tGPQJA2K2YovGEX7N0ihKizx4
	 Xa1nzyrrBf+UVdzJ6xjov1KagVqaRsWT3GrA/oRgWArNwDeXyqLfIxPvZcB4zW0bAu
	 i1dOwELPpOAkA==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6116d9bb6ecso1033270eaf.3
        for <kexec@lists.infradead.org>; Fri, 11 Jul 2025 02:29:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdNPfr2ZM9I0TUQNHaLviTaduJ5+Mtn50SekEuvYkkiON8O57wmNlZzUOaEYZbYi88SimBsA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzapb3P0aW4OPqf8j5JVT5nk2vc+I/t1hRf5kLOO2Mevipb+8Kp
	VbaobGXZQ3619bNKjBAfJfiQSXdaEADzQfTS5YTBBS3XpvxjdHwXmQ/3IHT/ggMTwJ51njSJQfZ
	W59WD5ag+mofLzyBUYPE/16B46JjZ6n0=
X-Google-Smtp-Source: AGHT+IHah/1nYPPCS226AsETgCQiVMx9hN5wz3RtNvupDeronRgy3EyjIlni8u4klecH0TlVtPdr1MRtZLHO16vIPZQ=
X-Received: by 2002:a05:6820:20c:b0:611:b24d:c27b with SMTP id
 006d021491bc7-613e5ff6f4fmr1516730eaf.7.1752226154677; Fri, 11 Jul 2025
 02:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <5046396.31r3eYUQgx@rjwysocki.net> <2396879.ElGaqSPkdT@rjwysocki.net>
 <aHCsUAhqRz5zJH2t@MiWiFi-R3L-srv>
In-Reply-To: <aHCsUAhqRz5zJH2t@MiWiFi-R3L-srv>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 11 Jul 2025 11:29:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gMF_HS3pXDdXSLz9V3iZr6XvAgCZmu43Dx=oJjBJThsg@mail.gmail.com>
X-Gm-Features: Ac12FXyKFz98IUnh2R9pHZzFjoCI8hWGXwPMgzheZQYu2jad9b8REvYXq3idXSg
Message-ID: <CAJZ5v0gMF_HS3pXDdXSLz9V3iZr6XvAgCZmu43Dx=oJjBJThsg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] kexec_core: Fix error code path in the KEXEC_JUMP flow
To: Baoquan He <bhe@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, kexec@lists.infradead.org, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250711_022915_925513_A0722E51 
X-CRM114-Status: GOOD (  19.07  )
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

On Fri, Jul 11, 2025 at 8:16=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> On 07/10/25 at 03:10pm, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If dpm_suspend_start() fails, dpm_resume_end() must be called to
> > recover devices whose suspend callbacks have been called, but this
> > does not happen in the KEXEC_JUMP flow's error path due to a confused
> > goto target label.
> >
> > Address this by using the correct target label in the goto statement in
> > question.
>
> Sounds very reasonable, thanks for the fix.
>
> Acked-by: Baoquan He <bhe@redhat.com>

Thanks!

I've queued it up for 6.17 along with the [2/2].

> >
> > Fixes: 2965faa5e03d ("kexec: split kexec_load syscall from kexec core c=
ode")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  kernel/kexec_core.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -1080,7 +1080,7 @@
> >               console_suspend_all();
> >               error =3D dpm_suspend_start(PMSG_FREEZE);
> >               if (error)
> > -                     goto Resume_console;
> > +                     goto Resume_devices;
> >               /*
> >                * dpm_suspend_end() must be called after dpm_suspend_sta=
rt()
> >                * to complete the transition, like in the hibernation fl=
ows
> >
> >
> >
>

