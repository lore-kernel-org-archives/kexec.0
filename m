Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27FACFA44E
	for <kexec@archiver.kernel.org>; Wed, 23 Oct 2024 16:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EVmGXAKs84rVNjRg66yfDwBDAz0X8EAOTyvfMZV/LbI=; b=hmtL02oqvLod31
	iKskzQhgnv/qnOxc4rnDFzgJ/6Ljo5gVZ9RDhrAx4+hmqJqeQvetehjW9rHHGx1s90wB98f5nfWkE
	EsxO/MQdItMa/KawvZwFv2mNY39yrEi731x/J6H9aJPcsE5FeD8DBzDzcJ0rNkXFdL5T8X0z87Jot
	3IdzJOmTfUIIskDJkheBsqKQZWfwX0yu/josIXvUw3aZkKKrrbFiNtTOQaLEXkHvva+3ClS1yFpZ0
	8FU6uhz7htuuYbUZiEK0UcoWm4lkJEjtAgwhSsw4dcYLmBcyElNrQDiZR3JTcGqMvaTErLB6fyXFs
	Fz7U1iW4HSZY00SRPZ4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3dyd-0000000F5x2-1DC2;
	Wed, 23 Oct 2024 16:12:51 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3dDm-0000000EwjO-0Lwh;
	Wed, 23 Oct 2024 15:24:27 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a99f629a7aaso187030866b.1;
        Wed, 23 Oct 2024 08:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729697064; x=1730301864; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I8bsCbuYj3wrkY+HeSAAVlp5CC82l84u/ffkdl8Y/1g=;
        b=YGpmK5oD0trMSah8aPRZypBMyN6e0j8e/eChLo8TRb/fapCWHUcnoENnu/escVFTL1
         +9lB8p5dGvwh2JLOZm/7Aj20vBzi+Jkc5LWkzwkpkvl8k0gPsZEJRum+O85hybx4L5K1
         AF2Z/Rm/0FxWYfZ1/XJBmQIz3L282kO0IDy/jqkOFs39E36EnNoKGmlUQaVkUgf8FQsR
         F0Ou66UCo7cyS4Zurq2IGE3jPCjv3024oKYYiYrimSX/oAo15YdZK2EkOVMQo/fOS+Zc
         ZlpW7HamuQov1xgH5FpIDyP1c0EGRTWFfzTA0AIW+mE3wVEUAbBt9P8HcMfUObnZu4tU
         MRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697064; x=1730301864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8bsCbuYj3wrkY+HeSAAVlp5CC82l84u/ffkdl8Y/1g=;
        b=ikGG9K+vklmjOCLxTYtxUL0KIVlg6Yc3Q5NocQbhA2FebReuGxxqyxjv/ph/kQDH9U
         V23hpF5bPXRp6iO7KD/ONDPIBf1AZXJJoIYjzCL9M5QGae21zTAUMr7eZKsH+TXz5sek
         7FtuItno0IdjGWKeSdkSfBsjf2UCMukbTYr2s7f/qynNJFZaiOB9oXDQF9714rSWHcfm
         EWEZRs6GmogBML6RSZme8hvnRhKqx06jdGqeJ64/CujnQ7ixEwHO8HuVGiZ4YebivD6y
         euWR/gsawQBT1nCU8R81VQx0Pf+wvijj0F+rFwJYV5q2rPe+K0mERjbD+MRHloEiRHvD
         qqyA==
X-Forwarded-Encrypted: i=1; AJvYcCWjOZRylhFW1lpbMLlwxLjPPh+29bJOUjBdXbzjbSbXbO8aIldMqdMTbXBSoOD8ht0QngopHg==@lists.infradead.org, AJvYcCXr7nDxOY2KEAnBoudVqFXfy3j6i1zSzFjXOJ2MlHj/WVCudqMe2Z8hHmzhaKtLZ/6c/6uoBfyII2qgOJMudoDKNg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzeyHUFx2JQmHS9WLolZe2zOJrR5aLUjk9WNucEfwiR3hDXvD7X
	krhrjqBwsl2VcZmSCsENLUh2WpcYZBVb80Z3Sxea67H/lwBOQslV
X-Google-Smtp-Source: AGHT+IGLxU7wxiCH3a1b/uHVpe3fD6Af7zQszRgnPFbDSKYaGfHilRmwG2cZ7GC2/X4IxrDdkB/rog==
X-Received: by 2002:a17:907:6d0c:b0:a8d:2281:94d9 with SMTP id a640c23a62f3a-a9aaa620d72mr822955666b.23.1729697063565;
        Wed, 23 Oct 2024 08:24:23 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:ca73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91559b33sm487702366b.116.2024.10.23.08.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 08:24:23 -0700 (PDT)
Message-ID: <237a32b7-e2c9-4db4-9358-918ce54da779@gmail.com>
Date: Wed, 23 Oct 2024 16:24:22 +0100
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
 <1e117d65-b454-4d5c-b03a-c3ab3b078093@gmail.com>
 <CAL_JsqJhd0X+eCW6WgXUjCLb-dBqHN4_01vzRRLU07Wz5Q2tLw@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAL_JsqJhd0X+eCW6WgXUjCLb-dBqHN4_01vzRRLU07Wz5Q2tLw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_082426_164415_0A67288E 
X-CRM114-Status: GOOD (  35.84  )
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

CgpPbiAyMy8xMC8yMDI0IDE2OjE3LCBSb2IgSGVycmluZyB3cm90ZToKPiBPbiBXZWQsIE9jdCAy
MywgMjAyNCBhdCA5OjQz4oCvQU0gVXNhbWEgQXJpZiA8dXNhbWFhcmlmNjQyQGdtYWlsLmNvbT4g
d3JvdGU6Cj4+Cj4+Cj4+Cj4+IE9uIDIzLzEwLzIwMjQgMTQ6NDAsIFJvYiBIZXJyaW5nIHdyb3Rl
Ogo+Pj4gT24gTW9uLCBPY3QgNywgMjAyNCBhdCAxMDozMOKAr0FNIFVzYW1hIEFyaWYgPHVzYW1h
YXJpZjY0MkBnbWFpbC5jb20+IHdyb3RlOgo+Pj4+Cj4+Pj4KPj4+Pgo+Pj4+IE9uIDA3LzEwLzIw
MjQgMTU6MzksIFJvYiBIZXJyaW5nIHdyb3RlOgo+Pj4+PiBPbiBNb24sIE9jdCA3LCAyMDI0IGF0
IDk6MDbigK9BTSBVc2FtYSBBcmlmIDx1c2FtYWFyaWY2NDJAZ21haWwuY29tPiB3cm90ZToKPj4+
Pj4+Cj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IE9uIDA0LzEwLzIwMjQgMDE6MDMsIFJvYiBIZXJyaW5n
IHdyb3RlOgo+Pj4+Pj4+IE9uIFRodSwgT2N0IDAzLCAyMDI0IGF0IDEyOjM4OjQwUE0gKzAxMDAs
IFVzYW1hIEFyaWYgd3JvdGU6Cj4+Pj4+Pj4+ICBfX3BhKCkgaXMgb25seSBpbnRlbmRlZCB0byBi
ZSB1c2VkIGZvciBsaW5lYXIgbWFwIGFkZHJlc3NlcyBhbmQgdXNpbmcKPj4+Pj4+Pj4gaXQgZm9y
IGluaXRpYWxfYm9vdF9wYXJhbXMgd2hpY2ggaXMgaW4gZml4bWFwIGZvciBhcm02NCB3aWxsIGdp
dmUgYW4KPj4+Pj4+Pj4gaW5jb3JyZWN0IHZhbHVlLiBIZW5jZSBzdGFzaCB0aGUgcGh5c2ljYWwg
YWRkcmVzcyB3aGVuIGl0IGlzIGtub3duIGF0Cj4+Pj4+Pj4+IGJvb3QgdGltZSBhbmQgdXNlIGl0
IGF0IGtleGVjIHRpbWUgaW5zdGVhZCBvZiBjb252ZXJ0aW5nIHRoZSB2aXJ0dWFsCj4+Pj4+Pj4+
IGFkZHJlc3MgdXNpbmcgX19wYSgpLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBSZXBvcnRlZC1ieTogQnJl
bm8gTGVpdGFvIDxsZWl0YW9AZGViaWFuLm9yZz4KPj4+Pj4+Pj4gU3VnZ2VzdGVkLWJ5OiBNYXJr
IFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPgo+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBV
c2FtYSBBcmlmIDx1c2FtYWFyaWY2NDJAZ21haWwuY29tPgo+Pj4+Pj4+PiBGaXhlczogYWMxMGJl
NWNkYmZhICgiYXJtNjQ6IFVzZSBjb21tb24gb2Zfa2V4ZWNfYWxsb2NfYW5kX3NldHVwX2ZkdCgp
IikKPj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4+ICBhcmNoL2FybTY0L2tlcm5lbC9zZXR1cC5jIHwgOCAr
KysrKysrKwo+Pj4+Pj4+PiAgZHJpdmVycy9vZi9mZHQuYyAgICAgICAgICB8IDYgKysrKysrCj4+
Pj4+Pj4+ICBkcml2ZXJzL29mL2tleGVjLmMgICAgICAgIHwgOCArKysrKystLQo+Pj4+Pj4+PiAg
aW5jbHVkZS9saW51eC9vZl9mZHQuaCAgICB8IDIgKysKPj4+Pj4+Pj4gIDQgZmlsZXMgY2hhbmdl
ZCwgMjIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4+Pj4+Pj4KPj4+Pj4+Pj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQva2VybmVsL3NldHVwLmMgYi9hcmNoL2FybTY0L2tlcm5lbC9z
ZXR1cC5jCj4+Pj4+Pj4+IGluZGV4IGIyMmQyOGVjODAyOC4uYTRkOTZmNWUyZTA1IDEwMDY0NAo+
Pj4+Pj4+PiAtLS0gYS9hcmNoL2FybTY0L2tlcm5lbC9zZXR1cC5jCj4+Pj4+Pj4+ICsrKyBiL2Fy
Y2gvYXJtNjQva2VybmVsL3NldHVwLmMKPj4+Pj4+Pj4gQEAgLTE5NCw2ICsxOTQsMTQgQEAgc3Rh
dGljIHZvaWQgX19pbml0IHNldHVwX21hY2hpbmVfZmR0KHBoeXNfYWRkcl90IGR0X3BoeXMpCj4+
Pj4+Pj4+ICAgICAgLyogRWFybHkgZml4dXBzIGFyZSBkb25lLCBtYXAgdGhlIEZEVCBhcyByZWFk
LW9ubHkgbm93ICovCj4+Pj4+Pj4+ICAgICAgZml4bWFwX3JlbWFwX2ZkdChkdF9waHlzLCAmc2l6
ZSwgUEFHRV9LRVJORUxfUk8pOwo+Pj4+Pj4+Pgo+Pj4+Pj4+PiArICAgIC8qCj4+Pj4+Pj4+ICsg
ICAgICogU2F2ZSBkdF9waHlzIGFkZHJlc3Mgc28gdGhhdCBpdCBjYW4gYmUgdXNlZCBsYXRlciBm
b3Iga2V4ZWMuIFRoaXMKPj4+Pj4+Pj4gKyAgICAgKiBpcyBkb25lIGFzIF9fcGEoKSBpcyBvbmx5
IGludGVuZGVkIHRvIGJlIHVzZWQgZm9yIGxpbmVhciBtYXAgYWRkcmVzc2VzCj4+Pj4+Pj4+ICsg
ICAgICogYW5kIHVzaW5nIGl0IGZvciBpbml0aWFsX2Jvb3RfcGFyYW1zIHdoaWNoIGlzIGluIGZp
eG1hcCB3aWxsIGdpdmUgYW4KPj4+Pj4+Pj4gKyAgICAgKiBpbmNvcnJlY3QgdmFsdWUuCj4+Pj4+
Pj4+ICsgICAgICovCj4+Pj4+Pj4+ICsgICAgc2V0X2luaXRpYWxfYm9vdF9wYXJhbXNfcGEoZHRf
cGh5cyk7Cj4+Pj4+Pj4KPj4+Pj4+PiBObyBuZXcgYXJjaC0+ZHQgZnVuY3Rpb25zIHBsZWFzZS4g
SWYgd2UgbmVlZCB0byBzYXZlIG9mZiB0aGUgUEEsIHRoZW4gZG8KPj4+Pj4+PiB0aGF0IHdoZW4g
d2Ugc2V0IGluaXRpYWxfYm9vdF9wYXJhbXMuCj4+Pj4+Pj4KPj4+Pj4+PiBSb2IKPj4+Pj4+Cj4+
Pj4+Pgo+Pj4+Pj4gaW5pdGlhbF9ib290X3BhcmFtcyBpcyBzZXQgaW4gZWFybHlfaW5pdF9kdF92
ZXJpZnksIGNhbGxlZCBieSBlYXJseV9pbml0X2R0X3NjYW4uCj4+Pj4+PiBUaGlzIGlzIGRvbmUg
aW4gc2V0dXBfbWFjaGluZV9mZHQgaW4gYXJtNjQgd2hlcmUgdGhlIFBBIGlzIGF2YWlsYWJsZSwK
Pj4+Pj4+IGJ1dCBpbiBvdGhlciBmdW5jdGlvbnMgaW4gb3RoZXIgYXJjaGl0ZWN0dXJlcywgd2hl
cmUgdGhlIFBBIGlzIG5vdCBhdmFpbGFibGUuCj4+Pj4+Cj4+Pj4+IERvZXNuJ3QgX19wYSgpIHdv
cmsgZm9yIGFsbCB0aGUgb3RoZXIgYXJjaGl0ZWN0dXJlcz8gVGhhdCdzIHdoYXQgeW91cgo+Pj4+
PiBwYXRjaCBpbmRpY2F0ZXMuCj4+Pj4+Cj4+Pj4KPj4+PiBZZXMsIF9fcGEoKSB3b3JrcyBmb3Ig
YWxsIG90aGVyIGFyY2hpdGVjdHVyZXMuCj4+Pj4KPj4+PiBCdXQgd2Ugd291bGQgbmVlZCB0byBh
ZGQgaW5pdGlhbF9ib290X3BhcmFtc19wYSBvZiB0eXBlIHBoeXNfYWRkcl90Cj4+Pj4gYXMgYW4g
YXJndW1lbnQgZm9yIGVhcmx5X2luaXRfZHRfc2Nhbiwgd2hpY2ggaXMgY2FsbGVkIGJ5IGFsbCBv
dGhlciBhcmNocywKPj4+PiBhbmQgd2UgdGVjaG5pY2FsbHkgY2FudCB1c2UgMCBhcyBhbiBpbnZh
bGlkIHZhbHVlLgo+Pj4+Cj4+Pj4gV2UgY291bGQgY29udmVydCBpbml0aWFsX2Jvb3RfcGFyYW1z
X3BhIHRvIHZvaWQgKiwgYW5kIHBhc3MgTlVMTCBmb3IgYWxsCj4+Pj4gb3RoZXIgYXJjaHMuIEJ1
dCBhZ2FpbiwgSSBkb24ndCByZWFsbHkgdGhpbmsgd2Ugc2hvdWxkIGJlIGNoYW5naW5nIHRoZQo+
Pj4+IGVhcmx5X2luaXRfZHRfc2NhbihkdF92aXJ0KSBjYWxsIGluIGFsbCBvdGhlciBhcmNocyB0
bwo+Pj4+IGVhcmx5X2luaXRfZHRfc2NhbihkdF92aXJ0LCBOVUxMKSBqdXN0IHRvIHNhdmUgaW5p
dGlhbF9ib290X3BhcmFtc19wYQo+Pj4+IGluIGFybTY0Pwo+Pj4+Cj4+Pj4+PiBTbyBpdCBtYWtl
cyBpdCBxdWl0ZSBtZXNzeSB0byBzZXQgaXQgaW4gdGhlIHNhbWUgcGxhY2UgYXMgaW5pdGlhbF9i
b290X3BhcmFtcy4KPj4+Pj4+IEl0cyBvbmx5IG5lZWRlZCBmb3IgYXJtNjQgYW5kIG1ha2luZyBh
IGNoYW5nZSBpbiBhbGwgYXJjaHMgcHJvYmFibHkgaXNudCBhIGdvb2QgaWRlYT8KPj4+Pj4+Cj4+
Pj4+PiBBbnkgcmVhc29uIHRvIG5vdCBhZGQgYSBuZXcgZnVuY3Rpb24gdG8gbWFrZSBhcmNoIC0+
IG9mL2ZkdCBjYWxsPwo+Pj4+Pgo+Pj4+PiBZZXMuIEl0IGlzIHRoZSBvcHBvc2l0ZSBkaXJlY3Rp
b24gSSBoYXZlIHJld29ya2VkIHRoZSBpbnRlcmZhY2VzIHRvLgo+Pj4+PiBXZSBkb24ndCB3YW50
IGVhY2ggYXJjaCBjYWxsaW5nIHZhcmlvdXMgZWFybHkgRFQgZnVuY3Rpb25zIGF0IHJhbmRvbQo+
Pj4+PiB0aW1lcyBhbmQgb3JkZXIuIFRoYXQncyBmcmFnaWxlIHdoZW4gdGhlIERUIGZ1bmN0aW9u
cyBtYWtlIGFzc3VtcHRpb25zCj4+Pj4+IGFib3V0IHdoZW4gdGhleSBhcmUgY2FsbGVkIG9yIHdo
YXQncyBiZWVuIGluaXRpYWxpemVkIGFscmVhZHkuCj4+Pj4+Cj4+Pj4+IEFub3RoZXIgb3B0aW9u
IGlzIHRvIG1ha2UgYXJtNjQgY29weSB0aGUgRFQgYXMgc29tZSBhcmNoZXMgZG8uCj4+Pj4+Cj4+
Pj4+IFJvYgo+Pj4+Cj4+Pj4gQWggbWF5YmUgSSBkaWRuJ3QgdW5kZXJzdGFuZCB0aGlzIHByb3Bl
cmx5LCBidXQgaXNudCBlYXJseV9pbml0X2R0X3NjYW4gYW4KPj4+PiBhcmNoIC0+IG9mL2ZkdCBp
bnRlcmZhY2VzLiBzZXRfaW5pdGlhbF9ib290X3BhcmFtc19wYSBpcyBhIHNpbWlsYXIgaW50ZXJm
YWNlCj4+Pj4gdG8gZWFybHlfaW5pdF9kdF9zY2FuPwo+Pj4KPj4+IFllcywgYW5kIEkgZG9uJ3Qg
d2FudCBtb3JlIEFQSXMgaWYgdGhleSBjYW4gYmUgYXZvaWRlZC4gV2hlbiBpcwo+Pj4gc2V0X2lu
aXRpYWxfYm9vdF9wYXJhbXNfcGEoKSBzdXBwb3NlZCB0byBiZSBjYWxsZWQ/IElzIGl0IGJlZm9y
ZSBvcgo+Pj4gYWZ0ZXIgZWFybHlfaW5pdF9kdF9zY2FuKCk/Cj4+Cj4+IEl0cyBvbmx5IG5lZWRl
ZCBpbiBhcm02NCwgYW5kIGNhbiBiZSBlaXRoZXIgYmVmb3JlIG9yIGFmdGVyLCBhcyBsb25nIGFz
IGl0cwo+PiBzb21ld2hlcmUgaW4gc2V0dXBfbWFjaGluZV9mZHQsIHdoZXJlIGR0X3BoeXMgaXMg
YXZhaWxhYmxlLgo+IAo+IE1heWJlIG9ubHkgYXJtNjQgdG9kYXkuIFdoYXQgaGFwcGVucyB3aGVu
IHJpc2N2IGRlY2lkZXMgdGhleSB0b28gd2FudAo+IHRvIHN1cHBvcnQgdGhlIERUIGFueXdoZXJl
IGluIG1lbW9yeSBpbmNsdWRpbmcgb3V0c2lkZSB0aGUgbGluZWFyCj4gYWRkcmVzcyBtYXAgYW5k
IHRoZW4gdGhleSBuZWVkIHRoZSBzYW1lIHRoaW5nLgo+IAo+Pj4gQ2FuIHN1YnNlcXVlbnQgT0Yg
ZnVuY3Rpb25zIGFzc3VtZSB0aGUgUEEKPj4+IGlzIHZhbGlkPwo+Pgo+PiBBZnRlciBzZXRfaW5p
dGlhbF9ib290X3BhcmFtc19wYSBoYXMgYmVlbiBjYWxsZWQsIHllcy4KPiAKPiBIb3cgZG8gSSBr
bm93IGl0IGhhcyBiZWVuIGNhbGxlZD8gRG8gSSBoYXZlIHRvIGdvIHdhZGUgdGhydSBldmVyeSBh
cmNoCj4gdG8gc2VlPyBZb3UgY291bGQgZG9jdW1lbnQgdGhlIHJlcXVpcmVtZW50IHRvIGJlIGlt
bWVkaWF0ZWx5IGFmdGVyCj4gZWFybHlfaW5pdF9kdF9zY2FuKCksIGJ1dCB0aGVuIGhvdyBkbyB5
b3UgZW5mb3JjZSB0aGF0PyBZb3UgY2FuJ3QKPiB1bmxlc3MgeW91IGRlc2lnbiB0aGUgaW50ZXJm
YWNlIHRvIGp1c3QgYXZvaWQgdGhlIHByb2JsZW0gaW4gdGhlIGZpcnN0Cj4gcGxhY2UuCj4gCj4+
PiBJZiBhbiBhcmNoIGRvZXNuJ3QgY2FsbCBzZXRfaW5pdGlhbF9ib290X3BhcmFtc19wYSgpIGlz
Cj4+PiBfX3BhKCkgdmFsaWQgb3IgZGlkIHRoZXkganVzdCBmb3JnZXQgdG8gY2FsbCBpdD8KPj4K
Pj4gT25seSBhcm02NCBzZWVtcyB0byBkbyB0aGUgZml4bWFwIGFzIGRpc2N1c3NlZCBpbgo+PiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMWVhNTUzOGYtN2U5Ni00MDM0LTlhZjktZTJkNWZk
NzJlMDY5QGdtYWlsLmNvbS8sCj4+IHNvIF9fcGEgc2hvdWxkIHdvcmsgaW4gb3RoZXJzLgo+Pgo+
PiBSZXF1aXJpbmcgdGhlIFBBIHRvCj4+PiBiZSBzZXQgYXQgdGhlIHNhbWUgdGltZSBhcyBpbml0
aWFsX2Jvb3RfcGFyYW1zIGF2b2lkcyBhbGwgdGhvc2UgaXNzdWVzCj4+PiB3aXRoIGFueSBwZXJp
b2Qgb2YgdGltZSBoYXZpbmcgdGhlIFBBIGluY29ycmVjdC4KPj4+Cj4+Cj4+IEFyZSB5b3UgcmVj
b21tZW5kaW5nIEkgc2VuZCBhIHBhdGNoIHdoaWNoIGNoYW5nZXMgYWxsIGFyY2hzIHRvIGNhbGwK
Pj4gZWFybHlfaW5pdF9kdF9zY2FuKGR0X3ZpcnQsIE5VTEwpPwo+PiBvciBtYXliZSBlYXJseV9p
bml0X2R0X3NjYW4oZHRfdmlydCwgX19wYShkdF92aXJ0KSk/Cj4+IGFuZCBhcm0gdG8gY2FsbCBl
YXJseV9pbml0X2R0X3NjYW4oZHRfdmlydCwgZHRfcGh5cykuCj4gCj4gSSBiZWxpZXZlIHRoYXQn
cyB3aGF0IEkgc3VnZ2VzdGVkIGFscmVhZHksIHNvIHllcy4gV2hldGhlciBOVUxMIG9yCj4gX19w
YShkdF92aXJ0KSk/IF9fcGEoKSB3b3VsZCBiZSBiZXR0ZXIgYmVjYXVzZSB0aGVuIHRoZSBhcmNo
IGhhcyB0bwo+IHRoaW5rIGFib3V0IHdoZXRoZXIgdGhhdCBpcyByaWdodCBvciBub3QuCgoKU291
bmRzIGdvb2QhIFdpbGwgc2VuZCBhIHYyIHdpdGggdGhlIGNoYW5nZS4KClRoYW5rcwo+IAo+PiBI
YXBweSB0byBkbyBzZW5kIGEgdjIgd2l0aCB0aGF0IGlmIGl0cyB0aGUgd2F5IGZvcndhcmQsIGFs
dGhvdWdoIEkgZmVlbAo+PiBzZXRfaW5pdGlhbF9ib290X3BhcmFtc19wYSgpIGluIGp1c3Qgb25l
IGFyY2ggbWlnaHQgYmUgYmV0dGVyIHRoYW4KPj4gY2hhbmdpbmcgdGhpcyBmb3IgYWxsIGFyY2hz
Lgo+IAo+IFdlIGRvbid0IHdvcmsgYXJvdW5kIGtlcm5lbCBBUElzIGlmIHRoZXkgZG9uJ3QgbWVl
dCBjaGFuZ2luZyBuZWVkcy4gV2UKPiBjaGFuZ2UgdGhlbS4KPiAKPiBSb2IKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QK
a2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2tleGVjCg==
