Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B48C4345F
	for <kexec@archiver.kernel.org>; Wed, 17 Apr 2024 07:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EJ/wE2mjNvLH0sZQW2AhDbY457YzVXg1EG05b1wAEKE=; b=BnASKOkJ2iqEAG
	PnQq3MTJiBVLBoHf5IDctBR8/caAmpG0kycw+0GDEWteuazYbJzhV2oJa8wvknU9ZZrnlmIB6tEKy
	9IrbS6rImwjHihN1pY9gLBdpiS5m7J5CiNV8vRXGOP2Tw8gDGjC/9sDngMDmjnAn7oC0narpGKjIw
	YeJXZr/oOA1TqpbxMepywwouhdqg5wFHEH7v6Z7IfCzZw5l8lPctkwfEHm2glNJeUeu5nIspX5fh6
	staBgGhlRRvq93sxvKlokQT8hg0Sz/OEP5q3+f/mCZg2uI6/XBYrDECPqquhFGp5WcNBqpvoEKX2n
	cnN4B+sN6Q7b1oSOizdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwznB-0000000F2pG-0X8o;
	Wed, 17 Apr 2024 07:33:17 +0000
Received: from mail-yw1-f176.google.com ([209.85.128.176])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwzn7-0000000F2oH-44td
	for kexec@lists.infradead.org;
	Wed, 17 Apr 2024 07:33:15 +0000
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-618944792c3so47098007b3.1
        for <kexec@lists.infradead.org>; Wed, 17 Apr 2024 00:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713339188; x=1713943988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWT+JVEfiwxFQ2uS0czPJ+Qjk2ZoL23ti+eoi7gGfk8=;
        b=aOD+LxX2JD2bs8dGGx/+YMdf1RponPsM1tUqafSlSnHPxmav7ScjmUtznlIC0c+8Tc
         X5KcKtOPEnGQyXgUh2Rp0bMuQokYn23eSiFwSaht5w23E04pfEWdfjcAkfirghEYuuA5
         HXxAw8mlWoux9jYs5H95ushPR5IZmB9iwAUtwyg1NVad+kdaEQhAY5CInU/9eh/y6Lke
         dcTBU6uk5bJJW9Lcf/1QqwtfZRtiyExugFLZb7OU1okfFhQrS5xZKShlE76Pn2BfFUoP
         eWz+BzQta4MSRme7x8cprFkZ1pP8yJUzAyWF/djVzM96YuOPs92Eqjo17UUBBQlHSap4
         OxJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDehXyOB85AG49P9UawVlVsxV1wrOi1jqj5mqc/GJPNNeBAVdviHmJih/lxiWfDLuY0n3T+Zj/KFf+m8nYNDgoF8qHPEJhgx1h
X-Gm-Message-State: AOJu0Yw3eHLT0O4Cxt4Rr6KGXyMTAA+78bx0GgXFcS1UAmbRBdY/rnPK
	IIcIZ0mtwGIO5wOy18h82eER9y2F6vvQ5SwOhp4elH/CkaG8PFxu2m1vWV61
X-Google-Smtp-Source: AGHT+IEephdHSo8tcXDHDNWxj6rJ7vRP/eRj5fKSOjPZ0XIk19jOj4cWsLxItQfImRBlWoyVB6R90Q==
X-Received: by 2002:a0d:e942:0:b0:61b:6b6:5cb2 with SMTP id s63-20020a0de942000000b0061b06b65cb2mr1290381ywe.43.1713339188085;
        Wed, 17 Apr 2024 00:33:08 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id o20-20020a817e14000000b00611a41bc579sm2826346ywn.57.2024.04.17.00.33.07
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 00:33:07 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso5809611276.1
        for <kexec@lists.infradead.org>; Wed, 17 Apr 2024 00:33:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWsow27CHkTFAsY92SvqwdN4h8lbFgw/ny84/6l9hVtJqZZtNtW92S8xsXVGITzCV/7KCwsPPR/R/SUFnAxbEMJJ9V1guPGPoEG
X-Received: by 2002:a05:690c:989:b0:61b:97c:5ffa with SMTP id
 ce9-20020a05690c098900b0061b097c5ffamr866589ywb.22.1713339187177; Wed, 17 Apr
 2024 00:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240329132825.1102459-1-bhe@redhat.com> <20240329132825.1102459-2-bhe@redhat.com>
 <CAAhV-H76-FOvcTXB_rW1B1wFthYK6txVtC+brfzk6nwOhar8iQ@mail.gmail.com>
 <ZgggcyeJ1bnkfGOp@MiWiFi-R3L-srv> <CAAhV-H5xGDAkF2kjdveKoGd+GwYrmix8_E=YB0i=c98qOGvffw@mail.gmail.com>
In-Reply-To: <CAAhV-H5xGDAkF2kjdveKoGd+GwYrmix8_E=YB0i=c98qOGvffw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Apr 2024 09:32:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVrFPJQ2B7-SBCq-m7tU9twKYwyH+0Czy-zB_n2F=VwrA@mail.gmail.com>
Message-ID: <CAMuHMdVrFPJQ2B7-SBCq-m7tU9twKYwyH+0Czy-zB_n2F=VwrA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arch/loongarch: clean up the left code and Kconfig
 item related to CRASH_CORE
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, akpm@linux-foundation.org, 
	WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_003314_031457_421A527B 
X-CRM114-Status: GOOD (  20.32  )
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

T24gV2VkLCBBcHIgMTcsIDIwMjQgYXQgNToxNeKAr0FNIEh1YWNhaSBDaGVuIDxjaGVuaHVhY2Fp
QGtlcm5lbC5vcmc+IHdyb3RlOgo+IE9uIFNhdCwgTWFyIDMwLCAyMDI0IGF0IDEwOjI04oCvUE0g
QmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIDAzLzMwLzI0IGF0
IDA5OjU5cG0sIEh1YWNhaSBDaGVuIHdyb3RlOgo+ID4gPiBRdWV1ZWQsIHRoYW5rcy4KPiA+Cj4g
PiBUaGFua3MsIEh1YWNhaS4gV2hpbGUgSSBub3RpY2VkIEFuZHJldyBoYXMgcXVldWVkIHRoaXMg
cGF0Y2hzZXQgaW4gaGlzCj4gPiBtbS11bnN0YWJsZSBicmFuY2guCj4gSWYgSSdtIG5vdCBtaXN0
YWtlbiwgbW0tdW5zdGFibGUgaXMgdGFyZ2V0IGZvciB0aGUgbmV4dCA2LjEwLCBub3QgZm9yCj4g
dGhlIGN1cnJlbnQgNi45LiBCdXQgSSB0aGluayB0aGlzIHBhdGNoIHNob3VsZCBiZSBhIGZpeCBm
b3IgNi45LCBzbyBJCj4gdGhpbmsgaXQgaXMgbW9yZSBzdWl0YWJsZSBpbiB0aGUgbG9vbmdhcmNo
LWZpeGVzIGJyYW5jaC4gV2hhdCdzIHlvdXIKPiBvcGluaW9uPwoKVGhpcyB3b3VsZCBoYXZlIGJl
ZW4gc2xpZ2h0bHkgbW9yZSBvYnZpb3VzIHdpdGgKRml4ZXM6IDg1ZmNkZTQwMmRiMTkxYjUgKCJr
ZXhlYzogc3BsaXQgY3Jhc2hrZXJuZWwgcmVzZXJ2YXRpb24gY29kZQpvdXQgZnJvbSBjcmFzaF9j
b3JlLmMiKQoKR3J7b2V0amUsZWV0aW5nfXMsCgogICAgICAgICAgICAgICAgICAgICAgICBHZWVy
dAoKLS0gCkdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25k
IGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcKCkluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMg
d2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQKd2hlbiBJ
J20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21l
dGhpbmcgbGlrZSB0aGF0LgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVz
IFRvcnZhbGRzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
