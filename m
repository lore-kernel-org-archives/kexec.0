Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA97C001B0
	for <kexec@archiver.kernel.org>; Wed, 19 Jul 2023 06:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TjNxvZ04vDdsby6ZamL7Owucqw7TLCj56AH4Swe7pXA=; b=mWMrMhY/+RVsJr
	2qSswOQ9KpTjq/9M4TlZo8qh1du8KLIntihaFTQTRhj8u+YSbx9neg1K6qVgsBEih23wu7daVEklw
	UaojwKntN3qWxlvHNnCNp3/cbLpueO42R51BIcLNqt7RBiT1+3fYgFlSvnyAuVBEmTqK8N0Ug4fx3
	r/5NYY7lfy2oQonyWECOUccaUk+HH3CNQbSkiBdxz4uL98Kn4x6FyfmTNdK2Ghj9sa9ZtSx7vM4YJ
	H/B2ShI4VFi+ImZDOu77UULDZOdw9po5vqou64fITUeiqMHe9VrZGsxNnMNkmZcMC4AhbVfSwaTs7
	ibKx+a59LslMB8m9OSNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM13x-005x1o-1q;
	Wed, 19 Jul 2023 06:53:29 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM13v-005x0O-2I
	for kexec@bombadil.infradead.org;
	Wed, 19 Jul 2023 06:53:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=4yHx4HrfZqQeQHE9vX1YoGZ33C2Py0gSDsJKBhg4K6M=; b=nXZddxCIHTDBbbEoTRgNxk8jUQ
	qAhwclD4nmJkQqn4PlskfAFsPMZNWw6RflJ1toKU9x/dm+hso3hvtq70fqiSnu0XP0NwanzpTgwUe
	YFNADk7+NjrMvYtrQ9SVRaA1xNUfCZ8gU5byGIhv/cDKlgxzlgVTQJbZt5r1RNKWgGDVqTShs/TV6
	RDM+QZSs8fY6g8M4JBkjwYascp9EL11T868RYjK+ha/EiSetS4pYliq5/5X6CEIU1EizCjoKf9fUA
	XS9CQQ1er14x/jWSP5t7CveyhZao72uprS23H62u29tUy2cH0ZoMHU3LKKgkpH1M8qorPsqwUOcKW
	YpaGvzfw==;
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qLhCa-00BMnM-2w
	for kexec@lists.infradead.org;
	Tue, 18 Jul 2023 09:41:08 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VnhEuq-_1689673217;
Received: from 30.221.101.185(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VnhEuq-_1689673217)
          by smtp.aliyun-inc.com;
          Tue, 18 Jul 2023 17:40:33 +0800
Message-ID: <a416d394-ecf8-f6a5-3227-1f5ade206363@linux.alibaba.com>
Date: Tue, 18 Jul 2023 17:40:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH V2] RISC-V: Add support for riscv kexec/kdump on
 kexec-tools
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>,
 Guo Ren <guoren@kernel.org>
Cc: "xianting_100@126.com" <xianting_100@126.com>,
 Simon Horman <horms@kernel.org>, kexec@lists.infradead.org, wefu@redhat.com,
 yixun.lan@gmail.com, Baoquan He <bhe@redhat.com>
References: <20221020031548.47587-1-xianting.tian@linux.alibaba.com>
 <Y1K6TsGGC3KnFlf8@vergenet.net>
 <44c6ec02-ab91-a9ba-a0b8-fed6b93b82d4@linux.alibaba.com>
 <c87af556-1996-bc22-52da-1da23761d591@linux.alibaba.com>
 <ZCD2wkLCIAztKb/C@MiWiFi-R3L-srv>
 <CAJF2gTQgZZDgh384E_a1AavzQwt04F46G=EPAWMprqDgkNua0A@mail.gmail.com>
 <20230718113726.07c1f500@meshulam.tesarici.cz>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <20230718113726.07c1f500@meshulam.tesarici.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230718_104105_501533_8B0D4C77 
X-CRM114-Status: GOOD (  18.05  )
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

CuWcqCAyMDIzLzcvMTgg5LiL5Y2INTozNywgUGV0ciBUZXNhxZnDrWsg5YaZ6YGTOgo+IE9uIE1v
biwgMjcgTWFyIDIwMjMgMTY6Mjc6NTYgKzA4MDAKPiBHdW8gUmVuIDxndW9yZW5Aa2VybmVsLm9y
Zz4gd3JvdGU6Cj4KPj4gRi5ZLkkKPj4KPj4geGlhbnRpbmdfMTAwQDEyNi5jb20KPj4KPj4gT24g
TW9uLCBNYXIgMjcsIDIwMjMgYXQgOTo1MuKAr0FNIEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29t
PiB3cm90ZToKPj4+IEhpIFhpYW50aW5nLAo+Pj4KPj4+IE9uIDEwLzI2LzIyIGF0IDEwOjU5YW0s
IFhpYW50aW5nIFRpYW4gd3JvdGU6Cj4+Pj4g5ZyoIDIwMjIvMTAvMjYg5LiK5Y2IMTA6MTMsIFhp
YW50aW5nIFRpYW4g5YaZ6YGTOgo+Pj4+PiBIaSBTaW1vbgo+Pj4+Pgo+Pj4+PiB0aGFua3MgZm9y
IHRoZSBjb21tZW50cwo+Pj4+Pgo+Pj4+PiDlnKggMjAyMi8xMC8yMSDkuIvljYgxMToyNywgU2lt
b24gSG9ybWFuIOWGmemBkzoKPj4+Pj4+IE9uIFRodSwgT2N0IDIwLCAyMDIyIGF0IDExOjE1OjQ4
QU0gKzA4MDAsIFhpYW50aW5nIFRpYW4gd3JvdGU6Cj4+Pj4+Pj4gRnJvbTogTmljayBLb3NzaWZp
ZGlzIDxtaWNrQGljcy5mb3J0aC5ncj4KPj4+Pj4+Pgo+Pj4+Pj4+IFRoaXMgcGF0Y2ggYWRkcyBz
dXBwb3J0IGZvciBsb2FkaW5nIHRoZSBFTEYga2VybmVsIGltYWdlLiBJdCBwYXJzZXMKPj4+Pj4+
PiB0aGUgY3VycmVudC9wcm92aWRlZCBkZXZpY2UgdHJlZSB0byBkZXRlcm1pbmUgdGhlIHN5c3Rl
bSdzIG1lbW9yeQo+Pj4+Pj4+IGxheW91dCwgYW5kIC9wcm9jL2lvbWVtIGZvciB0aGUgdmFyaW91
cyBrZXJuZWwgc2VnbWVudHMuCj4+Pj4+Pj4KPj4+Pj4+PiBUaGlzIHBhdGNoIHdhcyBmaXJzdGx5
IGRldmVsb3BlZCBieSBOaWNrIEtvc3NpZmlkaXMsIGFuZCB0d28gZml4ZXMgKAo+Pj4+Pj4+ICAg
ICAgMTogZmFpbCB0byBmaW5kIGZyZWUgbWVtb3J5IGFyZWEgZm9yIGR0YiBsb2FkIHdoZW4gdXNp
bmcKPj4+Pj4+PiBpbml0cmQgaW1hZ2UsCj4+Pj4+Pj4gbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBl
cm1haWwvbGludXgtcmlzY3YvMjAyMi1BdWd1c3QvMDE4Mzk4Lmh0bWw7Cj4+Pj4+Pj4gICAgICAy
OiBmaXggbWVtb3J5IHJhbmdlIHNpemUgY2FsY3VsYXRpb24sCj4+Pj4+Pj4gICAgICAgICAga2V4
ZWMvYXJjaC9yaXNjdi9jcmFzaGR1bXAtcmlzY3YuYzpsaW5lIDg1Cj4+Pj4+Pj4gKSBhcmUgY29u
dHJpYnV0ZWQgYnkgWWl4dW4gTGFuLCBYaWFudGluZyBUaWFuLgo+Pj4+Pj4+Cj4+Pj4+Pj4gVGVz
dGVkIG9uIFFlbXUncyBydjY0IHZpcnQgbWFjaGluZSBhbmQgU29DIG9mIFQtSGVhZCBSSVNDLVYK
Pj4+Pj4+PiBYdWFudGllIDkxMCBDUFUuCj4+Pj4+PiBIaSwKPj4+Pj4+Cj4+Pj4+PiB0aGFua3Mg
Zm9yIHNvbWUgcGF0Y2guCj4+Pj4+Pgo+Pj4+Pj4gU29tZSBtaW5vciBmZWVkYmFjayBmb2xsb3dz
Lgo+Pj4+Pj4KPj4+Pj4+IFNlcGFyYXRlbHksIEknbGwgcG9zdCBhIHBhdGNoIHRvIGFkZCBSSVND
LVYgYnVpbGRzIHRvIHRoZSBnaXRodWIKPj4+Pj4+IHdvcmtmbG93LiBJZiB5b3UgY291bGQgaW5j
bHVkZSB0aGF0IGluIFYzIEknZCBiZSBtb3N0IGdyYXRlZnVsLgo+Pj4+Pj4gICAKPj4+Pj4+PiBU
ZXN0ZWQtYnk6IFlpeHVuIExhbiA8eWl4dW4ubGFuQGdtYWlsLmNvbT4KPj4+Pj4+PiBDby1kZXZl
bG9wZWQtYnk6IFhpYW50aW5nIFRpYW4gPHhpYW50aW5nLnRpYW5AbGludXguYWxpYmFiYS5jb20+
Cj4+Pj4+Pj4gQ28tZGV2ZWxvcGVkLWJ5OiBZaXh1biBMYW4gPHlpeHVuLmxhbkBnbWFpbC5jb20+
Cj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogTmljayBLb3NzaWZpZGlzIDxtaWNrQGljcy5mb3J0aC5n
cj4KPj4+Pj4+IC4uLgo+Pj4+Pj4gICAKPj4+Pj4+PiArICAgIHJldCA9IG1lbV9yZWdpb25zX2Fs
bG9jX2FuZF9hZGQobWVtX3Jhbmdlcywgc3RhcnQsCj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgZW5kIC0gc3RhcnQsIHR5cGUpOwo+Pj4+Pj4gbWVtX3JlZ2lvbnNfYWxsb2NfYW5kX2FkZCBp
c24ndCBhbHdheXMgYXZhaWxhYmxlLgo+Pj4+Pj4gZi5lLiBvbiBtaXBzIHRoaXMgY2F1c2VzIGEg
YnVpbGQgZmFpbHVyZS4KPj4+Pj4+Cj4+Pj4+PiBSZWY6IGh0dHBzOi8vZ2l0aHViLmNvbS9ob3Jt
cy9rZXhlYy10b29scy9hY3Rpb25zL3J1bnMvMzI5ODQ5MTE0My9qb2JzLzU0NDA2Nzc1OTUKPj4+
Pj4gQXMgeW91IGtub3csIG1lbV9yZWdpb25zX3NvcnQsIG1lbV9yZWdpb25zX2FsbG9jX2FuZF9h
ZGQgYXJlIHRoZSBjb21tb24KPj4+Pj4gZnVudGlvbnMsCj4+Pj4+Cj4+Pj4+IFRoZSBidWlsZCBl
cnJvciBvZiBtaXBzIGlzIGNhdXNlZCBieSB0aGlzIHJpc2N2IHBhdGNoPwo+Pj4+Pgo+Pj4+PiBr
ZXhlYy9tZW1fcmVnaW9ucy5jOnZvaWQgbWVtX3JlZ2lvbnNfc29ydChzdHJ1Y3QgbWVtb3J5X3Jh
bmdlcyAqcmFuZ2VzKQo+Pj4+PiBrZXhlYy9tZW1fcmVnaW9ucy5oOnZvaWQgbWVtX3JlZ2lvbnNf
c29ydChzdHJ1Y3QgbWVtb3J5X3JhbmdlcyAqcmFuZ2VzKTsKPj4+Pj4KPj4+Pj4KPj4+Pj4ga2V4
ZWMvbWVtX3JlZ2lvbnMuYzppbnQgbWVtX3JlZ2lvbnNfYWxsb2NfYW5kX2FkZChzdHJ1Y3QgbWVt
b3J5X3Jhbmdlcwo+Pj4+PiAqcmFuZ2VzLAo+Pj4+PiBrZXhlYy9tZW1fcmVnaW9ucy5oOmludCBt
ZW1fcmVnaW9uc19hbGxvY19hbmRfYWRkKHN0cnVjdCBtZW1vcnlfcmFuZ2VzCj4+Pj4+ICpyYW5n
ZXMsCj4+Pj4+ICAgCj4+Pj4+PiAuLi4KPj4+Pj4+ICAgCj4+Pj4+Pj4gK2ludCBkdGJfZ2V0X21l
bW9yeV9yYW5nZXMoY2hhciAqZHRiLCBzdHJ1Y3QgbWVtb3J5X3Jhbmdlcwo+Pj4+Pj4+ICptZW1f
cmFuZ2VzLCBzdHJ1Y3QgbWVtb3J5X3JhbmdlcyAqZXh0cmFfcmFuZ2VzKQo+Pj4+Pj4+ICt7Cj4+
Pj4+PiAuLi4KPj4+Pj4+ICAgCj4+Pj4+Pj4gKyAgICBtZW1fcmVnaW9uc19zb3J0KG1lbV9yYW5n
ZXMpOwo+Pj4+Pj4gTGlrZXdpc2UsIG1lbV9yZWdpb25zX3NvcnQgaXNuJ3QgYWx3YXlzIGF2YWls
YWJsZS4KPj4+Pj4+IGYuZS4gb24gbWlwcyB0aGlzIGNhdXNlcyBhIGJ1aWxkIGZhaWx1cmUuCj4+
Pj4+Pgo+Pj4+Pj4gLi4uCj4+Pj4+PiAgIAo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9wdXJnYXRvcnkv
YXJjaC9yaXNjdi9NYWtlZmlsZQo+Pj4+Pj4+IGIvcHVyZ2F0b3J5L2FyY2gvcmlzY3YvTWFrZWZp
bGUKPj4+Pj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+Pj4+Pj4+IGluZGV4IDAwMDAwMDAuLjhi
ZGVkNzEKPj4+Pj4+PiAtLS0gL2Rldi9udWxsCj4+Pj4+Pj4gKysrIGIvcHVyZ2F0b3J5L2FyY2gv
cmlzY3YvTWFrZWZpbGUKPj4+Pj4+PiBAQCAtMCwwICsxLDcgQEAKPj4+Pj4+PiArIwo+Pj4+Pj4+
ICsjIFB1cmdhdG9yeSByaXNjdgo+Pj4+Pj4+ICsjCj4+Pj4+Pj4gKwo+Pj4+Pj4+ICtyaXNjdl9Q
VVJHQVRPUllfU1JDUyA9Cj4+Pj4+Pj4gKwo+Pj4+Pj4+ICtkaXN0ICs9IHB1cmdhdG9yeS9hcmNo
L3NoL01ha2VmaWxlICQocmlzY3ZfUFVSR0FUT1JZX1NSQ1MpCj4+Pj4+PiBzL3NoL3Jpc2N2Lwo+
Pj4+Pj4KPj4+Pj4+IEVsc2UgdGhlIGRpc3RyaWJ1dGlvbiB0YXJiYWxsIHdvbid0IGluY2x1ZGUg
dGhpcyBNYWtlZmlsZQo+Pj4+Pj4KPj4+Pj4+IFlvdSBjYW4gZXhlcmNpc2UgdGhpcyB1c2luZzoK
Pj4+Pj4+ICAgICBtYWtlIGRpc3RjaGVjayBESVNUQ0hFQ0tfQ09ORklHVVJFX0ZMQUdTPSItLWhv
c3Q9cmlzY3Y2NC1saW51eC1nbnUiCj4+Pj4+IHRoYW5rcywgSSB3aWxsIGZpeCB0aGlzLgo+Pj4+
IHRoZSBmaXggaXMgaW4gbXkgcGVyc29uYWwgZ2l0ZWUKPj4+Pgo+Pj4+IGh0dHBzOi8vZ2l0ZWUu
Y29tL3hpYW50aW5nLXRpYW4va2V4ZWMtdG9vbHMvY29tbWl0cy9tYXN0ZXIKPj4+IElzIHRoaXMg
cGF0Y2hzZXQgcmVwb3N0aW5nIHN0aWxsIGluIHlvdXIgd29ya2luZyBwbGFuPyBJIGRvbid0IHNl
ZSB0aGUKPj4+IGNvZGUgaW4ga2V4ZS10b29scywgc28gcGluZyB0byBhc2suCj4+Pgo+Pj4gSWYg
dGhpcyBpcyBub3QgeW91ciB3b3JrIHRhc2tzIGFueSBtb3JlLCBwZW9wbGUgaW50ZXJlc3RlZCBj
YW4gcGljayB0aGlzCj4+PiBwYXRjaHNldCBhbmQgcG9zdCBhZnRlciBwb2xpc2hpbmcuCj4gTm93
IGl0IHNlZW1zIEkgYW0gaW50ZXJlc3RlZC4gRllJIG15IHBsYW4gaXMgdG8gc3RhcnQgd29ya2lu
ZyBvbiB0aGlzCj4gaWYgdGhlcmUgaXMgbm8gZnVydGhlciByZWFjdGlvbiBmcm9tIGFueWJvZHkg
ZWxzZSB3aXRoaW4gYSBmb3J0bmlnaHQuCkdvb2QsIHBsZWFzZSBmZWVsIGZyZWUgdG8gZG8gaXQu
Cj4KPiBQZXRyIFQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
