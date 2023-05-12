Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D688C7EE22
	for <kexec@archiver.kernel.org>; Fri, 12 May 2023 03:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RMjo86wfAByLS3i9DJzAj/mOjpbVEjXXhC2FxA0XOr4=; b=dGyXSvtelZSfAb
	VuN2VZ5yibVF4wevIqVv5qcv71S9TPPvb05yrrfVT1zN7qCwtTAeY3KsBe6hbC8l4ID6R+QEAfNo4
	YROA1xPLQk075YJMpNgniI4ulBoxcQmfSMgqL3tNTPtm1l97oseMQ/klLkEOxa0mdpdNkaue6PhDH
	zaD7MJaj95ysz5JuKO6dPrEK2Q99/4RXR8rtgZZl/nT4uAe3NjAD8Xo/FTDNB6+0RjmHfJwFbckoi
	Hesf/KsCJAaiUl8nc3MS25FvFip++i+JqOTcCsoyCvIcioIEnSFZdf8eWLmUsO4S96YBg6v0dMsbY
	OlsmBOZvmNYlJRhdDeHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxJBA-00AnQb-3A;
	Fri, 12 May 2023 03:10:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxJB5-00AnPn-19
	for kexec@lists.infradead.org;
	Fri, 12 May 2023 03:10:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683861041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOMJKTuYOls/a4zYIrSBZmD5M8/0t8m6+sP34X4IYwA=;
	b=BG1dDyI2FpJjj26xLwsAPS5fBqJyn21+QrXKOR+mzes7eqLeZ5JX4ZUHYVpNNwb6KBdFMj
	5TnN8Tftlv1jNkiy7FLgOqD7SOvyyugt6yJCs5y4uguhvu05Ub664gteQvwo5A15Q08V0o
	YdOACf+FB0tuTZ+DdRV2WpWJ56BGy5M=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-0fJcawBQPz6YPJr8FrEMoA-1; Thu, 11 May 2023 23:10:40 -0400
X-MC-Unique: 0fJcawBQPz6YPJr8FrEMoA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-61b7bb55ec2so53676556d6.1
        for <kexec@lists.infradead.org>; Thu, 11 May 2023 20:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683861040; x=1686453040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOMJKTuYOls/a4zYIrSBZmD5M8/0t8m6+sP34X4IYwA=;
        b=NTbYM6fteiHwPBYjqDrk3rkEJaO16p4AHEvGvPDss9zmMR/WbYBwUsKEZ/V0PZX44i
         WgX4yvMdUysTPgQe1i+zFKaVHTery1AI5u2SqqpsObz2Okf6FuUObkRlhjboT6endk+4
         72nk6c8J+XZhpRRX38qNyWyG2VD8+WrP47s6cUhtL5VJvmj0GS76IfXmVo/HW2gTUvDt
         843QIcf5LpHcNSxpOX2tJ4y6mknXow4dqsDpgSRJ7bx1NLgThGkLaULIwWA5z8epDuSb
         5BcMAUJRqcQJIdBbIcfSNwUcNhddWGH9dc1vVaMly3DUYKSrhenQiXcFG1n2eQk+kaBH
         5Mgg==
X-Gm-Message-State: AC+VfDz8b3F3XRWPVKzEYUZVBuCaGRPDzlgtm64mFsppKM3urezNQ73F
	OYjwVsFtKhpW97UT/SnmKiGjfmBzauTlwsJeYr503EmrZa+sYZHiIncLsZbrjNgXXAaUDenUCrZ
	2OYzk4pRPX+btt3k0WvYrGO3F0/Yc4CafNLQksRO4+kH2/q0=
X-Received: by 2002:a05:6214:19ef:b0:61b:79ab:7129 with SMTP id q15-20020a05621419ef00b0061b79ab7129mr36056010qvc.37.1683861039919;
        Thu, 11 May 2023 20:10:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6HlEgwl1z6EnYoc+cfS5sgxc2qvvYKi/V7EMRCfr+NqkYQbbjveA/5gQGSZL8DzhBLrZNlPCMnWUCUnHMgy2g=
X-Received: by 2002:a05:6214:19ef:b0:61b:79ab:7129 with SMTP id
 q15-20020a05621419ef00b0061b79ab7129mr36055989qvc.37.1683861039637; Thu, 11
 May 2023 20:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230505025438.11943-1-piliu@redhat.com>
In-Reply-To: <20230505025438.11943-1-piliu@redhat.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 12 May 2023 11:10:28 +0800
Message-ID: <CAF+s44ToFNcovqJL-ZiwsRWohMEW1iuKuuHWnvpUk46GR6TAhA@mail.gmail.com>
Subject: Re: [PATCH 0/5] arm64: zboot support
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, ardb@kernel.org, jeremy.linton@arm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_201043_490613_9B205F62 
X-CRM114-Status: GOOD (  22.68  )
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

SSBoYXZlIHJlYmFzZWQgSmVyZW15J3MgVjIgKHdoaWNoIGlzIG9mZi1saXN0KSBvbnRvIG15IG5l
dyBjb2RlLgoKVGhlIHdob2xlIHNlcmllcyBzaW5jZSBjb21taXQgYThkZTk0ZToKICBMb29uZ0Fy
Y2g6IGtkdW1wOiBTZXQgdXAga2VybmVsIGltYWdlIHNlZ21lbnQKaXMgYXZhaWxhYmxlIGluIHRo
ZSBHaXQgcmVwb3NpdG9yeQogIGF0IGh0dHBzOi8vZ2l0aHViLmNvbS9wZmxpdS9rZXhlYy10b29s
cy90cmVlL3pib290CnVwIHRvIHRoZSBoZWFkCgpJIGhhdmUgY29tcGlsZWQgaXQgb24geDg2XzY0
IGFuZCBhYXJjaDY0LCBhbmQgc3VjY2Vzc2Z1bGx5IGJvb3RlZCB0aGUKemJvb3QgaW1hZ2Ugb24g
YWFyY2g2NAoKQFNpbW9uLCBpcyB0aGVyZSBhbnkgaW5zdHJ1Y3Rpb24gdG8gZG8gdGhlIGNyb3Nz
LWJ1aWxkaW5nIGZvcgprZXhlYy10b29scywgc28gSSBjYW4gdmVyaWZ5IHRoZSBwYXR0ZXJuIHN1
YnN0aXR1dGlvbiB3b3JrcyB3ZWxsIG9uCm90aGVyIGFyY2hlcy4gSSB0aGluayBJIGNhbiBwb3N0
IGl0IHRvIHRoZSBsaXN0IHdpdGggYSBjb3Zlci1sZXR0ZXIKYWZ0ZXIgdmVyaWZpY2F0aW9uLgoK
VGhhbmtzLAoKUGluZ2ZhbgoKT24gRnJpLCBNYXkgNSwgMjAyMyBhdCAxMDo1NOKAr0FNIFBpbmdm
YW4gTGl1IDxwaWxpdUByZWRoYXQuY29tPiB3cm90ZToKPgo+IEFzIG1vcmUgY29tcGxpY2F0ZWQg
Y2Fwc3VsZSBrZXJuZWwgZm9ybWF0IG9jY3VycyBsaWtlIHpib290LCB3aGVyZSB0aGUKPiBjb21w
cmVzc2VkIGtlcm5lbCBpcyBzdG9yZWQgYXMgYSBwYXlsb2FkLiBUaGUgc3RyYWlnaHQgZm9yd2Fy
ZAo+IGRlY29tcHJlc3Npb24gY2FuIG5vdCBtZWV0IHRoZSBkZW1hbmQuCj4KPiBBcyB0aGUgZmly
c3Qgc3RlcCwgb24gYWFyY2g2NCwgcmVhZGluZyBpbiB0aGUga2VybmVsIGZpbGUgaW4gYSBwcm9i
ZQo+IG1ldGhvZCBhbmQgZGVjaWRlIGhvdyB0byB1bmZvbGQgdGhlIGNvbnRlbnQgYnkgdGhlIG1l
dGhvZCBpdHNlbGYuCj4KPiBUaGUgbmV3IGRlc2lnbmVkIHByb2JlIGludGVyZmFjZSByZXR1cm5z
IHR3byBmYWN0b3JzOgo+IDEuIHRoZSBwYXJzZWQga2VybmVsX2J1ZiBzaG91bGQgYmUgcmV0dXJu
ZWQgc28gdGhhdCBpdCBjYW4gYmUgdXNlZCBieQo+IHRoZSBpbWFnZSBsb2FkIG1ldGhvZCBsYXRl
ci4KPiAyLiB0aGUgZmluYWwgZmQgcGFzc2VkIHRvIHN5c19rZXhlY19maWxlX2xvYWQsIHNpbmNl
IGFhcmNoNjQga2VybmVsIGNhbgo+IG9ubHkgd29yayB3aXRoIEltYWdlIGZvcm1hdCwgdGhlIG91
dGVyIHBheWxvYWQgc2hvdWxkIGJlIHN0cmlwcGVkIGFuZCBhCj4gdGVtcG9yYXJ5IGZpbGUgb2Yg
SW1hZ2Ugc2hvdWxkIGJlIGNyZWF0ZWQuCj4KPgo+IFRvOiBrZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCj4gQ2M6IGhvcm1zQHZlcmdlLm5ldC5hdQo+IENjOiBhcmRiQGtlcm5lbC5vcmcKPiBDYzog
amVyZW15LmxpbnRvbkBhcm0uY29tCj4KPiBQaW5nZmFuIExpdSAoNSk6Cj4gICBrZXhlYzogQWRk
aW5nIG1pc3NpbmcgZnJlZSBmb3Iga2VybmVsX2J1Zgo+ICAgYXJtNjQvekltYWdlOiBSZW1vdmUg
dW5uZWNlc3NhcnkgYWxsb2NhdGlvbiBmb3IKPiAgICAga2VybmVsX3VuY29tcHJlc3NlZF9idWYK
PiAgIGFybTY0OiBjaGFuZ2UgdGhlIHByb3RvdHlwZSBvZiBpbWFnZSBwcm9iZSBmdW5jdGlvbgo+
ICAgYXJtNjQ6IFNjYXR0ZXIgdGhlIHJlYWRpbmcgb2Yga2VybmVsIGZpbGUgaW50byBlYWNoIHBy
b2JlCj4gICBhcm02NDogYWRkIHN1cHBvcnQgZm9yIHpib290IGltYWdlCj4KPiAga2V4ZWMvYXJj
aC9hcm0va2V4ZWMtYXJtLmggICAgICAgICAgICB8ICAgNCArLQo+ICBrZXhlYy9hcmNoL2FybS9r
ZXhlYy11SW1hZ2UtYXJtLmMgICAgIHwgICAyICstCj4gIGtleGVjL2FyY2gvYXJtNjQvTWFrZWZp
bGUgICAgICAgICAgICAgfCAgIDMgKy0KPiAga2V4ZWMvYXJjaC9hcm02NC9rZXhlYy1hcm02NC5j
ICAgICAgICB8ICAgMSArCj4gIGtleGVjL2FyY2gvYXJtNjQva2V4ZWMtYXJtNjQuaCAgICAgICAg
fCAgMTMgKy0KPiAga2V4ZWMvYXJjaC9hcm02NC9rZXhlYy1lbGYtYXJtNjQuYyAgICB8ICAgNyAr
LQo+ICBrZXhlYy9hcmNoL2FybTY0L2tleGVjLWltYWdlLWFybTY0LmMgIHwgICA2ICstCj4gIGtl
eGVjL2FyY2gvYXJtNjQva2V4ZWMtdUltYWdlLWFybTY0LmMgfCAgMTcgKy0KPiAga2V4ZWMvYXJj
aC9hcm02NC9rZXhlYy16SW1hZ2UtYXJtNjQuYyB8ICAyMyArLS0KPiAga2V4ZWMvYXJjaC9hcm02
NC9rZXhlYy16Ym9vdC1hcm02NC5jICB8IDI2MSArKysrKysrKysrKysrKysrKysrKysrKysrKwo+
ICBrZXhlYy9hcmNoL2FybTY0L3pib290LmggICAgICAgICAgICAgIHwgIDI2ICsrKwo+ICBrZXhl
Yy9rZXhlYy5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQ4ICsrKy0tCj4gIGtleGVjL2tl
eGVjLmggICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDggKwo+ICAxMyBmaWxlcyBjaGFuZ2Vk
LCAzNzcgaW5zZXJ0aW9ucygrKSwgNDIgZGVsZXRpb25zKC0pCj4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBrZXhlYy9hcmNoL2FybTY0L2tleGVjLXpib290LWFybTY0LmMKPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGtleGVjL2FyY2gvYXJtNjQvemJvb3QuaAo+Cj4gLS0KPiAyLjMxLjEKPgoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlz
dAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8va2V4ZWMK
