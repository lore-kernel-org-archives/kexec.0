Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04DDCF34C1
	for <kexec@archiver.kernel.org>; Thu,  3 Oct 2024 20:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N+je42462yLqxnbZm6T2lUH/HtW3s5s4cQHUvo2PKKM=; b=DPsCnaTw2P3QFQ
	aTSscLThIkymaBA/boz0qKHrAk0RWFjdH5KiZ49aft9rO3knIsDLaAfLlThHHxpcXPxtZ4wXr41Dk
	6CKYLxFF3WMZtZONDz1jq7GiU8n/9/K6FsR7Ms6dD22zBR5lzDQ1TUasC7KSczB0n+XxXAFcwdHm2
	pGKxNChLxtCQxWCZOzZ2+07Xfl3QtjEU35Ctakb7L/MVwiWlrnqul/uZ/mCGWL2RNGLi5mPrpxdfM
	yASgcK+qKNK0HaqwxehwrUg2lJjOw44nk94lRQC6r+XhLZvl6bleR4FpmbdvRl1GWJ6Qf8d+9CcUw
	ELQTCEd77okne2ost9Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swSL2-0000000AI5e-1wUH;
	Thu, 03 Oct 2024 20:22:16 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swSJk-0000000AHuR-2UeI
	for kexec@lists.infradead.org;
	Thu, 03 Oct 2024 20:20:58 +0000
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so502478a12.0
        for <kexec@lists.infradead.org>; Thu, 03 Oct 2024 13:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727986852; x=1728591652; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbiE8Fwcd7rX+QDGcaE2iE4PLXbaZTOlfpn9YTt6nAU=;
        b=eqpY37yj4K5+OnJBKv4nrePtjnmw1Jrm0NixPeOv8dLbUvr4Vs4oS0pyxke3GepREU
         tNBxFgV7XW3pCh68mx+O/OJ+i0geTFQ0f1yj1UG1EyQ72Gdqfb4LrHbAXXnCdui/CFD1
         sIKLlvStJE20k5DlW5iKw7RqgKiHueBubf9a7DofupELTcTq8RW7z+5/ucTKnctT/7Z5
         5DKtVfuHNNzjP/g4EM40PUVxS/gwA1lI6dGsz2Ex7VSDAGsfv624cuiYBuYUWW8DiDlG
         rq/VYJeLCm4OyrUL1L6LeFFLBS3RyylEVe3ilxx91apaxf3Tu+x9TcGayu/0b+KkMDRm
         +CJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727986852; x=1728591652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbiE8Fwcd7rX+QDGcaE2iE4PLXbaZTOlfpn9YTt6nAU=;
        b=YnkLgjP24C9hRWDIJ7sZPDpJbggFv/wBV8a9rA00MKAFxh2LEAH97DqOYI57jlSfD2
         HitKyFs+7rqaHtbnHaICV55e4DswegFnEQDvD580b84ivcRrfZFyDH7wa/Nm1vNrOXUR
         t5pk7FGbRXQKo1F7cNx43HtXbRYGrw9Fa/oyT0UZ1jjYVwkq23kCY/SVEoKmN+W88coA
         8olDLuDmtvpsg3ZoJJHHju0PpyiNzE2nlIDPR3ZrTWAxeWE1W0XTLnCBbMmRGi6QWzWE
         BLgJGuOHKcffOAm5rflls+jeHPSZELybywHKU5d4ZosmeJWytTWfXIYtw2s0TPvGpw8d
         cGtA==
X-Forwarded-Encrypted: i=1; AJvYcCXH2zz6Ua/Zsji537D+Y7lcdXLjQswMxjeEtowoelr2mi+27lo2x2zZadJB+wm0r5kQ3VVreQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzNkzi7aVaBa75aO35YLSukD3LhGdVYvBhVXByppbuiHLN8UgOX
	C76VQ7kI1R7BJuOBHmNRfivotdovsDaQSVp3RFQtcpeobqWrKeSMdivOxZbp8UBsNCl15R251Ce
	B7vojXvXxzgOTIb2q5ZT9KsaaI5QpCEjzpn6J
X-Google-Smtp-Source: AGHT+IGoii5GTavodnbmoAzteJqE0sqbwGfZNG8ANhg0hXL3IWG7GenPq51doRWMGZRSZaCvUyqDkTDMmm0zeloQ2x0=
X-Received: by 2002:a17:902:f68e:b0:20b:7a54:fe6f with SMTP id
 d9443c01a7336-20bff039e02mr4274625ad.50.1727986851673; Thu, 03 Oct 2024
 13:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20241003113840.2972416-1-usamaarif642@gmail.com>
In-Reply-To: <20241003113840.2972416-1-usamaarif642@gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 3 Oct 2024 13:20:10 -0700
Message-ID: <CAGETcx9r+VwMBt=Ra-+-ZFgO66DK1LGjbT8cXFZ7v-c-N20qTQ@mail.gmail.com>
Subject: Re: [PATCH] of/kexec: save pa of initial_boot_params for arm64 and
 use it at kexec
To: Usama Arif <usamaarif642@gmail.com>
Cc: mark.rutland@arm.com, will@kernel.org, leitao@debian.org, 
	catalin.marinas@arm.com, robh@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_132056_665253_0D6BB13F 
X-CRM114-Status: GOOD (  27.49  )
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

T24gVGh1LCBPY3QgMywgMjAyNCBhdCA0OjM44oCvQU0gVXNhbWEgQXJpZiA8dXNhbWFhcmlmNjQy
QGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiAgX19wYSgpIGlzIG9ubHkgaW50ZW5kZWQgdG8gYmUgdXNl
ZCBmb3IgbGluZWFyIG1hcCBhZGRyZXNzZXMgYW5kIHVzaW5nCj4gaXQgZm9yIGluaXRpYWxfYm9v
dF9wYXJhbXMgd2hpY2ggaXMgaW4gZml4bWFwIGZvciBhcm02NCB3aWxsIGdpdmUgYW4KPiBpbmNv
cnJlY3QgdmFsdWUuIEhlbmNlIHN0YXNoIHRoZSBwaHlzaWNhbCBhZGRyZXNzIHdoZW4gaXQgaXMg
a25vd24gYXQKPiBib290IHRpbWUgYW5kIHVzZSBpdCBhdCBrZXhlYyB0aW1lIGluc3RlYWQgb2Yg
Y29udmVydGluZyB0aGUgdmlydHVhbAo+IGFkZHJlc3MgdXNpbmcgX19wYSgpLgo+Cj4gUmVwb3J0
ZWQtYnk6IEJyZW5vIExlaXRhbyA8bGVpdGFvQGRlYmlhbi5vcmc+Cj4gU3VnZ2VzdGVkLWJ5OiBN
YXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPgo+IFNpZ25lZC1vZmYtYnk6IFVzYW1h
IEFyaWYgPHVzYW1hYXJpZjY0MkBnbWFpbC5jb20+Cj4gRml4ZXM6IGFjMTBiZTVjZGJmYSAoImFy
bTY0OiBVc2UgY29tbW9uIG9mX2tleGVjX2FsbG9jX2FuZF9zZXR1cF9mZHQoKSIpCj4gLS0tCj4g
IGFyY2gvYXJtNjQva2VybmVsL3NldHVwLmMgfCA4ICsrKysrKysrCj4gIGRyaXZlcnMvb2YvZmR0
LmMgICAgICAgICAgfCA2ICsrKysrKwo+ICBkcml2ZXJzL29mL2tleGVjLmMgICAgICAgIHwgOCAr
KysrKystLQo+ICBpbmNsdWRlL2xpbnV4L29mX2ZkdC5oICAgIHwgMiArKwo+ICA0IGZpbGVzIGNo
YW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm02NC9rZXJuZWwvc2V0dXAuYyBiL2FyY2gvYXJtNjQva2VybmVsL3NldHVwLmMKPiBp
bmRleCBiMjJkMjhlYzgwMjguLmE0ZDk2ZjVlMmUwNSAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybTY0
L2tlcm5lbC9zZXR1cC5jCj4gKysrIGIvYXJjaC9hcm02NC9rZXJuZWwvc2V0dXAuYwo+IEBAIC0x
OTQsNiArMTk0LDE0IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBzZXR1cF9tYWNoaW5lX2ZkdChwaHlz
X2FkZHJfdCBkdF9waHlzKQo+ICAgICAgICAgLyogRWFybHkgZml4dXBzIGFyZSBkb25lLCBtYXAg
dGhlIEZEVCBhcyByZWFkLW9ubHkgbm93ICovCj4gICAgICAgICBmaXhtYXBfcmVtYXBfZmR0KGR0
X3BoeXMsICZzaXplLCBQQUdFX0tFUk5FTF9STyk7Cj4KPiArICAgICAgIC8qCj4gKyAgICAgICAg
KiBTYXZlIGR0X3BoeXMgYWRkcmVzcyBzbyB0aGF0IGl0IGNhbiBiZSB1c2VkIGxhdGVyIGZvciBr
ZXhlYy4gVGhpcwo+ICsgICAgICAgICogaXMgZG9uZSBhcyBfX3BhKCkgaXMgb25seSBpbnRlbmRl
ZCB0byBiZSB1c2VkIGZvciBsaW5lYXIgbWFwIGFkZHJlc3Nlcwo+ICsgICAgICAgICogYW5kIHVz
aW5nIGl0IGZvciBpbml0aWFsX2Jvb3RfcGFyYW1zIHdoaWNoIGlzIGluIGZpeG1hcCB3aWxsIGdp
dmUgYW4KPiArICAgICAgICAqIGluY29ycmVjdCB2YWx1ZS4KPiArICAgICAgICAqLwo+ICsgICAg
ICAgc2V0X2luaXRpYWxfYm9vdF9wYXJhbXNfcGEoZHRfcGh5cyk7Cj4gKwo+ICAgICAgICAgbmFt
ZSA9IG9mX2ZsYXRfZHRfZ2V0X21hY2hpbmVfbmFtZSgpOwo+ICAgICAgICAgaWYgKCFuYW1lKQo+
ICAgICAgICAgICAgICAgICByZXR1cm47Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvb2YvZmR0LmMg
Yi9kcml2ZXJzL29mL2ZkdC5jCj4gaW5kZXggNGQ1MjhjMTBkZjNhLi45ZTMxMmI3YzI0NmUgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9vZi9mZHQuYwo+ICsrKyBiL2RyaXZlcnMvb2YvZmR0LmMKPiBA
QCAtNDU3LDYgKzQ1Nyw3IEBAIGludCBfX2luaXRkYXRhIGR0X3Jvb3RfYWRkcl9jZWxsczsKPiAg
aW50IF9faW5pdGRhdGEgZHRfcm9vdF9zaXplX2NlbGxzOwo+Cj4gIHZvaWQgKmluaXRpYWxfYm9v
dF9wYXJhbXMgX19yb19hZnRlcl9pbml0Owo+ICtwaHlzX2FkZHJfdCBpbml0aWFsX2Jvb3RfcGFy
YW1zX3BhIF9fcm9fYWZ0ZXJfaW5pdDsKPgo+ICAjaWZkZWYgQ09ORklHX09GX0VBUkxZX0ZMQVRU
UkVFCj4KPiBAQCAtMTE4NSw2ICsxMTg2LDExIEBAIGJvb2wgX19pbml0IGVhcmx5X2luaXRfZHRf
c2Nhbih2b2lkICpwYXJhbXMpCj4gICAgICAgICByZXR1cm4gdHJ1ZTsKPiAgfQo+Cj4gK3ZvaWQg
X19pbml0IHNldF9pbml0aWFsX2Jvb3RfcGFyYW1zX3BhKHBoeXNfYWRkcl90IHBhcmFtcykKPiAr
ewo+ICsgICAgICAgaW5pdGlhbF9ib290X3BhcmFtc19wYSA9IHBhcmFtczsKPiArfQo+ICsKPiAg
c3RhdGljIHZvaWQgKl9faW5pdCBjb3B5X2RldmljZV90cmVlKHZvaWQgKmZkdCkKPiAgewo+ICAg
ICAgICAgaW50IHNpemU7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvb2Yva2V4ZWMuYyBiL2RyaXZl
cnMvb2Yva2V4ZWMuYwo+IGluZGV4IDljY2RlMmZkNzdjYi4uY2E5ZjI3YjI3ZjcxIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvb2Yva2V4ZWMuYwo+ICsrKyBiL2RyaXZlcnMvb2Yva2V4ZWMuYwo+IEBA
IC0zMDAsOCArMzAwLDEyIEBAIHZvaWQgKm9mX2tleGVjX2FsbG9jX2FuZF9zZXR1cF9mZHQoY29u
c3Qgc3RydWN0IGtpbWFnZSAqaW1hZ2UsCj4gICAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+ICAg
ICAgICAgfQo+Cj4gLSAgICAgICAvKiBSZW1vdmUgbWVtb3J5IHJlc2VydmF0aW9uIGZvciB0aGUg
Y3VycmVudCBkZXZpY2UgdHJlZS4gKi8KPiAtICAgICAgIHJldCA9IGZkdF9maW5kX2FuZF9kZWxf
bWVtX3JzdihmZHQsIF9fcGEoaW5pdGlhbF9ib290X3BhcmFtcyksCj4gKyAgICAgICAvKiBSZW1v
dmUgbWVtb3J5IHJlc2VydmF0aW9uIGZvciB0aGUgY3VycmVudCBkZXZpY2UgdHJlZS4KPiArICAg
ICAgICAqIEZvciBhcm02NCwgaW5pdGlhbF9ib290X3BhcmFtcyBpcyBhIGZpeG1hcCBhZGRyZXNz
LCBoZW5jZSBfX3BhKCksCj4gKyAgICAgICAgKiBjYW4ndCBiZSB1c2VkIHRvIGdldCB0aGUgcGh5
c2ljYWwgYWRkcmVzcy4KPiArICAgICAgICAqLwo+ICsgICAgICAgcmV0ID0gZmR0X2ZpbmRfYW5k
X2RlbF9tZW1fcnN2KGZkdCwgSVNfRU5BQkxFRChDT05GSUdfQVJNNjQpID8KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbml0aWFsX2Jvb3RfcGFyYW1zX3BhIDogX19w
YShpbml0aWFsX2Jvb3RfcGFyYW1zKSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBmZHRfdG90YWxzaXplKGluaXRpYWxfYm9vdF9wYXJhbXMpKTsKCk5vdCBzdXJlIGFi
b3V0IHRoZSBjb3JyZWN0bmVzcyBvZiB0aGUgcGF0Y2ggKG5vdCBhIGtleGVjIGV4cGVydCkgYnV0
Cm5vIG5lZWQgdG8gZG8gYWxsIG9mIHRoaXMgaW5zaWRlIGEgZnVuY3Rpb24gcGFyYW1ldGVyLiBK
dXN0IGNyZWF0ZSBhCnZhcmlhYmxlIGFuZCB1c2UgaXQgaGVyZS4KCi1TYXJhdmFuYQoKPiAgICAg
ICAgIGlmIChyZXQgPT0gLUVJTlZBTCkgewo+ICAgICAgICAgICAgICAgICBwcl9lcnIoIkVycm9y
IHJlbW92aW5nIG1lbW9yeSByZXNlcnZhdGlvbi5cbiIpOwo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L29mX2ZkdC5oIGIvaW5jbHVkZS9saW51eC9vZl9mZHQuaAo+IGluZGV4IGQ2OWFkNWJi
MWViMS4uZGJkOTliZjIxYWM4IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvb2ZfZmR0LmgK
PiArKysgYi9pbmNsdWRlL2xpbnV4L29mX2ZkdC5oCj4gQEAgLTMxLDYgKzMxLDcgQEAgZXh0ZXJu
IHZvaWQgKm9mX2ZkdF91bmZsYXR0ZW5fdHJlZShjb25zdCB1bnNpZ25lZCBsb25nICpibG9iLAo+
ICBleHRlcm4gaW50IF9faW5pdGRhdGEgZHRfcm9vdF9hZGRyX2NlbGxzOwo+ICBleHRlcm4gaW50
IF9faW5pdGRhdGEgZHRfcm9vdF9zaXplX2NlbGxzOwo+ICBleHRlcm4gdm9pZCAqaW5pdGlhbF9i
b290X3BhcmFtczsKPiArZXh0ZXJuIHBoeXNfYWRkcl90IGluaXRpYWxfYm9vdF9wYXJhbXNfcGE7
Cj4KPiAgZXh0ZXJuIGNoYXIgX19kdGJfc3RhcnRbXTsKPiAgZXh0ZXJuIGNoYXIgX19kdGJfZW5k
W107Cj4gQEAgLTczLDYgKzc0LDcgQEAgZXh0ZXJuIGludCBlYXJseV9pbml0X2R0X3NjYW5fcm9v
dCh2b2lkKTsKPiAgZXh0ZXJuIGJvb2wgZWFybHlfaW5pdF9kdF9zY2FuKHZvaWQgKnBhcmFtcyk7
Cj4gIGV4dGVybiBib29sIGVhcmx5X2luaXRfZHRfdmVyaWZ5KHZvaWQgKnBhcmFtcyk7Cj4gIGV4
dGVybiB2b2lkIGVhcmx5X2luaXRfZHRfc2Nhbl9ub2Rlcyh2b2lkKTsKPiArZXh0ZXJuIHZvaWQg
c2V0X2luaXRpYWxfYm9vdF9wYXJhbXNfcGEocGh5c19hZGRyX3QgcGFyYW1zKTsKPgo+ICBleHRl
cm4gY29uc3QgY2hhciAqb2ZfZmxhdF9kdF9nZXRfbWFjaGluZV9uYW1lKHZvaWQpOwo+ICBleHRl
cm4gY29uc3Qgdm9pZCAqb2ZfZmxhdF9kdF9tYXRjaF9tYWNoaW5lKGNvbnN0IHZvaWQgKmRlZmF1
bHRfbWF0Y2gsCj4gLS0KPiAyLjQzLjUKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
