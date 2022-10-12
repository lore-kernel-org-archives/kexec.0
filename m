Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FFCC433FE
	for <kexec@archiver.kernel.org>; Wed, 12 Oct 2022 09:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SK+Db582K7CcFfg33rj3RCZMaUE/N/9z++TXn8YqhPI=; b=VDM3olYDJi/TNx
	R0HPhsH4wGMT6OTxSv2OXZPVeUmmbRHk1mY7JI9h278rCCD0TppDU+RgC2TlqXq2XyEK7DmT0PzoE
	zgtVT+JRn6SoS5AUPjQLasqxwN39nh8sUKYT7xNChNfKeRYQHPq4w2GrDHVRk6F1xEWQvt/WXRr+G
	Xj1qPJ67q6pWP8Qwk5+l7ayEY5vG0NRsS3eKBAZIFxwXnmFk511+7YSOstJ5LqTfA4Dzcgs74uKg1
	6diy1btZT7cSYGV9XoytrpPNgULmEIinbD2F3YDAxtdSBmyVwV2MxDrNPDLE3rpERc7wWfC3qYKhd
	Z2eF8TpnnrRyZJYafLSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiYQi-007Z3i-8O; Wed, 12 Oct 2022 09:53:36 +0000
Received: from esa.microchip.iphmx.com ([68.232.154.123])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiYQW-007Z0H-H3; Wed, 12 Oct 2022 09:53:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665568404; x=1697104404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OPG3s+9CXT0QwJB4pJ7tlvmxNG4ycLF3KJasH+oBYLY=;
  b=iGeJXWw2Z9XuAATxJaA/OIafGZiG0p7I384AC8B1y4yEH3fuL4SkKfGV
   aeO/XN/sMmG0tOmSgB/KgvRiOe0qF6cc5LecmmB/wDj9gEqQZpQpCJTBB
   iKs+dIzEvp9+hUO+ATN6HHE5zRATk32+6baaqyrw/LpTkLObfuP141/1n
   Fr0KYXHQOrt/VUcYOJAdOik4r6FIT4Q5qji+V8vjmiLTKeeMWOKvfhUFQ
   zsQ2anJKmd+P66lpbxd11e4Oa8HTmtXUnDShHRGDpyEblxQ3WKEDIXol5
   PmNP32X6PBU2P9mu2JZvtYjT+aZnV/J28hVdwHlP0VDh0QxzH+NRFlEX9
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,178,1661842800"; 
   d="scan'208";a="118161375"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Oct 2022 02:53:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 12 Oct 2022 02:53:16 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 12 Oct 2022 02:53:12 -0700
Date: Wed, 12 Oct 2022 10:52:50 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>, <anup@brainfault.org>,
	<heiko@sntech.de>, <guoren@kernel.org>, <mick@ics.forth.gr>,
	<alexandre.ghiti@canonical.com>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <corbet@lwn.net>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <crash-utility@redhat.com>,
	<heinrich.schuchardt@canonical.com>, <k-hagio-ab@nec.com>,
	<hschauhan@nulltrace.org>, <yixun.lan@gmail.com>
Subject: Re: [PATCH V6 0/6] RISC-V fixups to work with crash tool
Message-ID: <Y0aOcsf06a2+ExrU@wendy>
References: <mhng-f5fdaa37-e99a-4214-a297-ec81f0fed0c1@palmer-mbp2014>
 <f8d3ae66-73a8-db89-c4c4-918610fb5f35@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f8d3ae66-73a8-db89-c4c4-918610fb5f35@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_025330_873174_8BB467E7 
X-CRM114-Status: GOOD (  36.41  )
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

T24gV2VkLCBPY3QgMTIsIDIwMjIgYXQgMDU6NDI6MzdQTSArMDgwMCwgWGlhbnRpbmcgVGlhbiB3
cm90ZToKPiAKPiDlnKggMjAyMi84LzEyIOS4iuWNiDEyOjE3LCBQYWxtZXIgRGFiYmVsdCDlhpnp
gZM6Cj4gPiBPbiBUaHUsIDExIEF1ZyAyMDIyIDAwOjQxOjQ0IFBEVCAoLTA3MDApLAo+ID4geGlh
bnRpbmcudGlhbkBsaW51eC5hbGliYWJhLmNvbSB3cm90ZToKPiA+ID4gSSBldmVyIHNlbnQgdGhl
IHBhdGNoIDEgaW4gdGhlIGxpbms6Cj4gPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcv
cHJvamVjdC9saW51eC1yaXNjdi9wYXRjaC8yMDIyMDcwODA3MzE1MC4zNTI4MzAtMy14aWFudGlu
Zy50aWFuQGxpbnV4LmFsaWJhYmEuY29tLwo+ID4gPiAKPiA+ID4gQW5kIHBhdGNoIDIsMyBpbiB0
aGUgbGluazoKPiA+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4
LXJpc2N2L3BhdGNoLzIwMjIwNzE0MTEzMzAwLjM2Nzg1NC0yLXhpYW50aW5nLnRpYW5AbGludXgu
YWxpYmFiYS5jb20vCj4gPiA+IAo+ID4gPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3By
b2plY3QvbGludXgtcmlzY3YvcGF0Y2gvMjAyMjA3MTQxMTMzMDAuMzY3ODU0LTMteGlhbnRpbmcu
dGlhbkBsaW51eC5hbGliYWJhLmNvbS8KPiA+ID4gCj4gPiA+IAo+ID4gPiBUaGlzIHBhdGNoIHNl
dCBqdXN0IHB1dCB0aGVzZSBwYXRjaGVzIHRvZ2V0aGVyLCBhbmQgd2l0aCB0aHJlZSBuZXcKPiA+
ID4gcGF0Y2ggNCwgNSwgNi4KPiA+ID4gdGhlc2Ugc2l4IHBhdGNoZXMgYXJlIHRoZSBmaXh1cHMg
Zm9yIG1hY2hpbmVfa2V4ZWMsIGtlcm5lbCBtb2RlIFBDCj4gPiA+IGZvciB2bWNvcmUKPiA+ID4g
YW5kIGltcHJvdmVtZW50cyBmb3Igdm1jb3JlaW5mbywgbWVtb3J5IGxheW91dCBkdW1wIGFuZCBm
aXh1cAo+ID4gPiBzY2hlZHVsZSBvdXQgaXNzdWUKPiA+ID4gaW4gbWFjaGluZV9jcmFzaF9zaHV0
ZG93bigpLgo+ID4gPiAKPiA+ID4gVGhlIG1haW4gY2hhbmdlcyBpbiB0aGUgc2l4IHBhdGNocyBh
cyBiZWxvdywKPiA+ID4gUGF0Y2ggMTogRml4dXAgdXNlIG9mIHNtcF9wcm9jZXNzb3JfaWQoKSBp
biBwcmVlbXB0aWJsZSBjb250ZXh0LCB0bwo+ID4gPiBjbGVhbnVwCj4gPiA+IMKgwqDCoMKgwqDC
oMKgwqAgdGhlIGNvbnNvbGUgcHJpbnRzLgo+ID4gPiBQYXRjaCAyOiBGaXh1cCB0byBnZXQgY29y
cmVjdCBrZXJuZWwgbW9kZSBQQyBmb3Iga2VybmVsIG1vZGUgcmVncwo+ID4gPiBmb3Igdm1jb3Jl
Lgo+ID4gPiBQYXRjaCAzOiBGaXh1cCBzY2hlZHVsZSBvdXQgaXNzdWUgaW4gbWFjaGluZV9jcmFz
aF9zaHV0ZG93bigpCj4gPiA+IFBhdGNoIDQ6IEFkZCBtb2R1bGVzIHRvIHZpcnR1YWwga2VybmVs
IG1lbW9yeSBsYXlvdXQgZHVtcC4KPiA+ID4gUGF0Y2ggNTogQWRkIFZNIGxheW91dCwgdmEgYml0
cywgcmFtIGJhc2UgdG8gdm1jb3JlaW5mbywgd2hpY2ggY2FuCj4gPiA+IHNpbXBsaWZ5Cj4gPiA+
IMKgwqDCoMKgwqDCoMKgwqAgdGhlIGRldmVsb3BtZW50IG9mIGNyYXNoIHRvb2wgYXMgQVJNNjQg
YWxyZWFkeSBkaWQKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCAoYXJjaC9hcm02NC9rZXJuZWwvY3Jh
c2hfY29yZS5jKS4KPiA+ID4gUGF0Y2ggNjogVXBkYXRlcyB2bWNvcmVpbmZvLnJzdCBmb3Igdm1j
b3JlaW5mbyBleHBvcnQgZm9yIFJJU0NWNjQuCj4gPiA+IAo+ID4gPiBXaXRoIHRoZXNlIHNpeCBw
YXRjaGVzKHBhdGNoIDIgaXMgbXVzdCksIGNyYXNoIHRvb2wgY2FuIHdvcmsgd2VsbCB0bwo+ID4g
PiBhbmFseXplCj4gPiA+IGEgdm1jb3JlLiBUaGUgcGF0Y2hlcyBmb3IgY3Jhc2ggdG9vbCBmb3Ig
UklTQ1Y2NCBpcyBpbiB0aGUgbGluazoKPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtcmlzY3YvMjAyMjA4MDEwNDMwNDAuMjAwMzI2NC0xLXhpYW50aW5nLnRpYW5AbGludXguYWxp
YmFiYS5jb20vCj4gPiA+IAo+ID4gPiAKPiA+ID4gLS0tLS0tCj4gPiA+IENoYW5nZXMgdjEgLT4g
djI6Cj4gPiA+IMKgIDEsIHJlbW92ZSB0aGUgcGF0Y2ggIkFkZCBhIGZhc3QgY2FsbCBwYXRoIG9m
IGNyYXNoX2tleGVjKCkiIGZyb20KPiA+ID4gdGhpcyBzZXJpZXMKPiA+ID4gwqDCoMKgwqAgb2Yg
cGF0Y2hlcywgYXMgaXQgYWxyZWFkeSBhcHBsaWVkIHRvIHJpc2N2IGdpdC4KPiA+ID4gaHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvcmlzY3YvbGludXguZ2l0
L2NvbW1pdC8/aD1mb3ItbmV4dCZpZD0zZjE5MDExMTBhODliMGUyZTEzYWRiMmFjOGQxYTcxMDI4
NzllYTk4Cj4gPiA+IMKgIDIsIGFkZCAnUmV2aWV3ZWQtYnknIGJhc2VkIG9uIHRoZSBjb21tZW50
cyBvZiB2MS4KPiA+ID4gQ2hhbmdlcyB2MiAtPiB2MzoKPiA+ID4gwqAgdXNlICJyaXNjdiIgaW5z
dGVhZCBvZiAicmlzY3Y2NCIgaW4gcGF0Y2ggNSBzdWJqZWN0IGxpbmUuCj4gPiA+IENoYW5nZXMg
djMgLT4gdjQ6Cj4gPiA+IMKgIHVzZSAicmlzY3YiIGluc3RlYWQgb2YgInJpc2N2NjQiIGluIHRo
ZSBzdW1tYXJ5IG9mIHBhdGNoIDUgc3ViamVjdAo+ID4gPiBsaW5lLgo+ID4gPiBDaGFuZ2VzIHY0
IC0+IHY1Ogo+ID4gPiDCoCBhZGQgYSBuZXcgcGF0Y2ggIlJJU0MtVjogRml4dXAgc2NoZWR1bGUg
b3V0IGlzc3VlIGluCj4gPiA+IG1hY2hpbmVfY3Jhc2hfc2h1dGRvd24oKSIKPiA+ID4gQ2hhbmdl
cyB2NSAtPiB2NjoKPiA+ID4gwqAgMSwgbW92ZSAiZml4dXAiIHBhdGNoZXMgdG8gdGhlIHN0YXJ0
IG9mIHRoZSBwYXRjaCBzZXQuCj4gPiA+IMKgIDIsIGNoYW5nZSBwYXRjaCAxLCAyLCA2J3Mgc3Vi
amVjdCB0byBtYWtlIGl0IHRlbGwgbW9yZSB3aGF0IGl0J3MKPiA+ID4gYWJvdXQuCj4gPiA+IMKg
IDMsIGFkZCBGaXhlcyBmb3IgcGF0Y2ggMy4KPiA+ID4gwqAgNCwgYWRqdWVzdCB0aGUgY2hhbmdl
cyBmb3JtYXQgZm9yIHBhdGNoIDYuCj4gPiA+IAo+ID4gPiAKPiA+ID4gWGlhbnRpbmcgVGlhbiAo
Nik6Cj4gPiA+IMKgIFJJU0MtVjoga2V4ZWM6IEZpeHVwIHVzZSBvZiBzbXBfcHJvY2Vzc29yX2lk
KCkgaW4gcHJlZW1wdGlibGUgY29udGV4dAo+ID4gPiDCoCBSSVNDLVY6IEZpeHVwIGdldCBpbmNv
cnJlY3QgdXNlciBtb2RlIFBDIGZvciBrZXJuZWwgbW9kZSByZWdzCj4gPiA+IMKgIFJJU0MtVjog
Rml4dXAgc2NoZWR1bGUgb3V0IGlzc3VlIGluIG1hY2hpbmVfY3Jhc2hfc2h1dGRvd24oKQo+ID4g
PiDCoCBSSVNDLVY6IEFkZCBtb2R1bGVzIHRvIHZpcnR1YWwga2VybmVsIG1lbW9yeSBsYXlvdXQg
ZHVtcAo+ID4gPiDCoCBSSVNDLVY6IEFkZCBhcmNoX2NyYXNoX3NhdmVfdm1jb3JlaW5mbyBzdXBw
b3J0Cj4gPiA+IMKgIERvY3VtZW50YXRpb246IGtkdW1wOiBkZXNjcmliZSBWTUNPUkVJTkZPIGV4
cG9ydCBmb3IgUklTQ1Y2NAo+ID4gPiAKPiA+ID4gwqAuLi4vYWRtaW4tZ3VpZGUva2R1bXAvdm1j
b3JlaW5mby5yc3TCoMKgwqDCoMKgwqDCoMKgwqAgfCAzMSArKysrKysrKysrKysrKysrKysrCj4g
PiA+IMKgYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqAgMSArCj4gPiA+IMKgYXJjaC9yaXNjdi9rZXJuZWwvY3Jhc2hfY29y
ZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjkgKysrKysrKysrKysrKysrKysK
PiA+ID4gwqBhcmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9zYXZlX3JlZ3MuU8KgwqDCoMKgwqDCoMKg
wqDCoMKgIHzCoCAyICstCj4gPiA+IMKgYXJjaC9yaXNjdi9rZXJuZWwvbWFjaGluZV9rZXhlYy5j
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjggKysrKysrKysrKysrKystLS0KPiA+ID4gwqBh
cmNoL3Jpc2N2L21tL2luaXQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoCA0ICsrKwo+ID4gPiDCoDYgZmlsZXMgY2hhbmdlZCwgODkgaW5zZXJ0
aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPiA+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9y
aXNjdi9rZXJuZWwvY3Jhc2hfY29yZS5jCj4gPiAKPiA+IFRoYW5rLsKgIEkndmUgdGFrZW4gdGhl
IGZpcnN0IDQgb250byBmb3ItbmV4dCwgd2hpY2ggaXMgc3RpbGwgdGFyZ2V0ZWQKPiA+IGZvciA1
LjIwLCBhcyB0aGV5J3JlIGZpeGVzLsKgIEknbSBub3Qgb3Bwb3NlZCB0byB0YWtpbmcgdGhlIGRv
Y3VtZW50YXRpb24KPiA+IHBhdGNoIGZvciB0aGlzIGN5Y2xlIGFzIHdlbGwsIGl0IGp1c3QgbmVl
ZHMgc29tZSBnb2luZy1vdmVyIGFzIHRoZQo+ID4gd29yZGluZyBsb29rcyB2ZXJ5IG9kZCAob3Ig
YXQgbGVhc3QgaXQgZG9lcyB0byBtZSByaWdodCBub3csIG1heWJlIEknbQo+ID4ganVzdCBzdGls
bCBoYWxmIGFzbGVlcCkuwqAgUGF0Y2ggNSBpcyBhIG5ldyBmZWF0dXJlLCBhbmQgZ2l2ZW4gdGhh
dCBpdCdzCj4gPiBiZWluZyBzcHVuIGR1cmluZyB0aGUgbWVyZ2Ugd2luZG93IGl0J3MgdG9vIGxh
dGUuCj4gCj4gSGkgUGFsbWVyCj4gCj4gRG8geW91IHBsYW4gdG8gbWVyZ2UgdGhlIHR3byBwYXRj
aCB0byBMaW51eCA2LjEgdG8gc3VwcG9ydCBjcmFzaCB0b29sIHdvcms/wqAKPiB0aGFua3MKPiAK
PiDCoCBSSVNDLVY6IGtleGVjOiBGaXh1cCB1c2Ugb2Ygc21wX3Byb2Nlc3Nvcl9pZCgpIGluIHBy
ZWVtcHRpYmxlIGNvbnRleHQKCjM1NzYyOGU2OGY1YyAoIlJJU0MtVjoga2V4ZWM6IEZpeHVwIHVz
ZSBvZiBzbXBfcHJvY2Vzc29yX2lkKCkgaW4gcHJlZW1wdGlibGUgY29udGV4dCIKCj4gwqAgUklT
Qy1WOiBGaXh1cCBnZXQgaW5jb3JyZWN0IHVzZXIgbW9kZSBQQyBmb3Iga2VybmVsIG1vZGUgcmVn
cwoKNTljMDI2YzM1OWMzICgiUklTQy1WOiBGaXh1cCBnZXQgaW5jb3JyZWN0IHVzZXIgbW9kZSBQ
QyBmb3Iga2VybmVsIG1vZGUgcmVncyIpCgpIZXkgWGlhbnRpbmcsIHRob3NlIHR3byBjb21taXRz
IGFscmVhZHkgc2VlbSB0byBoYXZlIGJlZW4gYXBwbGllZCwgZG8KeW91IHBlcmhhcHMgaW5zdGVh
ZCBtZWFuIHRoZSBkb2N1bWVudGF0aW9uIHBhdGNoIGFuZCB0aGUgYWRkaXRpb24gb2YKc3VwcG9y
dCBmb3IgYXJjaF9jcmFzaF9zYXZlX3ZtY29yZWluZm8/IEkgcmVjYWxsZWQgYXNraW5nIGlmIHlv
dSBuZWVkZWQKdG8gcmVzcGluIGF0IHRoZSB0aW1lLCBidXQgZG8gbm90IHNlZSBhIHJlc3BvbnNl
OgpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1yaXNjdi8zOWZkYzg1ZS1iMmQ1LTg2M2Mt
NDg3OC00YjMzODBkNzZiYzRAbWljcm9jaGlwLmNvbS8KSUlSQyBCYWdhcyBoYWQgc29tZSBvdXRz
dGFuZGluZyBjb21tZW50cyBvbiB0aGUgZG9jdW1lbnRhdGlvbiBjaGFuZ2UKdG9vLiBXYXMgSSBp
bmNvcnJlY3Q/CgpUaGFua3MsCkNvbm9yLgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
