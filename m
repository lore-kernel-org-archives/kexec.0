Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDA8FA3741
	for <kexec@archiver.kernel.org>; Fri,  2 Jan 2026 14:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dHhKBLUj/xPGvd98uQUXe/daqMsBh++bApJj90w3Yok=; b=HjmtwUPRFn0Fo7jhM8eLlzbM74
	EBqKuU1UWYVZygZXdKxU9uOztcG1KqzqFSt2wimYfRa9dswDcofwlR7vrfBQSTZIQTRFJ2yi4vk0f
	9ZFxqBuZLBE1A5EB5gDjBz+190jcdp7IMuctz6UwJlt9KBkuv5WDKtkYbBducWiiHxMWBjTwG83OK
	zoD+s5m9ofjESxD/Gm/r8QpsjZfvBcmxAo6R3O279FsI9CcNRgP6MKX4mtPKD3p5azTOgjWO9u9N0
	IL80YHET6cmrL8YxBh7VZwgykn11alzl2E3kqE22HpcjiKBCwnXcKgYxGueCXmpFUrr/4VJZxPHWB
	YLrWG+YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbfmW-00000008Kjd-3nOe;
	Fri, 02 Jan 2026 14:05:32 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbfmU-00000008Kj3-38tJ
	for kexec@lists.infradead.org;
	Fri, 02 Jan 2026 14:05:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 999AC40624;
	Fri,  2 Jan 2026 14:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A71C116B1;
	Fri,  2 Jan 2026 14:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767362729;
	bh=dHhKBLUj/xPGvd98uQUXe/daqMsBh++bApJj90w3Yok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bEXwHj4cDOGyrvCsRQsGDv6yK+YiVcL6Hso7BUrsbYoRlIE0/vU3oyAYugWyBB03N
	 oLvB4x/cV2WbXpQ4eQ2+75+qFzaPNHOYpSE7Al6RyZFb/pH6fcgBWhZLuoTixEY+hG
	 4vRM1b0DI0my9AcFkYxCHeB3j9IQg2/kzWUkIOUEpkbj19gqZ8W1oeqr2cbKmVdZIj
	 0avpZ7L87kiJWhEaM0grbGMtsGS6G4xhroO237+78uDg+r3zrCjBegDBITsR6qYRHy
	 Lzyti33d7vz4No+P31u2mk14wPviBN2gkACyXRwsf1yZ0eCAF1j1oIuIH7H1V45Pu5
	 v0o+rvB5BhZeg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Evangelos Petrongonas <epetron@amazon.de>,  Alexander Graf
 <graf@amazon.com>,  Andrew Morton <akpm@linux-foundation.org>,  Jason Miu
 <jasonmiu@google.com>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  nh-open-source@amazon.com
Subject: Re: [PATCH] kho: add support for deferred struct page init
In-Reply-To: <CA+CK2bDDEZ5a+LJNDVMtKFtQ1D9rP6rJqU064eoru=a9eHpaAQ@mail.gmail.com>
	(Pasha Tatashin's message of "Tue, 30 Dec 2025 11:05:05 -0500")
References: <20251216084913.86342-1-epetron@amazon.de>
	<aUFJH9xzJXYOt_X8@kernel.org>
	<CA+CK2bDGvgcGJijAtSSa2k_FWjnZXm2jRiFd6Z9-XjEQ-Y68DQ@mail.gmail.com>
	<aUF4fsWwD9BswkFh@kernel.org>
	<CA+CK2bB2mn5b0N9gs1UavYLUQhbpVvdo702oHZa15E9OaZkKWg@mail.gmail.com>
	<aUUYprAotKYMiEs0@kernel.org>
	<CA+CK2bD101cSC_7+OWkMei2QvUVjSaRLy+LboLe8Sz7KS3by4g@mail.gmail.com>
	<861pkpkffh.fsf@kernel.org>
	<CA+CK2bA1kYCf0BwhX3Sg9Ur82nK-7HPzs0sg6xbVWFAJaZLhpw@mail.gmail.com>
	<86jyyecyzh.fsf@kernel.org>
	<CA+CK2bDxnTEe9Ohq5zLuyF-jqgD0DPhfdq6z=yztUsXU5p5fSQ@mail.gmail.com>
	<863452cwns.fsf@kernel.org>
	<CA+CK2bCjJWZG_rPoPsHWSxirmUCTOuFQzTCss2AKf9UqpThrdw@mail.gmail.com>
	<864ip99f1a.fsf@kernel.org>
	<CA+CK2bDDEZ5a+LJNDVMtKFtQ1D9rP6rJqU064eoru=a9eHpaAQ@mail.gmail.com>
Date: Fri, 02 Jan 2026 15:05:23 +0100
Message-ID: <861pk885zw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260102_060530_822619_4EB5B61A 
X-CRM114-Status: GOOD (  24.67  )
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

On Tue, Dec 30 2025, Pasha Tatashin wrote:

> On Mon, Dec 29, 2025 at 4:03=E2=80=AFPM Pratyush Yadav <pratyush@kernel.o=
rg> wrote:
>>
>> On Tue, Dec 23 2025, Pasha Tatashin wrote:
[...]
>> >
>> > I kind of do not like relying on magic to decide whether to initialize
>> > the struct page. I would prefer to avoid this magic marker altogether:
>> > i.e. struct page is either initialized or not, not halfway
>> > initialized, etc.
>>
>> The magic is purely sanity checking. It is not used to decide anything
>> other than to make sure this is actually a KHO page. I don't intend to
>> change that. My point is, if we make sure the KHO pages are properly
>> initialized during MM init, then restoring can actually be a very cheap
>> operation, where you only do the sanity checking. You can even put the
>> magic check behind CONFIG_KEXEC_HANDOVER_DEBUG if you want, but I think
>> it is useful enough to keep in production systems too.
>
> It is part of a critical hotpath during blackout, should really be
> behind CONFIG_KEXEC_HANDOVER_DEBUG
>
>> > Magic is not reliable. During machine reset in many firmware
>> > implementations, and in every kexec reboot, memory is not zeroed. The
>> > kernel usually allocates vmemmap using exactly the same pages, so
>> > there is just too high a chance of getting magic values accidentally
>> > inherited from the previous boot.
>>
>> I don't think that can happen. All the pages are zeroed when
>> initialized, which will clear the magic. We should only be setting the
>> magic on an initialized struct page.
>
> This can happen due to bugs when we use a partially initialized
> "struct page", something that Mike have been looking to do. So, pass
> some information in a struct page before it is fully initialized.

The magic is checked at restore time though, and by then all non-KHO
pages should be properly initialized and have their magic cleared.

Also, the magic is cleared by kho_restore_folio(), so this can only ever
happen for pages that were preserved but not restored in the previous
boot. I don't think that is a common use case in the first place.

[...]

--=20
Regards,
Pratyush Yadav

