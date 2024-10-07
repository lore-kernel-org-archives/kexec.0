Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2801CCFB43F
	for <kexec@archiver.kernel.org>; Mon,  7 Oct 2024 13:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FZvWKOfxUmNgANYUO6beKaKIJ5plOYSYlAg5iDXytXo=; b=eZ6hhoyUwfVde1
	oAsRLEvT46AJ4O3mz5J8SO/CCu2vkgcnsENQjuyi2wGID5PbKU4QkfYD5F/inBEiG4oLNyXRFva9Q
	AEOyySIlexAmCAxS70EvTtxkZauhaKR+BTczUFYRkp4l9aum0DVx7kZdnSd6qaZlg3A+eCTCTNK7p
	A5WT3n8WWiFs4mlOexkFr+wlTIui4vR4AgWqu3OFifeIGiFV+NKC+KJMOvVXKWre6V2rij7VFkSb8
	zOqaRrXpDUcL5GZwrMu0EAjCnZEI3Y6bF+SdOiDpKyjrgvW1umqYhF60lhyFcCaTV29bkX1QqvcC+
	LSdS3nrf0JJklSUjnSdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxoD1-00000002alq-2r4D;
	Mon, 07 Oct 2024 13:55:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxoBj-00000002adf-0T6t;
	Mon, 07 Oct 2024 13:54:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=KNiHRpWauHu9OcSIyJvokmcQHWfA46j89wHk+iMIBZs=; b=DEwyaLP7DVI3TFeeiYj21/degB
	bK6+NWjUuKQnABtFhAJ57osyD1S4zVsp+905CST4IPY2ajWPC9B0fs4nFAzuZ8vYnztzfd1EnoKTp
	7zQ84K6VpxcEhdifvXn+OQGSaLvsZnDGhVA3BySidLWVcPJ+4hxbqWGBUNDzrcDp/TFDTgpTqNunH
	WAoYxQe05gXO5kZLIiv2ik/IbLhI1EhjOz7JbZYBPIsA0MKqVC/rUO917xcSA96FqxBQ8lqXyrTYW
	W56KGg+TWaT5gWIZSq1sandwx7h6YIzL2RDPnzLkJVOqsjGsdec4lhKNhl/k1Bq8M4c53NOItWm0u
	EdlPkoYg==;
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxoBg-00000004Qcm-0Pwf;
	Mon, 07 Oct 2024 13:54:13 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5c89f3e8a74so6265758a12.0;
        Mon, 07 Oct 2024 06:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728309249; x=1728914049; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KNiHRpWauHu9OcSIyJvokmcQHWfA46j89wHk+iMIBZs=;
        b=Qv3UVdP17SwT65HGpJ9CCg02geSRLcm3QWLlCa6dA1+T/pY1KW10rwiZmtqPKiZ/IU
         EbfhULiHTlYhcBkQI8QzesAV/AdtHRp/tgOffymzEExK1u1qIWg0YROVLXubBGutVpG5
         3R/mWG59QNrxIt7geOzNYlc/97YGQXrM0wtuqqcOtqcyZS3D55qD0pXFRYXgc5PMDnUA
         4ADPk/bZhWdmLh1P3uiPeDyAIJ0A+7KhTKtKlI4XGjHef6IRcnEJUMwcnZAbeR3goCme
         W3DEYpxiTI++THwLYTgiL8kgWsZjVdHd4Jk/lCzzEYvOBYtzKuFBc49m9vx9AAE/1WpZ
         7/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728309249; x=1728914049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KNiHRpWauHu9OcSIyJvokmcQHWfA46j89wHk+iMIBZs=;
        b=uHH5FyPPCXUEyOsxc25n593bERWatP8SyIMf14xBMauWdrILOEesyu7R8FhnVRPkP9
         wd+Ums2mzTrowe1NBdanQnGy+M+zgg/PTeZWqnfNCUT/qXAh/xv2CmihzWmVBzMS4fj+
         5HQIycD3iK3ka96UA/AZ3ezxkEQqw4f8LZCTCoq9weLL2k6+z100GMiusHVgw/0+2oPu
         NVgIUon0NvG8wgeNJufCwZdUweulQz1NuCOr0aa88NG0ELn4HtNz8WLLp2yoJRcUWqOG
         1hhhu7dw4tSo+qMc6LvfEjKhcATzri9cTt/ytFh19m59TcCwhOfRphvfVcR+QRa8knbq
         Su8A==
X-Forwarded-Encrypted: i=1; AJvYcCU/MpIDUfxtX9flSd0RuRl9AT7r4r87PY0uHBSz8HQvAMV5rTRz6seZ7Oh3DDRIT32qs/WwZA==@lists.infradead.org, AJvYcCUHEcv4gzK9jE0zmVvBAoP0a6Yjzgu0VldtbCRgx3yfDUKd+uKzBRFzA/QqVc47R2Ocz549B6idrgNJ/wK64fqvxw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxifrkfg/nTEimqgJTRXlBR1dNEkV//y1wE9u6XeKBwVDf6B5Hq
	TWajdcmihpvTxSqPu05I0EpVuS92SYGgnJzMOqPGdl5NoTyvulUh
X-Google-Smtp-Source: AGHT+IHgrGUczMQa3+R9ilrZq3kW3bNhNLENKx/l2whAtuGxXcGTe19KE/m40/AM1uUuiHqPJkvYkw==
X-Received: by 2002:a17:907:368a:b0:a8d:2b7a:ff44 with SMTP id a640c23a62f3a-a991bd7a0bcmr1209519566b.32.1728309248865;
        Mon, 07 Oct 2024 06:54:08 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:3232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a995138f458sm169603066b.209.2024.10.07.06.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 06:54:08 -0700 (PDT)
Message-ID: <b14ac6d4-9d29-4193-ac2f-7e7d7ae3a60a@gmail.com>
Date: Mon, 7 Oct 2024 14:54:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of/kexec: save pa of initial_boot_params for arm64 and
 use it at kexec
To: Saravana Kannan <saravanak@google.com>
Cc: mark.rutland@arm.com, will@kernel.org, leitao@debian.org,
 catalin.marinas@arm.com, robh@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org
References: <20241003113840.2972416-1-usamaarif642@gmail.com>
 <CAGETcx9r+VwMBt=Ra-+-ZFgO66DK1LGjbT8cXFZ7v-c-N20qTQ@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGETcx9r+VwMBt=Ra-+-ZFgO66DK1LGjbT8cXFZ7v-c-N20qTQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_145412_284830_730B19BC 
X-CRM114-Status: GOOD (  21.56  )
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

CgpPbiAwMy8xMC8yMDI0IDIxOjIwLCBTYXJhdmFuYSBLYW5uYW4gd3JvdGU6Cj4gT24gVGh1LCBP
Y3QgMywgMjAyNCBhdCA0OjM44oCvQU0gVXNhbWEgQXJpZiA8dXNhbWFhcmlmNjQyQGdtYWlsLmNv
bT4gd3JvdGU6Cj4+Cj4+ICBfX3BhKCkgaXMgb25seSBpbnRlbmRlZCB0byBiZSB1c2VkIGZvciBs
aW5lYXIgbWFwIGFkZHJlc3NlcyBhbmQgdXNpbmcKPj4gaXQgZm9yIGluaXRpYWxfYm9vdF9wYXJh
bXMgd2hpY2ggaXMgaW4gZml4bWFwIGZvciBhcm02NCB3aWxsIGdpdmUgYW4KPj4gaW5jb3JyZWN0
IHZhbHVlLiBIZW5jZSBzdGFzaCB0aGUgcGh5c2ljYWwgYWRkcmVzcyB3aGVuIGl0IGlzIGtub3du
IGF0Cj4+IGJvb3QgdGltZSBhbmQgdXNlIGl0IGF0IGtleGVjIHRpbWUgaW5zdGVhZCBvZiBjb252
ZXJ0aW5nIHRoZSB2aXJ0dWFsCj4+IGFkZHJlc3MgdXNpbmcgX19wYSgpLgo+Pgo+PiBSZXBvcnRl
ZC1ieTogQnJlbm8gTGVpdGFvIDxsZWl0YW9AZGViaWFuLm9yZz4KPj4gU3VnZ2VzdGVkLWJ5OiBN
YXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBVc2Ft
YSBBcmlmIDx1c2FtYWFyaWY2NDJAZ21haWwuY29tPgo+PiBGaXhlczogYWMxMGJlNWNkYmZhICgi
YXJtNjQ6IFVzZSBjb21tb24gb2Zfa2V4ZWNfYWxsb2NfYW5kX3NldHVwX2ZkdCgpIikKPj4gLS0t
Cj4+ICBhcmNoL2FybTY0L2tlcm5lbC9zZXR1cC5jIHwgOCArKysrKysrKwo+PiAgZHJpdmVycy9v
Zi9mZHQuYyAgICAgICAgICB8IDYgKysrKysrCj4+ICBkcml2ZXJzL29mL2tleGVjLmMgICAgICAg
IHwgOCArKysrKystLQo+PiAgaW5jbHVkZS9saW51eC9vZl9mZHQuaCAgICB8IDIgKysKPj4gIDQg
ZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4KPj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQva2VybmVsL3NldHVwLmMgYi9hcmNoL2FybTY0L2tlcm5lbC9z
ZXR1cC5jCj4+IGluZGV4IGIyMmQyOGVjODAyOC4uYTRkOTZmNWUyZTA1IDEwMDY0NAo+PiAtLS0g
YS9hcmNoL2FybTY0L2tlcm5lbC9zZXR1cC5jCj4+ICsrKyBiL2FyY2gvYXJtNjQva2VybmVsL3Nl
dHVwLmMKPj4gQEAgLTE5NCw2ICsxOTQsMTQgQEAgc3RhdGljIHZvaWQgX19pbml0IHNldHVwX21h
Y2hpbmVfZmR0KHBoeXNfYWRkcl90IGR0X3BoeXMpCj4+ICAgICAgICAgLyogRWFybHkgZml4dXBz
IGFyZSBkb25lLCBtYXAgdGhlIEZEVCBhcyByZWFkLW9ubHkgbm93ICovCj4+ICAgICAgICAgZml4
bWFwX3JlbWFwX2ZkdChkdF9waHlzLCAmc2l6ZSwgUEFHRV9LRVJORUxfUk8pOwo+Pgo+PiArICAg
ICAgIC8qCj4+ICsgICAgICAgICogU2F2ZSBkdF9waHlzIGFkZHJlc3Mgc28gdGhhdCBpdCBjYW4g
YmUgdXNlZCBsYXRlciBmb3Iga2V4ZWMuIFRoaXMKPj4gKyAgICAgICAgKiBpcyBkb25lIGFzIF9f
cGEoKSBpcyBvbmx5IGludGVuZGVkIHRvIGJlIHVzZWQgZm9yIGxpbmVhciBtYXAgYWRkcmVzc2Vz
Cj4+ICsgICAgICAgICogYW5kIHVzaW5nIGl0IGZvciBpbml0aWFsX2Jvb3RfcGFyYW1zIHdoaWNo
IGlzIGluIGZpeG1hcCB3aWxsIGdpdmUgYW4KPj4gKyAgICAgICAgKiBpbmNvcnJlY3QgdmFsdWUu
Cj4+ICsgICAgICAgICovCj4+ICsgICAgICAgc2V0X2luaXRpYWxfYm9vdF9wYXJhbXNfcGEoZHRf
cGh5cyk7Cj4+ICsKPj4gICAgICAgICBuYW1lID0gb2ZfZmxhdF9kdF9nZXRfbWFjaGluZV9uYW1l
KCk7Cj4+ICAgICAgICAgaWYgKCFuYW1lKQo+PiAgICAgICAgICAgICAgICAgcmV0dXJuOwo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9vZi9mZHQuYyBiL2RyaXZlcnMvb2YvZmR0LmMKPj4gaW5kZXgg
NGQ1MjhjMTBkZjNhLi45ZTMxMmI3YzI0NmUgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvb2YvZmR0
LmMKPj4gKysrIGIvZHJpdmVycy9vZi9mZHQuYwo+PiBAQCAtNDU3LDYgKzQ1Nyw3IEBAIGludCBf
X2luaXRkYXRhIGR0X3Jvb3RfYWRkcl9jZWxsczsKPj4gIGludCBfX2luaXRkYXRhIGR0X3Jvb3Rf
c2l6ZV9jZWxsczsKPj4KPj4gIHZvaWQgKmluaXRpYWxfYm9vdF9wYXJhbXMgX19yb19hZnRlcl9p
bml0Owo+PiArcGh5c19hZGRyX3QgaW5pdGlhbF9ib290X3BhcmFtc19wYSBfX3JvX2FmdGVyX2lu
aXQ7Cj4+Cj4+ICAjaWZkZWYgQ09ORklHX09GX0VBUkxZX0ZMQVRUUkVFCj4+Cj4+IEBAIC0xMTg1
LDYgKzExODYsMTEgQEAgYm9vbCBfX2luaXQgZWFybHlfaW5pdF9kdF9zY2FuKHZvaWQgKnBhcmFt
cykKPj4gICAgICAgICByZXR1cm4gdHJ1ZTsKPj4gIH0KPj4KPj4gK3ZvaWQgX19pbml0IHNldF9p
bml0aWFsX2Jvb3RfcGFyYW1zX3BhKHBoeXNfYWRkcl90IHBhcmFtcykKPj4gK3sKPj4gKyAgICAg
ICBpbml0aWFsX2Jvb3RfcGFyYW1zX3BhID0gcGFyYW1zOwo+PiArfQo+PiArCj4+ICBzdGF0aWMg
dm9pZCAqX19pbml0IGNvcHlfZGV2aWNlX3RyZWUodm9pZCAqZmR0KQo+PiAgewo+PiAgICAgICAg
IGludCBzaXplOwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9vZi9rZXhlYy5jIGIvZHJpdmVycy9v
Zi9rZXhlYy5jCj4+IGluZGV4IDljY2RlMmZkNzdjYi4uY2E5ZjI3YjI3ZjcxIDEwMDY0NAo+PiAt
LS0gYS9kcml2ZXJzL29mL2tleGVjLmMKPj4gKysrIGIvZHJpdmVycy9vZi9rZXhlYy5jCj4+IEBA
IC0zMDAsOCArMzAwLDEyIEBAIHZvaWQgKm9mX2tleGVjX2FsbG9jX2FuZF9zZXR1cF9mZHQoY29u
c3Qgc3RydWN0IGtpbWFnZSAqaW1hZ2UsCj4+ICAgICAgICAgICAgICAgICBnb3RvIG91dDsKPj4g
ICAgICAgICB9Cj4+Cj4+IC0gICAgICAgLyogUmVtb3ZlIG1lbW9yeSByZXNlcnZhdGlvbiBmb3Ig
dGhlIGN1cnJlbnQgZGV2aWNlIHRyZWUuICovCj4+IC0gICAgICAgcmV0ID0gZmR0X2ZpbmRfYW5k
X2RlbF9tZW1fcnN2KGZkdCwgX19wYShpbml0aWFsX2Jvb3RfcGFyYW1zKSwKPj4gKyAgICAgICAv
KiBSZW1vdmUgbWVtb3J5IHJlc2VydmF0aW9uIGZvciB0aGUgY3VycmVudCBkZXZpY2UgdHJlZS4K
Pj4gKyAgICAgICAgKiBGb3IgYXJtNjQsIGluaXRpYWxfYm9vdF9wYXJhbXMgaXMgYSBmaXhtYXAg
YWRkcmVzcywgaGVuY2UgX19wYSgpLAo+PiArICAgICAgICAqIGNhbid0IGJlIHVzZWQgdG8gZ2V0
IHRoZSBwaHlzaWNhbCBhZGRyZXNzLgo+PiArICAgICAgICAqLwo+PiArICAgICAgIHJldCA9IGZk
dF9maW5kX2FuZF9kZWxfbWVtX3JzdihmZHQsIElTX0VOQUJMRUQoQ09ORklHX0FSTTY0KSA/Cj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluaXRpYWxfYm9vdF9wYXJh
bXNfcGEgOiBfX3BhKGluaXRpYWxfYm9vdF9wYXJhbXMpLAo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBmZHRfdG90YWxzaXplKGluaXRpYWxfYm9vdF9wYXJhbXMpKTsK
PiAKPiBOb3Qgc3VyZSBhYm91dCB0aGUgY29ycmVjdG5lc3Mgb2YgdGhlIHBhdGNoIChub3QgYSBr
ZXhlYyBleHBlcnQpIGJ1dAo+IG5vIG5lZWQgdG8gZG8gYWxsIG9mIHRoaXMgaW5zaWRlIGEgZnVu
Y3Rpb24gcGFyYW1ldGVyLiBKdXN0IGNyZWF0ZSBhCj4gdmFyaWFibGUgYW5kIHVzZSBpdCBoZXJl
Lgo+IAo+IC1TYXJhdmFuYQo+IAoKVGhhbmtzLCB3aWxsIGRvIGluIHRoZSBuZXh0IHJldmlzaW9u
LgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVj
IG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
