Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCC9C433FE
	for <kexec@archiver.kernel.org>; Wed, 19 Oct 2022 01:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FqlRXqU8Upc5H4/SVF1h1aqKn8QwYIZcBhnVXOdc7LY=; b=seaf3JJYX9XVzy
	iRbMWczHkgOEyLpGH1aETc2QfYNzwCeYm5qZFVUkz+EyepaUoeFHb1t0d0vjCfgep4DExuunnCBbp
	ULeeGSJ7iFDLfiMc6Yv1i0oSC2TlnbgGagzxfbFEb2Zj0YoyWRCoObSaozRWii00qo1XQKdOu5Tjv
	8gUE5sw5g4lbhJDaase7rozgXNWhJWNIhzgb3GmBjUZJSjknX/Xwbfo63Reuk3TTKCQ6Ngs9/2q5m
	XapuxgU5Bub6xlBwc3Wxo2FKt7dkJN5bqSzsqPY+tN+uB/+b3stf9Im03uJIILyqbksEhy9AqmOmc
	TXL4hCsa/K3gDhzlPSig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okyE7-00DKxK-Ux; Wed, 19 Oct 2022 01:50:35 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okyE3-00DKkK-M3; Wed, 19 Oct 2022 01:50:34 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VSYFzlh_1666144217;
Received: from 30.221.97.167(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VSYFzlh_1666144217)
          by smtp.aliyun-inc.com;
          Wed, 19 Oct 2022 09:50:19 +0800
Message-ID: <a66a5b16-5f1f-3d80-3cdc-4b82d38d604f@linux.alibaba.com>
Date: Wed, 19 Oct 2022 09:50:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V3 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
To: Baoquan He <bhe@redhat.com>, Kazuhito Hagio <k-hagio-ab@nec.com>,
 lijiang <lijiang@redhat.com>
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
 <049ec19e-60c3-2854-5f5e-9850231108b4@linux.alibaba.com>
 <Y05540td7lLz+0BY@MiWiFi-R3L-srv>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <Y05540td7lLz+0BY@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_185031_922930_49CF8D1F 
X-CRM114-Status: GOOD (  17.66  )
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

CuWcqCAyMDIyLzEwLzE4IOS4i+WNiDY6MDMsIEJhb3F1YW4gSGUg5YaZ6YGTOgo+IE9uIDEwLzE4
LzIyIGF0IDA1OjI1cG0sIFhpYW50aW5nIFRpYW4gd3JvdGU6Cj4+IOWcqCAyMDIyLzEwLzE4IOS4
i+WNiDU6MTAsIEJhb3F1YW4gSGUg5YaZ6YGTOgo+Pj4gT24gMTAvMTgvMjIgYXQgMDQ6MTdwbSwg
WGlhbnRpbmcgVGlhbiB3cm90ZToKPj4+PiBBZGQgYXJjaF9jcmFzaF9zYXZlX3ZtY29yZWluZm8o
KSwgd2hpY2ggZXhwb3J0cyBWTSBsYXlvdXQoTU9EVUxFUywgVk1BTExPQywKPj4+PiBWTUVNTUFQ
IGFuZCBLRVJORUxfTElOS19BRERSIHJhbmdlcyksIHZhIGJpdHMgYW5kIHJhbSBiYXNlIGZvciB2
bWNvcmUuCj4+Pj4KPj4+PiBEZWZhdWx0IHBhZ2V0YWJsZSBsZXZlbHMgYW5kIFBBR0VfT0ZGU0VU
IGFyZW4ndCBzYW1lIGZvciBkaWZmZXJlbnQga2VybmVsCj4+Pj4gdmVyc2lvbiBhcyBiZWxvdy4g
Rm9yIHBhZ2V0YWJsZSBsZXZlbHMsIGl0IHNldHMgc3Y1NyBieSBkZWZhdWx0IGFuZCBmYWxscwo+
Pj4+IGJhY2sgdG8gc2V0dGluZyBzdjQ4IGF0IGJvb3QgdGltZSBpZiBzdjU3IGlzIG5vdCBzdXBw
b3J0ZWQgYnkgdGhlIGhhcmR3YXJlLgo+Pj4+Cj4+Pj4gRm9yIHJhbSBiYXNlLCB0aGUgZGVmYXVs
dCB2YWx1ZSBpcyAweDgwMjAwMDAwIGZvciBxZW11IHJpc2N2NjQgZW52IGFuZCwKPj4+PiBmb3Ig
ZXhhbXBsZSwgaXMgMHgyMDAwMDAgb24gdGhlIFh1YW5UaWUgOTEwIENQVS4KPj4+Pgo+Pj4+ICAg
ICogTGludXggS2VybmVsIDUuMTggfgo+Pj4+ICAgICogICAgICBQR1RBQkxFX0xFVkVMUyA9IDUK
Pj4+PiAgICAqICAgICAgUEFHRV9PRkZTRVQgPSAweGZmNjAwMDAwMDAwMDAwMDAKPj4+PiAgICAq
IExpbnV4IEtlcm5lbCA1LjE3IH4KPj4+PiAgICAqICAgICAgUEdUQUJMRV9MRVZFTFMgPSA0Cj4+
Pj4gICAgKiAgICAgIFBBR0VfT0ZGU0VUID0gMHhmZmZmYWY4MDAwMDAwMDAwCj4+Pj4gICAgKiBM
aW51eCBLZXJuZWwgNC4xOSB+Cj4+Pj4gICAgKiAgICAgIFBHVEFCTEVfTEVWRUxTID0gMwo+Pj4+
ICAgICogICAgICBQQUdFX09GRlNFVCA9IDB4ZmZmZmZmZTAwMDAwMDAwMAo+Pj4+Cj4+Pj4gU2lu
Y2UgdGhlc2UgY29uZmlndXJhdGlvbnMgY2hhbmdlIGZyb20gdGltZSB0byB0aW1lIGFuZCB2ZXJz
aW9uIHRvIHZlcnNpb24sCj4+Pj4gaXQgaXMgcHJlZmVyYWJsZSB0byBleHBvcnQgdGhlbSB2aWEg
dm1jb3JlaW5mbyB0aGFuIHRvIGNoYW5nZSB0aGUgY3Jhc2gncwo+Pj4+IGNvZGUgZnJlcXVlbnRs
eSwgaXQgY2FuIHNpbXBsaWZ5IHRoZSBkZXZlbG9wbWVudCBvZiBjcmFzaCB0b29sLgo+Pj4+Cj4+
Pj4gU2lnbmVkLW9mZi1ieTogWGlhbnRpbmcgVGlhbiA8eGlhbnRpbmcudGlhbkBsaW51eC5hbGli
YWJhLmNvbT4KPj4+PiAtLS0KPj4+PiAgICBhcmNoL3Jpc2N2L2tlcm5lbC9NYWtlZmlsZSAgICAg
fCAgMSArCj4+Pj4gICAgYXJjaC9yaXNjdi9rZXJuZWwvY3Jhc2hfY29yZS5jIHwgMjkgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKPj4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDMwIGluc2Vy
dGlvbnMoKykKPj4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9rZXJuZWwvY3Jh
c2hfY29yZS5jCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZp
bGUgYi9hcmNoL3Jpc2N2L2tlcm5lbC9NYWtlZmlsZQo+Pj4+IGluZGV4IGRiNmU0YjEyOTRiYS4u
NGNmMzAzYTc3OWFiIDEwMDY0NAo+Pj4+IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxl
Cj4+Pj4gKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUKPj4+PiBAQCAtODEsNiArODEs
NyBAQCBvYmotJChDT05GSUdfS0dEQikJCSs9IGtnZGIubwo+Pj4+ICAgIG9iai0kKENPTkZJR19L
RVhFQ19DT1JFKQkrPSBrZXhlY19yZWxvY2F0ZS5vIGNyYXNoX3NhdmVfcmVncy5vIG1hY2hpbmVf
a2V4ZWMubwo+Pj4+ICAgIG9iai0kKENPTkZJR19LRVhFQ19GSUxFKQkrPSBlbGZfa2V4ZWMubyBt
YWNoaW5lX2tleGVjX2ZpbGUubwo+Pj4+ICAgIG9iai0kKENPTkZJR19DUkFTSF9EVU1QKQkrPSBj
cmFzaF9kdW1wLm8KPj4+PiArb2JqLSQoQ09ORklHX0NSQVNIX0NPUkUpCSs9IGNyYXNoX2NvcmUu
bwo+Pj4+ICAgIG9iai0kKENPTkZJR19KVU1QX0xBQkVMKQkrPSBqdW1wX2xhYmVsLm8KPj4+PiBk
aWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvY3Jhc2hfY29yZS5jIGIvYXJjaC9yaXNjdi9r
ZXJuZWwvY3Jhc2hfY29yZS5jCj4+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPj4+PiBpbmRleCAw
MDAwMDAwMDAwMDAuLjhkN2Y1ZmYxMDhkYQo+Pj4+IC0tLSAvZGV2L251bGwKPj4+PiArKysgYi9h
cmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9jb3JlLmMKPj4+PiBAQCAtMCwwICsxLDI5IEBACj4+Pj4g
Ky8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkKPj4+PiArCj4+Pj4gKyNp
bmNsdWRlIDxsaW51eC9jcmFzaF9jb3JlLmg+Cj4+Pj4gKyNpbmNsdWRlIDxsaW51eC9wYWdlbWFw
Lmg+Cj4+Pj4gKwo+Pj4+ICt2b2lkIGFyY2hfY3Jhc2hfc2F2ZV92bWNvcmVpbmZvKHZvaWQpCj4+
Pj4gK3sKPj4+PiArCVZNQ09SRUlORk9fTlVNQkVSKFZBX0JJVFMpOwo+Pj4+ICsJVk1DT1JFSU5G
T19OVU1CRVIocGh5c19yYW1fYmFzZSk7Cj4+Pj4gKwo+Pj4+ICsJdm1jb3JlaW5mb19hcHBlbmRf
c3RyKCJOVU1CRVIoUEFHRV9PRkZTRVQpPTB4JWx4XG4iLCBQQUdFX09GRlNFVCk7Cj4+Pj4gKwl2
bWNvcmVpbmZvX2FwcGVuZF9zdHIoIk5VTUJFUihWTUFMTE9DX1NUQVJUKT0weCVseFxuIiwgVk1B
TExPQ19TVEFSVCk7Cj4+Pj4gKwl2bWNvcmVpbmZvX2FwcGVuZF9zdHIoIk5VTUJFUihWTUFMTE9D
X0VORCk9MHglbHhcbiIsIFZNQUxMT0NfRU5EKTsKPj4+PiArCXZtY29yZWluZm9fYXBwZW5kX3N0
cigiTlVNQkVSKFZNRU1NQVBfU1RBUlQpPTB4JWx4XG4iLCBWTUVNTUFQX1NUQVJUKTsKPj4+PiAr
CXZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVNQkVSKFZNRU1NQVBfRU5EKT0weCVseFxuIiwgVk1F
TU1BUF9FTkQpOwo+Pj4+ICsjaWZkZWYgQ09ORklHXzY0QklUCj4+Pj4gKwl2bWNvcmVpbmZvX2Fw
cGVuZF9zdHIoIk5VTUJFUihNT0RVTEVTX1ZBRERSKT0weCVseFxuIiwgTU9EVUxFU19WQUREUik7
Cj4+Pj4gKwl2bWNvcmVpbmZvX2FwcGVuZF9zdHIoIk5VTUJFUihNT0RVTEVTX0VORCk9MHglbHhc
biIsIE1PRFVMRVNfRU5EKTsKPj4+PiArI2VuZGlmCj4+Pj4gKwo+Pj4+ICsJaWYgKElTX0VOQUJM
RUQoQ09ORklHXzY0QklUKSkgewo+Pj4+ICsjaWZkZWYgQ09ORklHX0tBU0FOCj4+Pj4gKwkJdm1j
b3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIoS0FTQU5fU0hBRE9XX1NUQVJUKT0weCVseFxuIiwg
S0FTQU5fU0hBRE9XX1NUQVJUKTsKPj4+PiArCQl2bWNvcmVpbmZvX2FwcGVuZF9zdHIoIk5VTUJF
UihLQVNBTl9TSEFET1dfRU5EKT0weCVseFxuIiwgS0FTQU5fU0hBRE9XX0VORCk7Cj4+Pj4gKyNl
bmRpZgo+Pj4+ICsJCXZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVNQkVSKEtFUk5FTF9MSU5LX0FE
RFIpPTB4JWx4XG4iLCBLRVJORUxfTElOS19BRERSKTsKPj4+PiArCQl2bWNvcmVpbmZvX2FwcGVu
ZF9zdHIoIk5VTUJFUihBRERSRVNTX1NQQUNFX0VORCk9MHglbHhcbiIsIEFERFJFU1NfU1BBQ0Vf
RU5EKTsKPj4+IFNlZW1zIHRoaXMgaXMgdGhlIGZpcnNyIEFSQ0ggd2hlcmUga2FzYW4gYW5kIGtl
cm5lbCBsaW5rL2JwZiBzcGFjZSBhcmUKPj4+IGFkZGVkIHRvIGR1bXAgYW5kIGFuYWx5emUuIEp1
c3QgY3VyaW91cywgaGF2ZSB5b3UgZ290IGNvZGUgY2hhbmdlIHRvCj4+PiBtYWtlIHVzZSBvZiB0
aGVtIHRvIGRvIGR1bXBpbmcgYW5kIGFuYWx5emU/Cj4+IEtBU0FOX1NIQURPV19TVEFSVCBpcyBu
b3QgdXNlZCwgS0VSTkVMX0xJTktfQUREUiBpcyB1c2VkIGluIHRoZSBjcmFzaCBwYXRjaCBzZXQ6
Cj4+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1yaXNjdi9jb3Zl
ci8yMDIyMDgxMzAzMTc1My4zMDk3NzIwLTEteGlhbnRpbmcudGlhbkBsaW51eC5hbGliYWJhLmNv
bS8KPiBPaCwgSSB3b3VsZCBzYXkgcGxlYXNlIG5vLiBTb21ldGltZSB3ZSBnb3QgdG9ucyBvZiBv
YmplY3Rpb24gd2hlbiBhZGRpbmcgYW4KPiBuZWNlc3Nhcnkgb25lLCB3ZSBkZWZpbml0ZWx5IHNo
b3VsZCBub3QgYWRkIG9uZSBmb3IgcG9zc2libGUgZnV0dXJlCj4gdXNlLgo+Cj4gRm9yIHRoaXMg
a2luZCBvZiBuZXdseSBhZGRlZCBvbmUsIHdlIG5lZWQgZ2V0IGFjayBmcm9tCj4gbWFrZWR1bXBm
aWxlL2NyYXNoIHV0aWxpdHkgbWFpbnRhaW5lciBzbyB0aGF0IHdlIGtub3cgdGhleSBhcmUgbmVj
ZXNzYXJ5Cj4gdG8gaGF2ZS4gQXQgbGVhc3QgdGhleSBkb24ndCBvcHBvc2UuCgpIaSBLYXp1LCBM
aSBKaWFuZwoKQ291bGQgeW91IGhlbHAgY29tbWVudCB3aGV0aGVyIHdlIG5lZWQgS0FTQU5fU0hB
RE9XX1NUQVJUIGFuZCAKS0VSTkVMX0xJTktfQUREUiBhcmVhIGV4cG9ydCBmb3Igdm1jb3JlIGZy
b20gY3Jhc2ggcG9pbnQgb2Ygdmlld++8nwoKSW4gbXkgY3Jhc2ggcGF0Y2ggc2V0LCBJIGRvbid0
IHVzZSBLQVNBTl9TSEFET1dfU1RBUlQsCkFuZCBvbmx5IGdldCB0aGUgdmFsdWUgb2YgS0VSTkVM
X0xJTktfQUREUiwgbm90IHJlYWx5IHVzZSBpdC4KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9y
Zy9wcm9qZWN0L2xpbnV4LXJpc2N2L2NvdmVyLzIwMjIwODEzMDMxNzUzLjMwOTc3MjAtMS14aWFu
dGluZy50aWFuQGxpbnV4LmFsaWJhYmEuY29tLwoKSWYgd2UgbmVlZCB0byByZW1vdmUgdGhlIHR3
byBhcmVhcywgSSB3aWxsIHJlc2VuZCB0aGUgY3Jhc2ggcGF0Y2ggc2V0IGFuZCBrZXJuZWwgcGF0
Y2ggc2V0Lgp0aGFua3MKCj4KPj4gSSBhZGQgaXQgaW4gY2FzZSBvZiB1c2luZyBpbiBmdXJ0dXJl
Lgo+Pgo+Pj4gVGhhbmtzCj4+PiBCYW9xdWFuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVj
Cg==
