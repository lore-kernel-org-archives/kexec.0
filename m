Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7D8CF5386
	for <kexec@archiver.kernel.org>; Wed, 23 Oct 2024 13:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zgbqm9JROtBjaYszcgq+yq/4MM4PA8J7GQ35LLvAzJE=; b=CAW0G0DDFxridN
	YToXW31CYBF3YyqRPmQsu3n7xPiff0i+q1HAvsD5f9gGvLrfcW1AXV8vU66NC3JGDPKi6mRoNlF2G
	YcAogLWlm9IJZv1QwBQHBCdbgF58WMZcYXsEtHsqZc5nhCUTghrfjQO6QYoGLlRXoiPApamXzUfPj
	vef2fmpinX8UbLdDeHsYjaQXe6S2AI2QiLZDXvRC5zBUAe/uvWIhrp+GHwq3mQvvdbVOk6D9EBpbK
	ywZ5UEw8UWVgzlpXDvPZBoktW4y13rAw08G9EWuWCwSIInOvK3nGXDU6A7t75LQrIFTZmllfQAL6i
	eAu5zaBYA9eDQ+lgo1lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3bb5-0000000Ea02-0KHk;
	Wed, 23 Oct 2024 13:40:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3bb2-0000000EZzW-27Hl;
	Wed, 23 Oct 2024 13:40:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 448FF5C5F0D;
	Wed, 23 Oct 2024 13:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B251C4CEE5;
	Wed, 23 Oct 2024 13:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729690819;
	bh=Lu9YSclbTdVAZko8HL1EN4aP4k9nSSYXLWoin86L7dk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Pf3xZiQBCxAPHaN7y/LNoguShipMOR7i6eDCrlw5URNtM7BjG8DaUNBEFtiN+bvFu
	 ggqCHHcXRju5mymBaSBM9HKTeyijIGw7hOj/SCQ8/oOt+zyxoY9krENgYjWJ/m10MS
	 EPWuWXPx5wS+yo1jbo3ONNc1C/ldL6g/tyvYh0cRjWmZ7Z1lyoHKrMvIXBDfGXjuIC
	 5tuL1xnJVp7GcMoKf7FI7iwoXafhfycx079vaaYAbYVTzRa26JYI2bK+hqTymP7H95
	 l0hidiaSWkBqvxQZSdHdu9oNcGCPMjBk6Xo1PTS99Sty73uYUQ1jHi8ce2ZmPG1oEz
	 ncBbnyetDsy6g==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e59dadebso8483902e87.0;
        Wed, 23 Oct 2024 06:40:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKBYRDHukwgGFTzBvLdI8VVsR8ClZMzr11b5cVPLA/ziKSAY6UCPArmIZsrzbWPbCRvANhaA==@lists.infradead.org, AJvYcCXonFR0IqxJDSq1S4W+R7jixzfMMRL9uO1KGuMMTq7oTH1SuJ8zkEwgur3BmiiiKzwUmnK6hhZ5v/SQ2YfL4HM6iw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwWrb0L6ZjaxNZPKHvkt9K1nEjqCPU0wMry/KY6LuIp4G6o/tKn
	khVES+yxNFmEeS5tCyJvN9N6aHZHsYZr6/FzjYEl6KD5ddsZJ7b/tfOeLQtp2EkkaTI+LnB3Up6
	P2gLx42RqHKmGMCQZzawZ+zw7mg==
X-Google-Smtp-Source: AGHT+IFp1rlvBvAgovwWIHdkc8JKbjpOUlWvNyNMMr+FomXIFzVaHzZoAryx8MZFai0b1ZgDur6QOvdz+dUkJLEiYps=
X-Received: by 2002:a05:6512:1110:b0:539:da76:c77e with SMTP id
 2adb3069b0e04-53b1a31d8a9mr1461200e87.5.1729690817815; Wed, 23 Oct 2024
 06:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20241003113840.2972416-1-usamaarif642@gmail.com>
 <20241004000316.GA1910499-robh@kernel.org> <d3d90f10-1ccd-4557-843c-5b546d3b913c@gmail.com>
 <CAL_JsqJVEjPt9tHNr0uAGHQwGnUbZDZoe7kURp3Qx0ce1jv+vw@mail.gmail.com> <4b9456a3-47ea-4a00-92fe-131ccd80e550@gmail.com>
In-Reply-To: <4b9456a3-47ea-4a00-92fe-131ccd80e550@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 23 Oct 2024 08:40:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLLxyhjrc-Aqg12mjUZHGGgw59=AJxPpOfh5uSST8hY0Q@mail.gmail.com>
Message-ID: <CAL_JsqLLxyhjrc-Aqg12mjUZHGGgw59=AJxPpOfh5uSST8hY0Q@mail.gmail.com>
Subject: Re: [PATCH] of/kexec: save pa of initial_boot_params for arm64 and
 use it at kexec
To: Usama Arif <usamaarif642@gmail.com>
Cc: mark.rutland@arm.com, will@kernel.org, leitao@debian.org, 
	catalin.marinas@arm.com, saravanak@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_064020_659897_246EA0D0 
X-CRM114-Status: GOOD (  36.32  )
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

T24gTW9uLCBPY3QgNywgMjAyNCBhdCAxMDozMOKAr0FNIFVzYW1hIEFyaWYgPHVzYW1hYXJpZjY0
MkBnbWFpbC5jb20+IHdyb3RlOgo+Cj4KPgo+IE9uIDA3LzEwLzIwMjQgMTU6MzksIFJvYiBIZXJy
aW5nIHdyb3RlOgo+ID4gT24gTW9uLCBPY3QgNywgMjAyNCBhdCA5OjA24oCvQU0gVXNhbWEgQXJp
ZiA8dXNhbWFhcmlmNjQyQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPj4KPiA+Pgo+ID4+Cj4gPj4gT24g
MDQvMTAvMjAyNCAwMTowMywgUm9iIEhlcnJpbmcgd3JvdGU6Cj4gPj4+IE9uIFRodSwgT2N0IDAz
LCAyMDI0IGF0IDEyOjM4OjQwUE0gKzAxMDAsIFVzYW1hIEFyaWYgd3JvdGU6Cj4gPj4+PiAgX19w
YSgpIGlzIG9ubHkgaW50ZW5kZWQgdG8gYmUgdXNlZCBmb3IgbGluZWFyIG1hcCBhZGRyZXNzZXMg
YW5kIHVzaW5nCj4gPj4+PiBpdCBmb3IgaW5pdGlhbF9ib290X3BhcmFtcyB3aGljaCBpcyBpbiBm
aXhtYXAgZm9yIGFybTY0IHdpbGwgZ2l2ZSBhbgo+ID4+Pj4gaW5jb3JyZWN0IHZhbHVlLiBIZW5j
ZSBzdGFzaCB0aGUgcGh5c2ljYWwgYWRkcmVzcyB3aGVuIGl0IGlzIGtub3duIGF0Cj4gPj4+PiBi
b290IHRpbWUgYW5kIHVzZSBpdCBhdCBrZXhlYyB0aW1lIGluc3RlYWQgb2YgY29udmVydGluZyB0
aGUgdmlydHVhbAo+ID4+Pj4gYWRkcmVzcyB1c2luZyBfX3BhKCkuCj4gPj4+Pgo+ID4+Pj4gUmVw
b3J0ZWQtYnk6IEJyZW5vIExlaXRhbyA8bGVpdGFvQGRlYmlhbi5vcmc+Cj4gPj4+PiBTdWdnZXN0
ZWQtYnk6IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+Cj4gPj4+PiBTaWduZWQt
b2ZmLWJ5OiBVc2FtYSBBcmlmIDx1c2FtYWFyaWY2NDJAZ21haWwuY29tPgo+ID4+Pj4gRml4ZXM6
IGFjMTBiZTVjZGJmYSAoImFybTY0OiBVc2UgY29tbW9uIG9mX2tleGVjX2FsbG9jX2FuZF9zZXR1
cF9mZHQoKSIpCj4gPj4+PiAtLS0KPiA+Pj4+ICBhcmNoL2FybTY0L2tlcm5lbC9zZXR1cC5jIHwg
OCArKysrKysrKwo+ID4+Pj4gIGRyaXZlcnMvb2YvZmR0LmMgICAgICAgICAgfCA2ICsrKysrKwo+
ID4+Pj4gIGRyaXZlcnMvb2Yva2V4ZWMuYyAgICAgICAgfCA4ICsrKysrKy0tCj4gPj4+PiAgaW5j
bHVkZS9saW51eC9vZl9mZHQuaCAgICB8IDIgKysKPiA+Pj4+ICA0IGZpbGVzIGNoYW5nZWQsIDIy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPj4+Pgo+ID4+Pj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtNjQva2VybmVsL3NldHVwLmMgYi9hcmNoL2FybTY0L2tlcm5lbC9zZXR1cC5jCj4g
Pj4+PiBpbmRleCBiMjJkMjhlYzgwMjguLmE0ZDk2ZjVlMmUwNSAxMDA2NDQKPiA+Pj4+IC0tLSBh
L2FyY2gvYXJtNjQva2VybmVsL3NldHVwLmMKPiA+Pj4+ICsrKyBiL2FyY2gvYXJtNjQva2VybmVs
L3NldHVwLmMKPiA+Pj4+IEBAIC0xOTQsNiArMTk0LDE0IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBz
ZXR1cF9tYWNoaW5lX2ZkdChwaHlzX2FkZHJfdCBkdF9waHlzKQo+ID4+Pj4gICAgICAvKiBFYXJs
eSBmaXh1cHMgYXJlIGRvbmUsIG1hcCB0aGUgRkRUIGFzIHJlYWQtb25seSBub3cgKi8KPiA+Pj4+
ICAgICAgZml4bWFwX3JlbWFwX2ZkdChkdF9waHlzLCAmc2l6ZSwgUEFHRV9LRVJORUxfUk8pOwo+
ID4+Pj4KPiA+Pj4+ICsgICAgLyoKPiA+Pj4+ICsgICAgICogU2F2ZSBkdF9waHlzIGFkZHJlc3Mg
c28gdGhhdCBpdCBjYW4gYmUgdXNlZCBsYXRlciBmb3Iga2V4ZWMuIFRoaXMKPiA+Pj4+ICsgICAg
ICogaXMgZG9uZSBhcyBfX3BhKCkgaXMgb25seSBpbnRlbmRlZCB0byBiZSB1c2VkIGZvciBsaW5l
YXIgbWFwIGFkZHJlc3Nlcwo+ID4+Pj4gKyAgICAgKiBhbmQgdXNpbmcgaXQgZm9yIGluaXRpYWxf
Ym9vdF9wYXJhbXMgd2hpY2ggaXMgaW4gZml4bWFwIHdpbGwgZ2l2ZSBhbgo+ID4+Pj4gKyAgICAg
KiBpbmNvcnJlY3QgdmFsdWUuCj4gPj4+PiArICAgICAqLwo+ID4+Pj4gKyAgICBzZXRfaW5pdGlh
bF9ib290X3BhcmFtc19wYShkdF9waHlzKTsKPiA+Pj4KPiA+Pj4gTm8gbmV3IGFyY2gtPmR0IGZ1
bmN0aW9ucyBwbGVhc2UuIElmIHdlIG5lZWQgdG8gc2F2ZSBvZmYgdGhlIFBBLCB0aGVuIGRvCj4g
Pj4+IHRoYXQgd2hlbiB3ZSBzZXQgaW5pdGlhbF9ib290X3BhcmFtcy4KPiA+Pj4KPiA+Pj4gUm9i
Cj4gPj4KPiA+Pgo+ID4+IGluaXRpYWxfYm9vdF9wYXJhbXMgaXMgc2V0IGluIGVhcmx5X2luaXRf
ZHRfdmVyaWZ5LCBjYWxsZWQgYnkgZWFybHlfaW5pdF9kdF9zY2FuLgo+ID4+IFRoaXMgaXMgZG9u
ZSBpbiBzZXR1cF9tYWNoaW5lX2ZkdCBpbiBhcm02NCB3aGVyZSB0aGUgUEEgaXMgYXZhaWxhYmxl
LAo+ID4+IGJ1dCBpbiBvdGhlciBmdW5jdGlvbnMgaW4gb3RoZXIgYXJjaGl0ZWN0dXJlcywgd2hl
cmUgdGhlIFBBIGlzIG5vdCBhdmFpbGFibGUuCj4gPgo+ID4gRG9lc24ndCBfX3BhKCkgd29yayBm
b3IgYWxsIHRoZSBvdGhlciBhcmNoaXRlY3R1cmVzPyBUaGF0J3Mgd2hhdCB5b3VyCj4gPiBwYXRj
aCBpbmRpY2F0ZXMuCj4gPgo+Cj4gWWVzLCBfX3BhKCkgd29ya3MgZm9yIGFsbCBvdGhlciBhcmNo
aXRlY3R1cmVzLgo+Cj4gQnV0IHdlIHdvdWxkIG5lZWQgdG8gYWRkIGluaXRpYWxfYm9vdF9wYXJh
bXNfcGEgb2YgdHlwZSBwaHlzX2FkZHJfdAo+IGFzIGFuIGFyZ3VtZW50IGZvciBlYXJseV9pbml0
X2R0X3NjYW4sIHdoaWNoIGlzIGNhbGxlZCBieSBhbGwgb3RoZXIgYXJjaHMsCj4gYW5kIHdlIHRl
Y2huaWNhbGx5IGNhbnQgdXNlIDAgYXMgYW4gaW52YWxpZCB2YWx1ZS4KPgo+IFdlIGNvdWxkIGNv
bnZlcnQgaW5pdGlhbF9ib290X3BhcmFtc19wYSB0byB2b2lkICosIGFuZCBwYXNzIE5VTEwgZm9y
IGFsbAo+IG90aGVyIGFyY2hzLiBCdXQgYWdhaW4sIEkgZG9uJ3QgcmVhbGx5IHRoaW5rIHdlIHNo
b3VsZCBiZSBjaGFuZ2luZyB0aGUKPiBlYXJseV9pbml0X2R0X3NjYW4oZHRfdmlydCkgY2FsbCBp
biBhbGwgb3RoZXIgYXJjaHMgdG8KPiBlYXJseV9pbml0X2R0X3NjYW4oZHRfdmlydCwgTlVMTCkg
anVzdCB0byBzYXZlIGluaXRpYWxfYm9vdF9wYXJhbXNfcGEKPiBpbiBhcm02ND8KPgo+ID4+IFNv
IGl0IG1ha2VzIGl0IHF1aXRlIG1lc3N5IHRvIHNldCBpdCBpbiB0aGUgc2FtZSBwbGFjZSBhcyBp
bml0aWFsX2Jvb3RfcGFyYW1zLgo+ID4+IEl0cyBvbmx5IG5lZWRlZCBmb3IgYXJtNjQgYW5kIG1h
a2luZyBhIGNoYW5nZSBpbiBhbGwgYXJjaHMgcHJvYmFibHkgaXNudCBhIGdvb2QgaWRlYT8KPiA+
Pgo+ID4+IEFueSByZWFzb24gdG8gbm90IGFkZCBhIG5ldyBmdW5jdGlvbiB0byBtYWtlIGFyY2gg
LT4gb2YvZmR0IGNhbGw/Cj4gPgo+ID4gWWVzLiBJdCBpcyB0aGUgb3Bwb3NpdGUgZGlyZWN0aW9u
IEkgaGF2ZSByZXdvcmtlZCB0aGUgaW50ZXJmYWNlcyB0by4KPiA+IFdlIGRvbid0IHdhbnQgZWFj
aCBhcmNoIGNhbGxpbmcgdmFyaW91cyBlYXJseSBEVCBmdW5jdGlvbnMgYXQgcmFuZG9tCj4gPiB0
aW1lcyBhbmQgb3JkZXIuIFRoYXQncyBmcmFnaWxlIHdoZW4gdGhlIERUIGZ1bmN0aW9ucyBtYWtl
IGFzc3VtcHRpb25zCj4gPiBhYm91dCB3aGVuIHRoZXkgYXJlIGNhbGxlZCBvciB3aGF0J3MgYmVl
biBpbml0aWFsaXplZCBhbHJlYWR5Lgo+ID4KPiA+IEFub3RoZXIgb3B0aW9uIGlzIHRvIG1ha2Ug
YXJtNjQgY29weSB0aGUgRFQgYXMgc29tZSBhcmNoZXMgZG8uCj4gPgo+ID4gUm9iCj4KPiBBaCBt
YXliZSBJIGRpZG4ndCB1bmRlcnN0YW5kIHRoaXMgcHJvcGVybHksIGJ1dCBpc250IGVhcmx5X2lu
aXRfZHRfc2NhbiBhbgo+IGFyY2ggLT4gb2YvZmR0IGludGVyZmFjZXMuIHNldF9pbml0aWFsX2Jv
b3RfcGFyYW1zX3BhIGlzIGEgc2ltaWxhciBpbnRlcmZhY2UKPiB0byBlYXJseV9pbml0X2R0X3Nj
YW4/CgpZZXMsIGFuZCBJIGRvbid0IHdhbnQgbW9yZSBBUElzIGlmIHRoZXkgY2FuIGJlIGF2b2lk
ZWQuIFdoZW4gaXMKc2V0X2luaXRpYWxfYm9vdF9wYXJhbXNfcGEoKSBzdXBwb3NlZCB0byBiZSBj
YWxsZWQ/IElzIGl0IGJlZm9yZSBvcgphZnRlciBlYXJseV9pbml0X2R0X3NjYW4oKT8gQ2FuIHN1
YnNlcXVlbnQgT0YgZnVuY3Rpb25zIGFzc3VtZSB0aGUgUEEKaXMgdmFsaWQ/IElmIGFuIGFyY2gg
ZG9lc24ndCBjYWxsIHNldF9pbml0aWFsX2Jvb3RfcGFyYW1zX3BhKCkgaXMKX19wYSgpIHZhbGlk
IG9yIGRpZCB0aGV5IGp1c3QgZm9yZ2V0IHRvIGNhbGwgaXQ/IFJlcXVpcmluZyB0aGUgUEEgdG8K
YmUgc2V0IGF0IHRoZSBzYW1lIHRpbWUgYXMgaW5pdGlhbF9ib290X3BhcmFtcyBhdm9pZHMgYWxs
IHRob3NlIGlzc3Vlcwp3aXRoIGFueSBwZXJpb2Qgb2YgdGltZSBoYXZpbmcgdGhlIFBBIGluY29y
cmVjdC4KClJvYgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
