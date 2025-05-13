Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C696C3ABC3
	for <kexec@archiver.kernel.org>; Tue, 13 May 2025 03:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gzecB5JF2WCaVL4U1mFSN1RE6OGoHu2bmVNsGCvVbk4=; b=Iyt0X5yIbkDzOmzIDa0P/cKqZO
	sskLV/CgDKE/993LyyPNXR6eLpqo4RV7aKRYPFZD55iJajgNgOnRHDg316XG0DdL8xZL+lzMxVHx2
	B71jFWQ4l03hQI0xkiWRKxSCTsDkLOiGNj/X8pJB34Tt5yfz7tqNRkwSkQJBKBKe/SPATTPUUrhgY
	FPxtwd70JfvtvXaKY9gKbLMl7fdbtD/IsiZz7Nso5C6hm+8mY3GsCFvZT3L9KjgYghtfku3eucteU
	dB3mx1ES7eVOkCuF5ukUCKDmZrRzWcSvSYhEaQXdcW59dv/Qr5ZJ6VzgzeTQ9vKBLzpNjzhJX4ULv
	Qi5m4GPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEgAq-0000000BEvb-1iE9;
	Tue, 13 May 2025 03:19:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEg5s-0000000BEHP-1Beq
	for kexec@lists.infradead.org;
	Tue, 13 May 2025 03:14:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AE92C629F8;
	Tue, 13 May 2025 03:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3342BC4CEE7;
	Tue, 13 May 2025 03:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1747106049;
	bh=jeFqy7zKESSjHISNy8tS/rhzHwYLUa6cEV201i7Nzks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MLSvsplGVO8OHx8goaLdPzja4JBmyQk/Mq62gXJ+ixRyRJFDZ+XPANipvuuoULo5h
	 gN7v7dzD4DvcO5WrwxdFAU+T5NJI2bqfSGXD81I0ml294lc9HM570dpp1uW4VWEf/z
	 FePhgHLFdOHtgAudqq+5FWAtUhYXlTM12YMLgYbA=
Date: Mon, 12 May 2025 20:14:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alexander Graf <graf@amazon.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, nh-open-source@amazon.com
Subject: Re: [PATCH] kexec: Enable CMA based contiguous allocation
Message-Id: <20250512201408.81acaf861581f6fb98e8a3b0@linux-foundation.org>
In-Reply-To: <35f818e2cf3f15b7dc7028f543e0eea94c799efd.camel@infradead.org>
References: <20250512225752.11687-1-graf@amazon.com>
	<20250512165933.ad1dc7ec5872284b4b59f544@linux-foundation.org>
	<35f818e2cf3f15b7dc7028f543e0eea94c799efd.camel@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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

On Mon, 12 May 2025 19:02:20 -0700 David Woodhouse <dwmw2@infradead.org> wr=
ote:

> > > =A0 2) More robust. Even if by accident some page is still in use for=
 DMA,
> > > =A0=A0=A0=A0 the new kernel image will be safe from that access becau=
se it resides
> > > =A0=A0=A0=A0 in a memory region that is considered allocated in the o=
ld kernel and
> > > =A0=A0=A0=A0 has a chance to reinitialize that component.
> >=20
> >=20
>  > https://lore.kernel.org/all/20250512140909.3464-1-dssauerw@amazon.de/>
>
> >Is this known to be a problem in current code?
>=20
> Oh $DEITY yes. The Arm Generic Interrupt Controller is, to quote a dear
> friend, "a cautionary tale of how not to approach a hardware design".
>=20
> It does a whole bunch of arbitrary DMA all over the place, and doesn't
> even live behind an IOMMU. And doesn't *stop* doing DMA unless you ask
> it *really* nicely; merely shutting down the offending high-level
> components isn't always enough, because they might still to write back
> some caches.
>=20
> Here's one of the latest examples (not actually the one which has been
> breaking kexec for us, as far as we know, but an example of the genre):
> https://lore.kernel.org/all/20250512140909.3464-1-dssauerw@amazon.de/
>=20
> So putting the new kernel into a physical memory region which was
> considered 'free' by the previous kernel, as Alex explains, is actually
> a very good defence-in-depth mechanism to protect against such issues.

Lol, it sounds like you're having fun over there.

Alexander, can you please repackage David's info to your taste and
include it in the changelog?  Escalating the value of the patch from
"might speed it up, don't know how much" to "addresses grievous
real-world issues" is helpful to the patch's case!


