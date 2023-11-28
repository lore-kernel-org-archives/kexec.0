Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F39BC4167B
	for <kexec@archiver.kernel.org>; Tue, 28 Nov 2023 11:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZTbQCPR6H7IkT1DMpxvNJDrGDVFsXQhxxwZcgNXpM00=; b=CNg+AHcxfEt2yp
	w9ElVdRp3whgJLS9nnpmwONprtq4xZLAy9Jke+tcco5EjjVbZAjQEvbq/uK/9kPjO4pzKQlXwWZSV
	iybA+e/Y7KfrHBTYeMKwAqEbN9l3fs1wsRy0QDJ9snRkEkBlnsVhUP7X7fsRTbLku8ZmX/CRzw9He
	L4H9Vzf2wgol4JkxgOGC9J8OMRwsxxBID0jcbWynceStgnLYDugB3udHO2QUVo76gkqZhwBHUMULd
	OjtoclxZnx6B72nbBk3GdxjLrPsXcvXw35LoFozYBtYDmC/egjTXupSZCjKs9i0gmarcOOY5qXTNP
	z1Eu6oY87BndgGy8EkZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7wcB-005F6m-17;
	Tue, 28 Nov 2023 11:50:55 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7wc7-005F5T-2k
	for kexec@lists.infradead.org;
	Tue, 28 Nov 2023 11:50:53 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-285bcb577d6so2199624a91.3
        for <kexec@lists.infradead.org>; Tue, 28 Nov 2023 03:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701172249; x=1701777049; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2kulW1geAfZxX/JQH9MeV9uEi0C8/RyxeovxkcDG50=;
        b=LfW8KasmBfSZvgfHN3OwrwL0eS7ho45L7yVpYCRh0ksftQD7Ysbq65tHWJQ6B1ahc7
         LffgPYMELa4jcxa4+sBoPxlqhZ8EgfbKYkuiawbcoXqe+f27AysOvmF306oEBzHMpmeT
         koCEgKdvEV0WmLucDXxBrNGi9mF/xPP64HeVPi/2VXr5RmV8nHBjDH9936xv8iHuWlvm
         wnQsAM8mRZH9cG6a3UXhqA/Y63TDoydjjqFeGYucgUc55/PoewBFZk2Gbqs8GdN5jr4h
         mc8IYs80AKXTiszLnNh1nTNlGGovmJmJVShggywaHR4Pqu8mDY4Vy7429v6ZhBTnfudO
         yfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701172249; x=1701777049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2kulW1geAfZxX/JQH9MeV9uEi0C8/RyxeovxkcDG50=;
        b=G2710dMikr1FLYVUMwoQQI3Mr0U62X0UfNFkoNMovOf4J9L/RQP4o1I53PJKPheY5k
         jAkgP0BydRwRnjPFB3gobWO/Teewkip86fcXMXdJsV/tUCe5aYCGNsl6G/4nm6VekFBP
         iSMZg1yjkk7lnqtZ/N51PWhUyGSL5P6U6a6oBpyBQjebMjCrX+lJkeV6JXTItY/BgyDU
         3+WWP53jgPxrCL8c6oomWcLe9GEfuZ7BcNhjCQjqC6FXESSR+E/63SvlMqbfAbTOJ3gi
         slA4mUtpAZAauis80C6zWcAwo7TYLDWYOo/X++81bGiUVQyz5+6j3oCGPQkmQgpFIw+l
         CFyw==
X-Gm-Message-State: AOJu0YyMGjIL6TMAwD3uTz/i4S1UeKcNSi+ZwF6u8zHGpGeXm+wCNaWU
	PPt012QmdLglE4K3Hrb3Mb8rY/PT/kmIAFTnHG/VpQ==
X-Google-Smtp-Source: AGHT+IEtIjr1f86Ll4Q97bmD9els2k6l3+wPfKL80sqsMUtZTff8dRmGfiY+mR8L+d5C9cxh35gQ+qwZwdcx8Fbii8I=
X-Received: by 2002:a17:90b:3884:b0:285:d803:8945 with SMTP id
 mu4-20020a17090b388400b00285d8038945mr6030411pjb.46.1701172248917; Tue, 28
 Nov 2023 03:50:48 -0800 (PST)
MIME-Version: 1.0
References: <20231128054457.659452-1-bhe@redhat.com>
In-Reply-To: <20231128054457.659452-1-bhe@redhat.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Tue, 28 Nov 2023 11:50:38 +0000
Message-ID: <CALrw=nEe195PSJywrkr5sPh_PnrLXG+ytvryG8CB-LHvmXpJkg@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, 
	eric_devolder@yahoo.com, agordeev@linux.ibm.com, 
	kernel-team <kernel-team@cloudflare.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_035051_905118_5A755ADD 
X-CRM114-Status: GOOD (  21.21  )
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

T24gVHVlLCBOb3YgMjgsIDIwMjMgYXQgNTo0NeKAr0FNIEJhb3F1YW4gSGUgPGJoZUByZWRoYXQu
Y29tPiB3cm90ZToKPgo+IElnbmF0IEtvcmNoYWdpbiBjb21wbGFpbmVkIHRoYXQgYSBwb3RlbnRp
YWwgY29uZmlnIHJlZ3Jlc3Npb24gd2FzCj4gaW50cm9kdWNlZCBieSBjb21taXQgODljZGU0NTU5
MTVmICgia2V4ZWM6IGNvbnNvbGlkYXRlIGtleGVjIGFuZAo+IGNyYXNoIG9wdGlvbnMgaW50byBr
ZXJuZWwvS2NvbmZpZy5rZXhlYyIpLiBCZWZvcmUgdGhlIGNvbW1pdCwKPiBDT05GSUdfQ1JBU0hf
RFVNUCBoYXMgbm8gZGVwZW5kZW5jeSBvbiBDT05GSUdfS0VYRUMuIEFmdGVyIHRoZSBjb21taXQs
Cj4gQ1JBU0hfRFVNUCBzZWxlY3RzIEtFWEVDLiBUaGF0IGVuZm9yY2VzIHN5c3RlbSB0byBoYXZl
IENPTkZJR19LRVhFQz15Cj4gYXMgbG9uZyBhcyBDT05GSUdfQ1JBU0hfRFVNUD1ZIHdoaWNoIHBl
b3BsZSBtYXkgbm90IHdhbnQuCj4KPiBJbiBJZ25hdCdzIGNhc2UsIGhlIHNldHMgQ09ORklHX0NS
QVNIX0RVTVA9eSwgQ09ORklHX0tFWEVDX0ZJTEU9eSBhbmQKPiBDT05GSUdfS0VYRUM9biBiZWNh
dXNlIGtleGVjX2xvYWQgaW50ZXJmYWNlIGNvdWxkIGhhdmUgc2VjdXJpdHkgaXNzdWUgaWYKPiBr
ZXJuZWwvaW5pdHJkIGhhcyBubyBjaGFuY2UgdG8gYmUgc2lnbmVkIGFuZCB2ZXJpZmllZC4KPgo+
IENSQVNIX0RVTVAgaGFzIHNlbGVjdCBvZiBLRVhFQyBiZWNhdXNlIEVyaWMsIGF1dGhvciBvZiBh
Ym92ZSBjb21taXQsCj4gbWV0IGEgTEtQIHJlcG9ydCBvZiBidWlsZCBmYWlsdXJlIHdoZW4gcG9z
dGluZyBwYXRjaCBvZiBlYXJsaWVyIHZlcnNpb24uCj4gUGxlYXNlIHNlZSBiZWxvdyBsaW5rIHRv
IGdldCBkZXRhaWwgb2YgdGhlIExLUCByZXBvcnQ6Cj4KPiAgICAgaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzNlOGVlY2QxLWEyNzctMmNmYi02OTBlLTVkZTJlYjdiOTg4ZUBvcmFjbGUuY29t
L1QvI3UKPgo+IEluIGZhY3QsIHRoYXQgTEtQIHJlcG9ydCBpcyB0cmlnZ2VyZWQgYmVjYXVzZSBh
cm0ncyA8YXNtL2tleGVjLmg+IGlzCj4gd3JhcHBlZCBpbiBDT05GSUdfS0VYRUMgaWZkZWZmZXJ5
IHNjb3BlLiBUaGF0IGlzIHdyb25nLiBDT05GSUdfS0VYRUMKPiBjb250cm9scyB0aGUgZW5hYmxp
bmcvZGlzYWJsaW5nIG9mIGtleGVjX2xvYWQgaW50ZXJmYWNlLCBidXQgbm90IGtleGVjCj4gZmVh
dHVyZS4gUmVtb3ZpbmcgdGhlIHdyb25nbHkgYWRkZWQgQ09ORklHX0tFWEVDIGlmZGVmZmVyeSBz
Y29wZSBpbgo+IDxhc20va2V4ZWMuaD4gb2YgYXJtIGFsbG93cyB1cyB0byBkcm9wIHRoZSBzZWxl
Y3QgS0VYRUMgZm9yIENSQVNIX0RVTVAuCj4gTWVhbndoaWxlLCBjaGFuZ2UgYXJjaC9hcm0va2Vy
bmVsL01ha2VmaWxlIHRvIGxldCBtYWNoaW5lX2tleGVjLm8KPiByZWxvY2F0ZV9rZXJuZWwubyBk
ZXBlbmQgb24gS0VYRUNfQ09SRS4KPgo+IEZpeGVzOiBjb21taXQgODljZGU0NTU5MTVmICgia2V4
ZWM6IGNvbnNvbGlkYXRlIGtleGVjIGFuZCBjcmFzaCBvcHRpb25zIGludG8ga2VybmVsL0tjb25m
aWcua2V4ZWMiKQo+IFJlcG9ydGVkLWJ5OiBJZ25hdCBLb3JjaGFnaW4gPGlnbmF0QGNsb3VkZmxh
cmUuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPgoKVGVz
dGVkLWJ5OiBJZ25hdCBLb3JjaGFnaW4gPGlnbmF0QGNsb3VkZmxhcmUuY29tPiAjIGNvbXBpbGUt
dGltZSBvbmx5CmZvciB4ODYgYW5kIGFybQoKPiAtLS0KPiAgYXJjaC9hcm0vaW5jbHVkZS9hc20v
a2V4ZWMuaCB8IDQgLS0tLQo+ICBhcmNoL2FybS9rZXJuZWwvTWFrZWZpbGUgICAgIHwgMiArLQo+
ICBrZXJuZWwvS2NvbmZpZy5rZXhlYyAgICAgICAgIHwgMSAtCj4gIDMgZmlsZXMgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
aW5jbHVkZS9hc20va2V4ZWMuaCBiL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2tleGVjLmgKPiBpbmRl
eCBlNjI4MzJkY2JhNzYuLmE4Mjg3ZTdhYjlkNCAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybS9pbmNs
dWRlL2FzbS9rZXhlYy5oCj4gKysrIGIvYXJjaC9hcm0vaW5jbHVkZS9hc20va2V4ZWMuaAo+IEBA
IC0yLDggKzIsNiBAQAo+ICAjaWZuZGVmIF9BUk1fS0VYRUNfSAo+ICAjZGVmaW5lIF9BUk1fS0VY
RUNfSAo+Cj4gLSNpZmRlZiBDT05GSUdfS0VYRUMKPiAtCj4gIC8qIE1heGltdW0gcGh5c2ljYWwg
YWRkcmVzcyB3ZSBjYW4gdXNlIHBhZ2VzIGZyb20gKi8KPiAgI2RlZmluZSBLRVhFQ19TT1VSQ0Vf
TUVNT1JZX0xJTUlUICgtMVVMKQo+ICAvKiBNYXhpbXVtIGFkZHJlc3Mgd2UgY2FuIHJlYWNoIGlu
IHBoeXNpY2FsIGFkZHJlc3MgbW9kZSAqLwo+IEBAIC04Miw2ICs4MCw0IEBAIHN0YXRpYyBpbmxp
bmUgc3RydWN0IHBhZ2UgKmJvb3RfcGZuX3RvX3BhZ2UodW5zaWduZWQgbG9uZyBib290X3BmbikK
Pgo+ICAjZW5kaWYgLyogX19BU1NFTUJMWV9fICovCj4KPiAtI2VuZGlmIC8qIENPTkZJR19LRVhF
QyAqLwo+IC0KPiAgI2VuZGlmIC8qIF9BUk1fS0VYRUNfSCAqLwo+IGRpZmYgLS1naXQgYS9hcmNo
L2FybS9rZXJuZWwvTWFrZWZpbGUgYi9hcmNoL2FybS9rZXJuZWwvTWFrZWZpbGUKPiBpbmRleCBk
NTNmNTZkNmY4NDAuLjc3MTI2NGQ0NzI2YSAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybS9rZXJuZWwv
TWFrZWZpbGUKPiArKysgYi9hcmNoL2FybS9rZXJuZWwvTWFrZWZpbGUKPiBAQCAtNTksNyArNTks
NyBAQCBvYmotJChDT05GSUdfRlVOQ1RJT05fVFJBQ0VSKSArPSBlbnRyeS1mdHJhY2Uubwo+ICBv
YmotJChDT05GSUdfRFlOQU1JQ19GVFJBQ0UpICAgKz0gZnRyYWNlLm8gaW5zbi5vIHBhdGNoLm8K
PiAgb2JqLSQoQ09ORklHX0ZVTkNUSU9OX0dSQVBIX1RSQUNFUikgICAgKz0gZnRyYWNlLm8gaW5z
bi5vIHBhdGNoLm8KPiAgb2JqLSQoQ09ORklHX0pVTVBfTEFCRUwpICAgICAgICs9IGp1bXBfbGFi
ZWwubyBpbnNuLm8gcGF0Y2gubwo+IC1vYmotJChDT05GSUdfS0VYRUMpICAgICAgICAgICAgKz0g
bWFjaGluZV9rZXhlYy5vIHJlbG9jYXRlX2tlcm5lbC5vCj4gK29iai0kKENPTkZJR19LRVhFQ19D
T1JFKSAgICAgICArPSBtYWNoaW5lX2tleGVjLm8gcmVsb2NhdGVfa2VybmVsLm8KPiAgIyBNYWlu
IHN0YWZmcyBpbiBLUFJPQkVTIGFyZSBpbiBhcmNoL2FybS9wcm9iZXMvIC4KPiAgb2JqLSQoQ09O
RklHX0tQUk9CRVMpICAgICAgICAgICs9IHBhdGNoLm8gaW5zbi5vCj4gIG9iai0kKENPTkZJR19P
QUJJX0NPTVBBVCkgICAgICArPSBzeXNfb2FiaS1jb21wYXQubwo+IGRpZmYgLS1naXQgYS9rZXJu
ZWwvS2NvbmZpZy5rZXhlYyBiL2tlcm5lbC9LY29uZmlnLmtleGVjCj4gaW5kZXggN2FmZjI4ZGVk
MmY0Li4xY2MzYjFjNTk1ZDcgMTAwNjQ0Cj4gLS0tIGEva2VybmVsL0tjb25maWcua2V4ZWMKPiAr
KysgYi9rZXJuZWwvS2NvbmZpZy5rZXhlYwo+IEBAIC05Nyw3ICs5Nyw2IEBAIGNvbmZpZyBDUkFT
SF9EVU1QCj4gICAgICAgICBkZXBlbmRzIG9uIEFSQ0hfU1VQUE9SVFNfS0VYRUMKPiAgICAgICAg
IHNlbGVjdCBDUkFTSF9DT1JFCj4gICAgICAgICBzZWxlY3QgS0VYRUNfQ09SRQo+IC0gICAgICAg
c2VsZWN0IEtFWEVDCj4gICAgICAgICBoZWxwCj4gICAgICAgICAgIEdlbmVyYXRlIGNyYXNoIGR1
bXAgYWZ0ZXIgYmVpbmcgc3RhcnRlZCBieSBrZXhlYy4KPiAgICAgICAgICAgVGhpcyBzaG91bGQg
YmUgbm9ybWFsbHkgb25seSBzZXQgaW4gc3BlY2lhbCBjcmFzaCBkdW1wIGtlcm5lbHMKPiAtLQo+
IDIuNDEuMAo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
