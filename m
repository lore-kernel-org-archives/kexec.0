Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B481CDB481
	for <kexec@archiver.kernel.org>; Wed, 24 Jun 2026 14:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wVHL6dNX3n7r+4CMxQlhF34InM0ZtmF2WvKJot0jDCY=; b=rNeh6KGDddfgjI6Hs9vTZYw881
	uVMmpsD9MG7gptEJoRwNQZnDYCbmg4N8qPbK/RVP1nqGeufgRnqr1n7b6j2llb2sC29XYc9qRnd9W
	BcboTgPFqycKgh829cqt7KPvBw7s2mKJXYAdRJySrRY1mgfp64vu4l9vZVBYdlZaRdon0FLu0mJUo
	WDBhJy+Blj1DGWA0dJ15ufLEHdkkJpcOBlAhp0kDd1h07VpSvPQjO2b1N0XU4vSyrnWsbH/5JGuou
	dpEi+ZozHKP9IILYSEiXTU0mPvRaMHV0kJy9QDI/uBqSJJ2REcFzauwZhqPRi+24acPd3UMuWHZC7
	kwp307TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcOqo-00000007w7r-27YF;
	Wed, 24 Jun 2026 14:45:14 +0000
Received: from shelob.surriel.com ([96.67.55.147])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcOql-00000007w7L-42mU
	for kexec@lists.infradead.org;
	Wed, 24 Jun 2026 14:45:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wVHL6dNX3n7r+4CMxQlhF34InM0ZtmF2WvKJot0jDCY=; b=SfAnQDLjyks4iVnfjPMSmwBwcE
	pI6O0c3Mm9qB2rzbC/gbho6xWZUqwzDU2x1INjpfNAT9SFAcZFuZ/zcv5lO0zd0i6AM5VVML3tird
	jr+ZzFY1nRGYKurHINka7k2ah+jijis6cIePNgJ+kT+k7T67C76SRJg7zUXFCJLIkOIGcM/8wY3nK
	BxE3JMWV9McHNXFwwGCAAVq1ripEwsaoDSZrdB4tVCI8XssJ3M/YcMtbW1V2UFlOHrbMtiJDPAvDn
	JY1BK5K56JFe4nhCAAQpRyEipz71TaJL547OD5Odj4GJI6F7xYLU4dLQMqoDrK4fPjeb6pOx0xEb/
	0seyqxtw==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wcOpw-000000005xR-1YWm;
	Wed, 24 Jun 2026 10:44:20 -0400
Message-ID: <da460b26bef42152bf23d395f845503ad8eedc4d.camel@surriel.com>
Subject: Re: mm/hwpoison: persist poisoned PFN list across kexec via KHO
 [RFC]
From: Rik van Riel <riel@surriel.com>
To: Pratyush Yadav <pratyush@kernel.org>, Breno Leitao <leitao@debian.org>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, david@kernel.org, 
	lance.yang@linux.dev, akpm@linux-foundation.org, baoquan.he@linux.dev, 
	rppt@kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 rneu@meta.com, 	caggio@meta.com, kas@kernel.org
Date: Wed, 24 Jun 2026 10:44:20 -0400
In-Reply-To: <2vxzse6ckqfg.fsf@kernel.org>
References: <ajut_LDQGYCShApx@gmail.com> <2vxzse6ckqfg.fsf@kernel.org>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260624_074512_011105_F413DD24 
X-CRM114-Status: GOOD (  12.67  )
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

On Wed, 2026-06-24 at 15:40 +0200, Pratyush Yadav wrote:
>=20
> Also, what happens on cold reboot? If the HW does not remember bad
> pages, won't the kernel be in the same position? How does it know the
> bad pages on a cold boot?

Some modern server hardware will simply unmap known
bad pages from the physical page map, so they will
not be exposed to the OS after a cold reboot.

The hardware keeps a log of uncorrectable memory
errors somewhere in memory, for example in the SEL.

>=20
>=20
> >=20
> > This PoC
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > =C2=A0 * Makes hardware-poisoned pages survive a kexec, using KHO (Kexe=
c
> > =C2=A0=C2=A0=C2=A0 HandOver) to carry the poison list between kernels.
> >=20
> > =C2=A0 * Producer: hooks num_poisoned_pages_inc()/_sub() - the single
> > =C2=A0=C2=A0=C2=A0 chokepoint for every poison/unpoison event - and rec=
ords each
> > =C2=A0=C2=A0=C2=A0 poisoned PFN into a vmalloc array that KHO preserves=
 across the
> > =C2=A0=C2=A0=C2=A0 kexec, described by a small versioned "hwpoison" sub=
tree.
>=20
> More of an implementation detail, but with vmalloc array, what if you
> have too many poisoned pages?
> >=20

If a very large amount of memory is broken, you
should probably just repair the hardware.

Page poisoning is good for localized memory
failures, but not for failures that extend across
much of a memory chip.

>=20
>=20
>=20
--=20
All Rights Reversed.

