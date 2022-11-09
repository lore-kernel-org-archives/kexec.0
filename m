Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4670C4332F
	for <kexec@archiver.kernel.org>; Wed,  9 Nov 2022 09:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=agqU1PjN6DT9qdUI4+0ANGX81996umevopxT8rlojio=; b=W7+32xMLWPJ2A4
	QSb9Pd6uuBM4VJyzHYUWPpPZVRAz5bnhWo2sZkS1Q0Dgfczm/7iTLAYhk9/gsSVVyGSdTvnIcbVbY
	ekc9wvSaEw5bBRR3t3VNgxS0F3LFNdyzjthY8iXiXiGLN8GJa522cmowQt+H/mtqYAHQECh71HmIG
	/3qdrHreOs63N6tG6eoypwAZbOtwBCX+0g8urigoX+dF6HXVnch8P0atteXXHYGxG0C4qUCILNbxo
	Nhe4j8EDGXzo9eG1a+rBxyBeVM3zHC2SSJ/5PDe+EkMKfilz7TT/rz2bxVfhQXSQtyFgObiIjDLIf
	DGDBTjkNKMrR3xWkhdYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osgxY-00C66l-Ef; Wed, 09 Nov 2022 09:01:24 +0000
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osgxO-00C5vr-TA
	for kexec@lists.infradead.org; Wed, 09 Nov 2022 09:01:17 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VUNEgVk_1667984463;
Received: from 30.221.96.243(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VUNEgVk_1667984463)
          by smtp.aliyun-inc.com;
          Wed, 09 Nov 2022 17:01:04 +0800
Message-ID: <f120e4f0-1db9-fc6a-85dd-f42b58ca4d88@linux.alibaba.com>
Date: Wed, 9 Nov 2022 17:01:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [Crash-utility][PATCH V4 1/9] Add RISCV64 framework code support
To: lijiang <lijiang@redhat.com>,
 "crash-utility@redhat.com" <crash-utility@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 "hschauhan@nulltrace.org" <hschauhan@nulltrace.org>,
 "lifang_xia@linux.alibaba.com" <lifang_xia@linux.alibaba.com>,
 "mick@ics.forth.gr" <mick@ics.forth.gr>,
 "heinrich.schuchardt@canonical.com" <heinrich.schuchardt@canonical.com>,
 "guoren@kernel.org" <guoren@kernel.org>,
 "yixun.lan@gmail.com" <yixun.lan@gmail.com>,
 =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
References: <20221020015014.46085-1-xianting.tian@linux.alibaba.com>
 <20221020015014.46085-2-xianting.tian@linux.alibaba.com>
 <4022d4a1-8967-3d09-e158-5a6f78f73655@nec.com>
 <4bccb5c9-6385-23d9-d496-65f9bd06beb2@linux.alibaba.com>
 <b5209fda-17c2-9271-c40e-1a0343a725a2@nec.com>
 <CANU+Zye-oDirOROVms1XODVunBf4rErQT1tGAY=62pZeufQUTw@mail.gmail.com>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <CANU+Zye-oDirOROVms1XODVunBf4rErQT1tGAY=62pZeufQUTw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_010115_140352_EBDF5961 
X-CRM114-Status: GOOD (  10.72  )
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

CuWcqCAyMDIyLzExLzMg5LiL5Y2IMTozMiwgbGlqaWFuZyDlhpnpgZM6Cj4gT24gRnJpLCBPY3Qg
MjEsIDIwMjIgYXQgMTA6NTcgQU0gSEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQo+IDxr
LWhhZ2lvLWFiQG5lYy5jb20+IHdyb3RlOgo+PiBPbiAyMDIyLzEwLzIxIDExOjQyLCBYaWFudGlu
ZyBUaWFuIHdyb3RlOgo+Pj4g5ZyoIDIwMjIvMTAvMjEg5LiK5Y2IMTA6MTcsIEhBR0lPIEtBWlVI
SVRPKOiQqeWwviDkuIDku4EpIOWGmemBkzoKPj4+PiBPbiAyMDIyLzEwLzIwIDEwOjUwLCBYaWFu
dGluZyBUaWFuIHdyb3RlOgo+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9SRUFETUUgYi9SRUFETUUK
Pj4+Pj4gaW5kZXggNWFiYmNlMS4uZDU4OWU3MiAxMDA2NDQKPj4+Pj4gLS0tIGEvUkVBRE1FCj4+
Pj4+ICsrKyBiL1JFQURNRQo+Pj4+PiBAQCAtMzcsNyArMzcsNyBAQAo+Pj4+PiAgICAgICBUaGVz
ZSBhcmUgdGhlIGN1cnJlbnQgcHJlcmVxdWlzaXRlczoKPj4+Pj4gICAgICAgbyAgQXQgdGhpcyBw
b2ludCwgeDg2LCBpYTY0LCB4ODZfNjQsIHBwYzY0LCBwcGMsIGFybSwgYXJtNjQsIGFscGhhLCBt
aXBzLAo+Pj4+PiAtICAgICBtaXBzNjQsIHMzOTAgYW5kIHMzOTB4LWJhc2VkIGtlcm5lbHMgYXJl
IHN1cHBvcnRlZC4gIE90aGVyIGFyY2hpdGVjdHVyZXMKPj4+Pj4gKyAgICAgbWlwczY0LCByaXNj
djY0LCBzMzkwIGFuZCBzMzkweC1iYXNlZCBrZXJuZWxzIGFyZSBzdXBwb3J0ZWQuICBPdGhlciBh
cmNoaXRlY3R1cmVzCj4+Pj4+ICAgICAgICAgIG1heSBiZSBhZGRyZXNzZWQgaW4gdGhlIGZ1dHVy
ZS4KPj4+PiBTZW50ZW5jZXMgaW4gdGhlIFJFQURNRSBhcmUgd3JhcHBlZCB3aXRoaW4gODAgY2hh
cmFjdGVycywgSSB3aWxsIGNoYW5nZQo+Pj4gdGhhbmtzLAo+Pj4KPj4+IERvIHlvdSBuZWVkIG1l
IHRvIHNlbmQgVjUgcGF0Y2ggc2V0IHRvIGZpeCB0aGlzPwo+PiBObywgSSB3aWxsIGFtZW5kIHRo
ZXNlIHdoZW4gYXBwbHlpbmcuCj4+Cj4gT24gdGhlIGtlcm5lbCBzaWRlLCBzb21lIHJlbGV2YW50
IGtlcm5lbCBwYXRjaGVzIGdvdCBhY2ssICBpdCBzZWVtcwo+IHRoZXkgd29uJ3QgIGNoYW5nZSBh
bnltb3JlLgo+Cj4gQW5kIHRoZSBWNCBsb29rcyBnb29kIHRvIG1lLCBzbzogQWNrLgpUaGFua3Ms
wqAgTGludXgga2VucmVsIFJJU0MtViBtYWludGFpbmVyIHN0aWxsIGRvbid0IGFwcGx5IHRoZSBr
ZXJuZWwgCnBhdGNoLMKgIGxldCdzIHdhaXQuCj4KPiBUaGFua3MuCj4gTGlhbmJvCj4KPj4gVGhh
bmtzLAo+PiBLYXp1Cj4+Cj4+Pj4gdGhpcyB0bzoKPj4+Pgo+Pj4+ICsgICAgIG1pcHM2NCwgcmlz
Y3Y2NCwgczM5MCBhbmQgczM5MHgtYmFzZWQga2VybmVscyBhcmUgc3VwcG9ydGVkLiAgT3RoZXIK
Pj4+PiArICAgICBhcmNoaXRlY3R1cmVzIG1heSBiZSBhZGRyZXNzZWQgaW4gdGhlIGZ1dHVyZS4K
Pj4+Pgo+Pj4+PiAgICAgICBvICBPbmUgc2l6ZSBmaXRzIGFsbCAtLSB0aGUgdXRpbGl0eSBjYW4g
YmUgcnVuIG9uIGFueSBMaW51eCBrZXJuZWwgdmVyc2lvbgo+Pj4+PiBAQCAtOTgsNiArOTgsOCBA
QAo+Pj4+PiAgICAgICAgICBhcm02NCBkdW1wZmlsZXMgbWF5IGJlIGJ1aWx0IGJ5IHR5cGluZyAi
bWFrZSB0YXJnZXQ9QVJNNjQiLgo+Pj4+PiAgICAgICBvICBPbiBhbiB4ODZfNjQgaG9zdCwgYW4g
eDg2XzY0IGJpbmFyeSB0aGF0IGNhbiBiZSB1c2VkIHRvIGFuYWx5emUKPj4+Pj4gICAgICAgICAg
cHBjNjRsZSBkdW1wZmlsZXMgbWF5IGJlIGJ1aWx0IGJ5IHR5cGluZyAibWFrZSB0YXJnZXQ9UFBD
NjQiLgo+Pj4+PiArICBvICBPbiBhbiB4ODZfNjQgaG9zdCwgYW4geDg2XzY0IGJpbmFyeSB0aGF0
IGNhbiBiZSB1c2VkIHRvIGFuYWx5emUKPj4+Pj4gKyAgICAgcmlzY3Y2NCBkdW1wZmlsZXMgbWF5
IGJlIGJ1aWx0IGJ5IHR5cGluZyAibWFrZSB0YXJnZXQ9UklTQ1Y2NCIuCj4+Pj4+ICAgICAgIFRy
YWRpdGlvbmFsbHkgd2hlbiB2bWNvcmVzIGFyZSBjb21wcmVzc2VkIHZpYSB0aGUgbWFrZWR1bXBm
aWxlKDgpIGZhY2lsaXR5Cj4+Pj4+ICAgICAgIHRoZSBsaWJ6IGNvbXByZXNzaW9uIGxpYnJhcnkg
aXMgdXNlZCwgYW5kIGJ5IGRlZmF1bHQgdGhlIGNyYXNoIHV0aWxpdHkKPj4+Pj4gZGlmZiAtLWdp
dCBhL2hlbHAuYyBiL2hlbHAuYwo+Pj4+PiBpbmRleCA5OTIxNGMxLi4yNTNjNzFiIDEwMDY0NAo+
Pj4+PiAtLS0gYS9oZWxwLmMKPj4+Pj4gKysrIGIvaGVscC5jCj4+Pj4+IEBAIC05NTEyLDcgKzk1
MTIsNyBAQCBjaGFyICpSRUFETUVbXSA9IHsKPj4+Pj4gICAgICIgIFRoZXNlIGFyZSB0aGUgY3Vy
cmVudCBwcmVyZXF1aXNpdGVzOiAiLAo+Pj4+PiAgICAgIiIsCj4+Pj4+ICAgICAiICBvICBBdCB0
aGlzIHBvaW50LCB4ODYsIGlhNjQsIHg4Nl82NCwgcHBjNjQsIHBwYywgYXJtLCBhcm02NCwgYWxw
aGEsIG1pcHMsIiwKPj4+Pj4gLSIgICAgIG1pcHM2NCwgczM5MCBhbmQgczM5MHgtYmFzZWQga2Vy
bmVscyBhcmUgc3VwcG9ydGVkLiAgT3RoZXIgYXJjaGl0ZWN0dXJlcyIsCj4+Pj4+ICsiICAgICBt
aXBzNjQsIHJpc2N2NjQsIHMzOTAgYW5kIHMzOTB4LWJhc2VkIGtlcm5lbHMgYXJlIHN1cHBvcnRl
ZC4gIE90aGVyIGFyY2hpdGVjdHVyZXMiLAo+Pj4+PiAgICAgIiAgICAgbWF5IGJlIGFkZHJlc3Nl
ZCBpbiB0aGUgZnV0dXJlLiIsCj4+Pj4+ICAgICAiIiwKPj4+Pj4gICAgICIgIG8gIE9uZSBzaXpl
IGZpdHMgYWxsIC0tIHRoZSB1dGlsaXR5IGNhbiBiZSBydW4gb24gYW55IExpbnV4IGtlcm5lbCB2
ZXJzaW9uIiwKPj4+PiBTYW1lIGFzIGFib3ZlLgo+Pj4+Cj4+Pj4gQW5kIGhlbHAuYyBsYWNrcyB0
aGlzIHBhcnQsIHdpbGwgYWRkOgo+Pj4+Cj4+Pj4gQEAgLTk1NzIsNiArOTU3Miw4IEBAIFJFQURN
RV9FTlRFUl9ESVJFQ1RPUlksCj4+Pj4gICAgICIgICAgIGFybTY0IGR1bXBmaWxlcyBtYXkgYmUg
YnVpbHQgYnkgdHlwaW5nIFwibWFrZSB0YXJnZXQ9QVJNNjRcIi4iLAo+Pj4+ICAgICAiICBvICBP
biBhbiB4ODZfNjQgaG9zdCwgYW4geDg2XzY0IGJpbmFyeSB0aGF0IGNhbiBiZSB1c2VkIHRvIGFu
YWx5emUiLAo+Pj4+ICAgICAiICAgICBwcGM2NGxlIGR1bXBmaWxlcyBtYXkgYmUgYnVpbHQgYnkg
dHlwaW5nIFwibWFrZSB0YXJnZXQ9UFBDNjRcIi4iLAo+Pj4+ICsiICBvICBPbiBhbiB4ODZfNjQg
aG9zdCwgYW4geDg2XzY0IGJpbmFyeSB0aGF0IGNhbiBiZSB1c2VkIHRvIGFuYWx5emUiLAo+Pj4+
ICsiICAgICByaXNjdjY0IGR1bXBmaWxlcyBtYXkgYmUgYnVpbHQgYnkgdHlwaW5nIFwibWFrZSB0
YXJnZXQ9UklTQ1Y2NFwiLiIsCj4+Pj4gICAgICIiLAo+Pj4+ICAgICAiICBUcmFkaXRpb25hbGx5
IHdoZW4gdm1jb3JlcyBhcmUgY29tcHJlc3NlZCB2aWEgdGhlIG1ha2VkdW1wZmlsZSg4KSBmYWNp
bGl0eSIsCj4+Pj4gICAgICIgIHRoZSBsaWJ6IGNvbXByZXNzaW9uIGxpYnJhcnkgaXMgdXNlZCwg
YW5kIGJ5IGRlZmF1bHQgdGhlIGNyYXNoIHV0aWxpdHkiLAo+Pj4+Cj4+Pj4KPj4+PiBXaXRoIHRo
ZXNlLCB0aGUgdjQgY3Jhc2ggcGF0Y2ggc2V0IGxvb2tzIGdvb2QgdG8gbWUuCj4+Pj4KPj4+PiBB
Y2tlZC1ieTogS2F6dWhpdG8gSGFnaW8gPGstaGFnaW8tYWJAbmVjLmNvbT4KPj4+Pgo+Pj4+IFRo
YW5rcywKPj4+PiBLYXp1CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
