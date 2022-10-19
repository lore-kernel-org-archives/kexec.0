Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C5CC43217
	for <kexec@archiver.kernel.org>; Wed, 19 Oct 2022 03:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Igse7q2iUuwxjkLCEyIWMsuz3Of6IRaM1E1qj0hm3m4=; b=UDAoWjrbDam6HA
	WkM9+7vKl+gURZFEesvpVgwIPiZTwy1GMJBkTBcWWFAFmie2WtD8Q0jrqtvBlfUbAcAGtw1jrM5r1
	1Kwlx5KJBBgIm1xXotLSDDUo2KeLWxgbLBBIgiFWHs7Z6iNU8BpgeJGdjdycABYJW/xCiQKhSIr+I
	SE5+kWkoZuiFtBII9Kcpo1fZGXNkuWVB8A35B+rQZ9srBE9uEOVBUnzW46vxwFkITIl+sZmQAh+J2
	bVYwUWmkQPmTudsZBe/do1dP4UjM2eBUklDYyUtR5yxlzKvZsZ25+KsclJyqmRK994DhAvKZXkqyX
	H4Wa5/pTJl4ccxI66U6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okzaC-00EFOz-EC; Wed, 19 Oct 2022 03:17:28 +0000
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okza9-00EFNU-L7; Wed, 19 Oct 2022 03:17:27 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VSYahCs_1666149436;
Received: from 30.221.97.167(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VSYahCs_1666149436)
          by smtp.aliyun-inc.com;
          Wed, 19 Oct 2022 11:17:18 +0800
Message-ID: <811bdf09-be38-ce2a-a1d3-ada9f7c85b97@linux.alibaba.com>
Date: Wed, 19 Oct 2022 11:17:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V3 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?=
 <k-hagio-ab@nec.com>, Baoquan He <bhe@redhat.com>,
 lijiang <lijiang@redhat.com>
Cc: "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
 "anup@brainfault.org" <anup@brainfault.org>,
 "heiko@sntech.de" <heiko@sntech.de>, "guoren@kernel.org"
 <guoren@kernel.org>, "mick@ics.forth.gr" <mick@ics.forth.gr>,
 "alexandre.ghiti@canonical.com" <alexandre.ghiti@canonical.com>,
 "vgoyal@redhat.com" <vgoyal@redhat.com>,
 "dyoung@redhat.com" <dyoung@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "Conor.Dooley@microchip.com" <Conor.Dooley@microchip.com>,
 "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "crash-utility@redhat.com" <crash-utility@redhat.com>,
 "heinrich.schuchardt@canonical.com" <heinrich.schuchardt@canonical.com>,
 "hschauhan@nulltrace.org" <hschauhan@nulltrace.org>,
 "yixun.lan@gmail.com" <yixun.lan@gmail.com>
References: <20221018081755.6214-1-xianting.tian@linux.alibaba.com>
 <20221018081755.6214-2-xianting.tian@linux.alibaba.com>
 <Y05tfxRenMs5d+bt@MiWiFi-R3L-srv>
 <049ec19e-60c3-2854-5f5e-9850231108b4@linux.alibaba.com>
 <Y05540td7lLz+0BY@MiWiFi-R3L-srv>
 <a66a5b16-5f1f-3d80-3cdc-4b82d38d604f@linux.alibaba.com>
 <0f0a77a9-c824-8aa4-77de-a75c2139d791@nec.com>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <0f0a77a9-c824-8aa4-77de-a75c2139d791@nec.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_201725_903657_B1DB1A00 
X-CRM114-Status: GOOD (  20.99  )
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

CuWcqCAyMDIyLzEwLzE5IOS4iuWNiDEwOjUwLCBIQUdJTyBLQVpVSElUTyjokKnlsL4g5LiA5LuB
KSDlhpnpgZM6Cj4gT24gMjAyMi8xMC8xOSAxMDo1MCwgWGlhbnRpbmcgVGlhbiB3cm90ZToKPj4g
5ZyoIDIwMjIvMTAvMTgg5LiL5Y2INjowMywgQmFvcXVhbiBIZSDlhpnpgZM6Cj4+PiBPbiAxMC8x
OC8yMiBhdCAwNToyNXBtLCBYaWFudGluZyBUaWFuIHdyb3RlOgo+Pj4+IOWcqCAyMDIyLzEwLzE4
IOS4i+WNiDU6MTAsIEJhb3F1YW4gSGUg5YaZ6YGTOgo+Pj4+PiBPbiAxMC8xOC8yMiBhdCAwNDox
N3BtLCBYaWFudGluZyBUaWFuIHdyb3RlOgo+Pj4+Pj4gQWRkIGFyY2hfY3Jhc2hfc2F2ZV92bWNv
cmVpbmZvKCksIHdoaWNoIGV4cG9ydHMgVk0gbGF5b3V0KE1PRFVMRVMsIFZNQUxMT0MsCj4+Pj4+
PiBWTUVNTUFQIGFuZCBLRVJORUxfTElOS19BRERSIHJhbmdlcyksIHZhIGJpdHMgYW5kIHJhbSBi
YXNlIGZvciB2bWNvcmUuCj4+Pj4+Pgo+Pj4+Pj4gRGVmYXVsdCBwYWdldGFibGUgbGV2ZWxzIGFu
ZCBQQUdFX09GRlNFVCBhcmVuJ3Qgc2FtZSBmb3IgZGlmZmVyZW50IGtlcm5lbAo+Pj4+Pj4gdmVy
c2lvbiBhcyBiZWxvdy4gRm9yIHBhZ2V0YWJsZSBsZXZlbHMsIGl0IHNldHMgc3Y1NyBieSBkZWZh
dWx0IGFuZCBmYWxscwo+Pj4+Pj4gYmFjayB0byBzZXR0aW5nIHN2NDggYXQgYm9vdCB0aW1lIGlm
IHN2NTcgaXMgbm90IHN1cHBvcnRlZCBieSB0aGUgaGFyZHdhcmUuCj4+Pj4+Pgo+Pj4+Pj4gRm9y
IHJhbSBiYXNlLCB0aGUgZGVmYXVsdCB2YWx1ZSBpcyAweDgwMjAwMDAwIGZvciBxZW11IHJpc2N2
NjQgZW52IGFuZCwKPj4+Pj4+IGZvciBleGFtcGxlLCBpcyAweDIwMDAwMCBvbiB0aGUgWHVhblRp
ZSA5MTAgQ1BVLgo+Pj4+Pj4KPj4+Pj4+ICDCoMKgICogTGludXggS2VybmVsIDUuMTggfgo+Pj4+
Pj4gIMKgwqAgKsKgwqDCoMKgwqAgUEdUQUJMRV9MRVZFTFMgPSA1Cj4+Pj4+PiAgwqDCoCAqwqDC
oMKgwqDCoCBQQUdFX09GRlNFVCA9IDB4ZmY2MDAwMDAwMDAwMDAwMAo+Pj4+Pj4gIMKgwqAgKiBM
aW51eCBLZXJuZWwgNS4xNyB+Cj4+Pj4+PiAgwqDCoCAqwqDCoMKgwqDCoCBQR1RBQkxFX0xFVkVM
UyA9IDQKPj4+Pj4+ICDCoMKgICrCoMKgwqDCoMKgIFBBR0VfT0ZGU0VUID0gMHhmZmZmYWY4MDAw
MDAwMDAwCj4+Pj4+PiAgwqDCoCAqIExpbnV4IEtlcm5lbCA0LjE5IH4KPj4+Pj4+ICDCoMKgICrC
oMKgwqDCoMKgIFBHVEFCTEVfTEVWRUxTID0gMwo+Pj4+Pj4gIMKgwqAgKsKgwqDCoMKgwqAgUEFH
RV9PRkZTRVQgPSAweGZmZmZmZmUwMDAwMDAwMDAKPj4+Pj4+Cj4+Pj4+PiBTaW5jZSB0aGVzZSBj
b25maWd1cmF0aW9ucyBjaGFuZ2UgZnJvbSB0aW1lIHRvIHRpbWUgYW5kIHZlcnNpb24gdG8gdmVy
c2lvbiwKPj4+Pj4+IGl0IGlzIHByZWZlcmFibGUgdG8gZXhwb3J0IHRoZW0gdmlhIHZtY29yZWlu
Zm8gdGhhbiB0byBjaGFuZ2UgdGhlIGNyYXNoJ3MKPj4+Pj4+IGNvZGUgZnJlcXVlbnRseSwgaXQg
Y2FuIHNpbXBsaWZ5IHRoZSBkZXZlbG9wbWVudCBvZiBjcmFzaCB0b29sLgo+Pj4+Pj4KPj4+Pj4+
IFNpZ25lZC1vZmYtYnk6IFhpYW50aW5nIFRpYW4gPHhpYW50aW5nLnRpYW5AbGludXguYWxpYmFi
YS5jb20+Cj4+Pj4+PiAtLS0KPj4+Pj4+ICDCoMKgIGFyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxl
wqDCoMKgwqAgfMKgIDEgKwo+Pj4+Pj4gIMKgwqAgYXJjaC9yaXNjdi9rZXJuZWwvY3Jhc2hfY29y
ZS5jIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4+Pj4+ICDCoMKgIDIgZmls
ZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKQo+Pj4+Pj4gIMKgwqAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGFyY2gvcmlzY3Yva2VybmVsL2NyYXNoX2NvcmUuYwo+Pj4+Pj4KPj4+Pj4+IGRpZmYgLS1n
aXQgYS9hcmNoL3Jpc2N2L2tlcm5lbC9NYWtlZmlsZSBiL2FyY2gvcmlzY3Yva2VybmVsL01ha2Vm
aWxlCj4+Pj4+PiBpbmRleCBkYjZlNGIxMjk0YmEuLjRjZjMwM2E3NzlhYiAxMDA2NDQKPj4+Pj4+
IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxlCj4+Pj4+PiArKysgYi9hcmNoL3Jpc2N2
L2tlcm5lbC9NYWtlZmlsZQo+Pj4+Pj4gQEAgLTgxLDYgKzgxLDcgQEAgb2JqLSQoQ09ORklHX0tH
REIpwqDCoMKgwqDCoMKgwqAgKz0ga2dkYi5vCj4+Pj4+PiAgwqDCoCBvYmotJChDT05GSUdfS0VY
RUNfQ09SRSnCoMKgwqAgKz0ga2V4ZWNfcmVsb2NhdGUubyBjcmFzaF9zYXZlX3JlZ3MubyBtYWNo
aW5lX2tleGVjLm8KPj4+Pj4+ICDCoMKgIG9iai0kKENPTkZJR19LRVhFQ19GSUxFKcKgwqDCoCAr
PSBlbGZfa2V4ZWMubyBtYWNoaW5lX2tleGVjX2ZpbGUubwo+Pj4+Pj4gIMKgwqAgb2JqLSQoQ09O
RklHX0NSQVNIX0RVTVApwqDCoMKgICs9IGNyYXNoX2R1bXAubwo+Pj4+Pj4gK29iai0kKENPTkZJ
R19DUkFTSF9DT1JFKcKgwqDCoCArPSBjcmFzaF9jb3JlLm8KPj4+Pj4+ICDCoMKgIG9iai0kKENP
TkZJR19KVU1QX0xBQkVMKcKgwqDCoCArPSBqdW1wX2xhYmVsLm8KPj4+Pj4+IGRpZmYgLS1naXQg
YS9hcmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9jb3JlLmMgYi9hcmNoL3Jpc2N2L2tlcm5lbC9jcmFz
aF9jb3JlLmMKPj4+Pj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+Pj4+PiBpbmRleCAwMDAwMDAw
MDAwMDAuLjhkN2Y1ZmYxMDhkYQo+Pj4+Pj4gLS0tIC9kZXYvbnVsbAo+Pj4+Pj4gKysrIGIvYXJj
aC9yaXNjdi9rZXJuZWwvY3Jhc2hfY29yZS5jCj4+Pj4+PiBAQCAtMCwwICsxLDI5IEBACj4+Pj4+
PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQo+Pj4+Pj4gKwo+Pj4+
Pj4gKyNpbmNsdWRlIDxsaW51eC9jcmFzaF9jb3JlLmg+Cj4+Pj4+PiArI2luY2x1ZGUgPGxpbnV4
L3BhZ2VtYXAuaD4KPj4+Pj4+ICsKPj4+Pj4+ICt2b2lkIGFyY2hfY3Jhc2hfc2F2ZV92bWNvcmVp
bmZvKHZvaWQpCj4+Pj4+PiArewo+Pj4+Pj4gK8KgwqDCoCBWTUNPUkVJTkZPX05VTUJFUihWQV9C
SVRTKTsKPj4+Pj4+ICvCoMKgwqAgVk1DT1JFSU5GT19OVU1CRVIocGh5c19yYW1fYmFzZSk7Cj4+
Pj4+PiArCj4+Pj4+PiArwqDCoMKgIHZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVNQkVSKFBBR0Vf
T0ZGU0VUKT0weCVseFxuIiwgUEFHRV9PRkZTRVQpOwo+Pj4+Pj4gK8KgwqDCoCB2bWNvcmVpbmZv
X2FwcGVuZF9zdHIoIk5VTUJFUihWTUFMTE9DX1NUQVJUKT0weCVseFxuIiwgVk1BTExPQ19TVEFS
VCk7Cj4+Pj4+PiArwqDCoMKgIHZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVNQkVSKFZNQUxMT0Nf
RU5EKT0weCVseFxuIiwgVk1BTExPQ19FTkQpOwo+Pj4+Pj4gK8KgwqDCoCB2bWNvcmVpbmZvX2Fw
cGVuZF9zdHIoIk5VTUJFUihWTUVNTUFQX1NUQVJUKT0weCVseFxuIiwgVk1FTU1BUF9TVEFSVCk7
Cj4+Pj4+PiArwqDCoMKgIHZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVNQkVSKFZNRU1NQVBfRU5E
KT0weCVseFxuIiwgVk1FTU1BUF9FTkQpOwo+Pj4+Pj4gKyNpZmRlZiBDT05GSUdfNjRCSVQKPj4+
Pj4+ICvCoMKgwqAgdm1jb3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIoTU9EVUxFU19WQUREUik9
MHglbHhcbiIsIE1PRFVMRVNfVkFERFIpOwo+Pj4+Pj4gK8KgwqDCoCB2bWNvcmVpbmZvX2FwcGVu
ZF9zdHIoIk5VTUJFUihNT0RVTEVTX0VORCk9MHglbHhcbiIsIE1PRFVMRVNfRU5EKTsKPj4+Pj4+
ICsjZW5kaWYKPj4+Pj4+ICsKPj4+Pj4+ICvCoMKgwqAgaWYgKElTX0VOQUJMRUQoQ09ORklHXzY0
QklUKSkgewo+Pj4+Pj4gKyNpZmRlZiBDT05GSUdfS0FTQU4KPj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oCB2bWNvcmVpbmZvX2FwcGVuZF9zdHIoIk5VTUJFUihLQVNBTl9TSEFET1dfU1RBUlQpPTB4JWx4
XG4iLCBLQVNBTl9TSEFET1dfU1RBUlQpOwo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHZtY29yZWlu
Zm9fYXBwZW5kX3N0cigiTlVNQkVSKEtBU0FOX1NIQURPV19FTkQpPTB4JWx4XG4iLCBLQVNBTl9T
SEFET1dfRU5EKTsKPj4+Pj4+ICsjZW5kaWYKPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB2bWNvcmVp
bmZvX2FwcGVuZF9zdHIoIk5VTUJFUihLRVJORUxfTElOS19BRERSKT0weCVseFxuIiwgS0VSTkVM
X0xJTktfQUREUik7Cj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgdm1jb3JlaW5mb19hcHBlbmRfc3Ry
KCJOVU1CRVIoQUREUkVTU19TUEFDRV9FTkQpPTB4JWx4XG4iLCBBRERSRVNTX1NQQUNFX0VORCk7
Cj4+Pj4+IFNlZW1zIHRoaXMgaXMgdGhlIGZpcnNyIEFSQ0ggd2hlcmUga2FzYW4gYW5kIGtlcm5l
bCBsaW5rL2JwZiBzcGFjZSBhcmUKPj4+Pj4gYWRkZWQgdG8gZHVtcCBhbmQgYW5hbHl6ZS4gSnVz
dCBjdXJpb3VzLCBoYXZlIHlvdSBnb3QgY29kZSBjaGFuZ2UgdG8KPj4+Pj4gbWFrZSB1c2Ugb2Yg
dGhlbSB0byBkbyBkdW1waW5nIGFuZCBhbmFseXplPwo+Pj4+IEtBU0FOX1NIQURPV19TVEFSVCBp
cyBub3QgdXNlZCwgS0VSTkVMX0xJTktfQUREUiBpcyB1c2VkIGluIHRoZSBjcmFzaCBwYXRjaCBz
ZXQ6Cj4+Pj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXJpc2N2
L2NvdmVyLzIwMjIwODEzMDMxNzUzLjMwOTc3MjAtMS14aWFudGluZy50aWFuQGxpbnV4LmFsaWJh
YmEuY29tLwo+Pj4gT2gsIEkgd291bGQgc2F5IHBsZWFzZSBuby4gU29tZXRpbWUgd2UgZ290IHRv
bnMgb2Ygb2JqZWN0aW9uIHdoZW4gYWRkaW5nIGFuCj4+PiBuZWNlc3Nhcnkgb25lLCB3ZSBkZWZp
bml0ZWx5IHNob3VsZCBub3QgYWRkIG9uZSBmb3IgcG9zc2libGUgZnV0dXJlCj4+PiB1c2UuCj4+
Pgo+Pj4gRm9yIHRoaXMga2luZCBvZiBuZXdseSBhZGRlZCBvbmUsIHdlIG5lZWQgZ2V0IGFjayBm
cm9tCj4+PiBtYWtlZHVtcGZpbGUvY3Jhc2ggdXRpbGl0eSBtYWludGFpbmVyIHNvIHRoYXQgd2Ug
a25vdyB0aGV5IGFyZSBuZWNlc3NhcnkKPj4+IHRvIGhhdmUuIEF0IGxlYXN0IHRoZXkgZG9uJ3Qg
b3Bwb3NlLgo+PiBIaSBLYXp1LCBMaSBKaWFuZwo+Pgo+PiBDb3VsZCB5b3UgaGVscCBjb21tZW50
IHdoZXRoZXIgd2UgbmVlZCBLQVNBTl9TSEFET1dfU1RBUlQgYW5kIEtFUk5FTF9MSU5LX0FERFIg
YXJlYSBleHBvcnQgZm9yIHZtY29yZSBmcm9tIGNyYXNoIHBvaW50IG9mIHZpZXfvvJ8KPj4KPj4g
SW4gbXkgY3Jhc2ggcGF0Y2ggc2V0LCBJIGRvbid0IHVzZSBLQVNBTl9TSEFET1dfU1RBUlQsCj4+
IEFuZCBvbmx5IGdldCB0aGUgdmFsdWUgb2YgS0VSTkVMX0xJTktfQUREUiwgbm90IHJlYWx5IHVz
ZSBpdC4KPj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXJpc2N2
L2NvdmVyLzIwMjIwODEzMDMxNzUzLjMwOTc3MjAtMS14aWFudGluZy50aWFuQGxpbnV4LmFsaWJh
YmEuY29tLwo+IEluIHlvdXIgY3Jhc2ggcGF0Y2ggc2V0LCBLRVJORUxfTElOS19BRERSIGlzIHVz
ZWQgaW4gVlRPUCgpIGFuZCBsb29rcwo+IG5lY2Vzc2FyeSB0byBtZS4KPgo+IFRoZSBvdGhlcnMg
KEtBU0FOX1NIQURPV19TVEFSVCwgS0FTQU5fU0hBRE9XX0VORCBhbmQgQUREUkVTU19TUEFDRV9F
TkQpCj4gYXJlIG5vdCBjdXJyZW50bHkgdXNlZC4gIEl0IG1heSBiZSBiZXR0ZXIgdG8gYWRkIHRo
ZW0gd2hlbiB0aGV5IGFyZQo+IHJlYWxseSB1c2VkLgoKSSBhbSB2ZXJ5IHNvcnJ5LCBJIG1pc3Nl
ZCBpdCAsIEtFUk5FTF9MSU5LX0FERFIgaXMgdXNlZCBpbmRlZWQuCgpLQVNBTl9TSEFET1dfU1RB
UlQgaXMgbm90IHVzZWQsIHNvIEkgZG9uJ3QgbmVlZCB0byBzZW5kIGNyYXNoIHBhdGNoIHNldCAK
YWdhaW4uIG9ubHkgbmVlZCB0byByZW1vdmUgS0FTQU5fU0hBRE9XX0VORCBpbiBrZXJuZWwgcGF0
Y2ggc2V0LgoKPgo+IFRoYW5rcywKPiBLYXp1Cj4KPj4gSWYgd2UgbmVlZCB0byByZW1vdmUgdGhl
IHR3byBhcmVhcywgSSB3aWxsIHJlc2VuZCB0aGUgY3Jhc2ggcGF0Y2ggc2V0IGFuZCBrZXJuZWwg
cGF0Y2ggc2V0Lgo+PiB0aGFua3MKPj4KPj4+PiBJIGFkZCBpdCBpbiBjYXNlIG9mIHVzaW5nIGlu
IGZ1cnR1cmUuCj4+Pj4KPj4+Pj4gVGhhbmtzCj4+Pj4+IEJhb3F1YW4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhl
Y0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8va2V4ZWMK
