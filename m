Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C91AC369CB
	for <kexec@archiver.kernel.org>; Wed, 23 Apr 2025 19:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	References:To:Subject:From:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QaJ3Tqgxx0FqadK6L2lrukZ1P22lF75y4otoTyRXPqw=; b=2BHX3v/A2bYb1K/9SRw53j1+/j
	DtoGb34tabZObYkYAz5WwwAmMhGKEhO1GeI6d9Vv//n1Z51/hp5P4GEAZJABORkzNHnu+YLPxkFRv
	owoJQpGg8yROXaOPcwk08wYIP1pgmYGDaWfesNPbURUkDOPPMkmWunFmYykFRu8Y+GdKddTu/9cDE
	ekhri8Q6BS2MFMnsewpMGZctpAg2Ag4gw/mhfDMMSM349TzCJue6KkARWwvUSg7x926mmpt7jEhqz
	sV/1vrXpih0Qxvvs3mbpEzbTi2NdcP3E+i3WjshtIF0jkhRytPkuFUR+ruzeLVShHQBRfxyjmd3pv
	8F/d2hag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7fLC-0000000BgRx-3LbQ;
	Wed, 23 Apr 2025 19:01:02 +0000
Received: from mail.archlinux.org ([2a01:4f9:c010:3052::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7fKq-0000000BgMu-49FS
	for kexec@lists.infradead.org;
	Wed, 23 Apr 2025 19:00:43 +0000
Message-ID: <3609c281-fe6d-4a85-af69-0b2ec958250a@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1745434835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QaJ3Tqgxx0FqadK6L2lrukZ1P22lF75y4otoTyRXPqw=;
	b=YKVlNzNj2oEShicf97dGqYJpMLeGSU7yhYpB8gOH91O8bU8nqnss8awZ8zoMIXpKLADZdy
	l4iICgXbyvGNmqYxZaEyhMnQKmg14RigqgoQrUMhMS5ru7OuSLfwW3i1YCBQKovh1ZLPXt
	HzPH/6eUBw2x9V+xLpy0q3eF4XtZkrVC98FTICdJ1sMaNamBDvxU0EjQN6Gc0TLp5qe6fj
	kkyYdCF6dtr658GR9kVabrqGBeAs4PGrbhJ8pNs+IDjqkTXRPqnCsHrAnS8MT5U+xVON5X
	cjJUNK5pfT9lkylQu2mKWg9s88Yb6uGFNoQv/USGHdbyd6E2/t/2u/xzh3Ompw7MZw1us9
	gVP6nG9UK4fkSKX0XI3A34ywnsoGw3pSwD5VSEdy2aaztg8coUPFzV3Lyk6zS08U7oNaVc
	UIhUOUGpmAUVcsi2LipnEfmk7Ut/WWUhTSdwtHkMHM/VUi6bOBjOV4s0ZKPDog2zKNuN9k
	xAuX+vCy1eEvE6tbPMlU76B8PxpISUiiP3UkpF/pOBlmhO4NyUwCLYitLeOzI9Se6RBVoK
	mXvdSa/Hz0gBJpDmbUlWUHcZ8xwtKR4/eEoFwi/gGa3AKEp39km7MwEUOVFs9uVKNYYsW2
	cUK1iTeIWm7ZtRuP2T8tWhLA9+ue79aE/dAjtVbiHRu0Dg9ls8t24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1745434835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QaJ3Tqgxx0FqadK6L2lrukZ1P22lF75y4otoTyRXPqw=;
	b=ov5QIltEEu8+77LasdtuOVex8/CsezdfxMPal+uPC7fgVTeleXB4rhzw2+03NVyeuWkMls
	fZHrYh8RUVtIOQCQ==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=artafinde smtp.mailfrom=artafinde@archlinux.org
Date: Wed, 23 Apr 2025 22:00:23 +0300
MIME-Version: 1.0
From: Leonidas Spyropoulos <artafinde@archlinux.org>
Subject: Re: [ANNOUNCE] makedumpfile 1.7.7
To: kexec@lists.infradead.org
References: <0e3945ff-e224-49b2-b122-0c0290d00b74@nec.com>
Content-Language: en-GB
Autocrypt: addr=artafinde@archlinux.org; keydata=
 xjMEZVZY3RYJKwYBBAHaRw8BAQdAsjxXb8lH9q6ra3NbhAUqYbtGL1kpJH8MBzeSjeUeGa7N
 SExlb25pZGFzIFNweXJvcG91bG9zIChBcmNoIExpbnV4IFBhY2thZ2VyIGtleSkgPGFydGFm
 aW5kZUBhcmNobGludXgub3JnPsKTBBMWCgA7FiEEIZG4lDG6wKi5bek9JEdA0Xx/0OwFAmVW
 WN0CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQJEdA0Xx/0OyI9AEAvplbjjov
 k7SykUFPobbXgtAx2i5hnjWfWsOFlQ/FinkBAOeS1H4dpidiJ5UBEXVkvEEjs3EzQKJT7hS0
 GVKUDokIzjgEZVZY3RIKKwYBBAGXVQEFAQEHQBAdgSzOFatqQqSkAlQz+zRWvMLqNP7z1rOP
 VXzMH6UcAwEIB8J4BBgWCgAgFiEEIZG4lDG6wKi5bek9JEdA0Xx/0OwFAmVWWN0CGwwACgkQ
 JEdA0Xx/0OyWIAEA4RigzVezX7E5zxl7qXOxkpIgMu/cF35rFBsEvsgNFh0A+wQhZBzZySV3
 JaiWCNq+smE/rvpHvUzlpnmN1kMvECIG
In-Reply-To: <0e3945ff-e224-49b2-b122-0c0290d00b74@nec.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------y9xBhiH2PvfrLNHyU9PFLhFy"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_120041_653492_1F39D07E 
X-CRM114-Status: GOOD (  11.24  )
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------y9xBhiH2PvfrLNHyU9PFLhFy
Content-Type: multipart/mixed; boundary="------------3EML03W4OQNCRLkKubSumwzc";
 protected-headers="v1"
From: Leonidas Spyropoulos <artafinde@archlinux.org>
To: kexec@lists.infradead.org
Message-ID: <3609c281-fe6d-4a85-af69-0b2ec958250a@archlinux.org>
Subject: Re: [ANNOUNCE] makedumpfile 1.7.7
References: <0e3945ff-e224-49b2-b122-0c0290d00b74@nec.com>
In-Reply-To: <0e3945ff-e224-49b2-b122-0c0290d00b74@nec.com>

--------------3EML03W4OQNCRLkKubSumwzc
Content-Type: multipart/mixed; boundary="------------CgEtrwLpxl5vyWYwy0FFtLph"

--------------CgEtrwLpxl5vyWYwy0FFtLph
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 22/04/2025 10:58, YAMAZAKI MASAMITSU(=E5=B1=B1=E5=B4=8E =E7=9C=9F=E5=85=
=89) wrote:
> Hi,
>=20
> We're pleased to announce the release of makedumpfile 1.7.7.
> Thank you everyone for your help to maintain the tool.
>=20
> Download:
> The latest makedumpfile can be downloaded from the following page.
>  =C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/makedumpfile/makedumpfile/=
releases
>=20
Hello,

I'm a package maintainer for Arch Linux of the makedumpfile. Previous
releases were signed both the commit and the tag with the GPG key of
Kazuhito Hagio. The 1.7.7 release is not signed (neither commit nor the
tag) and from a different person (YAMAZAKI MASAMITSU). From a chain of
trust that's not great.

Ideally we'd like these to be GPG signed and have some kind of chain of
trust from previous release to current.

To resolve the current situation I suggest, if possible, to add on the
root of the project a text file with approved GPG keys who are releasing
this project made with a signed commit from Kazuhito Hagio. This will
establish a chain of trust between Hagio's GPG key and Masa's key. Or
more complicated sign Masa's key with Hagio's. In both cases a new
signed tag 1.7.8 will be required as of now 1.7.7 is not OK (in terms of
chain of trust) and re-tagging is also bad for downstream systems and
for security-wise.

You can find more information for Arch's motivation on this and other
distro's in our recent RFC [0]

[0]: https://gitlab.archlinux.org/archlinux/rfcs/-/merge_requests/46

Cheers,

--=20
Leonidas Spyropoulos
Developer & DevOps
PGP: 59E43E106B247368

--------------CgEtrwLpxl5vyWYwy0FFtLph
Content-Type: application/pgp-keys; name="OpenPGP_0x244740D17C7FD0EC.asc"
Content-Disposition: attachment; filename="OpenPGP_0x244740D17C7FD0EC.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZVZY3RYJKwYBBAHaRw8BAQdAsjxXb8lH9q6ra3NbhAUqYbtGL1kpJH8MBzeS
jeUeGa7NSExlb25pZGFzIFNweXJvcG91bG9zIChBcmNoIExpbnV4IFBhY2thZ2Vy
IGtleSkgPGFydGFmaW5kZUBhcmNobGludXgub3JnPsKTBBMWCgA7FiEEIZG4lDG6
wKi5bek9JEdA0Xx/0OwFAmVWWN0CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
F4AACgkQJEdA0Xx/0OyI9AEAvplbjjovk7SykUFPobbXgtAx2i5hnjWfWsOFlQ/F
inkBAOeS1H4dpidiJ5UBEXVkvEEjs3EzQKJT7hS0GVKUDokIzSpMZW9uaWRhcyBT
cHlyb3BvdWxvcyA8YXJ0YWZpbmRlQGdtYWlsLmNvbT7CkwQTFgoAOxYhBCGRuJQx
usCouW3pPSRHQNF8f9DsBQJlVpNTAhsDBQsJCAcCAiICBhUKCQgLAgQWAgMBAh4H
AheAAAoJECRHQNF8f9DsPpABAPFZGF96CHer7Cd+ar2aNiCfXqm0a3xbwQ3zRSxO
wk81AP9f4zCI1NzItcnJ5VJExI2MnuoViUbOO2tlFFtgLjarBs44BGVWWN0SCisG
AQQBl1UBBQEBB0AQHYEszhWrakKkpAJUM/s0VrzC6jT+89azj1V8zB+lHAMBCAfC
eAQYFgoAIBYhBCGRuJQxusCouW3pPSRHQNF8f9DsBQJlVljdAhsMAAoJECRHQNF8
f9DsliABAOEYoM1Xs1+xOc8Ze6lzsZKSIDLv3Bd+axQbBL7IDRYdAPsEIWQc2ckl
dyWolgjavrJhP676R71M5aZ5jdZDLxAiBg=3D=3D
=3D8VXZ
-----END PGP PUBLIC KEY BLOCK-----

--------------CgEtrwLpxl5vyWYwy0FFtLph--

--------------3EML03W4OQNCRLkKubSumwzc--

--------------y9xBhiH2PvfrLNHyU9PFLhFy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQhkbiUMbrAqLlt6T0kR0DRfH/Q7AUCaAk4xwUDAAAAAAAKCRAkR0DRfH/Q7N7d
AP9Z/65ogJJvqVroB4yDcHqyNhkJ8DuDOY72o4EMIeddygEA41GVF8jdavliQphg8xDhh4xTsvvJ
hnbKnya2HC+eOwY=
=rRU7
-----END PGP SIGNATURE-----

--------------y9xBhiH2PvfrLNHyU9PFLhFy--

