Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3AEC0015E
	for <kexec@archiver.kernel.org>; Mon, 24 Jul 2023 08:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:Cc:References:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jTJ/v9CKzEmShbMuAR8Tm+ZZPpk/oypijl4ZHIX1gR8=; b=PvrgtvpvzePprB
	MokPQr2CIxwwjKgnrLQbhU0sazEtnpgAXQrShW08zXW7Oa1+NzpdH6hz0ewGhLnIBLcfcYTAL9Zhl
	MFnugNURdcxEVhMGhxcGix4KdfDBgn24opEgsfZQXjdCbF8sWcQ5bRaoD3V2LJD9aBiiJO+/qqwgG
	AMXQVlG/gjK7qqaaGjYps1kohvDGo7tHEdQrXCNxB7FKW6+KKqJKvpYdANq+U3Tu8UoUY7+BeP8Gj
	PbwZ3eQY3M5u5CVlgwJ14gnK9UBw3mTRXa7MG2S7VmjGR+pRtShd+ut7ut0sOyZId+6irRGNh0XgS
	MQ9Y+iqiz2zerQEMNB0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrHG-003JAt-0F;
	Mon, 24 Jul 2023 08:50:50 +0000
Received: from mx3.molgen.mpg.de ([141.14.17.11])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrHB-003J79-2w
	for kexec@lists.infradead.org;
	Mon, 24 Jul 2023 08:50:48 +0000
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9081461E5FE01;
	Mon, 24 Jul 2023 10:49:55 +0200 (CEST)
Message-ID: <e8be33b7-efc2-52b3-35fe-17aca9c8767b@molgen.mpg.de>
Date: Mon, 24 Jul 2023 10:49:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] kexec_lock:Fix comment for kexec_lock
Content-Language: en-US
To: Wenyu Liu <liuwenyu7@huawei.com>
References: <26ff12fe-347b-d908-0327-73cf3c83b00b@huawei.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, ebiederm@xmission.com,
 zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <26ff12fe-347b-d908-0327-73cf3c83b00b@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_015046_115043_C0A07698 
X-CRM114-Status: GOOD (  19.24  )
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

RGVhciBXZW55dSwKCgpUaGFuayB5b3UgZm9yIHlvdXIgcGF0Y2guIFNvbWUgbWlub3IgY29tbWVu
dHMsIHlvdSBjYW4gaWdub3JlLgoKQW0gMjQuMDcuMjMgdW0gMDU6NDUgc2NocmllYiBXZW55dSBM
aXUoRCk6CgpUaGUgKEQpIGxvb2tzIHN0cmFuZ2UuIEF0IGxlYXN0IGEgc3BhY2Ugc2hvdWxkIGJl
IGFkZGVkIGJlZm9yZSB0aGUgKC4KCj4ga2V4ZWNfbXV0ZXggaXMgcmVwbGFjZWQgYnkgYW4gYXRv
bWljIHZhcmlhYmxlIGluCj4gNTYzMTRiOTBmZDQzYmQyNDQ0IChwYW5pYywga2V4ZWM6IG1ha2Ug
X19jcmFzaF9rZXhlYygpIE5NSSBzYWZlKS4KPiAKPiBGaXggc29tZSBjb21tZW50IHRoYXQgc3Rp
bGwgdXNpbmcga2V4ZWNfbXV0ZXguCgpjb21tZW50KnMqCgo+IAo+IFNpZ25lZC1vZmYtYnk6IFdl
bnl1IExpdSAgPGxpdXdlbnl1N0BodWF3ZWkuY29tPgoKRHVlIHRvIHRoZSAoRCkgdGhpcyBkb2Vz
buKAmXQgZXhhY3RseSBtYXRjaCB3aXRoIHRoZSBBdXRob3IgZmllbGQuIFlvdSAKYWxzbyBoYXZl
IHR3byBzcGFjZXMgYmVmb3JlIDwgaW5zdGVhZCBvZiBvbmUuCgpBbHNvIGZvciB0aGUgY29tbWl0
IG1lc3NhZ2Ugc3VtbWFyeSB5b3UgY291bGQgYmUgbW9yZSBzcGVjaWZpYzoKCiA+IGtleGVjX2xv
Y2s6IFJlcGxhY2Uga2V4ZWNfbXV0ZXgoKSBieSBrZXhlY19sb2NrKCkgaW4gdHdvIGNvbW1lbnRz
CgpBdCBsZWFzdCwgcGxlYXNlIGFkZCBhIHNwYWNlIGFmdGVyIHRoZSBjb2xvbiAoOikuCgo+IC0t
LQo+ICAga2VybmVsL2tleGVjX2ZpbGUuYyAgICAgICAgICAgICAgICB8IDIgKy0KPiAgIHNlY3Vy
aXR5L2ludGVncml0eS9pbWEvaW1hX2tleGVjLmMgfCAyICstCj4gICAyIGZpbGVzIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEva2VybmVs
L2tleGVjX2ZpbGUuYyBiL2tlcm5lbC9rZXhlY19maWxlLmMKPiBpbmRleCA4ODFiYTBkMTcxNGMu
LmI1YmJiMmZlMDY2OCAxMDA2NDQKPiAtLS0gYS9rZXJuZWwva2V4ZWNfZmlsZS5jCj4gKysrIGIv
a2VybmVsL2tleGVjX2ZpbGUuYwo+IEBAIC02MjQsNyArNjI0LDcgQEAgaW50IGtleGVjX2xvY2F0
ZV9tZW1faG9sZShzdHJ1Y3Qga2V4ZWNfYnVmICprYnVmKQo+ICAgICoga2V4ZWNfYWRkX2J1ZmZl
ciAtIHBsYWNlIGEgYnVmZmVyIGluIGEga2V4ZWMgc2VnbWVudAo+ICAgICogQGtidWY6ICBCdWZm
ZXIgY29udGVudHMgYW5kIG1lbW9yeSBwYXJhbWV0ZXJzLgo+ICAgICoKPiAtICogVGhpcyBmdW5j
dGlvbiBhc3N1bWVzIHRoYXQga2V4ZWNfbXV0ZXggaXMgaGVsZC4KPiArICogVGhpcyBmdW5jdGlv
biBhc3N1bWVzIHRoYXQga2V4ZWNfbG9jayBpcyBoZWxkLgo+ICAgICogT24gc3VjY2Vzc2Z1bCBy
ZXR1cm4sIEBrYnVmLT5tZW0gd2lsbCBoYXZlIHRoZSBwaHlzaWNhbCBhZGRyZXNzIG9mCj4gICAg
KiB0aGUgYnVmZmVyIGluIG1lbW9yeS4KPiAgICAqCj4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2lu
dGVncml0eS9pbWEvaW1hX2tleGVjLmMgYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9rZXhl
Yy5jCj4gaW5kZXggNDE5ZGM0MDVjODMxLi5hZDEzM2ZlMTIwZGIgMTAwNjQ0Cj4gLS0tIGEvc2Vj
dXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfa2V4ZWMuYwo+ICsrKyBiL3NlY3VyaXR5L2ludGVncml0
eS9pbWEvaW1hX2tleGVjLmMKPiBAQCAtNzcsNyArNzcsNyBAQCBzdGF0aWMgaW50IGltYV9kdW1w
X21lYXN1cmVtZW50X2xpc3QodW5zaWduZWQgbG9uZyAqYnVmZmVyX3NpemUsIHZvaWQgKipidWZm
ZXIsCj4gICAgKiBDYWxsZWQgZHVyaW5nIGtleGVjX2ZpbGVfbG9hZCBzbyB0aGF0IElNQSBjYW4g
YWRkIGEgc2VnbWVudCB0byB0aGUga2V4ZWMKPiAgICAqIGltYWdlIGZvciB0aGUgbWVhc3VyZW1l
bnQgbGlzdCBmb3IgdGhlIG5leHQga2VybmVsLgo+ICAgICoKPiAtICogVGhpcyBmdW5jdGlvbiBh
c3N1bWVzIHRoYXQga2V4ZWNfbXV0ZXggaXMgaGVsZC4KPiArICogVGhpcyBmdW5jdGlvbiBhc3N1
bWVzIHRoYXQga2V4ZWNfbG9jayBpcyBoZWxkLgo+ICAgICovCj4gICB2b2lkIGltYV9hZGRfa2V4
ZWNfYnVmZmVyKHN0cnVjdCBraW1hZ2UgKmltYWdlKQo+ICAgewo+IC0tCj4gMi4zMy4wCgoKS2lu
ZCByZWdhcmRzLAoKUGF1bAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
