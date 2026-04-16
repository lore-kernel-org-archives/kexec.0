Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A42F8D759
	for <kexec@archiver.kernel.org>; Thu, 16 Apr 2026 15:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b68ONNVu+A9z5YiXqc2LhLMiu8RR50d90ZOohhHUFtk=; b=2iF+8YYBEtHwvNjE08QSBRPQLr
	bqvk3v8C3fpMP8tb0F7DQyIu3fWpguB4kajK0OYRVbUzxyAKlJij3EPKEstNpY+l3AhhdL6lMDHVV
	bpDysNf0abBAI9KsGxWeRzM1No2DB04r8rwqPOPtm5w1x0dXQYV39N8QzDCuSVs0+GbRpZwBaWWi+
	Cf3gatNIIBn5bz0O1huQ96WgUUVQfMT2dd/CT2FgnGBYLHv5KK4PsnVtkcLmId3GpRuOVZV+hD3VT
	fznFdjFlq6ru4xrncrzKD/ZQfEbXHa6pA3xUhiwgApHlTMFIOK2xBXhdQjfdNTG9BYKiUpn2A476Q
	vMEZorQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDOZJ-00000002c3R-0hIG;
	Thu, 16 Apr 2026 15:23:49 +0000
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDOZE-00000002c33-3zaJ
	for kexec@lists.infradead.org;
	Thu, 16 Apr 2026 15:23:46 +0000
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-126ea4e9697so7574c88.1
        for <kexec@lists.infradead.org>; Thu, 16 Apr 2026 08:23:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776353024; cv=none;
        d=google.com; s=arc-20240605;
        b=crbZ/HNROMfiqQufTkuXSPWYJO3/x7xFB4aCP3ru4UtF+sibmgVA1PxfF58ntCjWON
         dVkMOWW4J6lcACCHavEoIxNLRddpUlXHI0xzkG0hgkpaCD4K/hU0JUhtu9xafk2+W0JZ
         gAZNK4m7yvy0PaNYIes7ShwDv2flkgKn9XTf7loLVeP7VjoKEaeqICLJBlD3Wll5NDmI
         rlEgSf96aNIuI+IZmPHkPf3tn4jsF/ae3KKYgn6FXtXmnDr33BUvKjj5F1ThYmTWIayo
         idQVISH6LWls4GyrmKT/4Dqk8cs663uVQsyyoxytbUjh/eq9AUsNS+eaUgQzOw8ckma1
         TH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b68ONNVu+A9z5YiXqc2LhLMiu8RR50d90ZOohhHUFtk=;
        fh=YmZr5Uvptl7hzejwHSLt7IQY6XH7Eq948la73/tU1H8=;
        b=Iy/BYIcatw9USOznmb8smZN433iIOKbhP7WIepHAmGmmbh+BvkSpFUkRYvZ5MF9zbu
         zCXbYCuHiGIOK/XDLqsvFb6NRFgLEGYI+rrav2DKgsfSO/3glVFdBXRJBLfrvC+Fm4sN
         PfLVlSjAhtF3PnpUkEGOqsaN8a/5XBwhMvC7nC+BzjcM2yuwJfILlY78lRQihVTLum+t
         Y/Nb9lExTmbaAAz3iL7p7vDTMxQaDnxINEYQOKSbxtCmoiBWmOC07rnaBdzVkcD22W1S
         8NV7tCgVoSS9g/zGrCqz4eVdMHlABOu3w5Wu4BtwvT8vfMNi2uwfdUF9oIUqbKXHn1S3
         i7pQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776353024; x=1776957824; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b68ONNVu+A9z5YiXqc2LhLMiu8RR50d90ZOohhHUFtk=;
        b=Uw+MrsqJi02ETz0EHQQ5FiKaBi3P45lDyJg8BJWsyz2yD7t7VP973NCDVWNhWsSl8K
         diNdK4MHtE0QMiV+puUkijZHbXGbb+FkhU2fuRBtyMH5JUd72PZXa+Kwbn1TcAICOXEY
         EFZuaZRjzAxu2rdmEdjAhv4/SC9dPf05K3GZuEJYporLRkoTzvAYCWU8KLA9QhhaBqPB
         /S/lU+HafwTGnWPDNOXi0hSK0HxyAeyNiwGb7IDV0dn144TEWKCBGilL6RVu9ySMhRV6
         BtA4XocR49TniCTYa1uJkZmSAVcUiiC0Rz39EKgLGf4O8AFoUJsmXbYkZZUqArxQgixi
         pKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776353024; x=1776957824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b68ONNVu+A9z5YiXqc2LhLMiu8RR50d90ZOohhHUFtk=;
        b=CpHvhGjzicccxdsDTg9iUH0OrIpcjGNOIr9c2XlgaK7a4/hx4BoP7uzmdJyeWuNxnA
         b8OR6WUfr1xYB/I+liJj4iR6iKeLmjsG1A9dTIgXFAoAC0NJitlaTex6Ad3DokAAIbAt
         jWgkmo9YazDhxfVlO4HXlaD60tXGqiLAlhbbHTyaoMPdIHnTFnAfHMALMEnfrb8Aj56s
         TckXOSQ9bLk1pYwdCXM9dz4hBsHedoe4+fYS91VActIV9nyZWHxJt4OWB2sNIhMa8eqB
         E2+tLOLpMHMfBkhPBvFAard1WswB62sC1o81L49KweP7wn4Z+mvTMB4f7GOPvYdTlJSK
         5WvA==
X-Forwarded-Encrypted: i=1; AFNElJ/y1tBVWBicVUEuTXGw7tsZW91IU4M62Ow009QaDim/qioKKwceiaIsiyQ1Bjqj42WOi1NsPA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxRJS7EwfWZ/F1fEvXvfA3Am+gNP2mZs09lgDiVWEEL+U1tdsVA
	mkhlws2dUdxe8OZTBpCaHDK6H7uxn7njBqgyq38WPpdFkjn6EDtYGNwKUKFSE2UansqvUKkqEv8
	JqDjPanMF9QXMRqApgtb34B6/w2Vnwy8mOq/IAozE
X-Gm-Gg: AeBDieuuTH0yqlt0VLj2Tgee7dnjq5KTCNWT1iVoPFPIDmpWPP2TfKF4f4JC0Z7PDSl
	3YSv05FFjk52RysycGtaRFxNHo7so8Gtws24d5DYXJnajWXWp2CYG29KtOQP5BdTiLKz4ymHb7a
	0/5Ei0P/kxH8XlnXSKf2tzG90rAipq+eAyqbRxjOc7bR/pPZMqtKCws/7VmHCgmGKG8n6CwH8IV
	xVju74y78E7d3Xwe5sTqRVWnL4Faopfh03wXBdUfWmnuFKdWP2tTwuQjhLWjwz3Bgt+J+W1UHr4
	LzJL6pb0HCgPiaX0jr8paAP3Q8HZQKWONvS7uf9I+dcZa4KaoliJdmycCiw=
X-Received: by 2002:a05:7022:6b94:b0:128:ba6e:f809 with SMTP id
 a92af1059eb24-12c636c86f6mr184550c88.6.1776353023426; Thu, 16 Apr 2026
 08:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260416110654.247398-1-mclapinski@google.com> <aeD5kboEdzwuR4P_@kernel.org>
In-Reply-To: <aeD5kboEdzwuR4P_@kernel.org>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Thu, 16 Apr 2026 17:23:32 +0200
X-Gm-Features: AQROBzAD7ws_4z5SDd0LjpAlZ33XQQakBVV1I13_nXLGtUXK3uD9T-fFc-Ww5TY
Message-ID: <CAAi7L5dFaxwoU5dho8sJJ41+SSwgrmXW_NjQZnn7UPzj0zoowg@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] kho: add support for deferred struct page init
To: Mike Rapoport <rppt@kernel.org>
Cc: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_082345_027667_062FDB93 
X-CRM114-Status: GOOD (  28.32  )
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

On Thu, Apr 16, 2026 at 5:00=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Thu, Apr 16, 2026 at 01:06:52PM +0200, Michal Clapinski wrote:
> > When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, struct page
> > initialization is deferred to parallel kthreads that run later in
> > the boot process.
> >
> > Currently, KHO is incompatible with DEFERRED.
> > This series fixes that incompatibility.
> > ---
> > v8:
> > - moved overriding the migratetype from init_pageblock_migratetype
> >   to callsites
> > v7:
> > - reimplemented the initialization of kho scratch again
> > v6:
> > - reimplemented the initialization of kho scratch
> > v5:
> > - rebased
> > v4:
> > - added a new commit to fix deferred init of kho scratch
> > - switched to ulong when refering to pfn
> > v3:
> > - changed commit msg
> > - don't invoke early_pfn_to_nid if CONFIG_DEFERRED_STRUCT_PAGE_INIT=3Dn
> > v2:
> > - updated a comment
> >
> > I took Evangelos's test code:
> > https://git.infradead.org/?p=3Dusers/vpetrog/linux.git;a=3Dshortlog;h=
=3Drefs/heads/kho-deferred-struct-page-init
> > and then modified it to this monster test that does 2 allocations:
> > at core_initcall (early) and at module_init (late). Then kexec, then
> > 2 more allocations at these points, then restore the original 2, then
> > kexec, then restore the other 2. Basically I test preservation of early
> > and late allocation both on cold and on warm boot.
> > Tested it both with and without DEFERRED.
>
> Any chance you can clean that monster and send it as patch 3?

I fear that would delay this series somewhere into v15, which I would
like to avoid. Can I clean it up and send it separately?

> There's no real difference between core_initcall() and module_init() with
> respect to that deferred page initialization, they both run after the
> memory map is fully initialized.

One of them runs before kho_init() and the other after. So it allowed
me to expose the bug that I introduced in v4.

> > This patch probably doesn't apply onto anything currently.
> > It's based on mm-new with
> > "memblock: move reserve_bootmem_range() to memblock.c and make it stati=
c"
> > cherrypicked from rppt/memblock.
>
> You can base on for-next in the memblock tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock

I tried that but that branch is missing other commits from mm-new. So
I would have to modify my code, which would then conflict with mm-new.


> > Evangelos Petrongonas (1):
> >   kho: make preserved pages compatible with deferred struct page init
> >
> > Michal Clapinski (1):
> >   kho: fix deferred initialization of scratch areas
> >
> >  include/linux/memblock.h           |  7 ++--
> >  kernel/liveupdate/Kconfig          |  2 --
> >  kernel/liveupdate/kexec_handover.c | 52 +++++++++++++++---------------
> >  mm/memblock.c                      | 41 +++++++++++------------
> >  mm/mm_init.c                       | 27 +++++++++++-----
> >  5 files changed, 69 insertions(+), 60 deletions(-)
> >
> > --
> > 2.54.0.rc1.555.g9c883467ad-goog
> >
>
> --
> Sincerely yours,
> Mike.

