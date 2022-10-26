Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B22C38A2D
	for <kexec@archiver.kernel.org>; Wed, 26 Oct 2022 02:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u9OJFXLa7XSQPphpT3CyQnzXZzv4NJ8+JfMts+9+Bak=; b=ai/nKyHFX+/kf0
	RAmVIhUSSXHSVK71BxfbIoJ4o/jiiSicjT2xNPlyNfMN/uEJRhb8LA4g670jLaKM94388yT4qrNV3
	QBEGuU/2NpPYCE6sDwU4lvfpNTEzaT6bgAp12xYouaLWN7vXQP2MpA2c/z20tQCXdUGIGXpwc3pIF
	M4IXJ3ZaSW7ZDft03jjT/sjrC23gwuGa8IUxnqtx/3J9JmccfHwJrD3CKXYQ/S+gU5fH+Hpz0eXoG
	U5naY915JlagFQ1w7zCw1XSnNcR2dVKCLGrcVCqzIpmmjMk9U0CuOgbbgnbm1eTxFY7Zdqlrr09QM
	rygB4h2d/c24WR/S7zOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onWdi-007sgq-5u; Wed, 26 Oct 2022 02:59:34 +0000
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onWde-007sff-84
	for kexec@lists.infradead.org; Wed, 26 Oct 2022 02:59:32 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VT5HH60_1666753160;
Received: from 30.221.97.58(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VT5HH60_1666753160)
          by smtp.aliyun-inc.com;
          Wed, 26 Oct 2022 10:59:22 +0800
Message-ID: <c87af556-1996-bc22-52da-1da23761d591@linux.alibaba.com>
Date: Wed, 26 Oct 2022 10:59:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V2] RISC-V: Add support for riscv kexec/kdump on
 kexec-tools
From: Xianting Tian <xianting.tian@linux.alibaba.com>
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org, mick@ics.forth.gr, yixun.lan@gmail.com,
 guoren@kernel.org
References: <20221020031548.47587-1-xianting.tian@linux.alibaba.com>
 <Y1K6TsGGC3KnFlf8@vergenet.net>
 <44c6ec02-ab91-a9ba-a0b8-fed6b93b82d4@linux.alibaba.com>
In-Reply-To: <44c6ec02-ab91-a9ba-a0b8-fed6b93b82d4@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_195930_477647_03FE6DE6 
X-CRM114-Status: GOOD (  18.22  )
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

CuWcqCAyMDIyLzEwLzI2IOS4iuWNiDEwOjEzLCBYaWFudGluZyBUaWFuIOWGmemBkzoKPiBIaSBT
aW1vbgo+Cj4gdGhhbmtzIGZvciB0aGUgY29tbWVudHMKPgo+IOWcqCAyMDIyLzEwLzIxIOS4i+WN
iDExOjI3LCBTaW1vbiBIb3JtYW4g5YaZ6YGTOgo+PiBPbiBUaHUsIE9jdCAyMCwgMjAyMiBhdCAx
MToxNTo0OEFNICswODAwLCBYaWFudGluZyBUaWFuIHdyb3RlOgo+Pj4gRnJvbTogTmljayBLb3Nz
aWZpZGlzIDxtaWNrQGljcy5mb3J0aC5ncj4KPj4+Cj4+PiBUaGlzIHBhdGNoIGFkZHMgc3VwcG9y
dCBmb3IgbG9hZGluZyB0aGUgRUxGIGtlcm5lbCBpbWFnZS4gSXQgcGFyc2VzCj4+PiB0aGUgY3Vy
cmVudC9wcm92aWRlZCBkZXZpY2UgdHJlZSB0byBkZXRlcm1pbmUgdGhlIHN5c3RlbSdzIG1lbW9y
eQo+Pj4gbGF5b3V0LCBhbmQgL3Byb2MvaW9tZW0gZm9yIHRoZSB2YXJpb3VzIGtlcm5lbCBzZWdt
ZW50cy4KPj4+Cj4+PiBUaGlzIHBhdGNoIHdhcyBmaXJzdGx5IGRldmVsb3BlZCBieSBOaWNrIEtv
c3NpZmlkaXMsIGFuZCB0d28gZml4ZXMgKAo+Pj4gwqDCoMKgIDE6IGZhaWwgdG8gZmluZCBmcmVl
IG1lbW9yeSBhcmVhIGZvciBkdGIgbG9hZCB3aGVuIHVzaW5nIGluaXRyZCAKPj4+IGltYWdlLAo+
Pj4gbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtcmlzY3YvMjAyMi1BdWd1c3Qv
MDE4Mzk4Lmh0bWw7Cj4+PiDCoMKgwqAgMjogZml4IG1lbW9yeSByYW5nZSBzaXplIGNhbGN1bGF0
aW9uLAo+Pj4gwqDCoMKgwqDCoMKgwqAga2V4ZWMvYXJjaC9yaXNjdi9jcmFzaGR1bXAtcmlzY3Yu
YzpsaW5lIDg1Cj4+PiApIGFyZSBjb250cmlidXRlZCBieSBZaXh1biBMYW4sIFhpYW50aW5nIFRp
YW4uCj4+Pgo+Pj4gVGVzdGVkIG9uIFFlbXUncyBydjY0IHZpcnQgbWFjaGluZSBhbmQgU29DIG9m
IFQtSGVhZCBSSVNDLVYgWHVhbnRpZSAKPj4+IDkxMCBDUFUuCj4+IEhpLAo+Pgo+PiB0aGFua3Mg
Zm9yIHNvbWUgcGF0Y2guCj4+Cj4+IFNvbWUgbWlub3IgZmVlZGJhY2sgZm9sbG93cy4KPj4KPj4g
U2VwYXJhdGVseSwgSSdsbCBwb3N0IGEgcGF0Y2ggdG8gYWRkIFJJU0MtViBidWlsZHMgdG8gdGhl
IGdpdGh1Ygo+PiB3b3JrZmxvdy4gSWYgeW91IGNvdWxkIGluY2x1ZGUgdGhhdCBpbiBWMyBJJ2Qg
YmUgbW9zdCBncmF0ZWZ1bC4KPj4KPj4+IFRlc3RlZC1ieTogWWl4dW4gTGFuIDx5aXh1bi5sYW5A
Z21haWwuY29tPgo+Pj4gQ28tZGV2ZWxvcGVkLWJ5OiBYaWFudGluZyBUaWFuIDx4aWFudGluZy50
aWFuQGxpbnV4LmFsaWJhYmEuY29tPgo+Pj4gQ28tZGV2ZWxvcGVkLWJ5OiBZaXh1biBMYW4gPHlp
eHVuLmxhbkBnbWFpbC5jb20+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBOaWNrIEtvc3NpZmlkaXMgPG1p
Y2tAaWNzLmZvcnRoLmdyPgo+PiAuLi4KPj4KPj4+ICvCoMKgwqAgcmV0ID0gbWVtX3JlZ2lvbnNf
YWxsb2NfYW5kX2FkZChtZW1fcmFuZ2VzLCBzdGFydCwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBlbmQgLSBzdGFydCwgdHlwZSk7Cj4+IG1lbV9yZWdpb25zX2Fs
bG9jX2FuZF9hZGQgaXNuJ3QgYWx3YXlzIGF2YWlsYWJsZS4KPj4gZi5lLiBvbiBtaXBzIHRoaXMg
Y2F1c2VzIGEgYnVpbGQgZmFpbHVyZS4KPj4KPj4gUmVmOiAKPj4gaHR0cHM6Ly9naXRodWIuY29t
L2hvcm1zL2tleGVjLXRvb2xzL2FjdGlvbnMvcnVucy8zMjk4NDkxMTQzL2pvYnMvNTQ0MDY3NzU5
NQo+Cj4gQXMgeW91IGtub3csIG1lbV9yZWdpb25zX3NvcnQsIG1lbV9yZWdpb25zX2FsbG9jX2Fu
ZF9hZGQgYXJlIHRoZSAKPiBjb21tb24gZnVudGlvbnMsCj4KPiBUaGUgYnVpbGQgZXJyb3Igb2Yg
bWlwcyBpcyBjYXVzZWQgYnkgdGhpcyByaXNjdiBwYXRjaD8KPgo+IGtleGVjL21lbV9yZWdpb25z
LmM6dm9pZCBtZW1fcmVnaW9uc19zb3J0KHN0cnVjdCBtZW1vcnlfcmFuZ2VzICpyYW5nZXMpCj4g
a2V4ZWMvbWVtX3JlZ2lvbnMuaDp2b2lkIG1lbV9yZWdpb25zX3NvcnQoc3RydWN0IG1lbW9yeV9y
YW5nZXMgKnJhbmdlcyk7Cj4KPgo+IGtleGVjL21lbV9yZWdpb25zLmM6aW50IG1lbV9yZWdpb25z
X2FsbG9jX2FuZF9hZGQoc3RydWN0IG1lbW9yeV9yYW5nZXMgCj4gKnJhbmdlcywKPiBrZXhlYy9t
ZW1fcmVnaW9ucy5oOmludCBtZW1fcmVnaW9uc19hbGxvY19hbmRfYWRkKHN0cnVjdCBtZW1vcnlf
cmFuZ2VzIAo+ICpyYW5nZXMsCj4KPj4KPj4gLi4uCj4+Cj4+PiAraW50IGR0Yl9nZXRfbWVtb3J5
X3JhbmdlcyhjaGFyICpkdGIsIHN0cnVjdCBtZW1vcnlfcmFuZ2VzIAo+Pj4gKm1lbV9yYW5nZXMs
IHN0cnVjdCBtZW1vcnlfcmFuZ2VzICpleHRyYV9yYW5nZXMpCj4+PiArewo+PiAuLi4KPj4KPj4+
ICvCoMKgwqAgbWVtX3JlZ2lvbnNfc29ydChtZW1fcmFuZ2VzKTsKPj4gTGlrZXdpc2UsIG1lbV9y
ZWdpb25zX3NvcnQgaXNuJ3QgYWx3YXlzIGF2YWlsYWJsZS4KPj4gZi5lLiBvbiBtaXBzIHRoaXMg
Y2F1c2VzIGEgYnVpbGQgZmFpbHVyZS4KPj4KPj4gLi4uCj4+Cj4+PiBkaWZmIC0tZ2l0IGEvcHVy
Z2F0b3J5L2FyY2gvcmlzY3YvTWFrZWZpbGUgCj4+PiBiL3B1cmdhdG9yeS9hcmNoL3Jpc2N2L01h
a2VmaWxlCj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+Pj4gaW5kZXggMDAwMDAwMC4uOGJkZWQ3
MQo+Pj4gLS0tIC9kZXYvbnVsbAo+Pj4gKysrIGIvcHVyZ2F0b3J5L2FyY2gvcmlzY3YvTWFrZWZp
bGUKPj4+IEBAIC0wLDAgKzEsNyBAQAo+Pj4gKyMKPj4+ICsjIFB1cmdhdG9yeSByaXNjdgo+Pj4g
KyMKPj4+ICsKPj4+ICtyaXNjdl9QVVJHQVRPUllfU1JDUyA9Cj4+PiArCj4+PiArZGlzdCArPSBw
dXJnYXRvcnkvYXJjaC9zaC9NYWtlZmlsZSAkKHJpc2N2X1BVUkdBVE9SWV9TUkNTKQo+PiBzL3No
L3Jpc2N2Lwo+Pgo+PiBFbHNlIHRoZSBkaXN0cmlidXRpb24gdGFyYmFsbCB3b24ndCBpbmNsdWRl
IHRoaXMgTWFrZWZpbGUKPj4KPj4gWW91IGNhbiBleGVyY2lzZSB0aGlzIHVzaW5nOgo+PiDCoMKg
IG1ha2UgZGlzdGNoZWNrIERJU1RDSEVDS19DT05GSUdVUkVfRkxBR1M9Ii0taG9zdD1yaXNjdjY0
LWxpbnV4LWdudSIKPiB0aGFua3MsIEkgd2lsbCBmaXggdGhpcy4KCnRoZSBmaXggaXMgaW4gbXkg
cGVyc29uYWwgZ2l0ZWUKCmh0dHBzOi8vZ2l0ZWUuY29tL3hpYW50aW5nLXRpYW4va2V4ZWMtdG9v
bHMvY29tbWl0cy9tYXN0ZXIKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
