Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43B5C4167B
	for <kexec@archiver.kernel.org>; Thu, 30 Nov 2023 13:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MLVldD3zHcwTSytYVrVL0W4lGsIQCpvL76a86+L/UEk=; b=FV0De44tGOmomI
	wNtPB/GFyeWdYK0ZigWqMYejZ6wkbKko+Jx98VIg2Ql072XkvQ2j06a3H6QrtH3NpAcRy7XmFjI29
	1c0CwORQz/mtebl9wWddzj0oZbuISjt11qi97B7ANxkczqNVRXsKyYTEod/THIH244TJWvEpIGYB8
	ZZh2m+zEsQQ7Ge1r3WaeXhjrFUaAyM/uavgFgo993UyAJFg7VsdMehMeVwmTRkpLaHzkzViq9OL/+
	h81j7552f3fpyrbRww0GB8TqGBiTL24Vgi6NwxWajeDUBFMGg/V5Wm+A1pabYqx70+j+GXgtfZ/5i
	I+MvECqNhxNVd4lMfPFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8hAW-00AyKB-0F;
	Thu, 30 Nov 2023 13:33:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8hAS-00AyJa-30
	for kexec@lists.infradead.org;
	Thu, 30 Nov 2023 13:33:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701351200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIdax5nkZnwudivN9rSoOKpFOEYMEgv4l8J3J8z/rRE=;
	b=YhSnYaFRSD6S7wKuUzlnYLnRqigqTUzY4d2yDAYMwQsPJuZ0ZXVfUNGDITEgX7FztR0Ktk
	d0sicNYMdwh3C0YGae83pLceBJzfR3wiw2AQPRvJCDZENKER9LeIRjcnAEMBX/DNT1WNTA
	ddbCKwJ0G3KVTNcHjZCnkB9hjgylI/U=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-wfVAw87_Noiry0_jC4kkJA-1; Thu, 30 Nov 2023 08:33:16 -0500
X-MC-Unique: wfVAw87_Noiry0_jC4kkJA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5d0c4ba7081so16301227b3.0
        for <kexec@lists.infradead.org>; Thu, 30 Nov 2023 05:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701351196; x=1701955996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIdax5nkZnwudivN9rSoOKpFOEYMEgv4l8J3J8z/rRE=;
        b=dnqQR12gcJFSc4LnBkO1OV7k4Fwwi4LcU5GBB1kn0tMKqm69M3l2xTy9MnjEMjgolB
         0l34v2lElKgxQoyeh2YYlFdhDV/rL+30QJCTUaJMiVgatCZsZDyAvBi3zH7MCpXxuefS
         6zF/bsdAvJQMywUZQQCjy3CURXaCk4cf91Mx5yc1GwKOaoZodYTwOxncH9n9VDgj3w+f
         ZaMcXaRC9VypgLnKhqo2JSIZao/yVom/EnbTfDrJG/z8CuQmxRiFHfdOmEEn2BOqayu/
         Rdd8uT/ScmqR2K9Bp3lA5hRuinH5VF8xG1do+eqSU9k9RGb+mKa/XE0xLQ1Ocy4I4b0t
         7PQg==
X-Gm-Message-State: AOJu0YwG1DdjoOUG9d9axm8HLSaUPbjRmY22SDp+MSYtrEybN5zxG4aU
	KjzQMYLHU/DEab5SS9nIEayPv+TgRhuOPlowBy3A4mF9oUuTPow369jF5e+Uh28neJFGDUetQQI
	vjHiEVbT7Quk/yjtNLs8qjC9MBId/gXPFFrq/
X-Received: by 2002:a05:690c:26c5:b0:5ce:2148:d4cf with SMTP id eb5-20020a05690c26c500b005ce2148d4cfmr20665593ywb.7.1701351196236;
        Thu, 30 Nov 2023 05:33:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyHMfB1iLmJUS19oxGI8jchledMhy59y3Chc3JAP3cbaAu3Lb3Zgy8ugriUEexPf+OP5vCDjPkByF3Ed/Hc9I=
X-Received: by 2002:a05:690c:26c5:b0:5ce:2148:d4cf with SMTP id
 eb5-20020a05690c26c500b005ce2148d4cfmr20665576ywb.7.1701351195958; Thu, 30
 Nov 2023 05:33:15 -0800 (PST)
MIME-Version: 1.0
References: <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz> <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv> <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv> <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
 <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv> <ZWhg_b3O6piZtkQ-@tiehlicka>
 <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv> <ZWiOO-KNJ82f6Gxu@tiehlicka>
In-Reply-To: <ZWiOO-KNJ82f6Gxu@tiehlicka>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 30 Nov 2023 21:33:04 +0800
Message-ID: <CAF+s44QSJL5e6BVTAyyHR9Kzx7RJqZSkR=uXEypaouK_XuBbEw@mail.gmail.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
To: Michal Hocko <mhocko@suse.com>
Cc: Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>, Jiri Bohac <jbohac@suse.cz>, 
	Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231130_053325_063586_69BDA2D8 
X-CRM114-Status: GOOD (  37.03  )
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

T24gVGh1LCBOb3YgMzAsIDIwMjMgYXQgOToyOeKAr1BNIE1pY2hhbCBIb2NrbyA8bWhvY2tvQHN1
c2UuY29tPiB3cm90ZToKPgo+IE9uIFRodSAzMC0xMS0yMyAyMDowNDo1OSwgQmFvcXVhbiBIZSB3
cm90ZToKPiA+IE9uIDExLzMwLzIzIGF0IDExOjE2YW0sIE1pY2hhbCBIb2NrbyB3cm90ZToKPiA+
ID4gT24gVGh1IDMwLTExLTIzIDExOjAwOjQ4LCBCYW9xdWFuIEhlIHdyb3RlOgo+ID4gPiBbLi4u
XQo+ID4gPiA+IE5vdywgd2UgYXJlIHdvcnJpZWQgaWYgdGhlcmUncyByaXNrIGlmIHRoZSBDTUEg
YXJlYSBpcyByZXRha2VuIGludG8ga2R1bXAKPiA+ID4gPiBrZXJuZWwgYXMgc3lzdGVtIFJBTS4g
RS5nIGlzIGl0IHBvc3NpYmxlIHRoYXQgMXN0IGtlcm5lbCdzIG9uZ29pbmcgUkRNQQo+ID4gPiA+
IG9yIERNQSB3aWxsIGludGVyZmVyZSB3aXRoIGtkdW1wIGtlcm5lbCdzIG5vcm1hbCBtZW1vcnkg
YWNjZXNzaW5nPwo+ID4gPiA+IEJlY2F1c2Uga2R1bXAga2VybmVsIHVzdWFsbHkgb25seSByZXNl
dCBhbmQgaW5pdGlhbGl6ZSB0aGUgbmVlZGVkCj4gPiA+ID4gZGV2aWNlLCBlLmcgZHVtcCB0YXJn
ZXQuIFRob3NlIHVubmVlZGVkIGRldmljZXMgd2lsbCBiZSB1bnNodXRkb3duIGFuZAo+ID4gPiA+
IGxldCBnby4KPiA+ID4KPiA+ID4gSSBkbyBub3QgcmVhbGx5IHdhbnQgdG8gZGlzY291bnQgeW91
ciBjb25jZXJucyBidXQgSSBhbSBiaXQgY29uZnVzZWQgd2h5Cj4gPiA+IHRoaXMgbWF0dGVycyBz
byBtdWNoLiBGaXJzdCBvZiBhbGwsIGlmIHRoZXJlIGlzIGEgYnVnZ3kgUkRNQSBkcml2ZXIKPiA+
ID4gd2hpY2ggZG9lc24ndCB1c2UgdGhlIHByb3BlciBwaW5uaW5nIEFQSSAod2hpY2ggd291bGQg
bWlncmF0ZSBhd2F5IGZyb20KPiA+ID4gdGhlIENNQSkgdGhlbiB3aGF0IGlzIHRoZSB3b3JzdCBj
YXNlPyBXZSB3aWxsIGdldCBjcmFzaCBrZXJuZWwgY29ycnVwdGVkCj4gPiA+IHBvdGVudGlhbGx5
IGFuZCBmYWlsIHRvIHRha2UgYSBwcm9wZXIga2VybmVsIGNyYXNoLCByaWdodD8gSXMgdGhpcwo+
ID4gPiB3b3JyaXNvbWU/IFllcy4gSXMgaXQgYSByZWFsIHJvYWRibG9jaz8gSSBkbyBub3QgdGhp
bmsgc28uIFRoZSBwcm9ibGVtCj4gPiA+IHNlZW1zIHRoZW9yZXRpY2FsIHRvIG1lIGFuZCBpdCBp
cyBub3QgQ01BIHVzYWdlIGF0IGZhdWx0IGhlcmUgSU1ITy4gSXQKPiA+ID4gaXMgdGhlIHNhaWQg
dGhlb3JldGljYWwgZHJpdmVyIHRoYXQgbmVlZHMgZml4aW5nIGFueXdheS4KPiA+ID4KPiA+ID4g
Tm93LCBpdCBpcyByZWFsbHkgZmFpciB0byBtZW50aW9uIHRoYXQgQ01BIGJhY2tlZCBjcmFzaCBr
ZXJuZWwgbWVtb3J5Cj4gPiA+IGhhcyBzb21lIGxpbWl0YXRpb25zCj4gPiA+ICAgICAtIENNQSBy
ZXNlcnZhdGlvbiBjYW4gb25seSBiZSB1c2VkIGJ5IHRoZSB1c2Vyc3BhY2UgaW4gdGhlCj4gPiA+
ICAgICAgIHByaW1hcnkga2VybmVsLiBJZiB0aGUgc2l6ZSBpcyBvdmVyc2hvdCB0aGlzIG1pZ2h0
IGhhdmUKPiA+ID4gICAgICAgbmVnYXRpdmUgaW1wYWN0IG9uIGtlcm5lbCBhbGxvY2F0aW9ucwo+
ID4gPiAgICAgLSB1c2Vyc3BhY2UgbWVtb3J5IGR1bXBpbmcgaW4gdGhlIGNyYXNoIGtlcm5lbCBp
cyBmdW5kYW1lbnRhbGx5Cj4gPiA+ICAgICAgIGluY29tcGxldGUuCj4gPgo+ID4gSSBhbSBub3Qg
c3VyZSBpZiB3ZSBhcmUgdGFsa2luZyBhYm91dCB0aGUgc2FtZSB0aGluZy4gTXkgY29uY2VybiBp
czoKPiA+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09Cj4gPiAxKSBzeXN0ZW0gY29ycnV0cHRpb24gaGFwcGVuZWQsIGNy
YXNoIGR1bXBpbmcgaXMgcHJlcGFyZWQsIGNwdSBhbmQKPiA+IGludGVycnVwdCBjb250cm9sbGVy
cyBhcmUgc2h1dGRvd247Cj4gPiAyKSBhbGwgcGNpIGRldmljZXMgYXJlIGtlcHQgYWxpdmU7Cj4g
PiAzKSBrZHVtcCBrZXJuZWwgYm9vdCB1cCwgaW5pdGlhbGl6YXRpb24gaXMgb25seSBkb25lIG9u
IHRob3NlIGRldmljZXMKPiA+IHdoaWNoIGRyaXZlcnMgYXJlIGFkZGVkIGludG8ga2R1bXAga2Vy
bmVsJ3MgaW5pdHJkOwo+ID4gNCkgdGhvc2Ugb24tZmxpZ2h0IERNQSBlbmdpbmUgY291bGQgYmUg
c3RpbGwgd29ya2luZyBpZiB0aGVpciBrZXJuZWwKPiA+IG1vZHVsZSBpcyBub3QgbG9hZGVkOwo+
ID4KPiA+IEluIHRoaXMgY2FzZSwgaWYgdGhlIERNQSdzIGRlc3RpbmF0aW9uIGlzIGxvY2F0ZWQg
aW4gY3Jhc2hrZXJuZWw9LGNtYQo+ID4gcmVnaW9uLCB0aGUgRE1BIHdyaXR0aW5nIGNvdWxkIGNv
bnRpbnVlIGV2ZW4gd2hlbiBrZHVtcCBrZXJuZWwgaGFzIHB1dAo+ID4gaW1wb3J0YW50IGtlcm5l
bCBkYXRhIGludG8gdGhlIGFyZWEuIElzIHRoaXMgcG9zc2libGUgb3IgYWJzb2x1dGVseSBub3QK
PiA+IHBvc3NpYmxlIHdpdGggRE1BLCBSRE1BLCBvciBhbnkgb3RoZXIgc3R1ZmYgd2hpY2ggY291
bGQga2VlcCBhY2Nlc3NpbmcKPiA+IHRoYXQgYXJlYT8KPgo+IEkgZG8gbnVkZXJzdGFuZCB5b3Vy
IGNvbmNlcm4uIEJ1dCBhcyBhbHJlYWR5IHN0YXRlZCBpZiBhbnlib2R5IHVzZXMKPiBtb3ZhYmxl
IG1lbW9yeSAoQ01BIGluY2x1ZGluZykgYXMgYSB0YXJnZXQgb2Yge1J9RE1BIHRoZW4gdGhhdCBt
ZW1vcnkKPiBzaG91bGQgYmUgcHJvcGVybHkgcGlubmVkLiBUaGF0IHdvdWxkIG1lYW4gdGhhdCB0
aGUgbWVtb3J5IHdpbGwgYmUKPiBtaWdyYXRlZCB0byBzb21ld2hlcmUgb3V0c2lkZSBvZiBtb3Zh
YmxlIChDTUEpIG1lbW9yeSBiZWZvcmUgdGhlCj4gdHJhbnNmZXIgaXMgY29uZmlndXJlZC4gU28g
bW9kdWxvIGJ1Z3MgdGhpcyBzaG91bGRuJ3QgcmVhbGx5IGhhcHBlbi4KPiBBcmUgdGhlcmUge1J9
RE1BIGRyaXZlcnMgdGhhdCBkbyBub3QgcGluIG1lbW9yeSBjb3JyZWN0bHk/IFBvc3NpYmx5LiBJ
cwo+IHRoYXQgYSByb2FkIGJsb2FjayB0byBub3QgdXNpbmcgQ01BIHRvIGJhY2sgY3Jhc2gga2Vy
bmVsIG1lbW9yeSwgSSBkbwo+IG5vdCB0aGluayBzby4gVGhvc2UgZHJpdmVycyBzaG91bGQgYmUg
Zml4ZWQgaW5zdGVhZC4KPgpJIHRoaW5rIHRoYXQgaXMgb3VyIGNvbmNlcm4uIElzIHRoZXJlIGFu
eSBtZXRob2QgdG8gZ3VhcmFudGVlIHRoYXQKd2lsbCBub3QgaGFwcGVuIGluc3RlYWQgb2YgJ3No
b3VsZCBiZScgPwpBbnkgc3RhdGljIGFuYWx5c2lzIGR1cmluZyBjb21waWxpbmcgdGltZSBvciBk
eW5hbWljIGNoZWNraW5nIG1ldGhvZD8KCklmIHRoaXMgY2FuIGJlIHJlc29sdmVkLCBJIHRoaW5r
IHRoaXMgbWV0aG9kIGlzIHByb21pc2luZy4KClRoYW5rcywKClBpbmdmYW4KCj4gPiBUaGUgZXhp
c3RpbmcgY3Jhc2hrZXJuZWw9IHN5bnRheCBjYW4gZ3VyYW50ZWUgdGhlIHJlc2VydmVkIGNyYXNo
a2VybmVsCj4gPiBhcmVhIGZvciBrZHVtcCBrZXJuZWwgaXMgc2FmZS4KPgo+IEkgZG8gbm90IHRo
aW5rIHRoaXMgaXMgdHJ1ZS4gSWYgYSBETUEgaXMgbWlzY29uZmlndXJlZCBpdCBjYW4gc3RpbGwK
PiB0YXJnZXQgY3Jhc2gga2VybmVsIG1lbW9yeSBldmVuIGlmIGl0IGlzIG5vdCBtYXBwZWQgQUZB
SUNTLiBCdXQgdGhvc2UKPiBhcmUgdGhlb3JldGljYWxzLiBPciBhbSBJIG1pc3Npbmcgc29tZXRo
aW5nPwo+IC0tCj4gTWljaGFsIEhvY2tvCj4gU1VTRSBMYWJzCj4KCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCg==
