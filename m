Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516B5C4332F
	for <kexec@archiver.kernel.org>; Thu, 20 Oct 2022 03:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TNFegebyeF+TzasAmvKxUFWITOw4BH1iOX1W59Bz4Lw=; b=Vyub+xkDjsD1L9
	wu+RDocke6Y59DgCDijGE6D04XSHjauBAKhsmzIvsDh6sf9ICoLmMjXMB+H1KBBvIfuKMOa+BL9/2
	6aZlo3ECyn1TdvOiHbvoGMZic4rHuDGgtEUB7dHAqKutdBBbMsXoFNWIb9J/qiD0ht2HCjExMxbPX
	treKZGCsbmvmZR9a8bB/Pqu2sVV8fcAcDKgWrp7ThxlbAhAsoKYh9nuXxR2mPdbllam9eIQ/oskgS
	FuLS0RsdDHPSX7wdA2rCJg0HD3+TDU8QB6f47M/aOBxAuFlJa0/Qu/NBTEkf9B/DDMEOdO6UW3D57
	Nuw5aP2w0Dptytko15LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olLsK-009iE3-4A; Thu, 20 Oct 2022 03:05:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olLsG-009iBo-W4
	for kexec@lists.infradead.org; Thu, 20 Oct 2022 03:05:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666235136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+xXE+hLfnStgrhavEiF+uB0bvcu9Rc/vs92lJ9VfFU=;
	b=NHEQ4zoAR+AfWfA6v22bfbYI72EWesSLOWmLseNwGbrc/2tki+QOA+LYa2hVCxpQmeu/LY
	MwrQUt5vmYoFBHLqoey1VJHeA2tGZxTfqECcr0TdbdWwWaEOW8yNxm92hz2RRKC3BvmXUa
	Lsvb2MU+GdLMefaBu6+yTXy5FnAouyI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-LPQxcEDxNeOKlFqcJKKYRA-1; Wed, 19 Oct 2022 23:05:29 -0400
X-MC-Unique: LPQxcEDxNeOKlFqcJKKYRA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E664C811E75;
	Thu, 20 Oct 2022 03:05:27 +0000 (UTC)
Received: from localhost (ovpn-12-35.pek2.redhat.com [10.72.12.35])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B0A40140EBF3;
	Thu, 20 Oct 2022 03:05:26 +0000 (UTC)
Date: Thu, 20 Oct 2022 11:05:23 +0800
From: Baoquan He <bhe@redhat.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	anup@brainfault.org, heiko@sntech.de, guoren@kernel.org,
	mick@ics.forth.gr, alexandre.ghiti@canonical.com, vgoyal@redhat.com,
	dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
	bagasdotme@gmail.com, k-hagio-ab@nec.com, lijiang@redhat.com,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
	hschauhan@nulltrace.org, yixun.lan@gmail.com
Subject: Re: [PATCH V4 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
Message-ID: <Y1C681H2mlxX+zqf@MiWiFi-R3L-srv>
References: <20221019103623.7008-1-xianting.tian@linux.alibaba.com>
 <20221019103623.7008-2-xianting.tian@linux.alibaba.com>
 <Y1CtreAKT/SEh4vN@MiWiFi-R3L-srv>
 <30621b3b-47ba-d612-cfb0-583d779691a3@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <30621b3b-47ba-d612-cfb0-583d779691a3@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_200537_117630_BD29158F 
X-CRM114-Status: GOOD (  26.59  )
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

T24gMTAvMjAvMjIgYXQgMTA6MTdhbSwgWGlhbnRpbmcgVGlhbiB3cm90ZToKPiAKPiDlnKggMjAy
Mi8xMC8yMCDkuIrljYgxMDowOCwgQmFvcXVhbiBIZSDlhpnpgZM6Cj4gPiBPbiAxMC8xOS8yMiBh
dCAwNjozNnBtLCBYaWFudGluZyBUaWFuIHdyb3RlOgo+ID4gPiBBZGQgYXJjaF9jcmFzaF9zYXZl
X3ZtY29yZWluZm8oKSwgd2hpY2ggZXhwb3J0cyBWTSBsYXlvdXQoTU9EVUxFUywgVk1BTExPQywK
PiA+ID4gVk1FTU1BUCByYW5nZXMgYW5kIEtFUk5FTF9MSU5LX0FERFIpLCB2YSBiaXRzIGFuZCBy
YW0gYmFzZSBmb3Igdm1jb3JlLgo+ID4gPiAKPiA+ID4gRGVmYXVsdCBwYWdldGFibGUgbGV2ZWxz
IGFuZCBQQUdFX09GRlNFVCBhcmVuJ3Qgc2FtZSBmb3IgZGlmZmVyZW50IGtlcm5lbAo+ID4gPiB2
ZXJzaW9uIGFzIGJlbG93LiBGb3IgcGFnZXRhYmxlIGxldmVscywgaXQgc2V0cyBzdjU3IGJ5IGRl
ZmF1bHQgYW5kIGZhbGxzCj4gPiA+IGJhY2sgdG8gc2V0dGluZyBzdjQ4IGF0IGJvb3QgdGltZSBp
ZiBzdjU3IGlzIG5vdCBzdXBwb3J0ZWQgYnkgdGhlIGhhcmR3YXJlLgo+ID4gPiAKPiA+ID4gRm9y
IHJhbSBiYXNlLCB0aGUgZGVmYXVsdCB2YWx1ZSBpcyAweDgwMjAwMDAwIGZvciBxZW11IHJpc2N2
NjQgZW52IGFuZCwKPiA+ID4gZm9yIGV4YW1wbGUsIGlzIDB4MjAwMDAwIG9uIHRoZSBYdWFuVGll
IDkxMCBDUFUuCj4gPiA+IAo+ID4gPiAgICogTGludXggS2VybmVsIDUuMTggfgo+ID4gPiAgICog
ICAgICBQR1RBQkxFX0xFVkVMUyA9IDUKPiA+ID4gICAqICAgICAgUEFHRV9PRkZTRVQgPSAweGZm
NjAwMDAwMDAwMDAwMDAKPiA+ID4gICAqIExpbnV4IEtlcm5lbCA1LjE3IH4KPiA+ID4gICAqICAg
ICAgUEdUQUJMRV9MRVZFTFMgPSA0Cj4gPiA+ICAgKiAgICAgIFBBR0VfT0ZGU0VUID0gMHhmZmZm
YWY4MDAwMDAwMDAwCj4gPiA+ICAgKiBMaW51eCBLZXJuZWwgNC4xOSB+Cj4gPiA+ICAgKiAgICAg
IFBHVEFCTEVfTEVWRUxTID0gMwo+ID4gPiAgICogICAgICBQQUdFX09GRlNFVCA9IDB4ZmZmZmZm
ZTAwMDAwMDAwMAo+ID4gPiAKPiA+ID4gU2luY2UgdGhlc2UgY29uZmlndXJhdGlvbnMgY2hhbmdl
IGZyb20gdGltZSB0byB0aW1lIGFuZCB2ZXJzaW9uIHRvIHZlcnNpb24sCj4gPiA+IGl0IGlzIHBy
ZWZlcmFibGUgdG8gZXhwb3J0IHRoZW0gdmlhIHZtY29yZWluZm8gdGhhbiB0byBjaGFuZ2UgdGhl
IGNyYXNoJ3MKPiA+ID4gY29kZSBmcmVxdWVudGx5LCBpdCBjYW4gc2ltcGxpZnkgdGhlIGRldmVs
b3BtZW50IG9mIGNyYXNoIHRvb2wuCj4gPiA+IAo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYaWFudGlu
ZyBUaWFuIDx4aWFudGluZy50aWFuQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gPiAtLS0KPiA+ID4g
ICBhcmNoL3Jpc2N2L2tlcm5lbC9NYWtlZmlsZSAgICAgfCAgMSArCj4gPiA+ICAgYXJjaC9yaXNj
di9rZXJuZWwvY3Jhc2hfY29yZS5jIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysKPiA+ID4g
ICAyIGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKykKPiA+ID4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgYXJjaC9yaXNjdi9rZXJuZWwvY3Jhc2hfY29yZS5jCj4gPiA+IAo+ID4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUgYi9hcmNoL3Jpc2N2L2tlcm5lbC9NYWtl
ZmlsZQo+ID4gPiBpbmRleCBkYjZlNGIxMjk0YmEuLjRjZjMwM2E3NzlhYiAxMDA2NDQKPiA+ID4g
LS0tIGEvYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUKPiA+ID4gKysrIGIvYXJjaC9yaXNjdi9r
ZXJuZWwvTWFrZWZpbGUKPiA+ID4gQEAgLTgxLDYgKzgxLDcgQEAgb2JqLSQoQ09ORklHX0tHREIp
CQkrPSBrZ2RiLm8KPiA+ID4gICBvYmotJChDT05GSUdfS0VYRUNfQ09SRSkJKz0ga2V4ZWNfcmVs
b2NhdGUubyBjcmFzaF9zYXZlX3JlZ3MubyBtYWNoaW5lX2tleGVjLm8KPiA+ID4gICBvYmotJChD
T05GSUdfS0VYRUNfRklMRSkJKz0gZWxmX2tleGVjLm8gbWFjaGluZV9rZXhlY19maWxlLm8KPiA+
ID4gICBvYmotJChDT05GSUdfQ1JBU0hfRFVNUCkJKz0gY3Jhc2hfZHVtcC5vCj4gPiA+ICtvYmot
JChDT05GSUdfQ1JBU0hfQ09SRSkJKz0gY3Jhc2hfY29yZS5vCj4gPiA+ICAgb2JqLSQoQ09ORklH
X0pVTVBfTEFCRUwpCSs9IGp1bXBfbGFiZWwubwo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNj
di9rZXJuZWwvY3Jhc2hfY29yZS5jIGIvYXJjaC9yaXNjdi9rZXJuZWwvY3Jhc2hfY29yZS5jCj4g
PiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uM2U4ODlk
MGVkN2JkCj4gPiA+IC0tLSAvZGV2L251bGwKPiA+ID4gKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwv
Y3Jhc2hfY29yZS5jCj4gPiA+IEBAIC0wLDAgKzEsMjMgQEAKPiA+ID4gKy8vIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkKPiA+ID4gKwo+ID4gPiArI2luY2x1ZGUgPGxpbnV4
L2NyYXNoX2NvcmUuaD4KPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9wYWdlbWFwLmg+Cj4gPiA+ICsK
PiA+ID4gK3ZvaWQgYXJjaF9jcmFzaF9zYXZlX3ZtY29yZWluZm8odm9pZCkKPiA+ID4gK3sKPiA+
ID4gKwlWTUNPUkVJTkZPX05VTUJFUihWQV9CSVRTKTsKPiA+ID4gKwlWTUNPUkVJTkZPX05VTUJF
UihwaHlzX3JhbV9iYXNlKTsKPiA+ID4gKwo+ID4gPiArCXZtY29yZWluZm9fYXBwZW5kX3N0cigi
TlVNQkVSKFBBR0VfT0ZGU0VUKT0weCVseFxuIiwgUEFHRV9PRkZTRVQpOwo+ID4gPiArCXZtY29y
ZWluZm9fYXBwZW5kX3N0cigiTlVNQkVSKFZNQUxMT0NfU1RBUlQpPTB4JWx4XG4iLCBWTUFMTE9D
X1NUQVJUKTsKPiA+ID4gKwl2bWNvcmVpbmZvX2FwcGVuZF9zdHIoIk5VTUJFUihWTUFMTE9DX0VO
RCk9MHglbHhcbiIsIFZNQUxMT0NfRU5EKTsKPiA+ID4gKwl2bWNvcmVpbmZvX2FwcGVuZF9zdHIo
Ik5VTUJFUihWTUVNTUFQX1NUQVJUKT0weCVseFxuIiwgVk1FTU1BUF9TVEFSVCk7Cj4gPiA+ICsJ
dm1jb3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIoVk1FTU1BUF9FTkQpPTB4JWx4XG4iLCBWTUVN
TUFQX0VORCk7Cj4gPiA+ICsjaWZkZWYgQ09ORklHXzY0QklUCj4gPiA+ICsJdm1jb3JlaW5mb19h
cHBlbmRfc3RyKCJOVU1CRVIoTU9EVUxFU19WQUREUik9MHglbHhcbiIsIE1PRFVMRVNfVkFERFIp
Owo+ID4gPiArCXZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVNQkVSKE1PRFVMRVNfRU5EKT0weCVs
eFxuIiwgTU9EVUxFU19FTkQpOwo+ID4gPiArI2VuZGlmCj4gPiA+ICsKPiA+ID4gKwlpZiAoSVNf
RU5BQkxFRChDT05GSUdfNjRCSVQpKQo+ID4gPiArCQl2bWNvcmVpbmZvX2FwcGVuZF9zdHIoIk5V
TUJFUihLRVJORUxfTElOS19BRERSKT0weCVseFxuIiwgS0VSTkVMX0xJTktfQUREUik7Cj4gPiBX
b25kZXJpbmcgd2h5IHlvdSBkb24ndCBwdXQgS0VSTkVMX0xJTktfQUREUiBleHBvcnRpbmcgaW50
byB0aGUgYWJvdmUKPiA+IGlmZGVmZmVyeSBzY29wZSwgd2l0aCB0aGF0IHlvdSBjYW4gc2F2ZSBv
bmUgbGluZSBvZiAiSVNfRU5BQkxFRChDT05GSUdfNjRCSVQpIi4KPiBJIGZvbGxvd2VkIHRoZSBy
dWxlIGluIHByaW50X3ZtX2xheW91dCgpIG9mIGFyY2gvcmlzY3YvbW0vaW5pdC5jLCB3aGljaCB1
c2VkCj4gSVNfRU5BQkxFRCB3aGVuIHByaW50IHRoZSB2YWx1ZSBvZiBLRVJORUxfTElOS19BRERS
Lgo+IAoKSSBzZWUuIFRoZXJlJ3MgUEFHRV9PRkZTRVQgaW4gdGhlIG1pZGRsZS4gVGhhbmtzLgoK
ICAgICAgICBwcmludF9tbCgibG93bWVtIiwgKHVuc2lnbmVkIGxvbmcpUEFHRV9PRkZTRVQsCiAg
ICAgICAgICAgICAgICAodW5zaWduZWQgbG9uZyloaWdoX21lbW9yeSkKClNvIG5vdywgZG8geW91
IHRoaW5rIGlmIGl0J3MgbmVjZXNzYXJ5IHRvIGhhdmUgYW5vdGhlcgpJU19FTkFCTEVEKENPTkZJ
R182NEJJVCkgaW4gdGhlIGN1cnJlbnQgYXJjaF9jcmFzaF9zYXZlX3ZtY29yZWluZm8oKT8KCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWls
aW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
