Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.bonedaddy.net ([70.91.141.202])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WdDMr-0000wM-LE
 for kexec@lists.infradead.org; Thu, 24 Apr 2014 06:42:46 +0000
Message-ID: <1398321736.7980.71.camel@chianamo>
Subject: Re: [kexec-tools] [PATCH] Do not distribute generated files in the
 release tarball
From: Paul Wise <pabs3@bonedaddy.net>
Date: Thu, 24 Apr 2014 14:42:16 +0800
In-Reply-To: <20140424054209.GI8892@verge.net.au>
References: <1398313256-20388-1-git-send-email-pabs3@bonedaddy.net>
 <20140424043255.GC9469@verge.net.au> <1398314768.7980.66.camel@chianamo>
 <20140424054209.GI8892@verge.net.au>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2208638349539034584=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org


--===============2208638349539034584==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Fee6oKkzeHhzScxBWDMQ"


--=-Fee6oKkzeHhzScxBWDMQ
Content-Type: multipart/mixed; boundary="=-32l4b2ZOOVspHPjN17qR"


--=-32l4b2ZOOVspHPjN17qR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2014-04-24 at 14:42 +0900, Simon Horman wrote:

> Thanks, an interesting initiative.

One of the parts of that:

http://lintian.debian.org/tags/source-is-missing.html

> Could you add something like that to the changelog and add
> a signed-off-by line?

Attached a new patch, hope thats OK.

--=20
bye,
pabs

http://bonedaddy.net/pabs3/

--=-32l4b2ZOOVspHPjN17qR
Content-Disposition: attachment;
	filename*0=0001-Do-not-distribute-generated-files-in-the-release-tar.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-Do-not-distribute-generated-files-in-the-release-tar.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSBjMzQzN2IxMDAwOGRiYTQ5MTg0M2FhNDZhYTU0Yjg2MGI1ZTY5Nzg1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogUGF1bCBXaXNlIDxwYWJzM0Bib25lZGFkZHkubmV0Pg0KRGF0
ZTogVGh1LCAyNCBBcHIgMjAxNCAxMjoyMDo1NiArMDgwMA0KU3ViamVjdDogW1BBVENIXSBEbyBu
b3QgZGlzdHJpYnV0ZSBnZW5lcmF0ZWQgZmlsZXMgaW4gdGhlIHJlbGVhc2UgdGFyYmFsbA0KDQpH
ZW5lcmF0ZWQgZmlsZXMgc2hvdWxkIGFsd2F5cyBiZSBidWlsdCBmcm9tIHNvdXJjZSBhbmQgbmV2
ZXIgYmUgcHJlc2VudCBpbg0KVkNTIHJlcG9zaXRvcmllcyBhbmQgb25seSBhdXRvdG9vbHMgZ2Vu
ZXJhdGVkIGZpbGVzIHNob3VsZCBiZSBpbiB0YXJiYWxscy4NClRoaXMgZW5zdXJlcyB0aGF0IHRo
ZXkgZ2V0IGJ1aWx0IGFzIG9mdGVuIGFzIHBvc3NpYmxlIGFuZCBidWdzIHdpdGggdGhhdA0KcHJv
Y2VzcyBhcmUgZGlzY292ZXJlZCBlYXJseS4NCg0KU2lnbmVkLW9mZi1ieTogUGF1bCBXaXNlIDxw
YWJzM0Bib25lZGFkZHkubmV0Pg0KLS0tDQoga2V4ZWMvTWFrZWZpbGUgfCAyICstDQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9r
ZXhlYy9NYWtlZmlsZSBiL2tleGVjL01ha2VmaWxlDQppbmRleCA3ZDMxNzViLi5hNzU4YjRhIDEw
MDY0NA0KLS0tIGEva2V4ZWMvTWFrZWZpbGUNCisrKyBiL2tleGVjL01ha2VmaWxlDQpAQCAtMjks
NyArMjksNyBAQCBLRVhFQ19TUkNTX2Jhc2UgKz0ga2V4ZWMva2V4ZWMteGVuLmMNCiANCiBLRVhF
Q19HRU5FUkFURURfU1JDUyArPSAkKFBVUkdBVE9SWV9IRVhfQykNCiANCi1kaXN0ICs9IGtleGVj
L01ha2VmaWxlICQoS0VYRUNfR0VORVJBVEVEX1NSQ1MpCQkJXA0KK2Rpc3QgKz0ga2V4ZWMvTWFr
ZWZpbGUJCQkJCQlcDQogCSQoS0VYRUNfU1JDU19iYXNlKSBrZXhlYy9jcmFzaGR1bXAtZWxmLmMJ
CVwNCiAJa2V4ZWMvY3Jhc2hkdW1wLmgga2V4ZWMvZmlybXdhcmVfbWVtbWFwLmgJCVwNCiAJa2V4
ZWMva2V4ZWMtZWxmLWJvb3QuaAkJCQkJXA0KLS0gDQoxLjkuMg0KDQo=


--=-32l4b2ZOOVspHPjN17qR--

--=-Fee6oKkzeHhzScxBWDMQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABCgAGBQJTWLJIAAoJEDEWul6f+mmjS9cP/0uTVqcU665VbZGbn0eNR0RL
VHrwDnJO+9wNjtes3DWzo5490LuZreS2QxsiM0YaiEn5TbUVY2TZVEr5LX8g7HZv
mk/gSvusyxjRM+v9BFf/eQ4CsU7ejMjVik229nrxw9eA2xBzeuNQhInq0ysNsWmm
tntF5I/ZUyP5cEzRnc/pxx6twC8GeZ8z2htOv6uZw1Ql+0TyXb9BU3L2jZS5GaX+
7qLfeU3q6wa/rchmSD/dV1/H1xuJPm7v6NzmAGBhej8Qg/OsqCLhwAIJa7Weyhj6
0qrh4cIC5KxOAMP3kGSG1xv7WHzn1F4p7Ofx6+v8RvPVFhVgypKxq14PAJGcjD7L
i9HtvRZn9792Fo+f/k1HjAlF2shswbxRaYR9p18Y0bhwpErtsF/9g2YJLCGnU5UF
OsBUO23/R9BFVT2TfNAahcWH99u9FBgjApVH1fKof9RhCoWpDu2cOt6PEJHpJ9FI
3wll5q5TNIkX5ThAho7QpXbnz7+ZwnyAL9+24CG9oXWt+Nd0lOldiQBOeGYEnPRK
UgTBvjLxxqEWdaWfyO+wLf3OvpGJGpzfuvxRxV8qnxhPrWOWNxiqTD3lzvN8HFnH
BTPMQFflaTCea4IljqB5UIy6hfluloLJ6aony9GA/KRJ9b3qbEHab7ANQBAxU+Xv
M/x7ZHHlONc+fxsXaczY
=AeqZ
-----END PGP SIGNATURE-----

--=-Fee6oKkzeHhzScxBWDMQ--



--===============2208638349539034584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2208638349539034584==--


