Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D997CA1013
	for <kexec@archiver.kernel.org>; Sat,  6 Sep 2025 00:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iGdnI/KfWDDu00FpGfqLB2W/2CyE6C3w8An1H9pjQWM=; b=w75PG7XtLehQEH5wb9SC5ecDpD
	if1z+RK0ClsEcqKSEc/FdK9VLHGkvdBuIWeAlHfOpu0IqHfOgS6ha5c2H+ah5QLk1rs0wBvC+jivZ
	yEFB3zqPvg0zgD8jScuezevaESmGtYNetqd4I3km7kDhXp3JXLfRjvWGw7o8nkfO4M+mJZDWVa34u
	5cXuCw3oxZ+cTNqgInYFmzVSPkh1PSwOj+GIyZiWfn4ZNDh7/qFB4e/zpb8zJ/HriJMPnNoaBJIIX
	RshWbaLG6Gl7lGAI2z0T/eOIYz4/xp0h3op2AClh24Wtr0YDwmNQ2nE1+EO8x1Ucuh9iFwsNKrNN5
	uHWUaf3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uugWD-00000005T32-1GAC;
	Sat, 06 Sep 2025 00:11:01 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuarj-00000003grW-2Cai
	for kexec@lists.infradead.org;
	Fri, 05 Sep 2025 18:08:52 +0000
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3dcce361897so1634584f8f.3
        for <kexec@lists.infradead.org>; Fri, 05 Sep 2025 11:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757095729; x=1757700529; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGdnI/KfWDDu00FpGfqLB2W/2CyE6C3w8An1H9pjQWM=;
        b=l23E57jkUr+xS5rldPcmTq/m3L/vBHG02XPsH41sTaImYzc/73ZHupcSrLF2+N20D5
         ghoQ2PxlogpfWRCI4SqPrtp2QjA+9Ty5K1PbHuxBtR+aEeOG1nkbMePIf4o4q6QMtzAs
         zLhx6A+Enc99oRUKue843jZ/L4f2cQLgDe3G0jsf9L1ytbuO3CnW+EJ7inltXS72+hlX
         s6RDNKhj92ZqnlO7sbdYGyASvaozELKU+jeUOig4QnkwAu05OyHeDM/hR3N3qo8rRmra
         cq7kg94YWXVZrhKYg3Y2JbaSNqF4Plo5XNyFv5aToECMySSlJ3GyQHwlEI3AGidSNC2/
         lClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757095729; x=1757700529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGdnI/KfWDDu00FpGfqLB2W/2CyE6C3w8An1H9pjQWM=;
        b=Uv5q6TtBUZt8Wv4i1X5WaW+cLAtY+qm6ZuDoblRLcPbYOZqCHOI5V0eq3I5jzwbdi4
         AShmqmaZWly2pYj3XXgPfoTY0GK5UGMKih70u7Q3pF79azUlnIx5LtyTesZ7T5kjfUfv
         E+w5j7P6gLtRPB7my35I3cZGcb5I7SeE0Nh2gKxsVXpHgjPYgIs+TBYGEmMjuuA0Bgip
         lRVF9kr4zpK92dPGDAAHEzvDSYeQUoJDKbkNJrEHut+bBrTZ3QejWaHXJ8RylOUPAWm5
         Vqgmrx43hcMDVtXTszB22J4+gsQaOPW472GtLGB7V+YINc7XbG2nNz1GdB3Sz+S8KUKD
         W0Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXLSgb9OeSIGBFyyegYFuqsAgZgt44Oky5XXQ0Xhq4uyizAK/7LL8XBGujPq6u2W8OxJBp4zQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxmpEkWwJyLbctNBbLnBHSA8nZCdJ3oLqTjJDwQzQHcznsojz98
	bFPstIV63M8w9+fGfKw3LGVFpUATE3T1+tvU5LbkHinrx0J90MXVoHkP7gY4YD3HVO0S5bPOyIm
	Cr8xgPHiI7wsRvos2nWL2+B857K1iGcQ=
X-Gm-Gg: ASbGncuCtlsrs3JmeIWXMyPcKvexjIypIR5cX6abenF7DPZG8Aw7ETw2uInGS9ruJja
	vhP001zhKdkYLyrL0G7RHX2KaOs5Af+t5hUBqNQDFISyLEDmUa37vaDidopEt0BLrVA+u3Y2K6C
	rX/AHGOfJaN9Tzys9X4JjS6G53wO9iN8CEqm1tewA8n5yIriHIIixOh/zoF5XmV2S84ZvCdSx3u
	dqnfYTM0Xdj816bRQ==
X-Google-Smtp-Source: AGHT+IFERVcRo3NEqVJraCj4UK8XqQK1l3sZQfzYHrDnZAXUKAj3OQJ2L1gNLfVRJ4WTCNxbt7GRroTNPcmh78bqpuE=
X-Received: by 2002:a05:6000:18a8:b0:3d9:7021:fff0 with SMTP id
 ffacd0b85a97d-3d970220156mr11837479f8f.37.1757095729307; Fri, 05 Sep 2025
 11:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250820053459.164825-1-bhe@redhat.com> <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv> <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com>
In-Reply-To: <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 5 Sep 2025 20:08:36 +0200
X-Gm-Features: Ac12FXwl8rdmcy6KM72QT5kbnXVskzKHCQ5SWTQj8L2OmEz2lTLzNNXRX0uI6YQ
Message-ID: <CA+fCnZdWxWD99t9yhmB90VPefi3Gohn8Peo6=cxrvw8Zdz+3qQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Baoquan He <bhe@redhat.com>, snovitoll@gmail.com, glider@google.com, 
	dvyukov@google.com, elver@google.com, linux-mm@kvack.org, 
	vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250905_110851_569546_D3EAA19E 
X-CRM114-Status: GOOD (  15.37  )
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

On Fri, Sep 5, 2025 at 7:12=E2=80=AFPM Andrey Ryabinin <ryabinin.a.a@gmail.=
com> wrote:
>
> > But have you tried running kasan=3Doff + CONFIG_KASAN_STACK=3Dy +
> > CONFIG_VMAP_STACK=3Dy (+ CONFIG_KASAN_VMALLOC=3Dy)? I would expect this
> > should causes crashes, as the early shadow is mapped as read-only and
> > the inline stack instrumentation will try writing into it (or do the
> > writes into the early shadow somehow get ignored?..).
> >
>
> It's not read-only, otherwise we would crash very early before full shado=
w
> setup and won't be able to boot at all. So writes still happen, and shado=
w
> checked, but reports are disabled.

Hm, I thought it worked like that, but then what threw me off just now
was seeing that zero_pte_populate()->pte_wrprotect() (on arm64) resets
the PTE_WRITE bit and sets the PTE_RDONLY bit. So I thought the
kasan_early_shadow_page is marked as read-only and then the
instrumentation is disabled for all early code that might write into
the page before the proper shadow is set up. Or am I reading this
bit-setting code wrong?

