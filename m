Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65ADF99C64
	for <kexec@archiver.kernel.org>; Fri, 17 Apr 2026 20:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mc5L8/2rvf9EGhlXImjnU4JiA5BGpM3lg66Pey7qRR8=; b=MSqFHl3cwVUveqmYwDRROP9nnj
	J29eUlSSEjzsyN4ASfLVmfTSaxu3TK4jfqK6ncvI+Fm8jTYuBPQiVoqALRP85Q7MXjsnUR2SCxGHI
	R14Ta6y4UJOn/ujv/A3mVyDYE1qfXTOvwEJyfem1poKrrCBj5OQPFAuxR5WrDGb8aIfZ8yjRWEgYl
	qAyOJxVoylJP6K52HjVZ0ABFnMXBkqEW6NESaMn3uuRlJXajYb0JXiitnYNl8ghPdE/7yMYAD23uM
	CSUUsMEgTkiV7NY+X+V3nvYzLsmgusu4IYEnR2vt0/jRHMTgSqPXtgLAa6O6WB56cm/7WJnXxnGgo
	M1YT5YTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDq09-00000004SY4-39bf;
	Fri, 17 Apr 2026 20:41:21 +0000
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDq06-00000004SXf-1n9L
	for kexec@lists.infradead.org;
	Fri, 17 Apr 2026 20:41:19 +0000
Received: by mail-yx1-xb12a.google.com with SMTP id 956f58d0204a3-650775f427eso1293043d50.2
        for <kexec@lists.infradead.org>; Fri, 17 Apr 2026 13:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776458477; cv=none;
        d=google.com; s=arc-20240605;
        b=FP0q+Kv848zNfJvdCfY2I0wRxLLVh4XQKyBAWCF6Boc8LwYqxhI16Dfs9Y/p02cE8k
         teL/KhJ7icPz/ESCr1yvfZ/hyGkFOfGGS8R3OsA335wD96un+L18+CMJNl20lmzZM6G4
         +nCve6NvNKbwocOG77kwJf9EglNm3m3hKqQZS8PZYMiwU3XsOqrc2XV701qQLYeXxe8J
         FC7KvqTY4hVwJK88KQhZbUKSWX8eN5Kf4nUe5WaNukg6kswriDR67PgxzyE1IQuTlyIc
         kbVoAKeemD9H/h/k4BDe7QRDDbLrFdlLxXqakTsPXaeYt2XV4x+O8mvbzxG3HqiOeRDN
         PMKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Mc5L8/2rvf9EGhlXImjnU4JiA5BGpM3lg66Pey7qRR8=;
        fh=ohCuSSbU8OF8OzIpF+xjR4hSL0ojwXgoq4znVtE914U=;
        b=LnvG1JgT1tlyw7NTdBALcHGBQOQaLSaKo7eEj8HQhoqJ21wLcgFerh3NJ11l2nmDja
         +eEZtKMwlJ2ctRKnzgRycrVmnD5s/Wqi8GTp/trKqfRlJWSNFrjf1S4/kZ9miThqS58Y
         PVVU9ubSzzF5qBHthLRDXLZNlDCBn2Bm3iselVJQ36ZXHtSiZxbZtWXiX5bbz+s51F9n
         5anJt1bIuJ6MOfxJMvyXiVu1kkeACv0223DtpST1yv/QR6UeHAPlgWUB/1TPzUQhGLoz
         oo/ttkT1GfLBOAC1Wz3hym4/DY82YcyXmr3IAVog3F+I0Up1wW3KKbM6qaDOGmJgM0nk
         Qr8w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776458477; x=1777063277; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc5L8/2rvf9EGhlXImjnU4JiA5BGpM3lg66Pey7qRR8=;
        b=oKuXS+qOtB3QKsRAyVVxKZANzZxWQ/pbv0ogqUozNylQ91KI3+Ug2KWPZfviITpfGv
         bXG9M3EtGROYLY6XnCiu5w6LvPawwpjMBVYHKVDpzWLtQ2/eoYW+z1jlQNndHzmRGafC
         w5J9vMNYo+/nsjRoD6ihDdpgsXMdHeR9A2Mi+MlR8Qn/VXsFEDmrWP7KTd/5KenTpcFS
         K0vWcwAbrfKaxWCsUMxf1xiJK+Hc1InHxh25vyccqTwWrf1Qz8zbfFdFGTShuPlYzCr7
         jr3D8UiLRRm7XhUNjvPvj8q3kgpns2TXuxXJ2zKEypGl6IeQmj+jrCyVpAvlTNNZyU7Z
         6ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776458477; x=1777063277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mc5L8/2rvf9EGhlXImjnU4JiA5BGpM3lg66Pey7qRR8=;
        b=k3RZz4VRF5JN+0U8ehN17epfgFL3cqJBYJIDKHNzKrLhgh835SJzzpiw1ec+CiNZ9Q
         rFz5wiYYQPHxb7lsy8F9TwWoYNH2O8J2zpvr7dPyvk9D4CFOs6i0onQLby6EmUWOzr4w
         XnHwrMro0krgVYyufO6OSHW0d5rF3Ic6xA3s2g6JSE9QtrFABs0YW093aRmpu+bxpsB0
         ybZ86gWXts6FMGkxv0+zlFuJHJPjJ58vQnhVOeQj0xZRSOg4EuR29HDFKHxnDI59pcJo
         EVlKmdNrqJ3b29i/u9WZ7RrJzo/5wEqFsOQNfijCwkjSAY/kvPJDEzS5Lh1WAxzHdkUz
         yOwg==
X-Gm-Message-State: AOJu0Yw8Mifp5sm7WxEW0A17mdAWZ7D3zLFPvLPiMv9OVl1cWpcbLYUV
	wjtRm0Jwish3A+noW4+wvHr3i7sqEgRER2BepxOJRXokv9qahfHxr/m8rs3gPFPUVVqEryXWvdv
	Jf73/ohEnsVHnQ4vXQtPatjaeHAfBqfN4Wg==
X-Gm-Gg: AeBDietjSZaFSXL0ItB+s+JqmDP5AGGkk9Yv3W7DWag/sy51UI7VwyBofaH1pBJsxgt
	w/oJVQm2cFlDyRTaHwv+Fyj1c7jnKE1DSZKRRf3nKOUeUPm6Sh243HMeHegEukO9r4UeBFy3fFT
	ta1n4ky97btxI1XhPdlf8C6dHNnzVHny5rGzGCMOHhcTWFacTrKL+Q9FtC+sTJDJEYWZZqj92en
	3B6i6SkQV39BsssvVw6tIhy5t26zidl0xGi6tUn0JhWYHFD4t0LTuAAnSPr3TO0Qu3cQFRX4myW
	szjJvt17NZObFMmfz5owBUdMvZMsbE3EIGqX0unptZLf5AT5I6dK
X-Received: by 2002:a53:e945:0:b0:650:dbb:e79c with SMTP id
 956f58d0204a3-65310a278bdmr3096868d50.40.1776458477280; Fri, 17 Apr 2026
 13:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260417094426.1556849-1-luca.boccassi@gmail.com> <3rtwn7lkj5icexyammer5limslchbkm4xdgynp5llbt3wwybnp@ikjv5si2xodg>
In-Reply-To: <3rtwn7lkj5icexyammer5limslchbkm4xdgynp5llbt3wwybnp@ikjv5si2xodg>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Fri, 17 Apr 2026 21:41:06 +0100
X-Gm-Features: AQROBzCSC3rE7AP0-H4hL0tA9NAIE5JD2R9rjoGlXVxZSGuKx95-rERAc1LspiI
Message-ID: <CAMw=ZnRpQQqq-ZoUmPKqs8=XBpZcQjFsrivmMXQsouR33ZNr8Q@mail.gmail.com>
Subject: Re: [PATCH v2] liveupdate: add LUO_SESSION_MAGIC magic inode type
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pratyush@kernel.org, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_134118_472107_783382AF 
X-CRM114-Status: GOOD (  15.43  )
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

On Fri, 17 Apr 2026 at 21:34, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
>
> On 04-17 10:44, luca.boccassi@gmail.com wrote:
> > From: Luca Boccassi <luca.boccassi@gmail.com>
> >
> > In userspace when managing LUO sessions we want to be able to identify
> > a FD as a LUO session, in order to be able to do the special handling
> > that they require in order to function as intended on kexec.
> >
> > Currently this requires scraping procfs and doing string matching on
> > the prefix of the dname, which is not an ideal interface.
> >
> > Add a singleton inode type with a magic value, so that we can
> > programmatically identify a fd as a LUO session via fstat().
>
> Hi Luca,
>
> The patch looks good to me, but please add a self-test to
> selftests/liveupdate/liveupdate.c to verify that the fstat interface works
> as expected.

Sure thing, added and sent v3

