Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDF8EE49BD
	for <kexec@archiver.kernel.org>; Wed, 11 Sep 2024 14:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ARxfwSvL8QQ7nH1RrDUfOSFufYu1de4Kphdh65IhPkY=; b=odh1tNUPG9JhgZ
	HfFLwd9WLZ9hGt0yHsoQ1XKcG6WtYySkmCeebiG7MlwRXZfcVHnmMtrBCWSORd6cpntOPY917nAET
	gujCbenYS2VxqPjc5oTVyIB9keUt5D1Gircpc2u5DzUXCELG8u1zjXzaX/HIeKaRwS+beH4xaAl6C
	giGUlpiDpvoA5cxQPe0Rv1E1yQP8SnkmVoLLkpLQ/5t+5x3Gcj6taOQwId4uSAV71/iUbUp+G+Fjf
	42OOXmdYlE4e3LW24WqfEnUBQzeyuRw6vJdDMPJs4ovTjF7uqZz373p9UEr4/Jgl6U6lJZz4qd1UM
	It9ppAVY/5RZy2Nn/Z3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soOa6-00000009zIB-29wE;
	Wed, 11 Sep 2024 14:44:30 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soOQF-00000009vnH-0vS5
	for kexec@lists.infradead.org;
	Wed, 11 Sep 2024 14:34:20 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso194249066b.1
        for <kexec@lists.infradead.org>; Wed, 11 Sep 2024 07:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726065258; x=1726670058; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PVTuE5Ad6zPah/b8EIl3uFAmdBpE4CYkodOUlKK/R9c=;
        b=G0d7/L79xHJh/3SIdSddrqjclzKRIdXPtbHJnkH69NgZnZIH0bePvWOO5CAAHjSQWI
         uAgfyVWFB7xQ085hGhg4vs/soNix8MnE36rp6LJ0FOrLCHw7ORF+Nx+xre5mSoHQBUM6
         Zx6S1/F5SKHK6++5h9qvUS3HYoUybDsjMvGp8LBnv2aJvILVa7+dW83JDLwc1bFqFf4w
         0+eDH3RXiVC+CNh0L51b6NY0R3dGR2XUd6Q174CFghR9UT6oOJfgNVuD8n3L6EGMYt/v
         I7f74OBEz6VPHbI7vlWpQCO9pAa1NJh0QC6ZcpA0YILjbm6f8Ahu3QVaJXZzoo0FXMOS
         UDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726065258; x=1726670058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PVTuE5Ad6zPah/b8EIl3uFAmdBpE4CYkodOUlKK/R9c=;
        b=GRs5KtgZ/2RFfZaGbK0Oo3WGOWLMtoeSfpPS5sB1zAHCfN1gcS9WPt5kOhshkNzuwu
         ckgtF5f5ehmquxhq0bA1bQZSgVpvr1is+FsBMLFH3rlGE+PAUOpj5UOB3246jIorR/Td
         43mOdbOPo4MA5WbVXaVB4P1brI10j/4LNWDIbibB6jab2ESPAkxX3tAzYUairG+UyY55
         ulfoOrlrkRfsF4CtoVjIE+70JR0nrr8j0si66/6IdlM6tXMAkEYH38zUAXhNO/RvhXEO
         kAAdBKrsl20uMm2OPXf/UnbK41cew62DuNv2n3+rJ52uiIB/c5S/5MyvFqmyWTft1fTu
         f0/A==
X-Forwarded-Encrypted: i=1; AJvYcCUDMQkNRmoD17TzHGeNsU+6rJ6k4vtP1C7zfFGGucc6LRzcsZCF/F8Ri5IitiqVIixxqQ74Yw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzvC5dp+naxHiClp1exCOyiEQ+Py9B7ug5CX7eh+GSnrP8yWUfG
	Qr1OnDUf9nHsMAaa7UE8eQvWW/XAWiXU4vEmcSrFArVM2tL9EDci
X-Google-Smtp-Source: AGHT+IFWvH0mfTXi2x5OaLKLnSmNiGDqfGOGOCka3ud/AYA498nx/U9l4CG0TQPaUla3tH3QYSfjGQ==
X-Received: by 2002:a17:906:4fce:b0:a8d:6a35:5091 with SMTP id a640c23a62f3a-a8ffaac0a52mr483464966b.1.1726065256856;
        Wed, 11 Sep 2024 07:34:16 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::5:aa41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c7286esm613294166b.138.2024.09.11.07.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 07:34:16 -0700 (PDT)
Message-ID: <c80603d1-4604-486c-bd18-ccd4afaba57e@gmail.com>
Date: Wed, 11 Sep 2024 15:34:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io,
 kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com,
 vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org,
 rmikey@meta.com, gourry@gourry.net
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_073419_287911_D6287788 
X-CRM114-Status: GOOD (  25.81  )
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

CgpPbiAxMS8wOS8yMDI0IDEyOjUxLCBBcmQgQmllc2hldXZlbCB3cm90ZToKPiBPbiBXZWQsIDEx
IFNlcHQgMjAyNCBhdCAxMjo0MSwgVXNhbWEgQXJpZiA8dXNhbWFhcmlmNjQyQGdtYWlsLmNvbT4g
d3JvdGU6Cj4+Cj4+IExvb2tpbmcgYXQgdGhlIFRQTSBzcGVjIFsxXQo+Pgo+PiBJZiB0aGUgQUNQ
SSBUUE0yIHRhYmxlIGNvbnRhaW5zIHRoZSBhZGRyZXNzIGFuZCBzaXplIG9mIHRoZSBQbGF0Zm9y
bQo+PiBGaXJtd2FyZSBUQ0cgbG9nLCBmaXJtd2FyZSDigJxwaW5z4oCdIHRoZSBtZW1vcnkgYXNz
b2NpYXRlZCB3aXRoIHRoZQo+PiBQbGF0Zm9ybSBGaXJtd2FyZVRDRyBsb2csIGFuZCByZXBvcnRz
IHRoaXMgbWVtb3J5IGFzIOKAnFJlc2VydmVk4oCdIG1lbW9yeQo+PiB2aWEgdGhlIElOVCAxNWgv
RTgyMCBpbnRlcmZhY2UuCj4+Cj4+IEl0IGxvb2tzIGxpa2UgdGhlIGZpcm13YXJlIHNob3VsZCBw
YXNzIHRoaXMgYXMgcmVzZXJ2ZWQgaW4gZTgyMCBtZW1vcnkKPj4gbWFwLiBIb3dldmVyLCBpdCBk
b2Vzbid0IHNlZW0gdG8uIFRoZSBmaXJtd2FyZSBiZWluZyB0ZXN0ZWQgb24gaXM6Cj4+IGRtaWRl
Y29kZSAtcyBiaW9zLXZlcnNpb24KPj4gZWRrMi0yMDI0MDIxNC0yLmVsOQo+Pgo+PiBXaGVuIHRo
aXMgYXJlYSBpcyBub3QgcmVzZXJ2ZWQsIGl0IGNvbWVzIHVwIGFzIHVzYWJsZSBpbgo+PiAvc3lz
L2Zpcm13YXJlL21lbW1hcC4gVGhpcyBtZWFucyB0aGF0IGtleGVjLCB3aGljaCB1c2VzIHRoYXQg
bWVtbWFwCj4+IHRvIGZpbmQgdXNhYmxlIG1lbW9yeSByZWdpb25zLCBjYW4gc2VsZWN0IHRoZSBy
ZWdpb24gd2hlcmUgZWZpLnRwbV9sb2cKPj4gaXMgYW5kIG92ZXJ3cml0ZSBpdCBhbmQgcmVsb2Nh
dGVfa2VybmVsLgo+Pgo+PiBIYXZpbmcgYSBmaXggaW4gZmlybXdhcmUgY2FuIGJlIGRpZmZpY3Vs
dCB0byBnZXQgdGhyb3VnaC4gQXMgYSBzZWNvbmRhcnkKPj4gZml4LCB0aGlzIHBhdGNoIG1hcmtz
IHRoYXQgcmVnaW9uIGFzIHJlc2VydmVkIGluIGU4MjBfdGFibGVfZmlybXdhcmUgaWYgaXQKPj4g
aXMgY3VycmVudGx5IEU4MjBfVFlQRV9SQU0gc28gdGhhdCBrZXhlYyBkb2Vzbid0IHVzZSBpdCBm
b3Iga2VybmVsIHNlZ21lbnRzLgo+Pgo+PiBbMV0gaHR0cHM6Ly90cnVzdGVkY29tcHV0aW5nZ3Jv
dXAub3JnL3dwLWNvbnRlbnQvdXBsb2Fkcy9QQy1DbGllbnRQbGF0Zm9ybV9Qcm9maWxlX2Zvcl9U
UE1fMnAwX1N5c3RlbXNfdjQ5XzE2MTExNF9wdWJsaWMtcmV2aWV3LnBkZgo+Pgo+PiBTaWduZWQt
b2ZmLWJ5OiBVc2FtYSBBcmlmIDx1c2FtYWFyaWY2NDJAZ21haWwuY29tPgpGb3Jnb3QgdG8gYWRk
OgoKUmVwb3J0ZWQtYnk6IEJyZW5vIExlaXRhbyA8bGVpdGFvQGRlYmlhbi5vcmc+Cgo+IAo+IEkg
d291bGQgZXhwZWN0IHRoZSBFRkkgbWVtb3J5IG1hcCB0byBFODIwIGNvbnZlcnNpb24gaW1wbGVt
ZW50ZWQgaW4KPiB0aGUgRUZJIHN0dWIgdG8gdGFrZSBjYXJlIG9mIHRoaXMuCj4gCj4gSWYgeW91
IGFyZSBub3QgYm9vdGluZyB2aWEgdGhlIEVGSSBzdHViLCB0aGUgYm9vdGxvYWRlciBpcyBwZXJm
b3JtaW5nCj4gdGhpcyBjb252ZXJzaW9uLCBhbmQgc28gaXQgc2hvdWxkIGJlIGRvbmUgdGhlcmUg
aW5zdGVhZC4KPiAKSSB3aWxsIGxvb2sgaW50byB0aGlzIGFuZCByZXBvcnQgYmFjay4KVGhhbmtz
Cgo+IAo+PiAtLS0KPj4gIGFyY2gveDg2L2luY2x1ZGUvYXNtL2U4MjAvYXBpLmggfCAyICsrCj4+
ICBhcmNoL3g4Ni9rZXJuZWwvZTgyMC5jICAgICAgICAgIHwgNiArKysrKysKPj4gIGFyY2gveDg2
L3BsYXRmb3JtL2VmaS9lZmkuYyAgICAgfCA5ICsrKysrKysrKwo+PiAgZHJpdmVycy9maXJtd2Fy
ZS9lZmkvdHBtLmMgICAgICB8IDIgKy0KPj4gIGluY2x1ZGUvbGludXgvZWZpLmggICAgICAgICAg
ICAgfCA3ICsrKysrKysKPj4gIDUgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vZTgyMC9h
cGkuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2U4MjAvYXBpLmgKPj4gaW5kZXggMmU3NGE3ZjBl
OTM1Li40ZTlhYTI0ZjAzYmQgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2U4
MjAvYXBpLmgKPj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vZTgyMC9hcGkuaAo+PiBAQCAt
MTYsNiArMTYsOCBAQCBleHRlcm4gYm9vbCBlODIwX19tYXBwZWRfYWxsKHU2NCBzdGFydCwgdTY0
IGVuZCwgZW51bSBlODIwX3R5cGUgdHlwZSk7Cj4+Cj4+ICBleHRlcm4gdm9pZCBlODIwX19yYW5n
ZV9hZGQgICAodTY0IHN0YXJ0LCB1NjQgc2l6ZSwgZW51bSBlODIwX3R5cGUgdHlwZSk7Cj4+ICBl
eHRlcm4gdTY0ICBlODIwX19yYW5nZV91cGRhdGUodTY0IHN0YXJ0LCB1NjQgc2l6ZSwgZW51bSBl
ODIwX3R5cGUgb2xkX3R5cGUsIGVudW0gZTgyMF90eXBlIG5ld190eXBlKTsKPj4gK2V4dGVybiB1
NjQgIGU4MjBfX3JhbmdlX3VwZGF0ZV9maXJtd2FyZSh1NjQgc3RhcnQsIHU2NCBzaXplLCBlbnVt
IGU4MjBfdHlwZSBvbGRfdHlwZSwKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGVudW0gZTgyMF90eXBlIG5ld190eXBlKTsKPj4gIGV4dGVybiB1NjQgIGU4MjBfX3Jh
bmdlX3JlbW92ZSh1NjQgc3RhcnQsIHU2NCBzaXplLCBlbnVtIGU4MjBfdHlwZSBvbGRfdHlwZSwg
Ym9vbCBjaGVja190eXBlKTsKPj4gIGV4dGVybiB1NjQgIGU4MjBfX3JhbmdlX3VwZGF0ZV90YWJs
ZShzdHJ1Y3QgZTgyMF90YWJsZSAqdCwgdTY0IHN0YXJ0LCB1NjQgc2l6ZSwgZW51bSBlODIwX3R5
cGUgb2xkX3R5cGUsIGVudW0gZTgyMF90eXBlIG5ld190eXBlKTsKPj4KPj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2tlcm5lbC9lODIwLmMgYi9hcmNoL3g4Ni9rZXJuZWwvZTgyMC5jCj4+IGluZGV4
IDQ4OTNkMzBjZTQzOC4uOTEyNDAwMTYxNjIzIDEwMDY0NAo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJu
ZWwvZTgyMC5jCj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9lODIwLmMKPj4gQEAgLTUzOCw2ICs1
MzgsMTIgQEAgdTY0IF9faW5pdCBlODIwX19yYW5nZV91cGRhdGVfdGFibGUoc3RydWN0IGU4MjBf
dGFibGUgKnQsIHU2NCBzdGFydCwgdTY0IHNpemUsCj4+ICAgICAgICAgcmV0dXJuIF9fZTgyMF9f
cmFuZ2VfdXBkYXRlKHQsIHN0YXJ0LCBzaXplLCBvbGRfdHlwZSwgbmV3X3R5cGUpOwo+PiAgfQo+
Pgo+PiArdTY0IF9faW5pdCBlODIwX19yYW5nZV91cGRhdGVfZmlybXdhcmUodTY0IHN0YXJ0LCB1
NjQgc2l6ZSwgZW51bSBlODIwX3R5cGUgb2xkX3R5cGUsCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGVudW0gZTgyMF90eXBlIG5ld190eXBlKQo+PiArewo+PiArICAg
ICAgIHJldHVybiBfX2U4MjBfX3JhbmdlX3VwZGF0ZShlODIwX3RhYmxlX2Zpcm13YXJlLCBzdGFy
dCwgc2l6ZSwgb2xkX3R5cGUsIG5ld190eXBlKTsKPj4gK30KPj4gKwo+PiAgLyogUmVtb3ZlIGEg
cmFuZ2Ugb2YgbWVtb3J5IGZyb20gdGhlIEU4MjAgdGFibGU6ICovCj4+ICB1NjQgX19pbml0IGU4
MjBfX3JhbmdlX3JlbW92ZSh1NjQgc3RhcnQsIHU2NCBzaXplLCBlbnVtIGU4MjBfdHlwZSBvbGRf
dHlwZSwgYm9vbCBjaGVja190eXBlKQo+PiAgewo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvcGxh
dGZvcm0vZWZpL2VmaS5jIGIvYXJjaC94ODYvcGxhdGZvcm0vZWZpL2VmaS5jCj4+IGluZGV4IDg4
YTk2ODE2ZGU5YS4uYWE5NWY3N2Q3YTMwIDEwMDY0NAo+PiAtLS0gYS9hcmNoL3g4Ni9wbGF0Zm9y
bS9lZmkvZWZpLmMKPj4gKysrIGIvYXJjaC94ODYvcGxhdGZvcm0vZWZpL2VmaS5jCj4+IEBAIC0x
NzEsNiArMTcxLDE1IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBkb19hZGRfZWZpX21lbW1hcCh2b2lk
KQo+PiAgICAgICAgIGU4MjBfX3VwZGF0ZV90YWJsZShlODIwX3RhYmxlKTsKPj4gIH0KPj4KPj4g
Ky8qIFJlc2VydmUgZmlybXdhcmUgYXJlYSBpZiBpdCB3YXMgbWFya2VkIGFzIFJBTSAqLwo+PiAr
dm9pZCBhcmNoX3VwZGF0ZV9maXJtd2FyZV9hcmVhKHU2NCBhZGRyLCB1NjQgc2l6ZSkKPj4gK3sK
Pj4gKyAgICAgICBpZiAoZTgyMF9fZ2V0X2VudHJ5X3R5cGUoYWRkciwgYWRkciArIHNpemUpID09
IEU4MjBfVFlQRV9SQU0pIHsKPj4gKyAgICAgICAgICAgICAgIGU4MjBfX3JhbmdlX3VwZGF0ZV9m
aXJtd2FyZShhZGRyLCBzaXplLCBFODIwX1RZUEVfUkFNLCBFODIwX1RZUEVfUkVTRVJWRUQpOwo+
PiArICAgICAgICAgICAgICAgZTgyMF9fdXBkYXRlX3RhYmxlKGU4MjBfdGFibGVfZmlybXdhcmUp
Owo+PiArICAgICAgIH0KPj4gK30KPj4gKwo+PiAgLyoKPj4gICAqIEdpdmVuIGFkZF9lZmlfbWVt
bWFwIGRlZmF1bHRzIHRvIDAgYW5kIHRoZXJlIGlzIG5vIGFsdGVybmF0aXZlCj4+ICAgKiBlODIw
IG1lY2hhbmlzbSBmb3Igc29mdC1yZXNlcnZlZCBtZW1vcnksIGltcG9ydCB0aGUgZnVsbCBFRkkg
bWVtb3J5Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2VmaS90cG0uYyBiL2RyaXZl
cnMvZmlybXdhcmUvZWZpL3RwbS5jCj4+IGluZGV4IGU4ZDY5YmQ1NDhmMy4uOGU2ZTcxMzFkNzE4
IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL2VmaS90cG0uYwo+PiArKysgYi9kcml2
ZXJzL2Zpcm13YXJlL2VmaS90cG0uYwo+PiBAQCAtNjAsNiArNjAsNyBAQCBpbnQgX19pbml0IGVm
aV90cG1fZXZlbnRsb2dfaW5pdCh2b2lkKQo+PiAgICAgICAgIH0KPj4KPj4gICAgICAgICB0Ymxf
c2l6ZSA9IHNpemVvZigqbG9nX3RibCkgKyBsb2dfdGJsLT5zaXplOwo+PiArICAgICAgIGFyY2hf
dXBkYXRlX2Zpcm13YXJlX2FyZWEoZWZpLnRwbV9sb2csIHRibF9zaXplKTsKPj4gICAgICAgICBt
ZW1ibG9ja19yZXNlcnZlKGVmaS50cG1fbG9nLCB0Ymxfc2l6ZSk7Cj4+Cj4+ICAgICAgICAgaWYg
KGVmaS50cG1fZmluYWxfbG9nID09IEVGSV9JTlZBTElEX1RBQkxFX0FERFIpIHsKPj4gQEAgLTEw
Nyw0ICsxMDgsMyBAQCBpbnQgX19pbml0IGVmaV90cG1fZXZlbnRsb2dfaW5pdCh2b2lkKQo+PiAg
ICAgICAgIGVhcmx5X21lbXVubWFwKGxvZ190YmwsIHNpemVvZigqbG9nX3RibCkpOwo+PiAgICAg
ICAgIHJldHVybiByZXQ7Cj4+ICB9Cj4+IC0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
ZWZpLmggYi9pbmNsdWRlL2xpbnV4L2VmaS5oCj4+IGluZGV4IDZiZjNjNGZlODUxMS4uOWMyMzlj
ZGZmNzcxIDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2VmaS5oCj4+ICsrKyBiL2luY2x1
ZGUvbGludXgvZWZpLmgKPj4gQEAgLTEzNzEsNCArMTM3MSwxMSBAQCBleHRlcm4gc3RydWN0IGJs
b2NraW5nX25vdGlmaWVyX2hlYWQgZWZpdmFyX29wc19uaDsKPj4gIHZvaWQgZWZpdmFyc19nZW5l
cmljX29wc19yZWdpc3Rlcih2b2lkKTsKPj4gIHZvaWQgZWZpdmFyc19nZW5lcmljX29wc191bnJl
Z2lzdGVyKHZvaWQpOwo+Pgo+PiArI2lmZGVmIENPTkZJR19YODZfNjQKPj4gK3ZvaWQgX19pbml0
IGFyY2hfdXBkYXRlX2Zpcm13YXJlX2FyZWEodTY0IGFkZHIsIHU2NCBzaXplKTsKPj4gKyNlbHNl
Cj4+ICtzdGF0aWMgaW5saW5lIHZvaWQgX19pbml0IGFyY2hfdXBkYXRlX2Zpcm13YXJlX2FyZWEo
dTY0IGFkZHIsIHU2NCBzaXplKQo+PiArewo+PiArfQo+PiArI2VuZGlmCj4+ICAjZW5kaWYgLyog
X0xJTlVYX0VGSV9IICovCj4+IC0tCj4+IDIuNDMuNQo+PgoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8va2V4ZWMK
