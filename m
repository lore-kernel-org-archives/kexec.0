Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DDCC38A02
	for <kexec@archiver.kernel.org>; Fri, 28 Oct 2022 11:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z/y6B1EBv0YgRcfGteRc9p+SRFJWEaOHKSyPzVja8rw=; b=X6pXObZn9CKG1l
	IY9feAPVjzM8UMIgcGUeS/WWSh0ptLWRqcaWvF2FZzBWw+LgDCEdLJffpFhV+WvUkWmY+sm1ta7m0
	AYdo1TPzPmcYFJzTa3sfEqqHJRVNGoZh2pZr6lyDHRAEywB8TsUkuyfTR96eQxUU4SF5oDuXBowt4
	98w+OWr2xJeb7M4aEgUmSb4Ea3n6jYdujKnwpNBRWJK40qtXJIr9IIImqfx6tNXFeUKxVTutjZYtN
	nvwRXn9LRwrTC9P2sOGJr8m8tZ/3u6yw0wRVPhA7GCoKOV4W5ooG78X7+ai96t6+xhTiBK6GiTJ+o
	h01QJx5wdEnESJNckSGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooNL7-00Gtmg-Uo; Fri, 28 Oct 2022 11:15:53 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooM8G-00GU4y-OR
	for kexec@lists.infradead.org; Fri, 28 Oct 2022 09:58:34 +0000
Received: from momiji.horms.nl (2a02-a46e-7b6b-703-d63d-7eff-fe99-ac9d.fixed6.kpn.net [IPv6:2a02:a46e:7b6b:703:d63d:7eff:fe99:ac9d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id 6A374200C6;
	Fri, 28 Oct 2022 09:58:31 +0000 (UTC)
Received: by momiji.horms.nl (Postfix, from userid 7100)
	id 1FCE19402F1; Fri, 28 Oct 2022 11:58:31 +0200 (CEST)
Date: Fri, 28 Oct 2022 11:58:31 +0200
From: Simon Horman <horms@kernel.org>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Cc: Simon Horman <horms@kernel.org>, kexec@lists.infradead.org,
	mick@ics.forth.gr, yixun.lan@gmail.com, guoren@kernel.org
Subject: Re: [PATCH V2] RISC-V: Add support for riscv kexec/kdump on
 kexec-tools
Message-ID: <Y1unx7jgiSXCIF6L@vergenet.net>
References: <20221020031548.47587-1-xianting.tian@linux.alibaba.com>
 <Y1K6TsGGC3KnFlf8@vergenet.net>
 <44c6ec02-ab91-a9ba-a0b8-fed6b93b82d4@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <44c6ec02-ab91-a9ba-a0b8-fed6b93b82d4@linux.alibaba.com>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.7 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_025832_984177_37BF3BD6 
X-CRM114-Status: GOOD (  31.27  )
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

T24gV2VkLCBPY3QgMjYsIDIwMjIgYXQgMTA6MTM6NDhBTSArMDgwMCwgWGlhbnRpbmcgVGlhbiB3
cm90ZToKPiBIaSBTaW1vbgo+IAo+IHRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzCj4gCj4g5ZyoIDIw
MjIvMTAvMjEg5LiL5Y2IMTE6MjcsIFNpbW9uIEhvcm1hbiDlhpnpgZM6Cj4gPiBPbiBUaHUsIE9j
dCAyMCwgMjAyMiBhdCAxMToxNTo0OEFNICswODAwLCBYaWFudGluZyBUaWFuIHdyb3RlOgo+ID4g
PiBGcm9tOiBOaWNrIEtvc3NpZmlkaXMgPG1pY2tAaWNzLmZvcnRoLmdyPgo+ID4gPiAKPiA+ID4g
VGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIGxvYWRpbmcgdGhlIEVMRiBrZXJuZWwgaW1hZ2Uu
IEl0IHBhcnNlcwo+ID4gPiB0aGUgY3VycmVudC9wcm92aWRlZCBkZXZpY2UgdHJlZSB0byBkZXRl
cm1pbmUgdGhlIHN5c3RlbSdzIG1lbW9yeQo+ID4gPiBsYXlvdXQsIGFuZCAvcHJvYy9pb21lbSBm
b3IgdGhlIHZhcmlvdXMga2VybmVsIHNlZ21lbnRzLgo+ID4gPiAKPiA+ID4gVGhpcyBwYXRjaCB3
YXMgZmlyc3RseSBkZXZlbG9wZWQgYnkgTmljayBLb3NzaWZpZGlzLCBhbmQgdHdvIGZpeGVzICgK
PiA+ID4gICAgIDE6IGZhaWwgdG8gZmluZCBmcmVlIG1lbW9yeSBhcmVhIGZvciBkdGIgbG9hZCB3
aGVuIHVzaW5nIGluaXRyZCBpbWFnZSwKPiA+ID4gICAgICAgIGxpc3RzLmluZnJhZGVhZC5vcmcv
cGlwZXJtYWlsL2xpbnV4LXJpc2N2LzIwMjItQXVndXN0LzAxODM5OC5odG1sOwo+ID4gPiAgICAg
MjogZml4IG1lbW9yeSByYW5nZSBzaXplIGNhbGN1bGF0aW9uLAo+ID4gPiAgICAgICAgIGtleGVj
L2FyY2gvcmlzY3YvY3Jhc2hkdW1wLXJpc2N2LmM6bGluZSA4NQo+ID4gPiApIGFyZSBjb250cmli
dXRlZCBieSBZaXh1biBMYW4sIFhpYW50aW5nIFRpYW4uCj4gPiA+IAo+ID4gPiBUZXN0ZWQgb24g
UWVtdSdzIHJ2NjQgdmlydCBtYWNoaW5lIGFuZCBTb0Mgb2YgVC1IZWFkIFJJU0MtViBYdWFudGll
IDkxMCBDUFUuCj4gPiBIaSwKPiA+IAo+ID4gdGhhbmtzIGZvciBzb21lIHBhdGNoLgo+ID4gCj4g
PiBTb21lIG1pbm9yIGZlZWRiYWNrIGZvbGxvd3MuCj4gPiAKPiA+IFNlcGFyYXRlbHksIEknbGwg
cG9zdCBhIHBhdGNoIHRvIGFkZCBSSVNDLVYgYnVpbGRzIHRvIHRoZSBnaXRodWIKPiA+IHdvcmtm
bG93LiBJZiB5b3UgY291bGQgaW5jbHVkZSB0aGF0IGluIFYzIEknZCBiZSBtb3N0IGdyYXRlZnVs
Lgo+ID4gCj4gPiA+IFRlc3RlZC1ieTogWWl4dW4gTGFuIDx5aXh1bi5sYW5AZ21haWwuY29tPgo+
ID4gPiBDby1kZXZlbG9wZWQtYnk6IFhpYW50aW5nIFRpYW4gPHhpYW50aW5nLnRpYW5AbGludXgu
YWxpYmFiYS5jb20+Cj4gPiA+IENvLWRldmVsb3BlZC1ieTogWWl4dW4gTGFuIDx5aXh1bi5sYW5A
Z21haWwuY29tPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOaWNrIEtvc3NpZmlkaXMgPG1pY2tAaWNz
LmZvcnRoLmdyPgo+ID4gLi4uCj4gPiAKPiA+ID4gKwlyZXQgPSBtZW1fcmVnaW9uc19hbGxvY19h
bmRfYWRkKG1lbV9yYW5nZXMsIHN0YXJ0LAo+ID4gPiArCQkJCQllbmQgLSBzdGFydCwgdHlwZSk7
Cj4gPiBtZW1fcmVnaW9uc19hbGxvY19hbmRfYWRkIGlzbid0IGFsd2F5cyBhdmFpbGFibGUuCj4g
PiBmLmUuIG9uIG1pcHMgdGhpcyBjYXVzZXMgYSBidWlsZCBmYWlsdXJlLgo+ID4gCj4gPiBSZWY6
IGh0dHBzOi8vZ2l0aHViLmNvbS9ob3Jtcy9rZXhlYy10b29scy9hY3Rpb25zL3J1bnMvMzI5ODQ5
MTE0My9qb2JzLzU0NDA2Nzc1OTUKPiAKPiBBcyB5b3Uga25vdywgbWVtX3JlZ2lvbnNfc29ydCwg
bWVtX3JlZ2lvbnNfYWxsb2NfYW5kX2FkZCBhcmUgdGhlIGNvbW1vbgo+IGZ1bnRpb25zLAo+IAo+
IFRoZSBidWlsZCBlcnJvciBvZiBtaXBzIGlzIGNhdXNlZCBieSB0aGlzIHJpc2N2IHBhdGNoPwoK
WWVzLCBJIHRoaW5rIHNvLgoKVGhlIHdvcmtmbG93IHBhc3NlcyBvbiBtYWluOiBodHRwczovL2dp
dGh1Yi5jb20vaG9ybXMva2V4ZWMtdG9vbHMvYWN0aW9ucy9ydW5zLzMzNDQ1MjM1MTkKQnV0IG5v
dCB3aXRoIHRoZSByaXNjdiBwYXRjaCBhcHBsaWVkOiBodHRwczovL2dpdGh1Yi5jb20vaG9ybXMv
a2V4ZWMtdG9vbHMvdHJlZS9idWlsZC10ZXN0LXJpc2N2LXYyCgo+IGtleGVjL21lbV9yZWdpb25z
LmM6dm9pZCBtZW1fcmVnaW9uc19zb3J0KHN0cnVjdCBtZW1vcnlfcmFuZ2VzICpyYW5nZXMpCj4g
a2V4ZWMvbWVtX3JlZ2lvbnMuaDp2b2lkIG1lbV9yZWdpb25zX3NvcnQoc3RydWN0IG1lbW9yeV9y
YW5nZXMgKnJhbmdlcyk7Cj4gCj4gCj4ga2V4ZWMvbWVtX3JlZ2lvbnMuYzppbnQgbWVtX3JlZ2lv
bnNfYWxsb2NfYW5kX2FkZChzdHJ1Y3QgbWVtb3J5X3Jhbmdlcwo+ICpyYW5nZXMsCj4ga2V4ZWMv
bWVtX3JlZ2lvbnMuaDppbnQgbWVtX3JlZ2lvbnNfYWxsb2NfYW5kX2FkZChzdHJ1Y3QgbWVtb3J5
X3Jhbmdlcwo+ICpyYW5nZXMsCj4gCj4gPiAKPiA+IC4uLgo+ID4gCj4gPiA+ICtpbnQgZHRiX2dl
dF9tZW1vcnlfcmFuZ2VzKGNoYXIgKmR0Yiwgc3RydWN0IG1lbW9yeV9yYW5nZXMgKm1lbV9yYW5n
ZXMsIHN0cnVjdCBtZW1vcnlfcmFuZ2VzICpleHRyYV9yYW5nZXMpCj4gPiA+ICt7Cj4gPiAuLi4K
PiA+IAo+ID4gPiArCW1lbV9yZWdpb25zX3NvcnQobWVtX3Jhbmdlcyk7Cj4gPiBMaWtld2lzZSwg
bWVtX3JlZ2lvbnNfc29ydCBpc24ndCBhbHdheXMgYXZhaWxhYmxlLgo+ID4gZi5lLiBvbiBtaXBz
IHRoaXMgY2F1c2VzIGEgYnVpbGQgZmFpbHVyZS4KPiA+IAo+ID4gLi4uCj4gPiAKPiA+ID4gZGlm
ZiAtLWdpdCBhL3B1cmdhdG9yeS9hcmNoL3Jpc2N2L01ha2VmaWxlIGIvcHVyZ2F0b3J5L2FyY2gv
cmlzY3YvTWFrZWZpbGUKPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiA+ID4gaW5kZXggMDAw
MDAwMC4uOGJkZWQ3MQo+ID4gPiAtLS0gL2Rldi9udWxsCj4gPiA+ICsrKyBiL3B1cmdhdG9yeS9h
cmNoL3Jpc2N2L01ha2VmaWxlCj4gPiA+IEBAIC0wLDAgKzEsNyBAQAo+ID4gPiArIwo+ID4gPiAr
IyBQdXJnYXRvcnkgcmlzY3YKPiA+ID4gKyMKPiA+ID4gKwo+ID4gPiArcmlzY3ZfUFVSR0FUT1JZ
X1NSQ1MgPQo+ID4gPiArCj4gPiA+ICtkaXN0ICs9IHB1cmdhdG9yeS9hcmNoL3NoL01ha2VmaWxl
ICQocmlzY3ZfUFVSR0FUT1JZX1NSQ1MpCj4gPiBzL3NoL3Jpc2N2Lwo+ID4gCj4gPiBFbHNlIHRo
ZSBkaXN0cmlidXRpb24gdGFyYmFsbCB3b24ndCBpbmNsdWRlIHRoaXMgTWFrZWZpbGUKPiA+IAo+
ID4gWW91IGNhbiBleGVyY2lzZSB0aGlzIHVzaW5nOgo+ID4gICAgbWFrZSBkaXN0Y2hlY2sgRElT
VENIRUNLX0NPTkZJR1VSRV9GTEFHUz0iLS1ob3N0PXJpc2N2NjQtbGludXgtZ251Igo+IHRoYW5r
cywgSSB3aWxsIGZpeCB0aGlzLgoKVGhhbmtzLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhl
Ywo=
