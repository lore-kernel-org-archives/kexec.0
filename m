Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B55CCF5396
	for <kexec@archiver.kernel.org>; Wed, 23 Oct 2024 14:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+fNriOwwNDvqKcKl8o2I862fQ4DtnA7ii+H5ORinFls=; b=TNtpD4ImoNxyhF
	lkFutwKrG9BXenGUjJhlnVB48pm5kWWNwfdMMkMFMhno4OtJi7l/WulrsVIUTFwkzh5T9IwixSq3c
	ZDoCQa7Mb2LJcQOhzGut3arIjCgwHqcLsMOBKNisV6HXSEoRQtcAeOi/4NHjPghVq8lSrKMRi/2MG
	HmHGVx1gHk3YoEL6B8LocsEDJxPiWE2+9Rrz/4Ixt/MRcUWucFWRsjNmKupf9GXDV26tc9pj6i6fz
	mcmu6Es9KLo1YbATbx+4SARVDQSeDtTk4ggp6zSxxyZcKtToi7ZeEEY1Ltdh38+2r4kGWs4Gaqcy4
	sxgsGhO33fXWBdAv4jgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3cgJ-0000000Eo8F-1wr0;
	Wed, 23 Oct 2024 14:49:51 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3caU-0000000EmZb-0OK4;
	Wed, 23 Oct 2024 14:43:51 +0000
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5c94b0b466cso7773283a12.0;
        Wed, 23 Oct 2024 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729694628; x=1730299428; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q5rYTkHY31+cXuKv/fhTi/vwecjYJXbckDY0ZiVGZng=;
        b=CEmH2eDcxQar7hhSot2+jLXRHl8a5G5afp1o0+ii55kE/Ilf31nxAtTf0tBRU43egu
         Q7k7Izz0SflwXDyjlWuNHKBGQM4wYEVWtSaEtRQXY0pxjHvy/Cy8Qy8PdIt5QlIQP3o7
         +bwgs4T6Kh10pKGrS4imznsCXXo7MTP0hjXABSEmVWt5sY4PAHLuAFqRx4baNQsQH8S+
         rlVFWW3WB8U1ucPOyNRZnzWDvlpr5cOIF//scXu+aL3/K1CfHv3b1KaBkwio4ts7KtxP
         cT5sh0HaUaPKLfBR2JbcBIr+9bbifhexkpnSDb+WEWwY4bsJLZpwpgAr2rQ1ZnZvxO4P
         y/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729694628; x=1730299428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5rYTkHY31+cXuKv/fhTi/vwecjYJXbckDY0ZiVGZng=;
        b=AMapNdVidHOnaO+gDm5clg4c5YxS2PZo/Pe/vfgmJghOEiXDYQm3oR1OlBSZ510f+l
         Ynis3XERI2eXCCm49uvGf3zydoxtGpRlQfF5lJ/K+XjFIpKzZJZ1XQtmyrB2T99/21Vg
         J9KMh3F39t87IaadEhQjmHK5jpr0n63hMtoZTh3AnEZIiXIaJlKAV8Sp1fIzGYUpx7L0
         Ihn3l6Ihf954JoQiVgCdR9/ErD/RUQtZie0PfVrvk/HxGX/1mX2wV/u1zz416siqBmBm
         EfQka/ESSYXknyZFItiZhe8Cx0UJg3vfdb6KMOI3iL5npvodHwrXLhP95g1Safv1Q5sa
         lJ6A==
X-Forwarded-Encrypted: i=1; AJvYcCU7j9pP5vq/VNr7D2jRKwkSgtNooRl/kmJjoYz//t/A2gehqyDZVf9aYmwZ3vUxLoWCVzSk23fkd3VlZJcTeAgiWw==@lists.infradead.org, AJvYcCVqCNvJE1dt9E9nlDqkI3farA8KvPZ/pMQiRQXVfQV9PnOFTDmJkiVLdZERNI9UsuhwM9BuQQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy9BArgsGITyToio3hzokdS8/g5mxwO2Godw3wCr51tnbj6e1nU
	GxKibSNgDP/ez+CaRtOJ3R8+n0xG9/joyqbaAJLjHdcsKjO4ISF+
X-Google-Smtp-Source: AGHT+IHDJbvo8KOhjbBnEUwYt4z0DNUgMPzm4YxcQUEljWBb7Z20ciaU2eAHyabV6G4Hjpki7LKWTA==
X-Received: by 2002:a05:6402:2106:b0:5ca:d9f:9146 with SMTP id 4fb4d7f45d1cf-5cb8acfa78amr2972462a12.17.1729694625893;
        Wed, 23 Oct 2024 07:43:45 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:ca73])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb6696b68fsm4503334a12.1.2024.10.23.07.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:43:45 -0700 (PDT)
Message-ID: <1e117d65-b454-4d5c-b03a-c3ab3b078093@gmail.com>
Date: Wed, 23 Oct 2024 15:43:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of/kexec: save pa of initial_boot_params for arm64 and
 use it at kexec
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, will@kernel.org, leitao@debian.org,
 catalin.marinas@arm.com, saravanak@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org
References: <20241003113840.2972416-1-usamaarif642@gmail.com>
 <20241004000316.GA1910499-robh@kernel.org>
 <d3d90f10-1ccd-4557-843c-5b546d3b913c@gmail.com>
 <CAL_JsqJVEjPt9tHNr0uAGHQwGnUbZDZoe7kURp3Qx0ce1jv+vw@mail.gmail.com>
 <4b9456a3-47ea-4a00-92fe-131ccd80e550@gmail.com>
 <CAL_JsqLLxyhjrc-Aqg12mjUZHGGgw59=AJxPpOfh5uSST8hY0Q@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAL_JsqLLxyhjrc-Aqg12mjUZHGGgw59=AJxPpOfh5uSST8hY0Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_074350_170489_82810D89 
X-CRM114-Status: GOOD (  28.99  )
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

CgpPbiAyMy8xMC8yMDI0IDE0OjQwLCBSb2IgSGVycmluZyB3cm90ZToKPiBPbiBNb24sIE9jdCA3
LCAyMDI0IGF0IDEwOjMw4oCvQU0gVXNhbWEgQXJpZiA8dXNhbWFhcmlmNjQyQGdtYWlsLmNvbT4g
d3JvdGU6Cj4+Cj4+Cj4+Cj4+IE9uIDA3LzEwLzIwMjQgMTU6MzksIFJvYiBIZXJyaW5nIHdyb3Rl
Ogo+Pj4gT24gTW9uLCBPY3QgNywgMjAyNCBhdCA5OjA24oCvQU0gVXNhbWEgQXJpZiA8dXNhbWFh
cmlmNjQyQGdtYWlsLmNvbT4gd3JvdGU6Cj4+Pj4KPj4+Pgo+Pj4+Cj4+Pj4gT24gMDQvMTAvMjAy
NCAwMTowMywgUm9iIEhlcnJpbmcgd3JvdGU6Cj4+Pj4+IE9uIFRodSwgT2N0IDAzLCAyMDI0IGF0
IDEyOjM4OjQwUE0gKzAxMDAsIFVzYW1hIEFyaWYgd3JvdGU6Cj4+Pj4+PiAgX19wYSgpIGlzIG9u
bHkgaW50ZW5kZWQgdG8gYmUgdXNlZCBmb3IgbGluZWFyIG1hcCBhZGRyZXNzZXMgYW5kIHVzaW5n
Cj4+Pj4+PiBpdCBmb3IgaW5pdGlhbF9ib290X3BhcmFtcyB3aGljaCBpcyBpbiBmaXhtYXAgZm9y
IGFybTY0IHdpbGwgZ2l2ZSBhbgo+Pj4+Pj4gaW5jb3JyZWN0IHZhbHVlLiBIZW5jZSBzdGFzaCB0
aGUgcGh5c2ljYWwgYWRkcmVzcyB3aGVuIGl0IGlzIGtub3duIGF0Cj4+Pj4+PiBib290IHRpbWUg
YW5kIHVzZSBpdCBhdCBrZXhlYyB0aW1lIGluc3RlYWQgb2YgY29udmVydGluZyB0aGUgdmlydHVh
bAo+Pj4+Pj4gYWRkcmVzcyB1c2luZyBfX3BhKCkuCj4+Pj4+Pgo+Pj4+Pj4gUmVwb3J0ZWQtYnk6
IEJyZW5vIExlaXRhbyA8bGVpdGFvQGRlYmlhbi5vcmc+Cj4+Pj4+PiBTdWdnZXN0ZWQtYnk6IE1h
cmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+Cj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBV
c2FtYSBBcmlmIDx1c2FtYWFyaWY2NDJAZ21haWwuY29tPgo+Pj4+Pj4gRml4ZXM6IGFjMTBiZTVj
ZGJmYSAoImFybTY0OiBVc2UgY29tbW9uIG9mX2tleGVjX2FsbG9jX2FuZF9zZXR1cF9mZHQoKSIp
Cj4+Pj4+PiAtLS0KPj4+Pj4+ICBhcmNoL2FybTY0L2tlcm5lbC9zZXR1cC5jIHwgOCArKysrKysr
Kwo+Pj4+Pj4gIGRyaXZlcnMvb2YvZmR0LmMgICAgICAgICAgfCA2ICsrKysrKwo+Pj4+Pj4gIGRy
aXZlcnMvb2Yva2V4ZWMuYyAgICAgICAgfCA4ICsrKysrKy0tCj4+Pj4+PiAgaW5jbHVkZS9saW51
eC9vZl9mZHQuaCAgICB8IDIgKysKPj4+Pj4+ICA0IGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Pj4+Pgo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQva2VybmVsL3NldHVwLmMgYi9hcmNoL2FybTY0L2tlcm5lbC9zZXR1cC5jCj4+Pj4+PiBpbmRl
eCBiMjJkMjhlYzgwMjguLmE0ZDk2ZjVlMmUwNSAxMDA2NDQKPj4+Pj4+IC0tLSBhL2FyY2gvYXJt
NjQva2VybmVsL3NldHVwLmMKPj4+Pj4+ICsrKyBiL2FyY2gvYXJtNjQva2VybmVsL3NldHVwLmMK
Pj4+Pj4+IEBAIC0xOTQsNiArMTk0LDE0IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBzZXR1cF9tYWNo
aW5lX2ZkdChwaHlzX2FkZHJfdCBkdF9waHlzKQo+Pj4+Pj4gICAgICAvKiBFYXJseSBmaXh1cHMg
YXJlIGRvbmUsIG1hcCB0aGUgRkRUIGFzIHJlYWQtb25seSBub3cgKi8KPj4+Pj4+ICAgICAgZml4
bWFwX3JlbWFwX2ZkdChkdF9waHlzLCAmc2l6ZSwgUEFHRV9LRVJORUxfUk8pOwo+Pj4+Pj4KPj4+
Pj4+ICsgICAgLyoKPj4+Pj4+ICsgICAgICogU2F2ZSBkdF9waHlzIGFkZHJlc3Mgc28gdGhhdCBp
dCBjYW4gYmUgdXNlZCBsYXRlciBmb3Iga2V4ZWMuIFRoaXMKPj4+Pj4+ICsgICAgICogaXMgZG9u
ZSBhcyBfX3BhKCkgaXMgb25seSBpbnRlbmRlZCB0byBiZSB1c2VkIGZvciBsaW5lYXIgbWFwIGFk
ZHJlc3Nlcwo+Pj4+Pj4gKyAgICAgKiBhbmQgdXNpbmcgaXQgZm9yIGluaXRpYWxfYm9vdF9wYXJh
bXMgd2hpY2ggaXMgaW4gZml4bWFwIHdpbGwgZ2l2ZSBhbgo+Pj4+Pj4gKyAgICAgKiBpbmNvcnJl
Y3QgdmFsdWUuCj4+Pj4+PiArICAgICAqLwo+Pj4+Pj4gKyAgICBzZXRfaW5pdGlhbF9ib290X3Bh
cmFtc19wYShkdF9waHlzKTsKPj4+Pj4KPj4+Pj4gTm8gbmV3IGFyY2gtPmR0IGZ1bmN0aW9ucyBw
bGVhc2UuIElmIHdlIG5lZWQgdG8gc2F2ZSBvZmYgdGhlIFBBLCB0aGVuIGRvCj4+Pj4+IHRoYXQg
d2hlbiB3ZSBzZXQgaW5pdGlhbF9ib290X3BhcmFtcy4KPj4+Pj4KPj4+Pj4gUm9iCj4+Pj4KPj4+
Pgo+Pj4+IGluaXRpYWxfYm9vdF9wYXJhbXMgaXMgc2V0IGluIGVhcmx5X2luaXRfZHRfdmVyaWZ5
LCBjYWxsZWQgYnkgZWFybHlfaW5pdF9kdF9zY2FuLgo+Pj4+IFRoaXMgaXMgZG9uZSBpbiBzZXR1
cF9tYWNoaW5lX2ZkdCBpbiBhcm02NCB3aGVyZSB0aGUgUEEgaXMgYXZhaWxhYmxlLAo+Pj4+IGJ1
dCBpbiBvdGhlciBmdW5jdGlvbnMgaW4gb3RoZXIgYXJjaGl0ZWN0dXJlcywgd2hlcmUgdGhlIFBB
IGlzIG5vdCBhdmFpbGFibGUuCj4+Pgo+Pj4gRG9lc24ndCBfX3BhKCkgd29yayBmb3IgYWxsIHRo
ZSBvdGhlciBhcmNoaXRlY3R1cmVzPyBUaGF0J3Mgd2hhdCB5b3VyCj4+PiBwYXRjaCBpbmRpY2F0
ZXMuCj4+Pgo+Pgo+PiBZZXMsIF9fcGEoKSB3b3JrcyBmb3IgYWxsIG90aGVyIGFyY2hpdGVjdHVy
ZXMuCj4+Cj4+IEJ1dCB3ZSB3b3VsZCBuZWVkIHRvIGFkZCBpbml0aWFsX2Jvb3RfcGFyYW1zX3Bh
IG9mIHR5cGUgcGh5c19hZGRyX3QKPj4gYXMgYW4gYXJndW1lbnQgZm9yIGVhcmx5X2luaXRfZHRf
c2Nhbiwgd2hpY2ggaXMgY2FsbGVkIGJ5IGFsbCBvdGhlciBhcmNocywKPj4gYW5kIHdlIHRlY2hu
aWNhbGx5IGNhbnQgdXNlIDAgYXMgYW4gaW52YWxpZCB2YWx1ZS4KPj4KPj4gV2UgY291bGQgY29u
dmVydCBpbml0aWFsX2Jvb3RfcGFyYW1zX3BhIHRvIHZvaWQgKiwgYW5kIHBhc3MgTlVMTCBmb3Ig
YWxsCj4+IG90aGVyIGFyY2hzLiBCdXQgYWdhaW4sIEkgZG9uJ3QgcmVhbGx5IHRoaW5rIHdlIHNo
b3VsZCBiZSBjaGFuZ2luZyB0aGUKPj4gZWFybHlfaW5pdF9kdF9zY2FuKGR0X3ZpcnQpIGNhbGwg
aW4gYWxsIG90aGVyIGFyY2hzIHRvCj4+IGVhcmx5X2luaXRfZHRfc2NhbihkdF92aXJ0LCBOVUxM
KSBqdXN0IHRvIHNhdmUgaW5pdGlhbF9ib290X3BhcmFtc19wYQo+PiBpbiBhcm02ND8KPj4KPj4+
PiBTbyBpdCBtYWtlcyBpdCBxdWl0ZSBtZXNzeSB0byBzZXQgaXQgaW4gdGhlIHNhbWUgcGxhY2Ug
YXMgaW5pdGlhbF9ib290X3BhcmFtcy4KPj4+PiBJdHMgb25seSBuZWVkZWQgZm9yIGFybTY0IGFu
ZCBtYWtpbmcgYSBjaGFuZ2UgaW4gYWxsIGFyY2hzIHByb2JhYmx5IGlzbnQgYSBnb29kIGlkZWE/
Cj4+Pj4KPj4+PiBBbnkgcmVhc29uIHRvIG5vdCBhZGQgYSBuZXcgZnVuY3Rpb24gdG8gbWFrZSBh
cmNoIC0+IG9mL2ZkdCBjYWxsPwo+Pj4KPj4+IFllcy4gSXQgaXMgdGhlIG9wcG9zaXRlIGRpcmVj
dGlvbiBJIGhhdmUgcmV3b3JrZWQgdGhlIGludGVyZmFjZXMgdG8uCj4+PiBXZSBkb24ndCB3YW50
IGVhY2ggYXJjaCBjYWxsaW5nIHZhcmlvdXMgZWFybHkgRFQgZnVuY3Rpb25zIGF0IHJhbmRvbQo+
Pj4gdGltZXMgYW5kIG9yZGVyLiBUaGF0J3MgZnJhZ2lsZSB3aGVuIHRoZSBEVCBmdW5jdGlvbnMg
bWFrZSBhc3N1bXB0aW9ucwo+Pj4gYWJvdXQgd2hlbiB0aGV5IGFyZSBjYWxsZWQgb3Igd2hhdCdz
IGJlZW4gaW5pdGlhbGl6ZWQgYWxyZWFkeS4KPj4+Cj4+PiBBbm90aGVyIG9wdGlvbiBpcyB0byBt
YWtlIGFybTY0IGNvcHkgdGhlIERUIGFzIHNvbWUgYXJjaGVzIGRvLgo+Pj4KPj4+IFJvYgo+Pgo+
PiBBaCBtYXliZSBJIGRpZG4ndCB1bmRlcnN0YW5kIHRoaXMgcHJvcGVybHksIGJ1dCBpc250IGVh
cmx5X2luaXRfZHRfc2NhbiBhbgo+PiBhcmNoIC0+IG9mL2ZkdCBpbnRlcmZhY2VzLiBzZXRfaW5p
dGlhbF9ib290X3BhcmFtc19wYSBpcyBhIHNpbWlsYXIgaW50ZXJmYWNlCj4+IHRvIGVhcmx5X2lu
aXRfZHRfc2Nhbj8KPiAKPiBZZXMsIGFuZCBJIGRvbid0IHdhbnQgbW9yZSBBUElzIGlmIHRoZXkg
Y2FuIGJlIGF2b2lkZWQuIFdoZW4gaXMKPiBzZXRfaW5pdGlhbF9ib290X3BhcmFtc19wYSgpIHN1
cHBvc2VkIHRvIGJlIGNhbGxlZD8gSXMgaXQgYmVmb3JlIG9yCj4gYWZ0ZXIgZWFybHlfaW5pdF9k
dF9zY2FuKCk/IAoKSXRzIG9ubHkgbmVlZGVkIGluIGFybTY0LCBhbmQgY2FuIGJlIGVpdGhlciBi
ZWZvcmUgb3IgYWZ0ZXIsIGFzIGxvbmcgYXMgaXRzCnNvbWV3aGVyZSBpbiBzZXR1cF9tYWNoaW5l
X2ZkdCwgd2hlcmUgZHRfcGh5cyBpcyBhdmFpbGFibGUuCgo+IENhbiBzdWJzZXF1ZW50IE9GIGZ1
bmN0aW9ucyBhc3N1bWUgdGhlIFBBCj4gaXMgdmFsaWQ/CgpBZnRlciBzZXRfaW5pdGlhbF9ib290
X3BhcmFtc19wYSBoYXMgYmVlbiBjYWxsZWQsIHllcy4KCj4gSWYgYW4gYXJjaCBkb2Vzbid0IGNh
bGwgc2V0X2luaXRpYWxfYm9vdF9wYXJhbXNfcGEoKSBpcwo+IF9fcGEoKSB2YWxpZCBvciBkaWQg
dGhleSBqdXN0IGZvcmdldCB0byBjYWxsIGl0PyAKCk9ubHkgYXJtNjQgc2VlbXMgdG8gZG8gdGhl
IGZpeG1hcCBhcyBkaXNjdXNzZWQgaW4KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzFlYTU1
MzhmLTdlOTYtNDAzNC05YWY5LWUyZDVmZDcyZTA2OUBnbWFpbC5jb20vLApzbyBfX3BhIHNob3Vs
ZCB3b3JrIGluIG90aGVycy4KClJlcXVpcmluZyB0aGUgUEEgdG8KPiBiZSBzZXQgYXQgdGhlIHNh
bWUgdGltZSBhcyBpbml0aWFsX2Jvb3RfcGFyYW1zIGF2b2lkcyBhbGwgdGhvc2UgaXNzdWVzCj4g
d2l0aCBhbnkgcGVyaW9kIG9mIHRpbWUgaGF2aW5nIHRoZSBQQSBpbmNvcnJlY3QuCj4gCgpBcmUg
eW91IHJlY29tbWVuZGluZyBJIHNlbmQgYSBwYXRjaCB3aGljaCBjaGFuZ2VzIGFsbCBhcmNocyB0
byBjYWxsCmVhcmx5X2luaXRfZHRfc2NhbihkdF92aXJ0LCBOVUxMKT8Kb3IgbWF5YmUgZWFybHlf
aW5pdF9kdF9zY2FuKGR0X3ZpcnQsIF9fcGEoZHRfdmlydCkpPwphbmQgYXJtIHRvIGNhbGwgZWFy
bHlfaW5pdF9kdF9zY2FuKGR0X3ZpcnQsIGR0X3BoeXMpLgoKSGFwcHkgdG8gZG8gc2VuZCBhIHYy
IHdpdGggdGhhdCBpZiBpdHMgdGhlIHdheSBmb3J3YXJkLCBhbHRob3VnaCBJIGZlZWwKc2V0X2lu
aXRpYWxfYm9vdF9wYXJhbXNfcGEoKSBpbiBqdXN0IG9uZSBhcmNoIG1pZ2h0IGJlIGJldHRlciB0
aGFuCmNoYW5naW5nIHRoaXMgZm9yIGFsbCBhcmNocy4KClRoYW5rcwpVc2FtYQoKPiBSb2IKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWls
aW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
