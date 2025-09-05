Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A60CA1013
	for <kexec@archiver.kernel.org>; Sat,  6 Sep 2025 00:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5kSIyEkKJPNtcS4C9SW12B6CjFCMmyXxFbHsBSrhHlc=; b=1bmr1jXAmqx/Jlgm8Y/pOjKyi0
	lN3+sWlwga74kpjtYfBaPffLaVWbUsnEO7UlOVtnVsoOKqNNl9AOmaZwdkuRlNgmj1WDckoxxggTa
	T1CQiLpYEts42tBJFwlaIuHif28KX0u3iLzHYC9dtRf0WCJh1eOgpzGzAvhb5mqDurR0+Qf/CkW0s
	xK5Momo/DBNzhzcc0Au1EB+/8rjtjmQMIw4Y3g9e+0I+CgOaihyI01XzpUBN8hnUNl1yc0G/ODrLB
	Q5o4ZxKRKxtjwQd669oWNT6C3TM1+SlBLEpKDRLi7yhXZRx0ytETD+t+MZZNt5+54PEabJpkgacJv
	g/BXHtTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uugY4-00000005WPR-2Y97;
	Sat, 06 Sep 2025 00:12:56 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uucM3-00000004F2w-0OpZ
	for kexec@lists.infradead.org;
	Fri, 05 Sep 2025 19:44:16 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3cdc54cabb1so966995f8f.0
        for <kexec@lists.infradead.org>; Fri, 05 Sep 2025 12:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757101453; x=1757706253; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kSIyEkKJPNtcS4C9SW12B6CjFCMmyXxFbHsBSrhHlc=;
        b=hSvSCgeDWmPh2dTsgl58xovJQ5xzy7rMaZjQf5VDz6p3c3gQCz3zSD8YFoynYB5H0s
         DU1aRoBLOkLexynCGrOZIy3IjknlfMUcZRu51SF/1HBrn6AIjnDNSTqaf/3+Vp76w92Q
         +qMUYYS16lNSedoawqp+TtUwhYZFrslQLWhB9h9mKE5B/FUcTEA5NdMqLz7S1jMnr4/T
         UEb5P2MxS5KmgO9rz3FQ721QXoXZfmIixbOnVZ49ysWLWZSTEdm7hbqxf287SCLjk6r3
         T2olterUF/EE9fraflqikcDodQ8yJxpYY9wKtGoMrs0iGYkqCa0oBZ/pqNVowaRk0p/c
         NuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757101453; x=1757706253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kSIyEkKJPNtcS4C9SW12B6CjFCMmyXxFbHsBSrhHlc=;
        b=tyZAvoxLyPBxnsTph+FDwOderUITokpN/PbkMwhfe4u3aCp21HE1+QzIsO296ZUPfC
         7cNO5et3LdgpZiaijxJ+H+d4OW1cDiH3a5kwPa47Y3SERQAVPtaPeBUaAp9GrVjkxj/I
         RbXOBOZdqsA9xr2Zc+Kuk3RYP94n+ODqifKRshNzbmnCvM8nRNWZyty0pDg5du8DSMEU
         cwxfpTw/Me0MxhpRFZ0vcrxcY2JhZyo0+ir5hRhZ8QFkD5kOxEGBy9QVOXJuOZA0QyrD
         qJPjnSGLP0huY1J/MmgNWG68a7Mpt8jPMg0OdW0EssqX5dv/Cj0k8HQGP1lYuEpZxI8o
         tCgA==
X-Forwarded-Encrypted: i=1; AJvYcCWZx9JxnYfJmPKQjxFm/q+IRoKzeRZNTHGCFgoac2bhCFec5q42oVT9mKiXQ61OMDj+t8vCfw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyg+EKaLgwddb03TxhJZF4kmMuW4QeJQb21XHdIZI2p41M21eqM
	8ia4ZnH32iIRpobDgxvqwObkOgBt7RKGElzohKwsyA/PNcGh2CaFw4Ywl5WUVZ30g4L5WlDlXVW
	ayBABtzqqFDyDGrTXs7MumM5wGBleAYk=
X-Gm-Gg: ASbGncu/PMWfGb1NImnpEAc43Pmii/Evx42ISqP8szx9WKIBh+mT3mTwAeQzEA82Qfg
	ddvcCoi0+6shIGMbS/wBWRi1vBXbD7RGIvCfSnWZPg+6lVBDQBG6fmNHvHNekrJglB3KumIXrpp
	cv3SHvEa+ZgRvNUgupMWX58eXcVejsXranKe5teUSSdGRatqScrVyt9V9F9Ou1J2qBJXcovEev0
	2LtJjbfGCx2vFi/BQ==
X-Google-Smtp-Source: AGHT+IEIWTbj6iXai5EB56BajMtkwmQ0wX6zSMX9cOQAlzshrXJq4aBijoRGaRfyrquo9vOREnmChUojy9i9giTVk9g=
X-Received: by 2002:adf:b188:0:b0:3cd:44a8:ffcf with SMTP id
 ffacd0b85a97d-3d1dd81e4b7mr13383104f8f.12.1757101453197; Fri, 05 Sep 2025
 12:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250820053459.164825-1-bhe@redhat.com> <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv> <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com> <CA+fCnZdWxWD99t9yhmB90VPefi3Gohn8Peo6=cxrvw8Zdz+3qQ@mail.gmail.com>
 <c0bd173c-c84f-41d5-8532-2afb8eca9313@csgroup.eu>
In-Reply-To: <c0bd173c-c84f-41d5-8532-2afb8eca9313@csgroup.eu>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 5 Sep 2025 21:44:00 +0200
X-Gm-Features: Ac12FXw8jIlx5I_GnULq-nTw7_htdTiBmfe6-tGy9IZcoS0RzVO8mAQjd7gKDAU
Message-ID: <CA+fCnZd9unSjY-UnEwc4rGkSRgZX3nrs=WgBb2eDQNEpZX10cA@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Baoquan He <bhe@redhat.com>, snovitoll@gmail.com, 
	glider@google.com, dvyukov@google.com, elver@google.com, linux-mm@kvack.org, 
	vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250905_124415_143884_659C770A 
X-CRM114-Status: GOOD (  17.32  )
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

On Fri, Sep 5, 2025 at 9:13=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> > Hm, I thought it worked like that, but then what threw me off just now
> > was seeing that zero_pte_populate()->pte_wrprotect() (on arm64) resets
> > the PTE_WRITE bit and sets the PTE_RDONLY bit. So I thought the
> > kasan_early_shadow_page is marked as read-only and then the
> > instrumentation is disabled for all early code that might write into
> > the page before the proper shadow is set up. Or am I reading this
> > bit-setting code wrong?
>
> But that zero_pte_populate() is called by kasan_init() when everything
> is ready.
>
> kasan_init()->kasan_init_shadow()->kasan_populate_early_shadow()->zero_p4=
d_populate()->zero_pud_populate()->zero_pmd_populate()->zero_pte_populate()
>
> Here we are talking about the shadow set at startup kasan_early_init(),
> aren't we ?

Ah, you're right, thanks!

I was confused by the name of kasan_populate_early_shadow(). I think
we should rename it to kasan_populate_shadow_read_only() or something
like that and also update the comment. As this function is not
intended for populating early shadow (that is done via
kasan_early_init() in the arch code instead), we're populating normal
shadow for pages that can be accessed but whose shadow won't be
written to. Perhaps it makes sense to come up with a better name for
the kasan_early_shadow_page variable too to point out its dual
purpose.

