Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB7C606A31C
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=B82MdTcI;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.a=rsa-sha256 header.s=dkim-rsa header.b=hxtAkDAy;
	dkim=pass header.d=archlinux.org header.i=@archlinux.org header.a=ed25519-sha256 header.s=dkim-ed25519 header.b=n5KQDXra
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	From:References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=AKTw389ma82rDbmbC9M6kOMKYg5EIULOIyYInz7B3OY=; b=B82MdTcITdF5gqn43yWOjLfiTy
	U7s6lRtrTEWj08JrAv7cBp3MQCUqr2rUYru2oRs/wLoOAlkOxozXUL66N2A5thBkJZVdeiMUp27ij
	F6JXb7E40IrccZAySeUHZ3jeqm3KcVcKCHypVHvrDXS5OgGz5SoG/ozwLC5cQyuPrNAld1cGNYKM9
	0lEfB9fTpwtJ+wzdZpyJdaHsjREf19jZqOzJTwXv8sJsVKlVv+GJF2YDBtnQE9doHc9qr2DJ7iSVm
	bAWmdfVx9Y2EWsDeuGQ1f2GInx9v1g3GtuvD5ldjsNDXfODUqsnc2uszXpiColoXZau2w5H/3HS6p
	HD+jvHlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRRBI-00000009O9J-1eR6;
	Thu, 12 Nov 2026 09:33:20 +0000
Received: from mail.archlinux.org ([2a01:4f9:c010:3052::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRRBA-00000009O7I-3L2r
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 09:33:18 +0000
Message-ID: <ccc5a1a5-00b1-471e-9d23-571ae001cce6@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1794475983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AKTw389ma82rDbmbC9M6kOMKYg5EIULOIyYInz7B3OY=;
	b=hxtAkDAyYLbJIADGEigo8eMSRZyyDW9Gb8oWI7PUA0XKvKqvnS+vj93xwUIx+52Nw8/p8o
	U3QPfvIZTW+0BDaglc6c5a9U59S4VLT0z3ejqNS5ti6rcDeIIEc3QWNaf3y9/V5EOEiV/x
	5R52Gwx6IkRxhMy22VJYvpZWg1Tb2+6/GmqqV9qdOeuHDYjxnQYlMJDKz0eI9o7Jv9weoK
	ICF1aliuwqSnkl1QOB1B+fbqoE7ZQyGF8Co6dzEKQjU07ZUQfPr3+cWwWOxWaUcIA92FNk
	PDeoOhbreWklAm4A9lMYmsFIgsNMo4s8zcnJ8XSjRTYrUnDHY08wib4/OG+NMcGuKPjRjA
	5nG7OcU+MT1FM0qqMXVjV6THBt/7LP9rZw+1qZ226jPmxwUeudRTkWFn2k7PIM+biduGuu
	GgkIagOgaM+UilXgBLu4DpxB+6o/ArMBL4XN6+8Hgd+VvNu7YAdn7FuKmxwFDpqerRjegr
	2K4lMH/0jWqiD95QmJXi7vQMvyT5r9OieSCjWGuyjd/QwOUR52WS5Ve+UnCrT8NHMYOqR0
	IjRJ4R0nzkz0hjOxtSAq6aTBtM4YBe1beoqJY87wFGxUWWKbZHVOzhSIaiiN/e9e2PuuqJ
	kfto+CHV9cDn5GfGkZTTKlLWtmOgKLxgEg2xWkQba1ejNa8Cd5U+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1794475983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AKTw389ma82rDbmbC9M6kOMKYg5EIULOIyYInz7B3OY=;
	b=n5KQDXraDvDJCIgwRbJw+fEWQx1Lt+Czb47kWRNGnbrmAUu5dQC8VEQT5tn4LCmKgMMqDr
	6SjeyXqVHtHSjNAA==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=artafinde smtp.mailfrom=artafinde@archlinux.org
Date: Thu, 12 Nov 2026 09:33:01 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Subject: Re: [ANNOUNCE] makedumpfile 1.8.0
To: kexec@lists.infradead.org
References: <10bfd9ef-c589-45e8-9d1c-12b3b0acf118@nec.com>
 <350c0929-584b-4d04-afeb-61f89ca241c9@archlinux.org>
 <13b88b4d-e382-4851-a0b8-3f9e3f713c92@nec.com>
Content-Language: en-GB, en-GB-large
From: Leonidas Spyropoulos <artafinde@archlinux.org>
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
In-Reply-To: <13b88b4d-e382-4851-a0b8-3f9e3f713c92@nec.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------OtVppxAV6uz3O7p2qTJkyVpF"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_013313_478077_CCAE22FB 
X-CRM114-Status: GOOD (  11.57  )
X-Spam-Score: -4.4 (----)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------OtVppxAV6uz3O7p2qTJkyVpF
Content-Type: multipart/mixed; boundary="------------ivEfJWdQIHZOr3LlgI9DSThr";
 protected-headers="v1"; hp="clear"
Message-ID: <ccc5a1a5-00b1-471e-9d23-571ae001cce6@archlinux.org>
Date: Thu, 12 Nov 2026 09:33:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] makedumpfile 1.8.0
To: kexec@lists.infradead.org
References: <10bfd9ef-c589-45e8-9d1c-12b3b0acf118@nec.com>
 <350c0929-584b-4d04-afeb-61f89ca241c9@archlinux.org>
 <13b88b4d-e382-4851-a0b8-3f9e3f713c92@nec.com>
Content-Language: en-GB, en-GB-large
From: Leonidas Spyropoulos <artafinde@archlinux.org>
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
In-Reply-To: <13b88b4d-e382-4851-a0b8-3f9e3f713c92@nec.com>

--------------ivEfJWdQIHZOr3LlgI9DSThr
Content-Type: multipart/mixed; boundary="------------ljHFzaGMslzoF36PdLF6yBQs"

--------------ljHFzaGMslzoF36PdLF6yBQs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEvMTEvMjAyNiAxMDo0NiwgWUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp
IHdyb3RlOg0KPiANCj4gSSBjcmVhdGVkIHB1YmtleTYgZm9sbG93aW5nIHlvdXIgbWV0aG9k
LiBUaGVyZSBhcmUgbm8gcHJvYmxlbXMgY29tcGFyZWQgdG8NCj4gYmVmb3JlIHB1YmtleTUu
IEkgaGF2ZSBzaWduZWQgdGhlcmUgbmV3IGtleShtLXlhbWF6YWtpMikgd2l0aCB0aGUgb2xk
DQo+IGtleSAoeWFtYXpha2ktbXNtdCkuIEFkZGl0aW9uYWxseSwgSSBoYXZlIHVwZGF0ZWQg
dGhlIGBSRUFETUVgIGZpbGUuDQpIZWxsbyBNYXNhLA0KDQpUaGFuayB5b3UsIGFuZCBzb3Jy
eSBhYm91dCB0aGUgZ3BnIHRyb3VibGUuIEkgaGF2ZSB2ZXJpZmllZCBldmVyeXRoaW5nIA0K
YW5kIHRoZSBjaGFpbiBvZiB0cnVzdCBpcyByZXN0b3JlZCENCg0KT25lIHNtYWxsIGZvbGxv
dy11cCwgbm90IHVyZ2VudDogcmlnaHQgbm93IHRoZSBjZXJ0aWZpZWQga2V5IGNhbiBvbmx5
DQpiZSBmb3VuZCBpbiB0aGUgcHVia2V5NiB0YWcuIEl0IGlzIG5vdCBvbiBhbnkga2V5c2Vy
dmVyLCBhbmQgdGhlIGNvcHkNCm9uIHlvdXIgR2l0SHViIHByb2ZpbGUgKGdpdGh1Yi5jb20v
eWFtYXpha2ktbXNtdC5ncGcpIGRvZXMgbm90IGluY2x1ZGUNCnRoZSBzaWduYXR1cmUgZnJv
bSB0aGUgb2xkIGtleS4NCkNvdWxkIHlvdSBwbGVhc2UgdXBsb2FkIHRoZSBjZXJ0aWZpY2F0
ZSBrZXkgb24gc29tZSBrZXlzZXJ2ZXIgbGlrZSBiZWxvdyANCihjaG9vc2Ugb25lIG9mIHRo
ZW0pOg0KDQogIGdwZyAtLWFybW9yIC0tZXhwb3J0IDNFNjkwRUFFQURCNDJEQzMwOTY2NTIz
Qjk3MDMxNEQ5QTlGQ0MyRUMgPiBuZXcuYXNjDQoNCiAgLSBrZXlzZXJ2ZXIudWJ1bnR1LmNv
bSAodGhpcyBvbmUga2VlcHMgdGhlIHNpZ25hdHVyZSBmcm9tIHRoZSBvbGQga2V5KQ0KICAg
IGdwZyAtLWtleXNlcnZlciBoa3BzOi8va2V5c2VydmVyLnVidW50dS5jb20gXA0KICAgICAg
LS1zZW5kLWtleXMgM0U2OTBFQUVBREI0MkRDMzA5NjY1MjNCOTcwMzE0RDlBOUZDQzJFQw0K
ICAtIGtleXMub3BlbnBncC5vcmc6IHVwbG9hZCBuZXcuYXNjIGF0IGh0dHBzOi8va2V5cy5v
cGVucGdwLm9yZy91cGxvYWQNCiAgICBhbmQgY29uZmlybSB0aGUgdmVyaWZpY2F0aW9uIGVt
YWlsIGl0IHNlbmRzDQoNCkFsc28gcmUtdXBsb2FkaW5nIG5ldy5hc2Mgb24gR2l0SHViIHdv
dWxkIGFsc28gYWRkIHRoZSBjZXJ0aWZpY2F0aW9uIHRoZXJlLg0KDQpUaGFua3MgYWdhaW4g
Zm9yIHRha2luZyBjYXJlIG9mIHRoaXMuDQoNCkNoZWVycywNCg0KLS0gDQpMZW9uaWRhcyBT
cHlyb3BvdWxvcw0KRGV2ZWxvcGVyICYgRGV2T3BzDQpQR1A6IDU5RTQzRTEwNkIyNDczNjgN
CiAgICAgIDI0NDc0MEQxN0M3RkQwRUMNCg==
--------------ljHFzaGMslzoF36PdLF6yBQs
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

--------------ljHFzaGMslzoF36PdLF6yBQs--

--------------ivEfJWdQIHZOr3LlgI9DSThr--

--------------OtVppxAV6uz3O7p2qTJkyVpF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQhkbiUMbrAqLlt6T0kR0DRfH/Q7AUCavWHzQAKCRAkR0DRfH/Q
7LFlAP485HowiD33eFfgnrn4lcoCkoYruHWqs1+KCva0vdn9SAEAqBA7VgIJEuju
qJTt03aCXlnmc7U1f7tCaVfla4jWHAU=
=J5++
-----END PGP SIGNATURE-----

--------------OtVppxAV6uz3O7p2qTJkyVpF--

