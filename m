Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89821C3DA4A
	for <kexec@archiver.kernel.org>; Thu, 22 Aug 2024 10:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eIhz92jT3njzEAeTy80gI2bXYHgthRwDFShW4xCso+Y=; b=Z6WyXm4R46rovM
	FvXCetBFbErIFd4SOBSWUEcJg1wxffVxD4P3qilTOBZr0fOgbyR/t0f/iirQAaivVo8wBgRzrUdUn
	/9yGbKq4LDDFOUdyJM9msFvqw2wUdy+f+2ob1WULwQqyAPCM1tQ8gNBaif86emUXAdGPnrHlO6Xis
	ho/D3YJEWrzPwDbrN2UVj9aEUl0qYm6NCswM+rbEyk2kIYtUWJVHl/+d02wNvQNY64yXaHIuHimJq
	6sJS8Z105ftBL3ShJAdALSC3rfG2cVt7B1mBhUSnO49eV6qoEbrQqA1scCfqaV5pejhraAPzdDt/T
	bXqXosL/Mch0Qv150B4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh5PT-0000000CU0V-0alu;
	Thu, 22 Aug 2024 10:51:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh5PQ-0000000CTzs-2gfK
	for kexec@lists.infradead.org;
	Thu, 22 Aug 2024 10:51:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724323875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+h7ZCy1kJf6AIoz/obF45zUM8hMhISbyTBa2ni74eFA=;
	b=KXmWw3U5FjQ+peWc9pm1IKCv80mnBBuvhlukf+N2cfEuAQDdTgMHdIPhlGuy/MzXHpxy8B
	UaZaJcY3q0WedVG+A+tZV09tVHsjCjero2hHMSeTsubiZ0x2pVFBH6La8wQ9wCx43p2Hug
	a9evGo/1Vugl+trQhr0gUt8QqBvdmBA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-PTe1MAj1MRyyjqdzE9KIuQ-1; Thu, 22 Aug 2024 06:51:13 -0400
X-MC-Unique: PTe1MAj1MRyyjqdzE9KIuQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6bf7a4ff102so11612686d6.1
        for <kexec@lists.infradead.org>; Thu, 22 Aug 2024 03:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724323873; x=1724928673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+h7ZCy1kJf6AIoz/obF45zUM8hMhISbyTBa2ni74eFA=;
        b=THFv2M7lAl6aQ60G4w6JMmF9JYAOr7U0b+iYLpWxmh6AykhW3Ao7NcgAlIaqdwm4hc
         XR6YnbTUS9b+eB4NMZTX54uQLNKKjePgWCD4tC4ZzditUAig/NdxNRV47/Ow2CwYVmxH
         V63VGI+8jOlqg4HhxFD08+oicjgnHL2lpSpp6vlvO52qt+E3PN6Sme7G/xLf7keIWHvh
         eR8hWucxbPSxP9qLoHVFXbFs0of3lvERcs42YTdlt7FrHKtiwblXlvLnoyHYagE0j0DR
         yI49nzBwzlPtYg4q1NPl2EUTxsdoc/ng4TJwnbGhqmXj5jy1AnicLdJsOfZ6cb3CmHzP
         mshA==
X-Forwarded-Encrypted: i=1; AJvYcCWDeYz1ocQZHLuw8ZTyKnu/ZdIoOVzAHoJSjQsVIadSV8hjbxsVqX6IVnSNoXPN4MuXzJ5xMg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyUdpQB32Wv+tIXkXa6zI14rXJeY6b9UUOY5MGqG3VprbYs1fXs
	H+rCDHBetLhvDj1XQUnmbv8MuXKinoUJznsqR1FwlE15vvfKoAs4c19h84R9prHnOiP8MkBTBpg
	nNncgZA7KqA8dNZxrz4/cw0Xzu30EbhAAHwGEBK/Jx7tTcQVYxmvlLZSaVipk/YdHTC9gUq2fpc
	OTt6y0bfshoU8uUOlwdb4a0gGvakgtgloB
X-Received: by 2002:a05:6214:2b93:b0:6bf:60b8:d4d7 with SMTP id 6a1803df08f44-6c160c71354mr52700156d6.15.1724323873276;
        Thu, 22 Aug 2024 03:51:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECMvQR0VuHDPsLwc5r72CFhDMHvpNdsHZf14OCwK5hSOzEtc0/+0yf9mhnIndqwf2K8TJ897vRjSe7tccXEhQ=
X-Received: by 2002:a05:6214:2b93:b0:6bf:60b8:d4d7 with SMTP id
 6a1803df08f44-6c160c71354mr52699796d6.15.1724323872973; Thu, 22 Aug 2024
 03:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com> <CALu+AoQRdxJUpNK_eCjKJ=ydRZ4av2S3xBaz3CYJZp12xqm=jQ@mail.gmail.com>
In-Reply-To: <CALu+AoQRdxJUpNK_eCjKJ=ydRZ4av2S3xBaz3CYJZp12xqm=jQ@mail.gmail.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 22 Aug 2024 18:51:02 +0800
Message-ID: <CAF+s44TCvG3knnqyRbw=reaCRfh0_J76HO=ykF+J=ZFyoYZOCA@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Dave Young <dyoung@redhat.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_035116_774035_5C6E3DC1 
X-CRM114-Status: GOOD (  29.78  )
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

T24gVGh1LCBBdWcgMjIsIDIwMjQgYXQgMjoxN+KAr1BNIERhdmUgWW91bmcgPGR5b3VuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgMjIgQXVnIDIwMjQgYXQgMTM6NDIsIFBpbmdmYW4g
TGl1IDxwaWxpdUByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBXZWQsIEF1ZyAyMSwgMjAy
NCBhdCAxMDoyN+KAr1BNIExlbm5hcnQgUG9ldHRlcmluZwo+ID4gPG16eHJlYXJ5QDBwb2ludGVy
LmRlPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gTW8sIDE5LjA4LjI0IDIyOjUzLCBQaW5nZmFuIExp
dSAocGlsaXVAcmVkaGF0LmNvbSkgd3JvdGU6Cj4gPiA+Cj4gPiA+ID4gKioqIEJhY2tncm91bmQg
KioqCj4gPiA+ID4KPiA+ID4gPiBBcyBtb3JlIFBFIGZvcm1hdCBrZXJuZWwgaW1hZ2VzIGFyZSBp
bnRyb2R1Y2VkLCBpdCBwb3N0IGNoYWxsZW5nZSB0byBrZXhlYyB0bwo+ID4gPiA+IGNvcGUgd2l0
aCB0aGUgbmV3IGZvcm1hdC4KPiA+ID4gPgo+ID4gPiA+IEluIG15IGF0dGVtcHQgdG8gYWRkIHN1
cHBvcnQgZm9yIGFybTY0IHpib290IGltYWdlIGluIHRoZSBrZXJuZWwgWzFdLAo+ID4gPiA+IEFy
ZCBzdWdnZXN0ZWQgdXNpbmcgYW4gZW11bGF0b3IgdG8gdGFja2xlIHRoaXMgaXNzdWUuICBMYXN0
IHllYXIsIHdoZW4KPiA+ID4gPiBKYW4gdHJpZWQgdG8gaW50cm9kdWNlIFVLSSBzdXBwb3J0IGlu
IHRoZSBrZXJuZWwgWzJdLCBBcmQgbWVudGlvbmVkIHRoZQo+ID4gPiA+IGVtdWxhdG9yIGFwcHJv
YWNoIGFnYWluIFszXQo+ID4gPgo+ID4gPiBIbW0sIHN5c3RlbWQncyBzeXN0ZW1kLXN0dWIgY29k
ZSB0cmllcyB0byBsb2FkIGNlcnRhaW4gInNpZGUtY2FyIgo+ID4gPiBmaWxlcyBwbGFjZWQgbmV4
dCB0byB0aGUgVUtJLCB2aWEgdGhlIFVFRkkgZmlsZSBzeXN0ZW0gQVBJcy4gV2hhdCdzCj4gPiA+
IHlvdXIgaW50ZW50aW9uIHdpdGggdGhlIFVFRkkgZW11bGF0b3IgcmVnYXJkaW5nIHRoYXQ/IFRo
ZSBzaWRlY2FycyBhcmUKPiA+ID4gc29tZXdoYXQgaW1wb3J0YW50LCBiZWNhdXNlIHRoYXQncyBo
b3cgd2UgcGFyYW1ldGVyaXplIG90aGVyd2lzZQo+ID4gPiBzdHJpY3RseSBzZWFsZWQsIGltbXV0
YWJsZSBVS0lzLgo+ID4gPgo+ID4gSUlVQywgeW91IGFyZSByZWZlcnJpbmcgdG8gVUtJIGFkZG9u
cy4KPiA+Cj4gPiA+IEhlbmNlLCB3aGF0J3MgdGhlIHN0b3J5IHRoZXJlPyBpbXBsZW1lbnQgc29t
ZSBmb3JtIG9mIGZzIGRyaXZlciAoZm9yCj4gPiA+IHdoYXQgZnMgcHJlY2lzZWx5PykgaW4gdGhl
IGVtdWxhdG9yIHRvbz8KPiA+ID4KPiA+IEFzIGZvciBhZGRvbiwgdGhhdCBpcyBhIG1pc3Npbmcg
cGFydCBpbiB0aGlzIHNlcmllcy4gSSBoYXZlIG92ZXJsb29rZWQKPiA+IHRoaXMgaXNzdWUuIE9y
aWdpbmFsbHksIEkgdGhvdWdodCB0aGF0IHRoZXJlIHdhcyBubyBuZWVkIHRvIGltcGxlbWVudAo+
ID4gYSBkaXNrIGRyaXZlciBhbmQgdmZhdCBmaWxlIHN5c3RlbSwganVzdCBwcmVsb2FkIHRoZW0g
aW50byBtZW1vcnksIGFuZAo+ID4gZmluYWxseSBwcmVzZW50IHRoZW0gdGhyb3VnaCB0aGUgdWVm
aSBBUEkuIEkgd2lsbCB0YWtlIGEgY2xvc2VyIGxvb2sKPiA+IGF0IGl0IGFuZCBjaGV3IG9uIGl0
Lgo+ID4KPgo+IEhpIFBpbmdmYW4sCj4KPiBJZiBtb3JlIGFuZCBtb3JlIHN0dWZmIG5lZWRzIGNv
bWluZyBpbiwgIG5vdCBvbmx5IHRoZSBsaW1pdGVkIGJvb3QKPiBzZXJ2aWNlcyB0aGVuIGl0IHdp
bGwgYmUgd2F5IHRvbyBjb21wbGljYXRlZCBhbmQgaGFyZCB0byBtYWludGFpbiBhbmQKPiBkZWJ1
ZywgIGFsc28gdGhlIHR3byBrZXhlYyBjb2RlIHBhdGhzIGFyZSBkdXBsaWNhdGVkIHNvbWVob3cu
IEl0IGlzCj4gcmVhbGx5IGJhZC4uCj4KT0ssIEkgd2lsbCB0cnkgdG8ga2VlcCB0aGluZ3MgZWFz
aWVyLiBBbmQgd2hhdCBkbyB5b3UgbWVhbiBhYm91dCAiIHR3bwprZXhlYyBjb2RlIHBhdGhzIj8K
Cj4gSSBmb3Jnb3Qgd2h5IHdlIGNhbiBub3QganVzdCBleHRyYWN0IHRoZSBrZXJuZWwgZnJvbSBV
S0kgYW5kIHRoZW4gbG9hZAo+IGl0IGRpcmVjdGx5LCAgaWYgdGhlIGVtYmVkZGVkIGtlcm5lbCBp
cyBhbHNvIHNpZ25lZCBpdCBzaG91bGQgYmUgZ29vZD8KPgoKSSB0aGluayB0aGUgbWFpbiBjb25j
ZXJuIGlzIGFib3V0IHRoZSBzaWduYXR1cmUuCgpUaGFua3MsCgpQaW5nZmFuCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0
CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9rZXhlYwo=
