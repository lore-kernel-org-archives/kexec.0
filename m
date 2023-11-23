Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED266C5AD4C
	for <kexec@archiver.kernel.org>; Thu, 23 Nov 2023 08:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZL5oq3lylUEt4QyOctNx5H8QX5scobBst/lhQDhuPlU=; b=ib/8Oi0HjkqQSr
	3a/ehOsonjN2bHudKiMZhKUbgjPuQUpKG9hlro5eaJmzaNRmWnJnvBO5psPdMcTw7tlKhPj4emX2d
	2JnTQ7DfaLqPchehrBPzUUhJmBQYUAY06QopEPY/A03YrfH+KFx8Eds2t6iKCIG3/ibC1oMsTBZL+
	BOueLFoVK15zHpFZDL1Nc+W4tcxoRJ24I3hhkGMXO1Pobnng6YiED9oO+45w5ok3xJF3a9hTKc3Gs
	A0vjvH6D68ZEoqWMenX9duO7kfb8uuF7AA8TA1ylP3IOXtrXYAxSFOwzjwzQBCoNle9QPuBi51vG/
	qayazdxHeRsHNLbPkQ5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r65AP-0049lv-20;
	Thu, 23 Nov 2023 08:34:33 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r65AM-0049jj-1W
	for kexec@lists.infradead.org;
	Thu, 23 Nov 2023 08:34:31 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5a9bc2ec556so420404a12.0
        for <kexec@lists.infradead.org>; Thu, 23 Nov 2023 00:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1700728467; x=1701333267; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwJpO+HiDZw/9/oXGeHCL3JIdqDb9YbJK2ol1m1T6nA=;
        b=P33/4hvG1MgkMowUh00qRimJzAzySVS/bLEcFJRw4gsHiWyIJ1axSeM2cduB3wz3SY
         AoJwjKO/MA4GGQyjtd+vaBx2VHnEM4YYlOhhd7IdQufChuKy1cYCWu7tf91LdH6smdOh
         SBEplmSLw1QRZNGCM85QWMEu6NC0oZjfnszFf0RlyRe+vlMUIQdOc4i/vz8u/nC+9FNy
         aeUNJDAva4J8h9sTpp5f1fmQ6kDFzSSCO/x7ljWWlGCc7a4OINO0Gvd3S4ZWnQJrITJI
         C56Ycr8GVq9RR9cxS/ooewq4CGx9vLdxXp4xsC+vSHM7J65OJAby7CqkQiKAkt3NQ6E8
         //wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700728467; x=1701333267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwJpO+HiDZw/9/oXGeHCL3JIdqDb9YbJK2ol1m1T6nA=;
        b=VZ4Rb320lx6bf+X7QFrQK47grT/XEJL6c6fhM7zR0CC3qsUF0pwmBOBlvOyhgNj9IT
         NiWLlMEvOyotTM8Ocq5ePmB5LPfkMUzqU2F/iuhNuSojic6rPXLvECmojIN9xG0yTHOw
         K2ZgDJ1YkGwwY6y6Myqt1FUYimooYqtATodJZh4bTXwhi8D4rdRB9LYVoPk7Z6DW3BqT
         ptAUuAC+fJJovaHvPs4YMyVgCmsvcn8wEu/N3PAI6YppMHwE+PDVnq1oNZ6x72fDMrn0
         1k6DrDnq0W4tkoVX4gG9wzRaC1s3T0KJb2CwZNZSTFflwEdxxrQE62AbmsbeozAHkJuS
         E5ug==
X-Gm-Message-State: AOJu0YyKs21AgYQXOao+qgPUVTEOaOhLNLjj1PNGwjSF5TkmNgCfxRwy
	+AHU410fKMi3ucfpvcCli39KYFlcCPWA3JHo+Om7OQ==
X-Google-Smtp-Source: AGHT+IHv8tVmYrr0nVNwRf4ArxBSj2WKhPiPUlG/rnS4yd9QZHgWaaWGkAsHvCntxohQ4dGYjeVUfzjGlT4Y0zoZ7IY=
X-Received: by 2002:a17:90b:350c:b0:280:4829:52cc with SMTP id
 ls12-20020a17090b350c00b00280482952ccmr5402011pjb.37.1700728467437; Thu, 23
 Nov 2023 00:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20231123073652.507034-1-bhe@redhat.com> <20231123073652.507034-3-bhe@redhat.com>
In-Reply-To: <20231123073652.507034-3-bhe@redhat.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Thu, 23 Nov 2023 08:34:16 +0000
Message-ID: <CALrw=nFzy2zq-khLUCXsuf8J5_mka0YPyTosO190OUst2QSjVQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] drivers/base/cpu: crash data showing should depends
 on KEXEC_CORE
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
	akpm@linux-foundation.org, eric_devolder@yahoo.com, 
	kernel-team <kernel-team@cloudflare.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231123_003430_511153_EB85894B 
X-CRM114-Status: GOOD (  18.00  )
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

T24gVGh1LCBOb3YgMjMsIDIwMjMgYXQgNzozN+KAr0FNIEJhb3F1YW4gSGUgPGJoZUByZWRoYXQu
Y29tPiB3cm90ZToKPgo+IFdoZW4gYmVsb3cga2VybmVsIGNvbmZpZyBpdGVtcyBhcmUgc2V0LCBj
b21waWxpbmcgZXJyb3IgYXJlIHRyaWdnZXJlZC4KPgo+IENPTkZJR19DUkFTSF9DT1JFPXkKPiBD
T05GSUdfS0VYRUNfQ09SRT15Cj4gQ09ORklHX0NSQVNIX0RVTVA9eQo+IENPTkZJR19DUkFTSF9I
T1RQTFVHPXkKPgo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQo+IGRyaXZlcnMvYmFzZS9jcHUuYzogSW4gZnVuY3Rpb24g4oCYY3Jhc2hfaG90
cGx1Z19zaG934oCZOgo+IGRyaXZlcnMvYmFzZS9jcHUuYzozMDk6NDA6IGVycm9yOiBpbXBsaWNp
dCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhjcmFzaF9ob3RwbHVnX2NwdV9zdXBwb3J04oCZ
OyBkaWQgeW91IG1lYW4g4oCYY3Jhc2hfaG90cGx1Z19zaG934oCZPyBbLVdlcnJvcj1pbXBsaWNp
dC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KPiAgIDMwOSB8ICAgICAgICAgcmV0dXJuIHN5c2ZzX2Vt
aXQoYnVmLCAiJWRcbiIsIGNyYXNoX2hvdHBsdWdfY3B1X3N1cHBvcnQoKSk7Cj4gICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+Cj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
cmFzaF9ob3RwbHVnX3Nob3cKPiBjYzE6IHNvbWUgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBl
cnJvcnMKPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KPgo+IENPTkZJR19LRVhFQyBpcyB1c2VkIHRvIGVuYWJsZSBrZXhlY19sb2FkIGludGVy
ZmFjZSwgdGhlCj4gY3Jhc2hfbm90ZXMvY3Jhc2hfbm90ZXNfc2l6ZS9jcmFzaF9ob3RwbHVnIHNo
b3dpbmcgZGVwZW5kcyBvbgo+IENPTkZJR19LRVhFQyBpcyBpbmNvcnJlY3QuIEl0IHNob3VsZCBk
ZXBlbmQgb24gS0VYRUNfQ09SRSBpbnN0ZWFkLgo+Cj4gRml4IGl0IG5vdy4KCkNhbiB3ZSBhZGQg
Rml4ZXMvQ0Mgc3RhYmxlLCBzbyBpdCBnZXRzIGV2ZW50dWFsbHkgYmFja3BvcnRlZCBpbnRvIDYu
Nj8KCj4gU2lnbmVkLW9mZi1ieTogQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+Cj4gLS0tCj4g
IGRyaXZlcnMvYmFzZS9jcHUuYyB8IDYgKysrLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9iYXNlL2Nw
dS5jIGIvZHJpdmVycy9iYXNlL2NwdS5jCj4gaW5kZXggOWVhMjJlMTY1YWNkLi41NDg0OTFkZTgx
OGUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9iYXNlL2NwdS5jCj4gKysrIGIvZHJpdmVycy9iYXNl
L2NwdS5jCj4gQEAgLTE0NCw3ICsxNDQsNyBAQCBzdGF0aWMgREVWSUNFX0FUVFIocmVsZWFzZSwg
U19JV1VTUiwgTlVMTCwgY3B1X3JlbGVhc2Vfc3RvcmUpOwo+ICAjZW5kaWYgLyogQ09ORklHX0FS
Q0hfQ1BVX1BST0JFX1JFTEVBU0UgKi8KPiAgI2VuZGlmIC8qIENPTkZJR19IT1RQTFVHX0NQVSAq
Lwo+Cj4gLSNpZmRlZiBDT05GSUdfS0VYRUMKPiArI2lmZGVmIENPTkZJR19LRVhFQ19DT1JFCj4g
ICNpbmNsdWRlIDxsaW51eC9rZXhlYy5oPgo+Cj4gIHN0YXRpYyBzc2l6ZV90IGNyYXNoX25vdGVz
X3Nob3coc3RydWN0IGRldmljZSAqZGV2LAo+IEBAIC0xODksMTQgKzE4OSwxNCBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCBjcmFzaF9ub3RlX2NwdV9hdHRyX2dyb3VwID0g
ewo+ICAjZW5kaWYKPgo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCAqY29t
bW9uX2NwdV9hdHRyX2dyb3Vwc1tdID0gewo+IC0jaWZkZWYgQ09ORklHX0tFWEVDCj4gKyNpZmRl
ZiBDT05GSUdfS0VYRUNfQ09SRQo+ICAgICAgICAgJmNyYXNoX25vdGVfY3B1X2F0dHJfZ3JvdXAs
Cj4gICNlbmRpZgo+ICAgICAgICAgTlVMTAo+ICB9Owo+Cj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
YXR0cmlidXRlX2dyb3VwICpob3RwbHVnYWJsZV9jcHVfYXR0cl9ncm91cHNbXSA9IHsKPiAtI2lm
ZGVmIENPTkZJR19LRVhFQwo+ICsjaWZkZWYgQ09ORklHX0tFWEVDX0NPUkUKPiAgICAgICAgICZj
cmFzaF9ub3RlX2NwdV9hdHRyX2dyb3VwLAo+ICAjZW5kaWYKPiAgICAgICAgIE5VTEwKPiAtLQo+
IDIuNDEuMAo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
