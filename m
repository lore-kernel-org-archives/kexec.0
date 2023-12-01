Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFB9C4167B
	for <kexec@archiver.kernel.org>; Fri,  1 Dec 2023 00:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U70uipEf2VdAtvo6R32A9dbKSYnirtoV2oHshoPQSwg=; b=OsWGIZwoGf017M
	oHnHUcCD8S7/EmD/d+dxgVIMomt6MZIOeCiUBQgvcicyVWU1NXNczI2qnQCN2Ikhd1n49tk0VRXmU
	HkiD0dxWZ64L+rKCTQIgh/iCmf8FgP2B+Gnk9pfdwCKbFoQnbKLU96E0WwK6ZOTAbBYNAUZTklH/N
	TekvhJnka5iwbBpQ5rnQL6AwFE7h/dcdCbi6WivoefXhqKhBekidSAvQarhORvtee/bFuYDna9PoX
	B2nwp3+htB7cGGvI53hxB7aiAuXjlt2595OR2lNAUQCKUQuEDVY/vrah9bX2Tw/2oGjUb4/HKV7k4
	NNn84rejbhBhq92L7j6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8rni-00CIUQ-0G;
	Fri, 01 Dec 2023 00:54:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8rnf-00CITy-1b
	for kexec@lists.infradead.org;
	Fri, 01 Dec 2023 00:54:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701392073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YNA7ol50o+M8xPlYIHwLzfsOq0Ux1n/0WOxS3M7CEU=;
	b=PX+XK7V6DGcJc2XgJqMAVMP6UcUeV3tPTQrS3rA5vKsx/HxYtcfA/iq+wAHMWYEGigvedU
	DwD+jHGh+vBGWK/TNUR95RvykAZ6bLiZvWub0pZ8RpmAvb0ypR4b2lpIt8hkzo4IjGMzHb
	31tzh0UBKOkOOYdX9uGf6r03Yuefeo0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-Me14yrHwNPKm2SGNJzAuWQ-1; Thu, 30 Nov 2023 19:54:32 -0500
X-MC-Unique: Me14yrHwNPKm2SGNJzAuWQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5caf61210e3so23667767b3.0
        for <kexec@lists.infradead.org>; Thu, 30 Nov 2023 16:54:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701392072; x=1701996872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YNA7ol50o+M8xPlYIHwLzfsOq0Ux1n/0WOxS3M7CEU=;
        b=OhNwrEC1NYJreMVeErcNRk8vBP2UX6L17OrPLqt7WMdVIOXBbBVVdTxYcjHCK6GTYF
         PR/iKcQNCHyjoXfnue22Rtqu50qPwOIAocVtj8ivMEMIhv90K/z2AOmY7xWBXX3+qbSD
         0q/8gUjc84R72S5qT8ARFu0qbgYyx1itCEix4xe3dXnasUpbWVg1o17eGan7AjPMAMhz
         PW/2CF1sluemif9ZtfquAQt2qW5vCZmzNUH9jzW6Dm+C1LFfw7A4boiMySjuMDzs4fTh
         uglKAuVsVrqj/NWiSoeSp1uAJwN4ThNuvfit9HRtO/lOEdjQVouqVQa3UEyTlDQPwY2k
         3izw==
X-Gm-Message-State: AOJu0Yz4ybjoRDdCU2ycfihzgn+vyewXR/F8jilnmogp8fQofs+3qh6C
	XdXmznM6g6U2KBQT1mBwUhCMoz1rUjyL2peZk8ChFQPd9aEF1YMrB57a/LkXBmj64SppyFRNKmY
	DTLB6Ed2TPN1ayfyMZeODosO9qw4yjp3N1poh
X-Received: by 2002:a81:af5a:0:b0:5d3:f707:1b84 with SMTP id x26-20020a81af5a000000b005d3f7071b84mr758443ywj.5.1701392071779;
        Thu, 30 Nov 2023 16:54:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0AsPt60yeCWcZErjbPH3Tr+DPo1H+7VWNVgjo2QBMmGBpKlm1EvbTieVX5cZTxsl5r79oGZERX/wEswE4hjQ=
X-Received: by 2002:a81:af5a:0:b0:5d3:f707:1b84 with SMTP id
 x26-20020a81af5a000000b005d3f7071b84mr758437ywj.5.1701392071475; Thu, 30 Nov
 2023 16:54:31 -0800 (PST)
MIME-Version: 1.0
References: <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv> <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv> <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
 <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv> <ZWhg_b3O6piZtkQ-@tiehlicka>
 <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv> <ZWiOO-KNJ82f6Gxu@tiehlicka>
 <CAF+s44QSJL5e6BVTAyyHR9Kzx7RJqZSkR=uXEypaouK_XuBbEw@mail.gmail.com> <ZWiRbLGdBMO2jFGs@tiehlicka>
In-Reply-To: <ZWiRbLGdBMO2jFGs@tiehlicka>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 1 Dec 2023 08:54:20 +0800
Message-ID: <CAF+s44TQ2g6VTL4JSubvch5VkW7SSsePp-aBz+kigg563NijJg@mail.gmail.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
To: Michal Hocko <mhocko@suse.com>
Cc: Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>, Jiri Bohac <jbohac@suse.cz>, 
	Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231130_165435_637483_86186CB8 
X-CRM114-Status: GOOD (  42.33  )
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

T24gVGh1LCBOb3YgMzAsIDIwMjMgYXQgOTo0M+KAr1BNIE1pY2hhbCBIb2NrbyA8bWhvY2tvQHN1
c2UuY29tPiB3cm90ZToKPgo+IE9uIFRodSAzMC0xMS0yMyAyMTozMzowNCwgUGluZ2ZhbiBMaXUg
d3JvdGU6Cj4gPiBPbiBUaHUsIE5vdiAzMCwgMjAyMyBhdCA5OjI54oCvUE0gTWljaGFsIEhvY2tv
IDxtaG9ja29Ac3VzZS5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBUaHUgMzAtMTEtMjMgMjA6
MDQ6NTksIEJhb3F1YW4gSGUgd3JvdGU6Cj4gPiA+ID4gT24gMTEvMzAvMjMgYXQgMTE6MTZhbSwg
TWljaGFsIEhvY2tvIHdyb3RlOgo+ID4gPiA+ID4gT24gVGh1IDMwLTExLTIzIDExOjAwOjQ4LCBC
YW9xdWFuIEhlIHdyb3RlOgo+ID4gPiA+ID4gWy4uLl0KPiA+ID4gPiA+ID4gTm93LCB3ZSBhcmUg
d29ycmllZCBpZiB0aGVyZSdzIHJpc2sgaWYgdGhlIENNQSBhcmVhIGlzIHJldGFrZW4gaW50byBr
ZHVtcAo+ID4gPiA+ID4gPiBrZXJuZWwgYXMgc3lzdGVtIFJBTS4gRS5nIGlzIGl0IHBvc3NpYmxl
IHRoYXQgMXN0IGtlcm5lbCdzIG9uZ29pbmcgUkRNQQo+ID4gPiA+ID4gPiBvciBETUEgd2lsbCBp
bnRlcmZlcmUgd2l0aCBrZHVtcCBrZXJuZWwncyBub3JtYWwgbWVtb3J5IGFjY2Vzc2luZz8KPiA+
ID4gPiA+ID4gQmVjYXVzZSBrZHVtcCBrZXJuZWwgdXN1YWxseSBvbmx5IHJlc2V0IGFuZCBpbml0
aWFsaXplIHRoZSBuZWVkZWQKPiA+ID4gPiA+ID4gZGV2aWNlLCBlLmcgZHVtcCB0YXJnZXQuIFRo
b3NlIHVubmVlZGVkIGRldmljZXMgd2lsbCBiZSB1bnNodXRkb3duIGFuZAo+ID4gPiA+ID4gPiBs
ZXQgZ28uCj4gPiA+ID4gPgo+ID4gPiA+ID4gSSBkbyBub3QgcmVhbGx5IHdhbnQgdG8gZGlzY291
bnQgeW91ciBjb25jZXJucyBidXQgSSBhbSBiaXQgY29uZnVzZWQgd2h5Cj4gPiA+ID4gPiB0aGlz
IG1hdHRlcnMgc28gbXVjaC4gRmlyc3Qgb2YgYWxsLCBpZiB0aGVyZSBpcyBhIGJ1Z2d5IFJETUEg
ZHJpdmVyCj4gPiA+ID4gPiB3aGljaCBkb2Vzbid0IHVzZSB0aGUgcHJvcGVyIHBpbm5pbmcgQVBJ
ICh3aGljaCB3b3VsZCBtaWdyYXRlIGF3YXkgZnJvbQo+ID4gPiA+ID4gdGhlIENNQSkgdGhlbiB3
aGF0IGlzIHRoZSB3b3JzdCBjYXNlPyBXZSB3aWxsIGdldCBjcmFzaCBrZXJuZWwgY29ycnVwdGVk
Cj4gPiA+ID4gPiBwb3RlbnRpYWxseSBhbmQgZmFpbCB0byB0YWtlIGEgcHJvcGVyIGtlcm5lbCBj
cmFzaCwgcmlnaHQ/IElzIHRoaXMKPiA+ID4gPiA+IHdvcnJpc29tZT8gWWVzLiBJcyBpdCBhIHJl
YWwgcm9hZGJsb2NrPyBJIGRvIG5vdCB0aGluayBzby4gVGhlIHByb2JsZW0KPiA+ID4gPiA+IHNl
ZW1zIHRoZW9yZXRpY2FsIHRvIG1lIGFuZCBpdCBpcyBub3QgQ01BIHVzYWdlIGF0IGZhdWx0IGhl
cmUgSU1ITy4gSXQKPiA+ID4gPiA+IGlzIHRoZSBzYWlkIHRoZW9yZXRpY2FsIGRyaXZlciB0aGF0
IG5lZWRzIGZpeGluZyBhbnl3YXkuCj4gPiA+ID4gPgo+ID4gPiA+ID4gTm93LCBpdCBpcyByZWFs
bHkgZmFpciB0byBtZW50aW9uIHRoYXQgQ01BIGJhY2tlZCBjcmFzaCBrZXJuZWwgbWVtb3J5Cj4g
PiA+ID4gPiBoYXMgc29tZSBsaW1pdGF0aW9ucwo+ID4gPiA+ID4gICAgIC0gQ01BIHJlc2VydmF0
aW9uIGNhbiBvbmx5IGJlIHVzZWQgYnkgdGhlIHVzZXJzcGFjZSBpbiB0aGUKPiA+ID4gPiA+ICAg
ICAgIHByaW1hcnkga2VybmVsLiBJZiB0aGUgc2l6ZSBpcyBvdmVyc2hvdCB0aGlzIG1pZ2h0IGhh
dmUKPiA+ID4gPiA+ICAgICAgIG5lZ2F0aXZlIGltcGFjdCBvbiBrZXJuZWwgYWxsb2NhdGlvbnMK
PiA+ID4gPiA+ICAgICAtIHVzZXJzcGFjZSBtZW1vcnkgZHVtcGluZyBpbiB0aGUgY3Jhc2gga2Vy
bmVsIGlzIGZ1bmRhbWVudGFsbHkKPiA+ID4gPiA+ICAgICAgIGluY29tcGxldGUuCj4gPiA+ID4K
PiA+ID4gPiBJIGFtIG5vdCBzdXJlIGlmIHdlIGFyZSB0YWxraW5nIGFib3V0IHRoZSBzYW1lIHRo
aW5nLiBNeSBjb25jZXJuIGlzOgo+ID4gPiA+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4gPiA+ID4gMSkgc3lzdGVt
IGNvcnJ1dHB0aW9uIGhhcHBlbmVkLCBjcmFzaCBkdW1waW5nIGlzIHByZXBhcmVkLCBjcHUgYW5k
Cj4gPiA+ID4gaW50ZXJydXB0IGNvbnRyb2xsZXJzIGFyZSBzaHV0ZG93bjsKPiA+ID4gPiAyKSBh
bGwgcGNpIGRldmljZXMgYXJlIGtlcHQgYWxpdmU7Cj4gPiA+ID4gMykga2R1bXAga2VybmVsIGJv
b3QgdXAsIGluaXRpYWxpemF0aW9uIGlzIG9ubHkgZG9uZSBvbiB0aG9zZSBkZXZpY2VzCj4gPiA+
ID4gd2hpY2ggZHJpdmVycyBhcmUgYWRkZWQgaW50byBrZHVtcCBrZXJuZWwncyBpbml0cmQ7Cj4g
PiA+ID4gNCkgdGhvc2Ugb24tZmxpZ2h0IERNQSBlbmdpbmUgY291bGQgYmUgc3RpbGwgd29ya2lu
ZyBpZiB0aGVpciBrZXJuZWwKPiA+ID4gPiBtb2R1bGUgaXMgbm90IGxvYWRlZDsKPiA+ID4gPgo+
ID4gPiA+IEluIHRoaXMgY2FzZSwgaWYgdGhlIERNQSdzIGRlc3RpbmF0aW9uIGlzIGxvY2F0ZWQg
aW4gY3Jhc2hrZXJuZWw9LGNtYQo+ID4gPiA+IHJlZ2lvbiwgdGhlIERNQSB3cml0dGluZyBjb3Vs
ZCBjb250aW51ZSBldmVuIHdoZW4ga2R1bXAga2VybmVsIGhhcyBwdXQKPiA+ID4gPiBpbXBvcnRh
bnQga2VybmVsIGRhdGEgaW50byB0aGUgYXJlYS4gSXMgdGhpcyBwb3NzaWJsZSBvciBhYnNvbHV0
ZWx5IG5vdAo+ID4gPiA+IHBvc3NpYmxlIHdpdGggRE1BLCBSRE1BLCBvciBhbnkgb3RoZXIgc3R1
ZmYgd2hpY2ggY291bGQga2VlcCBhY2Nlc3NpbmcKPiA+ID4gPiB0aGF0IGFyZWE/Cj4gPiA+Cj4g
PiA+IEkgZG8gbnVkZXJzdGFuZCB5b3VyIGNvbmNlcm4uIEJ1dCBhcyBhbHJlYWR5IHN0YXRlZCBp
ZiBhbnlib2R5IHVzZXMKPiA+ID4gbW92YWJsZSBtZW1vcnkgKENNQSBpbmNsdWRpbmcpIGFzIGEg
dGFyZ2V0IG9mIHtSfURNQSB0aGVuIHRoYXQgbWVtb3J5Cj4gPiA+IHNob3VsZCBiZSBwcm9wZXJs
eSBwaW5uZWQuIFRoYXQgd291bGQgbWVhbiB0aGF0IHRoZSBtZW1vcnkgd2lsbCBiZQo+ID4gPiBt
aWdyYXRlZCB0byBzb21ld2hlcmUgb3V0c2lkZSBvZiBtb3ZhYmxlIChDTUEpIG1lbW9yeSBiZWZv
cmUgdGhlCj4gPiA+IHRyYW5zZmVyIGlzIGNvbmZpZ3VyZWQuIFNvIG1vZHVsbyBidWdzIHRoaXMg
c2hvdWxkbid0IHJlYWxseSBoYXBwZW4uCj4gPiA+IEFyZSB0aGVyZSB7Un1ETUEgZHJpdmVycyB0
aGF0IGRvIG5vdCBwaW4gbWVtb3J5IGNvcnJlY3RseT8gUG9zc2libHkuIElzCj4gPiA+IHRoYXQg
YSByb2FkIGJsb2FjayB0byBub3QgdXNpbmcgQ01BIHRvIGJhY2sgY3Jhc2gga2VybmVsIG1lbW9y
eSwgSSBkbwo+ID4gPiBub3QgdGhpbmsgc28uIFRob3NlIGRyaXZlcnMgc2hvdWxkIGJlIGZpeGVk
IGluc3RlYWQuCj4gPiA+Cj4gPiBJIHRoaW5rIHRoYXQgaXMgb3VyIGNvbmNlcm4uIElzIHRoZXJl
IGFueSBtZXRob2QgdG8gZ3VhcmFudGVlIHRoYXQKICAgICAgICAgICAgICAgICAgICAgICAgICAg
Xl5eIFNvcnJ5LCB0byBjbGFyaWZ5LCBJIGFtIG9ubHkgc3BlYWtpbmcgZm9yIG15c2VsZi4KCj4g
PiB3aWxsIG5vdCBoYXBwZW4gaW5zdGVhZCBvZiAnc2hvdWxkIGJlJyA/Cj4gPiBBbnkgc3RhdGlj
IGFuYWx5c2lzIGR1cmluZyBjb21waWxpbmcgdGltZSBvciBkeW5hbWljIGNoZWNraW5nIG1ldGhv
ZD8KPgo+IEkgYW0gbm90IGF3YXJlIG9mIGFueSBtZXRob2QgdG8gZGV0ZWN0IGEgZHJpdmVyIGlz
IGdvaW5nIHRvIGNvbmZpZ3VyZSBhCj4gUkRNQS4KPgoKSWYgdGhlcmUgaXMgYSBwYXR0ZXJuLCBz
Y3JpcHRzL2NvY2NpbmVsbGUgbWF5IGdpdmUgc29tZSBoZWxwLiBCdXQgSSBhbQpub3Qgc3VyZSBh
Ym91dCB0aGF0LgoKPiA+IElmIHRoaXMgY2FuIGJlIHJlc29sdmVkLCBJIHRoaW5rIHRoaXMgbWV0
aG9kIGlzIHByb21pc2luZy4KPgo+IEFyZSB5b3UgaW5kaWNhdGluZyB0aGlzIGlzIGEgbWFuZGF0
b3J5IHByZXJlcXVpc2l0ZT8KCklNSE8sIHRoYXQgc2hvdWxkIGJlIG1hbmRhdG9yeS4gT3RoZXJ3
aXNlIGZvciBhbnkgdW5leHBlY3RlZCBrZHVtcAprZXJuZWwgY29sbGFwc2VzLCAgaXQgY2FuIG5v
dCBzaGFrZSBvZmYgaXRzIHN1c3BpY2lvbi4KClRoYW5rcywKClBpbmdmYW4KCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QK
a2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2tleGVjCg==
