Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4379CDB479
	for <kexec@archiver.kernel.org>; Wed, 24 Jun 2026 15:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3pkskQ2++eDyNw2xnVvM9ZHICcQFK/ShGMe6urYxz4Y=; b=tERa3GqfmmLQmJuOqYc0DGsrlZ
	55CneNbB0TYLZBjVmTnQaVKnsEOJfIB9+esc0xSq/2kQz+4kQK0AkMjQUXR8Yrbb6OYbBQIrQmGgw
	4kxI/NeE5iBcIajq3xGDTm1OqlmPxsoNqbru/M+beKNzUArS1SCmzM37XgKyal2PGUOevxxybGcKZ
	ptIG2hz8uTYBD8gv0INXWQ9+KZu9J7kYgDnLAqXTIojYNzFUE4xsRR2ulKYTqy85HmFLzzqWbEkNJ
	8Tk6rSXDV2XCbBuu+UyvrxzxrmEf2vEdHBKnLgNntsNY/3A4c09cmjojUo9wB0ncWctvC2cTy8EIV
	5loDRSUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcPLg-00000007yuo-0guS;
	Wed, 24 Jun 2026 15:17:08 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcPLf-00000007yua-2ktB
	for kexec@lists.infradead.org;
	Wed, 24 Jun 2026 15:17:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D189460018;
	Wed, 24 Jun 2026 15:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EF61F000E9;
	Wed, 24 Jun 2026 15:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782314226;
	bh=3pkskQ2++eDyNw2xnVvM9ZHICcQFK/ShGMe6urYxz4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=AR11iw+ko1EXT45M5uLTzAPEvSIeSa2yGRu91808JZKaUqpY4V/hmPR/siLDNhkWM
	 3ANzx8JIV652LAnnPJOdBJFp/okW2Ym4CyaG/H5AqxNFpS/k3yp4SEmMNK3D2PZByY
	 xnPAVKULx20atCcrnF5n4OSOuwDCpZD90KSZgwd/2BzN0p1KF87CHHyHc2D6fn8InM
	 19VbNQagtJ7FdIKq86FaXexq/l6msAVFf9R5++IN/U5bCcX/xf8Z/tbvqUmfZd60U9
	 w9NaIGmLCzVoSriIHaWhPlF2nTWjePGJeQdjDhJxGy+KhT6e8tz/jWZpVEiTGG5ZSx
	 FET55wtSnO7cQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Breno Leitao <leitao@debian.org>,
  nao.horiguchi@gmail.com,  linmiaohe@huawei.com,  david@kernel.org,
  lance.yang@linux.dev,  akpm@linux-foundation.org,  baoquan.he@linux.dev,
  rppt@kernel.org,  kexec@lists.infradead.org,  linux-mm@kvack.org,
  rneu@meta.com,  caggio@meta.com,  kas@kernel.org
Subject: Re: mm/hwpoison: persist poisoned PFN list across kexec via KHO [RFC]
In-Reply-To: <da460b26bef42152bf23d395f845503ad8eedc4d.camel@surriel.com> (Rik
	van Riel's message of "Wed, 24 Jun 2026 10:44:20 -0400")
References: <ajut_LDQGYCShApx@gmail.com> <2vxzse6ckqfg.fsf@kernel.org>
	<da460b26bef42152bf23d395f845503ad8eedc4d.camel@surriel.com>
Date: Wed, 24 Jun 2026 17:17:02 +0200
Message-ID: <2vxzjyroklxt.fsf@kernel.org>
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

On Wed, Jun 24 2026, Rik van Riel wrote:

> On Wed, 2026-06-24 at 15:40 +0200, Pratyush Yadav wrote:
>>=20
>> Also, what happens on cold reboot? If the HW does not remember bad
>> pages, won't the kernel be in the same position? How does it know the
>> bad pages on a cold boot?
>
> Some modern server hardware will simply unmap known
> bad pages from the physical page map, so they will
> not be exposed to the OS after a cold reboot.
>
> The hardware keeps a log of uncorrectable memory
> errors somewhere in memory, for example in the SEL.
>
>>=20
>>=20
>> >=20
>> > This PoC
>> > =3D=3D=3D=3D=3D=3D=3D=3D
>> >=20
>> > =C2=A0 * Makes hardware-poisoned pages survive a kexec, using KHO (Kex=
ec
>> > =C2=A0=C2=A0=C2=A0 HandOver) to carry the poison list between kernels.
>> >=20
>> > =C2=A0 * Producer: hooks num_poisoned_pages_inc()/_sub() - the single
>> > =C2=A0=C2=A0=C2=A0 chokepoint for every poison/unpoison event - and re=
cords each
>> > =C2=A0=C2=A0=C2=A0 poisoned PFN into a vmalloc array that KHO preserve=
s across the
>> > =C2=A0=C2=A0=C2=A0 kexec, described by a small versioned "hwpoison" su=
btree.
>>=20
>> More of an implementation detail, but with vmalloc array, what if you
>> have too many poisoned pages?
>> >=20
>
> If a very large amount of memory is broken, you
> should probably just repair the hardware.

"large" is relative. On a 2 TiB system, if you have 0.5% of pages
poisoned (I have no idea if that number is realistic), you have 10 GiB
of memory poisoned, or around 2.6 million pages. To store all their
PFNs, you need around 20 MiB of memory.

While not too large, it isn't trivial either.

I think static data structures like vmalloc are likely not the way to go
here especially when we have better things like KHO block or the KHO
radix tree.

Between those two, what is more efficient largely depends on how many
pages you'd typically see poisoned and what their locations tend to be.
That I think we can dive deeper into when we take a closer look at the
patches.

>
> Page poisoning is good for localized memory
> failures, but not for failures that extend across
> much of a memory chip.


--=20
Regards,
Pratyush Yadav

