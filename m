Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE79C433FE
	for <kexec@archiver.kernel.org>; Tue, 18 Oct 2022 09:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7l/ICNQn5/p42VXtmtbgR4UHd/Mqibv5EPaWe1D9kSk=; b=DdmO6nCPEA0k07
	m8fWPpqqrC/cwdTddnitosPfXeIWgsqviLXcnwf1PrFe4w3hdO6yWN/8EO4PvvKwPgYK9yUA/gglq
	2r1tfYP/53DKAeSzD1UfZxHtnNmOyM/tzmP4tnzvzt5PWUU4+VdEvPIJV2H3q/RSxrukemEStGjlX
	E1OvtDFMEQdN8r3Fj4h2E+jYsRttWiycgRX48joEvQ/rPjt0Qv/XohFUss4Uwi+NtbgYwz2QKK+bk
	NlPIU38f1qCq3qzfE7ARZsLd2Mmu5IKzJC2ndJSEjwe6WZx1taLVAmmE/zP4Hvkh7w8BDtzMBwYLx
	RgrEeptUx7fyezn+EJRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okiqh-004xjh-CC; Tue, 18 Oct 2022 09:25:23 +0000
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okiqd-004xeE-R5; Tue, 18 Oct 2022 09:25:22 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0VSURu2I_1666085111;
Received: from 30.221.96.155(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VSURu2I_1666085111)
          by smtp.aliyun-inc.com;
          Tue, 18 Oct 2022 17:25:13 +0800
Message-ID: <049ec19e-60c3-2854-5f5e-9850231108b4@linux.alibaba.com>
Date: Tue, 18 Oct 2022 17:25:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V3 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
To: Baoquan He <bhe@redhat.com>, Kazuhito Hagio <k-hagio-ab@nec.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 anup@brainfault.org, heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
 alexandre.ghiti@canonical.com, vgoyal@redhat.com, dyoung@redhat.com,
 corbet@lwn.net, Conor.Dooley@microchip.com, bagasdotme@gmail.com,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
 hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20221018081755.6214-1-xianting.tian@linux.alibaba.com>
 <20221018081755.6214-2-xianting.tian@linux.alibaba.com>
 <Y05tfxRenMs5d+bt@MiWiFi-R3L-srv>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <Y05tfxRenMs5d+bt@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_022520_063402_5123CE12 
X-CRM114-Status: GOOD (  17.71  )
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

CuWcqCAyMDIyLzEwLzE4IOS4i+WNiDU6MTAsIEJhb3F1YW4gSGUg5YaZ6YGTOgo+IE9uIDEwLzE4
LzIyIGF0IDA0OjE3cG0sIFhpYW50aW5nIFRpYW4gd3JvdGU6Cj4+IEFkZCBhcmNoX2NyYXNoX3Nh
dmVfdm1jb3JlaW5mbygpLCB3aGljaCBleHBvcnRzIFZNIGxheW91dChNT0RVTEVTLCBWTUFMTE9D
LAo+PiBWTUVNTUFQIGFuZCBLRVJORUxfTElOS19BRERSIHJhbmdlcyksIHZhIGJpdHMgYW5kIHJh
bSBiYXNlIGZvciB2bWNvcmUuCj4+Cj4+IERlZmF1bHQgcGFnZXRhYmxlIGxldmVscyBhbmQgUEFH
RV9PRkZTRVQgYXJlbid0IHNhbWUgZm9yIGRpZmZlcmVudCBrZXJuZWwKPj4gdmVyc2lvbiBhcyBi
ZWxvdy4gRm9yIHBhZ2V0YWJsZSBsZXZlbHMsIGl0IHNldHMgc3Y1NyBieSBkZWZhdWx0IGFuZCBm
YWxscwo+PiBiYWNrIHRvIHNldHRpbmcgc3Y0OCBhdCBib290IHRpbWUgaWYgc3Y1NyBpcyBub3Qg
c3VwcG9ydGVkIGJ5IHRoZSBoYXJkd2FyZS4KPj4KPj4gRm9yIHJhbSBiYXNlLCB0aGUgZGVmYXVs
dCB2YWx1ZSBpcyAweDgwMjAwMDAwIGZvciBxZW11IHJpc2N2NjQgZW52IGFuZCwKPj4gZm9yIGV4
YW1wbGUsIGlzIDB4MjAwMDAwIG9uIHRoZSBYdWFuVGllIDkxMCBDUFUuCj4+Cj4+ICAgKiBMaW51
eCBLZXJuZWwgNS4xOCB+Cj4+ICAgKiAgICAgIFBHVEFCTEVfTEVWRUxTID0gNQo+PiAgICogICAg
ICBQQUdFX09GRlNFVCA9IDB4ZmY2MDAwMDAwMDAwMDAwMAo+PiAgICogTGludXggS2VybmVsIDUu
MTcgfgo+PiAgICogICAgICBQR1RBQkxFX0xFVkVMUyA9IDQKPj4gICAqICAgICAgUEFHRV9PRkZT
RVQgPSAweGZmZmZhZjgwMDAwMDAwMDAKPj4gICAqIExpbnV4IEtlcm5lbCA0LjE5IH4KPj4gICAq
ICAgICAgUEdUQUJMRV9MRVZFTFMgPSAzCj4+ICAgKiAgICAgIFBBR0VfT0ZGU0VUID0gMHhmZmZm
ZmZlMDAwMDAwMDAwCj4+Cj4+IFNpbmNlIHRoZXNlIGNvbmZpZ3VyYXRpb25zIGNoYW5nZSBmcm9t
IHRpbWUgdG8gdGltZSBhbmQgdmVyc2lvbiB0byB2ZXJzaW9uLAo+PiBpdCBpcyBwcmVmZXJhYmxl
IHRvIGV4cG9ydCB0aGVtIHZpYSB2bWNvcmVpbmZvIHRoYW4gdG8gY2hhbmdlIHRoZSBjcmFzaCdz
Cj4+IGNvZGUgZnJlcXVlbnRseSwgaXQgY2FuIHNpbXBsaWZ5IHRoZSBkZXZlbG9wbWVudCBvZiBj
cmFzaCB0b29sLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBYaWFudGluZyBUaWFuIDx4aWFudGluZy50
aWFuQGxpbnV4LmFsaWJhYmEuY29tPgo+PiAtLS0KPj4gICBhcmNoL3Jpc2N2L2tlcm5lbC9NYWtl
ZmlsZSAgICAgfCAgMSArCj4+ICAgYXJjaC9yaXNjdi9rZXJuZWwvY3Jhc2hfY29yZS5jIHwgMjkg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4gICAyIGZpbGVzIGNoYW5nZWQsIDMwIGlu
c2VydGlvbnMoKykKPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9rZXJuZWwvY3Jh
c2hfY29yZS5jCj4+Cj4+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2tlcm5lbC9NYWtlZmlsZSBi
L2FyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxlCj4+IGluZGV4IGRiNmU0YjEyOTRiYS4uNGNmMzAz
YTc3OWFiIDEwMDY0NAo+PiAtLS0gYS9hcmNoL3Jpc2N2L2tlcm5lbC9NYWtlZmlsZQo+PiArKysg
Yi9hcmNoL3Jpc2N2L2tlcm5lbC9NYWtlZmlsZQo+PiBAQCAtODEsNiArODEsNyBAQCBvYmotJChD
T05GSUdfS0dEQikJCSs9IGtnZGIubwo+PiAgIG9iai0kKENPTkZJR19LRVhFQ19DT1JFKQkrPSBr
ZXhlY19yZWxvY2F0ZS5vIGNyYXNoX3NhdmVfcmVncy5vIG1hY2hpbmVfa2V4ZWMubwo+PiAgIG9i
ai0kKENPTkZJR19LRVhFQ19GSUxFKQkrPSBlbGZfa2V4ZWMubyBtYWNoaW5lX2tleGVjX2ZpbGUu
bwo+PiAgIG9iai0kKENPTkZJR19DUkFTSF9EVU1QKQkrPSBjcmFzaF9kdW1wLm8KPj4gK29iai0k
KENPTkZJR19DUkFTSF9DT1JFKQkrPSBjcmFzaF9jb3JlLm8KPj4gICAKPj4gICBvYmotJChDT05G
SUdfSlVNUF9MQUJFTCkJKz0ganVtcF9sYWJlbC5vCj4+ICAgCj4+IGRpZmYgLS1naXQgYS9hcmNo
L3Jpc2N2L2tlcm5lbC9jcmFzaF9jb3JlLmMgYi9hcmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9jb3Jl
LmMKPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPj4gaW5kZXggMDAwMDAwMDAwMDAwLi44ZDdmNWZm
MTA4ZGEKPj4gLS0tIC9kZXYvbnVsbAo+PiArKysgYi9hcmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9j
b3JlLmMKPj4gQEAgLTAsMCArMSwyOSBAQAo+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAtb25seQo+PiArCj4+ICsjaW5jbHVkZSA8bGludXgvY3Jhc2hfY29yZS5oPgo+PiAr
I2luY2x1ZGUgPGxpbnV4L3BhZ2VtYXAuaD4KPj4gKwo+PiArdm9pZCBhcmNoX2NyYXNoX3NhdmVf
dm1jb3JlaW5mbyh2b2lkKQo+PiArewo+PiArCVZNQ09SRUlORk9fTlVNQkVSKFZBX0JJVFMpOwo+
PiArCVZNQ09SRUlORk9fTlVNQkVSKHBoeXNfcmFtX2Jhc2UpOwo+PiArCj4+ICsJdm1jb3JlaW5m
b19hcHBlbmRfc3RyKCJOVU1CRVIoUEFHRV9PRkZTRVQpPTB4JWx4XG4iLCBQQUdFX09GRlNFVCk7
Cj4+ICsJdm1jb3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIoVk1BTExPQ19TVEFSVCk9MHglbHhc
biIsIFZNQUxMT0NfU1RBUlQpOwo+PiArCXZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVNQkVSKFZN
QUxMT0NfRU5EKT0weCVseFxuIiwgVk1BTExPQ19FTkQpOwo+PiArCXZtY29yZWluZm9fYXBwZW5k
X3N0cigiTlVNQkVSKFZNRU1NQVBfU1RBUlQpPTB4JWx4XG4iLCBWTUVNTUFQX1NUQVJUKTsKPj4g
Kwl2bWNvcmVpbmZvX2FwcGVuZF9zdHIoIk5VTUJFUihWTUVNTUFQX0VORCk9MHglbHhcbiIsIFZN
RU1NQVBfRU5EKTsKPj4gKyNpZmRlZiBDT05GSUdfNjRCSVQKPj4gKwl2bWNvcmVpbmZvX2FwcGVu
ZF9zdHIoIk5VTUJFUihNT0RVTEVTX1ZBRERSKT0weCVseFxuIiwgTU9EVUxFU19WQUREUik7Cj4+
ICsJdm1jb3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIoTU9EVUxFU19FTkQpPTB4JWx4XG4iLCBN
T0RVTEVTX0VORCk7Cj4+ICsjZW5kaWYKPj4gKwo+PiArCWlmIChJU19FTkFCTEVEKENPTkZJR182
NEJJVCkpIHsKPj4gKyNpZmRlZiBDT05GSUdfS0FTQU4KPj4gKwkJdm1jb3JlaW5mb19hcHBlbmRf
c3RyKCJOVU1CRVIoS0FTQU5fU0hBRE9XX1NUQVJUKT0weCVseFxuIiwgS0FTQU5fU0hBRE9XX1NU
QVJUKTsKPj4gKwkJdm1jb3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIoS0FTQU5fU0hBRE9XX0VO
RCk9MHglbHhcbiIsIEtBU0FOX1NIQURPV19FTkQpOwo+PiArI2VuZGlmCj4+ICsJCXZtY29yZWlu
Zm9fYXBwZW5kX3N0cigiTlVNQkVSKEtFUk5FTF9MSU5LX0FERFIpPTB4JWx4XG4iLCBLRVJORUxf
TElOS19BRERSKTsKPj4gKwkJdm1jb3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIoQUREUkVTU19T
UEFDRV9FTkQpPTB4JWx4XG4iLCBBRERSRVNTX1NQQUNFX0VORCk7Cj4gU2VlbXMgdGhpcyBpcyB0
aGUgZmlyc3IgQVJDSCB3aGVyZSBrYXNhbiBhbmQga2VybmVsIGxpbmsvYnBmIHNwYWNlIGFyZQo+
IGFkZGVkIHRvIGR1bXAgYW5kIGFuYWx5emUuIEp1c3QgY3VyaW91cywgaGF2ZSB5b3UgZ290IGNv
ZGUgY2hhbmdlIHRvCj4gbWFrZSB1c2Ugb2YgdGhlbSB0byBkbyBkdW1waW5nIGFuZCBhbmFseXpl
PwoKS0FTQU5fU0hBRE9XX1NUQVJUIGlzIG5vdCB1c2VkLCBLRVJORUxfTElOS19BRERSIGlzIHVz
ZWQgaW4gdGhlIGNyYXNoIHBhdGNoIHNldDoKaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9w
cm9qZWN0L2xpbnV4LXJpc2N2L2NvdmVyLzIwMjIwODEzMDMxNzUzLjMwOTc3MjAtMS14aWFudGlu
Zy50aWFuQGxpbnV4LmFsaWJhYmEuY29tLwoKSSBhZGQgaXQgaW4gY2FzZSBvZiB1c2luZyBpbiBm
dXJ0dXJlLgoKPgo+IFRoYW5rcwo+IEJhb3F1YW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4
ZWMK
