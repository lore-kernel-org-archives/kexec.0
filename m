Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C38C83F01
	for <kexec@archiver.kernel.org>; Thu, 31 Aug 2023 12:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nDMfav5G1/kTnbSYFcRNRCqZcE/F5JyKdYjyGv1LOJ8=; b=Etw099cLWOL4nZ
	bT+u/V7kaRR664eHawqm2kdNobA1a87AQZCw1XkpIJm7QrsLS0R8WrgQ/fiXchr7VcHDew7HgnqS7
	cSWhiSwmBpbmgMz7+p6AD5FwHanooNTnXIp1F3eSavfDokwcj8WbchtRrXEoHTf1EvkptpZvDuH7A
	TzyhGpApEB1nG5tvNHwgynyadjsmW79C2k1Ko8R5X4xMahJ3Ia8WTi4qnTA3aFjg99Ny1OhmYArrG
	X3vrJMxJ7Zo3MHRo5qfZGdb0etUsiKyPG0mlVH3OMWnPInuAVTejWwS0q19eQb4T1kf9NU3f/ReW5
	hKwZBBjitcOktO6ZBTNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbggl-00FGys-1A;
	Thu, 31 Aug 2023 12:22:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbggi-00FGy0-2u
	for kexec@lists.infradead.org;
	Thu, 31 Aug 2023 12:22:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693484533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSOEGxFz87m0ye0g3IzP1/eXKvdkuFQz3xBGryZ7gJY=;
	b=Qv3aBiP9AeFvyw3FxZjb3U9mEGI+WoE4GbXaMabz3Z6ymYAjkTqB4xzwjyBVztiwHyGPq1
	1FunRJBc6yc3HiYg1cs5Yu/BOLX2dt8JucWOPmmPrxK6ll0HVg02mj0zr2ny0zA3x851nS
	Mz034Y1cLEZoV4Ild4dnP/WShOjFm3w=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-AOBAnArQMkyo82mGJEX8IQ-1; Thu, 31 Aug 2023 08:22:12 -0400
X-MC-Unique: AOBAnArQMkyo82mGJEX8IQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5009005a5fdso379217e87.0
        for <kexec@lists.infradead.org>; Thu, 31 Aug 2023 05:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693484530; x=1694089330;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSOEGxFz87m0ye0g3IzP1/eXKvdkuFQz3xBGryZ7gJY=;
        b=lz29gx6GUSkG+3m4i9ghA/j3XTZS1MBG30X/PgoahxCG1qgoACb81dOBoHf0FlNM0g
         jOfrQcyLAoMObdjO8rsktu/TlafN0u2tPQ+cQ/fcDr/dDWfepirapjWqVnF6lOGAXyUb
         04HC06VSI8cLx6eJ42P8uoSghUyH71KoXiHZiF9MiIwO+vCOX0mBId7+BTNxg5/71wL/
         j/xghcKGpv0e88TspRq9fGlElqomLVvLp1MqIrEeLlU1MqYle4rJFVK2ABx8raqoC0o4
         JA6wjVyb2WoSEiAA5D5jFJ/wVYcScbGPplsFrDoTb/WRCB/iIUS1bur8hXPI7WvVVCxa
         fnQQ==
X-Gm-Message-State: AOJu0YxM3fXYRTCvMTAxHM8eA7Ec7Xg/LurtbvKp/YwXv3XonGWLPmxf
	G3PUFThaWljJ22aSXopFmVcrUo3auhi+jNw/VS2pRME0AkhJchirLgg2zwRlqo86+ojLm0KZ6if
	0wIBIxMLtvuPJftbcvuUR
X-Received: by 2002:ac2:4432:0:b0:4fd:cbd8:17c0 with SMTP id w18-20020ac24432000000b004fdcbd817c0mr3729092lfl.3.1693484530580;
        Thu, 31 Aug 2023 05:22:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5CjCYPDLiBCWT5zVq/nHUhJcr4QW0nSq7bjVUdz8KXgZTbSh2XNB92Vzw3Ab4jqk6Nh2Jcg==
X-Received: by 2002:ac2:4432:0:b0:4fd:cbd8:17c0 with SMTP id w18-20020ac24432000000b004fdcbd817c0mr3729057lfl.3.1693484530194;
        Thu, 31 Aug 2023 05:22:10 -0700 (PDT)
Received: from [10.32.64.120] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id f3-20020a7bc8c3000000b00401c595fcc7sm5011941wml.11.2023.08.31.05.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 05:22:09 -0700 (PDT)
Message-ID: <94b893ef37fe0cc0bcc52e8b54c62be3853a7bbb.camel@redhat.com>
Subject: Re: [PATCH 1/5] string.h: add array-wrappers for (v)memdup_user()
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Andy Shevchenko <andy@kernel.org>, 
 Eric Biederman <ebiederm@xmission.com>, Christian Brauner
 <brauner@kernel.org>, David Disseldorp <ddiss@suse.de>,  Luis Chamberlain
 <mcgrof@kernel.org>, Siddh Raman Pant <code@siddh.me>, Nick Alcock
 <nick.alcock@oracle.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>, VMware
 Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 dri-devel@lists.freedesktop.org,  linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org,  linux-hardening@vger.kernel.org, David Airlie
 <airlied@redhat.com>
Date: Thu, 31 Aug 2023 14:22:08 +0200
In-Reply-To: <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com>
References: <cover.1693386602.git.pstanner@redhat.com>
	 <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
	 <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230831_052217_008270_DA1A2532 
X-CRM114-Status: GOOD (  21.02  )
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

T24gV2VkLCAyMDIzLTA4LTMwIGF0IDE3OjExICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gT24gV2VkLCBBdWcgMzAsIDIwMjMgYXQgNDo0NuKAr1BNIFBoaWxpcHAgU3Rhbm5lciA8cHN0
YW5uZXJAcmVkaGF0LmNvbT4KPiB3cm90ZToKPiA+IAo+ID4gQ3VycmVudGx5LCB1c2VyIGFycmF5
IGR1cGxpY2F0aW9ucyBhcmUgc29tZXRpbWVzIGRvbmUgd2l0aG91dCBhbgo+ID4gb3ZlcmZsb3cg
Y2hlY2suIFNvbWV0aW1lcyB0aGUgY2hlY2tzIGFyZSBkb25lIG1hbnVhbGx5OyBzb21ldGltZXMK
PiA+IHRoZQo+ID4gYXJyYXkgc2l6ZSBpcyBjYWxjdWxhdGVkIHdpdGggYXJyYXlfc2l6ZSgpIGFu
ZCBzb21ldGltZXMgYnkKPiA+IGNhbGN1bGF0aW5nCj4gPiBuICogc2l6ZSBkaXJlY3RseSBpbiBj
b2RlLgo+ID4gCj4gPiBJbnRyb2R1Y2Ugd3JhcHBlcnMgZm9yIGFycmF5cyBmb3IgbWVtZHVwX3Vz
ZXIoKSBhbmQgdm1lbWR1cF91c2VyKCkKPiA+IHRvCj4gPiBwcm92aWRlIGEgc3RhbmRhcmRpemVk
IGFuZCBzYWZlIHdheSBmb3IgZHVwbGljYXRpbmcgdXNlciBhcnJheXMuCj4gPiAKPiA+IFRoaXMg
aXMgYm90aCBmb3IgbmV3IGNvZGUgYXMgd2VsbCBhcyByZXBsYWNpbmcgdXNhZ2Ugb2YKPiA+ICh2
KW1lbWR1cF91c2VyKCkKPiA+IGluIGV4aXN0aW5nIGNvZGUgdGhhdCB1c2VzLCBlLmcuLCBuICog
c2l6ZSB0byBjYWxjdWxhdGUgYXJyYXkKPiA+IHNpemVzLgo+IAo+IC4uLgo+IAo+ID4gLS0tIGEv
aW5jbHVkZS9saW51eC9zdHJpbmcuaAo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9zdHJpbmcuaAo+
IAo+IEknbSB3b25kZXJpbmcgaWYgdGhpcyBoYXMgbm8gc2lkZS1lZmZlY3RzIGFzIHN0cmluZy5o
L3N0cmluZy5jIElJUkMKPiBpcwo+IHVzZWQgYWxzbyBmb3IgZWFybHkgc3RhZ2VzIHdoZXJlIHNv
bWUgb2YgdGhlIEFQSXMgYXJlIG5vdCBhdmFpbGFibGUuCj4gCgpJIGZvcmdvdCB0byBhZGRyZXNz
IHRoaXMgcG9pbnQgaW4gbXkgcHJldmlvdXMgcmVwbHkuCgpXaG8ncyBnb2luZyB0byBkZWNpZGUg
d2hldGhlciB0aGlzIGlzIGEgcHJvYmxlbSBvciBub3Q/CgoKTXkgcGVyc29uYWwgZ3Vlc3MgaXMg
dGhhdCB0aGlzIGlzIHVubGlrZWx5IHRvIGJlIGEgcHJvYmxlbSBiZWNhdXNlCgogICBBLiBlaXRo
ZXIgKHYpbWVtZHVwX3VzZXIoKSBpcyBhdmFpbGFibGUsIGluIHdoaWNoIGNhc2UKICAgICAgKHYp
bWVtZHVwX2FycmF5X3VzZXIoKSB3aWxsIGFsd2F5cyB3b3JrIOKAk8KgCiAgIEIuIG9yICh2KW1l
bWR1cF91c2VyKCkgaXMgbm90IGF2YWlsYWJsZSwgd2hpY2ggd291bGQgY2F1c2UgdGhlIGNvZGUK
ICAgICAgdGhhdCBjdXJyZW50bHkgdXNlcyAodiltZW1kdXBfdXNlcigpIGZvciBjb3B5aW5nIGFy
cmF5cyB0byBmYWlsCiAgICAgIGFueXdheXMuCgoKUC4KCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2tleGVjCg==
