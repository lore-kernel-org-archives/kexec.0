Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE1DEE3F39
	for <kexec@archiver.kernel.org>; Wed, 13 Sep 2023 00:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EBKQk0tlWn/Ii52k8mxiCG5LL4O5D2N1FurKF3VEd7U=; b=khMxkynHvWuhNz
	hjl3sbByXGi//zMdhvVabapM5sG4bdsMLlvVdtRxeRUHGCL8WTZQAVodjULN7/hdI5hELo6abVNFn
	IMdBX4ZIU+iVTdiOS14Lau125euWfI7l6lovpbSUSQ/BbRv8jABvH1kjHnQYD76XXBzPnCPXk/6lm
	qivQuhgMchEakBgeRlF0svQef5c6XVfACyTAB/o98Lm/cG4fPG8pAvnHRWUlEyiY8T9r3oTZ7X1Vf
	A9Vg6IahiAi0g2fSobe1nUfnTaFlKJ/4fCn+aNxP95BOPncq/FpNuhF/PGm1J4yDtW4T82UeYx93L
	UXHVr5A9PzSFoS4GY7oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgE9E-004MlO-1Z;
	Wed, 13 Sep 2023 00:54:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgE9A-004Ml0-18
	for kexec@lists.infradead.org;
	Wed, 13 Sep 2023 00:54:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694566461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WlQ5ufVwrBFIi6NILOynddh0fFLorOZ4m2MorABOQos=;
	b=ZIuT4e7i9ESxewyxaKSq09P6Pc6J1D5m028T/AH7NuptePjD4loYwaXgrwo+GBxreA1jmv
	ZRlD1G6It6wQB5yjthSSxZoNrhIyhKIG5/7geNLzZmV6Z5FlwhYjbKRm2dhN/FfkoL6XgF
	eNP08fZNB7TfZcdQZSnURM9hXTnXjQk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-ElznRIlpMhe4WpC4i3DFsA-1; Tue, 12 Sep 2023 20:54:19 -0400
X-MC-Unique: ElznRIlpMhe4WpC4i3DFsA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-64b7c2a0d5dso68804016d6.3
        for <kexec@lists.infradead.org>; Tue, 12 Sep 2023 17:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694566459; x=1695171259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlQ5ufVwrBFIi6NILOynddh0fFLorOZ4m2MorABOQos=;
        b=eBz+D1//1XpmLkMBnxX/QN3KczfngfY0JuQwIqC678WOEQ7jWI0mYuZzYp1d+CtSVA
         Llo+ee1Kf+p2fum1GuskV3yVGQVxxFVQFsxIppJZ1Dpmh5hBNg2t26saCTmv0e3DcmXy
         ufZDVLL8swVYBN4TUa+ogCltCW0iAQYo+kCRmFUC7hOaW6aW12MDt2SXWIzuTA5nI/mK
         016lfBBqUa7/7DEOHBSaziPyjFbXBhvezzu9jhd8vMBIO3A+gEft+YtPnc/NwKbYzAd7
         +eb0vpq+DNBqSRuVZeMP8DzSBvaGj5pp6lLzSZYqOqm9KI5HohE1OhqwRs17cjM6qwG3
         B2qw==
X-Gm-Message-State: AOJu0Yx1hAPLWsniZZO9Xtb1F8f/vVdu5j3SNqMH8bRewZrjr/sWf/RU
	oR81jpM81vDX5d8wLlQcLLAAOdchi53b33FvlqF+RiY+X8ZehrFcz4zExquL5Awn/kV4nJwnZJ5
	u93U6LEq6H47iKszjCfAvBuuptyQSNs7umYWsX3rAeN2k
X-Received: by 2002:a0c:f850:0:b0:636:39ed:4dce with SMTP id g16-20020a0cf850000000b0063639ed4dcemr1090575qvo.20.1694566459247;
        Tue, 12 Sep 2023 17:54:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJhjTg2loRqXfgRAMTx35UXLwMd2ThKTritx/96qdXONAG+C6Z8/y6gbn5o3tXBlX7b+MKMMS2A6tPi7bFWE0=
X-Received: by 2002:a0c:f850:0:b0:636:39ed:4dce with SMTP id
 g16-20020a0cf850000000b0063639ed4dcemr1090566qvo.20.1694566459031; Tue, 12
 Sep 2023 17:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230911183722.11173-1-dyoung@redhat.com>
In-Reply-To: <20230911183722.11173-1-dyoung@redhat.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Wed, 13 Sep 2023 08:54:08 +0800
Message-ID: <CAF+s44Tm8MgbcHg=Uea8JULv=-jpe6P7dYRuGY1WGSwTNp93cg@mail.gmail.com>
Subject: Re: [PATCH 1/2] zboot: enable arm64 kexec_load for zboot image
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, Simon Horman <horms@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_175424_462744_C3303C7E 
X-CRM114-Status: GOOD (  24.64  )
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

T24gTW9uLCBTZXAgMTEsIDIwMjMgYXQgNjozN+KAr1BNIERhdmUgWW91bmcgPGR5b3VuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+IGtleGVjX2ZpbGVfbG9hZCBzdXBwb3J0IG9mIHpib290IGtlcm5l
bCBpbWFnZSBkZWNvbXByZXNzZWQgdGhlIHZtbGludXosCj4gc28gaW4ga2V4ZWNfbG9hZCBjb2Rl
IGp1c3QgbG9hZCB0aGUga2VybmVsIHdpdGggcmVhZGluZyB0aGUgZGVjb21wcmVzc2VkCj4ga2Vy
bmVsIGZkIGludG8gYSBuZXcgYnVmZmVyIGFuZCB1c2UgaXQgZGlyZWN0bHkuCj4KPiBTaWduZWQt
b2ZmLWJ5OiBEYXZlIFlvdW5nIDxkeW91bmdAcmVkaGF0LmNvbT4KPiAtLS0KPiAgaW5jbHVkZS9r
ZXhlYy1wZS16Ym9vdC5oICAgICAgICAgICAgICAgfCAgMyArKy0KPiAga2V4ZWMvYXJjaC9hcm02
NC9rZXhlYy12bWxpbnV6LWFybTY0LmMgfCAyMCArKysrKysrKysrKysrKysrKystLQo+ICBrZXhl
Yy9rZXhlYy1wZS16Ym9vdC5jICAgICAgICAgICAgICAgICB8ICA0ICsrKy0KPiAga2V4ZWMva2V4
ZWMuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQo+ICBrZXhlYy9rZXhlYy5oICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsKPiAgNSBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUva2V4ZWMt
cGUtemJvb3QuaCBiL2luY2x1ZGUva2V4ZWMtcGUtemJvb3QuaAo+IGluZGV4IGUyZTA0NDhhODFm
Mi4uMzc0OTE2Y2JlODgzIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUva2V4ZWMtcGUtemJvb3QuaAo+
ICsrKyBiL2luY2x1ZGUva2V4ZWMtcGUtemJvb3QuaAo+IEBAIC0xMSw1ICsxMSw2IEBAIHN0cnVj
dCBsaW51eF9wZV96Ym9vdF9oZWFkZXIgewo+ICAgICAgICAgdWludDMyX3QgY29tcHJlc3NfdHlw
ZTsKPiAgfTsKPgo+IC1pbnQgcGV6X3ByZXBhcmUoY29uc3QgY2hhciAqY3J1ZGVfYnVmLCBvZmZf
dCBidWZfc3osIGludCAqa2VybmVsX2ZkKTsKPiAraW50IHBlel9wcmVwYXJlKGNvbnN0IGNoYXIg
KmNydWRlX2J1Ziwgb2ZmX3QgYnVmX3N6LCBpbnQgKmtlcm5lbF9mZCwKPiArICAgICAgICAgICAg
ICAgb2ZmX3QgKmtlcm5lbF9zaXplKTsKPiAgI2VuZGlmCj4gZGlmZiAtLWdpdCBhL2tleGVjL2Fy
Y2gvYXJtNjQva2V4ZWMtdm1saW51ei1hcm02NC5jIGIva2V4ZWMvYXJjaC9hcm02NC9rZXhlYy12
bWxpbnV6LWFybTY0LmMKPiBpbmRleCBjMGVlNDdjOGY1MGEuLjhmMzc4ZDhmYTZkMCAxMDA2NDQK
PiAtLS0gYS9rZXhlYy9hcmNoL2FybTY0L2tleGVjLXZtbGludXotYXJtNjQuYwo+ICsrKyBiL2tl
eGVjL2FyY2gvYXJtNjQva2V4ZWMtdm1saW51ei1hcm02NC5jCj4gQEAgLTM0LDYgKzM0LDcgQEAK
PiAgI2luY2x1ZGUgImFyY2gvb3B0aW9ucy5oIgo+Cj4gIHN0YXRpYyBpbnQga2VybmVsX2ZkID0g
LTE7Cj4gK3N0YXRpYyBvZmZfdCBkZWNvbXByZXNzZWRfc2l6ZTsKPgo+ICAvKiBSZXR1cm5zOgo+
ICAgKiAtMSA6IGluIGNhc2Ugb2YgZXJyb3IvaW52YWxpZCBmb3JtYXQgKG5vdCBhIHZhbGlkIFBF
K2NvbXByZXNzZWQgWkJPT1QgZm9ybWF0Lgo+IEBAIC03Miw3ICs3Myw3IEBAIGludCBwZXpfYXJt
NjRfcHJvYmUoY29uc3QgY2hhciAqa2VybmVsX2J1Ziwgb2ZmX3Qga2VybmVsX3NpemUpCj4gICAg
ICAgICAgICAgICAgIHJldHVybiAtMTsKPiAgICAgICAgIH0KPgo+IC0gICAgICAgcmV0ID0gcGV6
X3ByZXBhcmUoYnVmLCBidWZfc3osICZrZXJuZWxfZmQpOwo+ICsgICAgICAgcmV0ID0gcGV6X3By
ZXBhcmUoYnVmLCBidWZfc3osICZrZXJuZWxfZmQsICZkZWNvbXByZXNzZWRfc2l6ZSk7Cj4KPiAg
ICAgICAgIGlmICghcmV0KSB7Cj4gICAgICAgICAgICAgLyogdmFsaWRhdGUgdGhlIGFybTY0IHNw
ZWNpZmljIGhlYWRlciAqLwo+IEBAIC05OCw4ICs5OSwyMyBAQCBiYWRfaGVhZGVyOgo+ICBpbnQg
cGV6X2FybTY0X2xvYWQoaW50IGFyZ2MsIGNoYXIgKiphcmd2LCBjb25zdCBjaGFyICpidWYsIG9m
Zl90IGxlbiwKPiAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qga2V4ZWNfaW5mbyAqaW5m
bykKPiAgewo+ICsgICAgICAgY2hhciAqa2J1ZjsKPiArCj4gICAgICAgICBpbmZvLT5rZXJuZWxf
ZmQgPSBrZXJuZWxfZmQ7Cj4gLSAgICAgICByZXR1cm4gaW1hZ2VfYXJtNjRfbG9hZChhcmdjLCBh
cmd2LCBidWYsIGxlbiwgaW5mbyk7Cj4gKyAgICAgICBpZiAoa2VybmVsX2ZkID4gMCAmJiBkZWNv
bXByZXNzZWRfc2l6ZSA+IDApIHsKPiArICAgICAgICAgICAgICAgb2ZmX3QgbnJlYWQ7Cj4gKwo+
ICsgICAgICAgICAgICAgICBrYnVmID0gc2x1cnBfZmQoa2VybmVsX2ZkLCBOVUxMLCBkZWNvbXBy
ZXNzZWRfc2l6ZSwgJm5yZWFkKTsKPiArICAgICAgICAgICAgICAgaWYgKCFrYnVmIHx8IG5yZWFk
ICE9IGRlY29tcHJlc3NlZF9zaXplKSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgZGJncHJp
bnRmKCIlczogZmFpbGVkLlxuIiwgX19mdW5jX18pOwo+ICsgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiAtMTsKPiArICAgICAgICAgICAgICAgfQo+ICsgICAgICAgfSBlbHNlIHsKPiArICAg
ICAgICAgICAgICAgZGJncHJpbnRmKCIlczogd3JvbmcgZmlsZSBkZXNjcmlwdG9yLlxuIiwgX19m
dW5jX18pOwo+ICsgICAgICAgICAgICAgICByZXR1cm4gLTE7Cj4gKyAgICAgICB9Cj4gKwo+ICsg
ICAgICAgcmV0dXJuIGltYWdlX2FybTY0X2xvYWQoYXJnYywgYXJndiwga2J1ZiwgZGVjb21wcmVz
c2VkX3NpemUsIGluZm8pOwo+ICB9Cj4KPiAgdm9pZCBwZXpfYXJtNjRfdXNhZ2Uodm9pZCkKPiBk
aWZmIC0tZ2l0IGEva2V4ZWMva2V4ZWMtcGUtemJvb3QuYyBiL2tleGVjL2tleGVjLXBlLXpib290
LmMKPiBpbmRleCAyZjJlMDUyYjc2YzUuLjNhYmQxN2Q5ZmU1OSAxMDA2NDQKPiAtLS0gYS9rZXhl
Yy9rZXhlYy1wZS16Ym9vdC5jCj4gKysrIGIva2V4ZWMva2V4ZWMtcGUtemJvb3QuYwo+IEBAIC0z
Nyw3ICszNyw4IEBACj4gICAqCj4gICAqIGNydWRlX2J1ZjogdGhlIGNvbnRlbnQsIHdoaWNoIGlz
IHJlYWQgZnJvbSB0aGUga2VybmVsIGZpbGUgd2l0aG91dCBhbnkgcHJvY2Vzc2luZwo+ICAgKi8K
PiAtaW50IHBlel9wcmVwYXJlKGNvbnN0IGNoYXIgKmNydWRlX2J1Ziwgb2ZmX3QgYnVmX3N6LCBp
bnQgKmtlcm5lbF9mZCkKPiAraW50IHBlel9wcmVwYXJlKGNvbnN0IGNoYXIgKmNydWRlX2J1Ziwg
b2ZmX3QgYnVmX3N6LCBpbnQgKmtlcm5lbF9mZCwKPiArICAgICAgICAgICAgICAgb2ZmX3QgKmtl
cm5lbF9zaXplKQo+ICB7Cj4gICAgICAgICBpbnQgcmV0ID0gLTE7Cj4gICAgICAgICBpbnQgZmQg
PSAwOwo+IEBAIC0xMTAsNiArMTExLDcgQEAgaW50IHBlel9wcmVwYXJlKGNvbnN0IGNoYXIgKmNy
dWRlX2J1Ziwgb2ZmX3QgYnVmX3N6LCBpbnQgKmtlcm5lbF9mZCkKPiAgICAgICAgICAgICAgICAg
Z290byBmYWlsX2JhZF9oZWFkZXI7Cj4gICAgICAgICB9Cj4KPiArICAgICAgICprZXJuZWxfc2l6
ZSA9IGRlY29tcHJlc3NlZF9zaXplOwo+ICAgICAgICAgZGJncHJpbnRmKCIlczogZG9uZVxuIiwg
X19mdW5jX18pOwo+Cj4gICAgICAgICByZXQgPSAwOwo+IGRpZmYgLS1naXQgYS9rZXhlYy9rZXhl
Yy5jIGIva2V4ZWMva2V4ZWMuYwo+IGluZGV4IGMzYjE4MmUyNTRlMC4uMWVkYmQzNDljODZkIDEw
MDY0NAo+IC0tLSBhL2tleGVjL2tleGVjLmMKPiArKysgYi9rZXhlYy9rZXhlYy5jCj4gQEAgLTQ4
OSw3ICs0ODksNyBAQCBzdGF0aWMgaW50IGFkZF9iYWNrdXBfc2VnbWVudHMoc3RydWN0IGtleGVj
X2luZm8gKmluZm8sCj4gICAgICAgICByZXR1cm4gMDsKPiAgfQo+Cj4gLXN0YXRpYyBjaGFyICpz
bHVycF9mZChpbnQgZmQsIGNvbnN0IGNoYXIgKmZpbGVuYW1lLCBvZmZfdCBzaXplLCBvZmZfdCAq
bnJlYWQpCj4gK2NoYXIgKnNsdXJwX2ZkKGludCBmZCwgY29uc3QgY2hhciAqZmlsZW5hbWUsIG9m
Zl90IHNpemUsIG9mZl90ICpucmVhZCkKPiAgewo+ICAgICAgICAgY2hhciAqYnVmOwo+ICAgICAg
ICAgb2ZmX3QgcHJvZ3Jlc3M7Cj4gZGlmZiAtLWdpdCBhL2tleGVjL2tleGVjLmggYi9rZXhlYy9r
ZXhlYy5oCj4gaW5kZXggZWQzYjQ5OWE4MGYyLi4wOTMzMzg5NjljNTcgMTAwNjQ0Cj4gLS0tIGEv
a2V4ZWMva2V4ZWMuaAo+ICsrKyBiL2tleGVjL2tleGVjLmgKPiBAQCAtMjY3LDYgKzI2Nyw3IEBA
IGV4dGVybiB2b2lkIGRpZShjb25zdCBjaGFyICpmbXQsIC4uLikKPiAgICAgICAgIF9fYXR0cmli
dXRlX18gKChmb3JtYXQgKHByaW50ZiwgMSwgMikpKTsKPiAgZXh0ZXJuIHZvaWQgKnhtYWxsb2Mo
c2l6ZV90IHNpemUpOwo+ICBleHRlcm4gdm9pZCAqeHJlYWxsb2Modm9pZCAqcHRyLCBzaXplX3Qg
c2l6ZSk7Cj4gK2V4dGVybiBjaGFyICpzbHVycF9mZChpbnQgZmQsIGNvbnN0IGNoYXIgKmZpbGVu
YW1lLCBvZmZfdCBzaXplLCBvZmZfdCAqbnJlYWQpOwo+ICBleHRlcm4gY2hhciAqc2x1cnBfZmls
ZShjb25zdCBjaGFyICpmaWxlbmFtZSwgb2ZmX3QgKnJfc2l6ZSk7Cj4gIGV4dGVybiBjaGFyICpz
bHVycF9maWxlX21tYXAoY29uc3QgY2hhciAqZmlsZW5hbWUsIG9mZl90ICpyX3NpemUpOwo+ICBl
eHRlcm4gY2hhciAqc2x1cnBfZmlsZV9sZW4oY29uc3QgY2hhciAqZmlsZW5hbWUsIG9mZl90IHNp
emUsIG9mZl90ICpucmVhZCk7Cj4gLS0KPiAyLjM3LjIKPgoKTEdUTSwKUmV2aWV3ZWQtYnk6IFBp
bmdmYW4gTGl1IDxwaWxpdUByZWRoYXQuY29tPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4
ZWMK
