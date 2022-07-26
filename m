Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6341C00140
	for <kexec@archiver.kernel.org>; Tue, 26 Jul 2022 14:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VYIaGXq4uyxEM8DuksDttwFTYoM8qjRjDPyDWbQjLiU=; b=cQX8zNOnkpq1SZy7Vc5zXuT0Tl
	82h6vB8/lM3jD1liTP/WIeQKQ1f0uYmdZ4dJjfEAjwZDejEAzJPAWijVklHi+TkmOPIl5+AlWvi20
	0mCXG4QAP/zw9fs9jljm8LEefz9OdozjcNZ3saa5AM6/ZcTkeY8ja/zNdYUo5nwluuCNvWnxnNBvY
	B5nh9tglzjpueraQIyCr93a369id1UyL5RLTcKoCb5sNeHhy9jKNoF5Uog10XhPuP4+QKPA3yLRuG
	Zn1p66QVp6ENNCTbgsCN3LZI/cOAsqtWAEi3yLQcdJ1dUsw//BJcJlEL37C907Sif7L6Xu4eCVT6x
	fgnvY3+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGL7k-0001BZ-2J; Tue, 26 Jul 2022 14:01:24 +0000
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGL4p-00HaDx-MG; Tue, 26 Jul 2022 13:58:27 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VKVecKN_1658843892;
Received: from 192.168.1.4(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VKVecKN_1658843892)
          by smtp.aliyun-inc.com;
          Tue, 26 Jul 2022 21:58:14 +0800
Subject: Re: [PATCH V4 0/5] RISC-V fixups to work with crash tool
To: Conor.Dooley@microchip.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
 guoren@kernel.org, mick@ics.forth.gr, alexandre.ghiti@canonical.com,
 bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, corbet@lwn.net
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 crash-utility@redhat.com, huanyi.xj@alibaba-inc.com,
 heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
 hschauhan@nulltrace.org
References: <20220726093729.1231867-1-xianting.tian@linux.alibaba.com>
 <651b552d-8954-e58c-e994-4a9782f1112a@microchip.com>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <0f723ce0-48b4-b31d-e590-94b45cef8fa5@linux.alibaba.com>
Date: Tue, 26 Jul 2022 21:58:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <651b552d-8954-e58c-e994-4a9782f1112a@microchip.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220726_065824_001248_F106B701 
X-CRM114-Status: GOOD (  13.71  )
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

CuWcqCAyMDIyLzcvMjYg5LiL5Y2INTo1MiwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20g5YaZ
6YGTOgo+IE9uIDI2LzA3LzIwMjIgMTA6MzcsIFhpYW50aW5nIFRpYW4gd3JvdGU6Cj4+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQo+IEFoIEkgc2VlIHlvdSd2ZSBhbHJlYWR5IHNl
bnQgYSB2NC4KPgo+PiBDaGFuZ2VzIHYxIC0+IHYyOgo+PiAgICAxLCByZW1vdmUgdGhlIHBhdGNo
ICJBZGQgYSBmYXN0IGNhbGwgcGF0aCBvZiBjcmFzaF9rZXhlYygpIiBmcm9tIHRoaXMgc2VyaWVz
Cj4+ICAgIG9mIHBhdGNoZXMsIGFzIGl0IGFscmVhZHkgYXBwbGllZCB0byByaXNjdiBnaXQuCj4+
ICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Jpc2N2
L2xpbnV4LmdpdC9jb21taXQvP2g9Zm9yLW5leHQmaWQ9M2YxOTAxMTEwYTg5YjBlMmUxM2FkYjJh
YzhkMWE3MTAyODc5ZWE5OAo+PiAgICAyLCBhZGQgJ1Jldmlld2VkLWJ5JyBiYXNlZCBvbiB0aGUg
Y29tbWVudHMgb2YgdjEuCj4+IENoYW5nZXMgdjIgLT4gdjM6Cj4+ICAgIHVzZSAicmlzY3YiIGlu
c3RlYWQgb2YgInJpc2N2NjQiIGluIHBhdGNoIDUgc3ViamVjdCBsaW5lLgo+PiBDaGFuZ2VzIHYz
IC0+IHY0Ogo+PiAgICB1c2UgInJpc2N2IiBpbnN0ZWFkIG9mICJyaXNjdjY0IiBpbiB0aGUgc3Vt
bWFyeSBvZiBwYXRjaCA1IHN1YmplY3QgbGluZS4KPiBUaGVyZSdzIG5vIG5lZWQgdG8gcmVzcGlu
IGEgc2VyaWVzIGZvciB0aGUgc2FrZSAzIGNoYXJhY3RlcnMgaW4gdGhlIGNvdmVyCj4gbGV0dGVy
IChzbyBzb3JyeSBpZiB5b3UgbWlzdW5kZXJzdG9vZCBtZSEpLi4uCj4KPj4gWGlhbnRpbmcgVGlh
biAoNSk6Cj4+ICAgICBSSVNDLVY6IHVzZSBfX3NtcF9wcm9jZXNzb3JfaWQoKSBpbnN0ZWFkIG9m
IHNtcF9wcm9jZXNzb3JfaWQoKQo+PiAgICAgUklTQy1WOiBBZGQgYXJjaF9jcmFzaF9zYXZlX3Zt
Y29yZWluZm8gc3VwcG9ydAo+PiAgICAgcmlzY3Y6IEFkZCBtb2R1bGVzIHRvIHZpcnR1YWwga2Vy
bmVsIG1lbW9yeSBsYXlvdXQgZHVtcAo+PiAgICAgUklTQy1WOiBGaXh1cCBnZXR0aW5nIGNvcnJl
Y3QgY3VycmVudCBwYwo+PiAgICAgcmlzY3Y6IGNyYXNoX2NvcmU6IEV4cG9ydCBrZXJuZWwgdm0g
bGF5b3V0LCBwaHlzX3JhbV9iYXNlCj4gLi4uYnV0IGl0IHdvdWxkJ3ZlIGJlZW4gZ29vZCB0byBh
bGlnbiB0aGVzZSB0byBlaXRoZXIgInJpc2N2OiIgb3IKPiAiUklTQy1WOiIgJiBub3QgbWl4IHRo
ZSB0d28gaW4gYSBzZXJpZXMuIERvbid0IGRvIHRoaXMgcmlnaHQgYXdheSwKPiBpdCBpcyBva2F5
IHRvIHdhaXQgZm9yIG1vcmUgc2lnbmlmaWNhbnQgY2hhbmdlcyBiZWZvcmUgc2VuZGluZyBvdXQK
PiBhIG5ldyB2ZXJzaW9uIGFzIHRoaXMgc29ydCBvZiB0aGluZyBjb3VsZCBlYXNpbHkgYmUgY2hh
bmdlZCB3aGVuCj4gYmVpbmcgYXBwbGllZC4KTWFueSB0aGFua3MsIEkgZ290IGl0LCB3YWl0aW5n
IHRoZXNlIHBhdGNoZXMgdG8gYmUgYXBwbGllZDopCj4KPiBUaGFua3MsCj4gQ29ub3IuCj4KPgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFp
bGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
