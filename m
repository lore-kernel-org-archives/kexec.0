Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAC2EB64DC
	for <kexec@archiver.kernel.org>; Mon, 17 Jul 2023 15:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9lOP/1IBx+FRMyQcByjIVLaXuwtuvuQzlF6kxwb7ke0=; b=atCr6PLOmyY4MR
	THbNByvWYCC6n0036dRiMerp/pDrZjWwCRpbcvtVZyI6/O1Wm1Ej11U3OvGVCehpIPLg5kdJ06jiq
	4Zr8ns6gJ2cK6Zw3lHmQuUo7ju9gT68EPy4j+KbxqQ431V6DIyhQmFCoXpSL8CH0cEpG++On6t4F0
	q1kBd7RGwEWJ/K9t8sWs/vuPNKCv2+eGHJsgxQG19U0KKfhzXJF+VS8pyUL6MSK+P08MawtABQoWv
	7cGEUCLxM1hAjOK7hUFx20OgKel8lq208ugXNEolBLMGrS3rjH1L4LwZr5fBlYALJuMG8Z6METZGt
	kZcG31UfXNrxH4gE9NhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qLPtn-004MFc-1i;
	Mon, 17 Jul 2023 15:12:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qLPtk-004MEU-0O
	for kexec@lists.infradead.org;
	Mon, 17 Jul 2023 15:12:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689606746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Z1R60E2ZDa1sZtOt0a5TFflX73Adcu3YIcOrKAojsE=;
	b=hSx9Su2fh/GvYHkATFRGKqppEF6sFwOVULJP/nfFudEzPV2wonYM0kIK6m/YtG32dknbXd
	/yAfAaTxnkQNMqBzh3zzL6vuZlY0Vq4FT5SRiuYkS1/US9FjzhkNkhW82p1hV0CU6ea6qM
	oZJhZchyRTNLnq0fgef+5naMjMbjSTg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-3D-GEO7KOAO2mWoVNpdFmA-1; Mon, 17 Jul 2023 11:12:25 -0400
X-MC-Unique: 3D-GEO7KOAO2mWoVNpdFmA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-51bef8bb689so6927241a12.1
        for <kexec@lists.infradead.org>; Mon, 17 Jul 2023 08:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689606744; x=1692198744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Z1R60E2ZDa1sZtOt0a5TFflX73Adcu3YIcOrKAojsE=;
        b=UPvD21quA2sGWdkIioIPZrIJ/1jhmIK1/rQINksCI/BPPpChil48W1tK1Kywg6l6ST
         CrKQBrtDaBb3Xbjl1An+RHoTe1AAHT4OE1UBEjQhAt7BMhwn4qgqJM6UjH5pGcU8CTWQ
         wwZ5LBtjqlqmH4nQeCVFUMpMHUxcLKiZmjH4HiGLJmJ4V5inr5bOiZWBOOrnb9zEMHcN
         Omth1KiA4JO3tNkuo8Ir3RC97aJ0jja/9IkZPprLPD87H6XnWT6UcSjqjlbeS3h9d7ke
         8YItLCdeu0JOV26sZH/JwknYmhfa4ZOTRS8pW6vNXgh9P22GdPoVl2qOFNyA0AwKdjJa
         Tv7w==
X-Gm-Message-State: ABy/qLb8JbnFKdndMLZKpaZWhlwrJiz/2iK0EZH0g4d//VL44qS7Jcaf
	YGDlmVwM6HpXr2GhK8BNYKqaqj6rGoN/6qcCchkmxN8DeUVo82qOfQ6xPyJxEdRw76oGHGpi97d
	HJVfHpNxh6gWVT/xxHOdDC1lj/qcZ+wM1kzvh
X-Received: by 2002:a05:6402:42cc:b0:51f:e0f0:f2cd with SMTP id i12-20020a05640242cc00b0051fe0f0f2cdmr11664855edc.3.1689606744287;
        Mon, 17 Jul 2023 08:12:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGMNX9yof2GWE8oz7jVoRRWAHmk/1Oqwuutxcg20comIaY6zdK6uBSjv18bFjD3A2v1Cwtu2PrDMhARChVQIo0=
X-Received: by 2002:a05:6402:42cc:b0:51f:e0f0:f2cd with SMTP id
 i12-20020a05640242cc00b0051fe0f0f2cdmr11664844edc.3.1689606744027; Mon, 17
 Jul 2023 08:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com> <CAMj1kXGEFr+E3pKLrJJq=FXv9ZhDg0zSEw7sewumPZkwtd3P5Q@mail.gmail.com>
In-Reply-To: <CAMj1kXGEFr+E3pKLrJJq=FXv9ZhDg0zSEw7sewumPZkwtd3P5Q@mail.gmail.com>
From: Tao Liu <ltao@redhat.com>
Date: Mon, 17 Jul 2023 23:11:48 +0800
Message-ID: <CAO7dBbXhF36vCgVMOM2H83H34OqsA6J3KmsBMvYcs_p9_5pa4Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, bhe@redhat.com, dyoung@redhat.com, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230717_081228_254356_D3E9D1AA 
X-CRM114-Status: GOOD (  29.01  )
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

T24gTW9uLCBKdWwgMTcsIDIwMjMgYXQgMTA6NTfigK9QTSBBcmQgQmllc2hldXZlbCA8YXJkYkBr
ZXJuZWwub3JnPiB3cm90ZToKPgo+IE9uIE1vbiwgMTcgSnVsIDIwMjMgYXQgMTU6NTMsIFRhbyBM
aXUgPGx0YW9AcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gSGkgQm9yaXNsYXYsCj4gPgo+ID4g
T24gVGh1LCBKdWwgMTMsIDIwMjMgYXQgNjowNeKAr1BNIEJvcmlzbGF2IFBldGtvdiA8YnBAYWxp
ZW44LmRlPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gVGh1LCBKdW4gMDEsIDIwMjMgYXQgMDM6MjA6
NDRQTSArMDgwMCwgVGFvIExpdSB3cm90ZToKPiA+ID4gPiAgYXJjaC94ODYva2VybmVsL21hY2hp
bmVfa2V4ZWNfNjQuYyB8IDM1ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQo+ID4gPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiA+ID4K
PiA+ID4gT2ssIHBscyB0cnkgdGhpcyB0b3RhbGx5IHVudGVzdGVkIHRoaW5nLgo+ID4gPgo+ID4g
PiBUaHguCj4gPiA+Cj4gPiA+IC0tLQo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvYm9vdC9j
b21wcmVzc2VkL3Nldi5jIGIvYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL3Nldi5jCj4gPiA+IGlu
ZGV4IDA5ZGM4YzE4N2IzYy4uZmVmZTI3YjJhZjg1IDEwMDY0NAo+ID4gPiAtLS0gYS9hcmNoL3g4
Ni9ib290L2NvbXByZXNzZWQvc2V2LmMKPiA+ID4gKysrIGIvYXJjaC94ODYvYm9vdC9jb21wcmVz
c2VkL3Nldi5jCj4gPiA+IEBAIC00MDQsMTMgKzQwNCwyMCBAQCB2b2lkIHNldl9lbmFibGUoc3Ry
dWN0IGJvb3RfcGFyYW1zICpicCkKPiA+ID4gICAgICAgICBpZiAoYnApCj4gPiA+ICAgICAgICAg
ICAgICAgICBicC0+Y2NfYmxvYl9hZGRyZXNzID0gMDsKPiA+ID4KPiA+ID4gKyAgICAgICAvKiBD
aGVjayBmb3IgdGhlIFNNRS9TRVYgc3VwcG9ydCBsZWFmICovCj4gPiA+ICsgICAgICAgZWF4ID0g
MHg4MDAwMDAwMDsKPiA+ID4gKyAgICAgICBlY3ggPSAwOwo+ID4gPiArICAgICAgIG5hdGl2ZV9j
cHVpZCgmZWF4LCAmZWJ4LCAmZWN4LCAmZWR4KTsKPiA+ID4gKyAgICAgICBpZiAoZWF4IDwgMHg4
MDAwMDAxZikKPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybjsKPiA+ID4gKwo+ID4gPiAgICAg
ICAgIC8qCj4gPiA+ICAgICAgICAgICogU2V0dXAvcHJlbGltaW5hcnkgZGV0ZWN0aW9uIG9mIFNO
UC4gVGhpcyB3aWxsIGJlIHNhbml0eS1jaGVja2VkCj4gPiA+ICAgICAgICAgICogYWdhaW5zdCBD
UFVJRC9NU1IgdmFsdWVzIGxhdGVyLgo+ID4gPiAgICAgICAgICAqLwo+ID4gPiAgICAgICAgIHNu
cCA9IHNucF9pbml0KGJwKTsKPiA+ID4KPiA+ID4gLSAgICAgICAvKiBDaGVjayBmb3IgdGhlIFNN
RS9TRVYgc3VwcG9ydCBsZWFmICovCj4gPiA+ICsgICAgICAgLyogUmVjaGVjayB0aGUgU01FL1NF
ViBzdXBwb3J0IGxlYWYgKi8KPiA+ID4gICAgICAgICBlYXggPSAweDgwMDAwMDAwOwo+ID4gPiAg
ICAgICAgIGVjeCA9IDA7Cj4gPiA+ICAgICAgICAgbmF0aXZlX2NwdWlkKCZlYXgsICZlYngsICZl
Y3gsICZlZHgpOwo+ID4gPgo+ID4gVGhhbmtzIGEgbG90IGZvciB0aGUgcGF0Y2ggYWJvdmUhIFNv
cnJ5IGZvciB0aGUgbGF0ZSByZXNwb25zZS4gSSBoYXZlCj4gPiBjb21waWxlZCBhbmQgdGVzdGVk
IGl0IGxvY2FsbHkgYWdhaW5zdCA2LjUuMC1yYzEsIHRob3VnaCBpdCBjYW4gcGFzcwo+ID4gdGhl
IGVhcmx5IHN0YWdlIG9mIGtleGVjIGtlcm5lbCBib290dXAsCj4KPiBPSywgc28gdGhhdCBwcm92
ZXMgdGhhdCB0aGUgY2NfYmxvYiB0YWJsZSBhY2Nlc3MgaXMgdGhlIGN1bHByaXQgaGVyZS4KPiBU
aGF0IHN0aWxsIG1lYW5zIHRoYXQga2V4ZWMgb24gU0VWIGlzIGxpa2VseSB0byBleHBsb2RlIGlu
IHRoZSBleGFjdAo+IHNhbWUgd2F5IHNob3VsZCBhbnlvbmUgYXR0ZW1wdCB0aGF0Lgo+Cj4KPiA+
IGhvd2V2ZXIgdGhlIGtlcm5lbCB3aWxsIHBhbmljCj4gPiBvY2Nhc2lvbmFsbHkgbGF0ZXIuIFRo
ZSB0ZXN0IG1hY2hpbmUgaXMgdGhlIG9uZSB3aXRoIEludGVsIEF0b20KPiA+IHg2NDI1UkUgY3B1
IHdoaWNoIGVuY291bnRlcmVkIHRoZSBwYWdlIGZhdWx0IGlzc3VlIG9mIG1pc3NpbmcgZWZpCj4g
PiBjb25maWcgdGFibGUuCj4gPgo+Cj4gQWdyZWUgd2l0aCBCb3JpcyB0aGF0IHRoaXMgc2VlbXMg
ZW50aXJlbHkgdW5yZWxhdGVkLgoKQWdyZWUsIEkgd2lsbCBoYXZlIGEgcmV0ZXN0IGJhc2VkIG9u
IEJvcmlzJ3Mgc3VnZ2VzdGlvbnMuCgo+Cj4gPiAuLi5zbmlwLi4uCj4gPiBbICAgMjEuMzYwNzYz
XSAgbnZtZTBuMTogcDEgcDIgcDMKPiA+IFsgICAyMS4zNjQyMDddIGlnYyAwMDAwOjAzOjAwLjA6
IFBUTSBlbmFibGVkLCA0bnMgZ3JhbnVsYXJpdHkKPiA+IFsgICAyMS40MjEwOTddIHBwcyBwcHMx
OiBuZXcgUFBTIHNvdXJjZSBwdHAxCj4gPiBbICAgMjEuNDI1Mzk2XSBpZ2MgMDAwMDowMzowMC4w
ICh1bm5hbWVkIG5ldF9kZXZpY2UpICh1bmluaXRpYWxpemVkKTogUEhDIGFkZGVkCj4gPiBbICAg
MjEuNDU3MDA1XSBpZ2MgMDAwMDowMzowMC4wOiA0LjAwMCBHYi9zIGF2YWlsYWJsZSBQQ0llIGJh
bmR3aWR0aAo+ID4gKDUuMCBHVC9zIFBDSWUgeDEgbGluaykKPiA+IFsgICAyMS40NjUyMTBdIGln
YyAwMDAwOjAzOjAwLjAgZXRoMTogTUFDOiAuLi5zbmlwLi4uCj4gPiBbICAgMjEuNDczNDI0XSBp
Z2MgMDAwMDowMzowMC4wIGVucDNzMDogcmVuYW1lZCBmcm9tIGV0aDEKPiA+IFsgICAyMS40Nzk0
NDZdIEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgYWRkcmVzczogMDAwMDAw
MDAwMDAwMDAwOAo+ID4gWyAgIDIxLjQ4NjQwNV0gI1BGOiBzdXBlcnZpc29yIHJlYWQgYWNjZXNz
IGluIGtlcm5lbCBtb2RlCj4gPiBbICAgMjEuNDkxNTE5XSBtbWMxOiBGYWlsZWQgdG8gaW5pdGlh
bGl6ZSBhIG5vbi1yZW1vdmFibGUgY2FyZAo+ID4gWyAgIDIxLjQ5MTUzOF0gI1BGOiBlcnJvcl9j
b2RlKDB4MDAwMCkgLSBub3QtcHJlc2VudCBwYWdlCj4gPiBbICAgMjEuNTAyMjI5XSBQR0QgMCBQ
NEQgMAo+ID4gWyAgIDIxLjUwNDc3M10gT29wczogMDAwMCBbIzFdIFBSRUVNUFQgU01QIE5PUFRJ
Cj4gPiBbICAgMjEuNTA5MTMzXSBDUFU6IDMgUElEOiA0MDIgQ29tbTogc3lzdGVtZC11ZGV2ZCBO
b3QgdGFpbnRlZCA2LjUuMC1yYzErICMxCj4gPiBbICAgMjEuNTE1OTA1XSBIYXJkd2FyZSBuYW1l
OiAuLi5zbmlwLi4uCj4KPgo+IFdoeSBhcmUgeW91IHNuaXBwaW5nIHRoZSBoYXJkd2FyZSBuYW1l
PwoKU29ycnkgZm9yIHRoZSBpbmNvbnZlbmllbmNlIGhlcmUuLi4gVGhlIG1hY2hpbmUgaXMgYm9y
cm93ZWQgZnJvbSBvdXIKcGFydG5lciwgd2hpY2ggbWF5IG5vdCBiZSBvZmZpY2lhbGx5IHJlbGVh
c2VkIHRvIHRoZSBtYXJrZXQuIEkgaGF2ZW4ndApkaXNjdXNzZWQgdGhlIGxlZ2FsIGlzc3VlIHdp
dGggdGhlbS4gSW4gYWRkaXRpb24sIEkgdGhpbmsgdGhlIHN0YWNrCnRyYWNlIGlzIG1vcmUgdXNl
ZnVsLCBzbyBJIHNuaXBwZWQgdGhlIGhhcmR3YXJlIG5hbWUuIFNvcnJ5IGFib3V0CnRoYXQuLi4K
Cj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhl
YyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
