Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7DBEB64D9
	for <kexec@archiver.kernel.org>; Fri,  7 Jul 2023 03:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uopw8Q1zUD172jYTUnTW8LERG8Aq3bt2LJ66u5OgCR8=; b=UkSLPoBvy4JGN4
	QtN7WdR7tqdhJ5KsnQW6E8zrT7mEgx+YFZ6WAxzXpRnZuqYHfctuOnnhfcv/HXRiELvEf5rNhhYcd
	dLs26xyB2yX6Yg+iZ1Jfsco44NV38uQgiGiY1dXi8WYlwMEAQ9uZFSW+LHZMN8qXulbR469SXehg4
	QK4/+c8Eg2qZgeiJEBnE1OD6k4ytf/40LhpMAFmAAyw3aL2dd+S8q3oAFvZApmdvwGJX/qzlS4Fbb
	5a+fKuCfYWrMe/6VqrBhmgHUrgn0hkijEhubbz1OFt3sIaJO7RMuo+z4TxsltXyUyjKtLMVn4X2pi
	ZQM47fvxeisPAWlnYprA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHcJs-003MTn-09;
	Fri, 07 Jul 2023 03:39:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHcJo-003MST-0h
	for kexec@lists.infradead.org;
	Fri, 07 Jul 2023 03:39:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688701177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbeIWKt/ZhH8gtM0LHJ3D85O5R0ToQZ4nVPoPoLDodA=;
	b=A2B37ZFxvbMXZhdvqsidL5Pnrqqxlaew7hngH6XwrcTlHQzhYxHDz+yicKL2An5Eemo4Sd
	Uy51SdTVs/l+tvTPsvWP35lRRjfDVFcRzEuAkpO3txH41dhTwlTfD4uDqsOlLCgIpnHgCt
	XeERWZNYVnVhTkpi/aJqk7ZlMDgyIr8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-dR26QWgGM-msfZB0lrNktA-1; Thu, 06 Jul 2023 23:39:36 -0400
X-MC-Unique: dR26QWgGM-msfZB0lrNktA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51e278a3a2dso947607a12.3
        for <kexec@lists.infradead.org>; Thu, 06 Jul 2023 20:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688701175; x=1691293175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbeIWKt/ZhH8gtM0LHJ3D85O5R0ToQZ4nVPoPoLDodA=;
        b=h9OAS6P8hFAnVDmb6RphT/aJxS6mBaz/uBSmuMLOCDEm8DJn+Z/NGspsEK92t73Nz3
         7XpDFzEfGYSfmnFJovy4ku+omM5BGp6XnGtzppMxYuKDrjjgCga6WpKxA079Mu4/JYaA
         moZ5vNTPh0pLF5BvUYDURDBobQkUU/vkof0Eggnvpfs2r6/szQXXbO+MSqevAhqU52og
         ba3fgDZn0EO1AT1JFwsKlJlw6yMOGqPtiS+RzvtPaWkpOT5WL4ePflS9Vam+NClC/cca
         AQOju/nCKHzS+j3SvIqSZKKsLtxLIuSIMpqekxhpFWq6FbY7nqU0pO2VJVUMa0gHihml
         o0Pg==
X-Gm-Message-State: ABy/qLbMCVOsQySM3UjCenr++s79vDxhFkAMh4Hx5+G/aGHKpln7p1hj
	u7tFXOM1TEU1ivs8tVkck2sQrVzPWJxyyyvnmIoKx/c85fw6dcXXonNTm6qJB38e9Yrei4f3Jcv
	4WAQE3jhUeUHLVt7hgE5kOoMC8O9AmjKywj8v
X-Received: by 2002:aa7:cd92:0:b0:51e:164c:b67e with SMTP id x18-20020aa7cd92000000b0051e164cb67emr3108131edv.0.1688701175523;
        Thu, 06 Jul 2023 20:39:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHWJlmOujAltt/uzXw3YCGTJt7vhiRKcD5tJ9CGfoQeyq9yhSziGesjZchBVi/vAgucC8Sy47azag+xCNS8lsY=
X-Received: by 2002:aa7:cd92:0:b0:51e:164c:b67e with SMTP id
 x18-20020aa7cd92000000b0051e164cb67emr3108117edv.0.1688701175176; Thu, 06 Jul
 2023 20:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
In-Reply-To: <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
From: Tao Liu <ltao@redhat.com>
Date: Fri, 7 Jul 2023 11:38:59 +0800
Message-ID: <CAO7dBbXdJgpO4Ym=4WME3OOrUhq2MNKpNZmhpsC7pOSugHiKDg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, ardb@kernel.org, linux-kernel@vger.kernel.org, 
	bhe@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, michael.roth@amd.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230706_203940_351985_8FBE8771 
X-CRM114-Status: GOOD (  38.43  )
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

SGkgQm9yaXNsYXYsCgpUaGFua3MgZm9yIHRoZSBwYXRjaCByZXZpZXchCgpPbiBUaHUsIEp1bCA2
LCAyMDIzIGF0IDE6MzTigK9BTSBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4gd3JvdGU6
Cj4KPiBPbiBUaHUsIEp1biAwMSwgMjAyMyBhdCAwMzoyMDo0NFBNICswODAwLCBUYW8gTGl1IHdy
b3RlOgo+ID4gQSBrZXhlYyBrZXJuZWwgYm9vdHVwIGhhbmcgaXMgb2JzZXJ2ZWQgb24gSW50ZWwg
QXRvbSBjcHUgZHVlIHRvIHVubWFwcGVkCj4KPiBzL2NwdS9DUFUvZwo+Cj4gPiBFRkkgY29uZmln
IHRhYmxlLgo+ID4KPiA+IEN1cnJlbnRseSBFRkkgc3lzdGVtIHRhYmxlIGlzIGlkZW50aXR5LW1h
cHBlZCBmb3IgdGhlIGtleGVjIGtlcm5lbCwgYnV0IEVGSQo+ID4gY29uZmlnIHRhYmxlIGlzIG5v
dCBtYXBwZWQgZXhwbGljaXRseToKPgo+IFdoeSBkb2VzIHRoZSBFRkkgY29uZmlnIHRhYmxlICpu
ZWVkKiB0byBiZSBtYXBwZWQgZXhwbGljaXRseT8KPgo+ID4gICAgIGNvbW1pdCA2YmJlYjI3NmI3
MWYgKCJ4ODYva2V4ZWM6IEFkZCB0aGUgRUZJIHN5c3RlbSB0YWJsZXMgYW5kIEFDUEkKPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdGFibGVzIHRvIHRoZSBpZGVudCBtYXAiKQo+ID4KPiA+
IExhdGVyIGluIHRoZSBmb2xsb3dpbmcgMiBjb21taXRzLCBFRkkgY29uZmlnIHRhYmxlIHdpbGwg
YmUgYWNjZXNzZWQgd2hlbgo+ID4gZW5hYmxpbmcgc2V2IGF0IGtlcm5lbCBzdGFydHVwLgo+Cj4g
V2hhdCBkb2VzIFNFViBoYXZlIHRvIGRvIHdpdGggYW4gSW50ZWwgcHJvYmxlbT8KCkZvciB0aGUg
MiBxdWVzdGlvbnMgYWJvdmUuIFRoZSBjYWxsIHN0YWNrIGlzIGZvbGxvd3M6CgpoZWFkXzY0LlM6
Lkxvbl9rZXJuZWxfY3Mod2hpY2ggaXMgYmVmb3JlIGV4dHJhY3Rfa2VybmVsKSAtPiBzZXZfZW5h
YmxlCi0+IHNucF9pbml0IC0+IGZpbmRfY2NfYmxvYiAtPiBmaW5kX2NjX2Jsb2JfZWZpLiBObyBt
YXR0ZXIgd2hhdCBjcHUsCndpdGggQ09ORklHX0FNRF9NRU1fRU5DUllQVCBlbmFibGVkLCBhbGwg
d2lsbCBlbnRlciBzZXZfZW5hYmxlKCkgYW5kCmdvIHRocm91Z2ggdGhlc2UgZnVuY3Rpb25zLiBJ
IGFzc3VtZSBpdCBpcyBoYXJtbGVzcyBmb3IgSW50ZWwgY3B1LApub3JtYWxseSBqdXN0IGV4aXQg
aWYgc2V2IGVuYWJsZSBjb25kaXRpb25zIG5vdCBtZXQuIEhvd2V2ZXIgdGhlIGVmaQpjb25maWcg
dGFibGUgd2lsbCBiZSBpdGVyYXRlZCBpbiBmaW5kX2NjX2Jsb2JfZWZpKCksIGluIG9yZGVyIHRv
IGZpbmQKaWYgdGhlcmUgaXMgRUZJX0NDX0JMT0JfR1VJRChDb25maWRlbnRpYWwgQ29tcHV0aW5n
IGJsb2IpIGluIHRoZQp2ZW5kb3IgdGFibGUuCgo+Cj4gPiBUaGlzIG1heSByZXN1bHQgaW4gYSBw
YWdlIGZhdWx0IGR1ZSB0byBFRkkKPiA+IGNvbmZpZyB0YWJsZSdzIHVubWFwcGVkIGFkZHJlc3Mu
IFNpbmNlIHRoZSBwYWdlIGZhdWx0IG9jY3VycyBhdCBhbiBlYXJseQo+ID4gc3RhZ2UsIGl0IGlz
IHVucmVjb3ZlcmFibGUgYW5kIGtlcm5lbCBoYW5ncy4KPiA+Cj4gPiAgICAgY29tbWl0IGVjMWM2
NmFmM2EzMCAoIng4Ni9jb21wcmVzc2VkLzY0OiBEZXRlY3Qvc2V0dXAgU0VWL1NNRSBmZWF0dXJl
cwo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICBlYXJsaWVyIGR1cmluZyBib290IikKPiA+
ICAgICBjb21taXQgYzAxZmNlOWNlZjg0ICgieDg2L2NvbXByZXNzZWQ6IEFkZCBTRVYtU05QIGZl
YXR1cmUKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV0ZWN0aW9uL3NldHVwIikKPiA+
Cj4gPiBJbiBhZGRpdGlvbiwgdGhlIGlzc3VlIGRvZXNuJ3QgYXBwZWFyIG9uIGFsbCBzeXN0ZW1z
LCBiZWNhdXNlIHRoZSBrZXhlYwo+ID4ga2VybmVsIHVzZXMgUGFnZSBTaXplIEV4dGVuc2lvbiAo
UFNFKSBmb3IgaWRlbnRpdHkgbWFwcGluZy4gSW4gbW9zdCBjYXNlcywKPiA+IEVGSSBjb25maWcg
dGFibGUgY2FuIGVuZCB1cCB0byBiZSBtYXBwZWQgaW50byBkdWUgdG8gMSBHQiBwYWdlIHNpemUu
Cj4gPiBIb3dldmVyIGlmIG5vZ2JwYWdlcyBpcyBzZXQsIG9yIGNwdSBkb2Vzbid0IHN1cHBvcnQg
cGRwZTFnYiBmZWF0dXJlCj4gPiAoZS5nIEludGVsIEF0b20geDY0MjVSRSBjcHUpLCBFRkkgY29u
ZmlnIHRhYmxlIG1heSBub3QgYmUgbWFwcGVkIGludG8KPiA+IGR1ZSB0byAyIE1CIHBhZ2Ugc2l6
ZSwgdGh1cyBhIHBhZ2UgZmF1bHQgaGFuZyBpcyBtb3JlIGxpa2VseSB0byBoYXBwZW4uCj4KPiBU
aGlzIGRvZXNuJ3QgYW5zd2VyIG15IHF1ZXN0aW9uIGFib3ZlLgoKQ3VycmVudGx5IHRoZSBlZmkg
Y29uZmlnIHRhYmxlIGlzIG5vdCBleHBsaWNpdGx5IGlkZW50IG1hcHBlZCBmb3IgMm5kCmtlcm5l
bC4gSW4gYSBmZXcgInVubHVja3kiIGNhc2VzLCAybmQga2VybmVsIHdpbGwgcGFnZSBmYXVsdCBk
dXJpbmcKZmluZF9jY19ibG9iX2VmaSgpIGFuZCB1bnJlY292ZXJhYmxlLCBidXQgZm9yIG1vc3Qg
Y2FzZXMsIGl0IGlzCiJsdWNreSIgd2l0aCBubyBwcm9ibGVtIGJlY2F1c2UgUFNFIGFuZCBwZHBl
MWdiIGNhbiBtYWtlIGNvbmZpZyB0YWJsZQptYXBwZWQgaW50byB3aGVuIGlkZW50IG1hcHBpbmcg
c29tZXRoaW5nIGVsc2UuCgo+Cj4gPiBUaGlzIHBhdGNoIHdpbGwgbWFrZSBzdXJlIHRoZSBFRkkg
Y29uZmlnIHRhYmxlIGlzIGFsd2F5cyBtYXBwZWQuCj4KPiBBdm9pZCBoYXZpbmcgIlRoaXMgcGF0
Y2giIG9yICJUaGlzIGNvbW1pdCIgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLiBJdCBpcwo+IHRhdXRv
bG9naWNhbGx5IHVzZWxlc3MuCj4KPiBBbHNvLCBkbwo+Cj4gJCBnaXQgZ3JlcCAnVGhpcyBwYXRj
aCcgRG9jdW1lbnRhdGlvbi9wcm9jZXNzCj4KPiBmb3IgbW9yZSBkZXRhaWxzLgoKVGhhbmtzLCBJ
IHdpbGwgZ2V0IGl0IGltcHJvdmVkIGluIHYzLgoKPgo+Cj4gPgo+ID4gU2lnbmVkLW9mZi1ieTog
VGFvIExpdSA8bHRhb0ByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiBDaGFuZ2VzIGluIHYyOgo+ID4g
LSBSZXBocmFzZSB0aGUgY2hhbmdlIGxvZyBiYXNlZCBvbiBCYW9xdWFuJ3Mgc3VnZ2VzdGlvbi4K
PiA+IC0gUmVuYW1lIG1hcF9lZmlfc3lzX2NmZ190YWIoKSB0byBtYXBfZWZpX3RhYmxlcygpLgo+
ID4gLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9rZXhlYy8yMDIzMDUyNTA5
NDkxNC4yMzQyMC0xLWx0YW9AcmVkaGF0LmNvbS8KPiA+IC0tLQo+ID4gIGFyY2gveDg2L2tlcm5l
bC9tYWNoaW5lX2tleGVjXzY0LmMgfCAzNSArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiA+
Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL21hY2hpbmVfa2V4ZWNfNjQuYyBiL2Fy
Y2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmMKPiA+IGluZGV4IDFhM2UyYzA1YThhNS4u
NjY0YWVmYTZlODk2IDEwMDY0NAo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL21hY2hpbmVfa2V4
ZWNfNjQuYwo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL21hY2hpbmVfa2V4ZWNfNjQuYwo+ID4g
QEAgLTI4LDYgKzI4LDcgQEAKPiA+ICAjaW5jbHVkZSA8YXNtL3NldHVwLmg+Cj4gPiAgI2luY2x1
ZGUgPGFzbS9zZXRfbWVtb3J5Lmg+Cj4gPiAgI2luY2x1ZGUgPGFzbS9jcHUuaD4KPiA+ICsjaW5j
bHVkZSA8YXNtL2VmaS5oPgo+ID4KPiA+ICAjaWZkZWYgQ09ORklHX0FDUEkKPiA+ICAvKgo+ID4g
QEAgLTg2LDEwICs4NywxMiBAQCBjb25zdCBzdHJ1Y3Qga2V4ZWNfZmlsZV9vcHMgKiBjb25zdCBr
ZXhlY19maWxlX2xvYWRlcnNbXSA9IHsKPiA+ICAjZW5kaWYKPiA+Cj4gPiAgc3RhdGljIGludAo+
ID4gLW1hcF9lZmlfc3lzdGFiKHN0cnVjdCB4ODZfbWFwcGluZ19pbmZvICppbmZvLCBwZ2RfdCAq
bGV2ZWw0cCkKPiA+ICttYXBfZWZpX3RhYmxlcyhzdHJ1Y3QgeDg2X21hcHBpbmdfaW5mbyAqaW5m
bywgcGdkX3QgKmxldmVsNHApCj4gPiAgewo+ID4gICNpZmRlZiBDT05GSUdfRUZJCj4gPiAgICAg
ICB1bnNpZ25lZCBsb25nIG1zdGFydCwgbWVuZDsKPiA+ICsgICAgIHZvaWQgKmthZGRyOwo+ID4g
KyAgICAgaW50IHJldDsKPiA+Cj4gPiAgICAgICBpZiAoIWVmaV9lbmFibGVkKEVGSV9CT09UKSkK
PiA+ICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gPiBAQCAtMTA1LDYgKzEwOCwzMCBAQCBtYXBf
ZWZpX3N5c3RhYihzdHJ1Y3QgeDg2X21hcHBpbmdfaW5mbyAqaW5mbywgcGdkX3QgKmxldmVsNHAp
Cj4gPiAgICAgICBpZiAoIW1zdGFydCkKPiA+ICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gPgo+
ID4gKyAgICAgcmV0ID0ga2VybmVsX2lkZW50X21hcHBpbmdfaW5pdChpbmZvLCBsZXZlbDRwLCBt
c3RhcnQsIG1lbmQpOwo+ID4gKyAgICAgaWYgKHJldCkKPiA+ICsgICAgICAgICAgICAgcmV0dXJu
IHJldDsKPiA+ICsKPiA+ICsgICAgIGthZGRyID0gbWVtcmVtYXAobXN0YXJ0LCBtZW5kIC0gbXN0
YXJ0LCBNRU1SRU1BUF9XQik7Cj4gPiArICAgICBpZiAoIWthZGRyKSB7Cj4gPiArICAgICAgICAg
ICAgIHByX2VycigiQ291bGQgbm90IG1hcCBVRUZJIHN5c3RlbSB0YWJsZVxuIik7Cj4gPiArICAg
ICAgICAgICAgIHJldHVybiAtRU5PTUVNOwo+ID4gKyAgICAgfQo+ID4gKwo+ID4gKyAgICAgbXN0
YXJ0ID0gZWZpX2NvbmZpZ190YWJsZTsKPgo+IFllYWgsIGFib3V0IHRoaXMsIGRpZCB5b3Ugc2Vl
IGVmaV9yZXVzZV9jb25maWcoKSBhbmQgdGhlIGNvbW1lbnQgYWJvdmUKPiBpdCBlc3BlY2lhbGx5
Pwo+Cj4gT3IgaXMgaXQgdGhhdCB0aGUgRUZJIGluIHRoYXQgYm94IHdhbnRzIHRoZSBjb25maWcg
dGFibGUgbWFwcGVkIDE6MSBhbmQKPiBhY2Nlc3NlcyBpdCBkdXJpbmcgYm9vdC9rZXhlYz8KClRo
ZSBjYWxsIHN0YWNrIHNob3dzIHRoZSBwYWdlIGZhdWx0IGlzc3VlIGlzIGJlZm9yZSB0aGUgMm5k
IGtlcm5lbApleHRyYWN0LCB3aGljaCBpcyBlYXJsaWVyIHRoYW4gd2hhdCBlZmlfcmV1c2VfY29u
ZmlnKCkgZG9lcyBmb3Iga2VybmVsCmluaXQuCgpUaGFua3MsClRhbyBMaXUKPgo+IEluIGFueSBj
YXNlLCB0aGlzIGlzIGFsbCBjbG91ZHkgd2l0aG91dCBhIHByb3BlciByb290IGNhdXNlLgo+Cj4g
QWxzbywgSSdkIGxpa2UgZm9yIEFyZCB0byBoYXZlIGEgbG9vayBhdCB0aGlzIHRvby4KPgo+IFRo
eC4KPgo+IC0tCj4gUmVnYXJkcy9HcnVzcywKPiAgICAgQm9yaXMuCj4KPiBodHRwczovL3Blb3Bs
ZS5rZXJuZWwub3JnL3RnbHgvbm90ZXMtYWJvdXQtbmV0aXF1ZXR0ZQo+CgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0Cmtl
eGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9rZXhlYwo=
