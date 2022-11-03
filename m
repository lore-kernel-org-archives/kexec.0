Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D862AC4332F
	for <kexec@archiver.kernel.org>; Thu,  3 Nov 2022 05:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c1BEJK4hwLcFzm9UaesqfilDrmGJNoQQkGmf9WhFLZY=; b=GgIc5GIM4z7M4f
	20cnj3f2PH9AlN2BO0eG5EVd1Zw6KYRgs9QagzI476P2TuD/4lPW8V940KVH5UZoj/FNmg1SOw4UM
	cj/B/wfJHmJI1yuQUwopv7tMpmg9OL/M1uZwIpWqlO4My8yIHBAQyQ6XqDEDpGLRndM+6YpRjusII
	NOXVIxoY919VxaZBDJQO2fJm8n7luBbyTD10+9bok7Vxv2v7rcmp7t9vXi6Yg9lm42eWTqVcVjewc
	zRRl9DmkBiSJyEZ4oxxSOH6KZ6OoAKB/7NwkJjvr8b98oGAUx1l90qvqh4UlnZ05yN9DP8BV9JXrv
	c4Rja/en5Yy/TteIvJEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqSqf-00GA9a-Kn; Thu, 03 Nov 2022 05:33:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqSqd-00GA7O-49
	for kexec@lists.infradead.org; Thu, 03 Nov 2022 05:33:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667453579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oo4WM0K9bb0VSgOPDM6MlrSqi62IWbFV4KcpoeMCcEk=;
	b=AtdB7MzAM6afG18DzGieSwllyH/myxwL17bspY0PW/XFbnJlmkbGpMjfUtEIsljFImEFyz
	2XAftYGU1Dl8lJ+Si5FeYhTCFdQOEi9AompQ8WXVEvr2SJfVIY0a/q4PjtVl1dbN2cnjQL
	AAqyE6kGLalQEWxlSMEBHIgYYqCWdJA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-597-vL9sR1bkO5meyMnB3UQItA-1; Thu, 03 Nov 2022 01:32:56 -0400
X-MC-Unique: vL9sR1bkO5meyMnB3UQItA-1
Received: by mail-ej1-f70.google.com with SMTP id hd11-20020a170907968b00b0078df60485fdso529865ejc.17
        for <kexec@lists.infradead.org>; Wed, 02 Nov 2022 22:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oo4WM0K9bb0VSgOPDM6MlrSqi62IWbFV4KcpoeMCcEk=;
        b=RJlW1/M15T03oRv3+MoxhESCz/+CDJpaT1cBZ0y4M/VHcYG3ENZXcPOgK1jZEflggj
         PiOjVFdRPM92GboN7uSJqpPW+yA8nEChKzM0Sda1VTpma+v4VG6hmelO6aNKUZjpke8v
         diBTjAG/rvnQIhv8iffxytNhYy+r7s2trzVIR5nferzJre5lI1P8kilEnF2n0WWWTp5K
         sVZApajB4puAzt67BK5srOJW8GzPBI/fXkUpyTR0zNDdSxx8Ud0xhlyyOcHNVi+pZU8w
         qoDjU2dzChWOFYfXac4kihyVaTaVGBfxmIXQJilWYNzA43PjOvsP/IYOKOsCFDsyVJfU
         mXvg==
X-Gm-Message-State: ACrzQf39awIUbpZAjnR12CwAVTbe2i7s+UUvlYF/Hk5A1qZRLPaC8mnh
	gj3agfl/xl07Z/O7tzgDsa5OpGZoRCbY1qpFUMjJeUApC4p0vxyMuUfPjmjyMM4+klxwA+qSJtz
	BIYxm+qw+mIzPETHLabXnTCUi7/TRT8tMlu1x
X-Received: by 2002:a17:906:c151:b0:78d:cdbc:9fb7 with SMTP id dp17-20020a170906c15100b0078dcdbc9fb7mr26335582ejc.688.1667453575252;
        Wed, 02 Nov 2022 22:32:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7NGXSYYlJV12JtmD4Pe4qUrTFJ3digjkNR08ZBNqWnWLB2AMWsOe9DiT7TwU+MAsDD9mjCfcTsqfzydGtQD8E=
X-Received: by 2002:a17:906:c151:b0:78d:cdbc:9fb7 with SMTP id
 dp17-20020a170906c15100b0078dcdbc9fb7mr26335572ejc.688.1667453575058; Wed, 02
 Nov 2022 22:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221020015014.46085-1-xianting.tian@linux.alibaba.com>
 <20221020015014.46085-2-xianting.tian@linux.alibaba.com> <4022d4a1-8967-3d09-e158-5a6f78f73655@nec.com>
 <4bccb5c9-6385-23d9-d496-65f9bd06beb2@linux.alibaba.com> <b5209fda-17c2-9271-c40e-1a0343a725a2@nec.com>
In-Reply-To: <b5209fda-17c2-9271-c40e-1a0343a725a2@nec.com>
From: lijiang <lijiang@redhat.com>
Date: Thu, 3 Nov 2022 13:32:43 +0800
Message-ID: <CANU+Zye-oDirOROVms1XODVunBf4rErQT1tGAY=62pZeufQUTw@mail.gmail.com>
Subject: Re: [Crash-utility][PATCH V4 1/9] Add RISCV64 framework code support
To: "crash-utility@redhat.com" <crash-utility@redhat.com>
Cc: Xianting Tian <xianting.tian@linux.alibaba.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"hschauhan@nulltrace.org" <hschauhan@nulltrace.org>, 
	"lifang_xia@linux.alibaba.com" <lifang_xia@linux.alibaba.com>, "mick@ics.forth.gr" <mick@ics.forth.gr>, 
	"heinrich.schuchardt@canonical.com" <heinrich.schuchardt@canonical.com>, "guoren@kernel.org" <guoren@kernel.org>, 
	"yixun.lan@gmail.com" <yixun.lan@gmail.com>, =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_223303_300780_F8306736 
X-CRM114-Status: GOOD (  19.97  )
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

T24gRnJpLCBPY3QgMjEsIDIwMjIgYXQgMTA6NTcgQU0gSEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA
5LiA5LuBKQo8ay1oYWdpby1hYkBuZWMuY29tPiB3cm90ZToKPgo+IE9uIDIwMjIvMTAvMjEgMTE6
NDIsIFhpYW50aW5nIFRpYW4gd3JvdGU6Cj4gPgo+ID4g5ZyoIDIwMjIvMTAvMjEg5LiK5Y2IMTA6
MTcsIEhBR0lPIEtBWlVISVRPKOiQqeWwviDkuIDku4EpIOWGmemBkzoKPiA+PiBPbiAyMDIyLzEw
LzIwIDEwOjUwLCBYaWFudGluZyBUaWFuIHdyb3RlOgo+ID4+Cj4gPj4+IGRpZmYgLS1naXQgYS9S
RUFETUUgYi9SRUFETUUKPiA+Pj4gaW5kZXggNWFiYmNlMS4uZDU4OWU3MiAxMDA2NDQKPiA+Pj4g
LS0tIGEvUkVBRE1FCj4gPj4+ICsrKyBiL1JFQURNRQo+ID4+PiBAQCAtMzcsNyArMzcsNyBAQAo+
ID4+PiAgICAgIFRoZXNlIGFyZSB0aGUgY3VycmVudCBwcmVyZXF1aXNpdGVzOgo+ID4+PiAgICAg
IG8gIEF0IHRoaXMgcG9pbnQsIHg4NiwgaWE2NCwgeDg2XzY0LCBwcGM2NCwgcHBjLCBhcm0sIGFy
bTY0LCBhbHBoYSwgbWlwcywKPiA+Pj4gLSAgICAgbWlwczY0LCBzMzkwIGFuZCBzMzkweC1iYXNl
ZCBrZXJuZWxzIGFyZSBzdXBwb3J0ZWQuICBPdGhlciBhcmNoaXRlY3R1cmVzCj4gPj4+ICsgICAg
IG1pcHM2NCwgcmlzY3Y2NCwgczM5MCBhbmQgczM5MHgtYmFzZWQga2VybmVscyBhcmUgc3VwcG9y
dGVkLiAgT3RoZXIgYXJjaGl0ZWN0dXJlcwo+ID4+PiAgICAgICAgIG1heSBiZSBhZGRyZXNzZWQg
aW4gdGhlIGZ1dHVyZS4KPiA+PiBTZW50ZW5jZXMgaW4gdGhlIFJFQURNRSBhcmUgd3JhcHBlZCB3
aXRoaW4gODAgY2hhcmFjdGVycywgSSB3aWxsIGNoYW5nZQo+ID4KPiA+IHRoYW5rcywKPiA+Cj4g
PiBEbyB5b3UgbmVlZCBtZSB0byBzZW5kIFY1IHBhdGNoIHNldCB0byBmaXggdGhpcz8KPgo+IE5v
LCBJIHdpbGwgYW1lbmQgdGhlc2Ugd2hlbiBhcHBseWluZy4KPgoKT24gdGhlIGtlcm5lbCBzaWRl
LCBzb21lIHJlbGV2YW50IGtlcm5lbCBwYXRjaGVzIGdvdCBhY2ssICBpdCBzZWVtcwp0aGV5IHdv
bid0ICBjaGFuZ2UgYW55bW9yZS4KCkFuZCB0aGUgVjQgbG9va3MgZ29vZCB0byBtZSwgc286IEFj
ay4KClRoYW5rcy4KTGlhbmJvCgo+IFRoYW5rcywKPiBLYXp1Cj4KPiA+Cj4gPj4gdGhpcyB0bzoK
PiA+Pgo+ID4+ICsgICAgIG1pcHM2NCwgcmlzY3Y2NCwgczM5MCBhbmQgczM5MHgtYmFzZWQga2Vy
bmVscyBhcmUgc3VwcG9ydGVkLiAgT3RoZXIKPiA+PiArICAgICBhcmNoaXRlY3R1cmVzIG1heSBi
ZSBhZGRyZXNzZWQgaW4gdGhlIGZ1dHVyZS4KPiA+Pgo+ID4+PiAgICAgIG8gIE9uZSBzaXplIGZp
dHMgYWxsIC0tIHRoZSB1dGlsaXR5IGNhbiBiZSBydW4gb24gYW55IExpbnV4IGtlcm5lbCB2ZXJz
aW9uCj4gPj4+IEBAIC05OCw2ICs5OCw4IEBACj4gPj4+ICAgICAgICAgYXJtNjQgZHVtcGZpbGVz
IG1heSBiZSBidWlsdCBieSB0eXBpbmcgIm1ha2UgdGFyZ2V0PUFSTTY0Ii4KPiA+Pj4gICAgICBv
ICBPbiBhbiB4ODZfNjQgaG9zdCwgYW4geDg2XzY0IGJpbmFyeSB0aGF0IGNhbiBiZSB1c2VkIHRv
IGFuYWx5emUKPiA+Pj4gICAgICAgICBwcGM2NGxlIGR1bXBmaWxlcyBtYXkgYmUgYnVpbHQgYnkg
dHlwaW5nICJtYWtlIHRhcmdldD1QUEM2NCIuCj4gPj4+ICsgIG8gIE9uIGFuIHg4Nl82NCBob3N0
LCBhbiB4ODZfNjQgYmluYXJ5IHRoYXQgY2FuIGJlIHVzZWQgdG8gYW5hbHl6ZQo+ID4+PiArICAg
ICByaXNjdjY0IGR1bXBmaWxlcyBtYXkgYmUgYnVpbHQgYnkgdHlwaW5nICJtYWtlIHRhcmdldD1S
SVNDVjY0Ii4KPiA+Pj4gICAgICBUcmFkaXRpb25hbGx5IHdoZW4gdm1jb3JlcyBhcmUgY29tcHJl
c3NlZCB2aWEgdGhlIG1ha2VkdW1wZmlsZSg4KSBmYWNpbGl0eQo+ID4+PiAgICAgIHRoZSBsaWJ6
IGNvbXByZXNzaW9uIGxpYnJhcnkgaXMgdXNlZCwgYW5kIGJ5IGRlZmF1bHQgdGhlIGNyYXNoIHV0
aWxpdHkKPiA+Pgo+ID4+PiBkaWZmIC0tZ2l0IGEvaGVscC5jIGIvaGVscC5jCj4gPj4+IGluZGV4
IDk5MjE0YzEuLjI1M2M3MWIgMTAwNjQ0Cj4gPj4+IC0tLSBhL2hlbHAuYwo+ID4+PiArKysgYi9o
ZWxwLmMKPiA+Pj4gQEAgLTk1MTIsNyArOTUxMiw3IEBAIGNoYXIgKlJFQURNRVtdID0gewo+ID4+
PiAgICAiICBUaGVzZSBhcmUgdGhlIGN1cnJlbnQgcHJlcmVxdWlzaXRlczogIiwKPiA+Pj4gICAg
IiIsCj4gPj4+ICAgICIgIG8gIEF0IHRoaXMgcG9pbnQsIHg4NiwgaWE2NCwgeDg2XzY0LCBwcGM2
NCwgcHBjLCBhcm0sIGFybTY0LCBhbHBoYSwgbWlwcywiLAo+ID4+PiAtIiAgICAgbWlwczY0LCBz
MzkwIGFuZCBzMzkweC1iYXNlZCBrZXJuZWxzIGFyZSBzdXBwb3J0ZWQuICBPdGhlciBhcmNoaXRl
Y3R1cmVzIiwKPiA+Pj4gKyIgICAgIG1pcHM2NCwgcmlzY3Y2NCwgczM5MCBhbmQgczM5MHgtYmFz
ZWQga2VybmVscyBhcmUgc3VwcG9ydGVkLiAgT3RoZXIgYXJjaGl0ZWN0dXJlcyIsCj4gPj4+ICAg
ICIgICAgIG1heSBiZSBhZGRyZXNzZWQgaW4gdGhlIGZ1dHVyZS4iLAo+ID4+PiAgICAiIiwKPiA+
Pj4gICAgIiAgbyAgT25lIHNpemUgZml0cyBhbGwgLS0gdGhlIHV0aWxpdHkgY2FuIGJlIHJ1biBv
biBhbnkgTGludXgga2VybmVsIHZlcnNpb24iLAo+ID4+IFNhbWUgYXMgYWJvdmUuCj4gPj4KPiA+
PiBBbmQgaGVscC5jIGxhY2tzIHRoaXMgcGFydCwgd2lsbCBhZGQ6Cj4gPj4KPiA+PiBAQCAtOTU3
Miw2ICs5NTcyLDggQEAgUkVBRE1FX0VOVEVSX0RJUkVDVE9SWSwKPiA+PiAgICAiICAgICBhcm02
NCBkdW1wZmlsZXMgbWF5IGJlIGJ1aWx0IGJ5IHR5cGluZyBcIm1ha2UgdGFyZ2V0PUFSTTY0XCIu
IiwKPiA+PiAgICAiICBvICBPbiBhbiB4ODZfNjQgaG9zdCwgYW4geDg2XzY0IGJpbmFyeSB0aGF0
IGNhbiBiZSB1c2VkIHRvIGFuYWx5emUiLAo+ID4+ICAgICIgICAgIHBwYzY0bGUgZHVtcGZpbGVz
IG1heSBiZSBidWlsdCBieSB0eXBpbmcgXCJtYWtlIHRhcmdldD1QUEM2NFwiLiIsCj4gPj4gKyIg
IG8gIE9uIGFuIHg4Nl82NCBob3N0LCBhbiB4ODZfNjQgYmluYXJ5IHRoYXQgY2FuIGJlIHVzZWQg
dG8gYW5hbHl6ZSIsCj4gPj4gKyIgICAgIHJpc2N2NjQgZHVtcGZpbGVzIG1heSBiZSBidWlsdCBi
eSB0eXBpbmcgXCJtYWtlIHRhcmdldD1SSVNDVjY0XCIuIiwKPiA+PiAgICAiIiwKPiA+PiAgICAi
ICBUcmFkaXRpb25hbGx5IHdoZW4gdm1jb3JlcyBhcmUgY29tcHJlc3NlZCB2aWEgdGhlIG1ha2Vk
dW1wZmlsZSg4KSBmYWNpbGl0eSIsCj4gPj4gICAgIiAgdGhlIGxpYnogY29tcHJlc3Npb24gbGli
cmFyeSBpcyB1c2VkLCBhbmQgYnkgZGVmYXVsdCB0aGUgY3Jhc2ggdXRpbGl0eSIsCj4gPj4KPiA+
Pgo+ID4+IFdpdGggdGhlc2UsIHRoZSB2NCBjcmFzaCBwYXRjaCBzZXQgbG9va3MgZ29vZCB0byBt
ZS4KPiA+Pgo+ID4+IEFja2VkLWJ5OiBLYXp1aGl0byBIYWdpbyA8ay1oYWdpby1hYkBuZWMuY29t
Pgo+ID4+Cj4gPj4gVGhhbmtzLAo+ID4+IEthenUKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCg==
