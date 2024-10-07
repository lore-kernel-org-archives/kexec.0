Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8E5CFB446
	for <kexec@archiver.kernel.org>; Mon,  7 Oct 2024 15:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6VuVpQdG8XUZLsUHszLXyffG0eViiYOwIfmC330M+rU=; b=NgScONS65vSrhX
	PzGz+HrsFK4NwTH/zUUra215nNIaJogo5p2J/1mjYLMh4RISmDN8axoweELfoKU25R3oEw5uZdXJf
	SMsdGxhn5nLvMMxeJXGF0qXNGabjXBs1YQ9TkAOx//ZYlXBUHjobxTXo3FW+iCoqQzOtFDdszxX7I
	+ylIUD4gfATHGJetBLSpwB2MnePEbGj7KcOoUEv158vHUvdTdRaGzTqLn3o7q27AxuHcKNO+AXEYa
	wY5uixlYi1etnua95DldItoZ+j13DTu7ougX4nMt70fXTIP2kUhU+zFw9hB2xBDhYh0PnipZpTnQz
	FR1kewHVYTOwycYqJ3Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxpjB-00000002xhz-137v;
	Mon, 07 Oct 2024 15:32:53 +0000
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxpgm-00000002x26-1cgQ;
	Mon, 07 Oct 2024 15:30:25 +0000
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2fabfc06c26so39897491fa.2;
        Mon, 07 Oct 2024 08:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728315022; x=1728919822; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXLByxgQO38tEiqRKfkJDtPyksE44EY2/93lJNbxUPM=;
        b=PnbR9tovCsb6c83u+EXG7lZqxtInqvkDNSIJrfsshiFOoHlmOeS5tzvGDFRWC5RjAY
         zVbdo4npxyMz/AO9NIev+LwqBG5tu37vcISdPk/TmDfqQlxI9i5DmCdzlohJyY8n+9u+
         3ZP+aMjEogsn/NJZzjuloZm6Vd855rDd/Ezp16bIgIEwJ8KbKGvuFvn4utzDE8g8uY2y
         cs+FG7B5dKy19WRdcLui0ssT+N0UUcg5Q5mN7NnDr2XdPFPBawDrhDRtLU6o6OLMhBMZ
         L1Vki0jqDYZ5QEms7tzGHfXwL4nXot953Btryx3BkwRmUzIiIeuIL8NtouEMo8RuUxv1
         MQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728315022; x=1728919822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXLByxgQO38tEiqRKfkJDtPyksE44EY2/93lJNbxUPM=;
        b=jC0lu8u7yDf5NBSV9qId5hfPTVeHeCC6JvqroWlReQS/aoS6AC8iC66wDqn0+4EiJS
         9LKHVme93/A+juM+ssfDyXXF13g1vq0Ztrk9cGPZ00KRFaBgLqh7WrSrnablIq6VGTYA
         VDv0KLB6cz6mVkmkRnMAZRJGvG6XT8O00TtVoeaoZyGuU5YOHr71CMNUe1JG3QMN1N5B
         4/SUE0Iey6qx8/A7Tayw2mwhdxzDTS+eFWL7SG2m5to3onuE9UZVZNO2A3Eq/7ah/3+3
         VV2VPXFvMHjlSswtSgnob7LxjDuJtSflt5Gf7cpCinpOjMILMQj2T+PG5HUZkMM6kqY5
         O2NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN1gY34lrRfKuhIFAFxWIIWP8I3s+1BlntOZjPjiGn2+TKNwTa8CLgOtJBBUSkbnWFnRRMbUxVIsELLc91UH/ZuQ==@lists.infradead.org, AJvYcCXIv+Ge0tVLZ7j6gehyXKTalpZwq5haBOmGGAO57KoHjoIQjVonYz7spjhZSN2sPeeACYqt2w==@lists.infradead.org
X-Gm-Message-State: AOJu0YwYMvRr9N63+c3VjjioL/Y4U5cXsN1vYTD66WcV/ltAjmnoYFvU
	TRqNQXG/4O6S2j9U2DG7VfRWuGRnBYAgA9MGDVAwtDyNkNGLZZho2VBntQ==
X-Google-Smtp-Source: AGHT+IFzFcHLeJlu8dAi5eLHYzBkuPCqoVEGXKOk00hKW7JHJg1u6N9K9qAJKE3PQff6BeCe5jf0bg==
X-Received: by 2002:a05:6402:13cd:b0:5c4:a6f:9be7 with SMTP id 4fb4d7f45d1cf-5c8d2e397c1mr12425589a12.8.1728315009552;
        Mon, 07 Oct 2024 08:30:09 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:3232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eb5ebsm3426058a12.65.2024.10.07.08.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 08:30:09 -0700 (PDT)
Message-ID: <4b9456a3-47ea-4a00-92fe-131ccd80e550@gmail.com>
Date: Mon, 7 Oct 2024 16:30:08 +0100
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
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAL_JsqJVEjPt9tHNr0uAGHQwGnUbZDZoe7kURp3Qx0ce1jv+vw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_083024_450285_90740659 
X-CRM114-Status: GOOD (  25.31  )
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

CgpPbiAwNy8xMC8yMDI0IDE1OjM5LCBSb2IgSGVycmluZyB3cm90ZToKPiBPbiBNb24sIE9jdCA3
LCAyMDI0IGF0IDk6MDbigK9BTSBVc2FtYSBBcmlmIDx1c2FtYWFyaWY2NDJAZ21haWwuY29tPiB3
cm90ZToKPj4KPj4KPj4KPj4gT24gMDQvMTAvMjAyNCAwMTowMywgUm9iIEhlcnJpbmcgd3JvdGU6
Cj4+PiBPbiBUaHUsIE9jdCAwMywgMjAyNCBhdCAxMjozODo0MFBNICswMTAwLCBVc2FtYSBBcmlm
IHdyb3RlOgo+Pj4+ICBfX3BhKCkgaXMgb25seSBpbnRlbmRlZCB0byBiZSB1c2VkIGZvciBsaW5l
YXIgbWFwIGFkZHJlc3NlcyBhbmQgdXNpbmcKPj4+PiBpdCBmb3IgaW5pdGlhbF9ib290X3BhcmFt
cyB3aGljaCBpcyBpbiBmaXhtYXAgZm9yIGFybTY0IHdpbGwgZ2l2ZSBhbgo+Pj4+IGluY29ycmVj
dCB2YWx1ZS4gSGVuY2Ugc3Rhc2ggdGhlIHBoeXNpY2FsIGFkZHJlc3Mgd2hlbiBpdCBpcyBrbm93
biBhdAo+Pj4+IGJvb3QgdGltZSBhbmQgdXNlIGl0IGF0IGtleGVjIHRpbWUgaW5zdGVhZCBvZiBj
b252ZXJ0aW5nIHRoZSB2aXJ0dWFsCj4+Pj4gYWRkcmVzcyB1c2luZyBfX3BhKCkuCj4+Pj4KPj4+
PiBSZXBvcnRlZC1ieTogQnJlbm8gTGVpdGFvIDxsZWl0YW9AZGViaWFuLm9yZz4KPj4+PiBTdWdn
ZXN0ZWQtYnk6IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+Cj4+Pj4gU2lnbmVk
LW9mZi1ieTogVXNhbWEgQXJpZiA8dXNhbWFhcmlmNjQyQGdtYWlsLmNvbT4KPj4+PiBGaXhlczog
YWMxMGJlNWNkYmZhICgiYXJtNjQ6IFVzZSBjb21tb24gb2Zfa2V4ZWNfYWxsb2NfYW5kX3NldHVw
X2ZkdCgpIikKPj4+PiAtLS0KPj4+PiAgYXJjaC9hcm02NC9rZXJuZWwvc2V0dXAuYyB8IDggKysr
KysrKysKPj4+PiAgZHJpdmVycy9vZi9mZHQuYyAgICAgICAgICB8IDYgKysrKysrCj4+Pj4gIGRy
aXZlcnMvb2Yva2V4ZWMuYyAgICAgICAgfCA4ICsrKysrKy0tCj4+Pj4gIGluY2x1ZGUvbGludXgv
b2ZfZmR0LmggICAgfCAyICsrCj4+Pj4gIDQgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2tlcm5l
bC9zZXR1cC5jIGIvYXJjaC9hcm02NC9rZXJuZWwvc2V0dXAuYwo+Pj4+IGluZGV4IGIyMmQyOGVj
ODAyOC4uYTRkOTZmNWUyZTA1IDEwMDY0NAo+Pj4+IC0tLSBhL2FyY2gvYXJtNjQva2VybmVsL3Nl
dHVwLmMKPj4+PiArKysgYi9hcmNoL2FybTY0L2tlcm5lbC9zZXR1cC5jCj4+Pj4gQEAgLTE5NCw2
ICsxOTQsMTQgQEAgc3RhdGljIHZvaWQgX19pbml0IHNldHVwX21hY2hpbmVfZmR0KHBoeXNfYWRk
cl90IGR0X3BoeXMpCj4+Pj4gICAgICAvKiBFYXJseSBmaXh1cHMgYXJlIGRvbmUsIG1hcCB0aGUg
RkRUIGFzIHJlYWQtb25seSBub3cgKi8KPj4+PiAgICAgIGZpeG1hcF9yZW1hcF9mZHQoZHRfcGh5
cywgJnNpemUsIFBBR0VfS0VSTkVMX1JPKTsKPj4+Pgo+Pj4+ICsgICAgLyoKPj4+PiArICAgICAq
IFNhdmUgZHRfcGh5cyBhZGRyZXNzIHNvIHRoYXQgaXQgY2FuIGJlIHVzZWQgbGF0ZXIgZm9yIGtl
eGVjLiBUaGlzCj4+Pj4gKyAgICAgKiBpcyBkb25lIGFzIF9fcGEoKSBpcyBvbmx5IGludGVuZGVk
IHRvIGJlIHVzZWQgZm9yIGxpbmVhciBtYXAgYWRkcmVzc2VzCj4+Pj4gKyAgICAgKiBhbmQgdXNp
bmcgaXQgZm9yIGluaXRpYWxfYm9vdF9wYXJhbXMgd2hpY2ggaXMgaW4gZml4bWFwIHdpbGwgZ2l2
ZSBhbgo+Pj4+ICsgICAgICogaW5jb3JyZWN0IHZhbHVlLgo+Pj4+ICsgICAgICovCj4+Pj4gKyAg
ICBzZXRfaW5pdGlhbF9ib290X3BhcmFtc19wYShkdF9waHlzKTsKPj4+Cj4+PiBObyBuZXcgYXJj
aC0+ZHQgZnVuY3Rpb25zIHBsZWFzZS4gSWYgd2UgbmVlZCB0byBzYXZlIG9mZiB0aGUgUEEsIHRo
ZW4gZG8KPj4+IHRoYXQgd2hlbiB3ZSBzZXQgaW5pdGlhbF9ib290X3BhcmFtcy4KPj4+Cj4+PiBS
b2IKPj4KPj4KPj4gaW5pdGlhbF9ib290X3BhcmFtcyBpcyBzZXQgaW4gZWFybHlfaW5pdF9kdF92
ZXJpZnksIGNhbGxlZCBieSBlYXJseV9pbml0X2R0X3NjYW4uCj4+IFRoaXMgaXMgZG9uZSBpbiBz
ZXR1cF9tYWNoaW5lX2ZkdCBpbiBhcm02NCB3aGVyZSB0aGUgUEEgaXMgYXZhaWxhYmxlLAo+PiBi
dXQgaW4gb3RoZXIgZnVuY3Rpb25zIGluIG90aGVyIGFyY2hpdGVjdHVyZXMsIHdoZXJlIHRoZSBQ
QSBpcyBub3QgYXZhaWxhYmxlLgo+IAo+IERvZXNuJ3QgX19wYSgpIHdvcmsgZm9yIGFsbCB0aGUg
b3RoZXIgYXJjaGl0ZWN0dXJlcz8gVGhhdCdzIHdoYXQgeW91cgo+IHBhdGNoIGluZGljYXRlcy4K
PiAKClllcywgX19wYSgpIHdvcmtzIGZvciBhbGwgb3RoZXIgYXJjaGl0ZWN0dXJlcy4KCkJ1dCB3
ZSB3b3VsZCBuZWVkIHRvIGFkZCBpbml0aWFsX2Jvb3RfcGFyYW1zX3BhIG9mIHR5cGUgcGh5c19h
ZGRyX3QKYXMgYW4gYXJndW1lbnQgZm9yIGVhcmx5X2luaXRfZHRfc2Nhbiwgd2hpY2ggaXMgY2Fs
bGVkIGJ5IGFsbCBvdGhlciBhcmNocywKYW5kIHdlIHRlY2huaWNhbGx5IGNhbnQgdXNlIDAgYXMg
YW4gaW52YWxpZCB2YWx1ZS4KCldlIGNvdWxkIGNvbnZlcnQgaW5pdGlhbF9ib290X3BhcmFtc19w
YSB0byB2b2lkICosIGFuZCBwYXNzIE5VTEwgZm9yIGFsbApvdGhlciBhcmNocy4gQnV0IGFnYWlu
LCBJIGRvbid0IHJlYWxseSB0aGluayB3ZSBzaG91bGQgYmUgY2hhbmdpbmcgdGhlCmVhcmx5X2lu
aXRfZHRfc2NhbihkdF92aXJ0KSBjYWxsIGluIGFsbCBvdGhlciBhcmNocyB0bwplYXJseV9pbml0
X2R0X3NjYW4oZHRfdmlydCwgTlVMTCkganVzdCB0byBzYXZlIGluaXRpYWxfYm9vdF9wYXJhbXNf
cGEKaW4gYXJtNjQ/Cgo+PiBTbyBpdCBtYWtlcyBpdCBxdWl0ZSBtZXNzeSB0byBzZXQgaXQgaW4g
dGhlIHNhbWUgcGxhY2UgYXMgaW5pdGlhbF9ib290X3BhcmFtcy4KPj4gSXRzIG9ubHkgbmVlZGVk
IGZvciBhcm02NCBhbmQgbWFraW5nIGEgY2hhbmdlIGluIGFsbCBhcmNocyBwcm9iYWJseSBpc250
IGEgZ29vZCBpZGVhPwo+Pgo+PiBBbnkgcmVhc29uIHRvIG5vdCBhZGQgYSBuZXcgZnVuY3Rpb24g
dG8gbWFrZSBhcmNoIC0+IG9mL2ZkdCBjYWxsPwo+IAo+IFllcy4gSXQgaXMgdGhlIG9wcG9zaXRl
IGRpcmVjdGlvbiBJIGhhdmUgcmV3b3JrZWQgdGhlIGludGVyZmFjZXMgdG8uCj4gV2UgZG9uJ3Qg
d2FudCBlYWNoIGFyY2ggY2FsbGluZyB2YXJpb3VzIGVhcmx5IERUIGZ1bmN0aW9ucyBhdCByYW5k
b20KPiB0aW1lcyBhbmQgb3JkZXIuIFRoYXQncyBmcmFnaWxlIHdoZW4gdGhlIERUIGZ1bmN0aW9u
cyBtYWtlIGFzc3VtcHRpb25zCj4gYWJvdXQgd2hlbiB0aGV5IGFyZSBjYWxsZWQgb3Igd2hhdCdz
IGJlZW4gaW5pdGlhbGl6ZWQgYWxyZWFkeS4KPiAKPiBBbm90aGVyIG9wdGlvbiBpcyB0byBtYWtl
IGFybTY0IGNvcHkgdGhlIERUIGFzIHNvbWUgYXJjaGVzIGRvLgo+IAo+IFJvYgoKQWggbWF5YmUg
SSBkaWRuJ3QgdW5kZXJzdGFuZCB0aGlzIHByb3Blcmx5LCBidXQgaXNudCBlYXJseV9pbml0X2R0
X3NjYW4gYW4KYXJjaCAtPiBvZi9mZHQgaW50ZXJmYWNlcy4gc2V0X2luaXRpYWxfYm9vdF9wYXJh
bXNfcGEgaXMgYSBzaW1pbGFyIGludGVyZmFjZQp0byBlYXJseV9pbml0X2R0X3NjYW4/CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5n
IGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
