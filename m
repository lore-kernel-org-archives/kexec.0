Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F95CE8D52
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 16:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yDQtpO0LuGRtA7x4zSaAXPnOMeh5Kiwvod9aseLK5Gg=; b=Tb/k4vGGymQ6RFDNoZ45vfV13G
	qQnkWnCnSv/Q1uvoyYisB+CtQyousAQXE7//31Q0GXNQgbfTkxrd/wdIH6g5jEhRLK/yN4HLgxoEo
	WfHOQb+gNEMUSjOaBJ5ltRT2/VPP6S/xCi8EwJraFzFjV5RYYbTiqj2rQcwRW5j2jqV/DYoZbmeur
	MCPww8GhFOfvTs4TlZonmquVZVjoH2aKhyU7LXo5G9Towm9Hgri+Db96mHNAeIyqUCGWNlod+8TkC
	KdbZIhN2jxN6dCv4orR5hF88v7pElwZi9xJVDW35EY475EnICtBKvVMpkLe36s8k8fPSKRqY6bdSv
	OptAkkbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJwwo-0000000ClJO-1HtN;
	Fri, 14 Nov 2025 16:46:54 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJwwl-0000000ClIi-3Ysk
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 16:46:53 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so3874170a12.0
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 08:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763138810; x=1763743610; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDQtpO0LuGRtA7x4zSaAXPnOMeh5Kiwvod9aseLK5Gg=;
        b=LZWSZsefvNsD0hErKRyuRxVjU9BAbO0VeWqarSreE6Hu+7+C19GhdnIqv7P89wPUC5
         m0ugjrfHyFLt9Vc7rCYvnKSU3cBpZfhARjOjvy8KVNyUMaYXJVKaP/5AYLCvfs95uCpv
         ijbSwsufucfup9WhhDvmaHPo0qM+b/zokaKhkV6GeFxTzeHBe78WIXsXedYMzazb5vAE
         jXld5mCEPBl3m/9O0eo+JlfurnBNwVjCLTHqpxtd+QX9boPf3u1JBMpJ50bJv6U0FSTu
         B8FeprYRvSP5EopIMptFUUDKLw53oepE/J/uMr7o41uZdXwvYGuyA+VH/uHiwlqq2NCg
         2Qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763138810; x=1763743610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yDQtpO0LuGRtA7x4zSaAXPnOMeh5Kiwvod9aseLK5Gg=;
        b=wXDZ4vGLjOec024fzzjJikIqa7FOykGciVVG6gp6MLeWAYX4efh6/dDWh7VsUPT/rF
         atA8jR7Xhnts6RPp6ItqmwcfEfnQ17mPbmX010CS2ENiTt6scBK/s3jS8ZSOM8tXtKlj
         h5HVUNdtWUAJkgo5HvdwkrN7fTQag7nY1TK3zAFGnKsZowj4BRV7fhQ7hl1bgXHYQNkL
         5agbpTQ4fiJ7ePVaRJj0fcdG5fbANv1qkRr02c7GY1AKkJRp4j5r7gN8jVg0qGRjsAUQ
         hu4j2uIjVTj01lZ3d3q0ETw+YP5M/eyC1waqPZBDwTNJsT59aar1yQPhf7mKMpUw4zp/
         rD2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUu37mwilI6h0tgWw7YHqoZto/UEF/qLR4rNoNx37hXgWXzxKqABIM3zOeYvbOS+8dmUJQ+VA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzjopCQazVGrmUpcIJ/p7ahu6iya8V8yHNAwQYYoplSGT60sgm9
	ILtkMK/tBadxFVXCBSOxNqEteAfbsCCXVYlKDBpAOa+Vdg3ggnrUzcBOyfmkJGIZ0GllrfDELJY
	UXNCgYKh1OW2WKntnPo3UnXYUJvAqF7j2qz9K3Fi63w==
X-Gm-Gg: ASbGncsGddlzAnEZVFgA+aS7XhQPsAJcKJx2cHldCp6tXNpWYEJ1MpAvWx47S4TnntB
	IkRoroJcGNjXEU6JhycAFH9ABYRu5eHouJbUrvz6HOt8UvP4DyF74ycRvCWnibARGBThMyNQ/MG
	T6nhqLI0FYqxoOhPj/def9Pk6yGieipn3g9zk42vNinThzXZlLLtjVYEoyQ0kciluf1Rz2sLHIU
	d1IeVdIBHjsJSJaPjwlhJxPM1URCtd8gEbKQgLH9bMXwqBy3wDdbwcgAw==
X-Google-Smtp-Source: AGHT+IFbJ/KZEyWmM8d4Tn7qAbyKy89sED/8mpiPp9IrefIs6/m2O49OIJhrycbebbsgWFvmsokzshBL66RF2COnksA=
X-Received: by 2002:a05:6402:34d5:b0:643:18db:1d82 with SMTP id
 4fb4d7f45d1cf-64350e2159emr3167393a12.11.1763138809509; Fri, 14 Nov 2025
 08:46:49 -0800 (PST)
MIME-Version: 1.0
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com> <aRdWF8ck4iq1hc0B@kernel.org>
In-Reply-To: <aRdWF8ck4iq1hc0B@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 11:46:12 -0500
X-Gm-Features: AWmQ_bnccF6a3b19rd__cNBKQXa9KGCdbhYFEGJJeXr8Oiyaq_gWPptNojqbe4c
Message-ID: <CA+CK2bCgdz3Hv90axzuSThRtEF17oSj-RKHgVwu5rQ7TXcoKcQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/13] kho: simplify state machine and enable dynamic updates
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, bhe@redhat.com, jasonmiu@google.com, 
	arnd@arndb.de, coxu@redhat.com, dave@vasilevsky.ca, ebiggers@google.com, 
	graf@amazon.com, kees@kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_084651_905615_A346FE10 
X-CRM114-Status: GOOD (  15.21  )
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

On Fri, Nov 14, 2025 at 11:17=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> On Fri, Nov 14, 2025 at 10:53:45AM -0500, Pasha Tatashin wrote:
> >
> > This patch series refactors the Kexec Handover subsystem to transition
> > from a rigid, state-locked model to a dynamic, re-entrant architecture.
> > It also introduces usability improvements.
> >
> > Pasha Tatashin (13):
> >   kho: Fix misleading log message in kho_populate()
> >   kho: Convert __kho_abort() to return void
> >   kho: Preserve FDT folio only once during initialization
> >   kho: Verify deserialization status and fix FDT alignment access
> >   kho: Always expose output FDT in debugfs
> >   kho: Simplify serialization and remove __kho_abort
> >   kho: Remove global preserved_mem_map and store state in FDT
> >   kho: Remove abort functionality and support state refresh
> >   kho: Update FDT dynamically for subtree addition/removal
> >   kho: Allow kexec load before KHO finalization
> >   kho: Allow memory preservation state updates after finalization
> >   kho: Add Kconfig option to enable KHO by default
> >   kho: Introduce high-level memory allocation API
>
> For the series:
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>
> with small nits in patches 9 and 13 in replies to them.

Thank you Mike! I will update the series, and post v2 shortly.

Pasha

>
> >
> >  include/linux/kexec_handover.h              |  22 +-
> >  kernel/liveupdate/Kconfig                   |  14 +
> >  kernel/liveupdate/kexec_handover.c          | 338 ++++++++++++--------
> >  kernel/liveupdate/kexec_handover_debugfs.c  |   2 +-
> >  kernel/liveupdate/kexec_handover_internal.h |   1 -
> >  5 files changed, 232 insertions(+), 145 deletions(-)
> >
> > --
> > 2.52.0.rc1.455.g30608eb744-goog
> >
>
> --
> Sincerely yours,
> Mike.

