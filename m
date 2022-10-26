Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19EAC38A2D
	for <kexec@archiver.kernel.org>; Wed, 26 Oct 2022 09:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ocauf7irj9nVDsuGkdGHHKPi8ub4jm1q2qIYkOG8CBs=; b=35U0thJfjq1GUv
	VSTtxIvejL1wJQRrHlJWUrFQKCkR6b2yIjvH2pe2PqMl7qXDXhP4ckxsAYOOtMrEqCjoBUpHU/j8N
	f445yAZ+hHKw3511RVn+42WoN5HXmxME821vPnIAvX58iRNw9/Z8L02D5+ZJXmCLk8b5CVtLYiDuk
	qJnf+fCxhOt4uRb87lU82rfnaJz6x04np5hG8R3FO6vQdabCVvBtj4JpTzA4sNRD+ss61i9yCsr+U
	WiSxmwVdsuoYCXOsOORqb6vS8OBHvY5L0Z+Uc9M1Va1aGEXO7ZUGECe3JicW+3NT9Z2E+vmUo8/KL
	66ayWKm6LIFe9fw4ESDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oncOg-008fao-9y; Wed, 26 Oct 2022 09:08:26 +0000
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oncOd-008fYS-2Z; Wed, 26 Oct 2022 09:08:25 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VT6dyvZ_1666775291;
Received: from 30.221.97.58(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VT6dyvZ_1666775291)
          by smtp.aliyun-inc.com;
          Wed, 26 Oct 2022 17:08:13 +0800
Message-ID: <5df30e57-88ae-0a3b-2c1a-b962363d8670@linux.alibaba.com>
Date: Wed, 26 Oct 2022 17:08:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V4 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
From: Xianting Tian <xianting.tian@linux.alibaba.com>
To: Baoquan He <bhe@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Conor Dooley <Conor.Dooley@microchip.com>
Cc: paul.walmsley@sifive.com, aou@eecs.berkeley.edu, anup@brainfault.org,
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
In-Reply-To: <6af05838-fa58-8197-f3ce-ca95457077a7@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_020823_305731_680E8080 
X-CRM114-Status: GOOD (  14.29  )
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

SGkgUGFsbWVyLCBDb25vcgoKSXMgdGhpcyB2ZXJzaW9uIE9LIGZvciB5b3U/IERvIHlvdSBwbGFu
IHRvIGFwcGx5IHRoaXMgcGF0Y2ggc2V0PyB0aGFua3MKCuWcqCAyMDIyLzEwLzIwIOS4i+WNiDEy
OjQwLCBYaWFudGluZyBUaWFuIOWGmemBkzoKPgo+IOWcqCAyMDIyLzEwLzIwIOS4iuWNiDExOjA1
LCBCYW9xdWFuIEhlIOWGmemBkzoKPj4gT24gMTAvMjAvMjIgYXQgMTA6MTdhbSwgWGlhbnRpbmcg
VGlhbiB3cm90ZToKPj4+IOWcqCAyMDIyLzEwLzIwIOS4iuWNiDEwOjA4LCBCYW9xdWFuIEhlIOWG
memBkzoKPj4+PiBPbiAxMC8xOS8yMiBhdCAwNjozNnBtLCBYaWFudGluZyBUaWFuIHdyb3RlOgo+
Pj4+PiBBZGQgYXJjaF9jcmFzaF9zYXZlX3ZtY29yZWluZm8oKSwgd2hpY2ggZXhwb3J0cyBWTSBs
YXlvdXQoTU9EVUxFUywgCj4+Pj4+IFZNQUxMT0MsCj4+Pj4+IFZNRU1NQVAgcmFuZ2VzIGFuZCBL
RVJORUxfTElOS19BRERSKSwgdmEgYml0cyBhbmQgcmFtIGJhc2UgZm9yIAo+Pj4+PiB2bWNvcmUu
Cj4+Pj4+Cj4+Pj4+IERlZmF1bHQgcGFnZXRhYmxlIGxldmVscyBhbmQgUEFHRV9PRkZTRVQgYXJl
bid0IHNhbWUgZm9yIGRpZmZlcmVudCAKPj4+Pj4ga2VybmVsCj4+Pj4+IHZlcnNpb24gYXMgYmVs
b3cuIEZvciBwYWdldGFibGUgbGV2ZWxzLCBpdCBzZXRzIHN2NTcgYnkgZGVmYXVsdCAKPj4+Pj4g
YW5kIGZhbGxzCj4+Pj4+IGJhY2sgdG8gc2V0dGluZyBzdjQ4IGF0IGJvb3QgdGltZSBpZiBzdjU3
IGlzIG5vdCBzdXBwb3J0ZWQgYnkgdGhlIAo+Pj4+PiBoYXJkd2FyZS4KPj4+Pj4KPj4+Pj4gRm9y
IHJhbSBiYXNlLCB0aGUgZGVmYXVsdCB2YWx1ZSBpcyAweDgwMjAwMDAwIGZvciBxZW11IHJpc2N2
NjQgZW52IAo+Pj4+PiBhbmQsCj4+Pj4+IGZvciBleGFtcGxlLCBpcyAweDIwMDAwMCBvbiB0aGUg
WHVhblRpZSA5MTAgQ1BVLgo+Pj4+Pgo+Pj4+PiDCoMKgICogTGludXggS2VybmVsIDUuMTggfgo+
Pj4+PiDCoMKgICrCoMKgwqDCoMKgIFBHVEFCTEVfTEVWRUxTID0gNQo+Pj4+PiDCoMKgICrCoMKg
wqDCoMKgIFBBR0VfT0ZGU0VUID0gMHhmZjYwMDAwMDAwMDAwMDAwCj4+Pj4+IMKgwqAgKiBMaW51
eCBLZXJuZWwgNS4xNyB+Cj4+Pj4+IMKgwqAgKsKgwqDCoMKgwqAgUEdUQUJMRV9MRVZFTFMgPSA0
Cj4+Pj4+IMKgwqAgKsKgwqDCoMKgwqAgUEFHRV9PRkZTRVQgPSAweGZmZmZhZjgwMDAwMDAwMDAK
Pj4+Pj4gwqDCoCAqIExpbnV4IEtlcm5lbCA0LjE5IH4KPj4+Pj4gwqDCoCAqwqDCoMKgwqDCoCBQ
R1RBQkxFX0xFVkVMUyA9IDMKPj4+Pj4gwqDCoCAqwqDCoMKgwqDCoCBQQUdFX09GRlNFVCA9IDB4
ZmZmZmZmZTAwMDAwMDAwMAo+Pj4+Pgo+Pj4+PiBTaW5jZSB0aGVzZSBjb25maWd1cmF0aW9ucyBj
aGFuZ2UgZnJvbSB0aW1lIHRvIHRpbWUgYW5kIHZlcnNpb24gdG8gCj4+Pj4+IHZlcnNpb24sCj4+
Pj4+IGl0IGlzIHByZWZlcmFibGUgdG8gZXhwb3J0IHRoZW0gdmlhIHZtY29yZWluZm8gdGhhbiB0
byBjaGFuZ2UgdGhlIAo+Pj4+PiBjcmFzaCdzCj4+Pj4+IGNvZGUgZnJlcXVlbnRseSwgaXQgY2Fu
IHNpbXBsaWZ5IHRoZSBkZXZlbG9wbWVudCBvZiBjcmFzaCB0b29sLgo+Pj4+Pgo+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBYaWFudGluZyBUaWFuIDx4aWFudGluZy50aWFuQGxpbnV4LmFsaWJhYmEuY29t
Pgo+Pj4+PiAtLS0KPj4+Pj4gwqDCoCBhcmNoL3Jpc2N2L2tlcm5lbC9NYWtlZmlsZcKgwqDCoMKg
IHzCoCAxICsKPj4+Pj4gwqDCoCBhcmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9jb3JlLmMgfCAyMyAr
KysrKysrKysrKysrKysrKysrKysrKwo+Pj4+PiDCoMKgIDIgZmlsZXMgY2hhbmdlZCwgMjQgaW5z
ZXJ0aW9ucygrKQo+Pj4+PiDCoMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2tlcm5l
bC9jcmFzaF9jb3JlLmMKPj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2VybmVs
L01ha2VmaWxlIGIvYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUKPj4+Pj4gaW5kZXggZGI2ZTRi
MTI5NGJhLi40Y2YzMDNhNzc5YWIgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVs
L01ha2VmaWxlCj4+Pj4+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxlCj4+Pj4+IEBA
IC04MSw2ICs4MSw3IEBAIG9iai0kKENPTkZJR19LR0RCKcKgwqDCoMKgwqDCoMKgICs9IGtnZGIu
bwo+Pj4+PiDCoMKgIG9iai0kKENPTkZJR19LRVhFQ19DT1JFKcKgwqDCoCArPSBrZXhlY19yZWxv
Y2F0ZS5vIAo+Pj4+PiBjcmFzaF9zYXZlX3JlZ3MubyBtYWNoaW5lX2tleGVjLm8KPj4+Pj4gwqDC
oCBvYmotJChDT05GSUdfS0VYRUNfRklMRSnCoMKgwqAgKz0gZWxmX2tleGVjLm8gbWFjaGluZV9r
ZXhlY19maWxlLm8KPj4+Pj4gwqDCoCBvYmotJChDT05GSUdfQ1JBU0hfRFVNUCnCoMKgwqAgKz0g
Y3Jhc2hfZHVtcC5vCj4+Pj4+ICtvYmotJChDT05GSUdfQ1JBU0hfQ09SRSnCoMKgwqAgKz0gY3Jh
c2hfY29yZS5vCj4+Pj4+IMKgwqAgb2JqLSQoQ09ORklHX0pVTVBfTEFCRUwpwqDCoMKgICs9IGp1
bXBfbGFiZWwubwo+Pj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvY3Jhc2hfY29y
ZS5jIAo+Pj4+PiBiL2FyY2gvcmlzY3Yva2VybmVsL2NyYXNoX2NvcmUuYwo+Pj4+PiBuZXcgZmls
ZSBtb2RlIDEwMDY0NAo+Pj4+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjNlODg5ZDBlZDdiZAo+Pj4+
PiAtLS0gL2Rldi9udWxsCj4+Pj4+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVsL2NyYXNoX2NvcmUu
Ywo+Pj4+PiBAQCAtMCwwICsxLDIzIEBACj4+Pj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMC1vbmx5Cj4+Pj4+ICsKPj4+Pj4gKyNpbmNsdWRlIDxsaW51eC9jcmFzaF9jb3Jl
Lmg+Cj4+Pj4+ICsjaW5jbHVkZSA8bGludXgvcGFnZW1hcC5oPgo+Pj4+PiArCj4+Pj4+ICt2b2lk
IGFyY2hfY3Jhc2hfc2F2ZV92bWNvcmVpbmZvKHZvaWQpCj4+Pj4+ICt7Cj4+Pj4+ICvCoMKgwqAg
Vk1DT1JFSU5GT19OVU1CRVIoVkFfQklUUyk7Cj4+Pj4+ICvCoMKgwqAgVk1DT1JFSU5GT19OVU1C
RVIocGh5c19yYW1fYmFzZSk7Cj4+Pj4+ICsKPj4+Pj4gK8KgwqDCoCB2bWNvcmVpbmZvX2FwcGVu
ZF9zdHIoIk5VTUJFUihQQUdFX09GRlNFVCk9MHglbHhcbiIsIAo+Pj4+PiBQQUdFX09GRlNFVCk7
Cj4+Pj4+ICsgdm1jb3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIoVk1BTExPQ19TVEFSVCk9MHgl
bHhcbiIsIAo+Pj4+PiBWTUFMTE9DX1NUQVJUKTsKPj4+Pj4gK8KgwqDCoCB2bWNvcmVpbmZvX2Fw
cGVuZF9zdHIoIk5VTUJFUihWTUFMTE9DX0VORCk9MHglbHhcbiIsIAo+Pj4+PiBWTUFMTE9DX0VO
RCk7Cj4+Pj4+ICsgdm1jb3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIoVk1FTU1BUF9TVEFSVCk9
MHglbHhcbiIsIAo+Pj4+PiBWTUVNTUFQX1NUQVJUKTsKPj4+Pj4gK8KgwqDCoCB2bWNvcmVpbmZv
X2FwcGVuZF9zdHIoIk5VTUJFUihWTUVNTUFQX0VORCk9MHglbHhcbiIsIAo+Pj4+PiBWTUVNTUFQ
X0VORCk7Cj4+Pj4+ICsjaWZkZWYgQ09ORklHXzY0QklUCj4+Pj4+ICsgdm1jb3JlaW5mb19hcHBl
bmRfc3RyKCJOVU1CRVIoTU9EVUxFU19WQUREUik9MHglbHhcbiIsIAo+Pj4+PiBNT0RVTEVTX1ZB
RERSKTsKPj4+Pj4gK8KgwqDCoCB2bWNvcmVpbmZvX2FwcGVuZF9zdHIoIk5VTUJFUihNT0RVTEVT
X0VORCk9MHglbHhcbiIsIAo+Pj4+PiBNT0RVTEVTX0VORCk7Cj4+Pj4+ICsjZW5kaWYKPj4+Pj4g
Kwo+Pj4+PiArwqDCoMKgIGlmIChJU19FTkFCTEVEKENPTkZJR182NEJJVCkpCj4+Pj4+ICsgdm1j
b3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIoS0VSTkVMX0xJTktfQUREUik9MHglbHhcbiIsIAo+
Pj4+PiBLRVJORUxfTElOS19BRERSKTsKPj4+PiBXb25kZXJpbmcgd2h5IHlvdSBkb24ndCBwdXQg
S0VSTkVMX0xJTktfQUREUiBleHBvcnRpbmcgaW50byB0aGUgYWJvdmUKPj4+PiBpZmRlZmZlcnkg
c2NvcGUsIHdpdGggdGhhdCB5b3UgY2FuIHNhdmUgb25lIGxpbmUgb2YgCj4+Pj4gIklTX0VOQUJM
RUQoQ09ORklHXzY0QklUKSIuCj4+PiBJIGZvbGxvd2VkIHRoZSBydWxlIGluIHByaW50X3ZtX2xh
eW91dCgpIG9mIGFyY2gvcmlzY3YvbW0vaW5pdC5jLCAKPj4+IHdoaWNoIHVzZWQKPj4+IElTX0VO
QUJMRUQgd2hlbiBwcmludCB0aGUgdmFsdWUgb2YgS0VSTkVMX0xJTktfQUREUi4KPj4+Cj4+IEkg
c2VlLiBUaGVyZSdzIFBBR0VfT0ZGU0VUIGluIHRoZSBtaWRkbGUuIFRoYW5rcy4KPj4KPj4gwqDC
oMKgwqDCoMKgwqDCoCBwcmludF9tbCgibG93bWVtIiwgKHVuc2lnbmVkIGxvbmcpUEFHRV9PRkZT
RVQsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICh1bnNpZ25lZCBsb25nKWhp
Z2hfbWVtb3J5KQo+Pgo+PiBTbyBub3csIGRvIHlvdSB0aGluayBpZiBpdCdzIG5lY2Vzc2FyeSB0
byBoYXZlIGFub3RoZXIKPj4gSVNfRU5BQkxFRChDT05GSUdfNjRCSVQpIGluIHRoZSBjdXJyZW50
IGFyY2hfY3Jhc2hfc2F2ZV92bWNvcmVpbmZvKCk/Cj4KPiBGb3Igd2hpY2ggTUFDUk8/wqAgSSB0
aGluayBjdXJyZW50IGNvZGUgZm9yIFBBR0VfT0ZGU0VUIGlzIE9LLgo+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4
ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2tleGVjCg==
