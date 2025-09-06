Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E571CA1012
	for <kexec@archiver.kernel.org>; Sat,  6 Sep 2025 13:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VE+Mx/TU7aQIVb363hbvW+WQvMnqT6BMcQeprM6OFYE=; b=4GS0Ugdd/3gWc5n+j0EvES7hCS
	ysC9mkVcK+42AuF37fCiwuxXF/cmJ1GV8UkbMMn51A3+yRd2rWDUfb5KSnliwnjH/Cg8Vg5smgoIK
	pyHo4F9Sv7hLkq8EZNbd4gEfcidu1R14ACD7vcelKPqzCFbCAgVuyJ8IyXdVHEbOT2n3npWGRWu3c
	fz79Bgc5hxKwBTOkM8stjTQxctC3bPqwKJjng2wQjZmKIFTEojwVXj5R4OgOHPMZomQJ8LyE0slWz
	rO7qNyl53Z7lex99TJ4S/OvFhtuADsQlg3MskaJ38V1QqdnMHnKADxcGGPkHdepdnJbd2pBwdUBuu
	0QfwyxZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuswv-00000007ou2-0iiM;
	Sat, 06 Sep 2025 13:27:25 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uusv2-00000007ok9-1wQm
	for kexec@lists.infradead.org;
	Sat, 06 Sep 2025 13:25:29 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3e537dc30f7so414941f8f.2
        for <kexec@lists.infradead.org>; Sat, 06 Sep 2025 06:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757165127; x=1757769927; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VE+Mx/TU7aQIVb363hbvW+WQvMnqT6BMcQeprM6OFYE=;
        b=itjiKrUtzYDPFv6EDvzDMed+NHP1T8pgY0ihYSq5wcGJOhz2PkQuWMvs588BA6wj3t
         qHG5x9ZDDUtJOMzTXKCoRIZ3k5mbf6JVuWTN/MJ+1pXBk0Ju/E74elZ6ngufPWDKD7xB
         zd7ewrinAOYFng28d9NOd4yjpsrxa3Bq/D7cLk8pp192ghvnUAu1GpcFOz0ZfnlktqFK
         1Jem/lcGheaPrFzGfrH8y8unFq04+wwKte0XW/yL5Ae/KJ//2ACupE9sYfttxGmlwQp3
         6SWLASqB1O5sXw80FVlEFRVdSUqobqe+iM64vY1Sxipzxcn16lJKKKcHZvTcjwLbojbu
         16Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757165127; x=1757769927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VE+Mx/TU7aQIVb363hbvW+WQvMnqT6BMcQeprM6OFYE=;
        b=VMvtt5tS80/OO6BzC5ZeTd0uhTdGnYZCLxmkzZcwUZ55QUVpOaE8kW+QP8Q3hDeB3v
         RrHU3NLyC6ob7/nzwW1cKN9SLqGNfMQ1fjKUFfRne2yM4qKOQ9ATp7U/yi8tS5idXSSW
         BE5coKPepUa17LEg4KGISd5dZTmNpbFN+lyq1nwdoLfQTEsq92aN/swt9JPyUOMN8b5x
         33O1YmgENy62sIP2ZAwlJaFQR8jTWrmcx1WZC+rNorj6PYIVCdm+nkS2Ed+Y5NgUFyS3
         LDBdgSZhZz/DDieTeixPwEYXpr/LtP4v1FkqtbPc7QGW2PYGH2tWYC5ZXbyezqpdGqeJ
         axAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUynrir4KANbbv4jtTB60osB7LmXkK+9t632wnd+epkb03FGav1BPvytIgOgAgz6f/vm8mbaw==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywby7Uk/8jUoVx6lJ0mI2M5WIYZn3U5ve0ltQQdghd92ln721fD
	k8gOWwdX2YZnRYeWQvDoJuu+kzJEb8mqPs2fstkA7JvdD+3E3Tt8qd23SNuBG8zKG6HB32pQjvI
	SdHKPBTnJhGA6JoP76gN4FtxsYtLO/3M=
X-Gm-Gg: ASbGncu8qdW40zFd0329y1l/CrZCuZhCNAtjt0US5tQ47zK9cu5wPYbbkaRNHfdXjof
	pTOr1ZKex+fD3HV/UP03VjsS3Xpv5vB9kcRlgORJzlIFZxu6P1vYL+XuJ5bDn9nNtHWznoifDtY
	z1b+HU/Dd3j07N4jcGLjWTl55FdUcsoYT+gh3R5vN0Pu9nscgoxc+GyxgXGQzY//lzw3bCJR2r5
	yBQkSoo
X-Google-Smtp-Source: AGHT+IH7xxFltspr8zCiYexkZxI5yiQn/I8vOs80sqSulDOmiRjBylXmYFVNrCaFsedsn3UnPzIuoip5fBxmKpv09wE=
X-Received: by 2002:a5d:5887:0:b0:3d1:6d7a:ab24 with SMTP id
 ffacd0b85a97d-3e641a6095cmr1198571f8f.17.1757165126529; Sat, 06 Sep 2025
 06:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250820053459.164825-1-bhe@redhat.com> <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv> <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com> <CA+fCnZf7jYPUyqHqonWhDKVi9eeN6aaaByMTBYCQrv2-8+hngQ@mail.gmail.com>
In-Reply-To: <CA+fCnZf7jYPUyqHqonWhDKVi9eeN6aaaByMTBYCQrv2-8+hngQ@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 6 Sep 2025 15:25:15 +0200
X-Gm-Features: AS18NWDtWolEoXZVKCJMBulXUlUwGez_rwjXq9tKdDHHBjrrgE8FIXbdfmCaUgk
Message-ID: <CA+fCnZf0z526E31AN_NUM-ioaGm+YF2kn02NwGU6-fmki-tkCg@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>
Cc: glider@google.com, dvyukov@google.com, elver@google.com, 
	linux-mm@kvack.org, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu, Andrey Ryabinin <ryabinin.a.a@gmail.com>, snovitoll@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250906_062528_505449_9E004F97 
X-CRM114-Status: GOOD (  13.16  )
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

On Fri, Sep 5, 2025 at 10:34=E2=80=AFPM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> Baoquan, I'd be in favor of implementing kasan.vmalloc=3Doff instead of
> kasan=3Doff. This seems to both (almost) solve the RAM overhead problem
> you're having (AFAIU) and also seems like a useful feature on its own
> (similar to CONFIG_KASAN_VMALLOC=3Dn but via command-line). The patches
> to support kasan.vmalloc=3Doff should also be orthogonal to the
> Sabyrzhan's series.
>
> If you feel strongly that the ~1/8th RAM overhead (coming from the
> physmap shadow and the slab redzones) is still unacceptable for your
> use case (noting that the performance overhead (and the constant
> silent detection of false-positive bugs) would still be there), I
> think you can proceed with your series (unless someone else is
> against).

Hm, just realized that kasan.vmalloc=3Doff would probably break if
CONFIG_VMAP_STACK is enabled: read-only shadow for vmalloc =3D>
read-only shadow for stacks =3D> stack instrumentation will try writing
into read-only shadow and crash.

So I wonder if there's a way to avoid the lazy vmap freeing to deal
with the RAM overhead.

