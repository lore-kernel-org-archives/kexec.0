Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88851CD4F4C
	for <kexec@archiver.kernel.org>; Sun,  8 Sep 2024 10:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KOVSuqoXEfRdiOqeAPjATnBeJbKmK94LVjQEY7eNSdY=; b=BIL0/WLf7Rpv09
	R88L+S+DmhXixhPC6YD++wZ98QnCQFODMnCwpT/+vbxuVAi2fkQFgBEen9m54Zw3A9Q0TkhpqniCc
	1/+hYLjEmK+SATOlx5YFVrAdY1VuAGw40/pXYXphP/tlQKBqjdkQrGHXy8fcTn3AVWhsap/9SIv8a
	n6xBm9aiHdrKiQJ35PcqC+fOjZwXxQUzHNlXS9nX+mVPYO38eQbR3Rkq4PHz2kGH36TKjPF/K+DTu
	tR0ber0P72sFanJtM3sA9IpQXXBbPV+t/EcYnlH9irtp6VHG8L+zLiHkzFR8f01mF14uNphGij1t5
	Z0bEnPEjlhgtVEe1pM9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snFC1-0000000Gazk-3GBm;
	Sun, 08 Sep 2024 10:30:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snFBy-0000000Gayz-2bv5
	for kexec@lists.infradead.org;
	Sun, 08 Sep 2024 10:30:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725791448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5OMd23lOq0TQ1xex/NXYk3jY8jVWK0MlC2mTgfKJm8=;
	b=Q6cN6j5xe/dca4pANw0S8LnMrOme0Sl8EWEMqCecrMKe66vc0mLcsbFGCAeKnAAoPWpagF
	6E/LbQeL1DjiZtn70+ZpZxE8A/HOb9YxqdsTevpcwACrgHUY0cDUVyGsnP5sK6ZVlgncSG
	FkBCJCQ7svaF0wP56R2g2QniLNsV9y4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-3_IErx1HNZWPkhjP_PcxIQ-1; Sun,
 08 Sep 2024 06:30:43 -0400
X-MC-Unique: 3_IErx1HNZWPkhjP_PcxIQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76F5F19560B5;
	Sun,  8 Sep 2024 10:30:41 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91F211956056;
	Sun,  8 Sep 2024 10:30:39 +0000 (UTC)
Date: Sun, 8 Sep 2024 18:30:33 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
Message-ID: <Zt18yUCWRK8178uv@MiWiFi-R3L-srv>
References: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
 <87v80lnf8d.fsf@mail.lhotse>
 <10c666ae-d528-4f49-82e9-8e0fee7099e0@linux.ibm.com>
 <355b58b1-6c51-4c42-b6ea-dcd6b1617a18@linux.ibm.com>
 <ZsLjGJvAUIaxrG6x@MiWiFi-R3L-srv>
 <1e4a8e18-cda9-45f5-a842-8ffcd725efc9@linux.ibm.com>
 <ZtGqTSMvx6Ljf5Xi@MiWiFi-R3L-srv>
 <0dd94920-b13f-4da7-9ea6-4f008af1f4b3@linux.ibm.com>
 <ZtkkIoUIu8shp/ut@MiWiFi-R3L-srv>
 <c6f30e31-69fe-4ece-b251-c49f1ab59a04@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c6f30e31-69fe-4ece-b251-c49f1ab59a04@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240908_033050_756667_BCFDF7EF 
X-CRM114-Status: GOOD (  43.37  )
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

T24gMDkvMDUvMjQgYXQgMDI6MDdwbSwgU291cmFiaCBKYWluIHdyb3RlOgo+IEhlbGxvIEJhb3F1
YW4sCj4gCj4gT24gMDUvMDkvMjQgMDg6NTMsIEJhb3F1YW4gSGUgd3JvdGU6Cj4gPiBPbiAwOS8w
NC8yNCBhdCAwMjo1NXBtLCBTb3VyYWJoIEphaW4gd3JvdGU6Cj4gPiA+IEhlbGxvIEJhb3F1YW4s
Cj4gPiA+IAo+ID4gPiBPbiAzMC8wOC8yNCAxNjo0NywgQmFvcXVhbiBIZSB3cm90ZToKPiA+ID4g
PiBPbiAwOC8yMC8yNCBhdCAxMjoxMHBtLCBTb3VyYWJoIEphaW4gd3JvdGU6Cj4gPiA+ID4gPiBI
ZWxsbyBCYW9xdWFuLAo+ID4gPiA+ID4gCj4gPiAuLi4uLi5zbmlwLi4uCj4gPiA+ID4gPiAyLiBB
IHBhdGNoIHRvIHJldHVybiBlYXJseSBmcm9tIHRoZSBgY3Jhc2hfaGFuZGxlX2hvdHBsdWdfZXZl
bnQoKWAgZnVuY3Rpb24KPiA+ID4gPiA+IGlmIGBrZXhlY19pbl9wcm9ncmVzc2AgaXMKPiA+ID4g
PiA+ICAgwqDCoCBzZXQgdG8gVHJ1ZS4gVGhpcyBpcyBlc3NlbnRpYWxseSBteSBvcmlnaW5hbCBw
YXRjaC4KPiA+ID4gPiBUaGVyZSdzIGEgcmFjZSBnYXAgYmV0d2VlbiB0aGUga2V4ZWNfaW5fcHJv
Z3Jlc3MgY2hlY2tpbmcgYW5kIHRoZQo+ID4gPiA+IHNldHRpbmcgaXQgdG8gdHJ1ZSB3aGljaCBN
aWNoYWVsIGhhcyBtZW50aW9uZWQuCj4gPiA+IFRoZSB3aW5kb3cgd2hlcmUga2VybmVsIGlzIGhv
bGRpbmcga2V4ZWNfbG9jayB0byBkbyBrZXhlYyBib290Cj4gPiA+IGJ1dCBrZXhlY19pbl9wcm9n
cmVzcyBpcyB5ZXQgbm90IHNldCB0byBUcnVlLgo+ID4gPiAKPiA+ID4gSWYga2VybmVsIG5lZWRz
IHRvIGhhbmRsZSBjcmFzaCBob3RwbHVnIGV2ZW50LCB0aGUgZnVuY3Rpb24KPiA+ID4gY3Jhc2hf
aGFuZGxlX2hvdHBsdWdfZXZlbnQoKcKgIHdpbGwgbm90IGdldCB0aGUga2V4ZWNfbG9jayBhbmQK
PiA+ID4gZXJyb3Igb3V0IGJ5IHByaW50aW5nIGVycm9yIG1lc3NhZ2UgYWJvdXQgbm90IGFibGUg
dG8gdXBkYXRlCj4gPiA+IGtkdW1wIGltYWdlLgo+ID4gQnV0IHlvdSB3YW50ZWQgdG8gYXZvaWQg
dGhlIGVycm9yaW5nIG91dCBpZiBpdCdzIGJlaW5nIGluCj4gPiBrZXJuZWxfa2V4ZWMoKS4gIE5v
dyB5b3UgYXJlIHNlZWluZyBhdCBsZWFzdCBvbmUgdGhlIG5vaXNpbmcKPiA+IG1lc3NhZ2UsIGFy
ZW4ndCB5b3U/Cj4gCj4gWWVzLCBidXQgaXQgaXMgdmVyeSByYXJlIHRvIGVuY291bnRlci4KPiAK
PiBNeSBjb21tZW50cyBvbiB5b3VyIHVwZGF0ZWQgY29kZSBhcmUgaW5saW5lIGJlbG93Lgo+IAo+
ID4gCj4gPiA+IEkgdGhpbmsgaXQgc2hvdWxkIGJlIGZpbmUuIEdpdmVuIHRoYXQgbG9jayBpcyBh
bHJlYWR5IHRha2VuIGZvcgo+ID4gPiBrZXhlYyBrZXJuZWwgYm9vdC4KPiA+ID4gCj4gPiA+IEFt
IEkgbWlzc2luZyBzb21ldGhpbmcgbWFqb3I/Cj4gPiA+IAo+ID4gPiA+IFRoYXQncyB3aHkgSSB0
aGluawo+ID4gPiA+IG1heWJlIGNoZWNraW5nIGtleGVjX2luX3Byb2dyZXNzIGFmdGVyIGZhaWxp
bmcgdG8gcmV0cml2aW5nCj4gPiA+ID4gX19rZXhlY19sb2NrIGlzIGEgbGl0dGxlIGJldHRlciwg
bm90IHZlcnkgc3VyZS4KPiA+ID4gVHJ5IGZvciBrZXhlYyBsb2NrIGJlZm9yZSBrZXhlY19pbl9w
cm9ncmVzcyBjaGVjayB3aWxsIG5vdCBzb2x2ZQo+ID4gPiB0aGUgb3JpZ2luYWwgcHJvYmxlbSB0
aGlzIHBhdGNoIHRyeWluZyB0byBzb2x2ZS4KPiA+ID4gCj4gPiA+IFlvdSBwcm9wb3NlZCB0aGUg
YmVsb3cgY2hhbmdlcyBlYXJsaWVyOgo+ID4gPiAKPiA+ID4gLQlpZiAoIWtleGVjX3RyeWxvY2so
KSkgewo+ID4gPiArCWlmICgha2V4ZWNfdHJ5bG9jaygpICYmIGtleGVjX2luX3Byb2dyZXNzKSB7
Cj4gPiA+ICAgCQlwcl9pbmZvKCJrZXhlY190cnlsb2NrKCkgZmFpbGVkLCBlbGZjb3JlaGRyIG1h
eSBiZSBpbmFjY3VyYXRlXG4iKTsKPiA+ID4gICAJCWNyYXNoX2hvdHBsdWdfdW5sb2NrKCk7Cj4g
PiBBaCwgSSBtZWFudCBhcyBiZWxvdywgYnV0IHdyb3RlIGl0IG1pc3Rha2VubHkuCj4gPiAKPiA+
IGRpZmYgLS1naXQgYS9rZXJuZWwvY3Jhc2hfY29yZS5jIGIva2VybmVsL2NyYXNoX2NvcmUuYwo+
ID4gaW5kZXggNjNjZjg5MzkzYzZlLi5lN2M3YWE3NjFmNDYgMTAwNjQ0Cj4gPiAtLS0gYS9rZXJu
ZWwvY3Jhc2hfY29yZS5jCj4gPiArKysgYi9rZXJuZWwvY3Jhc2hfY29yZS5jCj4gPiBAQCAtNTA0
LDcgKzUwNCw3IEBAIGludCBjcmFzaF9jaGVja19ob3RwbHVnX3N1cHBvcnQodm9pZCkKPiA+ICAg
CWNyYXNoX2hvdHBsdWdfbG9jaygpOwo+ID4gICAJLyogT2J0YWluIGxvY2sgd2hpbGUgcmVhZGlu
ZyBjcmFzaCBpbmZvcm1hdGlvbiAqLwo+ID4gLQlpZiAoIWtleGVjX3RyeWxvY2soKSkgewo+ID4g
KwlpZiAoIWtleGVjX3RyeWxvY2soKSAmJiAha2V4ZWNfaW5fcHJvZ3Jlc3MpIHsKPiA+ICAgCQlw
cl9pbmZvKCJrZXhlY190cnlsb2NrKCkgZmFpbGVkLCBlbGZjb3JlaGRyIG1heSBiZSBpbmFjY3Vy
YXRlXG4iKTsKPiA+ICAgCQljcmFzaF9ob3RwbHVnX3VubG9jaygpOwo+ID4gICAJCXJldHVybiAw
Owo+ID4gCj4gPiAKPiA+ID4gCj4gPiA+IE9uY2UgdGhlIGtleGVjX2luX3Byb2dyZXNzIGlzIHNl
dCB0byBUcnVlIHRoZXJlIGlzIG5vIHdheSBvbmUgY2FuIGdldAo+ID4gPiBrZXhlY19sb2NrLiBT
byBrZXhlY190cnlsb2NrKCkgYmVmb3JlIGtleGVjX2luX3Byb2dyZXNzIGlzIG5vdCBoZWxwZnVs
Cj4gPiA+IGZvciB0aGUgcHJvYmxlbSBJIGFtIHRyeWluZyB0byBzb2x2ZS4KPiA+IFdpdGggeW91
ciBwYXRjaCwgeW91IGNvdWxkIHN0aWxsIGdldCB0aGUgZXJyb3IgbWVzc2FnZSBpZiB0aGUgcmFj
ZSBnYXAKPiA+IGV4aXN0LiBXaXRoIGFib3ZlIGNoYW5nZSwgeW91IHdvbid0IGdldCBpdC4gUGxl
YXNlIGNvcnJlY3QgbWUgaWYgSSBhbQo+ID4gd3JvbmcuCj4gCj4gVGhlIGFib3ZlIGNvZGUgd2ls
bCBwcmludCBhbiBlcnJvciBtZXNzYWdlIGR1cmluZyB0aGUgcmFjZSBnYXAuIEhlcmUncyB3aHk6
Cj4gCj4gTGV04oCZcyBzYXkgdGhlIGtleGVjIGxvY2sgaXMgYWNxdWlyZWQgaW4gdGhlIGtlcm5l
bF9rZXhlYygpIGZ1bmN0aW9uLAo+IGJ1dCBrZXhlY19pbl9wcm9ncmVzcyBpcyBub3QgeWV0IHNl
dCB0byBUcnVlLiBJbiB0aGlzIHNjZW5hcmlvLCB0aGUgY29kZQo+IHdpbGwgcHJpbnQKPiBhbiBl
cnJvciBtZXNzYWdlLgo+IAo+IFRoZXJlIGlzIGFub3RoZXIgaXNzdWUgSSBzZWUgd2l0aCB0aGUg
YWJvdmUgY29kZToKPiAKPiBDb25zaWRlciB0aGF0IHRoZSBzeXN0ZW0gaXMgb24gdGhlIGtleGVj
IGtlcm5lbCBib290IHBhdGgsIGFuZAo+IGtleGVjX2luX3Byb2dyZXNzCj4gaXMgc2V0IHRvIFRy
dWUuIElmIGNyYXNoX2hvdHBsdWdfdW5sb2NrKCkgaXMgY2FsbGVkLCB0aGUga2VybmVsIHdpbGwg
bm90Cj4gb25seSB1cGRhdGUKPiB0aGUga2R1bXAgaW1hZ2Ugd2l0aG91dCBhY3F1aXJpbmcgdGhl
IGtleGVjIGxvY2ssIGJ1dCBpdCB3aWxsIGFsc28gcmVsZWFzZQo+IHRoZQo+IGtleGVjIGxvY2sg
aW4gdGhlIG91dCBsYWJlbC4gSSBiZWxpZXZlIHRoaXMgaXMgaW5jb3JyZWN0Lgo+IAo+IFBsZWFz
ZSBzaGFyZSB5b3VyIHRob3VnaHRzLgoKSG93IGFib3V0IHRoaXM/CgpkaWZmIC0tZ2l0IGEva2Vy
bmVsL2NyYXNoX2NvcmUuYyBiL2tlcm5lbC9jcmFzaF9jb3JlLmMKaW5kZXggNjNjZjg5MzkzYzZl
Li44YmE3YjFkYTBkZWQgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9jcmFzaF9jb3JlLmMKKysrIGIva2Vy
bmVsL2NyYXNoX2NvcmUuYwpAQCAtNTA1LDcgKzUwNSw4IEBAIGludCBjcmFzaF9jaGVja19ob3Rw
bHVnX3N1cHBvcnQodm9pZCkKIAljcmFzaF9ob3RwbHVnX2xvY2soKTsKIAkvKiBPYnRhaW4gbG9j
ayB3aGlsZSByZWFkaW5nIGNyYXNoIGluZm9ybWF0aW9uICovCiAJaWYgKCFrZXhlY190cnlsb2Nr
KCkpIHsKLQkJcHJfaW5mbygia2V4ZWNfdHJ5bG9jaygpIGZhaWxlZCwgZWxmY29yZWhkciBtYXkg
YmUgaW5hY2N1cmF0ZVxuIik7CisJCWlmICgha2V4ZWNfaW5fcHJvZ3Jlc3MpCisJCQlwcl9pbmZv
KCJrZXhlY190cnlsb2NrKCkgZmFpbGVkLCBlbGZjb3JlaGRyIG1heSBiZSBpbmFjY3VyYXRlXG4i
KTsKIAkJY3Jhc2hfaG90cGx1Z191bmxvY2soKTsKIAkJcmV0dXJuIDA7CiAJfQpAQCAtNTQwLDcg
KzU0MSw4IEBAIHN0YXRpYyB2b2lkIGNyYXNoX2hhbmRsZV9ob3RwbHVnX2V2ZW50KHVuc2lnbmVk
IGludCBocF9hY3Rpb24sIHVuc2lnbmVkIGludCBjcHUsCiAJY3Jhc2hfaG90cGx1Z19sb2NrKCk7
CiAJLyogT2J0YWluIGxvY2sgd2hpbGUgY2hhbmdpbmcgY3Jhc2ggaW5mb3JtYXRpb24gKi8KIAlp
ZiAoIWtleGVjX3RyeWxvY2soKSkgewotCQlwcl9pbmZvKCJrZXhlY190cnlsb2NrKCkgZmFpbGVk
LCBlbGZjb3JlaGRyIG1heSBiZSBpbmFjY3VyYXRlXG4iKTsKKwkJaWYgKCFrZXhlY19pbl9wcm9n
cmVzcykKKwkJCXByX2luZm8oImtleGVjX3RyeWxvY2soKSBmYWlsZWQsIGVsZmNvcmVoZHIgbWF5
IGJlIGluYWNjdXJhdGVcbiIpOwogCQljcmFzaF9ob3RwbHVnX3VubG9jaygpOwogCQlyZXR1cm47
CiAJfQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtl
eGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
