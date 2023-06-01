Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF727C7EE29
	for <kexec@archiver.kernel.org>; Thu,  1 Jun 2023 08:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lGWe6GMY27/uG+U6zQuZnZnhF32OpIAWqHvkplj1iBE=; b=qT5WVlWnEnQXIh
	HCkQ0GCjT0uYMHYz0sSiNkCHdhkk1x1zgf/cylCUrBogqwr9MQpXTZJWqeKaaVvneNatHc2V7Hydr
	JWqVZCwa2c4sk1dPnN1oB5sPENKDrHyMbrfPZU75vfAt2RDnu61s9idg8oVGeRTqN81dLDENjW29b
	iOt3R10Vm1+afvacVosNuRe8icYa7i+Dt6wu18zqUQRbxwRsLUKCinkXRGME06abYk3u2Dqq5jVAi
	zNMj9EwZPuvSR4h/T0j4LEBa3z1KqoknYHjCJpCIwjGXMKTuGZ+PtNKfBdIM6L86Tw/VyoqekU0Dj
	hKMgxxu3QMrd8VZ9lClg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4ddQ-002Xqy-1W;
	Thu, 01 Jun 2023 08:26:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4ddN-002XoC-1P
	for kexec@lists.infradead.org;
	Thu, 01 Jun 2023 08:26:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685607969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzamysyMQrXM2G/k2OexOLkxj2XMsJJyutAVuKEvN7A=;
	b=VQOV73jLbu+QUIl6AnHnCibEYD8KG2mS/Xxo/0hjcpMgeUjO+KeqPK7b+89x85UvQwVRJm
	du30t2BJa1B8JJ873MAmyx3sO4wcMNBBwTnkvj6TBAt4d64oSLy37R9fN9w4+fXXE1jj4r
	w0jck99wWt9kqtXz/r15Y62rr/U1rH8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-xhsgyuTcNGSGaamV7WAA7A-1; Thu, 01 Jun 2023 04:26:09 -0400
X-MC-Unique: xhsgyuTcNGSGaamV7WAA7A-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-96f6944c529so34013366b.2
        for <kexec@lists.infradead.org>; Thu, 01 Jun 2023 01:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685607967; x=1688199967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzamysyMQrXM2G/k2OexOLkxj2XMsJJyutAVuKEvN7A=;
        b=dwTAhH3MEQ/Yy6sZ6Rme1QP5v8UwICMNuBPzitEAj7v68sndo4uFDBjZk0m8N4Eax8
         3gTGzBv9fGojTxYBc5B+IRM7Qfix3VaZwhpeYi/2faPhHQaWwdGiggvpE/Y8dI/AF5TS
         Aq3hfC0MJi7dduiqFxy6J6ZyU/Ajkp7r0DnDFNzwrLxWLQf9Xl95rDbZ4nIz06qeT0Nc
         3ULQdA4X15AxJZHF6lg8jbCj9WKEvJUC0pMrcrSo7GY38KdQsjnvwTo+qX6E+TQFdkiR
         hwovaKc0xDMfwP9yXOj43wfhKzhahi8eviiZHjWnY53pOE+VvaDHvIDTZtcDyCRq0n7R
         zV2g==
X-Gm-Message-State: AC+VfDw+osBm7I3JqRDORTxF/Vt4Q41b+a2tV8Jkxocy2hbY5mGjD6rK
	cH+Lo/q38doa7mHu9SZsg/xyYCow6m6J9NnE03R+mmP9pHLDVYlZtAjy12U1YnOZ/7IPsVG15rA
	oOscQz70aO+P/1Gh+iDzJgJXc9kpb/VTnU+ZbUMeVCb6at24DRYZkgUI=
X-Received: by 2002:a17:907:1ca2:b0:96b:1608:3563 with SMTP id nb34-20020a1709071ca200b0096b16083563mr7253954ejc.58.1685607967667;
        Thu, 01 Jun 2023 01:26:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Z/VwEnPjyGSKqfUflBU9/ovfi6znyKV8z4UMFz8tIFJ3bkPV3n5wUqi3rzVrrhn6dsjIBzc9jOQE560mDKJ8=
X-Received: by 2002:a17:907:1ca2:b0:96b:1608:3563 with SMTP id
 nb34-20020a1709071ca200b0096b16083563mr7253934ejc.58.1685607967405; Thu, 01
 Jun 2023 01:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <ZHhTDXpPqFL+3m5h@MiWiFi-R3L-srv>
In-Reply-To: <ZHhTDXpPqFL+3m5h@MiWiFi-R3L-srv>
From: Tao Liu <ltao@redhat.com>
Date: Thu, 1 Jun 2023 16:25:31 +0800
Message-ID: <CAO7dBbVXD+3tq_iQMKtX+Vw7csPfzPJdOWVduMENyO6i7p0b0w@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To: Baoquan He <bhe@redhat.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, ardb@kernel.org, 
	linux-kernel@vger.kernel.org, dyoung@redhat.com, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_012613_550893_DA79BBBF 
X-CRM114-Status: GOOD (  34.25  )
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

SGkgQmFvcXVhbiwKCk9uIFRodSwgSnVuIDEsIDIwMjMgYXQgNDoxM+KAr1BNIEJhb3F1YW4gSGUg
PGJoZUByZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIDA2LzAxLzIzIGF0IDAzOjIwcG0sIFRhbyBM
aXUgd3JvdGU6Cj4gPiBBIGtleGVjIGtlcm5lbCBib290dXAgaGFuZyBpcyBvYnNlcnZlZCBvbiBJ
bnRlbCBBdG9tIGNwdSBkdWUgdG8gdW5tYXBwZWQKPiA+IEVGSSBjb25maWcgdGFibGUuCj4gPgo+
ID4gQ3VycmVudGx5IEVGSSBzeXN0ZW0gdGFibGUgaXMgaWRlbnRpdHktbWFwcGVkIGZvciB0aGUg
a2V4ZWMga2VybmVsLCBidXQgRUZJCj4gPiBjb25maWcgdGFibGUgaXMgbm90IG1hcHBlZCBleHBs
aWNpdGx5Ogo+ID4KPiA+ICAgICBjb21taXQgNmJiZWIyNzZiNzFmICgieDg2L2tleGVjOiBBZGQg
dGhlIEVGSSBzeXN0ZW0gdGFibGVzIGFuZCBBQ1BJCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHRhYmxlcyB0byB0aGUgaWRlbnQgbWFwIikKPiA+Cj4gPiBMYXRlciBpbiB0aGUgZm9sbG93
aW5nIDIgY29tbWl0cywgRUZJIGNvbmZpZyB0YWJsZSB3aWxsIGJlIGFjY2Vzc2VkIHdoZW4KPiA+
IGVuYWJsaW5nIHNldiBhdCBrZXJuZWwgc3RhcnR1cC4gVGhpcyBtYXkgcmVzdWx0IGluIGEgcGFn
ZSBmYXVsdCBkdWUgdG8gRUZJCj4gPiBjb25maWcgdGFibGUncyB1bm1hcHBlZCBhZGRyZXNzLiBT
aW5jZSB0aGUgcGFnZSBmYXVsdCBvY2N1cnMgYXQgYW4gZWFybHkKPiA+IHN0YWdlLCBpdCBpcyB1
bnJlY292ZXJhYmxlIGFuZCBrZXJuZWwgaGFuZ3MuCj4gPgo+ID4gICAgIGNvbW1pdCBlYzFjNjZh
ZjNhMzAgKCJ4ODYvY29tcHJlc3NlZC82NDogRGV0ZWN0L3NldHVwIFNFVi9TTUUgZmVhdHVyZXMK
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgZWFybGllciBkdXJpbmcgYm9vdCIpCj4gPiAg
ICAgY29tbWl0IGMwMWZjZTljZWY4NCAoIng4Ni9jb21wcmVzc2VkOiBBZGQgU0VWLVNOUCBmZWF0
dXJlCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldGVjdGlvbi9zZXR1cCIpCj4gPgo+
ID4gSW4gYWRkaXRpb24sIHRoZSBpc3N1ZSBkb2Vzbid0IGFwcGVhciBvbiBhbGwgc3lzdGVtcywg
YmVjYXVzZSB0aGUga2V4ZWMKPiA+IGtlcm5lbCB1c2VzIFBhZ2UgU2l6ZSBFeHRlbnNpb24gKFBT
RSkgZm9yIGlkZW50aXR5IG1hcHBpbmcuIEluIG1vc3QgY2FzZXMsCj4gPiBFRkkgY29uZmlnIHRh
YmxlIGNhbiBlbmQgdXAgdG8gYmUgbWFwcGVkIGludG8gZHVlIHRvIDEgR0IgcGFnZSBzaXplLgo+
ID4gSG93ZXZlciBpZiBub2dicGFnZXMgaXMgc2V0LCBvciBjcHUgZG9lc24ndCBzdXBwb3J0IHBk
cGUxZ2IgZmVhdHVyZQo+ID4gKGUuZyBJbnRlbCBBdG9tIHg2NDI1UkUgY3B1KSwgRUZJIGNvbmZp
ZyB0YWJsZSBtYXkgbm90IGJlIG1hcHBlZCBpbnRvCj4gPiBkdWUgdG8gMiBNQiBwYWdlIHNpemUs
IHRodXMgYSBwYWdlIGZhdWx0IGhhbmcgaXMgbW9yZSBsaWtlbHkgdG8gaGFwcGVuLgo+ID4KPiA+
IFRoaXMgcGF0Y2ggd2lsbCBtYWtlIHN1cmUgdGhlIEVGSSBjb25maWcgdGFibGUgaXMgYWx3YXlz
IG1hcHBlZC4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBUYW8gTGl1IDxsdGFvQHJlZGhhdC5jb20+
Cj4gPiAtLS0KPiA+IENoYW5nZXMgaW4gdjI6Cj4gPiAtIFJlcGhyYXNlIHRoZSBjaGFuZ2UgbG9n
IGJhc2VkIG9uIEJhb3F1YW4ncyBzdWdnZXN0aW9uLgo+ID4gLSBSZW5hbWUgbWFwX2VmaV9zeXNf
Y2ZnX3RhYigpIHRvIG1hcF9lZmlfdGFibGVzKCkuCj4gPiAtIExpbmsgdG8gdjE6IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2tleGVjLzIwMjMwNTI1MDk0OTE0LjIzNDIwLTEtbHRhb0ByZWRoYXQu
Y29tLwo+ID4gLS0tCj4gPiAgYXJjaC94ODYva2VybmVsL21hY2hpbmVfa2V4ZWNfNjQuYyB8IDM1
ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzMSBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9rZXJuZWwvbWFjaGluZV9rZXhlY182NC5jIGIvYXJjaC94ODYva2VybmVsL21hY2hpbmVfa2V4
ZWNfNjQuYwo+ID4gaW5kZXggMWEzZTJjMDVhOGE1Li42NjRhZWZhNmU4OTYgMTAwNjQ0Cj4gPiAt
LS0gYS9hcmNoL3g4Ni9rZXJuZWwvbWFjaGluZV9rZXhlY182NC5jCj4gPiArKysgYi9hcmNoL3g4
Ni9rZXJuZWwvbWFjaGluZV9rZXhlY182NC5jCj4gPiBAQCAtMjgsNiArMjgsNyBAQAo+ID4gICNp
bmNsdWRlIDxhc20vc2V0dXAuaD4KPiA+ICAjaW5jbHVkZSA8YXNtL3NldF9tZW1vcnkuaD4KPiA+
ICAjaW5jbHVkZSA8YXNtL2NwdS5oPgo+ID4gKyNpbmNsdWRlIDxhc20vZWZpLmg+Cj4gPgo+ID4g
ICNpZmRlZiBDT05GSUdfQUNQSQo+ID4gIC8qCj4gPiBAQCAtODYsMTAgKzg3LDEyIEBAIGNvbnN0
IHN0cnVjdCBrZXhlY19maWxlX29wcyAqIGNvbnN0IGtleGVjX2ZpbGVfbG9hZGVyc1tdID0gewo+
ID4gICNlbmRpZgo+ID4KPiA+ICBzdGF0aWMgaW50Cj4gPiAtbWFwX2VmaV9zeXN0YWIoc3RydWN0
IHg4Nl9tYXBwaW5nX2luZm8gKmluZm8sIHBnZF90ICpsZXZlbDRwKQo+ID4gK21hcF9lZmlfdGFi
bGVzKHN0cnVjdCB4ODZfbWFwcGluZ19pbmZvICppbmZvLCBwZ2RfdCAqbGV2ZWw0cCkKPiA+ICB7
Cj4gPiAgI2lmZGVmIENPTkZJR19FRkkKPiA+ICAgICAgIHVuc2lnbmVkIGxvbmcgbXN0YXJ0LCBt
ZW5kOwo+ID4gKyAgICAgdm9pZCAqa2FkZHI7Cj4gPiArICAgICBpbnQgcmV0Owo+ID4KPiA+ICAg
ICAgIGlmICghZWZpX2VuYWJsZWQoRUZJX0JPT1QpKQo+ID4gICAgICAgICAgICAgICByZXR1cm4g
MDsKPiA+IEBAIC0xMDUsNiArMTA4LDMwIEBAIG1hcF9lZmlfc3lzdGFiKHN0cnVjdCB4ODZfbWFw
cGluZ19pbmZvICppbmZvLCBwZ2RfdCAqbGV2ZWw0cCkKPiA+ICAgICAgIGlmICghbXN0YXJ0KQo+
ID4gICAgICAgICAgICAgICByZXR1cm4gMDsKPiA+Cj4gPiArICAgICByZXQgPSBrZXJuZWxfaWRl
bnRfbWFwcGluZ19pbml0KGluZm8sIGxldmVsNHAsIG1zdGFydCwgbWVuZCk7Cj4gPiArICAgICBp
ZiAocmV0KQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gcmV0Owo+ID4gKwo+ID4gKyAgICAga2Fk
ZHIgPSBtZW1yZW1hcChtc3RhcnQsIG1lbmQgLSBtc3RhcnQsIE1FTVJFTUFQX1dCKTsKPiA+ICsg
ICAgIGlmICgha2FkZHIpIHsKPiA+ICsgICAgICAgICAgICAgcHJfZXJyKCJDb3VsZCBub3QgbWFw
IFVFRkkgc3lzdGVtIHRhYmxlXG4iKTsKPiA+ICsgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07
Cj4gPiArICAgICB9Cj4gPiArCj4gPiArICAgICBtc3RhcnQgPSBlZmlfY29uZmlnX3RhYmxlOwo+
ID4gKwo+ID4gKyAgICAgaWYgKGVmaV9lbmFibGVkKEVGSV82NEJJVCkpIHsKPiA+ICsgICAgICAg
ICAgICAgZWZpX3N5c3RlbV90YWJsZV82NF90ICpzdGJsID0gKGVmaV9zeXN0ZW1fdGFibGVfNjRf
dCAqKWthZGRyOwo+ID4gKwo+ID4gKyAgICAgICAgICAgICBtZW5kID0gbXN0YXJ0ICsgc2l6ZW9m
KGVmaV9jb25maWdfdGFibGVfNjRfdCkgKiBzdGJsLT5ucl90YWJsZXM7Cj4gPiArICAgICB9IGVs
c2Ugewo+ID4gKyAgICAgICAgICAgICBlZmlfc3lzdGVtX3RhYmxlXzMyX3QgKnN0YmwgPSAoZWZp
X3N5c3RlbV90YWJsZV8zMl90ICopa2FkZHI7Cj4gPiArCj4gPiArICAgICAgICAgICAgIG1lbmQg
PSBtc3RhcnQgKyBzaXplb2YoZWZpX2NvbmZpZ190YWJsZV8zMl90KSAqIHN0YmwtPm5yX3RhYmxl
czsKPiA+ICsgICAgIH0KPiA+ICsKPiA+ICsgICAgIG1lbXVubWFwKGthZGRyKTsKPiA+ICsKPiA+
ICAgICAgIHJldHVybiBrZXJuZWxfaWRlbnRfbWFwcGluZ19pbml0KGluZm8sIGxldmVsNHAsIG1z
dGFydCwgbWVuZCk7Cj4gPiAgI2VuZGlmCj4gPiAgICAgICByZXR1cm4gMDsKPiA+IEBAIC0yNDQs
MTAgKzI3MSwxMCBAQCBzdGF0aWMgaW50IGluaXRfcGd0YWJsZShzdHJ1Y3Qga2ltYWdlICppbWFn
ZSwgdW5zaWduZWQgbG9uZyBzdGFydF9wZ3RhYmxlKQo+ID4gICAgICAgfQo+ID4KPiA+ICAgICAg
IC8qCj4gPiAtICAgICAgKiBQcmVwYXJlIEVGSSBzeXN0YWIgYW5kIEFDUEkgdGFibGVzIGZvciBr
ZXhlYyBrZXJuZWwgc2luY2UgdGhleSBhcmUKPiA+IC0gICAgICAqIG5vdCBjb3ZlcmVkIGJ5IHBm
bl9tYXBwZWQuCj4gPiArICAgICAgKiBQcmVwYXJlIEVGSSBzeXN0YWIsIGNvbmZpZyB0YWJsZSBh
bmQgQUNQSSB0YWJsZXMgZm9yIGtleGVjIGtlcm5lbAo+Cj4gVGhlIGNvZGUgY29tbWVudCBuZWVk
IGJlIHVwZGF0ZWQgdG9vPwo+Cj4gICAgICAgICAgKiBQcmVwYXJlIEVGSSB0YWJsZXMgYW5kIEFD
UEkgdGFibGVzIGZvciBrZXhlYyBrZXJuZWwgc2luY2UgdGhleSBhcmUKPiAgICAgICAgICAqIG5v
dCBjb3ZlcmVkIGJ5IHBmbl9tYXBwZWQuCj4KPiBPdGhlciB0aGFuIHRoaXMgbml0LCB0aGlzIHBh
dGNoIGxvb2tzIGdvb2QgdG8gbWUsIHRoYW5rcy4KPgoKVGhhbmtzIGZvciB0aGUgcGF0Y2ggcmV2
aWV3ISBJJ20gT0sgd2l0aCB0aGUgY29tbWVudCB1cGRhdGUsIGJ1dCBJCnByZWZlciB0byBsZWF2
ZSBpdCBhcyBpdCBpcy4gU2luY2UgdGhlIGNvbW1lbnQgcHJvdmlkZXMgbW9yZSBkZXRhaWxzOgp0
aGVyZSBhcmUgc3lzdGFiIGFuZCBjb25maWcgdGFibGVzIG1hcHBlZCBpbnN0ZWFkIG9mIGFsbCBl
ZmkgdGFibGVzLgoKVGhhbmtzLApUYW8gTGl1Cgo+IEFja2VkLWJ5OiBCYW9xdWFuIEhlIDxiaGVA
cmVkaGF0LmNvbT4KPgo+Cj4gPiArICAgICAgKiBzaW5jZSB0aGV5IGFyZSBub3QgY292ZXJlZCBi
eSBwZm5fbWFwcGVkLgo+ID4gICAgICAgICovCj4gPiAtICAgICByZXN1bHQgPSBtYXBfZWZpX3N5
c3RhYigmaW5mbywgbGV2ZWw0cCk7Cj4gPiArICAgICByZXN1bHQgPSBtYXBfZWZpX3RhYmxlcygm
aW5mbywgbGV2ZWw0cCk7Cj4gPiAgICAgICBpZiAocmVzdWx0KQo+ID4gICAgICAgICAgICAgICBy
ZXR1cm4gcmVzdWx0Owo+ID4KPiA+IC0tCj4gPiAyLjMzLjEKPiA+Cj4KCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4
ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2tleGVjCg==
