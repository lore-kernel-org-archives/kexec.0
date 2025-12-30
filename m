Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF04DEE4982
	for <kexec@archiver.kernel.org>; Tue, 30 Dec 2025 16:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OL50/gZnO2VMMSC973/UKorxrP/7cJIiMBsmZ6LNx7g=; b=2ESzb6t6l7gBD2wmC0gnGK2Zsi
	iYzwahRTEJ+aI80qY++VXQf+u66p5DTl3fdF9jjru83YjgoZU5oRe+ej3C9Q21IRcXBb+l0wMnE1e
	S0HmGrTwPNZLYUKP1bhx+7mwt5d6CLLv7Q33da/znWYjfiFx2IwFvTg6VVB4FTtxfmC5Ct9iWgyCL
	VMk6Ahpqk7mnBBKqQAQoivt29HL1U1PdKIbffMAd4Ttqk2/YJ5I2vaywEkFNAhLPDY09ET9tdbdR6
	sUWIzZO4b20SUzqpCDfvn48bqA1z6S1n2VOHibxW9CnSk2m6GRtGjCS5zCr5HNEq55ASqWy52KoWK
	SLFo59AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vacQy-0000000537J-1Eh2;
	Tue, 30 Dec 2025 16:18:56 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vacQv-0000000536F-2OIY
	for kexec@lists.infradead.org;
	Tue, 30 Dec 2025 16:18:54 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-64d2c50f0d6so11976272a12.3
        for <kexec@lists.infradead.org>; Tue, 30 Dec 2025 08:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1767111531; x=1767716331; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OL50/gZnO2VMMSC973/UKorxrP/7cJIiMBsmZ6LNx7g=;
        b=C5319Z6eVjiiv6bVwU1bNP13YcQR+N0o4zv0MrjV2zWMzB9IzAASe0ip4QgRlEBJYb
         fyJ3q0xsbDvgWxeb5xVyOGzIARQyzkPVoox5CrYNuhhG7LA7NzyyLoeVW+L00d029shb
         sNERgw2+6W8/lV9J3Fk6eOm/5CajmtmlX2rB4LPjK2WbQwjAe//fm0vI9v6n9it9ITTI
         I7yrwMnNZkCML0iXcRkRfHTA4w0HqSV9DC3ec1IcnfzngXz3E5BIqI3tmnZrnriWk52m
         ksxGhjuVCP94utUQczMYQy0qUUgp0AMYetAAB3LqAagzT+xvsjkl1ABhSxCcare0ZT46
         1k9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767111531; x=1767716331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OL50/gZnO2VMMSC973/UKorxrP/7cJIiMBsmZ6LNx7g=;
        b=RX4k1GJcouHHS8gCPzhKQjY9wB0JQMDwrtNeKh1H7bMu+Vt4BSbwv9iFAxiEEk77Vw
         YOellnytMKYjB9oLu+zI7OhfoVxp+W5A3j2XMw5BwhKWQaNJ4HIAJZAs8Jw1YGNHz4n8
         KbJQUMfXLAa2gEVohMrH8lgqcRlP6uvN+awrNUm9FYJ6IQ3MD7uprfdihMNubSXsfxM5
         /5UDtKI+BGR1Hc5VOwMjy0+zPJrvKUeQP0pdeXu6iTqV+GbXquqghIaJlCWqmA0GSCK/
         HArEfPYp4o9xGKSB3gtrGe5xnREZ9gk2v//74iNLRbBOteHpERZrFGPUZLBfmoXQ90ru
         8fDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU26yN8yydnxRNc10rRqjn71d1zibTU4PHTNKX+teLq5XxX4TdL6duwqFjgQOxgA18CIrXNeg==@lists.infradead.org
X-Gm-Message-State: AOJu0YySAX1iDb63A/8WFLuug0y2d87+goEBb0U1gDPBLi1kE1RGNlzn
	EURe3pZo7uSTZ+eDQDTWKk07DytK8OPteQIvW5DQQBJDdvLjIEsDJxJFTY/AGhkT07/hMwprTBr
	nWy8TIhG23dpISocpRzk4i0YYycEvFUu6QeiXMdg4pA==
X-Gm-Gg: AY/fxX76iwuX/pExrQUyQra1FccEEqFSelYVqNhbunZilcpgMPCEo3DQQJiI/UYqcOw
	zeJfUF4+iyTaRGxnzAtXQr59PAEmh9nMu8VMCI/pZR7T5WKds+6cVBWOtoG4mEs+zZ1qzQrZIeB
	5ixUQUJMQiGfGeOcED3FF0C5bs0v/IL7lFkf9GArTW2HBYJ/5L+yzaI01wFiC0tZlpNE8K1AnIw
	th9/0pypOGDhJoyA5TBQvwz6px/h8FrVtCcxqCmNDXZlU6J1CZVRcT5lLRqFOjVcKPlD46xhYnT
	cQzB9G1W+P5L4hbDHYr59tVFkQ==
X-Google-Smtp-Source: AGHT+IFeLw7u44MQZgbjsQFGA12sP1qdi+5HsRmBGCX/BEXK6I9KYbtNSPfAQW5/lttSum6QUrCoLo8izwyidq6kWdA=
X-Received: by 2002:a17:907:97cf:b0:b7a:72bd:ac65 with SMTP id
 a640c23a62f3a-b8036ec9e68mr3510206766b.9.1767111529979; Tue, 30 Dec 2025
 08:18:49 -0800 (PST)
MIME-Version: 1.0
References: <aUUYprAotKYMiEs0@kernel.org> <CA+CK2bD101cSC_7+OWkMei2QvUVjSaRLy+LboLe8Sz7KS3by4g@mail.gmail.com>
 <861pkpkffh.fsf@kernel.org> <CA+CK2bA1kYCf0BwhX3Sg9Ur82nK-7HPzs0sg6xbVWFAJaZLhpw@mail.gmail.com>
 <86jyyecyzh.fsf@kernel.org> <CA+CK2bDxnTEe9Ohq5zLuyF-jqgD0DPhfdq6z=yztUsXU5p5fSQ@mail.gmail.com>
 <863452cwns.fsf@kernel.org> <CA+CK2bCjJWZG_rPoPsHWSxirmUCTOuFQzTCss2AKf9UqpThrdw@mail.gmail.com>
 <864ip99f1a.fsf@kernel.org> <CA+CK2bDDEZ5a+LJNDVMtKFtQ1D9rP6rJqU064eoru=a9eHpaAQ@mail.gmail.com>
 <aVP6wBYoHJQsplIl@kernel.org>
In-Reply-To: <aVP6wBYoHJQsplIl@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 30 Dec 2025 11:18:12 -0500
X-Gm-Features: AQt7F2rRyBAWSRSVw8tyvBNQJKwYnaZAfvLVHz2DyBAssxNNcP1N6GpP7-FmoGk
Message-ID: <CA+CK2bDZPwYpUhksDLSbfVdVm5TYbh0XrOKRV=q4YjGpqH+Fwg@mail.gmail.com>
Subject: Re: [PATCH] kho: add support for deferred struct page init
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Evangelos Petrongonas <epetron@amazon.de>, 
	Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251230_081853_620315_268DAB24 
X-CRM114-Status: GOOD (  14.83  )
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

On Tue, Dec 30, 2025 at 11:16=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> On Tue, Dec 30, 2025 at 11:05:05AM -0500, Pasha Tatashin wrote:
> > On Mon, Dec 29, 2025 at 4:03=E2=80=AFPM Pratyush Yadav <pratyush@kernel=
.org> wrote:
> > >
> > > The magic is purely sanity checking. It is not used to decide anythin=
g
> > > other than to make sure this is actually a KHO page. I don't intend t=
o
> > > change that. My point is, if we make sure the KHO pages are properly
> > > initialized during MM init, then restoring can actually be a very che=
ap
> > > operation, where you only do the sanity checking. You can even put th=
e
> > > magic check behind CONFIG_KEXEC_HANDOVER_DEBUG if you want, but I thi=
nk
> > > it is useful enough to keep in production systems too.
> >
> > It is part of a critical hotpath during blackout, should really be
> > behind CONFIG_KEXEC_HANDOVER_DEBUG
>
> Do you have the numbers? ;-)

The fastest reboot we can achieve is ~0.4s on ARM
(shutdown+purgatory+boot), let's not add anything to regress, as every
microsecond counts during blackout.

Pasha

