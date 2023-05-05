Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D90C7EE21
	for <kexec@archiver.kernel.org>; Fri,  5 May 2023 03:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5Ov+7qo9lOvp83afLo1DAx2LYeGG9IlVidaSw4B1YMs=; b=NdkKh3y5wqMNou
	GwzVWsy3fW8ILqQjfSWzSL61dWwV5dmESFutOzQ9ToUD0K13BSQcjmv580sfVPtHUXAlCTyapOfZs
	a5fAey/x1wIirb7e6P8UsDxc0pW971yux16crcrhQwAXzNz3BbOcamJ8QPWGFrdmJh1Wnj3S265b8
	JsuhBbacONnZMjTHy43CzrlVikna4mIFkEQg2MQrGo34HJAK4SgRV8emjJ9tYvO0yIhlRxgrCXImr
	nko7+S20cx1JLTOK0BzrPJTVXmPx/lYFHc0iOEkDSvBkBEoFR4E9beAZ67N88rRp+fB+y5/Gbme2w
	8z35gJoYP/6B8IYuuv/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puloU-009bjz-34;
	Fri, 05 May 2023 03:08:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puloS-009bjS-1K
	for kexec@lists.infradead.org;
	Fri, 05 May 2023 03:08:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683256129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jeFaguXA0upFRW1MVss2D2fkIUAp1XnyKHL11Ujw42o=;
	b=SCS7OxMHwegLKhamgES5XlzgvNS+DshnHqU43s4gBuVOgoV2BNx0892HrjpBFHdUC8BVup
	hhJcZFbrToBiYTlALBzxKJMypp7ddWVx9LBtmSWAgB+hDdLFiVDL/cwwt/0BNEKS1FDHFO
	0xmjU+A/RKbJ89QVqdN5k9qkp5ULg+s=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-YEZ5xeHbO762BQPxJvZDfw-1; Thu, 04 May 2023 23:08:48 -0400
X-MC-Unique: YEZ5xeHbO762BQPxJvZDfw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-75646ca18a9so901185a.0
        for <kexec@lists.infradead.org>; Thu, 04 May 2023 20:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683256128; x=1685848128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeFaguXA0upFRW1MVss2D2fkIUAp1XnyKHL11Ujw42o=;
        b=XBY58EpbrwRAtngmuRUPYrgA8+LoKtW+M+xHamC8Wvy6SM2iQf7ejn4r2Jfn6M/iej
         7YC3dmwzJQGBBsTzrRfzYYr/ZQAk6WGDn2VQQTVmR1kl5no/UTUx9S5TH6ow+QqztLD8
         dK6mvJNrUuUUJp6HeNzpvhmtWYB780xnPl6yfS+fV9hv18su7d/egbKXYmbHQYV3q/dB
         pYTBQjvSrlPE5mg1JZHAjTH5XvrIXqR0Iz+u3yLViElrkUUbCfYaOSp9OREEWmUcRsHz
         TSdVL3Qh4CODnY3kzEp7g4eXjNBf/6qCjnlLOJPriL4QoLbTJE0Y5Q3EFU6ufihiFn0S
         LTMQ==
X-Gm-Message-State: AC+VfDx1gblsKNnPUP1KPPWuvVeRHNtL6GO1Y3WFc663L6PxAeOHzNvH
	r39H/eyJAIRqcVCy6nErh1dtxSlnRJdGhN+hUOjj1sSupM51eU92OFqR5Jwtg7gQavdNCpsKN73
	gseEZHc3y3tkMFDsfXeiYY3lLzcBEjThGfYgW
X-Received: by 2002:a05:6214:407:b0:5ef:7e33:c6c9 with SMTP id z7-20020a056214040700b005ef7e33c6c9mr222559qvx.38.1683256127999;
        Thu, 04 May 2023 20:08:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7OvuzDckaBHgVDGuX624xDOpy42ooV6LjLc/xqc3Xp7YSyDci0lIb+k3AEzsNUFKijEcihenq6YXpxJ8Y5Ezs=
X-Received: by 2002:a05:6214:407:b0:5ef:7e33:c6c9 with SMTP id
 z7-20020a056214040700b005ef7e33c6c9mr222541qvx.38.1683256127761; Thu, 04 May
 2023 20:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230504164147.1166614-1-jeremy.linton@arm.com>
In-Reply-To: <20230504164147.1166614-1-jeremy.linton@arm.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 5 May 2023 11:08:36 +0800
Message-ID: <CAF+s44Q43rTrf=konek47A-EoWsPjfOyQSdKQRmFnXA4=W7+=w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Support kexec'ing PEs containing compressed kernels
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, bhsharma@redhat.com, 
	ardb@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_200852_518010_64D824C3 
X-CRM114-Status: GOOD (  22.00  )
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

SGkgSmVyZW15LAoKVGhhbmtzIGZvciBzaGFyaW5nIHRoaXMuIFdoZW4gSSBnZXQgeW91ciBzZXJp
ZXMsIG15IHNlcmllcyBpcyBjbG9zZSB0bwplbmQsIHNvIGp1c3QgcG9zdCBpdC4KCk15IDIvNSBp
cyBpZGVudGljYWwgdG8geW91ciA0LzQsIGFuZCBjYW4gYmUgZHJvcHBlZC4gTXkgNS81IGlzIHNp
bWlsYXIKdG8geW91ciAyLzQsIHdoaWNoIGNhbiBiZSBkcm9wcGVkIGVpdGhlci4KClRoZSBtYWlu
IGRpZmZlcmVuY2UgaXMgYWJvdXQgdGhlIGltYWdlIHByb2JlIG1ldGhvZC4gU2luY2UgdGhlCmlu
dHJvZHVjdGlvbiBvZiB6Ym9vdCBmb3JtYXQsIGl0IGlzIG5vdCBwcm9wZXIgYW55IG1vcmUgdG8g
Y2FsbCB0aGUKc2x1cnBfZGVjb21wcmVzc19maWxlKCkgZnVuY3Rpb24gb25jZSBiZWZvcmUgYXR0
ZW1wdGluZyB0byBjYWxsCnZhcmlvdXMgcG9zc2libGUgcHJvYmVzLiBTbyBteSBzZXJpZXMgc2Nh
dHRlcnMgdGhlCnNsdXJwX2RlY29tcHJlc3NfZmlsZSgpIGludG8gZWFjaCBwcm9iZSwgYW5kIHJl
dHVybiB0d28gZmFjdG9yczogdGhlCmtlcm5lbCBmZCB3aGljaCBpcyB1c2VkIGJ5IHN5c19rZXhl
Y19maWxlX2xvYWQgYW5kIHRoZSBwYXJzZWQga2VybmVsCmJ1Ziwgd2hpY2ggaXMgdXNlZCBsYXRl
ciBieSB0aGUgaW1hZ2UgcHJvYmUgZnVuY3Rpb24uCgpPbiBGcmksIE1heSA1LCAyMDIzIGF0IDEy
OjQ04oCvQU0gSmVyZW15IExpbnRvbiA8amVyZW15LmxpbnRvbkBhcm0uY29tPiB3cm90ZToKPgo+
IFRoZSBsaW51eCBaQk9PVCBvcHRpb24gY3JlYXRlcyBQRXMgdGhhdCBjb250YWluIGNvbXByZXNz
ZWQga2VybmVsIGltYWdlcwo+IHdoaWNoIGFyZSBzZWxmIGRlY29tcHJlc3NlZCBvbiBleGVjdXRp
b24gYnkgVUVGSS4KPgo+IFRoaXMgc2V0IGFkZHMgc3VwcG9ydCBmb3IgdGhpcyBpbWFnZSBmb3Jt
YXQgdG8ga2V4ZWMgYnkgZGVjb21wcmVzc2luZyB0aGUKPiBjb250YWluZWQga2VybmVsIGltYWdl
IHRvIGEgdGVtcCBmaWxlLCB0aGVuIGhhbmRpbmcgdGhlIHJlc3VsdGluZyBpbWFnZQo+IG9mZiB0
byB0aGUgZXhpc3RpbmcgIkltYWdlIiBsb2FkIHJvdXRpbmUgdG8gcGFzcyB0byB0aGUga2V4ZWMg
c3lzY2FsbC4KPgo+IFRoZXJlIGlzIGFsc28gYW4gYWRkaXRpb25hbCBwYXRjaCB3aGljaCBjbGVh
bnMgdXAgc29tZSBlcnJvcnMgbm90aWNlZAo+IGluIHRoZSBleGlzdGluZyB6SW1hZ2Ugc3VwcG9y
dCBhcyB3ZWxsLgo+Cj4gSmVyZW15IExpbnRvbiAoNCk6Cj4gICBhcm02NDogQ2xlYW51cCBfcHJv
YmUoKSByZXR1cm4gdmFsdWVzCj4gICBhcm02NDogQWRkIFpCT09UIFBFIGNvbnRhaW5pbmcgY29t
cHJlc3NlZCBpbWFnZSBzdXBwb3J0Cj4gICBhcm02NDogSG9vayB1cCB0aGUgWkJPT1Qgc3VwcG9y
dCBhcyB2bWxpbnV6Cj4gICBhcm02NDogRml4IHNvbWUgaXNzdWVzIHdpdGggekltYWdlIF9wcm9i
ZSgpCj4KPiAga2V4ZWMvYXJjaC9hcm02NC9NYWtlZmlsZSAgICAgICAgICAgICAgfCAgIDMgKy0K
PiAga2V4ZWMvYXJjaC9hcm02NC9pbWFnZS1oZWFkZXIuaCAgICAgICAgfCAgMTEgKysKPiAga2V4
ZWMvYXJjaC9hcm02NC9rZXhlYy1hcm02NC5jICAgICAgICAgfCAgIDcgKwo+ICBrZXhlYy9hcmNo
L2FybTY0L2tleGVjLWFybTY0LmggICAgICAgICB8ICAgMyArCj4gIGtleGVjL2FyY2gvYXJtNjQv
a2V4ZWMtZWxmLWFybTY0LmMgICAgIHwgICAxICsKPiAga2V4ZWMvYXJjaC9hcm02NC9rZXhlYy12
bWxpbnV6LWFybTY0LmMgfCAxNzIgKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICBrZXhlYy9h
cmNoL2FybTY0L2tleGVjLXpJbWFnZS1hcm02NC5jICB8ICAxMyArLQo+ICBrZXhlYy9rZXhlYy5j
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMSArLQo+ICA4IGZpbGVzIGNoYW5nZWQsIDIw
MSBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGtl
eGVjL2FyY2gvYXJtNjQva2V4ZWMtdm1saW51ei1hcm02NC5jCj4KPiAtLQo+IDIuNDAuMAo+Cj4K
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGtleGVj
IG1haWxpbmcgbGlzdAo+IGtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCj4KCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCg==
