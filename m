Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CC2CFB443
	for <kexec@archiver.kernel.org>; Mon,  7 Oct 2024 14:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M1jobWssNymYcW7AGzd2j7KA7AiuZUoU8zGYJ+valUw=; b=vZvdG0laSWzzES
	urry0zKVm9pvWZ/myQkwtriC0GWFvdSkYnraHH37YZCQqiyLW4tsvpeEauWZDhmqTJsPR291wPrU6
	iP9ytFD5j+MkM/ZmvJOy/YcWVUJGJMQq7369mqSYXDUQB183+cHho60En59EIj8yjmfT1ENNLI5jv
	AUWJOnof0nURSJNgw0SZUz35LchnniHM92IY+WiCO3SV8mYWrsPMjMyB8WpngjgibRPpE2GAZC+QU
	yn3c2KhfWPBufNlO2p/W9t/n/PiWAM7OusLbIqd3Cuanyi8vGylm7CtV3GWcv9FqrRNJjk3GCnQ03
	cNiH8ORnyU0LWaqy+mHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxozD-00000002mgp-2fkZ;
	Mon, 07 Oct 2024 14:45:23 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxoty-00000002lbM-1xbD;
	Mon, 07 Oct 2024 14:39:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CC86BA41475;
	Mon,  7 Oct 2024 14:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D2CC4CED2;
	Mon,  7 Oct 2024 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728311997;
	bh=xIKmFdsKl3VoJoRVa+lTTRtmFAYUymUeG0NPSdB4qkM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sfa4o+1olqcPgJpIaH+SDfJrdsUpJdOjPkMbApZLOfM4xIJ08b/N4llmtg1XjlbUu
	 JQe6E0lhXk1HoH8ekYKUyTePuwYCexJxCDXkGP/StWz/VrYUs1qseXDOiL2z7v9GpG
	 iJD9d/e9AgP2dG9KaDC2VQ22oYOeYuGwSyhvw1dq+VZShyEAAjjGCaAWwyfZnnqfEe
	 Dg7Jf9QGs8lH9mfxVpSXLTotHNRX+qAh12ZrS8egHx4FUywBS4Q8QKhDeLtPPlVD1f
	 Jplv06X8RYwFa6ZsujT0tjQ29PTU/s0dfHmQsiPcFZd6jVj1zzNyF6c4Ie+//U28lS
	 l5dK+y1YBFPaA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53959a88668so5513954e87.2;
        Mon, 07 Oct 2024 07:39:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQPUty5PQZEQrpOwoEvm1qYHAouXWdqN6VLIipOeiwUW41SicAC0UzDCrzmIk7WqVnSMe3C+9RYhgZcrCxHLgpBQ==@lists.infradead.org, AJvYcCXAUDMN0mvyIDXYMqMIsDVlm/5tzfuODtIjI3msJtvae+aKuZTCpjsUWH/aNjiEuW8whY2Y5g==@lists.infradead.org
X-Gm-Message-State: AOJu0YzIN6smVtDEwY3pfdfBfIzcm4izlUgEbZHXcpioNVEZ1I3IRexL
	7AhVpRTy2Fed8UJK3HBtpXkMctg9eF1B+8qnXSe/+Ii/0b3TiB3kxOxJ+oTkHBcDwD4DHk0nFG1
	nFmGmp3wFQg05FSidyeiaAD6JOA==
X-Google-Smtp-Source: AGHT+IEG5q6+j+CeqLxaVJZa0oofLHHRdz/JFR71IlJpiAgKIbDzqEkmM0wZIXncpHj7oLyHzkEwSpYcacaGxALVOpk=
X-Received: by 2002:a05:6512:31ce:b0:52f:df:db40 with SMTP id
 2adb3069b0e04-539ab9ed4f8mr6140759e87.56.1728311995390; Mon, 07 Oct 2024
 07:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20241003113840.2972416-1-usamaarif642@gmail.com>
 <20241004000316.GA1910499-robh@kernel.org> <d3d90f10-1ccd-4557-843c-5b546d3b913c@gmail.com>
In-Reply-To: <d3d90f10-1ccd-4557-843c-5b546d3b913c@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 7 Oct 2024 09:39:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJVEjPt9tHNr0uAGHQwGnUbZDZoe7kURp3Qx0ce1jv+vw@mail.gmail.com>
Message-ID: <CAL_JsqJVEjPt9tHNr0uAGHQwGnUbZDZoe7kURp3Qx0ce1jv+vw@mail.gmail.com>
Subject: Re: [PATCH] of/kexec: save pa of initial_boot_params for arm64 and
 use it at kexec
To: Usama Arif <usamaarif642@gmail.com>
Cc: mark.rutland@arm.com, will@kernel.org, leitao@debian.org, 
	catalin.marinas@arm.com, saravanak@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_073958_653863_3BB09356 
X-CRM114-Status: GOOD (  27.65  )
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

T24gTW9uLCBPY3QgNywgMjAyNCBhdCA5OjA24oCvQU0gVXNhbWEgQXJpZiA8dXNhbWFhcmlmNjQy
QGdtYWlsLmNvbT4gd3JvdGU6Cj4KPgo+Cj4gT24gMDQvMTAvMjAyNCAwMTowMywgUm9iIEhlcnJp
bmcgd3JvdGU6Cj4gPiBPbiBUaHUsIE9jdCAwMywgMjAyNCBhdCAxMjozODo0MFBNICswMTAwLCBV
c2FtYSBBcmlmIHdyb3RlOgo+ID4+ICBfX3BhKCkgaXMgb25seSBpbnRlbmRlZCB0byBiZSB1c2Vk
IGZvciBsaW5lYXIgbWFwIGFkZHJlc3NlcyBhbmQgdXNpbmcKPiA+PiBpdCBmb3IgaW5pdGlhbF9i
b290X3BhcmFtcyB3aGljaCBpcyBpbiBmaXhtYXAgZm9yIGFybTY0IHdpbGwgZ2l2ZSBhbgo+ID4+
IGluY29ycmVjdCB2YWx1ZS4gSGVuY2Ugc3Rhc2ggdGhlIHBoeXNpY2FsIGFkZHJlc3Mgd2hlbiBp
dCBpcyBrbm93biBhdAo+ID4+IGJvb3QgdGltZSBhbmQgdXNlIGl0IGF0IGtleGVjIHRpbWUgaW5z
dGVhZCBvZiBjb252ZXJ0aW5nIHRoZSB2aXJ0dWFsCj4gPj4gYWRkcmVzcyB1c2luZyBfX3BhKCku
Cj4gPj4KPiA+PiBSZXBvcnRlZC1ieTogQnJlbm8gTGVpdGFvIDxsZWl0YW9AZGViaWFuLm9yZz4K
PiA+PiBTdWdnZXN0ZWQtYnk6IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+Cj4g
Pj4gU2lnbmVkLW9mZi1ieTogVXNhbWEgQXJpZiA8dXNhbWFhcmlmNjQyQGdtYWlsLmNvbT4KPiA+
PiBGaXhlczogYWMxMGJlNWNkYmZhICgiYXJtNjQ6IFVzZSBjb21tb24gb2Zfa2V4ZWNfYWxsb2Nf
YW5kX3NldHVwX2ZkdCgpIikKPiA+PiAtLS0KPiA+PiAgYXJjaC9hcm02NC9rZXJuZWwvc2V0dXAu
YyB8IDggKysrKysrKysKPiA+PiAgZHJpdmVycy9vZi9mZHQuYyAgICAgICAgICB8IDYgKysrKysr
Cj4gPj4gIGRyaXZlcnMvb2Yva2V4ZWMuYyAgICAgICAgfCA4ICsrKysrKy0tCj4gPj4gIGluY2x1
ZGUvbGludXgvb2ZfZmR0LmggICAgfCAyICsrCj4gPj4gIDQgZmlsZXMgY2hhbmdlZCwgMjIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+Pgo+ID4+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bTY0L2tlcm5lbC9zZXR1cC5jIGIvYXJjaC9hcm02NC9rZXJuZWwvc2V0dXAuYwo+ID4+IGluZGV4
IGIyMmQyOGVjODAyOC4uYTRkOTZmNWUyZTA1IDEwMDY0NAo+ID4+IC0tLSBhL2FyY2gvYXJtNjQv
a2VybmVsL3NldHVwLmMKPiA+PiArKysgYi9hcmNoL2FybTY0L2tlcm5lbC9zZXR1cC5jCj4gPj4g
QEAgLTE5NCw2ICsxOTQsMTQgQEAgc3RhdGljIHZvaWQgX19pbml0IHNldHVwX21hY2hpbmVfZmR0
KHBoeXNfYWRkcl90IGR0X3BoeXMpCj4gPj4gICAgICAvKiBFYXJseSBmaXh1cHMgYXJlIGRvbmUs
IG1hcCB0aGUgRkRUIGFzIHJlYWQtb25seSBub3cgKi8KPiA+PiAgICAgIGZpeG1hcF9yZW1hcF9m
ZHQoZHRfcGh5cywgJnNpemUsIFBBR0VfS0VSTkVMX1JPKTsKPiA+Pgo+ID4+ICsgICAgLyoKPiA+
PiArICAgICAqIFNhdmUgZHRfcGh5cyBhZGRyZXNzIHNvIHRoYXQgaXQgY2FuIGJlIHVzZWQgbGF0
ZXIgZm9yIGtleGVjLiBUaGlzCj4gPj4gKyAgICAgKiBpcyBkb25lIGFzIF9fcGEoKSBpcyBvbmx5
IGludGVuZGVkIHRvIGJlIHVzZWQgZm9yIGxpbmVhciBtYXAgYWRkcmVzc2VzCj4gPj4gKyAgICAg
KiBhbmQgdXNpbmcgaXQgZm9yIGluaXRpYWxfYm9vdF9wYXJhbXMgd2hpY2ggaXMgaW4gZml4bWFw
IHdpbGwgZ2l2ZSBhbgo+ID4+ICsgICAgICogaW5jb3JyZWN0IHZhbHVlLgo+ID4+ICsgICAgICov
Cj4gPj4gKyAgICBzZXRfaW5pdGlhbF9ib290X3BhcmFtc19wYShkdF9waHlzKTsKPiA+Cj4gPiBO
byBuZXcgYXJjaC0+ZHQgZnVuY3Rpb25zIHBsZWFzZS4gSWYgd2UgbmVlZCB0byBzYXZlIG9mZiB0
aGUgUEEsIHRoZW4gZG8KPiA+IHRoYXQgd2hlbiB3ZSBzZXQgaW5pdGlhbF9ib290X3BhcmFtcy4K
PiA+Cj4gPiBSb2IKPgo+Cj4gaW5pdGlhbF9ib290X3BhcmFtcyBpcyBzZXQgaW4gZWFybHlfaW5p
dF9kdF92ZXJpZnksIGNhbGxlZCBieSBlYXJseV9pbml0X2R0X3NjYW4uCj4gVGhpcyBpcyBkb25l
IGluIHNldHVwX21hY2hpbmVfZmR0IGluIGFybTY0IHdoZXJlIHRoZSBQQSBpcyBhdmFpbGFibGUs
Cj4gYnV0IGluIG90aGVyIGZ1bmN0aW9ucyBpbiBvdGhlciBhcmNoaXRlY3R1cmVzLCB3aGVyZSB0
aGUgUEEgaXMgbm90IGF2YWlsYWJsZS4KCkRvZXNuJ3QgX19wYSgpIHdvcmsgZm9yIGFsbCB0aGUg
b3RoZXIgYXJjaGl0ZWN0dXJlcz8gVGhhdCdzIHdoYXQgeW91cgpwYXRjaCBpbmRpY2F0ZXMuCgo+
IFNvIGl0IG1ha2VzIGl0IHF1aXRlIG1lc3N5IHRvIHNldCBpdCBpbiB0aGUgc2FtZSBwbGFjZSBh
cyBpbml0aWFsX2Jvb3RfcGFyYW1zLgo+IEl0cyBvbmx5IG5lZWRlZCBmb3IgYXJtNjQgYW5kIG1h
a2luZyBhIGNoYW5nZSBpbiBhbGwgYXJjaHMgcHJvYmFibHkgaXNudCBhIGdvb2QgaWRlYT8KPgo+
IEFueSByZWFzb24gdG8gbm90IGFkZCBhIG5ldyBmdW5jdGlvbiB0byBtYWtlIGFyY2ggLT4gb2Yv
ZmR0IGNhbGw/CgpZZXMuIEl0IGlzIHRoZSBvcHBvc2l0ZSBkaXJlY3Rpb24gSSBoYXZlIHJld29y
a2VkIHRoZSBpbnRlcmZhY2VzIHRvLgpXZSBkb24ndCB3YW50IGVhY2ggYXJjaCBjYWxsaW5nIHZh
cmlvdXMgZWFybHkgRFQgZnVuY3Rpb25zIGF0IHJhbmRvbQp0aW1lcyBhbmQgb3JkZXIuIFRoYXQn
cyBmcmFnaWxlIHdoZW4gdGhlIERUIGZ1bmN0aW9ucyBtYWtlIGFzc3VtcHRpb25zCmFib3V0IHdo
ZW4gdGhleSBhcmUgY2FsbGVkIG9yIHdoYXQncyBiZWVuIGluaXRpYWxpemVkIGFscmVhZHkuCgpB
bm90aGVyIG9wdGlvbiBpcyB0byBtYWtlIGFybTY0IGNvcHkgdGhlIERUIGFzIHNvbWUgYXJjaGVz
IGRvLgoKUm9iCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
