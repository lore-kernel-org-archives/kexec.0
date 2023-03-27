Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B163C74A5B
	for <kexec@archiver.kernel.org>; Mon, 27 Mar 2023 01:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QOS8xL874Zgu0F+XHF2Qzt6ysjgQKIjQXRZqa6+FPhw=; b=DmmLmOkPFd/IwK
	SAsLEPp1QPXc+lSrlitrzoVJA1E7U+ORFTUkL1eLWYJZKXmm7IhJUTUejsSwXmYu/UTnhEG0OZzKY
	FChli368XfxBRYWjeO+4UoRHQh87u6jfrgIAq6vG1J8wDD+sspDyoDXrOZnE0eqOXtHeC48jWwyhI
	viteXL+DW4htjS7SvqK7soNFTIM5Lckv6EOK04a5SopXpzfI+9MB4SVEmL6ph8N2bHy2u7nAoZ5wR
	YZcOyJMxA4BHknCVLlq6/uWuuMyOYZRmQ++ufEHQTXF/I8YIv1Hw4Ec0QvczXhi/cVuOgXZ5wUUoS
	j3JdD9Xzwahila/v0NJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgc29-009UnV-0N;
	Mon, 27 Mar 2023 01:52:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgc25-009Umw-1n
	for kexec@lists.infradead.org;
	Mon, 27 Mar 2023 01:52:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679881942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3gXTptLJ3KRhKYSFpQDo115zUyQoPevVeuZn9061tU=;
	b=KVdQc6GNQdjGNi6ZECs2xtewz2VC0DqQEbnpZo0EMx9N19vFZMI2uRJrQB6W16/ZE7ldjc
	p4UHGHuyS2Vd1i/9a2VXkzOQDJdMls/7EPbvpMsulutS516/FBVf/3lOc2gTDpHRDNFJGf
	vdSzX8P6ZwzXK2Y0XlrXTEjmTgOHlQI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-vVbgrHXYN8qYtxahA0cJtw-1; Sun, 26 Mar 2023 21:52:18 -0400
X-MC-Unique: vVbgrHXYN8qYtxahA0cJtw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15D393C0ED47;
	Mon, 27 Mar 2023 01:52:17 +0000 (UTC)
Received: from localhost (ovpn-12-88.pek2.redhat.com [10.72.12.88])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 470C335453;
	Mon, 27 Mar 2023 01:52:15 +0000 (UTC)
Date: Mon, 27 Mar 2023 09:52:02 +0800
From: Baoquan He <bhe@redhat.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Cc: Simon Horman <horms@kernel.org>, kexec@lists.infradead.org,
	wefu@redhat.com, yixun.lan@gmail.com, guoren@kernel.org
Subject: Re: [PATCH V2] RISC-V: Add support for riscv kexec/kdump on
 kexec-tools
Message-ID: <ZCD2wkLCIAztKb/C@MiWiFi-R3L-srv>
References: <20221020031548.47587-1-xianting.tian@linux.alibaba.com>
 <Y1K6TsGGC3KnFlf8@vergenet.net>
 <44c6ec02-ab91-a9ba-a0b8-fed6b93b82d4@linux.alibaba.com>
 <c87af556-1996-bc22-52da-1da23761d591@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <c87af556-1996-bc22-52da-1da23761d591@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_185225_768491_BE011DC1 
X-CRM114-Status: GOOD (  35.98  )
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

SGkgWGlhbnRpbmcsCgpPbiAxMC8yNi8yMiBhdCAxMDo1OWFtLCBYaWFudGluZyBUaWFuIHdyb3Rl
Ogo+IAo+IOWcqCAyMDIyLzEwLzI2IOS4iuWNiDEwOjEzLCBYaWFudGluZyBUaWFuIOWGmemBkzoK
PiA+IEhpIFNpbW9uCj4gPiAKPiA+IHRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzCj4gPiAKPiA+IOWc
qCAyMDIyLzEwLzIxIOS4i+WNiDExOjI3LCBTaW1vbiBIb3JtYW4g5YaZ6YGTOgo+ID4gPiBPbiBU
aHUsIE9jdCAyMCwgMjAyMiBhdCAxMToxNTo0OEFNICswODAwLCBYaWFudGluZyBUaWFuIHdyb3Rl
Ogo+ID4gPiA+IEZyb206IE5pY2sgS29zc2lmaWRpcyA8bWlja0BpY3MuZm9ydGguZ3I+Cj4gPiA+
ID4gCj4gPiA+ID4gVGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIGxvYWRpbmcgdGhlIEVMRiBr
ZXJuZWwgaW1hZ2UuIEl0IHBhcnNlcwo+ID4gPiA+IHRoZSBjdXJyZW50L3Byb3ZpZGVkIGRldmlj
ZSB0cmVlIHRvIGRldGVybWluZSB0aGUgc3lzdGVtJ3MgbWVtb3J5Cj4gPiA+ID4gbGF5b3V0LCBh
bmQgL3Byb2MvaW9tZW0gZm9yIHRoZSB2YXJpb3VzIGtlcm5lbCBzZWdtZW50cy4KPiA+ID4gPiAK
PiA+ID4gPiBUaGlzIHBhdGNoIHdhcyBmaXJzdGx5IGRldmVsb3BlZCBieSBOaWNrIEtvc3NpZmlk
aXMsIGFuZCB0d28gZml4ZXMgKAo+ID4gPiA+IMKgwqDCoCAxOiBmYWlsIHRvIGZpbmQgZnJlZSBt
ZW1vcnkgYXJlYSBmb3IgZHRiIGxvYWQgd2hlbiB1c2luZwo+ID4gPiA+IGluaXRyZCBpbWFnZSwK
PiA+ID4gPiBsaXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9saW51eC1yaXNjdi8yMDIyLUF1
Z3VzdC8wMTgzOTguaHRtbDsKPiA+ID4gPiDCoMKgwqAgMjogZml4IG1lbW9yeSByYW5nZSBzaXpl
IGNhbGN1bGF0aW9uLAo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIGtleGVjL2FyY2gvcmlzY3YvY3Jh
c2hkdW1wLXJpc2N2LmM6bGluZSA4NQo+ID4gPiA+ICkgYXJlIGNvbnRyaWJ1dGVkIGJ5IFlpeHVu
IExhbiwgWGlhbnRpbmcgVGlhbi4KPiA+ID4gPiAKPiA+ID4gPiBUZXN0ZWQgb24gUWVtdSdzIHJ2
NjQgdmlydCBtYWNoaW5lIGFuZCBTb0Mgb2YgVC1IZWFkIFJJU0MtVgo+ID4gPiA+IFh1YW50aWUg
OTEwIENQVS4KPiA+ID4gSGksCj4gPiA+IAo+ID4gPiB0aGFua3MgZm9yIHNvbWUgcGF0Y2guCj4g
PiA+IAo+ID4gPiBTb21lIG1pbm9yIGZlZWRiYWNrIGZvbGxvd3MuCj4gPiA+IAo+ID4gPiBTZXBh
cmF0ZWx5LCBJJ2xsIHBvc3QgYSBwYXRjaCB0byBhZGQgUklTQy1WIGJ1aWxkcyB0byB0aGUgZ2l0
aHViCj4gPiA+IHdvcmtmbG93LiBJZiB5b3UgY291bGQgaW5jbHVkZSB0aGF0IGluIFYzIEknZCBi
ZSBtb3N0IGdyYXRlZnVsLgo+ID4gPiAKPiA+ID4gPiBUZXN0ZWQtYnk6IFlpeHVuIExhbiA8eWl4
dW4ubGFuQGdtYWlsLmNvbT4KPiA+ID4gPiBDby1kZXZlbG9wZWQtYnk6IFhpYW50aW5nIFRpYW4g
PHhpYW50aW5nLnRpYW5AbGludXguYWxpYmFiYS5jb20+Cj4gPiA+ID4gQ28tZGV2ZWxvcGVkLWJ5
OiBZaXh1biBMYW4gPHlpeHVuLmxhbkBnbWFpbC5jb20+Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
TmljayBLb3NzaWZpZGlzIDxtaWNrQGljcy5mb3J0aC5ncj4KPiA+ID4gLi4uCj4gPiA+IAo+ID4g
PiA+ICvCoMKgwqAgcmV0ID0gbWVtX3JlZ2lvbnNfYWxsb2NfYW5kX2FkZChtZW1fcmFuZ2VzLCBz
dGFydCwKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW5k
IC0gc3RhcnQsIHR5cGUpOwo+ID4gPiBtZW1fcmVnaW9uc19hbGxvY19hbmRfYWRkIGlzbid0IGFs
d2F5cyBhdmFpbGFibGUuCj4gPiA+IGYuZS4gb24gbWlwcyB0aGlzIGNhdXNlcyBhIGJ1aWxkIGZh
aWx1cmUuCj4gPiA+IAo+ID4gPiBSZWY6IGh0dHBzOi8vZ2l0aHViLmNvbS9ob3Jtcy9rZXhlYy10
b29scy9hY3Rpb25zL3J1bnMvMzI5ODQ5MTE0My9qb2JzLzU0NDA2Nzc1OTUKPiA+IAo+ID4gQXMg
eW91IGtub3csIG1lbV9yZWdpb25zX3NvcnQsIG1lbV9yZWdpb25zX2FsbG9jX2FuZF9hZGQgYXJl
IHRoZSBjb21tb24KPiA+IGZ1bnRpb25zLAo+ID4gCj4gPiBUaGUgYnVpbGQgZXJyb3Igb2YgbWlw
cyBpcyBjYXVzZWQgYnkgdGhpcyByaXNjdiBwYXRjaD8KPiA+IAo+ID4ga2V4ZWMvbWVtX3JlZ2lv
bnMuYzp2b2lkIG1lbV9yZWdpb25zX3NvcnQoc3RydWN0IG1lbW9yeV9yYW5nZXMgKnJhbmdlcykK
PiA+IGtleGVjL21lbV9yZWdpb25zLmg6dm9pZCBtZW1fcmVnaW9uc19zb3J0KHN0cnVjdCBtZW1v
cnlfcmFuZ2VzICpyYW5nZXMpOwo+ID4gCj4gPiAKPiA+IGtleGVjL21lbV9yZWdpb25zLmM6aW50
IG1lbV9yZWdpb25zX2FsbG9jX2FuZF9hZGQoc3RydWN0IG1lbW9yeV9yYW5nZXMKPiA+ICpyYW5n
ZXMsCj4gPiBrZXhlYy9tZW1fcmVnaW9ucy5oOmludCBtZW1fcmVnaW9uc19hbGxvY19hbmRfYWRk
KHN0cnVjdCBtZW1vcnlfcmFuZ2VzCj4gPiAqcmFuZ2VzLAo+ID4gCj4gPiA+IAo+ID4gPiAuLi4K
PiA+ID4gCj4gPiA+ID4gK2ludCBkdGJfZ2V0X21lbW9yeV9yYW5nZXMoY2hhciAqZHRiLCBzdHJ1
Y3QgbWVtb3J5X3Jhbmdlcwo+ID4gPiA+ICptZW1fcmFuZ2VzLCBzdHJ1Y3QgbWVtb3J5X3Jhbmdl
cyAqZXh0cmFfcmFuZ2VzKQo+ID4gPiA+ICt7Cj4gPiA+IC4uLgo+ID4gPiAKPiA+ID4gPiArwqDC
oMKgIG1lbV9yZWdpb25zX3NvcnQobWVtX3Jhbmdlcyk7Cj4gPiA+IExpa2V3aXNlLCBtZW1fcmVn
aW9uc19zb3J0IGlzbid0IGFsd2F5cyBhdmFpbGFibGUuCj4gPiA+IGYuZS4gb24gbWlwcyB0aGlz
IGNhdXNlcyBhIGJ1aWxkIGZhaWx1cmUuCj4gPiA+IAo+ID4gPiAuLi4KPiA+ID4gCj4gPiA+ID4g
ZGlmZiAtLWdpdCBhL3B1cmdhdG9yeS9hcmNoL3Jpc2N2L01ha2VmaWxlCj4gPiA+ID4gYi9wdXJn
YXRvcnkvYXJjaC9yaXNjdi9NYWtlZmlsZQo+ID4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4g
PiA+ID4gaW5kZXggMDAwMDAwMC4uOGJkZWQ3MQo+ID4gPiA+IC0tLSAvZGV2L251bGwKPiA+ID4g
PiArKysgYi9wdXJnYXRvcnkvYXJjaC9yaXNjdi9NYWtlZmlsZQo+ID4gPiA+IEBAIC0wLDAgKzEs
NyBAQAo+ID4gPiA+ICsjCj4gPiA+ID4gKyMgUHVyZ2F0b3J5IHJpc2N2Cj4gPiA+ID4gKyMKPiA+
ID4gPiArCj4gPiA+ID4gK3Jpc2N2X1BVUkdBVE9SWV9TUkNTID0KPiA+ID4gPiArCj4gPiA+ID4g
K2Rpc3QgKz0gcHVyZ2F0b3J5L2FyY2gvc2gvTWFrZWZpbGUgJChyaXNjdl9QVVJHQVRPUllfU1JD
UykKPiA+ID4gcy9zaC9yaXNjdi8KPiA+ID4gCj4gPiA+IEVsc2UgdGhlIGRpc3RyaWJ1dGlvbiB0
YXJiYWxsIHdvbid0IGluY2x1ZGUgdGhpcyBNYWtlZmlsZQo+ID4gPiAKPiA+ID4gWW91IGNhbiBl
eGVyY2lzZSB0aGlzIHVzaW5nOgo+ID4gPiDCoMKgIG1ha2UgZGlzdGNoZWNrIERJU1RDSEVDS19D
T05GSUdVUkVfRkxBR1M9Ii0taG9zdD1yaXNjdjY0LWxpbnV4LWdudSIKPiA+IHRoYW5rcywgSSB3
aWxsIGZpeCB0aGlzLgo+IAo+IHRoZSBmaXggaXMgaW4gbXkgcGVyc29uYWwgZ2l0ZWUKPiAKPiBo
dHRwczovL2dpdGVlLmNvbS94aWFudGluZy10aWFuL2tleGVjLXRvb2xzL2NvbW1pdHMvbWFzdGVy
CgpJcyB0aGlzIHBhdGNoc2V0IHJlcG9zdGluZyBzdGlsbCBpbiB5b3VyIHdvcmtpbmcgcGxhbj8g
SSBkb24ndCBzZWUgdGhlCmNvZGUgaW4ga2V4ZS10b29scywgc28gcGluZyB0byBhc2suCgpJZiB0
aGlzIGlzIG5vdCB5b3VyIHdvcmsgdGFza3MgYW55IG1vcmUsIHBlb3BsZSBpbnRlcmVzdGVkIGNh
biBwaWNrIHRoaXMKcGF0Y2hzZXQgYW5kIHBvc3QgYWZ0ZXIgcG9saXNoaW5nLgoKVGhhbmtzCkJh
b3F1YW4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpr
ZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
