Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029C4C433EF
	for <kexec@archiver.kernel.org>; Tue, 26 Jul 2022 09:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	Cc:To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fPgovIQzTfAQL60AK5fA0Bv9E3hbUknEEbVUv5omIx4=; b=ExKQkb3lEh4NYaxJrNzJLX/QgR
	kqJT+Rgo/aCoWeYGTt8vg5fFUIw6O7X/QgeMMxXpVw5NXbbjXpMEbELiDK/yAT5u/N9+pzGoPLRJ5
	anM2ttn3+/TalABRMoDVDsa4i4q1ijJz1iV4ERZXaL4VhCsvHorlqTCGu9OlWib2IvXNwXIzFpfXx
	VwRqn0wTMKxy3nTpn3Bgz/kM3hTqRz7zry+tyuDz4jEjtt90Xn0DJNH5JSoP1FuYP8mgLM5n5SuI+
	TxUNMypiNoa3FaJ38cvXmaQnDmXiVMIwjlEypC+2NCVDDNr1mZSmsrRgCRfT5b0/KvHEX/W/wwV++
	TAp6q+Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGGrz-00BPUR-2E; Tue, 26 Jul 2022 09:28:51 +0000
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGGrs-00BPF6-Gt; Tue, 26 Jul 2022 09:28:47 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VKUwbzM_1658827715;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VKUwbzM_1658827715)
          by smtp.aliyun-inc.com;
          Tue, 26 Jul 2022 17:28:37 +0800
Subject: Re: [RESEND PATCH V2 0/5] Fixups to work with crash tool
From: Xianting Tian <xianting.tian@linux.alibaba.com>
To: Conor.Dooley@microchip.com
Cc: alexandre.ghiti@canonical.com, heiko@sntech.de, palmer@dabbelt.com,
 mick@ics.forth.gr, guoren@kernel.org, kexec@lists.infradead.org,
 bhe@redhat.com, linux-doc@vger.kernel.org, vgoyal@redhat.com,
 linux-riscv@lists.infradead.org, dyoung@redhat.com,
 linux-kernel@vger.kernel.org, crash-utility@redhat.com,
 huanyi.xj@alibaba-inc.com, heinrich.schuchardt@canonical.com,
 anup@brainfault.org, corbet@lwn.net, k-hagio-ab@nec.com,
 hschauhan@nulltrace.org, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
References: <20220725014539.1037627-1-xianting.tian@linux.alibaba.com>
 <51c97da7-422f-1b5b-03d3-dc36c9132c2a@microchip.com>
 <7a395f64-8ec7-e07f-e763-afc1f2611c75@linux.alibaba.com>
 <2301681f-361d-b85b-e255-3bf449ceeaa9@microchip.com>
 <cf00c1f6-b043-a11e-f7a5-bed1e829cb73@linux.alibaba.com>
Message-ID: <6320e6dd-ebd9-3575-a85f-c3a2f92e9f54@linux.alibaba.com>
Date: Tue, 26 Jul 2022 17:28:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cf00c1f6-b043-a11e-f7a5-bed1e829cb73@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220726_022844_769368_9B9738E3 
X-CRM114-Status: GOOD (  10.41  )
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

CuWcqCAyMDIyLzcvMjYg5LiL5Y2INDoxNiwgWGlhbnRpbmcgVGlhbiDlhpnpgZM6Cj4KPiDlnKgg
MjAyMi83LzI2IOS4i+WNiDQ6MDEsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIOWGmemBkzoK
Pj4gT24gMjYvMDcvMjAyMiAwODo1NCwgdGlhbnhpYW50aW5nIHdyb3RlOgo+Pj4g5ZyoIDIwMjIv
Ny8yNiDkuIrljYgxOjEzLCBDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSDlhpnpgZM6Cj4+Pj4g
VGhhdCBzYWlkLCB0aGlzIGRvZXMgbm90IGFwcGx5IHRvIHJpc2N2L2Zvci1uZXh0Ogo+Pj4+IGI0
IHNoYXphbSAyMDIyMDcyNTAxNDUzOS4xMDM3NjI3LTEteGlhbnRpbmcudGlhbkBsaW51eC5hbGli
YWJhLmNvbQo+Pj4+IEdyYWJiaW5nIHRocmVhZCBmcm9tIAo+Pj4+IGxvcmUua2VybmVsLm9yZy9h
bGwvMjAyMjA3MjUwMTQ1MzkuMTAzNzYyNy0xLXhpYW50aW5nLnRpYW4lNDBsaW51eC5hbGliYWJh
LmNvbS90Lm1ib3guZ3oKPj4+PiBDaGVja2luZyBmb3IgbmV3ZXIgcmV2aXNpb25zIG9uIGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC8KPj4+PiBBbmFseXppbmcgNiBtZXNzYWdlcyBpbiB0aGUg
dGhyZWFkCj4+Pj4gQ2hlY2tpbmcgYXR0ZXN0YXRpb24gb24gYWxsIG1lc3NhZ2VzLCBtYXkgdGFr
ZSBhIG1vbWVudC4uLgo+Pj4+IC0tLQo+Pj4+IMKgwqDCoCBbUEFUQ0ggdjIgMS81XSBSSVNDLVY6
IHVzZSBfX3NtcF9wcm9jZXNzb3JfaWQoKSBpbnN0ZWFkIG9mIAo+Pj4+IHNtcF9wcm9jZXNzb3Jf
aWQoKQo+Pj4+IMKgwqDCoCBbUEFUQ0ggdjIgMi81XSBSSVNDLVY6IEFkZCBhcmNoX2NyYXNoX3Nh
dmVfdm1jb3JlaW5mbyBzdXBwb3J0Cj4+Pj4gwqDCoMKgIFtQQVRDSCB2MiAzLzVdIHJpc2N2OiBB
ZGQgbW9kdWxlcyB0byB2aXJ0dWFsIGtlcm5lbCBtZW1vcnkgCj4+Pj4gbGF5b3V0IGR1bXAKPj4+
PiDCoMKgwqAgW1BBVENIIHYyIDQvNV0gUklTQy1WOiBGaXh1cCBnZXR0aW5nIGNvcnJlY3QgY3Vy
cmVudCBwYwo+Pj4+IMKgwqDCoCBbUEFUQ0ggdjIgNS81XSByaXNjdjogY3Jhc2hfY29yZTogRXhw
b3J0IGtlcm5lbCB2bSBsYXlvdXQsIAo+Pj4+IHBoeXNfcmFtX2Jhc2UKPj4+PiAtLS0KPj4+PiBU
b3RhbCBwYXRjaGVzOiA1Cj4+Pj4gLS0tCj4+Pj4gQXBwbHlpbmc6IFJJU0MtVjogdXNlIF9fc21w
X3Byb2Nlc3Nvcl9pZCgpIGluc3RlYWQgb2YgCj4+Pj4gc21wX3Byb2Nlc3Nvcl9pZCgpCj4+Pj4g
QXBwbHlpbmc6IFJJU0MtVjogQWRkIGFyY2hfY3Jhc2hfc2F2ZV92bWNvcmVpbmZvIHN1cHBvcnQK
Pj4+PiBQYXRjaCBmYWlsZWQgYXQgMDAwMiBSSVNDLVY6IEFkZCBhcmNoX2NyYXNoX3NhdmVfdm1j
b3JlaW5mbyBzdXBwb3J0Cj4+PiBwYXRjaCAyIGFwcGx5IGlzIE9LIGZvciBtZSwgSSBkb24ndCBr
bm93IHdoeSB5b3UgZmFpbGVkIDooCj4+PiBEbyB5b3UgaGF2ZSBtb3JlIGRldGFscyBmb3IgdGhp
cz8KPj4+Cj4+IFdoYXQgZGlkIHlvdSBhcHBseSBpdCB0bz8gSXQgZG9lcyBub3QgYXBwbHkgZm9y
IG1lIHRvIHJpc2N2L2Zvci1uZXh0Ogo+PiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC9yaXNjdi9saW51eC5naXQvbG9nLz9oPWZvci1uZXh0IAo+Pgo+Cj4g
VGhpcyA1IHBhdGNoZXMgYXJlIGJhc2VkIG9uIHRoZSBtYXN0ZXIgYnJhbmNoIG9mIGJlbG93IGdp
dDoKPgo+IGh0dHBzOi8va2VybmVsLmdvb2dsZXNvdXJjZS5jb20vcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdCAKPgo+Cj4gImdpdCBhbSAwMDAyLVJJU0MtVi1BZGQt
YXJjaF9jcmFzaF9zYXZlX3ZtY29yZWluZm8tc3VwcG9ydC5wYXRjaCIgdG8gCj4gdGhpcyBnaXQg
aXMgb2sgZm9yIG1lLgo+Cj4gQWxsIGlzIGNvcnJlY3Q/CgpJIGZpZ3VyZWQgb3V0IHRoZSByZWFz
b24sIHRoZXJlIGlzIG9uZSBkaWZmZXJlbmNlIGluIAphcmNoL3Jpc2N2L2tlcm5lbC9NYWtlZmls
ZSBiZXR3ZWVuIHJpc2N2L2Zvci1uZXh0IGFuZCB0b3J2YWxkcy9saW51eC4KCkZvciByaXNjdi9m
b3ItbmV4dCwgaW4gbGluZSA4MSBvZiBhcmNoL3Jpc2N2L2tlcm5lbC9NYWtlZmlsZSwgaXQgaXM6
CgogwqDCoMKgIG9iai0kKENPTkZJR19LRVhFQynCoMKgwqAgwqDCoMKgICs9IGtleGVjX3JlbG9j
YXRlLm8gY3Jhc2hfc2F2ZV9yZWdzLm8gCm1hY2hpbmVfa2V4ZWMubwoKQnV0IGZvciB0b3J2YWxk
cy9saW51eCwgaW4gbGluZSA4MSBvZiBhcmNoL3Jpc2N2L2tlcm5lbC9NYWtlZmlsZSwgaXQgaXM6
CgogwqDCoMKgIG9iai0kKENPTkZJR19LRVhFQ19DT1JFKcKgwqDCoMKgwqDCoMKgICs9IGtleGVj
X3JlbG9jYXRlLm8gCmNyYXNoX3NhdmVfcmVncy5vIG1hY2hpbmVfa2V4ZWMubwoKdG9ydmFsZHMv
bGludXggaXMgbmV3ZXIgdGhhbiByaXNjdi9mb3ItbmV4dCzCoCBjb21taXQgM2E2NmEwODc1OSAK
KCJSSVNDLVY6IGtleGVjOiBGaXggYnVpbGQgZXJyb3Igd2l0aG91dCBDT05GSUdfS0VYRUMiKSBh
ZGRlZCAKIkNPTkZJR19LRVhFQ19DT1JFIiBmb3IgdG9ydmFsZHMvbGludXgsIEJ1dCByaXNjdi9m
b3ItbmV4dAoKZG9lc24ndCBjb250YWluIHRoZSBjb21taXQuCgoKPgo+Pgo+PiBUaGFua3MsCj4+
IENvbm9yLgo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
