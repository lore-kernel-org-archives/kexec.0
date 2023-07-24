Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57398C001B0
	for <kexec@archiver.kernel.org>; Mon, 24 Jul 2023 09:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UqeNtZNSc/A39bpg7IxVsz7adPO78RRg1a5rQwJLXmc=; b=XdJ8x7IpD7XHV+
	M1uh8swGTJbpyCVF+BbxE1RYBUs/+mRRTtmbJxrOCmcbfH47Gx49ZY7F/EPMr3yV6/i8YqY8SP27I
	BBQE2aNnTgJhrTRpNN6B5eM08rVO3FBR4qJDG+YCPh+xSBvdSITxqb1qMcU8mDs2VmB6fpljlbFyT
	LWg+2as2ZJy/jeZkMkXTewWwBDNnlUD+WBNyaacQfRGDkFvWRKMhP3enAF4jviDUNCd3F2gxstpYC
	+UpaJ/U/Qm75JGAhOgGYXvv5JZPtLxDJ2LrQilDBnsxoNNHahYUnrqVT4BUN0+5n/ZbQJUz074wB+
	IHPpOW6nWQHL/yue8B0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrcK-003MQt-1Y;
	Mon, 24 Jul 2023 09:12:36 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrcG-003MQF-2J
	for kexec@lists.infradead.org;
	Mon, 24 Jul 2023 09:12:35 +0000
Received: from kwepemm600006.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R8Z9q1MFGzHqhN;
	Mon, 24 Jul 2023 17:09:51 +0800 (CST)
Received: from [10.174.177.30] (10.174.177.30) by
 kwepemm600006.china.huawei.com (7.193.23.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 17:12:23 +0800
Message-ID: <92e2a8ca-cd3f-7db5-c0cf-03a72695524d@huawei.com>
Date: Mon, 24 Jul 2023 17:12:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] kexec_lock:Fix comment for kexec_lock
To: Baoquan He <bhe@redhat.com>
CC: <kexec@lists.infradead.org>, <linux-integrity@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <ebiederm@xmission.com>,
	<zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>, <paul@paul-moore.com>,
	<jmorris@namei.org>, <serge@hallyn.com>
References: <26ff12fe-347b-d908-0327-73cf3c83b00b@huawei.com>
 <ZL405LGPVa6lOl5s@MiWiFi-R3L-srv>
From: "Wenyu Liu(D)" <liuwenyu7@huawei.com>
In-Reply-To: <ZL405LGPVa6lOl5s@MiWiFi-R3L-srv>
X-Originating-IP: [10.174.177.30]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600006.china.huawei.com (7.193.23.105)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_021232_966708_0E7038DF 
X-CRM114-Status: GOOD (  14.64  )
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

VGhhbmtzIGZvciB0aGUgdGlwcywgSSB3aWxsIHBvc3QgYSBuZXcgb25lIGxhdGVyCgrlnKggMjAy
My83LzI0IDE2OjIzLCBCYW9xdWFuIEhlIOWGmemBkzoKPiBPbiAwNy8yNC8yMyBhdCAxMTo0NWFt
LCBXZW55dSBMaXUoRCkgd3JvdGU6Cj4+IGtleGVjX211dGV4IGlzIHJlcGxhY2VkIGJ5IGFuIGF0
b21pYyB2YXJpYWJsZSBpbgo+PiA1NjMxNGI5MGZkNDNiZDI0NDQgKHBhbmljLCBrZXhlYzogbWFr
ZSBfX2NyYXNoX2tleGVjKCkgTk1JIHNhZmUpLgo+IAo+IFlvdSBjb3VsZCB1c2UgYSBkaXN0cm9z
IGtlcm5lbCBvciBjdXN0b21pemVkIGtlcm5lbCBhbmQgbWFkZSBjaGFuZ2UKPiBiYXNlZCBvbiB0
aGF0LiBUaGUgY29tbWl0IGlkIGlzbid0IGNvcnJlY3QuIEkgcGFzdGVkIHRoZSByaWdodCBvbmUK
PiBhdCBiZWxvdy4KPiAKPiBjb21taXQgMDVjNjI1NzQzM2IgKCJwYW5pYywga2V4ZWM6IG1ha2Ug
X19jcmFzaF9rZXhlYygpIE5NSSBzYWZlIikKPiAKPiBPdGhlciB0aGFuIHRoaXMsIHRoaXMgbG9v
a3MgZ29vZC4gWW91IGNhbiBwb3N0IGEgbmV3IG9uZSB3aXRoIG15IGFjay4KPiAKPiBBY2tlZC1i
eTogQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+Cj4gCj4+Cj4+IEZpeCBzb21lIGNvbW1lbnQg
dGhhdCBzdGlsbCB1c2luZyBrZXhlY19tdXRleC4KPj4KPj4gU2lnbmVkLW9mZi1ieTogV2VueXUg
TGl1ICA8bGl1d2VueXU3QGh1YXdlaS5jb20+Cj4+IC0tLQo+PiAga2VybmVsL2tleGVjX2ZpbGUu
YyAgICAgICAgICAgICAgICB8IDIgKy0KPj4gIHNlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2tl
eGVjLmMgfCAyICstCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9rZXhlY19maWxlLmMgYi9rZXJuZWwv
a2V4ZWNfZmlsZS5jCj4+IGluZGV4IDg4MWJhMGQxNzE0Yy4uYjViYmIyZmUwNjY4IDEwMDY0NAo+
PiAtLS0gYS9rZXJuZWwva2V4ZWNfZmlsZS5jCj4+ICsrKyBiL2tlcm5lbC9rZXhlY19maWxlLmMK
Pj4gQEAgLTYyNCw3ICs2MjQsNyBAQCBpbnQga2V4ZWNfbG9jYXRlX21lbV9ob2xlKHN0cnVjdCBr
ZXhlY19idWYgKmtidWYpCj4+ICAgKiBrZXhlY19hZGRfYnVmZmVyIC0gcGxhY2UgYSBidWZmZXIg
aW4gYSBrZXhlYyBzZWdtZW50Cj4+ICAgKiBAa2J1ZjogIEJ1ZmZlciBjb250ZW50cyBhbmQgbWVt
b3J5IHBhcmFtZXRlcnMuCj4+ICAgKgo+PiAtICogVGhpcyBmdW5jdGlvbiBhc3N1bWVzIHRoYXQg
a2V4ZWNfbXV0ZXggaXMgaGVsZC4KPj4gKyAqIFRoaXMgZnVuY3Rpb24gYXNzdW1lcyB0aGF0IGtl
eGVjX2xvY2sgaXMgaGVsZC4KPj4gICAqIE9uIHN1Y2Nlc3NmdWwgcmV0dXJuLCBAa2J1Zi0+bWVt
IHdpbGwgaGF2ZSB0aGUgcGh5c2ljYWwgYWRkcmVzcyBvZgo+PiAgICogdGhlIGJ1ZmZlciBpbiBt
ZW1vcnkuCj4+ICAgKgo+PiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFf
a2V4ZWMuYyBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2tleGVjLmMKPj4gaW5kZXggNDE5
ZGM0MDVjODMxLi5hZDEzM2ZlMTIwZGIgMTAwNjQ0Cj4+IC0tLSBhL3NlY3VyaXR5L2ludGVncml0
eS9pbWEvaW1hX2tleGVjLmMKPj4gKysrIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfa2V4
ZWMuYwo+PiBAQCAtNzcsNyArNzcsNyBAQCBzdGF0aWMgaW50IGltYV9kdW1wX21lYXN1cmVtZW50
X2xpc3QodW5zaWduZWQgbG9uZyAqYnVmZmVyX3NpemUsIHZvaWQgKipidWZmZXIsCj4+ICAgKiBD
YWxsZWQgZHVyaW5nIGtleGVjX2ZpbGVfbG9hZCBzbyB0aGF0IElNQSBjYW4gYWRkIGEgc2VnbWVu
dCB0byB0aGUga2V4ZWMKPj4gICAqIGltYWdlIGZvciB0aGUgbWVhc3VyZW1lbnQgbGlzdCBmb3Ig
dGhlIG5leHQga2VybmVsLgo+PiAgICoKPj4gLSAqIFRoaXMgZnVuY3Rpb24gYXNzdW1lcyB0aGF0
IGtleGVjX211dGV4IGlzIGhlbGQuCj4+ICsgKiBUaGlzIGZ1bmN0aW9uIGFzc3VtZXMgdGhhdCBr
ZXhlY19sb2NrIGlzIGhlbGQuCj4+ICAgKi8KPj4gIHZvaWQgaW1hX2FkZF9rZXhlY19idWZmZXIo
c3RydWN0IGtpbWFnZSAqaW1hZ2UpCj4+ICB7Cj4+IC0tCj4+IDIuMzMuMAo+Pgo+PiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBrZXhlYyBtYWlsaW5n
IGxpc3QKPj4ga2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwo+PiBodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCj4+Cj4gCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCg==
