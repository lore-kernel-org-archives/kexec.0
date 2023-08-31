Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473AAC83F32
	for <kexec@archiver.kernel.org>; Thu, 31 Aug 2023 12:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mlT737oX4xKUNQljwI40B5t4hFPNQFrLzGBnZPlerkQ=; b=K+RoTnrmwJyH/r
	UQgckWygZZpwYiJKQaaid9KwzpYjBvc7eH7RDXdhh0vC0O0K9ceFyHgUoyIHTja7fPZ6bCqK3aeXF
	Q902mlIlMKmMeC0bc7agoutk/gZhxZ+ZIIEjiRsF35Lv9j4Hzm7Y5ZgIXAam2t8JPfACkhdgFTF2v
	oA6+3IjyvyHTRqa46QACvYfMf9vBDxhijUzJaF1cfXBYLZNsiixyvNEGtszKr8dkdeAEkldeuc3j8
	OkQHs0KMjHBrAj/QgmsgWGIBjH5LoY+RnGFg/C9SY7hdmSwBuSZSvGNJ6GtaQbUVwRE6MzCzJbpFC
	S5+eA76Pa9Bk72qA+9iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbgbj-00FGY7-1S;
	Thu, 31 Aug 2023 12:17:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbgbf-00FGWs-2c
	for kexec@lists.infradead.org;
	Thu, 31 Aug 2023 12:17:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693484219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1TIPZiS5WiygpRoovt73Dy9nOHlU7oscs2x344MogyU=;
	b=QM8qKAGK9IbMC12Q/AkAwOOUxhcHEkaJE44UypwcxBVT3DZHx0zXKuJ8AqFpG+w2l1TOI7
	iBg4q95YWZKhKSkF2Wbr3fZ0ka5huN5LZP2C6jfRQUVLBCPRPK9lNTXmlV3aQl68PCnK0L
	Nzv6NTkmOEWsl0c0ltb8bjVSKkcoOJ0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-0DFbKjnsOkCu4S2b2-3Eyw-1; Thu, 31 Aug 2023 08:16:57 -0400
X-MC-Unique: 0DFbKjnsOkCu4S2b2-3Eyw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe246ec511so1275985e9.1
        for <kexec@lists.infradead.org>; Thu, 31 Aug 2023 05:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693484216; x=1694089016;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1TIPZiS5WiygpRoovt73Dy9nOHlU7oscs2x344MogyU=;
        b=jwqj8Xy7rfaBUJzU74oeu0iJFt8k2uN3OxfRhJ7laNHU2UhqXliRtQfz5b07KJqBG3
         vXO8qeogKAIX3wdn99ivKW7Yn1bNiJFVHr5LeEIFMn+b4vj1fqnRriUPeBvr1cWCtJSu
         DqFx28UxIxzOB7hnGLGLa52pavtNRtbh5XjZ3QUw0OoklNZ7+U0MyRJuyo/yufTQq//C
         IETvD5GM2RCX2u75Mh8hR2L0Jy+q+tSLx+u43ylNSxuRwlgtK1HeqZtJkeMAKi13tOXp
         BCjXuuUTaRD/RCtm1kU3zId3KkdmeDgECJDCDa4Rz8Ck+3nbUqAr7Fez4dvLz5LsAs4u
         rLeQ==
X-Gm-Message-State: AOJu0YxR4rEFoCdGlB5f8UksB7SfpHNGdaSKK6wvNFfXnhfiwrMZQJSe
	s9ETJZxfGJHYmgM0PqBbWx6sL55U/we6jbunwPHEo5WkCyTrVrcW6GLgSX32VQRV8A8hVB1D5eM
	SPCd8ju0PXbCiUHjTAtzt
X-Received: by 2002:a05:600c:5113:b0:401:c392:d28d with SMTP id o19-20020a05600c511300b00401c392d28dmr4029830wms.2.1693484216702;
        Thu, 31 Aug 2023 05:16:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGojultcfb0NIiOQPSvztdAjpKlNPabZq65nI0NSxG/DjDY/J8YCs5kvptoKVkC+FPxrHVegg==
X-Received: by 2002:a05:600c:5113:b0:401:c392:d28d with SMTP id o19-20020a05600c511300b00401c392d28dmr4029795wms.2.1693484216302;
        Thu, 31 Aug 2023 05:16:56 -0700 (PDT)
Received: from [10.32.64.120] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id z17-20020a7bc7d1000000b003fbdbd0a7desm4922787wmk.27.2023.08.31.05.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 05:16:55 -0700 (PDT)
Message-ID: <98bf616420e4ef3c7c18a1f52fda7cd410137f7d.camel@redhat.com>
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
Date: Thu, 31 Aug 2023 14:16:54 +0200
In-Reply-To: <CAHp75VdqFPJAnCm9A-S+TCChr9v9_s=Wfnb5wO2=vuwp1v+JvA@mail.gmail.com>
References: <cover.1693386602.git.pstanner@redhat.com>
	 <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
	 <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com>
	 <721a70c347d82931d12e5b75b19d132f82ee5ed2.camel@redhat.com>
	 <CAHp75VdS=kSWnz8FzHcdrZPaeZKsQNbzjE9mNN7BDvZA_nQpaA@mail.gmail.com>
	 <a4ba0493965ad32fcf95cd6e2439096668a9ed46.camel@redhat.com>
	 <CAHp75VdqFPJAnCm9A-S+TCChr9v9_s=Wfnb5wO2=vuwp1v+JvA@mail.gmail.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230831_051703_923703_D0B6602C 
X-CRM114-Status: GOOD (  21.18  )
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

T24gVGh1LCAyMDIzLTA4LTMxIGF0IDExOjU5ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gT24gV2VkLCBBdWcgMzAsIDIwMjMgYXQgMTA6MTXigK9QTSA8cHN0YW5uZXJAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4gPiBPbiBXZWQsIDIwMjMtMDgtMzAgYXQgMTc6MjkgKzAzMDAsIEFuZHkgU2hl
dmNoZW5rbyB3cm90ZToKPiA+ID4gT24gV2VkLCBBdWcgMzAsIDIwMjMgYXQgNToxOeKAr1BNIDxw
c3Rhbm5lckByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiBPbiBXZWQsIDIwMjMtMDgtMzAgYXQg
MTc6MTEgKzAzMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToKPiA+ID4gPiA+IE9uIFdlZCwgQXVn
IDMwLCAyMDIzIGF0IDQ6NDbigK9QTSBQaGlsaXBwIFN0YW5uZXIKPiA+ID4gPiA+IDxwc3Rhbm5l
ckByZWRoYXQuY29tPgo+ID4gPiBBbHBoYWJldGljYWwuCj4gPiA+IAo+ID4gPiBjb21waWxlci5o
Cj4gPiA+IGVyci5oCj4gPiA+IG92ZXJmbG93LmgKPiA+ID4gLi4udGhlIHJlc3QgdGhhdCBpcyBh
IGJpdCB1bm9yZGVyZWQuLi4KPiA+ID4gCj4gPiA+ID4gPiA+IMKgI2luY2x1ZGUgPGxpbnV4L3N0
ZGFyZy5oPgo+ID4gPiA+ID4gPiDCoCNpbmNsdWRlIDx1YXBpL2xpbnV4L3N0cmluZy5oPgo+ID4g
Cj4gPiBJIG1lYW4gSSBjb3VsZCBpbmNsdWRlIG15IG93biBpbiBhIHNvcnRlZCBtYW5uZXIg4oCT
IGJ1dCB0aGUgZXhpc3RpbmcKPiA+IG9uZXMgYXJlIG5vdCBzb3J0ZWQ6Cj4gCj4gSSBrbm93LCB0
aGF0J3Mgd2h5IEkgcHV0ICIodG8gc29tZSBleHRlbnQpIiBpbiBteSBpbml0aWFsIGNvbW1lbnQu
Cj4gCj4gPiBXZSBjb3VsZCBzb3J0IHRoZW0gYWxsLCBidXQgSSdkIHByZWZlciB0byBkbyB0aGF0
IGluIGEgc2VwYXJhdGUKPiA+IHBhdGNoCj4gPiBzbyB0aGF0IHRoaXMgY29tbWl0IGRvZXMgbm90
IG1ha2UgdGhlIGltcHJlc3Npb24gb2YgZG9pbmcgYW55dGhpbmcKPiA+IGVsc2UKPiA+IHRoYW4g
aW5jbHVkaW5nIHRoZSB0d28gbmV3IGhlYWRlcnMKPiAKPiBCdXQgeW91IGNhbiBkbyB5b3VyIHN0
dWZmIGZpcnN0IHdpdGggYmV0dGVyIG9yZGVyaW5nIHRoYW4geW91Cj4gcHJvcG9zZWQKPiBpbml0
aWFsbHksIHNvIHRoZXJlIHdpbGwgYmUgbGVzcyBjaHVybiBmb3IgYW55IGFkZGl0aW9uYWwgY2hh
bmdlCj4gKGVpdGhlciB0aGF0IHNpbXBseSB1bmlmaWVzIHRoZSB0aGluZyBvciBzb21ldGhpbmcg
ZWxzZSkuCj4gCj4gCgpJJ2xsIHRha2UgY2FyZSBvZiB0aG9zZSBwb2ludHMgaW4gYSB2MiBvbmNl
IEkgZ2F0aGVyZWQgc29tZSBtb3JlCmZlZWRiYWNrIGZyb20gdGhlIG90aGVyIHBhcnRpZXMuCgpQ
LgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVj
IG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
