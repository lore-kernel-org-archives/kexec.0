Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415D7C41535
	for <kexec@archiver.kernel.org>; Tue, 19 Dec 2023 03:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XiMzoM4CZAYC1cGn26u6AYbz8okj/uRvxCcVCY4oZkw=; b=jPijoy2U8TqwQo
	mPmDUO6MePauHJXWDxlwF9+YFUhO9wYjdaH89fFNjGDaYIb4tgCBs84GblNUU6gHkexJ+CK31qqt9
	/Zha8XhONUhIqLb+Hbm7ajof+UhxHSopnnwwa/JHbiTBOZ1fPF3zl7aBh/NHFmtilWa//0iPaP5wN
	1v03jHNNG/djyqSnfcBS/9RdLAy7IFR+EL7hq2A0y5eUIX1YzHORrizE//ZKfZ7B6pBQBkGjOhtBQ
	qp9ymmeeEF8WGmMC9kjy8K5kqvNO2Z1ce0fk61IDlcwoSvQ7PYBo2WHjLSG3Xx6fBpWuxl+Eb49WZ
	7U26t2iCv3lqB1w3Ch1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFR8w-00Cj9r-1U;
	Tue, 19 Dec 2023 03:51:42 +0000
Received: from mail-m11887.qiye.163.com ([115.236.118.87])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFR8s-00Cj8n-2B
	for kexec@lists.infradead.org;
	Tue, 19 Dec 2023 03:51:40 +0000
Received: from [10.9.0.130] (unknown [211.103.144.18])
	by smtp.qiye.163.com (Hmail) with ESMTPA id BD8ED260127;
	Tue, 19 Dec 2023 11:50:33 +0800 (CST)
Message-ID: <c797bdde-b5a5-4b2b-9106-c1386a0e7516@easystack.cn>
Date: Tue, 19 Dec 2023 11:50:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Content-Language: en-US
To: Yuntao Wang <ytcoode@gmail.com>
Cc: bhe@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, vgoyal@redhat.com
References: <2fc2ad7d-13be-4a9a-b984-67b1bf04c56b@easystack.cn>
 <20231219024727.35016-1-ytcoode@gmail.com>
From: fuqiang wang <fuqiang.wang@easystack.cn>
In-Reply-To: <20231219024727.35016-1-ytcoode@gmail.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQktLVk4fT0JOTR9CTUtNT1UZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKSlVKS0hVSk9PVUpDWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8c803268680276kunmbd8ed260127
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kwg6Nww*FTEwKwIfKQkiDw0a
	PVEaCx1VSlVKTEtJQk5MQ0hMT0JCVTMWGhIXVR0OChIaFRxVDBoVHDseGggCCA8aGBBVGBVFWVdZ
	EgtZQVlJSkpVSktIVUpPT1VKQ1lXWQgBWUFITU1JNwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_195138_942364_79384391 
X-CRM114-Status: GOOD (  14.79  )
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

5ZyoIDIwMjMvMTIvMTkgMTA6NDcsIFl1bnRhbyBXYW5nIOWGmemBkzoKCj4gSGkgZnVxaWFuZywK
Pgo+IFllc3RlcmRheSwgSSBwb3N0ZWQgdHdvIHBhdGNoZXMgdGhhdCBoYXBwZW4gdG8gYWRkcmVz
cyB0aGUgYnVncyB5b3UgYW4gQmFvcXVhbgo+IGFyZSBjdXJyZW50bHkgZGlzY3Vzc2luZyBoZXJl
LCBJIHdhc24ndCBhd2FyZSB0aGF0IHlvdSBib3RoIHdlcmUgYWxzbyB3b3JraW5nCj4gb24gZml4
aW5nIHRoZXNlIGlzc3Vlcy4KPgo+IEJhb3F1YW4gc3VnZ2VzdGVkIEkgdGFsayB0byB5b3UgYWJv
dXQgaXQuCj4KPiBJZiB5b3UncmUgaW50ZXJlc3RlZCwgeW91IGNhbiB0YWtlIGEgbG9vayBhdCBt
eSBwYXRjaGVzIGFuZCByZXZpZXcgdGhlbSB0byBzZWUKPiBpZiB0aGVyZSBhcmUgYW55IGlzc3Vl
cy4gSWYgZXZlcnl0aGluZyBpcyBmaW5lLCBhbmQgaWYgeW91J3JlIHdpbGxpbmcsIHlvdSBjYW4K
PiBhbHNvIGFkZCBhICdSZXZpZXdlZC1ieScgdGFnIHRoZXJlLgo+Cj4gVGhlIGZvbGxvd2luZyBs
aW5rIGlzIGZvciB0aGUgdHdvIHBhdGNoZXMgSSBwb3N0ZWQgeWVzdGVyZGF5Ogo+Cj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMTIxODA4MTkxNS4yNDEyMC0zLXl0Y29vZGVAZ21h
aWwuY29tL3QvI3UKPgo+IFNpbmNlcmVseSwKPiBZdW50YW8KCkhpIFl1bnRhbywKCkknbSBnbGFk
IHlvdSd2ZSBhbHNvIG5vdGljZWQgdGhpcyBpc3N1ZS4gQnV0IEknbSBzb3JyeSwgSSB3YW50IHRv
IHNvbHZlIHRoaXMKcHJvYmxlbSBteXNlbGYgYmVjYXVzZSB0aGlzIGlzIG15IGZpcnN0IHRpbWUg
cG9zdGluZyBhIHBhdGNoIGluIHRoZSBjb21tdW5pdHksCmFuZCBJIGNoZXJpc2ggdGhpcyBvcHBv
cnR1bml0eSB2ZXJ5IG11Y2guCgpJIGhhdmUgY2FyZWZ1bGx5IHJldmlld2VkIHlvdXIgcGF0Y2gu
IFRoZXJlIGlzIHNvbWUgY2hhbmdlcyB3aGVyZSBteSB2aWV3cyBkaWZmZXIKZnJvbSB5b3VyczoK
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcmFzaC5jIGIvYXJjaC94ODYva2VybmVsL2Ny
YXNoLmMKaW5kZXggYzkyZDg4NjgwZGJmLi4zYmU0NmY0YjQ0MWUgMTAwNjQ0Ci0tLSBhL2FyY2gv
eDg2L2tlcm5lbC9jcmFzaC5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9jcmFzaC5jCkBAIC0yODIs
MTAgKzI4Miw2IEBAIGludCBjcmFzaF9zZXR1cF9tZW1tYXBfZW50cmllcyhzdHJ1Y3Qga2ltYWdl
ICppbWFnZSwgc3RydWN0IGJvb3RfcGFyYW1zICpwYXJhbXMpCiDCoMKgwqDCoCBzdHJ1Y3QgY3Jh
c2hfbWVtbWFwX2RhdGEgY21kOwogwqDCoMKgwqAgc3RydWN0IGNyYXNoX21lbSAqY21lbTsKCi3C
oMKgwqAgY21lbSA9IHZ6YWxsb2Moc3RydWN0X3NpemUoY21lbSwgcmFuZ2VzLCAxKSk7Ci3CoMKg
wqAgaWYgKCFjbWVtKQotwqDCoMKgIMKgwqDCoCByZXR1cm4gLUVOT01FTTsKLQogwqDCoMKgwqAg
bWVtc2V0KCZjbWQsIDAsIHNpemVvZihzdHJ1Y3QgY3Jhc2hfbWVtbWFwX2RhdGEpKTsKIMKgwqDC
oMKgIGNtZC5wYXJhbXMgPSBwYXJhbXM7CgpAQCAtMzIxLDYgKzMxNywxMSBAQCBpbnQgY3Jhc2hf
c2V0dXBfbWVtbWFwX2VudHJpZXMoc3RydWN0IGtpbWFnZSAqaW1hZ2UsIHN0cnVjdCBib290X3Bh
cmFtcyAqcGFyYW1zKQogwqDCoMKgwqAgfQoKIMKgwqDCoMKgIC8qIEV4Y2x1ZGUgc29tZSByYW5n
ZXMgZnJvbSBjcmFzaGtfcmVzIGFuZCBhZGQgcmVzdCB0byBtZW1tYXAgKi8KK8KgwqDCoCBjbWVt
ID0gdnphbGxvYyhzdHJ1Y3Rfc2l6ZShjbWVtLCByYW5nZXMsIDEpKTsKK8KgwqDCoCBpZiAoIWNt
ZW0pCivCoMKgwqAgwqDCoMKgIHJldHVybiAtRU5PTUVNOworwqDCoMKgIGNtZW0tPm1heF9ucl9y
YW5nZXMgPSAxOworCiDCoMKgwqDCoCByZXQgPSBtZW1tYXBfZXhjbHVkZV9yYW5nZXMoaW1hZ2Us
IGNtZW0sIGNyYXNoa19yZXMuc3RhcnQsIGNyYXNoa19yZXMuZW5kKTsKIMKgwqDCoMKgIGlmIChy
ZXQpCiDCoMKgwqDCoCDCoMKgwqAgZ290byBvdXQ7CgoxLiBJIGRvbid0IGZlZWwgdmVyeSBnb29k
IHRoYXQgeW91IGhhdmUgbW92ZWQgdnphbGxvYygpIHRvIGluIGZyb250IG9mCm1lbW1hcF9leGNs
dWRlX3Jhbmdlcy4gQmVjYXVzZSBpZiBtZW1vcnkgYWxsb2NhdGlvbiBmYWlscywgdGhlcmUgaXMg
bm8gbmVlZCB0bwpkbyBhbnl0aGluZyBlbHNlIGFmdGVyd2FyZHMuCgoyLiBUaGUgY21lbS0+bWF4
X25yX3JhbmdlcyBzaG91bGQgYmUgc2V0IHRvIDIuIEJlY2F1c2UgaW4KbWVtbWFwX2V4Y2x1ZGVf
cmFuZ2VzLCBhIGNtZW0tPnJhbmdlc1tdIHdpbGwgYmUgZmlsbGVkIGluIGFuZCBpZiBhIHNwbGl0
IG9jY3VycwpsYXRlciwgYW5vdGhlciBvbmUgd2lsbCBiZSBhZGRlZC4KClRoYW5rcwpmdXFpYW5n
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
