Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECBDC433FE
	for <kexec@archiver.kernel.org>; Wed, 26 Oct 2022 09:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7DY2pBlc7InCb4E/aEzXj3XwbQtCmjaqvE6sTEVvyqU=; b=yRg/jZvvgkzypf
	kgnEWMyxjUskK9ACb0o4N6Lu5O5yXV3k2pNIpAfedVUI6EdKLEO0hXwXsvNzhKHmDNwGTCmFqkfDY
	2wfXNtNV7sX8CUAn0GCbQAeV/MeFIKhjb2s41bLoR4oVxfBjSFY/E8a3VQPb7cHP/pUGRpPvwtUx5
	E/6iNiWAfGWIptNfQwq4Sy2s92VIGksC5zBmRkIFAwWkR1k0bDVBawsXXF3r/bt1tTSTNBtrbJDNv
	caSnx3bmAwaBzriRdjFhWqy3LRBKFtMcHSm99Me8dIv3lhYui+G8fd1rRMcQSfDtZEZeswLk4sD7w
	0he5giygEkoefSeN+6PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oncfW-008jRR-Lq; Wed, 26 Oct 2022 09:25:50 +0000
Received: from esa.microchip.iphmx.com ([68.232.153.233])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oncfR-008jPA-AL; Wed, 26 Oct 2022 09:25:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666776345; x=1698312345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J2x3u/A7C/R5Z7jun6x22iPwMoJoUKGDgdxT1e8scO8=;
  b=Lops0h+hidIX2y+OzSjeG2DCsNLBdzdQ+H4vDGxzCH+qIb4fj8Ha6AMD
   reSqISuIwScCiW4NKHD+e5zbQSli0dVFfsVe78MfJ68eveBnKd6tPn1+0
   lFdGn07TKhh3JUr93/uf3EhtSXr6G6EW6mw9sRc045/ldi9AZuuspom7N
   NuMOwGy0fFVpDyOAXbwCznmIlBvgk+S4L3+W8Z78CqihijZc1faMRiI3f
   HwfapakFS6iANUn518DElZED+7Wc/wM6X++SvIzJVQp7zA/cTfvNQGCRY
   ect99/DTFp9f6XaczBOFSeT1OPeV+pD/qMZrbhZnfQCZlTJreEPdba+c7
   w==;
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="197083124"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Oct 2022 02:25:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 26 Oct 2022 02:25:39 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 26 Oct 2022 02:25:35 -0700
Date: Wed, 26 Oct 2022 10:25:20 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
CC: Baoquan He <bhe@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	<paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>, <anup@brainfault.org>,
	<heiko@sntech.de>, <guoren@kernel.org>, <mick@ics.forth.gr>,
	<alexandre.ghiti@canonical.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<corbet@lwn.net>, <bagasdotme@gmail.com>, <k-hagio-ab@nec.com>,
	<lijiang@redhat.com>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <crash-utility@redhat.com>,
	<heinrich.schuchardt@canonical.com>, <hschauhan@nulltrace.org>,
	<yixun.lan@gmail.com>
Subject: Re: [PATCH V4 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
Message-ID: <Y1j9AAhJXpoCx48N@wendy>
References: <20221019103623.7008-1-xianting.tian@linux.alibaba.com>
 <20221019103623.7008-2-xianting.tian@linux.alibaba.com>
 <Y1CtreAKT/SEh4vN@MiWiFi-R3L-srv>
 <30621b3b-47ba-d612-cfb0-583d779691a3@linux.alibaba.com>
 <Y1C681H2mlxX+zqf@MiWiFi-R3L-srv>
 <6af05838-fa58-8197-f3ce-ca95457077a7@linux.alibaba.com>
 <5df30e57-88ae-0a3b-2c1a-b962363d8670@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5df30e57-88ae-0a3b-2c1a-b962363d8670@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_022545_441660_C8C2516E 
X-CRM114-Status: GOOD (  32.84  )
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

T24gV2VkLCBPY3QgMjYsIDIwMjIgYXQgMDU6MDg6MTFQTSArMDgwMCwgWGlhbnRpbmcgVGlhbiB3
cm90ZToKPiBIaSBQYWxtZXIsIENvbm9yCj4gCj4gSXMgdGhpcyB2ZXJzaW9uIE9LIGZvciB5b3U/
CgpUaGUgd2VpcmQgaWZkZWYvSVNfRU5BQkxFRCB0aGluZyB3YXMgdGhlIG9ubHkgY29tbWVudCBJ
IGhhZC4gSXQncyBhIGJpdApvZGQgJiBJIG5vdGljZSBCYW9xdWFuIGJyb3VnaHQgaXQgdXAgdG9v
LiBJIGRpZG4ndCAoYW5kIHdvbid0KSBnaXZlIHlvdQphIHJldmlld2VkIGJ5IG9uIHRoZXNlIHBh
dGNoZXMgYmVjYXVzZSBJIGRvbid0IHVuZGVyc3RhbmQgdGhlIGFyZWEgd2VsbAplbm91Z2guIFRo
ZSBnZW5lcmFsIG5pdHBpY2tlcnkgc2VlbXMgdG8gYmUgc29ydGVkIHRob3VnaC4KClRoYW5rcywK
Q29ub3IuCgo+IAo+IOWcqCAyMDIyLzEwLzIwIOS4i+WNiDEyOjQwLCBYaWFudGluZyBUaWFuIOWG
memBkzoKPiA+IAo+ID4g5ZyoIDIwMjIvMTAvMjAg5LiK5Y2IMTE6MDUsIEJhb3F1YW4gSGUg5YaZ
6YGTOgo+ID4gPiBPbiAxMC8yMC8yMiBhdCAxMDoxN2FtLCBYaWFudGluZyBUaWFuIHdyb3RlOgo+
ID4gPiA+IOWcqCAyMDIyLzEwLzIwIOS4iuWNiDEwOjA4LCBCYW9xdWFuIEhlIOWGmemBkzoKPiA+
ID4gPiA+IE9uIDEwLzE5LzIyIGF0IDA2OjM2cG0sIFhpYW50aW5nIFRpYW4gd3JvdGU6Cj4gPiA+
ID4gPiA+IEFkZCBhcmNoX2NyYXNoX3NhdmVfdm1jb3JlaW5mbygpLCB3aGljaCBleHBvcnRzIFZN
Cj4gPiA+ID4gPiA+IGxheW91dChNT0RVTEVTLCBWTUFMTE9DLAo+ID4gPiA+ID4gPiBWTUVNTUFQ
IHJhbmdlcyBhbmQgS0VSTkVMX0xJTktfQUREUiksIHZhIGJpdHMgYW5kIHJhbQo+ID4gPiA+ID4g
PiBiYXNlIGZvciB2bWNvcmUuCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiBEZWZhdWx0IHBhZ2V0
YWJsZSBsZXZlbHMgYW5kIFBBR0VfT0ZGU0VUIGFyZW4ndCBzYW1lIGZvcgo+ID4gPiA+ID4gPiBk
aWZmZXJlbnQga2VybmVsCj4gPiA+ID4gPiA+IHZlcnNpb24gYXMgYmVsb3cuIEZvciBwYWdldGFi
bGUgbGV2ZWxzLCBpdCBzZXRzIHN2NTcgYnkKPiA+ID4gPiA+ID4gZGVmYXVsdCBhbmQgZmFsbHMK
PiA+ID4gPiA+ID4gYmFjayB0byBzZXR0aW5nIHN2NDggYXQgYm9vdCB0aW1lIGlmIHN2NTcgaXMg
bm90Cj4gPiA+ID4gPiA+IHN1cHBvcnRlZCBieSB0aGUgaGFyZHdhcmUuCj4gPiA+ID4gPiA+IAo+
ID4gPiA+ID4gPiBGb3IgcmFtIGJhc2UsIHRoZSBkZWZhdWx0IHZhbHVlIGlzIDB4ODAyMDAwMDAg
Zm9yIHFlbXUKPiA+ID4gPiA+ID4gcmlzY3Y2NCBlbnYgYW5kLAo+ID4gPiA+ID4gPiBmb3IgZXhh
bXBsZSwgaXMgMHgyMDAwMDAgb24gdGhlIFh1YW5UaWUgOTEwIENQVS4KPiA+ID4gPiA+ID4gCj4g
PiA+ID4gPiA+IMKgwqAgKiBMaW51eCBLZXJuZWwgNS4xOCB+Cj4gPiA+ID4gPiA+IMKgwqAgKsKg
wqDCoMKgwqAgUEdUQUJMRV9MRVZFTFMgPSA1Cj4gPiA+ID4gPiA+IMKgwqAgKsKgwqDCoMKgwqAg
UEFHRV9PRkZTRVQgPSAweGZmNjAwMDAwMDAwMDAwMDAKPiA+ID4gPiA+ID4gwqDCoCAqIExpbnV4
IEtlcm5lbCA1LjE3IH4KPiA+ID4gPiA+ID4gwqDCoCAqwqDCoMKgwqDCoCBQR1RBQkxFX0xFVkVM
UyA9IDQKPiA+ID4gPiA+ID4gwqDCoCAqwqDCoMKgwqDCoCBQQUdFX09GRlNFVCA9IDB4ZmZmZmFm
ODAwMDAwMDAwMAo+ID4gPiA+ID4gPiDCoMKgICogTGludXggS2VybmVsIDQuMTkgfgo+ID4gPiA+
ID4gPiDCoMKgICrCoMKgwqDCoMKgIFBHVEFCTEVfTEVWRUxTID0gMwo+ID4gPiA+ID4gPiDCoMKg
ICrCoMKgwqDCoMKgIFBBR0VfT0ZGU0VUID0gMHhmZmZmZmZlMDAwMDAwMDAwCj4gPiA+ID4gPiA+
IAo+ID4gPiA+ID4gPiBTaW5jZSB0aGVzZSBjb25maWd1cmF0aW9ucyBjaGFuZ2UgZnJvbSB0aW1l
IHRvIHRpbWUgYW5kCj4gPiA+ID4gPiA+IHZlcnNpb24gdG8gdmVyc2lvbiwKPiA+ID4gPiA+ID4g
aXQgaXMgcHJlZmVyYWJsZSB0byBleHBvcnQgdGhlbSB2aWEgdm1jb3JlaW5mbyB0aGFuIHRvCj4g
PiA+ID4gPiA+IGNoYW5nZSB0aGUgY3Jhc2gncwo+ID4gPiA+ID4gPiBjb2RlIGZyZXF1ZW50bHks
IGl0IGNhbiBzaW1wbGlmeSB0aGUgZGV2ZWxvcG1lbnQgb2YgY3Jhc2ggdG9vbC4KPiA+ID4gPiA+
ID4gCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFhpYW50aW5nIFRpYW4gPHhpYW50aW5nLnRp
YW5AbGludXguYWxpYmFiYS5jb20+Cj4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gPiDCoMKgIGFy
Y2gvcmlzY3Yva2VybmVsL01ha2VmaWxlwqDCoMKgwqAgfMKgIDEgKwo+ID4gPiA+ID4gPiDCoMKg
IGFyY2gvcmlzY3Yva2VybmVsL2NyYXNoX2NvcmUuYyB8IDIzICsrKysrKysrKysrKysrKysrKysr
KysrCj4gPiA+ID4gPiA+IMKgwqAgMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspCj4g
PiA+ID4gPiA+IMKgwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3Yva2VybmVsL2NyYXNo
X2NvcmUuYwo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yv
a2VybmVsL01ha2VmaWxlIGIvYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUKPiA+ID4gPiA+ID4g
aW5kZXggZGI2ZTRiMTI5NGJhLi40Y2YzMDNhNzc5YWIgMTAwNjQ0Cj4gPiA+ID4gPiA+IC0tLSBh
L2FyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxlCj4gPiA+ID4gPiA+ICsrKyBiL2FyY2gvcmlzY3Yv
a2VybmVsL01ha2VmaWxlCj4gPiA+ID4gPiA+IEBAIC04MSw2ICs4MSw3IEBAIG9iai0kKENPTkZJ
R19LR0RCKcKgwqDCoMKgwqDCoMKgICs9IGtnZGIubwo+ID4gPiA+ID4gPiDCoMKgIG9iai0kKENP
TkZJR19LRVhFQ19DT1JFKcKgwqDCoCArPSBrZXhlY19yZWxvY2F0ZS5vCj4gPiA+ID4gPiA+IGNy
YXNoX3NhdmVfcmVncy5vIG1hY2hpbmVfa2V4ZWMubwo+ID4gPiA+ID4gPiDCoMKgIG9iai0kKENP
TkZJR19LRVhFQ19GSUxFKcKgwqDCoCArPSBlbGZfa2V4ZWMubyBtYWNoaW5lX2tleGVjX2ZpbGUu
bwo+ID4gPiA+ID4gPiDCoMKgIG9iai0kKENPTkZJR19DUkFTSF9EVU1QKcKgwqDCoCArPSBjcmFz
aF9kdW1wLm8KPiA+ID4gPiA+ID4gK29iai0kKENPTkZJR19DUkFTSF9DT1JFKcKgwqDCoCArPSBj
cmFzaF9jb3JlLm8KPiA+ID4gPiA+ID4gwqDCoCBvYmotJChDT05GSUdfSlVNUF9MQUJFTCnCoMKg
wqAgKz0ganVtcF9sYWJlbC5vCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2tl
cm5lbC9jcmFzaF9jb3JlLmMKPiA+ID4gPiA+ID4gYi9hcmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9j
b3JlLmMKPiA+ID4gPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiA+ID4gPiA+ID4gaW5kZXgg
MDAwMDAwMDAwMDAwLi4zZTg4OWQwZWQ3YmQKPiA+ID4gPiA+ID4gLS0tIC9kZXYvbnVsbAo+ID4g
PiA+ID4gPiArKysgYi9hcmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9jb3JlLmMKPiA+ID4gPiA+ID4g
QEAgLTAsMCArMSwyMyBAQAo+ID4gPiA+ID4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAtb25seQo+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgv
Y3Jhc2hfY29yZS5oPgo+ID4gPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L3BhZ2VtYXAuaD4KPiA+
ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiArdm9pZCBhcmNoX2NyYXNoX3NhdmVfdm1jb3JlaW5mbyh2
b2lkKQo+ID4gPiA+ID4gPiArewo+ID4gPiA+ID4gPiArwqDCoMKgIFZNQ09SRUlORk9fTlVNQkVS
KFZBX0JJVFMpOwo+ID4gPiA+ID4gPiArwqDCoMKgIFZNQ09SRUlORk9fTlVNQkVSKHBoeXNfcmFt
X2Jhc2UpOwo+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ICvCoMKgwqAKPiA+ID4gPiA+ID4gdm1j
b3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIoUEFHRV9PRkZTRVQpPTB4JWx4XG4iLAo+ID4gPiA+
ID4gPiBQQUdFX09GRlNFVCk7Cj4gPiA+ID4gPiA+ICsgdm1jb3JlaW5mb19hcHBlbmRfc3RyKCJO
VU1CRVIoVk1BTExPQ19TVEFSVCk9MHglbHhcbiIsCj4gPiA+ID4gPiA+IFZNQUxMT0NfU1RBUlQp
Owo+ID4gPiA+ID4gPiArwqDCoMKgCj4gPiA+ID4gPiA+IHZtY29yZWluZm9fYXBwZW5kX3N0cigi
TlVNQkVSKFZNQUxMT0NfRU5EKT0weCVseFxuIiwKPiA+ID4gPiA+ID4gVk1BTExPQ19FTkQpOwo+
ID4gPiA+ID4gPiArIHZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVNQkVSKFZNRU1NQVBfU1RBUlQp
PTB4JWx4XG4iLAo+ID4gPiA+ID4gPiBWTUVNTUFQX1NUQVJUKTsKPiA+ID4gPiA+ID4gK8KgwqDC
oAo+ID4gPiA+ID4gPiB2bWNvcmVpbmZvX2FwcGVuZF9zdHIoIk5VTUJFUihWTUVNTUFQX0VORCk9
MHglbHhcbiIsCj4gPiA+ID4gPiA+IFZNRU1NQVBfRU5EKTsKPiA+ID4gPiA+ID4gKyNpZmRlZiBD
T05GSUdfNjRCSVQKPiA+ID4gPiA+ID4gKyB2bWNvcmVpbmZvX2FwcGVuZF9zdHIoIk5VTUJFUihN
T0RVTEVTX1ZBRERSKT0weCVseFxuIiwKPiA+ID4gPiA+ID4gTU9EVUxFU19WQUREUik7Cj4gPiA+
ID4gPiA+ICvCoMKgwqAKPiA+ID4gPiA+ID4gdm1jb3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIo
TU9EVUxFU19FTkQpPTB4JWx4XG4iLAo+ID4gPiA+ID4gPiBNT0RVTEVTX0VORCk7Cj4gPiA+ID4g
PiA+ICsjZW5kaWYKPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiArwqDCoMKgIGlmIChJU19FTkFC
TEVEKENPTkZJR182NEJJVCkpCj4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gdm1jb3JlaW5mb19h
cHBlbmRfc3RyKCJOVU1CRVIoS0VSTkVMX0xJTktfQUREUik9MHglbHhcbiIsCj4gPiA+ID4gPiA+
IEtFUk5FTF9MSU5LX0FERFIpOwo+ID4gPiA+ID4gV29uZGVyaW5nIHdoeSB5b3UgZG9uJ3QgcHV0
IEtFUk5FTF9MSU5LX0FERFIgZXhwb3J0aW5nIGludG8gdGhlIGFib3ZlCj4gPiA+ID4gPiBpZmRl
ZmZlcnkgc2NvcGUsIHdpdGggdGhhdCB5b3UgY2FuIHNhdmUgb25lIGxpbmUgb2YKPiA+ID4gPiA+
ICJJU19FTkFCTEVEKENPTkZJR182NEJJVCkiLgo+ID4gPiA+IEkgZm9sbG93ZWQgdGhlIHJ1bGUg
aW4gcHJpbnRfdm1fbGF5b3V0KCkgb2YKPiA+ID4gPiBhcmNoL3Jpc2N2L21tL2luaXQuYywgd2hp
Y2ggdXNlZAo+ID4gPiA+IElTX0VOQUJMRUQgd2hlbiBwcmludCB0aGUgdmFsdWUgb2YgS0VSTkVM
X0xJTktfQUREUi4KPiA+ID4gPiAKPiA+ID4gSSBzZWUuIFRoZXJlJ3MgUEFHRV9PRkZTRVQgaW4g
dGhlIG1pZGRsZS4gVGhhbmtzLgo+ID4gPiAKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCBwcmludF9t
bCgibG93bWVtIiwgKHVuc2lnbmVkIGxvbmcpUEFHRV9PRkZTRVQsCj4gPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICh1bnNpZ25lZCBsb25nKWhpZ2hfbWVtb3J5KQo+ID4gPiAK
PiA+ID4gU28gbm93LCBkbyB5b3UgdGhpbmsgaWYgaXQncyBuZWNlc3NhcnkgdG8gaGF2ZSBhbm90
aGVyCj4gPiA+IElTX0VOQUJMRUQoQ09ORklHXzY0QklUKSBpbiB0aGUgY3VycmVudCBhcmNoX2Ny
YXNoX3NhdmVfdm1jb3JlaW5mbygpPwo+ID4gCj4gPiBGb3Igd2hpY2ggTUFDUk8/wqAgSSB0aGlu
ayBjdXJyZW50IGNvZGUgZm9yIFBBR0VfT0ZGU0VUIGlzIE9LLgo+ID4gCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4
ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2tleGVjCg==
