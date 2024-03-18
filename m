Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB82EC54E5D
	for <kexec@archiver.kernel.org>; Mon, 18 Mar 2024 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y/v3/K6ogdDged6pT+0oj4Xx3m/rlSQQDBi8F37XSCM=; b=wBWcwd6zxVxP5o
	ISmXB159uDWoP/L2YDtLBkWnqjpR+Zg2Ndnv9uHz5m4+K9G/Yd0psFHpJpOrMkH3iHU9XhMzZR3HP
	deG4Jr0rOK0LVy0OdC+bKYsV6cCyA6gXXpzmPSt6YLaKU1fZzWU3WCGrfcqoaHlU7EM5A/hf25iwd
	ICySMf7tNpSB8s7aoAcANV4wScDqZcrzVunYFivVOFGAKAGfIQMwnieX8S8T2R1/CoNRqMw6GJe9f
	GbCm1f6OtlrkATF3n+WWwLYz9+4gKQQLDivdS4nJkBbhLrCO+qOODAVmOJSh+OIAXz4RHsFfFzkro
	vW3TY/wLXVLb1FqV5Ofg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmFc4-00000009B0V-2BW9;
	Mon, 18 Mar 2024 16:13:24 +0000
Received: from out-184.mta1.migadu.com ([2001:41d0:203:375::b8])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmFc0-00000009AxO-3XyH
	for kexec@lists.infradead.org;
	Mon, 18 Mar 2024 16:13:22 +0000
Message-ID: <4bcdd9cc-6149-490e-b3df-a39346e5035b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710778394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7JooqxhdWYea4plzORL0v2OMwlVA0hITUGPfyr/rxw=;
	b=W/LMiKkl6A4zdyQuXXzHGTu6K+ix0qYxeckWn56Lr46JxVD++xmIb6GSHomV5XuUqBTnxN
	LOhg+TZiWK4q32Hpl4i2AcyLD09newzHoBR+5j9LENN/eoOiAZkWDEc6cbM9sdpw/86qeV
	iZYKYZuyFvzzKM8Rzo1HI380XLGGl/A=
Date: Mon, 18 Mar 2024 09:13:11 -0700
MIME-Version: 1.0
Subject: Re: [PATCH linux-next] bpf: fix warning for crash_kexec
Content-Language: en-GB
To: Hari Bathini <hbathini@linux.ibm.com>, bpf@vger.kernel.org
Cc: Kexec-ml <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240209123520.778599-1-hbathini@linux.ibm.com>
 <6a1d94f7-b4bf-4315-b862-4e278abbaa73@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <6a1d94f7-b4bf-4315-b862-4e278abbaa73@linux.ibm.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_091321_338924_83D327B8 
X-CRM114-Status: GOOD (  10.92  )
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

Ck9uIDMvMTcvMjQgMTE6NTIgUE0sIEhhcmkgQmF0aGluaSB3cm90ZToKPiBKdXN0IGNoZWNraW5n
IG9uIHdoZXRoZXIgdGhpcyB3aWxsIGdvIHZpYSBicGYgb3IgbW0gdHJlZT8KClNlbmRpbmcgdG8g
YnBmLW5leHQgc2hvdWxkIGJlIG9rYXkuCkNvdWxkIHlvdSByZXN1Ym1pdCB0aGUgcGF0Y2ggYXMg
Q09ORklHX0NSQVNIX0RVTVAgcHJvYmFibHkgbm90CmF2YWlsYWJsZSB0byBicGYtbmV4dCB3aGVu
IHlvdSBpbml0aWFsbHkgc3VibWl0dGVkIHRoZSBwYXRjaC4KCj4KPiBPbiAwOS8wMi8yNCA2OjA1
IHBtLCBIYXJpIEJhdGhpbmkgd3JvdGU6Cj4+IFdpdGggWzFdLCBDT05GSUdfS0VYRUMgJiAhQ09O
RklHX0NSQVNIX0RVTVAgaXMgc3VwcG9ydGVkIGJ1dCB0aGF0IGxlZAo+PiB0byB0aGUgYmVsb3cg
d2FybmluZzoKPj4KPj4gwqDCoCAiV0FSTjogcmVzb2x2ZV9idGZpZHM6IHVucmVzb2x2ZWQgc3lt
Ym9sIGNyYXNoX2tleGVjIgo+Pgo+PiBGaXggaXQgYnkgdXNpbmcgdGhlIGFwcHJvcHJpYXRlICNp
ZmRlZi4KPj4KPj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDEyNDA1MTI1
NC42NzEwNS0xLWJoZUByZWRoYXQuY29tLwo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBIYXJpIEJhdGhp
bmkgPGhiYXRoaW5pQGxpbnV4LmlibS5jb20+Cj4+IC0tLQo+PiDCoCBrZXJuZWwvYnBmL2hlbHBl
cnMuYyB8IDIgKy0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvYnBmL2hlbHBlcnMuYyBiL2tlcm5lbC9i
cGYvaGVscGVycy5jCj4+IGluZGV4IDRkYjFjNjU4MjU0Yy4uZTQwOGQxMTE1ZTI2IDEwMDY0NAo+
PiAtLS0gYS9rZXJuZWwvYnBmL2hlbHBlcnMuYwo+PiArKysgYi9rZXJuZWwvYnBmL2hlbHBlcnMu
Ywo+PiBAQCAtMjU0NSw3ICsyNTQ1LDcgQEAgX19icGZfa2Z1bmMgdm9pZCBicGZfdGhyb3codTY0
IGNvb2tpZSkKPj4gwqAgX19icGZfa2Z1bmNfZW5kX2RlZnMoKTsKPj4gwqAgwqAgQlRGX0tGVU5D
U19TVEFSVChnZW5lcmljX2J0Zl9pZHMpCj4+IC0jaWZkZWYgQ09ORklHX0tFWEVDX0NPUkUKPj4g
KyNpZmRlZiBDT05GSUdfQ1JBU0hfRFVNUAo+PiDCoCBCVEZfSURfRkxBR1MoZnVuYywgY3Jhc2hf
a2V4ZWMsIEtGX0RFU1RSVUNUSVZFKQo+PiDCoCAjZW5kaWYKPj4gwqAgQlRGX0lEX0ZMQUdTKGZ1
bmMsIGJwZl9vYmpfbmV3X2ltcGwsIEtGX0FDUVVJUkUgfCBLRl9SRVRfTlVMTCkKPgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBs
aXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
