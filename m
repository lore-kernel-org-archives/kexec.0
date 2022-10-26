Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73E3C433FE
	for <kexec@archiver.kernel.org>; Wed, 26 Oct 2022 09:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jbggaXPrFlCKPfMre1h4muJrXsWZ17kBO9EbDq0llog=; b=jxbq5P1NO0Fgtk
	oU6yvFR33p2afc8F5eNp0GZ3UV85rcUpbDPr+z3FvnZMYt3HAJGR4LvefspEdYm36zSK/vF0j3djT
	cYaqqd4w1za4mkpHynNh1tKhRm35/FHFXMBQH8R3X1tLuHzFHkXQWGgnc/qgYm+LyFO/KBI4ccbfP
	DeL2bnhSMZupFA1F4ACf7xmnpi24FOkw1NDwSMJHk8wLRbBTQC65fHaM1Fmz+dgD3Lyg8sfqmfKIs
	PaprlXXYu+cR28Oz+jv2ORhNeShv1kN4omPUkInXbSgCK55FlL6t6UADyrB33uKc+TcBM/KjHO388
	h2XJLmv1EZf5rCTLPBIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oncy8-008pYm-OS; Wed, 26 Oct 2022 09:45:04 +0000
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oncy4-008pVc-U8; Wed, 26 Oct 2022 09:45:03 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VT6jFsX_1666777492;
Received: from 30.221.97.58(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VT6jFsX_1666777492)
          by smtp.aliyun-inc.com;
          Wed, 26 Oct 2022 17:44:55 +0800
Message-ID: <3c8beab1-3ca7-c3d7-6f31-c28a0ae008a3@linux.alibaba.com>
Date: Wed, 26 Oct 2022 17:44:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V4 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Baoquan He <bhe@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 paul.walmsley@sifive.com, aou@eecs.berkeley.edu, anup@brainfault.org,
 heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
 alexandre.ghiti@canonical.com, vgoyal@redhat.com, dyoung@redhat.com,
 corbet@lwn.net, bagasdotme@gmail.com, k-hagio-ab@nec.com,
 lijiang@redhat.com, kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
 hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20221019103623.7008-1-xianting.tian@linux.alibaba.com>
 <20221019103623.7008-2-xianting.tian@linux.alibaba.com>
 <Y1CtreAKT/SEh4vN@MiWiFi-R3L-srv>
 <30621b3b-47ba-d612-cfb0-583d779691a3@linux.alibaba.com>
 <Y1C681H2mlxX+zqf@MiWiFi-R3L-srv>
 <6af05838-fa58-8197-f3ce-ca95457077a7@linux.alibaba.com>
 <5df30e57-88ae-0a3b-2c1a-b962363d8670@linux.alibaba.com>
 <Y1j9AAhJXpoCx48N@wendy>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <Y1j9AAhJXpoCx48N@wendy>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_024501_164450_62D87909 
X-CRM114-Status: GOOD (  19.14  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

CuWcqCAyMDIyLzEwLzI2IOS4i+WNiDU6MjUsIENvbm9yIERvb2xleSDlhpnpgZM6Cj4gT24gV2Vk
LCBPY3QgMjYsIDIwMjIgYXQgMDU6MDg6MTFQTSArMDgwMCwgWGlhbnRpbmcgVGlhbiB3cm90ZToK
Pj4gSGkgUGFsbWVyLCBDb25vcgo+Pgo+PiBJcyB0aGlzIHZlcnNpb24gT0sgZm9yIHlvdT8KPiBU
aGUgd2VpcmQgaWZkZWYvSVNfRU5BQkxFRCB0aGluZyB3YXMgdGhlIG9ubHkgY29tbWVudCBJIGhh
ZC4gSXQncyBhIGJpdAo+IG9kZCAmIEkgbm90aWNlIEJhb3F1YW4gYnJvdWdodCBpdCB1cCB0b28u
IEkgZGlkbid0IChhbmQgd29uJ3QpIGdpdmUgeW91Cj4gYSByZXZpZXdlZCBieSBvbiB0aGVzZSBw
YXRjaGVzIGJlY2F1c2UgSSBkb24ndCB1bmRlcnN0YW5kIHRoZSBhcmVhIHdlbGwKPiBlbm91Z2gu
IFRoZSBnZW5lcmFsIG5pdHBpY2tlcnkgc2VlbXMgdG8gYmUgc29ydGVkIHRob3VnaC4KCkkgY2hl
Y2tlZCB0aGUgS0VSTkVMX0xJTktfQUREUiBkZWZpbml0aW9uIG9mIHJpc2N2LMKgIGl0IGlzIHZh
bGlkIGZvciAKQ09ORklHXzY0QklUIGFuZCAhQ09ORklHXzY0QklULgoKTWF5YmUgd2UgY2FuIHJl
bW92ZSBJU19FTkFCTEVEKENPTkZJR182NEJJVCkKCmFyY2gvcmlzY3YvaW5jbHVkZS9hc20vcGd0
YWJsZS5oCiNkZWZpbmUgQUREUkVTU19TUEFDRV9FTkTCoMKgwqDCoMKgwqAgKFVMKC0xKSkKI2lm
ZGVmIENPTkZJR182NEJJVAovKiBMZWF2ZSAyR0IgZm9yIGtlcm5lbCBhbmQgQlBGIGF0IHRoZSBl
bmQgb2YgdGhlIGFkZHJlc3Mgc3BhY2UgKi8KI2RlZmluZSBLRVJORUxfTElOS19BRERSwqDCoMKg
wqDCoMKgwqAgKEFERFJFU1NfU1BBQ0VfRU5EIC0gU1pfMkcgKyAxKQojZWxzZQojZGVmaW5lIEtF
Uk5FTF9MSU5LX0FERFLCoMKgwqDCoMKgwqDCoCBQQUdFX09GRlNFVAojZW5kaWYKCmFyY2gvcmlz
Y3YvaW5jbHVkZS9hc20vcGFnZS5oCiNpZmRlZiBDT05GSUdfNjRCSVQKI2lmZGVmIENPTkZJR19N
TVUKI2RlZmluZSBQQUdFX09GRlNFVMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrZXJuZWxfbWFw
LnBhZ2Vfb2Zmc2V0CiNlbHNlCiNkZWZpbmUgUEFHRV9PRkZTRVTCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgX0FDKENPTkZJR19QQUdFX09GRlNFVCwgVUwpCiNlbmRpZgovKgogwqAqIEJ5IGRlZmF1
bHQsIENPTkZJR19QQUdFX09GRlNFVCB2YWx1ZSBjb3JyZXNwb25kcyB0byBTVjQ4IGFkZHJlc3Mg
CnNwYWNlIHNvCiDCoCogZGVmaW5lIHRoZSBQQUdFX09GRlNFVCB2YWx1ZSBmb3IgU1YzOS4KIMKg
Ki8KI2RlZmluZSBQQUdFX09GRlNFVF9MNMKgwqDCoMKgwqDCoMKgwqDCoCBfQUMoMHhmZmZmYWY4
MDAwMDAwMDAwLCBVTCkKI2RlZmluZSBQQUdFX09GRlNFVF9MM8KgwqDCoMKgwqDCoMKgwqDCoCBf
QUMoMHhmZmZmZmZkODAwMDAwMDAwLCBVTCkKI2Vsc2UKI2RlZmluZSBQQUdFX09GRlNFVMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBfQUMoQ09ORklHX1BBR0VfT0ZGU0VULCBVTCkKI2VuZGlmIC8q
IENPTkZJR182NEJJVCAqLwoKPgo+IFRoYW5rcywKPiBDb25vci4KPgo+PiDlnKggMjAyMi8xMC8y
MCDkuIvljYgxMjo0MCwgWGlhbnRpbmcgVGlhbiDlhpnpgZM6Cj4+PiDlnKggMjAyMi8xMC8yMCDk
uIrljYgxMTowNSwgQmFvcXVhbiBIZSDlhpnpgZM6Cj4+Pj4gT24gMTAvMjAvMjIgYXQgMTA6MTdh
bSwgWGlhbnRpbmcgVGlhbiB3cm90ZToKPj4+Pj4g5ZyoIDIwMjIvMTAvMjAg5LiK5Y2IMTA6MDgs
IEJhb3F1YW4gSGUg5YaZ6YGTOgo+Pj4+Pj4gT24gMTAvMTkvMjIgYXQgMDY6MzZwbSwgWGlhbnRp
bmcgVGlhbiB3cm90ZToKPj4+Pj4+PiBBZGQgYXJjaF9jcmFzaF9zYXZlX3ZtY29yZWluZm8oKSwg
d2hpY2ggZXhwb3J0cyBWTQo+Pj4+Pj4+IGxheW91dChNT0RVTEVTLCBWTUFMTE9DLAo+Pj4+Pj4+
IFZNRU1NQVAgcmFuZ2VzIGFuZCBLRVJORUxfTElOS19BRERSKSwgdmEgYml0cyBhbmQgcmFtCj4+
Pj4+Pj4gYmFzZSBmb3Igdm1jb3JlLgo+Pj4+Pj4+Cj4+Pj4+Pj4gRGVmYXVsdCBwYWdldGFibGUg
bGV2ZWxzIGFuZCBQQUdFX09GRlNFVCBhcmVuJ3Qgc2FtZSBmb3IKPj4+Pj4+PiBkaWZmZXJlbnQg
a2VybmVsCj4+Pj4+Pj4gdmVyc2lvbiBhcyBiZWxvdy4gRm9yIHBhZ2V0YWJsZSBsZXZlbHMsIGl0
IHNldHMgc3Y1NyBieQo+Pj4+Pj4+IGRlZmF1bHQgYW5kIGZhbGxzCj4+Pj4+Pj4gYmFjayB0byBz
ZXR0aW5nIHN2NDggYXQgYm9vdCB0aW1lIGlmIHN2NTcgaXMgbm90Cj4+Pj4+Pj4gc3VwcG9ydGVk
IGJ5IHRoZSBoYXJkd2FyZS4KPj4+Pj4+Pgo+Pj4+Pj4+IEZvciByYW0gYmFzZSwgdGhlIGRlZmF1
bHQgdmFsdWUgaXMgMHg4MDIwMDAwMCBmb3IgcWVtdQo+Pj4+Pj4+IHJpc2N2NjQgZW52IGFuZCwK
Pj4+Pj4+PiBmb3IgZXhhbXBsZSwgaXMgMHgyMDAwMDAgb24gdGhlIFh1YW5UaWUgOTEwIENQVS4K
Pj4+Pj4+Pgo+Pj4+Pj4+ICDCoMKgICogTGludXggS2VybmVsIDUuMTggfgo+Pj4+Pj4+ICDCoMKg
ICrCoMKgwqDCoMKgIFBHVEFCTEVfTEVWRUxTID0gNQo+Pj4+Pj4+ICDCoMKgICrCoMKgwqDCoMKg
IFBBR0VfT0ZGU0VUID0gMHhmZjYwMDAwMDAwMDAwMDAwCj4+Pj4+Pj4gIMKgwqAgKiBMaW51eCBL
ZXJuZWwgNS4xNyB+Cj4+Pj4+Pj4gIMKgwqAgKsKgwqDCoMKgwqAgUEdUQUJMRV9MRVZFTFMgPSA0
Cj4+Pj4+Pj4gIMKgwqAgKsKgwqDCoMKgwqAgUEFHRV9PRkZTRVQgPSAweGZmZmZhZjgwMDAwMDAw
MDAKPj4+Pj4+PiAgwqDCoCAqIExpbnV4IEtlcm5lbCA0LjE5IH4KPj4+Pj4+PiAgwqDCoCAqwqDC
oMKgwqDCoCBQR1RBQkxFX0xFVkVMUyA9IDMKPj4+Pj4+PiAgwqDCoCAqwqDCoMKgwqDCoCBQQUdF
X09GRlNFVCA9IDB4ZmZmZmZmZTAwMDAwMDAwMAo+Pj4+Pj4+Cj4+Pj4+Pj4gU2luY2UgdGhlc2Ug
Y29uZmlndXJhdGlvbnMgY2hhbmdlIGZyb20gdGltZSB0byB0aW1lIGFuZAo+Pj4+Pj4+IHZlcnNp
b24gdG8gdmVyc2lvbiwKPj4+Pj4+PiBpdCBpcyBwcmVmZXJhYmxlIHRvIGV4cG9ydCB0aGVtIHZp
YSB2bWNvcmVpbmZvIHRoYW4gdG8KPj4+Pj4+PiBjaGFuZ2UgdGhlIGNyYXNoJ3MKPj4+Pj4+PiBj
b2RlIGZyZXF1ZW50bHksIGl0IGNhbiBzaW1wbGlmeSB0aGUgZGV2ZWxvcG1lbnQgb2YgY3Jhc2gg
dG9vbC4KPj4+Pj4+Pgo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFhpYW50aW5nIFRpYW4gPHhpYW50
aW5nLnRpYW5AbGludXguYWxpYmFiYS5jb20+Cj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4gIMKgwqAgYXJj
aC9yaXNjdi9rZXJuZWwvTWFrZWZpbGXCoMKgwqDCoCB8wqAgMSArCj4+Pj4+Pj4gIMKgwqAgYXJj
aC9yaXNjdi9rZXJuZWwvY3Jhc2hfY29yZS5jIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysK
Pj4+Pj4+PiAgwqDCoCAyIGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKykKPj4+Pj4+PiAg
wqDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9rZXJuZWwvY3Jhc2hfY29yZS5jCj4+
Pj4+Pj4KPj4+Pj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUgYi9h
cmNoL3Jpc2N2L2tlcm5lbC9NYWtlZmlsZQo+Pj4+Pj4+IGluZGV4IGRiNmU0YjEyOTRiYS4uNGNm
MzAzYTc3OWFiIDEwMDY0NAo+Pj4+Pj4+IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxl
Cj4+Pj4+Pj4gKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUKPj4+Pj4+PiBAQCAtODEs
NiArODEsNyBAQCBvYmotJChDT05GSUdfS0dEQinCoMKgwqDCoMKgwqDCoCArPSBrZ2RiLm8KPj4+
Pj4+PiAgwqDCoCBvYmotJChDT05GSUdfS0VYRUNfQ09SRSnCoMKgwqAgKz0ga2V4ZWNfcmVsb2Nh
dGUubwo+Pj4+Pj4+IGNyYXNoX3NhdmVfcmVncy5vIG1hY2hpbmVfa2V4ZWMubwo+Pj4+Pj4+ICDC
oMKgIG9iai0kKENPTkZJR19LRVhFQ19GSUxFKcKgwqDCoCArPSBlbGZfa2V4ZWMubyBtYWNoaW5l
X2tleGVjX2ZpbGUubwo+Pj4+Pj4+ICDCoMKgIG9iai0kKENPTkZJR19DUkFTSF9EVU1QKcKgwqDC
oCArPSBjcmFzaF9kdW1wLm8KPj4+Pj4+PiArb2JqLSQoQ09ORklHX0NSQVNIX0NPUkUpwqDCoMKg
ICs9IGNyYXNoX2NvcmUubwo+Pj4+Pj4+ICDCoMKgIG9iai0kKENPTkZJR19KVU1QX0xBQkVMKcKg
wqDCoCArPSBqdW1wX2xhYmVsLm8KPj4+Pj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJu
ZWwvY3Jhc2hfY29yZS5jCj4+Pj4+Pj4gYi9hcmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9jb3JlLmMK
Pj4+Pj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+Pj4+Pj4+IGluZGV4IDAwMDAwMDAwMDAwMC4u
M2U4ODlkMGVkN2JkCj4+Pj4+Pj4gLS0tIC9kZXYvbnVsbAo+Pj4+Pj4+ICsrKyBiL2FyY2gvcmlz
Y3Yva2VybmVsL2NyYXNoX2NvcmUuYwo+Pj4+Pj4+IEBAIC0wLDAgKzEsMjMgQEAKPj4+Pj4+PiAr
Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQo+Pj4+Pj4+ICsKPj4+Pj4+
PiArI2luY2x1ZGUgPGxpbnV4L2NyYXNoX2NvcmUuaD4KPj4+Pj4+PiArI2luY2x1ZGUgPGxpbnV4
L3BhZ2VtYXAuaD4KPj4+Pj4+PiArCj4+Pj4+Pj4gK3ZvaWQgYXJjaF9jcmFzaF9zYXZlX3ZtY29y
ZWluZm8odm9pZCkKPj4+Pj4+PiArewo+Pj4+Pj4+ICvCoMKgwqAgVk1DT1JFSU5GT19OVU1CRVIo
VkFfQklUUyk7Cj4+Pj4+Pj4gK8KgwqDCoCBWTUNPUkVJTkZPX05VTUJFUihwaHlzX3JhbV9iYXNl
KTsKPj4+Pj4+PiArCj4+Pj4+Pj4gKwo+Pj4+Pj4+IHZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVN
QkVSKFBBR0VfT0ZGU0VUKT0weCVseFxuIiwKPj4+Pj4+PiBQQUdFX09GRlNFVCk7Cj4+Pj4+Pj4g
KyB2bWNvcmVpbmZvX2FwcGVuZF9zdHIoIk5VTUJFUihWTUFMTE9DX1NUQVJUKT0weCVseFxuIiwK
Pj4+Pj4+PiBWTUFMTE9DX1NUQVJUKTsKPj4+Pj4+PiArCj4+Pj4+Pj4gdm1jb3JlaW5mb19hcHBl
bmRfc3RyKCJOVU1CRVIoVk1BTExPQ19FTkQpPTB4JWx4XG4iLAo+Pj4+Pj4+IFZNQUxMT0NfRU5E
KTsKPj4+Pj4+PiArIHZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVNQkVSKFZNRU1NQVBfU1RBUlQp
PTB4JWx4XG4iLAo+Pj4+Pj4+IFZNRU1NQVBfU1RBUlQpOwo+Pj4+Pj4+ICsKPj4+Pj4+PiB2bWNv
cmVpbmZvX2FwcGVuZF9zdHIoIk5VTUJFUihWTUVNTUFQX0VORCk9MHglbHhcbiIsCj4+Pj4+Pj4g
Vk1FTU1BUF9FTkQpOwo+Pj4+Pj4+ICsjaWZkZWYgQ09ORklHXzY0QklUCj4+Pj4+Pj4gKyB2bWNv
cmVpbmZvX2FwcGVuZF9zdHIoIk5VTUJFUihNT0RVTEVTX1ZBRERSKT0weCVseFxuIiwKPj4+Pj4+
PiBNT0RVTEVTX1ZBRERSKTsKPj4+Pj4+PiArCj4+Pj4+Pj4gdm1jb3JlaW5mb19hcHBlbmRfc3Ry
KCJOVU1CRVIoTU9EVUxFU19FTkQpPTB4JWx4XG4iLAo+Pj4+Pj4+IE1PRFVMRVNfRU5EKTsKPj4+
Pj4+PiArI2VuZGlmCj4+Pj4+Pj4gKwo+Pj4+Pj4+ICvCoMKgwqAgaWYgKElTX0VOQUJMRUQoQ09O
RklHXzY0QklUKSkKPj4+Pj4+PiArCj4+Pj4+Pj4gdm1jb3JlaW5mb19hcHBlbmRfc3RyKCJOVU1C
RVIoS0VSTkVMX0xJTktfQUREUik9MHglbHhcbiIsCj4+Pj4+Pj4gS0VSTkVMX0xJTktfQUREUik7
Cj4+Pj4+PiBXb25kZXJpbmcgd2h5IHlvdSBkb24ndCBwdXQgS0VSTkVMX0xJTktfQUREUiBleHBv
cnRpbmcgaW50byB0aGUgYWJvdmUKPj4+Pj4+IGlmZGVmZmVyeSBzY29wZSwgd2l0aCB0aGF0IHlv
dSBjYW4gc2F2ZSBvbmUgbGluZSBvZgo+Pj4+Pj4gIklTX0VOQUJMRUQoQ09ORklHXzY0QklUKSIu
Cj4+Pj4+IEkgZm9sbG93ZWQgdGhlIHJ1bGUgaW4gcHJpbnRfdm1fbGF5b3V0KCkgb2YKPj4+Pj4g
YXJjaC9yaXNjdi9tbS9pbml0LmMsIHdoaWNoIHVzZWQKPj4+Pj4gSVNfRU5BQkxFRCB3aGVuIHBy
aW50IHRoZSB2YWx1ZSBvZiBLRVJORUxfTElOS19BRERSLgo+Pj4+Pgo+Pj4+IEkgc2VlLiBUaGVy
ZSdzIFBBR0VfT0ZGU0VUIGluIHRoZSBtaWRkbGUuIFRoYW5rcy4KPj4+Pgo+Pj4+ICDCoMKgwqDC
oMKgwqDCoMKgIHByaW50X21sKCJsb3dtZW0iLCAodW5zaWduZWQgbG9uZylQQUdFX09GRlNFVCwK
Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHVuc2lnbmVkIGxvbmcpaGln
aF9tZW1vcnkpCj4+Pj4KPj4+PiBTbyBub3csIGRvIHlvdSB0aGluayBpZiBpdCdzIG5lY2Vzc2Fy
eSB0byBoYXZlIGFub3RoZXIKPj4+PiBJU19FTkFCTEVEKENPTkZJR182NEJJVCkgaW4gdGhlIGN1
cnJlbnQgYXJjaF9jcmFzaF9zYXZlX3ZtY29yZWluZm8oKT8KPj4+IEZvciB3aGljaCBNQUNSTz/C
oCBJIHRoaW5rIGN1cnJlbnQgY29kZSBmb3IgUEFHRV9PRkZTRVQgaXMgT0suCj4+PgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBs
aXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
