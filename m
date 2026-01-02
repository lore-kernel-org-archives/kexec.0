Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E803EFA3748
	for <kexec@archiver.kernel.org>; Fri,  2 Jan 2026 14:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fAtafWg1sFBzBjGB7d+SGUoSzDz5D9BUwo+weGX2YLg=; b=d5WKq/Hg4zt+xOSsHGR0vhSmR5
	OPORxX4HImKdfcnMQeS9U94ggnc87Sl4gGDzFhgOyET+G1LPIT3+PKtkqQOcn9D4agiUaBQileF6Q
	7VTbLZkpPO+kA5qQDFRsAKVHjK9Oy/fC1YfFXrUIZQJKeNs12VxhEKwkKCyQkXKrWrLshtCOXxBce
	8JPk+jHykmR8IcNVXbuhn6V0f4Ittj5COhzLzGt4cPPOOR812/T9zDtXOih+IpcVQgGJ/g89Xnr+L
	PKzAxX28trXe7aqI4KubxJk9+adfaM51LxR4TaHaLK0th00XWRNCNARd8cHdDsW0pcsexV+x310s0
	IijtUI/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbg4o-00000008MGw-2A5t;
	Fri, 02 Jan 2026 14:24:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbg4n-00000008MGP-2Tws
	for kexec@lists.infradead.org;
	Fri, 02 Jan 2026 14:24:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8073E60017;
	Fri,  2 Jan 2026 14:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42226C116B1;
	Fri,  2 Jan 2026 14:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767363864;
	bh=fAtafWg1sFBzBjGB7d+SGUoSzDz5D9BUwo+weGX2YLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=L0we59nDG+Q3GO+jsNtxGY9fMPViX52grgVcLoYYogLiRu0tpcWBslFf5vCdovms0
	 jAZGfkNETBQOZJyw03RwzQyCxjmF8CGIzfhFKihnFxTSondniZaSRsC6aNtytG2pJ9
	 laaVkcVXzn9NczWdabf8Rk3cUuuKSPVQmn8DVlvBbHXT3ee944ykDzxaOkHpbMPzFg
	 24mwMcVKhvB5rCloyErmB8LjDtfa8jvARawIIlSwcy1AHh5JXL+NiGEDrHi1PdVf1k
	 19DmldnbzoIsY/IYkz5W4aGv8oRimtMl33ZnaW4baB3T96NBSCJz69fNwuQSfj4TTW
	 BN/2JbRLlBlFw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Evangelos Petrongonas <epetron@amazon.de>,
  Alexander Graf <graf@amazon.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  nh-open-source@amazon.com
Subject: Re: [PATCH] kho: add support for deferred struct page init
In-Reply-To: <aVTw_08W7zXR7Y0F@kernel.org> (Mike Rapoport's message of "Wed,
	31 Dec 2025 11:46:39 +0200")
References: <86jyyecyzh.fsf@kernel.org>
	<CA+CK2bDxnTEe9Ohq5zLuyF-jqgD0DPhfdq6z=yztUsXU5p5fSQ@mail.gmail.com>
	<863452cwns.fsf@kernel.org>
	<CA+CK2bCjJWZG_rPoPsHWSxirmUCTOuFQzTCss2AKf9UqpThrdw@mail.gmail.com>
	<864ip99f1a.fsf@kernel.org>
	<CA+CK2bDDEZ5a+LJNDVMtKFtQ1D9rP6rJqU064eoru=a9eHpaAQ@mail.gmail.com>
	<aVP6wBYoHJQsplIl@kernel.org>
	<CA+CK2bDZPwYpUhksDLSbfVdVm5TYbh0XrOKRV=q4YjGpqH+Fwg@mail.gmail.com>
	<aVQJUPOn85WlJaM9@kernel.org>
	<CA+CK2bCm=AGDSLTbs6etbqveFUHU80okE-bCT2zg20nrHXgHRQ@mail.gmail.com>
	<aVTw_08W7zXR7Y0F@kernel.org>
Date: Fri, 02 Jan 2026 15:24:18 +0100
Message-ID: <86wm206qjx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On Wed, Dec 31 2025, Mike Rapoport wrote:

> On Tue, Dec 30, 2025 at 01:21:31PM -0500, Pasha Tatashin wrote:
>> On Tue, Dec 30, 2025 at 12:18=E2=80=AFPM Mike Rapoport <rppt@kernel.org>=
 wrote:
>> >
>> > On Tue, Dec 30, 2025 at 11:18:12AM -0500, Pasha Tatashin wrote:
>> > > On Tue, Dec 30, 2025 at 11:16=E2=80=AFAM Mike Rapoport <rppt@kernel.=
org> wrote:
>> > > >
>> > > > On Tue, Dec 30, 2025 at 11:05:05AM -0500, Pasha Tatashin wrote:
>> > > > > On Mon, Dec 29, 2025 at 4:03=E2=80=AFPM Pratyush Yadav <pratyush=
@kernel.org> wrote:
>> > > > > >
>> > > > > > The magic is purely sanity checking. It is not used to decide =
anything
>> > > > > > other than to make sure this is actually a KHO page. I don't i=
ntend to
>> > > > > > change that. My point is, if we make sure the KHO pages are pr=
operly
>> > > > > > initialized during MM init, then restoring can actually be a v=
ery cheap
>> > > > > > operation, where you only do the sanity checking. You can even=
 put the
>> > > > > > magic check behind CONFIG_KEXEC_HANDOVER_DEBUG if you want, bu=
t I think
>> > > > > > it is useful enough to keep in production systems too.
>> > > > >
>> > > > > It is part of a critical hotpath during blackout, should really =
be
>> > > > > behind CONFIG_KEXEC_HANDOVER_DEBUG
>> > > >
>> > > > Do you have the numbers? ;-)
>> > >
>> > > The fastest reboot we can achieve is ~0.4s on ARM
>> >
>> > I meant the difference between assigning info.magic and skipping it.
>>=20
>> It is proportional to the amount of preserved memory. Extra assignment
>> for each page. In our fleet we have observed IOMMU page tables to be
>> 20G in size. So, let's just assume it is 20G. That is: 20 * 1024^3 /

The magic check is done for each preservation, not for each page. So if
the 20G of preserved memory is 1G huge pages, then you only need 20 to
check the magic 20 times.

>
> Do you see 400ms reboot times on machines that have 20G of IOMMU page
> tables? That's impressive presuming the overall size of those machines.=20
>
>> 4096 =3D 5.24 million pages. If we access "struct page" only for the
>> magic purpose, we fetch full 64-byte cacheline, which is 5.24 million
>> * 64 bytes =3D 335 M, that is ~13ms with ~25G/s DRAM; and also each TLB
>> miss will add some latency, 5.2M * 10ns =3D ~50ms. In total we can get
>> 15ms ~ 50ms regression compared to 400ms, that is 4-12%. It will be
>> less if we also access "struct page" for another reason at the same
>> time, but still it adds up.
>
> Your overhead calculations are based on the assumption that we don't
> access struct page, but we do. We assign page->private during
> deserialization and then initialize struct page during restore.
> We get the hit of cache fetches and TLB misses anyway.

Exactly. The cache line will be fetched anyway. So I think the real
overhead is a fetch and compare.

>
> It would be interesting to see the difference *measured* on those large
> systems.
>
[...]

--=20
Regards,
Pratyush Yadav

