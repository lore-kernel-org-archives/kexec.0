Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525CCC4167B
	for <kexec@archiver.kernel.org>; Sun, 26 Nov 2023 03:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nZwS3srZle+vGalj/rRruCvt5o90tZY4hGcM3pOlz0o=; b=AOjk7EVwY5uD5k
	2NLDMHROSjbE7OBft8SoOtDGZJMxxPDxH1sB1nlnDjDr39NbUEjZ2KFHZdXidqxGIvEnZH9p2I7Nv
	cc4ho7hd2bw3pM1/iQjU+LLub04veQub8HZLb79qVGJcTy7FZ8AMI/hnrrFnPYDqDI4RUbAJczJKm
	f8fMQeeoE/3HfGU3S9EYe/smgIUpTmQdUtP3EdbTARX3If8eqI+ix8lmtcGeWMrRBCDoTfBeEj8ml
	lHMce8n+1oxYbNpRB8VNdAH9OlSSvPxiVrGyVvaymUUvka+Mtn81+Lpa2inQThzehDn10qbk9ZfpC
	zUaY5BQFYQIq79+Z5uaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r75oz-00AAIN-1C;
	Sun, 26 Nov 2023 03:28:37 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r75ow-00AAHc-0D
	for kexec@lists.infradead.org;
	Sun, 26 Nov 2023 03:28:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 85E7060D58
	for <kexec@lists.infradead.org>; Sun, 26 Nov 2023 03:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AA7C433C9
	for <kexec@lists.infradead.org>; Sun, 26 Nov 2023 03:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700969310;
	bh=OYOHGNO0l10c6uw66DK7YJ/0AYaK9T9FtS3chTdnDhM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kVnRW9hEZbK3hream57aZRVHH/hwWqei//DQOZ7dqGCRYCiXGWfEntb37Qfs0HY+4
	 fzJ2+noWB6R5AOAYD9yC7KW34V1CLJBJBPofjYaNHi9z2JnOqcu/tLdjsjXCvVPmJn
	 DOj4vRXzF9C3uworiZLpL0FbAnChyxSxvibhaxo1ZnsZqg8aRg/mTbaT/u9JDju5gg
	 NYEMZxeKD6Yf5xNlQzjtPB1SnF1SwFUSrjCWBrrIJMsA+T9NR99Gu0M2a+sdHFQ3AU
	 b9/04zwGUhLWb4hZNlk+GWw/xoqvorTBdo0X/97g4/KG2HUYk8kb8vTKs6RzH0tIei
	 4OJ0LshipLNcA==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-54af1daf6a9so3554543a12.1
        for <kexec@lists.infradead.org>; Sat, 25 Nov 2023 19:28:29 -0800 (PST)
X-Gm-Message-State: AOJu0YxZ1lGoyesrxDWKzmZ7rT3p6qkJ8OB4T1y68ne6CbAm35XNbkOs
	fj5KL/NJPz/ayWWvqChgybYZjP/3PuufP2Epw8Q=
X-Google-Smtp-Source: AGHT+IHph+umJtx0eO94MZ9Pi4YTFWvaEnEFL87k4jNTkYp4+r4hYWIJOpjOtLCLI4BCvgktx3xDzelh88h2mmaepOU=
X-Received: by 2002:a05:6402:a41:b0:54a:fc86:f0c6 with SMTP id
 bt1-20020a0564020a4100b0054afc86f0c6mr4923426edb.21.1700969307646; Sat, 25
 Nov 2023 19:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20231124085410.107080-1-wangrui@loongson.cn>
In-Reply-To: <20231124085410.107080-1-wangrui@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 26 Nov 2023 11:28:15 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7HyfD2bV+g3qfJXw9z0tC2WRRnHjbPgibdanNWGjxN1g@mail.gmail.com>
Message-ID: <CAAhV-H7HyfD2bV+g3qfJXw9z0tC2WRRnHjbPgibdanNWGjxN1g@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix an issue with relocatable vmlinux
To: WANG Rui <wangrui@loongson.cn>
Cc: kexec@lists.infradead.org, Varad Gautam <vrd@amazon.de>, 
	AKASHI Takahiro <takahiro.akashi@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231125_192834_151144_CC008AFE 
X-CRM114-Status: GOOD (  19.89  )
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

UmV2aWV3ZWQtYnk6IEh1YWNhaSBDaGVuIDxjaGVuaHVhY2FpQGxvb25nc29uLmNuPgoKT24gRnJp
LCBOb3YgMjQsIDIwMjMgYXQgNDo1NOKAr1BNIFdBTkcgUnVpIDx3YW5ncnVpQGxvb25nc29uLmNu
PiB3cm90ZToKPgo+IE5vcm1hbGx5IHZtbGludXggZm9yIExvb25nQXJjaCBpcyBvZiBFVF9FWEVD
IHR5cGUsIHdoaWxlIGlmIGJ1aWx0IHdpdGgKPiBDT05GSUdfUkVMT0NBVEFCTEUgKHRoaXMgaXMg
UElFKSBhbmQgQ2xhbmcsIGl0IHdpbGwgYmUgb2YgRVRfRFlOIHR5cGUuCj4gTWVhbndoaWxlLCBw
aHlzaWNhbCBhZGRyZXNzIGZpZWxkIG9mIHNlZ21lbnRzIGluIHZtbGludXggaGFzIGFjdHVhbGx5
Cj4gdGhlIHNhbWUgdmFsdWUgYXMgdmlydHVhbCBhZGRyZXNzIGZpZWxkLgo+Cj4gU2ltaWxhciB0
byBhcm02NCwgdGhpcyBwYXRjaCBhbGxvd3MgdG8gdW5jb25kaXRpb25hbGx5IHNraXAgdGhlIGNo
ZWNrCj4gb24gTG9vbmdBcmNoLgo+Cj4gTGluazogaHR0cHM6Ly9naXRodWIuY29tL0NsYW5nQnVp
bHRMaW51eC9saW51eC9pc3N1ZXMvMTk2Mwo+IFNpZ25lZC1vZmYtYnk6IFdBTkcgUnVpIDx3YW5n
cnVpQGxvb25nc29uLmNuPgo+IC0tLQo+ICBrZXhlYy9rZXhlYy1lbGYtZXhlYy5jIHwgNSArKyst
LQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2tleGVjL2tleGVjLWVsZi1leGVjLmMgYi9rZXhlYy9rZXhlYy1lbGYtZXhl
Yy5jCj4gaW5kZXggYmVhN2IzZS4uYjMzNzY0MiAxMDA2NDQKPiAtLS0gYS9rZXhlYy9rZXhlYy1l
bGYtZXhlYy5jCj4gKysrIGIva2V4ZWMva2V4ZWMtZWxmLWV4ZWMuYwo+IEBAIC0zOSwxMiArMzks
MTMgQEAgc3RhdGljIGludCBnZXRfZWxmX2V4ZWNfbG9hZF9iYXNlKHN0cnVjdCBtZW1fZWhkciAq
ZWhkciwgc3RydWN0IGtleGVjX2luZm8gKmluZm8KPiAgICAgICAgIHVuc2lnbmVkIGxvbmcgZmly
c3QsIGxhc3Q7Cj4gICAgICAgICBzaXplX3QgaTsKPgo+IC0gICAgICAgLyogTm90ZSBvbiBhcm02
NDoKPiArICAgICAgIC8qIE5vdGUgb24gYXJtNjQgYW5kIGxvb25nYXJjaDY0Ogo+ICAgICAgICAg
ICogYXJtNjQncyB2bWxpbnV4IGhhcyB2aXJ0dWFsIGFkZHJlc3MgaW4gcGh5c2ljYWwgYWRkcmVz
cwo+ICAgICAgICAgICogZmllbGQgb2YgUFRfTE9BRCBzZWdtZW50cy4gU28gdGhlIGZvbGxvd2lu
ZyB2YWxpZGl0eSBjaGVjawo+ICAgICAgICAgICogYW5kIHJlbG9jYXRpb24gbWFrZXMgbm8gc2Vu
c2Ugb24gYXJtNjQuCj4gKyAgICAgICAgKiBUaGlzIGlzIGFsc28gYXBwbGllcyB0byBMb29uZ0Fy
Y2guCj4gICAgICAgICAgKi8KPiAtICAgICAgIGlmIChlaGRyLT5lX21hY2hpbmUgPT0gRU1fQUFS
Q0g2NCkKPiArICAgICAgIGlmIChlaGRyLT5lX21hY2hpbmUgPT0gRU1fQUFSQ0g2NCB8fCBlaGRy
LT5lX21hY2hpbmUgPT0gRU1fTE9PTkdBUkNIKQo+ICAgICAgICAgICAgICAgICByZXR1cm4gMDsK
Pgo+ICAgICAgICAgZmlyc3QgPSBVTE9OR19NQVg7Cj4gLS0KPiAyLjQzLjAKPgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0
CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9rZXhlYwo=
