Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA43CEEAA7E
	for <kexec@archiver.kernel.org>; Fri, 15 Sep 2023 01:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7TSLmqn/BEcoKrGvoCd6UqDNY4E7ScjRiOT44DRmf/w=; b=R93vBgTUuk8GB/
	IU8P3f8TVRUVx9eMgoPvcDDzAEHrhstkGQ3KmnG1xMO84W3OrxePP22t/JsLGO+hRNsRHLBikMgmV
	lf9hcKFQxC/KNOymZd2ATfWsyaV50rVGuXXPp/n2wwh95NqHUeaO1Y5Fka8C+5g3pCi6odPG82gzN
	qzdsDccogNmmh49Dd8DjMC64YJZisbTQjwuGn/NsUFHqRsa0k95HKU42T1hgTSk8+fR9Qxp9Amhw6
	Q3ejquzDzVCDbPrYLqLvGKBBIN3+X5fbp7lLkjwv8FV4vceNKhSXYlMAf3VQ8J5s31jiAARw3VFgk
	YjRLYXiwNOZn59iFcqyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgxYS-009Y89-2O;
	Fri, 15 Sep 2023 01:23:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgxYP-009Y7o-2i
	for kexec@lists.infradead.org;
	Fri, 15 Sep 2023 01:23:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694741007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEqObfF+G4D0p1wf2hUjevuVHoD5Z5TkA9H9uKd23JI=;
	b=K742LCIBdA94sjTUlGemUwR/2i1wmoPBgBZLNZ6L3JtAzOBYOjCTXihPtD75fCW9BmLOV5
	BmG/ytbH4IosgyLy3LkmqpMb/rlhKzI0j8A/s64D+ohlVwtLo8wYXuJsUf0g8QClasuWtO
	8ohMGBCBTKzCDyrE3rSshmEPByBHidU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-6nAHMZ2BPgO7SqedR7X7Zw-1; Thu, 14 Sep 2023 21:23:25 -0400
X-MC-Unique: 6nAHMZ2BPgO7SqedR7X7Zw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76dcf1d88d9so190157685a.2
        for <kexec@lists.infradead.org>; Thu, 14 Sep 2023 18:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694741004; x=1695345804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEqObfF+G4D0p1wf2hUjevuVHoD5Z5TkA9H9uKd23JI=;
        b=K369GfsjqQhB1kBTDxgoSOlYDGUNYZgM/C2Qgt1r6EzAPzwmjb2YmZ8N7nPqt9KXlD
         Ze+/mfiMzMiP5Gs7VhAwe8it2ERfZaO8rOD5ZZB/zcj5Me1P648gLQGTNTaeHjECL8xX
         8uHAHqTFaTwItVliDUxLgz4qres/rnQ29gEu64+qXraOWwAcxeg/rt5uGbuG4Fs3pLc0
         YoMIWY50hRP+MOz8MyDIaahJ2HGd+wLFJXER6C12KTVKp9jHuw54keQvGBenNHbUNia4
         G2OgyxtXIcd6dIDsarURw0F9M8RopqnKajRMNcU5oWfuJ4GYgcXYi2+ZvT9gbKhOM18W
         6ecw==
X-Gm-Message-State: AOJu0YxugFNF9mbrcyMMbGIEa3Ks/lIPFtmn9HSKgAl2+YRrhJLeUOPS
	VnOdq5E8GDXI5FEgLgV3+r8hQwiKUyeuP+SKG6bQVy6zdEYGydjewycqM8poRbffGqQ1Cgdy9Pc
	SKEdssdAkE19mkHXtx7xzoNfA1EeYe6WuBKYD
X-Received: by 2002:a37:ef16:0:b0:767:b196:e88 with SMTP id j22-20020a37ef16000000b00767b1960e88mr159135qkk.42.1694741004578;
        Thu, 14 Sep 2023 18:23:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO+VGnJkC8u/Y9jTZEzrJGD5Tbg0X228tmim9ESiEaxT96Fb0jgs8v9JsKLq3Sr+8CyGEWG1oKaoAyjVjfVs0=
X-Received: by 2002:a37:ef16:0:b0:767:b196:e88 with SMTP id
 j22-20020a37ef16000000b00767b1960e88mr159126qkk.42.1694741004299; Thu, 14 Sep
 2023 18:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230914085000.17982-1-dyoung@redhat.com> <20230914085000.17982-2-dyoung@redhat.com>
In-Reply-To: <20230914085000.17982-2-dyoung@redhat.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 15 Sep 2023 09:23:13 +0800
Message-ID: <CAF+s44QR3fBsGw9pmJdPCGVexKyocj8utdjC-13kR9HUCXUf+w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] zboot: enable arm64 kexec_load for zboot image
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, Simon Horman <horms@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_182329_954075_1A929351 
X-CRM114-Status: GOOD (  24.51  )
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

T24gVGh1LCBTZXAgMTQsIDIwMjMgYXQgNDo1MOKAr1BNIERhdmUgWW91bmcgPGR5b3VuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+IGtleGVjX2ZpbGVfbG9hZCBzdXBwb3J0IG9mIHpib290IGtlcm5l
bCBpbWFnZSBkZWNvbXByZXNzZWQgdGhlIHZtbGludXosCj4gc28gaW4ga2V4ZWNfbG9hZCBjb2Rl
IGp1c3QgbG9hZCB0aGUga2VybmVsIHdpdGggcmVhZGluZyB0aGUgZGVjb21wcmVzc2VkCj4ga2Vy
bmVsIGZkIGludG8gYSBuZXcgYnVmZmVyIGFuZCB1c2UgaXQgZGlyZWN0bHkuCj4KPiBTaWduZWQt
b2ZmLWJ5OiBEYXZlIFlvdW5nIDxkeW91bmdAcmVkaGF0LmNvbT4KPiAtLS0KPiAgaW5jbHVkZS9r
ZXhlYy1wZS16Ym9vdC5oICAgICAgICAgICAgICAgfCAgMyArKy0KPiAga2V4ZWMvYXJjaC9hcm02
NC9rZXhlYy12bWxpbnV6LWFybTY0LmMgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKy0tLQo+
ICBrZXhlYy9rZXhlYy1wZS16Ym9vdC5jICAgICAgICAgICAgICAgICB8ICA0ICsrKy0KPiAga2V4
ZWMva2V4ZWMuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQo+ICBrZXhlYy9rZXhl
Yy5oICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsKPiAgNSBmaWxlcyBjaGFuZ2VkLCAz
MCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
a2V4ZWMtcGUtemJvb3QuaCBiL2luY2x1ZGUva2V4ZWMtcGUtemJvb3QuaAo+IGluZGV4IGUyZTA0
NDhhODFmMi4uMzc0OTE2Y2JlODgzIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUva2V4ZWMtcGUtemJv
b3QuaAo+ICsrKyBiL2luY2x1ZGUva2V4ZWMtcGUtemJvb3QuaAo+IEBAIC0xMSw1ICsxMSw2IEBA
IHN0cnVjdCBsaW51eF9wZV96Ym9vdF9oZWFkZXIgewo+ICAgICAgICAgdWludDMyX3QgY29tcHJl
c3NfdHlwZTsKPiAgfTsKPgo+IC1pbnQgcGV6X3ByZXBhcmUoY29uc3QgY2hhciAqY3J1ZGVfYnVm
LCBvZmZfdCBidWZfc3osIGludCAqa2VybmVsX2ZkKTsKPiAraW50IHBlel9wcmVwYXJlKGNvbnN0
IGNoYXIgKmNydWRlX2J1Ziwgb2ZmX3QgYnVmX3N6LCBpbnQgKmtlcm5lbF9mZCwKPiArICAgICAg
ICAgICAgICAgb2ZmX3QgKmtlcm5lbF9zaXplKTsKPiAgI2VuZGlmCj4gZGlmZiAtLWdpdCBhL2tl
eGVjL2FyY2gvYXJtNjQva2V4ZWMtdm1saW51ei1hcm02NC5jIGIva2V4ZWMvYXJjaC9hcm02NC9r
ZXhlYy12bWxpbnV6LWFybTY0LmMKPiBpbmRleCBjMGVlNDdjOGY1MGEuLmUyOTFhMzRjOTdhZCAx
MDA2NDQKPiAtLS0gYS9rZXhlYy9hcmNoL2FybTY0L2tleGVjLXZtbGludXotYXJtNjQuYwo+ICsr
KyBiL2tleGVjL2FyY2gvYXJtNjQva2V4ZWMtdm1saW51ei1hcm02NC5jCj4gQEAgLTM0LDYgKzM0
LDcgQEAKPiAgI2luY2x1ZGUgImFyY2gvb3B0aW9ucy5oIgo+Cj4gIHN0YXRpYyBpbnQga2VybmVs
X2ZkID0gLTE7Cj4gK3N0YXRpYyBvZmZfdCBkZWNvbXByZXNzZWRfc2l6ZTsKPgo+ICAvKiBSZXR1
cm5zOgo+ICAgKiAtMSA6IGluIGNhc2Ugb2YgZXJyb3IvaW52YWxpZCBmb3JtYXQgKG5vdCBhIHZh
bGlkIFBFK2NvbXByZXNzZWQgWkJPT1QgZm9ybWF0Lgo+IEBAIC03Miw3ICs3Myw3IEBAIGludCBw
ZXpfYXJtNjRfcHJvYmUoY29uc3QgY2hhciAqa2VybmVsX2J1Ziwgb2ZmX3Qga2VybmVsX3NpemUp
Cj4gICAgICAgICAgICAgICAgIHJldHVybiAtMTsKPiAgICAgICAgIH0KPgo+IC0gICAgICAgcmV0
ID0gcGV6X3ByZXBhcmUoYnVmLCBidWZfc3osICZrZXJuZWxfZmQpOwo+ICsgICAgICAgcmV0ID0g
cGV6X3ByZXBhcmUoYnVmLCBidWZfc3osICZrZXJuZWxfZmQsICZkZWNvbXByZXNzZWRfc2l6ZSk7
Cj4KPiAgICAgICAgIGlmICghcmV0KSB7Cj4gICAgICAgICAgICAgLyogdmFsaWRhdGUgdGhlIGFy
bTY0IHNwZWNpZmljIGhlYWRlciAqLwo+IEBAIC05OCw4ICs5OSwyNyBAQCBiYWRfaGVhZGVyOgo+
ICBpbnQgcGV6X2FybTY0X2xvYWQoaW50IGFyZ2MsIGNoYXIgKiphcmd2LCBjb25zdCBjaGFyICpi
dWYsIG9mZl90IGxlbiwKPiAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qga2V4ZWNfaW5m
byAqaW5mbykKPiAgewo+IC0gICAgICAgaW5mby0+a2VybmVsX2ZkID0ga2VybmVsX2ZkOwo+IC0g
ICAgICAgcmV0dXJuIGltYWdlX2FybTY0X2xvYWQoYXJnYywgYXJndiwgYnVmLCBsZW4sIGluZm8p
Owo+ICsgICAgICAgaWYgKGtlcm5lbF9mZCA+IDAgJiYgZGVjb21wcmVzc2VkX3NpemUgPiAwKSB7
Cj4gKyAgICAgICAgICAgICAgIGNoYXIgKmtidWY7Cj4gKyAgICAgICAgICAgICAgIG9mZl90IG5y
ZWFkOwo+ICsgICAgICAgICAgICAgICBpbnQgZmQ7Cj4gKwo+ICsgICAgICAgICAgICAgICBpbmZv
LT5rZXJuZWxfZmQgPSBrZXJuZWxfZmQ7Cj4gKyAgICAgICAgICAgICAgIGZkID0gZHVwKGtlcm5l
bF9mZCk7Cj4gKyAgICAgICAgICAgICAgIGlmIChmZCA8IDApIHsKPiArICAgICAgICAgICAgICAg
ICAgICAgICBkYmdwcmludGYoIiVzOiBkdXAgZmQgZmFpbGVkLlxuIiwgX19mdW5jX18pOwo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtMTsKPiArICAgICAgICAgICAgICAgfQo+ICsg
ICAgICAgICAgICAgICBrYnVmID0gc2x1cnBfZmQoZmQsIE5VTEwsIGRlY29tcHJlc3NlZF9zaXpl
LCAmbnJlYWQpOwo+ICsgICAgICAgICAgICAgICBpZiAoIWtidWYgfHwgbnJlYWQgIT0gZGVjb21w
cmVzc2VkX3NpemUpIHsKPiArICAgICAgICAgICAgICAgICAgICAgICBkYmdwcmludGYoIiVzOiBz
bHVycF9mZCBmYWlsZWQuXG4iLCBfX2Z1bmNfXyk7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIC0xOwo+ICsgICAgICAgICAgICAgICB9Cj4gKyAgICAgICAgICAgICAgIHJldHVybiBp
bWFnZV9hcm02NF9sb2FkKGFyZ2MsIGFyZ3YsIGtidWYsIGRlY29tcHJlc3NlZF9zaXplLCBpbmZv
KTsKPiArICAgICAgIH0KPiArCj4gKyAgICAgICBkYmdwcmludGYoIiVzOiB3cm9uZyBrZXJuZWwg
ZmlsZSBkZXNjcmlwdG9yLlxuIiwgX19mdW5jX18pOwo+ICsgICAgICAgcmV0dXJuIC0xOwo+ICB9
Cj4KPiAgdm9pZCBwZXpfYXJtNjRfdXNhZ2Uodm9pZCkKPiBkaWZmIC0tZ2l0IGEva2V4ZWMva2V4
ZWMtcGUtemJvb3QuYyBiL2tleGVjL2tleGVjLXBlLXpib290LmMKPiBpbmRleCAyZjJlMDUyYjc2
YzUuLjNhYmQxN2Q5ZmU1OSAxMDA2NDQKPiAtLS0gYS9rZXhlYy9rZXhlYy1wZS16Ym9vdC5jCj4g
KysrIGIva2V4ZWMva2V4ZWMtcGUtemJvb3QuYwo+IEBAIC0zNyw3ICszNyw4IEBACj4gICAqCj4g
ICAqIGNydWRlX2J1ZjogdGhlIGNvbnRlbnQsIHdoaWNoIGlzIHJlYWQgZnJvbSB0aGUga2VybmVs
IGZpbGUgd2l0aG91dCBhbnkgcHJvY2Vzc2luZwo+ICAgKi8KPiAtaW50IHBlel9wcmVwYXJlKGNv
bnN0IGNoYXIgKmNydWRlX2J1Ziwgb2ZmX3QgYnVmX3N6LCBpbnQgKmtlcm5lbF9mZCkKPiAraW50
IHBlel9wcmVwYXJlKGNvbnN0IGNoYXIgKmNydWRlX2J1Ziwgb2ZmX3QgYnVmX3N6LCBpbnQgKmtl
cm5lbF9mZCwKPiArICAgICAgICAgICAgICAgb2ZmX3QgKmtlcm5lbF9zaXplKQo+ICB7Cj4gICAg
ICAgICBpbnQgcmV0ID0gLTE7Cj4gICAgICAgICBpbnQgZmQgPSAwOwo+IEBAIC0xMTAsNiArMTEx
LDcgQEAgaW50IHBlel9wcmVwYXJlKGNvbnN0IGNoYXIgKmNydWRlX2J1Ziwgb2ZmX3QgYnVmX3N6
LCBpbnQgKmtlcm5lbF9mZCkKPiAgICAgICAgICAgICAgICAgZ290byBmYWlsX2JhZF9oZWFkZXI7
Cj4gICAgICAgICB9Cj4KPiArICAgICAgICprZXJuZWxfc2l6ZSA9IGRlY29tcHJlc3NlZF9zaXpl
Owo+ICAgICAgICAgZGJncHJpbnRmKCIlczogZG9uZVxuIiwgX19mdW5jX18pOwo+Cj4gICAgICAg
ICByZXQgPSAwOwo+IGRpZmYgLS1naXQgYS9rZXhlYy9rZXhlYy5jIGIva2V4ZWMva2V4ZWMuYwo+
IGluZGV4IGMzYjE4MmUyNTRlMC4uMWVkYmQzNDljODZkIDEwMDY0NAo+IC0tLSBhL2tleGVjL2tl
eGVjLmMKPiArKysgYi9rZXhlYy9rZXhlYy5jCj4gQEAgLTQ4OSw3ICs0ODksNyBAQCBzdGF0aWMg
aW50IGFkZF9iYWNrdXBfc2VnbWVudHMoc3RydWN0IGtleGVjX2luZm8gKmluZm8sCj4gICAgICAg
ICByZXR1cm4gMDsKPiAgfQo+Cj4gLXN0YXRpYyBjaGFyICpzbHVycF9mZChpbnQgZmQsIGNvbnN0
IGNoYXIgKmZpbGVuYW1lLCBvZmZfdCBzaXplLCBvZmZfdCAqbnJlYWQpCj4gK2NoYXIgKnNsdXJw
X2ZkKGludCBmZCwgY29uc3QgY2hhciAqZmlsZW5hbWUsIG9mZl90IHNpemUsIG9mZl90ICpucmVh
ZCkKPiAgewo+ICAgICAgICAgY2hhciAqYnVmOwo+ICAgICAgICAgb2ZmX3QgcHJvZ3Jlc3M7Cj4g
ZGlmZiAtLWdpdCBhL2tleGVjL2tleGVjLmggYi9rZXhlYy9rZXhlYy5oCj4gaW5kZXggZWQzYjQ5
OWE4MGYyLi4wOTMzMzg5NjljNTcgMTAwNjQ0Cj4gLS0tIGEva2V4ZWMva2V4ZWMuaAo+ICsrKyBi
L2tleGVjL2tleGVjLmgKPiBAQCAtMjY3LDYgKzI2Nyw3IEBAIGV4dGVybiB2b2lkIGRpZShjb25z
dCBjaGFyICpmbXQsIC4uLikKPiAgICAgICAgIF9fYXR0cmlidXRlX18gKChmb3JtYXQgKHByaW50
ZiwgMSwgMikpKTsKPiAgZXh0ZXJuIHZvaWQgKnhtYWxsb2Moc2l6ZV90IHNpemUpOwo+ICBleHRl
cm4gdm9pZCAqeHJlYWxsb2Modm9pZCAqcHRyLCBzaXplX3Qgc2l6ZSk7Cj4gK2V4dGVybiBjaGFy
ICpzbHVycF9mZChpbnQgZmQsIGNvbnN0IGNoYXIgKmZpbGVuYW1lLCBvZmZfdCBzaXplLCBvZmZf
dCAqbnJlYWQpOwo+ICBleHRlcm4gY2hhciAqc2x1cnBfZmlsZShjb25zdCBjaGFyICpmaWxlbmFt
ZSwgb2ZmX3QgKnJfc2l6ZSk7Cj4gIGV4dGVybiBjaGFyICpzbHVycF9maWxlX21tYXAoY29uc3Qg
Y2hhciAqZmlsZW5hbWUsIG9mZl90ICpyX3NpemUpOwo+ICBleHRlcm4gY2hhciAqc2x1cnBfZmls
ZV9sZW4oY29uc3QgY2hhciAqZmlsZW5hbWUsIG9mZl90IHNpemUsIG9mZl90ICpucmVhZCk7Cj4g
LS0KPiAyLjM3LjIKPgoKSGF2ZSB0ZXN0ZWQgYm90aCBrZXhlY19sb2FkIGFuZCBrZXhlY19maWxl
X2xvYWQsIGJvdGggb2YgdGhlbSB3b3JrLgoKUmV2aWV3ZWQtYnk6IFBpbmdmYW4gTGl1IDxwaWxp
dUByZWRoYXQuY29tPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
