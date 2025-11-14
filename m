Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6377CEACD2
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 22:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NsPGYF2w3uxO5rL5MOHM8fulZ8/BOxWbrIXWlML1778=; b=KgpyR5K4vwH0PYm5jptPko3SIv
	mONr1w3DROSpm63Qx0XtgKhjJTuOtiK7XeeSJi8Q02Laj+/MNaBNxeTQejWYP2pBr+J4xL64ZlxmF
	ooh6+RuCxVFwRX1rt4xjGW7mCwjO6X/ZFpnPlp/cm4o3BbMgEhsbq7FGaxvEl7zFGoHIpRmFUfQ2v
	Ip+8MApmln2EP5KIP1L5EMGJJMuB/7f3EE4/l5Yo78Jf+qFQo5ePh0PvrQ4Azyp4N90vs0q8/SXrw
	zPJqSkWN2Jz2E2A/kehaSW1zKrjVyc3K4NO9qKN43NtN8hP6CmxeJUHVjOG7Q5tUEwfs3H3oWQRAW
	HaHU0gXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vK1wy-0000000DA3t-3V02;
	Fri, 14 Nov 2025 22:07:24 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vK1wv-0000000DA3W-2oIE
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 22:07:23 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso3909513a12.3
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 14:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763158040; x=1763762840; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsPGYF2w3uxO5rL5MOHM8fulZ8/BOxWbrIXWlML1778=;
        b=ivCIYO7WR3j/UShbBdM+uuX27IedJ8U6M13wON3Jvl6/tdwKWZ7D4Smcqn7GY/7V2Y
         1A5sosRXtShdsQqz6fDMj2+feONuicxYcDAUdgztzfsj4S1bq9MXxy4p4orv7RbmBBtV
         uVWFtwBZv+exyrQ8f54ZToOTCvGoi+uUqc9sNJF73QMNoGnLd05UCIF++ji1PUAKlpi/
         4a7XtLO7ARCE+KgkP+HJ9ZNEr+LPpaK9T8CNaeytugRNEvtvTehOjYYyGRmi1VL4Aqvz
         W3uGVShTpF2eXoRQZo/IK30VBce5rLhWvywgWNcOj0dwysnLHT03wDWEiHzcmg7o7G9X
         7T+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763158040; x=1763762840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NsPGYF2w3uxO5rL5MOHM8fulZ8/BOxWbrIXWlML1778=;
        b=bQLaKrZYEuodtydolZDWc1HJ9fprl2HC5zNPGtuSz33ljdVRmt4dKd6flRsgHPMLkt
         CF+eyJzcO+pOnj9u9Vdit74TqQDnxICVp8p0/JdJnZouYgt9uVgINi/h7wRCElILoqlO
         95d1EnqESiPc8WI+Dsz125jDsVbHr7a/tkPJFpzh5WVO0+C9yOO8oIoSkAZGsCX+VlcT
         sWfixqOjcqDPuQJzX06raOPoFbiSeUVcjfVTXLRLLZ5JZwGRzR9Gz3rz47JztSLE0s/A
         p/oSTSG5+FzbGt6bmKQL3bnSpqHPL3H4fmKuigJ94syGHmcFYY7kLg4Zcru43MMnQNxa
         q/tg==
X-Forwarded-Encrypted: i=1; AJvYcCVXUUcg8RxiGbYEfDb3yw8LZZsxHaL+Y7OBXtA1k/pq+CqKVSmTcLT6AF5r24dqm2zg1cYkew==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywlx1HgDs7ckJyKIkGX5mfcDNQYjXlie9rPoBAw7GjPlT+mXPk6
	Ik0QUEvsFmqEAvJnTtDl3gmdsx+aBO2t2f1mylCRtaJvEJjQOX9mm0IUO/6bCoytixWKQYR5Akl
	F9Gqn4wvYKxsIwMhkM45P96XdTjyG8cLtMWMQ/Rv9iQ==
X-Gm-Gg: ASbGncvOW66FAOlDbnEvKmWlUQusHHRTVAzcxaCyWbGvI7s93+d3rXsvsKe0SIpKOAp
	4UDiPRJB18WLCghw4TaLLu4KUekiMbWrm0FLFn7Dms+u1Oapn84bE+gc3KKYq+T+0/CwFCV0z+e
	JjGtFNRpdqeOyCTChZdEiBHiECFthZIJ5LxG7D6gd8KOx+n9QcvMPrA3F1P9Vli3GwMI6fp3fGp
	A42Pkh9PYiZGdlorPqdexyUeOXWnS+Hy1XMwDtsEi1vzQBKkGmuOulmW/iTRQaLFMvM
X-Google-Smtp-Source: AGHT+IGFFZxrMCPmeJDXNHicMreqnciEQvXQFLNeLQFPskn+jhYADDIQoofuIRZMtOTmH83ub483KykN+dONJWKkP+U=
X-Received: by 2002:a05:6402:2710:b0:640:c454:e9 with SMTP id
 4fb4d7f45d1cf-64350e1120fmr4061156a12.4.1763158039593; Fri, 14 Nov 2025
 14:07:19 -0800 (PST)
MIME-Version: 1.0
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
 <20251114134434.5375d085a6bdc1671351f243@linux-foundation.org> <CA+CK2bB2O4Z6iaBMZ8G1paxdH4gywDvVsD6MtxHJW_mtS7hG7Q@mail.gmail.com>
In-Reply-To: <CA+CK2bB2O4Z6iaBMZ8G1paxdH4gywDvVsD6MtxHJW_mtS7hG7Q@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 17:06:42 -0500
X-Gm-Features: AWmQ_bmztZ2aQAhXiPYW2w94nYRhCiX3lNmPSLyIjD-mYwCHE5AQJdQs-jg1R5U
Message-ID: <CA+CK2bD4vr2tZpKaGqOZBhP+DMZYYm3EB_0ToyFDduZDMWhXxw@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] kho: simplify state machine and enable dynamic updates
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bhe@redhat.com, rppt@kernel.org, jasonmiu@google.com, arnd@arndb.de, 
	coxu@redhat.com, dave@vasilevsky.ca, ebiggers@google.com, graf@amazon.com, 
	kees@kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_140721_733216_F735F878 
X-CRM114-Status: GOOD (  22.75  )
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

On Fri, Nov 14, 2025 at 5:00=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Fri, Nov 14, 2025 at 4:44=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Fri, 14 Nov 2025 13:59:49 -0500 Pasha Tatashin <pasha.tatashin@solee=
n.com> wrote:
> >
> > > Andrew: This series applies against mm-nonmm-unstable, but should
> > > go right before LUOv5, i.e. on top of:
> > > "liveupdate: kho: use %pe format specifier for error pointer printing=
"
> > >
> > > Changelog v2:
> > > - Addressed comments from Mike and Pratyush
> > > - Added Review-bys.
> > >
> > > It also replaces the following patches, that once applied should be
> > > dropped from mm-nonmm-unstable:
> > > "liveupdate: kho: when live update add KHO image during kexec load"
> > > "liveupdate: Kconfig: make debugfs optional"
> > > "kho: enable KHO by default"
> > >
> > > This patch series refactors the Kexec Handover subsystem to transitio=
n
> > > from a rigid, state-locked model to a dynamic, re-entrant architectur=
e.
> > > It also introduces usability improvements.
> >
> > OK.

Also, with this series, kho_unpreserve_folio() returns void, and LUOv5
requires two small fixes where this function is used:

1. fixup for mm: "memfd_luo: allow preserving memfd"
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index e366de627264..ba435590d2cf 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -138,7 +138,7 @@ static struct memfd_luo_folio_ser
*memfd_luo_preserve_folios(struct file *file,
 err_unpreserve:
        i--;
        for (; i >=3D 0; i--)
-               WARN_ON_ONCE(kho_unpreserve_folio(folios[i]));
+               kho_unpreserve_folio(folios[i]);
        vfree(pfolios);
 err_unpin:
        unpin_folios(folios, nr_folios);
@@ -170,7 +170,7 @@ static void memfd_luo_unpreserve_folios(void *fdt,
struct memfd_luo_folio_ser *p

                folio =3D pfn_folio(PRESERVED_FOLIO_PFN(pfolio->foliodesc))=
;

-               WARN_ON_ONCE(kho_unpreserve_folio(folio));
+               kho_unpreserve_folio(folio);
                unpin_folio(folio);
        }

2. Fixup for liveupdate: luo_core: integrate with KHO:

diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 29a094ee225c..f0bc3ee0a10b 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -305,7 +305,7 @@ void luo_free_unpreserve(void *mem, size_t size)
                return;

        folio =3D virt_to_folio(mem);
-       WARN_ON_ONCE(kho_unpreserve_folio(folio));
+       kho_unpreserve_folio(folio);
        folio_put(folio);
 }


> >
> > Where are we with the series "Live Update Orchestrator, v5"?
>
> I am working on LUOv6, it is going to be an incremental update with
> much smaller delta compared to v4->v5, addressing all the comments
> collected so far. I plan to send it out this weekend.
>
> Thank you,
> Pasha
>
> > I'm seeing a couple of review comments which I plan to circle back on:
> >
> > https://lkml.kernel.org/r/aROZi043lxtegqWE@kernel.org
> > https://lkml.kernel.org/r/mafs0ms4tajcs.fsf@kernel.org
> > and a comment from yourself against
> > liveupdate-luo_core-integrate-with-kho.patch which indicates that you
> > plan to update that patch?

