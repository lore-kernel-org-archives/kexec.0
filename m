Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405A8C3DA59
	for <kexec@archiver.kernel.org>; Sat, 20 Jul 2024 07:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KIesEgT4EpZ3SP8JtzzgFVq6CarD9LkiI5bqV11SS5M=; b=IlJUC9hY5hnWig
	Gw4DxwYGFa6HxC7dMqgUgnq+9bTwofLHKhSo+tjs8eiGjqpaC5Ph3aFK3teIpARFFtfKWw6iuBhmV
	bcbW2dUjnVcg78H7P9eAvFEayl7lCGqiSW9tj8G2i7EhL3XpaL92riB237j3AbuGeX6EkhY9aFLap
	31yRE0x+q3B85vXDTZRbALbzprmQkP3JpcTDCA9TdtiHMoIBd0J4kXLzcKKtEKv8YQrisg9y4yxl9
	u4JKlEfDK4Cob8bo/Tm1HCNrcDvK5fT/Of+pHVjlA5I0tt14e4ZoMSh+xUiNUSyhECbkTjomsm5fD
	nXIaca0Ehae3glQdHo/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sV4gC-00000004hB7-1aWC;
	Sat, 20 Jul 2024 07:38:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sV4g9-00000004hAT-2Qry
	for kexec@lists.infradead.org;
	Sat, 20 Jul 2024 07:38:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721461130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gtJlNSO/VlVav+0eSeE5Nn2CqkE4RoB1EsIegq+Yd+Y=;
	b=acJHVayH437EG5oytPgcKHQyalDgXptHhUs6trs61g8IfldgEi/QolhXn5pQWrFBNzT9fu
	p6HJwnudnara6MvDaGBtlZZt4jWO0gYnKzipdVmgz/5K/UAePAiXmRuCZ/e/ktLPqKiBGV
	fJgpkqQI8uiboSzh+jHhG9d6ugYEnl8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-spJnEiRcN_auDpS7XyeWXw-1; Sat, 20 Jul 2024 03:38:48 -0400
X-MC-Unique: spJnEiRcN_auDpS7XyeWXw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2cb4c2276b6so2208684a91.1
        for <kexec@lists.infradead.org>; Sat, 20 Jul 2024 00:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721461127; x=1722065927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtJlNSO/VlVav+0eSeE5Nn2CqkE4RoB1EsIegq+Yd+Y=;
        b=qYJqs2qtL8MleOUlDV5otFeuxcLVFPB07h9MENHzGbJXh//nK3T0AW9Y6sHhozT0Jh
         X5sdbGPHYcdFjG1GjLzC6kQyUylJmQI/ru+Sox5pPiXwBHuTEcOb15C2sPzLhgja+STM
         XV1Dgl8uiOR8+l4yIWvo1Ky2pWWkj2MA8+EdKzAgA1pKbkugpVIgeOfd5T4A/qMQPvT+
         wIw03Bzapgz6mfXSKkfnK4gUmfZ7DuCqes/dETBrDlfZBPEGRJrF8RfDQ2TFOAa+08YD
         Mt30N2c15KkO+SD58s+0GU3FBw1YaXBlzL1T0eSOSaWePa6p95jgygAN4W9cdWiJcpWt
         fV2w==
X-Gm-Message-State: AOJu0YzdWsgGfx3nkqlrlXqQ3K9e1bxbcXPKyZXHBvNG2YItdFFLdaeS
	Aj7zH3r2LgUNgYbFQG7UmkvN8K739WYSSkdSAaGpL73RZwXknXghsUS/n2CqnM2vTP61ZoLfDUr
	p7WT4TwfB9v2nZW6Ucizr3UUpQ9xxa1yq8nQL076zuGKy5dUYLzpRJ1OKjAUZIIraRp7xarIz/q
	KLoZVEEjwYGQMlo9jFV9NwsGzQ8lWKfrTDKO6fXZGMYko=
X-Received: by 2002:a05:6a21:338b:b0:1c0:f216:7f20 with SMTP id adf61e73a8af0-1c42867920emr671247637.49.1721461126920;
        Sat, 20 Jul 2024 00:38:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDFJThysIbMR30X2f++5bDifKfG/V6G9LGs6R8GpVOWMOuf6qzfMWbQI9P9rSvYUc+hIbM37pFEJ76fRs0FRs=
X-Received: by 2002:a05:6a21:338b:b0:1c0:f216:7f20 with SMTP id
 adf61e73a8af0-1c42867920emr671241637.49.1721461126586; Sat, 20 Jul 2024
 00:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240625015712.3266086-1-lichliu@redhat.com> <bcdaf3b8-599d-4af1-af92-188e4072d143@nec.com>
In-Reply-To: <bcdaf3b8-599d-4af1-af92-188e4072d143@nec.com>
From: Lichen Liu <lichliu@redhat.com>
Date: Sat, 20 Jul 2024 15:38:35 +0800
Message-ID: <CAPmSd0Pd3afnTZGog3pXEY_mh093WDW27HJLUGN2QYDwk8RHyQ@mail.gmail.com>
Subject: Re: [PATCH] makedumpfile: call initial before use cache
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240720_003853_719302_E9A6C669 
X-CRM114-Status: GOOD (  29.42  )
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

VGhhbmtzIGZvciB5b3VyIGV4cGxhbmF0aW9uIQoKCk9uIFdlZCwgSnVsIDE3LCAyMDI0IGF0IDM6
NDTigK9QTSBIQUdJTyBLQVpVSElUTyjokKnlsL7jgIDkuIDku4EpCjxrLWhhZ2lvLWFiQG5lYy5j
b20+IHdyb3RlOgo+Cj4gSGkgTGljaGVuLAo+Cj4gc29ycnkgZm9yIHRoZSBsb25nIGRlbGF5Lgo+
Cj4gT24gMjAyNC8wNi8yNSAxMDo1NywgTGljaGVuIExpdSB3cm90ZToKPiA+IFJ1biAnbWFrZWR1
bXBmaWxlIC0tbWVtLXVzYWdlIC9wcm9jL2tjb3JlJyB3aWxsIGNvcmVkdW1wIG9uIHBwYzY0LCBp
dCBpcwo+ID4gYmVjYXVzZSBzaG93X21lbV91c2FnZSgpLT5nZXRfcGFnZV9vZmZzZXQoKS0+Z2V0
X3ZlcnNpb25kZXBfaW5mb19wcGM2NCgpCj4gPiAtPnJlYWRtZW0oKSB1c2UgY2FjaGUgYmVmb3Jl
IGl0IGlzIGluaXRlZCBieSBpbml0aWFsKCkuCj4gPgo+ID4gQ3VycmVudGx5IG9ubHkgcHBjNjQg
aGFzIHRoaXMgaXNzdWUgYmVjYXVzZSBvbmx5Cj4gPiBnZXRfdmVyc2lvbmRlcF9pbmZvX3BwYzY0
KCkgY2FsbCByZWFkbWVtKCkuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogTGljaGVuIExpdSA8bGlj
aGxpdUByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiAgIG1ha2VkdW1wZmlsZS5jIHwgNiArKystLS0K
PiA+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiA+
Cj4gPiBkaWZmIC0tZ2l0IGEvbWFrZWR1bXBmaWxlLmMgYi9tYWtlZHVtcGZpbGUuYwo+ID4gaW5k
ZXggNWIzNDcxMi4uNmE0MjI2NCAxMDA2NDQKPiA+IC0tLSBhL21ha2VkdW1wZmlsZS5jCj4gPiAr
KysgYi9tYWtlZHVtcGZpbGUuYwo+ID4gQEAgLTEyMDE5LDYgKzEyMDE5LDkgQEAgaW50IHNob3df
bWVtX3VzYWdlKHZvaWQpCj4gPiAgICAgICAgICAgICAgIERFQlVHX01TRygiUmVhZCB2bWNvcmVp
bmZvIGZyb20gTk9URSBzZWdtZW50OiAlZFxuIiwgdm1jb3JlaW5mbyk7Cj4gPiAgICAgICB9Cj4g
Pgo+ID4gKyAgICAgaWYgKCFpbml0aWFsKCkpCj4gPiArICAgICAgICAgICAgIHJldHVybiBGQUxT
RTsKPiA+ICsKPiA+ICAgICAgIGlmICghZ2V0X3BhZ2Vfb2Zmc2V0KCkpCj4gPiAgICAgICAgICAg
ICAgIHJldHVybiBGQUxTRTsKPiA+Cj4gPiBAQCAtMTIwMzQsOSArMTIwMzcsNiBAQCBpbnQgc2hv
d19tZW1fdXNhZ2Uodm9pZCkKPiA+ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gRkFMU0U7
Cj4gPiAgICAgICB9Cj4gPgo+ID4gLSAgICAgaWYgKCFpbml0aWFsKCkpCj4gPiAtICAgICAgICAg
ICAgIHJldHVybiBGQUxTRTsKPiA+IC0KPiA+ICAgICAgIGlmICghb3Blbl9kdW1wX2JpdG1hcCgp
KQo+ID4gICAgICAgICAgICAgICByZXR1cm4gRkFMU0U7Cj4gPgo+Cj4gaW5pdGlhbCgpIG5lZWRz
IHRvIGJlIGNhbGxlZCBhZnRlciBzZXRfa2NvcmVfdm1jb3JlaW5mbygpLCB3aGVuIHRoZXJlIGlz
Cj4gbm8gdm1jb3JlaW5mbyBpbiAvcHJvYy9rY29yZSBFTEYgbm90ZS4KPgo+IFNvIHdpdGggdGhl
IHBhdGNoLCAibWFrZWR1bXBmaWxlIC0tbWVtLXVzYWdlIiBmYWlscyBvbiBrZXJuZWxzIHRoYXQg
ZG8KPiBub3QgaGF2ZSBhIHZtY29yZWluZm8gaW4gRUxGIG5vdGUsIGUuZy4gUkhFTDcga2VybmVs
Ogo+Cj4gICAgIyBtYWtlZHVtcGZpbGUtZGV2IC1mIC0tbWVtLXVzYWdlIC9wcm9jL2tjb3JlCj4g
ICAgZXhjbHVkZV9mcmVlX3BhZ2U6IENhbid0IGdldCBuZWNlc3Nhcnkgc3ltYm9scyBmb3IgZXhj
bHVkaW5nIGZyZWUgcGFnZXMuCj4KPiAgICBtYWtlZHVtcGZpbGUgRmFpbGVkLgo+Cj4KPiBQcm9i
YWJseSByZWFkbWVtKCkgc2hvdWxkIG5vdCBiZSBjYWxsZWQgYmVmb3JlIGluaXRpYWwoKSBpbiB0
aGUgZmlyc3QKPiBwbGFjZS4gIEkgdGhpbmsgaXQncyB0aGUgcm9vdCBjYXVzZSwgYnV0IEknbSBu
b3Qgc3VyZSBob3cgd2UgY2FuIGZpeCBpdC4KPgo+IEEgd29ya2Fyb3VuZCBJIHRob3VnaHQgb2Yg
aXMgdGhhdCBtb3ZpbmcgZ2V0X3BhZ2Vfb2Zmc2V0KCkgYW5kCj4gZ2V0X3BoeXNfYmFzZSgpIGlu
dG8gdGhlICF2bWNvcmVpbmZvIGJsb2NrLiAgVGhlc2UgYXJlIG5lZWRlZCBieQo+IHNldF9rY29y
ZV92bWNvcmVpbmZvKCksIHNvIHdlIGNhbiBhdm9pZCBjYWxsaW5nIHRoZW0gaWYgdGhlcmUgaXMg
YQo+IHZtY29yZWluZm8gaW4gRUxGIG5vdGU6Cj4KPiAtLS0gYS9tYWtlZHVtcGZpbGUuYwo+ICsr
KyBiL21ha2VkdW1wZmlsZS5jCj4gQEAgLTEyMDE5LDE0ICsxMjAxOSwxNCBAQCBpbnQgc2hvd19t
ZW1fdXNhZ2Uodm9pZCkKPiAgICAgICAgICAgICAgICAgIERFQlVHX01TRygiUmVhZCB2bWNvcmVp
bmZvIGZyb20gTk9URSBzZWdtZW50OiAlZFxuIiwKPiB2bWNvcmVpbmZvKTsKPiAgICAgICAgICB9
Cj4KPiAtICAgICAgIGlmICghZ2V0X3BhZ2Vfb2Zmc2V0KCkpCj4gLSAgICAgICAgICAgICAgIHJl
dHVybiBGQUxTRTsKPiArICAgICAgIGlmICghdm1jb3JlaW5mbykgewo+ICsgICAgICAgICAgICAg
ICBpZiAoIWdldF9wYWdlX29mZnNldCgpKQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biBGQUxTRTsKPgo+IC0gICAgICAgLyogcGFkZHJfdG9fdmFkZHIoKSBvbiBhcm02NCBuZWVkcyBw
aHlzX2Jhc2UuICovCj4gLSAgICAgICBpZiAoIWdldF9waHlzX2Jhc2UoKSkKPiAtICAgICAgICAg
ICAgICAgcmV0dXJuIEZBTFNFOwo+ICsgICAgICAgICAgICAgICAvKiBwYWRkcl90b192YWRkcigp
IG9uIGFybTY0IG5lZWRzIHBoeXNfYmFzZS4gKi8KPiArICAgICAgICAgICAgICAgaWYgKCFnZXRf
cGh5c19iYXNlKCkpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIEZBTFNFOwo+Cj4g
LSAgICAgICBpZiAoIXZtY29yZWluZm8pIHsKPiAgICAgICAgICAgICAgICAgIGlmICghZ2V0X3N5
c19rZXJuZWxfdm1jb3JlaW5mbygmdm1jb3JlaW5mb19hZGRyLAo+ICZ2bWNvcmVpbmZvX2xlbikp
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBGQUxTRTsKPgo+Cj4gVGhpcyB3aWxs
IHdvcmsgb25seSBmb3IgNC4xOSBhbmQgbGF0ZXIga2VybmVscywgYnV0IG1pZ2h0IHJlZHVjZSB1
c2Vycwo+IHRoYXQgaGl0IHRoZSBpc3N1ZS4gIERvZXMgdGhpcyB3b3JrIGZvciB5b3U/ClRoYXQg
d29ya3MgZm9yIG1lIGJlY2F1c2UgSSdtIHRlc3RpbmcgZm9yIHRoZSA2Lngga2VybmVsLgoKVGhh
bmtzLApMaWNoZW4KPgo+IFRoYW5rcywKPiBLYXp1CgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9r
ZXhlYwo=
