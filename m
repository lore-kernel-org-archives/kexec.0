Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mtagate3.uk.ibm.com ([195.212.29.136])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KYFrD-0007AM-4x
	for kexec@lists.infradead.org; Wed, 27 Aug 2008 07:54:23 +0000
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate3.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m7R7sLni321682
	for <kexec@lists.infradead.org>; Wed, 27 Aug 2008 07:54:21 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m7R7sL2Y4169850
	for <kexec@lists.infradead.org>; Wed, 27 Aug 2008 08:54:21 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m7R7sKqi011232
	for <kexec@lists.infradead.org>; Wed, 27 Aug 2008 08:54:21 +0100
Received: from mercedes-benz.boeblingen.de.ibm.com
	(dyn-9-152-210-87.boeblingen.de.ibm.com [9.152.210.87])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.12.11) with ESMTP
	id m7R7sKgV011226
	for <kexec@lists.infradead.org>; Wed, 27 Aug 2008 08:54:20 +0100
Date: Wed, 27 Aug 2008 09:54:24 +0200
From: Maxim Shchetynin <maxim@linux.vnet.ibm.com>
Subject: [PATCH] Let kexec work on IBM QS2x blade servers
Message-ID: <20080827095424.2de4829e@mercedes-benz.boeblingen.de.ibm.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

SGVsbG8sCgpwbGVhc2UgaGF2ZSBhIGxvb2sgYXQgdGhlIGZvbGxvd2luZyBwYXRjaC4gVGhpcyBw
YXRjaCBhbGxvd3Mga2V4ZWMgdG8gd29yayBvbiBJQk0gUVMyeCBibGFkZXMuIFdvdWxkIGl0IGJl
IHBvc3NpYmxlIHRvIGFwcGx5IHRoaXMgcGF0Y2ggdG8gYSBuZXh0IGtleGVjIHZlcnNpb24/CgpG
cm9tOiBNYXhpbSBTaGNoZXR5bmluIDxtYXhpbUBkZS5pYm0uY29tPgpTaWduZWQtb2ZmLWJ5OiBN
YXhpbSBTaGNoZXR5bmluIDxtYXhpbUBkZS5pYm0uY29tPgotLS0KCmRpZmYgLU51YXIga2V4ZWMt
dG9vbHMtdGVzdGluZy0yMDA3MDMzMC9rZXhlYy9hcmNoL3BwYzY0L2tleGVjLWVsZi1yZWwtcHBj
NjQuYyBrZXhlYy10b29scy10ZXN0aW5nLTIwMDcwMzMwLWZpeGVkL2tleGVjL2FyY2gvcHBjNjQv
a2V4ZWMtZWxmLXJlbC1wcGM2NC5jCi0tLSBrZXhlYy10b29scy10ZXN0aW5nLTIwMDcwMzMwL2tl
eGVjL2FyY2gvcHBjNjQva2V4ZWMtZWxmLXJlbC1wcGM2NC5jCTIwMDctMDMtMzAgMDY6MzQ6MzYu
MDAwMDAwMDAwICswMjAwCisrKyBrZXhlYy10b29scy10ZXN0aW5nLTIwMDcwMzMwLWZpeGVkL2tl
eGVjL2FyY2gvcHBjNjQva2V4ZWMtZWxmLXJlbC1wcGM2NC5jCTIwMDgtMDYtMTkgMTc6MzU6MjMu
MDAwMDAwMDAwICswMjAwCkBAIC01Niw2ICs1Niw3IEBACiAJCWJyZWFrOwogCiAJY2FzZSBSX1BQ
QzY0X0FERFI2NDoKKwljYXNlIFJfUFBDNjRfUkVMNjQ6CiAJCS8qIFNpbXBseSBzZXQgaXQgKi8K
IAkJKih1aW50NjRfdCAqKWxvY2F0aW9uID0gdmFsdWU7CiAJCWJyZWFrOwoKLS0gCk1pdCBmcmV1
bmRsaWNoZW4gR3LDvMOfZW4gLyBtZXQgdnJpZW5kZWxpamtlIGdyb2V0ZW4gLyBhdmVjIHJlZ2Fy
ZHMKCiAgICBNYXhpbSBWLiBTaGNoZXR5bmluCiAgICBMaW51eCBLZXJuZWwgRW50d2lja2x1bmcK
ICAgIElCTSBEZXV0c2NobGFuZCBSZXNlYXJjaCAmIERldmVsb3BtZW50IEdtYkgKICAgIExpbnV4
IGbDvHIgQ2VsbCwgQWJ0ZWlsdW5nIDMyNTAKICAgIFNjaMO2bmFpY2hlciBTdHJhw59lIDIyMAog
ICAgNzEwMzIgQsO2YmxpbmdlbgoKVm9yc2l0emVuZGVyIGRlcyBBdWZzaWNodHNyYXRzOiBNYXJ0
aW4gSmV0dGVyCkdlc2Now6RmdHNmw7xocnVuZzogSGVyYmVydCBLaXJjaGVyClNpdHogZGVyIEdl
c2VsbHNjaGFmdDogQsO2YmxpbmdlbgpSZWdpc3RyaWVyZ2VyaWNodDogQW10c2dlcmljaHQgU3R1
dHRnYXJ0LCBIUkIgMjQzMjk0CgpGYWhyIG51ciBzbyBzY2huZWxsIHdpZSBkZWluIFNjaHV0emVu
Z2VsIGZsaWVnZW4ga2FubiEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
