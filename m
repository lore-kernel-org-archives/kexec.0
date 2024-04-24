Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26C9C10F15
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 20:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C8HAte0Rin8gl2+l5GZ3lrA5doYFkSb9iaazdFoW4Uo=; b=RHb6/iJUg6JzJV
	PSertTMDEmrC5TylrO/oX8iYR8s2mDUGVoBAQ8H4qbVy6i6t6BPk9XY8tdcN1/nP1b52XIjLV2LQ7
	Ay0iKlzYZST2T2lOP7EnsBbsPTgh99OuxHBXdjJSL0rulY10+A66QvXPBSMK7i9TP2S2/NsRDSzL3
	l7MUV8R1ibB4OS9ryFY/w/CZO1p1KI6VFus4WbUc5VYzplJ/xVRzYMQIo4BUNOdYXB1IwFayb6N16
	h2TZH51esUBm8rJMTfKtsTefHPbPESmtrVM77CoWlsQH4u7eUtk/u2yJdUGbZf0ymrvNnoVa5ijQE
	WIGQOLNM21r9U9FyLRxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzinq-00000005mor-1p7R;
	Wed, 24 Apr 2024 20:01:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzhrc-00000005X54-1n4n
	for kexec@bombadil.infradead.org;
	Wed, 24 Apr 2024 19:01:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=C/9BAtndkfFaumCrUJiPVhEbeA1SDIK0JZwe5FMmllc=; b=BHuOBA8smuB91Ce5UpNL3QhEtC
	uDFD7m8dcw7W3UGb/begyrK+Bsy/xei5jqiZcdsS4Bz79Tswj+VnhEkHm7ZluljDmtFfwkwGCVbB5
	VgLFmISZ/uQLJQ7qbb3iT/934GU5/4H6u9L2H3JxXzQSsC5W2UEe+ZR5QaN9v6ZIShnwGbfku7S3K
	YAP1s3tCWVsgaObVSecO/XWKZjXcmg6f6E72faxCysVlREBLGBfOIzZDehiLvCqb+l8utLkRsoUCM
	J6IGjmjwuMdTw2ieFbWgJM/LxytOCiW7QFn8ch1QBF8T/IufUdv0mOBHYO5Td6w396/HeMyF8Wd4d
	Op2rYUDA==;
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzhrG-0000000EVjX-3zOV
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 19:00:59 +0000
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-51bab51e963so180825e87.1
        for <kexec@lists.infradead.org>; Wed, 24 Apr 2024 12:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713985240; x=1714590040; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/9BAtndkfFaumCrUJiPVhEbeA1SDIK0JZwe5FMmllc=;
        b=Q2leoptSf98qAqXzwAZDJZCOf4uPlwzaqFJdYJuTYGGyyrP18keTjEdjG7EAsh0hxy
         Tf3BaJ/zrPjzn5TfaqdFUAuvg5hGEBAUPvzsNxuwlttYqL35xBkN8WSXG1OuxoNTRR6b
         4A7D595AocKep1TzGoy9CAcw0Q23MWWjuJ2nIO6FEFS0W5gu2OaFzfN8eiST4uYUJliS
         F8T9eGBFCsrXgrYrnUK1q0O3N1J0uyR8/346ZzGzonj76Xv4LhdpWc064dYx3ZJEWmEH
         PFyeVZsR2kIqVvw59ofF7DkYZOPStTtIpLkXfbioqnh7d23ixwbt40DTeSI4KmI/3mKW
         0CYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713985240; x=1714590040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/9BAtndkfFaumCrUJiPVhEbeA1SDIK0JZwe5FMmllc=;
        b=f3zncltUD9pKWChFhtP0p2gEUQhFpjxrK1BZm1o0vKu6rMHF+zH3FQbQVzBeTRBq3L
         xUHfk2CMOC/LAMZ2/YfzWuhow2ZTACAYta/IPsTBVjO+9FNrF1y3P+3CGrMw4yTvOHBV
         KzH3jioDOIeNsELRiBuolsU4E3MFlmhszS8jMLDciF+NKIh8nAOecoGA6RVgIRBH2w+e
         hYOKLNWJZjeyYRoW+QxsYfb9ZHzMswMNpulPISEgenatCiYwUbnPYs7teSMUqW7WbSKh
         LFbU/UViK95TWh4l4HfzgAQM9fWI9Hxjwk+llO/5/2TpMDOcIrrDF8t89kv7jBt1C8bB
         j1ug==
X-Forwarded-Encrypted: i=1; AJvYcCUW/2rZYkCrrpYYpWaicMi4kWynVW0BErvL855wZUtYWuTOJXG2lzuORq3Oc1/LQV4rmSa3zX2C1yMs8LDCnId3jBuE9wR3vaGn
X-Gm-Message-State: AOJu0YyIq4fbpSzQOnA4Pd5mKEYrOmfYn20kVpSMI0AxD24E2/HfpP8K
	K5WE4IDlCGlsoXZSURDiMY+INLTdmqgxRo0YEXUr4sOSqDKK/nrMltP6bg+hDnH+jvmESQf6nSf
	HO1WGNwN5O1jU4/uZelAcpwZaWw==
X-Google-Smtp-Source: AGHT+IGEmd97FetLZJu0mAN91ayBFJQ9xH9F8cfXfx+F3E2f/agJ9cJde+HWlwi4T3gsTOtiOQ41z4M3hWPYLhL845E=
X-Received: by 2002:a19:e00f:0:b0:51c:10b4:1d01 with SMTP id
 x15-20020a19e00f000000b0051c10b41d01mr1231030lfg.21.1713985239330; Wed, 24
 Apr 2024 12:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
 <20240424155309.1719454-15-ardb+git@google.com> <CAMzpN2g3E3Pj1wso0rUR5EWrHqTuUePsOWcQGf29wNkMa0+G3w@mail.gmail.com>
 <CAMj1kXE4f7UERE-x4CghW3=wQrvT1b2ODRSX3z6QAoy_wSJjiw@mail.gmail.com>
In-Reply-To: <CAMj1kXE4f7UERE-x4CghW3=wQrvT1b2ODRSX3z6QAoy_wSJjiw@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 24 Apr 2024 15:00:27 -0400
Message-ID: <CAMzpN2iT+j_f4wOWGG4JtQCKyUUe4XCtqAO7Set7cqZw8DsB_g@mail.gmail.com>
Subject: Re: [RFC PATCH 4/9] x86/purgatory: Avoid absolute reference to GDT
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_200055_677339_F03F9064 
X-CRM114-Status: GOOD (  26.20  )
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

T24gV2VkLCBBcHIgMjQsIDIwMjQgYXQgMTo1M+KAr1BNIEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtl
cm5lbC5vcmc+IHdyb3RlOgo+Cj4gSGkgQnJpYW4sCj4KPiBUaGFua3MgZm9yIHRha2luZyBhIGxv
b2suCj4KPiBPbiBXZWQsIDI0IEFwciAyMDI0IGF0IDE5OjM5LCBCcmlhbiBHZXJzdCA8YnJnZXJz
dEBnbWFpbC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFdlZCwgQXByIDI0LCAyMDI0IGF0IDEyOjA2
4oCvUE0gQXJkIEJpZXNoZXV2ZWwgPGFyZGIrZ2l0QGdvb2dsZS5jb20+IHdyb3RlOgo+ID4gPgo+
ID4gPiBGcm9tOiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPgo+ID4gPgo+ID4gPiBU
aGUgcHVyZ2F0b3J5IGlzIGFsbW9zdCBlbnRpcmVseSBwb3NpdGlvbiBpbmRlcGVuZGVudCwgd2l0
aG91dCBhbnkgbmVlZAo+ID4gPiBmb3IgYW55IHJlbG9jYXRpb24gcHJvY2Vzc2luZyBhdCBsb2Fk
IHRpbWUgZXhjZXB0IGZvciB0aGUgcmVmZXJlbmNlIHRvCj4gPiA+IHRoZSBHRFQgaW4gdGhlIGVu
dHJ5IGNvZGUuIEdlbmVyYXRlIHRoaXMgcmVmZXJlbmNlIGF0IHJ1bnRpbWUgaW5zdGVhZCwKPiA+
ID4gdG8gcmVtb3ZlIHRoZSBsYXN0IFJfWDg2XzY0XzY0IHJlbG9jYXRpb24gZnJvbSB0aGlzIGNv
ZGUuCj4gPiA+Cj4gPiA+IFdoaWxlIHRoZSBHRFQgaXRzZWxmIG5lZWRzIHRvIGJlIHByZXNlcnZl
ZCBpbiBtZW1vcnkgYXMgbG9uZyBhcyBpdCBpcwo+ID4gPiBsaXZlLCB0aGUgR0RUIGRlc2NyaXB0
b3IgdGhhdCBpcyB1c2VkIHRvIHByb2dyYW0gdGhlIEdEVCBjYW4gYmUKPiA+ID4gZGlzY2FyZGVk
IHNvIGl0IGNhbiBiZSBhbGxvY2F0ZWQgb24gdGhlIHN0YWNrLgo+ID4gPgo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPgo+ID4gPiAtLS0KPiA+ID4g
IGFyY2gveDg2L3B1cmdhdG9yeS9lbnRyeTY0LlMgfCAxMCArKysrKysrLS0tCj4gPiA+ICAxIGZp
bGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+ID4gPgo+ID4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYvcHVyZ2F0b3J5L2VudHJ5NjQuUyBiL2FyY2gveDg2L3B1cmdh
dG9yeS9lbnRyeTY0LlMKPiA+ID4gaW5kZXggOTkxMzg3N2IwZGJlLi44ODg2NjFkOWRiOWMgMTAw
NjQ0Cj4gPiA+IC0tLSBhL2FyY2gveDg2L3B1cmdhdG9yeS9lbnRyeTY0LlMKPiA+ID4gKysrIGIv
YXJjaC94ODYvcHVyZ2F0b3J5L2VudHJ5NjQuUwo+ID4gPiBAQCAtMTYsNyArMTYsMTEgQEAKPiA+
ID4KPiA+ID4gIFNZTV9DT0RFX1NUQVJUKGVudHJ5NjQpCj4gPiA+ICAgICAgICAgLyogU2V0dXAg
YSBnZHQgdGhhdCBzaG91bGQgYmUgcHJlc2VydmVkICovCj4gPiA+IC0gICAgICAgbGdkdCBnZHQo
JXJpcCkKPiA+ID4gKyAgICAgICBsZWFxICAgIGdkdCglcmlwKSwgJXJheAo+ID4gPiArICAgICAg
IHB1c2hxICAgJXJheAo+ID4gPiArICAgICAgIHB1c2h3ICAgJGdkdF9lbmQgLSBnZHQgLSAxCj4g
PiA+ICsgICAgICAgbGdkdCAgICAoJXJzcCkKPiA+ID4gKyAgICAgICBhZGRxICAgICQxMCwgJXJz
cAo+ID4KPiA+IFRoaXMgbWlzYWxpZ25zIHRoZSBzdGFjaywgcHVzaGluZyAxNiBieXRlcyBvbiB0
aGUgc3RhY2sgYnV0IG9ubHkKPiA+IHJlbW92aW5nIDEwIChkZWNpbWFsKS4KPiA+Cj4KPiBwdXNo
dyBzdWJ0cmFjdHMgMiBmcm9tIFJTUCBhbmQgc3RvcmVzIGEgd29yZC4gU28gdGhlIHRvdGFsIHNp
emUgc3RvcmVkCj4gaXMgMTAgZGVjaW1hbCBub3QgMTYuCgpJIGRpZG4ndCBub3RpY2UgdGhlIHB1
c2h3LCBzaW5jZSBJIGRpZG4ndCB0aGluayBhIDE2LWJpdCBwdXNoIHdhcyBldmVuCnBvc3NpYmxl
IGluIDY0LWJpdCBtb2RlLiBVbmV4cGVjdGVkLCBidXQgY2xldmVyLgoKCkJyaWFuIEdlcnN0Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWls
aW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
