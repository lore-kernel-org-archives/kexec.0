Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9ACC001DB
	for <kexec@archiver.kernel.org>; Tue,  8 Aug 2023 12:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s8W5uXSiVMC7kxJU8eqSQEZkKmeJGFu4Y+xQj2RayPU=; b=0oANJ2ShKCWnDz
	QzBT7bD2WD+IDFm94WL1lIJs+yY64D6z62SA4xxwfTlmKhtGHyBiFR0PGDnnEubCWlRYKe1MlqxN/
	oi9ttmLqTAAdtgPcE/NaKhnIGmW0FC+gN1U6BgPCbLhXhM3HjM5uOJjtuL/KzIkn4nGBzeDpcd8wF
	axbJ0gCARetLwGTWdMpzZ5OGrFjd4cibZb1nX9hE4+/0d+RRkIh4D1rzPffphLMuKXCUgP+SFImWW
	JyBjw+aygF05/XWyA0yZ+Bm3uQxfmIKEXXlv2Vt9Js6IlKJenGDCsNVjl5AKL97coui0tM01N1iHN
	NvUXtj7WXDbtyvA/6xpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTLwB-002ZOV-0s;
	Tue, 08 Aug 2023 12:35:47 +0000
Received: from bedivere.hansenpartnership.com ([2607:fcd0:100:8a00::2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTLw7-002ZN7-0B
	for kexec@lists.infradead.org;
	Tue, 08 Aug 2023 12:35:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1691498138;
	bh=KZKKRT5Ma1nq9ta9abKg3orsaJzYsdcSBENnz8xI6lo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=pa4OIxVYyMGokTSV6PutSvmvVqZomEWX3xoVHocoLIBZau8s8H2+4PEFqh3aDwHvU
	 kt7FKynZTmm8Soljhwwj0FIB56PqbUiNEaC9hClJ5QRIqxct9gjer4uTHu0l9sWDFJ
	 r+tNpJWjT83wdMDo44bm/sLFpgDUe2WPiwaxJvqs=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 83FB612868AE;
	Tue,  8 Aug 2023 08:35:38 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id W9axPlGpAZeL; Tue,  8 Aug 2023 08:35:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1691498138;
	bh=KZKKRT5Ma1nq9ta9abKg3orsaJzYsdcSBENnz8xI6lo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=pa4OIxVYyMGokTSV6PutSvmvVqZomEWX3xoVHocoLIBZau8s8H2+4PEFqh3aDwHvU
	 kt7FKynZTmm8Soljhwwj0FIB56PqbUiNEaC9hClJ5QRIqxct9gjer4uTHu0l9sWDFJ
	 r+tNpJWjT83wdMDo44bm/sLFpgDUe2WPiwaxJvqs=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D57FF12868AD;
	Tue,  8 Aug 2023 08:35:36 -0400 (EDT)
Message-ID: <8ad131f35c33cf10788344be6c981473971f9c1c.camel@HansenPartnership.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Stefan Berger <stefanb@linux.ibm.com>, Sush Shringarputale
 <sushring@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
 zohar@linux.ibm.com, peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, 
 kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, 
 kexec@lists.infradead.org, jmorris@namei.org, Paul Moore
 <paul@paul-moore.com>,  serge@hallyn.com
Cc: code@tyhicks.com, nramas@linux.microsoft.com, Tushar Sugandhi
	 <tusharsu@linux.microsoft.com>, linux-security-module@vger.kernel.org
Date: Tue, 08 Aug 2023 08:35:35 -0400
In-Reply-To: <5d21276a-daac-fc9b-add9-62e7c04bbdcd@linux.ibm.com>
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
	 <b748230c8ee291288afcf48898507556c3aa7c71.camel@HansenPartnership.com>
	 <5d21276a-daac-fc9b-add9-62e7c04bbdcd@linux.ibm.com>
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_053543_139222_06088C33 
X-CRM114-Status: GOOD (  24.19  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gTW9uLCAyMDIzLTA4LTA3IGF0IDE4OjQ5IC0wNDAwLCBTdGVmYW4gQmVyZ2VyIHdyb3RlOgo+
IAo+IAo+IE9uIDgvMS8yMyAxNzoyMSwgSmFtZXMgQm90dG9tbGV5IHdyb3RlOgo+ID4gT24gVHVl
LCAyMDIzLTA4LTAxIGF0IDEyOjEyIC0wNzAwLCBTdXNoIFNocmluZ2FycHV0YWxlIHdyb3RlOgo+
ID4gWy4uLl0KPiA+ID4gVHJ1bmNhdGluZyBJTUEgbG9nIHRvIHJlY2xhaW0gbWVtb3J5IGlzIG5v
dCBmZWFzaWJsZSwgc2luY2UgaXQKPiA+ID4gbWFrZXMgdGhlIGxvZyBnbyBvdXQgb2Ygc3luYyB3
aXRoIHRoZSBUUE0gUENSIHF1b3RlIG1ha2luZyByZW1vdGUKPiA+ID4gYXR0ZXN0YXRpb24gZmFp
bC4KPiA+IAo+ID4gVGhpcyBhc3N1bXB0aW9uIGlzbid0IGVudGlyZWx5IHRydWUuwqAgSXQncyBw
ZXJmZWN0bHkgcG9zc2libGUgdG8KPiA+IHNoYXJkIGFuIElNQSBsb2cgdXNpbmcgdHdvIFRQTTJf
UXVvdGUncyBmb3IgdGhlIGJlZ2lubmluZyBhbmQgZW5kCj4gPiBQQ1IgdmFsdWVzIHRvIHZhbGlk
YXRlIHRoZSBzaGFyZC7CoCBUaGUgSU1BIGxvZyBjb3VsZCBiZSB0cnVuY2F0ZWQKPiA+IGluIHRo
ZSBzYW1lIHdheSAocmVwbGFjZSB0aGUgcmVtb3ZlZCBwYXJ0IG9mIHRoZSBsb2cgd2l0aCBhCj4g
PiBUUE0yX1F1b3RlIGFuZCBBSywgc28gdGhlIGxvZyBzdGlsbCB2YWxpZGF0ZXMgZnJvbSB0aGUg
YmVnaW5uaW5nCj4gPiBxdW90ZSB0byB0aGUgZW5kKS4KPiA+IAo+ID4gSWYgeW91IHVzZSBhIFRQ
TTJfUXVvdGUgbWVjaGFuaXNtIHRvIHNhdmUgdGhlIGxvZywgYWxsIHlvdSBuZWVkIHRvCj4gPiBk
byBpcyBoYXZlIHRoZSBrZXJuZWwgZ2VuZXJhdGUgdGhlIHF1b3RlIHdpdGggYW4gaW50ZXJuYWwg
QUsuwqAgWW91Cj4gPiBjYW4ga2VlcCBhIHJlY29yZCBvZiB0aGUgcXVvdGUgYW5kIHRoZSBBSyBh
dCB0aGUgYmVnaW5uaW5nIG9mIHRoZQo+ID4gdHJ1bmNhdGVkIGtlcm5lbCBsb2cuwqAgSWYgdGhl
IHRydW5jYXRlZCBlbnRyaWVzIGFyZSBzYXZlZCBpbiBhIGZpbGUKPiA+IHNoYXJkIGl0Cj4gCj4g
VGhlIHRydW5jYXRpb24gc2VlbXMgZGFuZ2Vyb3VzIHRvIG1lLiBNYXliZSBub3QgYWxsIHRoZSBz
Y2VuYXJpb3MKPiB3aXRoIGFuIGF0dGVzdGF0aW9uIGNsaWVudCAoY2xpZW50ID0gcmVhZGluZyBs
b2dzIGFuZCBxdW90aW5nKSBhcmUKPiBwb3NzaWJsZSB0aGVuIGFueW1vcmUsIHN1Y2ggYXMgc3Rh
cnRpbmcgYW4gYXR0ZXN0YXRpb24gY2xpZW50IG9ubHkKPiBhZnRlciB0cnVuY2F0aW9uIGJ1dCBh
IHZlcmlmaWVyIG11c3QgaGF2ZSB3aXRuZXNzZWQgdGhlIHN5c3RlbSdzIFBDUnMKPiBhbmQgbG9n
IHN0YXRlIGJlZm9yZSB0aGUgdHJ1bmNhdGlvbiBvY2N1cnJlZC4KClRoYXQncyBub3QgZXhhY3Rs
eSBjb3JyZWN0LiAgTm90aGluZyBuZWVkcyB0byBoYXZlICJ3aXRuZXNzZWQiIHRoZQpzdGFydGlu
ZyBQQ1IgdmFsdWUgYmVjYXVzZSB0aGUgcXVvdGUgdm91Y2hlcyBmb3IgaXQgKGFuZCBjYW4gdm91
Y2ggZm9yCml0IGFmdGVyIHRoZSBmYWN0KS4gIFRoZSBvbmx5IHRoaW5nIHlvdSBuZWVkIHRvIHZl
cmlmeSB0aGUgcXVvdGUgaXMgdGhlCmF0dGVzdGF0aW9uIGtleSBhbmQgdGhlIG9ubHkgdGhpbmcg
eW91IG5lZWQgdG8gZG8gdG8gdHJ1c3QgdGhlCmF0dGVzdGF0aW9uIGtleSBpcyBlbnN1cmUgaXQg
d2FzIFRQTSBjcmVhdGVkLiAgQWxsIG9mIHRoYXQgY2FuIGJlCnZlcmlmaWVkIGFmdGVyIHRoZSBm
YWN0IGFzIHdlbGwuICBUaGUgb25seSB0aGluZyB0aGF0IGNhbiBiZSBkb25lIHRvCmRpc3J1cHQg
dGhpcyBpcyB0byBkZXN0cm95IHRoZSBUUE0gKG9yIHJlLW93biBpdCkuCgpSZW1lbWJlciB0aGUg
YXNzdW1wdGlvbiBpcyB5b3UgKmFsc28qIGhhdmUgdGhlIHJlbW92ZWQgbG9nIHNoYXJkIHRvCnBy
ZXNlbnQuICBGcm9tIHRoYXQgdGhlIFBDUiBzdGF0ZSBvZiB0aGUgc3RhcnRpbmcgcXVvdGUgY2Fu
IGJlCmNhbGN1bGF0ZWQgYW5kIGNoZWNrZWQgZm9yIG1hdGNoaW5nIHRoZSBxdW90ZS4gIElmIHlv
dSBsb3NlIHRoYXQsIGl0J3MKZXF1aXZhbGVudCB0byB0aGUgbG9nIGJlaW5nIHRhbXBlcmVkIHdp
dGggYW5kIGFsbCBiZXRzIGFyZSBvZmYuICBUaGUKYXNzdW1wdGlvbiBpcyB0aGF0IGJlY2F1c2Ug
b2YgdGhlIGltcG9zc2liaWxpdHkgb2YgZW5naW5lZXJpbmcgVFBNCmV4dGVuc2lvbnMsIGl0IHNo
b3VsZCBiZSBpbXBvc3NpYmxlIHRvIGNvbWUgdXAgd2l0aCBhIGZha2UgbG9nIHRoYXQKcHJvZHVj
ZXMgdGhlIFBDUnMgb2YgdGhlIHJlYWwgb25lLiAgSWYgdGhhdCdzIHZpb2xhdGVkLCB0aGVuIElN
QSBpdHNlbGYKYmVjb21lcyB1c2VsZXNzLgoKSmFtZXMKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2tleGVjCg==
