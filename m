Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C6CC83F03
	for <kexec@archiver.kernel.org>; Thu,  3 Jul 2025 17:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O6eQ7NOBur8NrA2FFiLtu9EBOR4LTolBpc5ssBqRWFc=; b=FU3xW1d86I4bKNw1wXyGMUvVje
	DDE7d/Esfw0HVjQkiXwUIYm4Jljv+Po4EmI7LBbHe16WmS2h/lnIt32gZr7yVYx1odIAOpz4Ruj/n
	esA9QZSRHioawsTqPY+Vd87VZMG33vyA1/6nSE55ZkAuWA9jSrwsspdOb4GPHTQIPsx5aiKeSNBYW
	UNqFxDeuLfUU9Q1gnSd8mTyxUEVM331O3SY++cYEVGF9DIOoST7zGFieIb2t2qjs8NLX/0sv/2Xh5
	G3yZVQoYpmTplhSKezDxbPppPT2lsuImhqF8FQkn5M0VJQLBjre6O+F3gwujNEpdR6l9kIs5HmGaW
	m8ZpO5KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXNTW-0000000C5ZS-20zR;
	Thu, 03 Jul 2025 17:11:54 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXKyC-0000000BgFd-2ced
	for kexec@lists.infradead.org;
	Thu, 03 Jul 2025 14:31:25 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3a4eb4dfd8eso1229529f8f.2
        for <kexec@lists.infradead.org>; Thu, 03 Jul 2025 07:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751553082; x=1752157882; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6eQ7NOBur8NrA2FFiLtu9EBOR4LTolBpc5ssBqRWFc=;
        b=Y9f5+pQwOUOuqrXKuB8sZlN+xU8Qs/MU+v74LisVPY3nsRIe28GX88P88PhaDlgX75
         5n4tzakpwdp50pfFeIDIVrnpWNYwpN79/x9vvWZ+HRQ0AXNLdQWbdNJcCl4NhD2nIfAu
         lZNNYuRVsIoO3tvlgtyky38N9kZwY7bRrDgOd/fDO8dnvEbbqwTSFM/AFd9Gz1Y7bGxS
         8zggghDbHvpxCWHt60vRfVSlbwo0NbAyy3N92uvYlEIyWYXhtcmZedphrxtPR8G4Nyww
         hjjR6VT+Y15gbKeiTqXPKrTIEoDDaPiaWLBcv88856PRX3RdIHQUIGM1j/oNRHGCTX5D
         lavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751553082; x=1752157882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6eQ7NOBur8NrA2FFiLtu9EBOR4LTolBpc5ssBqRWFc=;
        b=GfhKTCJaORt9t2aAu3SIT4rZz+yYpgcc0OF7ISdFsyINaApphtwgnajNooOPvRJUty
         3lNhFkM1C9D54/FyPcbzzsjmfq6bnxO9sdyv5vxPg6wzFzkbZQAYr8AivKp0wRAQ/uLW
         ASVXbjp+uG9GzZGSutTw5sgKjdjIKkbyPoROfJgXtkD1ZDpybUAvxE12ZwbAm5HI35VQ
         6PpZbsMuqQ0Yz+jBzTjt7gnwVEnvOhzScB6DrZDNU+YNsXnCzbdgHjUFjoPQNYi7AM/I
         Y+tgf9ETq5KvVW44jOYhi9NUjA7rzqKQ5JmInS9sIj7yyEX2ez+Q+U1vejI8p6vI12lu
         NqVg==
X-Forwarded-Encrypted: i=1; AJvYcCVAIMMsPsVLqkOZKNfDBD2PNhdeY5ap0EZbuGGGLDJCK3YetPT/+++Uhi4s1bY3d250vjywdg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzWHyWFBYTzIeWaAed4h6fEm9hbtYOgtkrEp+mxjqpiH6LrgOUA
	bxVpERGhN6eGpAE5VhPgMOUB7v2J3o2Dr1bSqP2tiN0HIpiiQONTYIKTJoBJN8bPk/o=
X-Gm-Gg: ASbGnctuKpfOBtepAjMxbGo1KDoh6iwUWixxRRfVpclDAuh+z2MCue5YM+Z8MQtzOJg
	8phA+264K3Zc+z6AkADWBS38EtGJG1kykydTE51hIk6svGv1rbz4D2yDrmcGxirUzDrrFyv6BDG
	4PtUAY9WtDxRomvDCVzmcn8rJzQxlNN8czpSkWYIcDIaO5MpXXPO1K6bdsRmNZaYhQPxiYzhTbx
	nG1zkZiLq0As4RiUQoOgkCA+fXk3TTHXAkJ9P2r5eyWYR192pCbs146kNuaizVr9sG6rV14rweG
	pC7CSWbsbEW/OOlwatdUmrTQNe6/UVg8MnWMaRxdFyNS+TeNThkJq8mg0OaJtzD2Wumil2DXHkJ
	1PBMNtLbLq8+Hy//JCeYjIeald7n7yutyvMiilK+k9ehBiBi7pfICh4QG/gvV36bVFwU=
X-Google-Smtp-Source: AGHT+IE8c82Z/ZpSTTE1hP7bZsyU80hGR24Y2aXHdGMgliDX67LKP44fGsP6X2dKhv/86kyrAzsXOg==
X-Received: by 2002:a5d:5f91:0:b0:3a4:eb9c:7cbc with SMTP id ffacd0b85a97d-3b37d161722mr790211f8f.15.1751553080545;
        Thu, 03 Jul 2025 07:31:20 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a996a862sm29050625e9.6.2025.07.03.07.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 07:31:16 -0700 (PDT)
Date: Thu, 3 Jul 2025 16:31:00 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Tao Liu <ltao@redhat.com>
Cc: "HAGIO =?UTF-8?B?S0FaVUhJVE8=?=(=?UTF-8?B?6JCp5bC+IOS4gOS7gQ==?=)"
 <k-hagio-ab@nec.com>, "YAMAZAKI =?UTF-8?B?TUFTQU1JVFNV?=(=?UTF-8?B?5bGx?=
 =?UTF-8?B?5bSOIOecn+WFiQ==?=)" <yamazaki-msmt@nec.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 "sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2][makedumpfile] Fix a data race in multi-threading
 mode (--num-threads=N)
Message-ID: <20250703163100.603f59f4@mordecai.tesarici.cz>
In-Reply-To: <CAO7dBbXpkshxguPbHDA2YFZeYsDAbyswBCQ7x0UKY__4H1K2jQ@mail.gmail.com>
References: <20250625022343.57529-2-ltao@redhat.com>
	<7c13a968-4a3a-4d0d-8977-3ba0a4a845b1@nec.com>
	<CAO7dBbXpkshxguPbHDA2YFZeYsDAbyswBCQ7x0UKY__4H1K2jQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_073124_664560_683A7384 
X-CRM114-Status: GOOD (  26.74  )
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

On Tue, 1 Jul 2025 19:59:53 +1200
Tao Liu <ltao@redhat.com> wrote:

> Hi Kazu,
>=20
> Thanks for your comments!
>=20
> On Tue, Jul 1, 2025 at 7:38=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=
=E3=80=80=E4=B8=80=E4=BB=81) <k-hagio-ab@nec.com> wrote:
> >
> > Hi Tao,
> >
> > thank you for the patch.
> >
> > On 2025/06/25 11:23, Tao Liu wrote: =20
> > > A vmcore corrupt issue has been noticed in powerpc arch [1]. It can be
> > > reproduced with upstream makedumpfile.
> > >
> > > When analyzing the corrupt vmcore using crash, the following error
> > > message will output:
> > >
> > >      crash: compressed kdump: uncompress failed: 0
> > >      crash: read error: kernel virtual address: c0001e2d2fe48000  typ=
e:
> > >      "hardirq thread_union"
> > >      crash: cannot read hardirq_ctx[930] at c0001e2d2fe48000
> > >      crash: compressed kdump: uncompress failed: 0
> > >
> > > If the vmcore is generated without num-threads option, then no such
> > > errors are noticed.
> > >
> > > With --num-threads=3DN enabled, there will be N sub-threads created. =
All
> > > sub-threads are producers which responsible for mm page processing, e=
.g.
> > > compression. The main thread is the consumer which responsible for
> > > writing the compressed data into file. page_flag_buf->ready is used to
> > > sync main and sub-threads. When a sub-thread finishes page processing,
> > > it will set ready flag to be FLAG_READY. In the meantime, main thread
> > > looply check all threads of the ready flags, and break the loop when
> > > find FLAG_READY. =20
> >
> > I've tried to reproduce the issue, but I couldn't on x86_64. =20
>=20
> Yes, I cannot reproduce it on x86_64 either, but the issue is very
> easily reproduced on ppc64 arch, which is where our QE reported.

Yes, this is expected. X86 implements a strongly ordered memory model,
so a "store-to-memory" instruction ensures that the new value is
immediately observed by other CPUs.

FWIW the current code is wrong even on X86, because it does nothing to
prevent compiler optimizations. The compiler is then allowed to reorder
instructions so that the write to page_flag_buf->ready happens after
other writes; with a bit of bad scheduling luck, the consumer thread
may see an inconsistent state (e.g. read a stale page_flag_buf->pfn).
Note that thanks to how compilers are designed (today), this issue is
more or less hypothetical. Nevertheless, the use of atomics fixes it,
because they also serve as memory barriers.

Petr T

