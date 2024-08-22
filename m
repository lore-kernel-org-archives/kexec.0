Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90FEC3DA4A
	for <kexec@archiver.kernel.org>; Thu, 22 Aug 2024 05:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=heqQY2sYUXol+cW4uozXyk0mOnDAFGmMxM2arCak2B0=; b=UOE5cG32bWPV18
	ZC1GvT6D2EjI58lCf1bk/MJMLu7IVZ18EgmkQB4QyM+T2MgG8pR6xuQ4aAMog+2PiURrvVOhrGKNE
	qb549DzCHJh2hvoc7WYG72YdKMguZz5NDELdsz3WSbtTVN6DvT8/bSelM02cD6Zri35+ypgpVIurg
	I8hgg7tBXV1G8fhBWWUE85V5x0noT3oBUEFc6V0lATVJpQO4kxAlxkXUu5h/nGcpxrFCCojj/dWPd
	DijAu0fOX0C0ldhwQiIcCJYl5DY/sHnsQUhE7HSVn/+0KlN4xt9B+AiDxusViMGy2wbM+IhnXmHN5
	P3D7K7AC0ITkU8dvl7fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh0af-0000000BV3s-1GVe;
	Thu, 22 Aug 2024 05:42:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh0ac-0000000BV2v-0pnJ
	for kexec@lists.infradead.org;
	Thu, 22 Aug 2024 05:42:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724305347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POmJdiV0VSWZbzyF9DzR22AxZLSfVLCRRZmOGu8DXAE=;
	b=SnGR8xCoV2H79HsGta+Ul1dPdlXZppfwKhCCXjRtQPUCjHH5x6wxQuNTbHWxaspTL49CJC
	TB9nL1jXqL0vU5UgJYR/0v2cT4BM18rM3ru5GNkjCR1Dyr9qXjSio6rGazwfM7C41ZiGee
	3nkbI++tU3WtDFV8n7ELAmeM9ZTWLrA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-G5Um2WusMtWj_9HPwEAfmA-1; Thu, 22 Aug 2024 01:42:25 -0400
X-MC-Unique: G5Um2WusMtWj_9HPwEAfmA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7a1d06f8e78so49074985a.3
        for <kexec@lists.infradead.org>; Wed, 21 Aug 2024 22:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724305345; x=1724910145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POmJdiV0VSWZbzyF9DzR22AxZLSfVLCRRZmOGu8DXAE=;
        b=ae9Ofb3NuxO8Jg3Z9m5bIkjdAnIa0jy4w3notiYwNkd5DA0U7Hm8gXDLTg7XKXaD+B
         29HMwi9zDmaXfL+12lutiERz+czgStDknZCyQTSxz3guAle2Q8BYQa2OqaWmVf2JyMgq
         sXMV2xjfOX3h71RFOrQrbcJeW3XtsWNuI2BJCVbAc9XxoTUgjcGBUBMKiYt04C9uavpr
         zy4Ebm5z/lLYY4IkEKMSun/EndPrm3Xn3XEffST3eXo5bspVIXn+pd5Rl2vc3OwSnXm2
         oi31p1dal7UcNbYUwemWoCGl+m3MfnloOih7uRmEr0ZapebS4MJVbl8snZGr/Fbpou44
         N54Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlbMioOUnhcHOKS+gjuMWpSTiV2DhKFyCg1EH2H8NN0wofbc+nzNkoKeSAqrrBKwumKWxGSw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx7ImimplDwGzHa6B4bGCDg4O0Bh1UvL/jzjLsjku1EBGjP1duO
	qqRDir0toGxhRnUt2SeEXtWkeZZVJW0p9imKkoPPhQNtf2P0QBUA++6xE90uKUoZ3Jbi+z0NJ5p
	GfIsf8yVCPAL6HhK4rBYHzNKkaLfbdlhH1ubFgWz3FpPYGgpzs3qR0ke79XRef3+myKtjFseC9y
	2TZfkIsAJFkmspE4ZNV55aVYB2xy+z6gRB
X-Received: by 2002:a05:6214:590a:b0:6bf:6a1d:bd32 with SMTP id 6a1803df08f44-6c155e32b6amr52213506d6.54.1724305345109;
        Wed, 21 Aug 2024 22:42:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElvJrntPKuDfwVGetI/C58C3ESzxqLa/dqLxQVN4fUwqqoca5WN3EJ+ZSDJ797qfFuc/4TtSX998fGB+XueXM=
X-Received: by 2002:a05:6214:590a:b0:6bf:6a1d:bd32 with SMTP id
 6a1803df08f44-6c155e32b6amr52213366d6.54.1724305344763; Wed, 21 Aug 2024
 22:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <ZsX5QNie3pzocSfT@gardel-login>
In-Reply-To: <ZsX5QNie3pzocSfT@gardel-login>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 22 Aug 2024 13:42:14 +0800
Message-ID: <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240821_224230_335865_54C118B5 
X-CRM114-Status: GOOD (  25.49  )
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

T24gV2VkLCBBdWcgMjEsIDIwMjQgYXQgMTA6MjfigK9QTSBMZW5uYXJ0IFBvZXR0ZXJpbmcKPG16
eHJlYXJ5QDBwb2ludGVyLmRlPiB3cm90ZToKPgo+IE9uIE1vLCAxOS4wOC4yNCAyMjo1MywgUGlu
Z2ZhbiBMaXUgKHBpbGl1QHJlZGhhdC5jb20pIHdyb3RlOgo+Cj4gPiAqKiogQmFja2dyb3VuZCAq
KioKPiA+Cj4gPiBBcyBtb3JlIFBFIGZvcm1hdCBrZXJuZWwgaW1hZ2VzIGFyZSBpbnRyb2R1Y2Vk
LCBpdCBwb3N0IGNoYWxsZW5nZSB0byBrZXhlYyB0bwo+ID4gY29wZSB3aXRoIHRoZSBuZXcgZm9y
bWF0Lgo+ID4KPiA+IEluIG15IGF0dGVtcHQgdG8gYWRkIHN1cHBvcnQgZm9yIGFybTY0IHpib290
IGltYWdlIGluIHRoZSBrZXJuZWwgWzFdLAo+ID4gQXJkIHN1Z2dlc3RlZCB1c2luZyBhbiBlbXVs
YXRvciB0byB0YWNrbGUgdGhpcyBpc3N1ZS4gIExhc3QgeWVhciwgd2hlbgo+ID4gSmFuIHRyaWVk
IHRvIGludHJvZHVjZSBVS0kgc3VwcG9ydCBpbiB0aGUga2VybmVsIFsyXSwgQXJkIG1lbnRpb25l
ZCB0aGUKPiA+IGVtdWxhdG9yIGFwcHJvYWNoIGFnYWluIFszXQo+Cj4gSG1tLCBzeXN0ZW1kJ3Mg
c3lzdGVtZC1zdHViIGNvZGUgdHJpZXMgdG8gbG9hZCBjZXJ0YWluICJzaWRlLWNhciIKPiBmaWxl
cyBwbGFjZWQgbmV4dCB0byB0aGUgVUtJLCB2aWEgdGhlIFVFRkkgZmlsZSBzeXN0ZW0gQVBJcy4g
V2hhdCdzCj4geW91ciBpbnRlbnRpb24gd2l0aCB0aGUgVUVGSSBlbXVsYXRvciByZWdhcmRpbmcg
dGhhdD8gVGhlIHNpZGVjYXJzIGFyZQo+IHNvbWV3aGF0IGltcG9ydGFudCwgYmVjYXVzZSB0aGF0
J3MgaG93IHdlIHBhcmFtZXRlcml6ZSBvdGhlcndpc2UKPiBzdHJpY3RseSBzZWFsZWQsIGltbXV0
YWJsZSBVS0lzLgo+CklJVUMsIHlvdSBhcmUgcmVmZXJyaW5nIHRvIFVLSSBhZGRvbnMuCgo+IEhl
bmNlLCB3aGF0J3MgdGhlIHN0b3J5IHRoZXJlPyBpbXBsZW1lbnQgc29tZSBmb3JtIG9mIGZzIGRy
aXZlciAoZm9yCj4gd2hhdCBmcyBwcmVjaXNlbHk/KSBpbiB0aGUgZW11bGF0b3IgdG9vPwo+CkFz
IGZvciBhZGRvbiwgdGhhdCBpcyBhIG1pc3NpbmcgcGFydCBpbiB0aGlzIHNlcmllcy4gSSBoYXZl
IG92ZXJsb29rZWQKdGhpcyBpc3N1ZS4gT3JpZ2luYWxseSwgSSB0aG91Z2h0IHRoYXQgdGhlcmUg
d2FzIG5vIG5lZWQgdG8gaW1wbGVtZW50CmEgZGlzayBkcml2ZXIgYW5kIHZmYXQgZmlsZSBzeXN0
ZW0sIGp1c3QgcHJlbG9hZCB0aGVtIGludG8gbWVtb3J5LCBhbmQKZmluYWxseSBwcmVzZW50IHRo
ZW0gdGhyb3VnaCB0aGUgdWVmaSBBUEkuIEkgd2lsbCB0YWtlIGEgY2xvc2VyIGxvb2sKYXQgaXQg
YW5kIGNoZXcgb24gaXQuCgo+IEFuZCByZWdhcmRpbmcgdHBtPyB0cG1zIHJlcXVpcmUgZHJpdmVy
cyBhbmQgaSBndWVzcyBhdCB0aGUgbW9tZW50IHVlZmkKPiBlbXVsYXRvciB3b3VsZCBydW4gdGhv
c2UgYXJlbid0IGF2YWlsYWJsZSBhbnltb3JlPyBidXQgd2UgcmVhbGx5Cj4gc2hvdWxkIGRvIGEg
c2VwYXJhdG9yIG1lYXN1cmVtZW50IHRoZW4uIChhbHNvIHRoZXJlIG5lZWRzIHRvIGJlIHNvbWUK
PiB3YXkgdG8gcGFzcyBvdmVyIG1lYXN1cmVtZW50IGxvZyBvZiB0aGF0IG1lYXN1cmVtZW50PykK
PgoKSXQgaXMgYSBwaXR5IHRoYXQgaXQgaXMgYSBjb21tb24gaXNzdWUgcGVyc2lzdGVudCB3aXRo
IGtleGVjLXJlYm9vdAprZXJuZWwgbm93YWRheXMuCkkgYW0gbm90IGZhbWlsaWFyIHdpdGggVFBN
IGFuZCBoYXZlIG5vIGNsZWFyIGlkZWEgZm9yIHRoZSB0aW1lIGJlaW5nLgooZW11bGF0aW5nIFBs
YXRmb3JtIENvbmZpZ3VyYXRpb24gUmVnaXN0ZXJzID8pLiAgQnV0IHNpbmNlIHRoaXMKZW11bGF0
b3IgaXMgaGVsZCBpbnNpZGUgYSBsaW51eCBrZXJuZWwgaW1hZ2UsIGFuZCB0aGUgVUtJJ3Mgc2ln
bmF0dXJlCmlzIGNoZWNrZWQgZHVyaW5nIGtleGVjX2ZpbGVfbG9hZC4gQWxsIG9mIHRoZW0gYXJl
IHNhZmUgZnJvbQptb2RpZmljYXRpb24sIHRoaXMgc2VjdXJpdHkgaXMgbm90IGFuIHVyZ2VudCBp
c3N1ZS4KClRoYW5rcyBmb3Igc2hhcmluZyB5b3VyIHRob3VnaHRzIGFuZCBpbnNpZ2h0cy4KCkJl
c3QgUmVnYXJkcywKClBpbmdmYW4KCj4gTGVubmFydAo+Cj4gLS0KPiBMZW5uYXJ0IFBvZXR0ZXJp
bmcsIEJlcmxpbgo+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
