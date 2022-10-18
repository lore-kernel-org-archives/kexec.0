Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D70C4332F
	for <kexec@archiver.kernel.org>; Tue, 18 Oct 2022 07:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5IDk1DG+HpxkgZcZ6d0ygf2CIK0zO0n7/OKGDKUS/E8=; b=3vORT3CBN4bxBu
	x1Rbt+aPc3w/oiWDbeJC+70NRlsl2UNoWeRY7ZKKPWoe21W9EkV1J2VvgvTdlf+bty9JS3FLzKGTv
	Od+ey5z/ehGJn1lZ6ikLncBNxYdyIkz7RZXoTn5U8ldTIbX+1XC/Zz1m0LWS5T7n0y9m/uo1Lwqlv
	oFU5SmbJ0x7gANTWdtj/3Ql4HR3kdvypZUKdNn9sDLxvu0V1z5hZBtQEoEyLTnslX/zwae8TTxuxj
	JyLZtizT3khknBM1OJ8NFkaPRbb1Vi+MRfNsVV8Yi2KHaDLtBn1tBhQfUzZXsB6ffUZRe1qESIIAq
	GP5zJBr8Jqa6hBHMHQ4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okgvm-003lzv-US; Tue, 18 Oct 2022 07:22:31 +0000
Received: from esa.microchip.iphmx.com ([68.232.154.123])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okgn8-003i9R-FE; Tue, 18 Oct 2022 07:13:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666077214; x=1697613214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=d2BCVj64BTYSF36FIoeHkZaQnwzNtVMpJCVSYBSBrSY=;
  b=SDHeJOF07MnbU5bvlwGBu6pVHoJ5k8idfFIn5Ewxbd/372h4QABRZ3C1
   v4GWyLldxxO9hLyKRJz+a/lKv1bhOjSBA6DbdjJCWH7Sj2QBsUu5GQqqU
   +TLHE6dmiDuSgpbmlzNXVrFMu+XiEgn/P3BNgtXxNs2LlouR42iwEO6h8
   1kYMolKF7gEMgRJsZLOFrfMiY+qhn/IhZW6l5ii1y1DEon0Aw73iBLZ4V
   MHaNcAY/n7rF2I1B0bSIWwbAM2xV7LwdRk0uotOMRDw5vZ8llLLIOr9uv
   M8AYIxGH1g3uTW8v6BAzuIcmysuraQ3Fa6jGYjGHu/E/Dd8Ss8+CiAdRK
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="182673360"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Oct 2022 00:13:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 18 Oct 2022 00:13:28 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 18 Oct 2022 00:13:24 -0700
Date: Tue, 18 Oct 2022 08:13:01 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
CC: Conor Dooley <conor@kernel.org>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <anup@brainfault.org>,
	<heiko@sntech.de>, <guoren@kernel.org>, <mick@ics.forth.gr>,
	<alexandre.ghiti@canonical.com>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <corbet@lwn.net>, <bagasdotme@gmail.com>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<crash-utility@redhat.com>, <heinrich.schuchardt@canonical.com>,
	<k-hagio-ab@nec.com>, <hschauhan@nulltrace.org>, <yixun.lan@gmail.com>
Subject: Re: [PATCH V2 2/2] Documentation: kdump: describe VMCOREINFO export
 for RISCV64
Message-ID: <Y05R/WK3cSEmwmYx@wendy>
References: <20221014134139.5151-1-xianting.tian@linux.alibaba.com>
 <20221014134139.5151-3-xianting.tian@linux.alibaba.com>
 <Y02vm7FrhdEoSXZ+@spud>
 <a4d2dc7e-7f45-00b7-6c31-cc934ba9c1f5@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a4d2dc7e-7f45-00b7-6c31-cc934ba9c1f5@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_001334_605074_9C09BEBB 
X-CRM114-Status: GOOD (  23.89  )
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

T24gVHVlLCBPY3QgMTgsIDIwMjIgYXQgMTA6NDE6NTBBTSArMDgwMCwgWGlhbnRpbmcgVGlhbiB3
cm90ZToKPiAKPiDlnKggMjAyMi8xMC8xOCDkuIrljYgzOjQwLCBDb25vciBEb29sZXkg5YaZ6YGT
Ogo+ID4gT24gRnJpLCBPY3QgMTQsIDIwMjIgYXQgMDk6NDE6MzlQTSArMDgwMCwgWGlhbnRpbmcg
VGlhbiB3cm90ZToKPiA+ID4gVGhlIGZvbGxvd2luZyBpbnRlcnJlbGF0ZWQgZGVmaW5pdGlvbnMg
YW5kIHJhbmdlcyBhcmUgbmVlZGVkIGJ5IHRoZSBrZHVtcAo+ID4gPiBjcmFzaCB0b29sLCB0aGV5
IGFyZSBleHBvcnRlZCBieSAiYXJjaC9yaXNjdi9rZXJuZWwvY3Jhc2hfY29yZS5jIjoKPiA+ID4g
ICAgICBWQV9CSVRTLAo+ID4gPiAgICAgIFBBR0VfT0ZGU0VULAo+ID4gPiAgICAgIHBoeXNfcmFt
X2Jhc2UsCj4gPiA+ICAgICAgTU9EVUxFU19WQUREUiB+IE1PRFVMRVNfRU5ELAo+ID4gPiAgICAg
IFZNQUxMT0NfU1RBUlQgfiBWTUFMTE9DX0VORCwKPiA+ID4gICAgICBWTUVNTUFQX1NUQVJUIH4g
Vk1FTU1BUF9FTkQsCj4gPiA+ICAgICAgS0FTQU5fU0hBRE9XX1NUQVJUIH4gS0FTQU5fU0hBRE9X
X0VORCwKPiA+ID4gICAgICBLRVJORUxfTElOS19BRERSIH4gQUREUkVTU19TUEFDRV9FTkQKPiA+
ID4gCj4gPiA+IERvY3VtZW50IHRoZXNlIFJJU0NWNjQgZXhwb3J0cyBhYm92ZS4KPiA+ID4gCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IFhpYW50aW5nIFRpYW4gPHhpYW50aW5nLnRpYW5AbGludXguYWxp
YmFiYS5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgIC4uLi9hZG1pbi1ndWlkZS9rZHVtcC92bWNvcmVp
bmZvLnJzdCAgICAgICAgICB8IDMwICsrKysrKysrKysrKysrKysrKysKPiA+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKQo+ID4gPiAKPiA+ID4gZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vYWRtaW4tZ3VpZGUva2R1bXAvdm1jb3JlaW5mby5yc3QgYi9Eb2N1bWVudGF0aW9u
L2FkbWluLWd1aWRlL2tkdW1wL3ZtY29yZWluZm8ucnN0Cj4gPiA+IGluZGV4IDY3MjZmNDM5OTU4
Yy4uOGUyZTE2NGNmM2RiIDEwMDY0NAo+ID4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1
aWRlL2tkdW1wL3ZtY29yZWluZm8ucnN0Cj4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vYWRtaW4t
Z3VpZGUva2R1bXAvdm1jb3JlaW5mby5yc3QKPiA+ID4gQEAgLTU5NSwzICs1OTUsMzMgQEAgWDJU
TEIKPiA+ID4gICAtLS0tLQo+ID4gPiAgIEluZGljYXRlcyB3aGV0aGVyIHRoZSBjcmFzaGVkIGtl
cm5lbCBlbmFibGVkIFNIIGV4dGVuZGVkIG1vZGUuCj4gPiA+ICsKPiA+ID4gK1JJU0NWNjQKPiA+
ID4gKz09PT09PT0KPiA+ID4gKwo+ID4gPiArVkFfQklUUwo+ID4gPiArLS0tLS0tLQo+ID4gPiAr
Cj4gPiA+ICtUaGUgbWF4aW11bSBudW1iZXIgb2YgYml0cyBmb3IgdmlydHVhbCBhZGRyZXNzZXMu
IFVzZWQgdG8gY29tcHV0ZSB0aGUKPiA+ID4gK3ZpcnR1YWwgbWVtb3J5IHJhbmdlcy4KPiA+ID4g
Kwo+ID4gPiArUEFHRV9PRkZTRVQKPiA+ID4gKy0tLS0tLS0tLS0tCj4gPiA+ICsKPiA+ID4gK0lu
ZGljYXRlcyB0aGUgdmlydHVhbCBrZXJuZWwgc3RhcnQgYWRkcmVzcyBvZiBkaXJlY3QtbWFwcGVk
IFJBTSByZWdpb24uCj4gPiBBcG9sb2dpZXMgZm9yIG5vdCBzZWVpbmcgdGhpcyBzb29uZXIsIGJ1
dCBzaG91bGQgdGhlcmUgbm90IGJlIGEgInRoZSIKPiA+IHByaW9yIHRvICJkaXJlY3QtbWFwcGVk
Ij8KPiB3aWxsIGZpeCBpbiB2Mwo+ID4gCj4gPiA+ICsKPiA+ID4gK3BoeXNfcmFtX2Jhc2UKPiA+
ID4gKy0tLS0tLS0tLS0tLS0KPiA+ID4gKwo+ID4gPiArSW5kaWNhdGVzIHRoZSBzdGFydCBwaHlz
aWNhbCBSQU0gYWRkcmVzcy4KPiA+ID4gKwo+ID4gPiArTU9EVUxFU19WQUREUnxNT0RVTEVTX0VO
RHxWTUFMTE9DX1NUQVJUfFZNQUxMT0NfRU5EfFZNRU1NQVBfU1RBUlR8Vk1FTU1BUF9FTkR8S0FT
QU5fU0hBRE9XX1NUQVJUfEtBU0FOX1NIQURPV19FTkR8S0VSTkVMX0xJTktfQUREUnxBRERSRVNT
X1NQQUNFX0VORAo+ID4gPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4g
PiArCj4gPiA+ICtVc2VkIHRvIGdldCB0aGUgY29ycmVjdCByYW5nZXM6Cj4gPiA+ICsKPiA+ID4g
KyAgKiBNT0RVTEVTX1ZBRERSIH4gTU9EVUxFU19FTkQgOiBLZXJuZWwgbW9kdWxlIHNwYWNlLgo+
ID4gPiArICAqIFZNQUxMT0NfU1RBUlQgfiBWTUFMTE9DX0VORCA6IHZtYWxsb2MoKSAvIGlvcmVt
YXAoKSBzcGFjZS4KPiA+ID4gKyAgKiBWTUVNTUFQX1NUQVJUIH4gVk1FTU1BUF9FTkQgOiB2bWVt
bWFwIHJlZ2lvbiwgdXNlZCBmb3Igc3RydWN0IHBhZ2UgYXJyYXkuCj4gPiBTaW5jZSBJJ20gaW4g
cGVkYW50IG1vZGUsIGl0IGRvZXMgbG9vayBhIGxpdHRsZSBvZGQgdGhhdCB5b3UncmUgdXNpbmcK
PiA+IHJlZ2lvbiBmb3Igdm1lbW1hcCBidXQgc3BhY2UgZm9yIHRoZSBvdGhlcnMgYnV0IGlkYyB0
aGF0IG11Y2guCj4gCj4gU29ycnksIEkgZGlkbid0IGdldCB5b3VyIHBvaW50IDooCj4gCj4gaXQg
Y29udGFpbnMgdm1lbW1hcCBhcmVhIHdpdGggcmVmZXJlbmNlIHd0aCBhcmNoL2FybTY0L2tlcm5l
bC9jcmFzaF9jb3JlLmMuCgpUaGUgd29yZGluZyBpcyBkaWZmZXJlbnQsIHZtZW1tYXAgdXNlcyBz
cGFjZSBhbmQgdGhlIG90aGVycyB1c2UgcmVnaW9uLgpOb3QgYSBiaWcgZGVhbC4KCj4gCj4gPiAK
PiA+IFRoYW5rcywKPiA+IENvbm9yLgo+ID4gCj4gPiA+ICsgICogS0FTQU5fU0hBRE9XX1NUQVJU
IH4gS0FTQU5fU0hBRE9XX0VORCA6IGthc2FuIHNoYWRvdyBzcGFjZS4KPiA+ID4gKyAgKiBLRVJO
RUxfTElOS19BRERSIH4gQUREUkVTU19TUEFDRV9FTkQgOiBLZXJuZWwgbGluayBhbmQgQlBGIHNw
YWNlLgo+ID4gPiAtLSAKPiA+ID4gMi4xNy4xCj4gPiA+IAo+ID4gPiAKPiAKPiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGxpbnV4LXJpc2N2IG1haWxp
bmcgbGlzdAo+IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcKPiBodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJpc2N2CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4
ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2tleGVjCg==
