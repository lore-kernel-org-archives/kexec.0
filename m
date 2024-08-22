Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5927AC5320E
	for <kexec@archiver.kernel.org>; Thu, 22 Aug 2024 10:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M3ugSs7eCmmh33d4yRZXg7S88Rm++m9s06brRW+qhgw=; b=ofeCNC5N9f7zw7
	OdV4OML/h6xLUb4nlgA3NTqjtmQf7J1NOCuoJ14Vac45f+jPZ6HEfCc/SWvQvNbkTCACHqPqmCBIO
	+8EymOHKTRU7mo6IIHHvqqxWO/0ejouQAe/qANJDrW5Y47BzNzsfgnDMefEKhcVXNRZp5fsUAxdt0
	fzaI3FHDb5dw5Dgt3A+QZCa9NjumNzmHb9vB8epEs2hRewZRgxguAkwr2XwFz76N62erwKeTsDi1t
	MvGVywkshRtVDPyaonEYmFa0Jkz5IskWDMGN3SAJR3fKetHfsiILF4l7FY5vpQweg+afQVENXr2ec
	FRwAZiKpOmsEoqvXyIAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh5KI-0000000CTK6-4At4;
	Thu, 22 Aug 2024 10:45:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh5KG-0000000CTJS-0q79
	for kexec@lists.infradead.org;
	Thu, 22 Aug 2024 10:45:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724323554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mpnb3SemwFliUZ4/dS7d4EoXv878E5NLpOTu5i7vK3A=;
	b=KqLX8G3Xb/JKhBK0N09IzfDvATSuV2WQ/7y6RuUYsp9bQjZYIjqCYmBbCD0iWMSpL8Y/CU
	w9RhVx5oNiGJ4jtvAhcoSsTmCluenw2LSokokAQE2AT3/JXa0j4GBUG8DvfPQj5EzPdEck
	7+m8g+Tsi/j/vMr+mAHKKowpjpUNPgk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-GdJA3f8nPLquBmq2r6JEJA-1; Thu, 22 Aug 2024 06:45:50 -0400
X-MC-Unique: GdJA3f8nPLquBmq2r6JEJA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6bf7ad66ab7so34391106d6.1
        for <kexec@lists.infradead.org>; Thu, 22 Aug 2024 03:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724323550; x=1724928350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mpnb3SemwFliUZ4/dS7d4EoXv878E5NLpOTu5i7vK3A=;
        b=Gn+3UXeSE5KEBM7cEI22oduG1TOe/Cb6PN+TCwEy3sUwKw1uvs1mEJ0uyfdMgH4350
         JexOXjOchNcOCJ45S8wwHzUdA4kMti4qMlsfioCoouV+zL3kLoPx9ZJ3TmB0IDJCkavx
         X60S5oFUEWmDsyw0P0AlhRFIgrj6jDhJT25yHt8p3S3e5nBjP41GCtiY4cqI21bbxqEa
         yo60RsifWqF+xfUHBmfZzQakTlpgvUxtjT2uy8EyKRrZl3UTAciqf3pm9y/ApeOHhUEh
         jj7zceTpi6Z5F4yWEtZC0NQTELh8wPE3zBk2lh1gtwmw2XINgIt1IqoEKy257XiB50Rb
         BErA==
X-Forwarded-Encrypted: i=1; AJvYcCXDZ7YodVixVmz9O+2tG+8wORIeXuNKWvrQfiRRslEI9xNUx14KdDhgqwdLEyhAK/1wpXelug==@lists.infradead.org
X-Gm-Message-State: AOJu0YwNMSiBo0HwzkcfM4Oryl7IrbK1cBEjBSY2lIe2D6YQbnVns7wq
	L4kPz+TMR2f+rUy0g084hi01MxGqUDZLzy35afUQOvukKJSPoH4ODWlQDq/PxpYRC4CjdY3UFLQ
	FTxnUV0fVY8+KG5HT9KI99mRqzeRleDIDQXEF9dEOdWMIf04VHoNtuMIchVe/kPl1bbqz5vEOgF
	s4pVq5l3FgaJCk9aZ7zoQMvJSnXmJ2800a
X-Received: by 2002:a05:6214:2b93:b0:6bf:60b8:d4d7 with SMTP id 6a1803df08f44-6c160c71354mr52485536d6.15.1724323549904;
        Thu, 22 Aug 2024 03:45:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHDpqdsRgZKmZj2LlYLuSKDF48ze2sPIDVJNwTHfTXpNGLbI9DbeX+bnNBTGnZjFpbQMzRQrZC/Ggb2z0yJ5U=
X-Received: by 2002:a05:6214:2b93:b0:6bf:60b8:d4d7 with SMTP id
 6a1803df08f44-6c160c71354mr52485196d6.15.1724323549541; Thu, 22 Aug 2024
 03:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com> <Zsb1isJ2cYRp2jpj@gardel-login>
In-Reply-To: <Zsb1isJ2cYRp2jpj@gardel-login>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 22 Aug 2024 18:45:38 +0800
Message-ID: <CAF+s44TauSXk-gDgRHn=6CsQrAv8Q-QyGXkDJO+_sTh_yKde5w@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20240822_034556_365299_956D6DE3 
X-CRM114-Status: GOOD (  39.25  )
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

T24gVGh1LCBBdWcgMjIsIDIwMjQgYXQgNDoyM+KAr1BNIExlbm5hcnQgUG9ldHRlcmluZyA8bXp4
cmVhcnlAMHBvaW50ZXIuZGU+IHdyb3RlOgo+Cj4gT24gRG8sIDIyLjA4LjI0IDEzOjQyLCBQaW5n
ZmFuIExpdSAocGlsaXVAcmVkaGF0LmNvbSkgd3JvdGU6Cj4KPiAgPiBPbiBXZWQsIEF1ZyAyMSwg
MjAyNCBhdCAxMDoyN+KAr1BNIExlbm5hcnQgUG9ldHRlcmluZwo+ID4gPG16eHJlYXJ5QDBwb2lu
dGVyLmRlPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gTW8sIDE5LjA4LjI0IDIyOjUzLCBQaW5nZmFu
IExpdSAocGlsaXVAcmVkaGF0LmNvbSkgd3JvdGU6Cj4gPiA+Cj4gPiA+ID4gKioqIEJhY2tncm91
bmQgKioqCj4gPiA+ID4KPiA+ID4gPiBBcyBtb3JlIFBFIGZvcm1hdCBrZXJuZWwgaW1hZ2VzIGFy
ZSBpbnRyb2R1Y2VkLCBpdCBwb3N0IGNoYWxsZW5nZSB0byBrZXhlYyB0bwo+ID4gPiA+IGNvcGUg
d2l0aCB0aGUgbmV3IGZvcm1hdC4KPiA+ID4gPgo+ID4gPiA+IEluIG15IGF0dGVtcHQgdG8gYWRk
IHN1cHBvcnQgZm9yIGFybTY0IHpib290IGltYWdlIGluIHRoZSBrZXJuZWwgWzFdLAo+ID4gPiA+
IEFyZCBzdWdnZXN0ZWQgdXNpbmcgYW4gZW11bGF0b3IgdG8gdGFja2xlIHRoaXMgaXNzdWUuICBM
YXN0IHllYXIsIHdoZW4KPiA+ID4gPiBKYW4gdHJpZWQgdG8gaW50cm9kdWNlIFVLSSBzdXBwb3J0
IGluIHRoZSBrZXJuZWwgWzJdLCBBcmQgbWVudGlvbmVkIHRoZQo+ID4gPiA+IGVtdWxhdG9yIGFw
cHJvYWNoIGFnYWluIFszXQo+ID4gPgo+ID4gPiBIbW0sIHN5c3RlbWQncyBzeXN0ZW1kLXN0dWIg
Y29kZSB0cmllcyB0byBsb2FkIGNlcnRhaW4gInNpZGUtY2FyIgo+ID4gPiBmaWxlcyBwbGFjZWQg
bmV4dCB0byB0aGUgVUtJLCB2aWEgdGhlIFVFRkkgZmlsZSBzeXN0ZW0gQVBJcy4gV2hhdCdzCj4g
PiA+IHlvdXIgaW50ZW50aW9uIHdpdGggdGhlIFVFRkkgZW11bGF0b3IgcmVnYXJkaW5nIHRoYXQ/
IFRoZSBzaWRlY2FycyBhcmUKPiA+ID4gc29tZXdoYXQgaW1wb3J0YW50LCBiZWNhdXNlIHRoYXQn
cyBob3cgd2UgcGFyYW1ldGVyaXplIG90aGVyd2lzZQo+ID4gPiBzdHJpY3RseSBzZWFsZWQsIGlt
bXV0YWJsZSBVS0lzLgo+ID4gPgo+ID4gSUlVQywgeW91IGFyZSByZWZlcnJpbmcgdG8gVUtJIGFk
ZG9ucy4KPgo+IFllYWgsIFVLSSBhZGRvbnMsIGFzIHdlbGwgYXMgY3JlZGVudGlhbCBmaWxlcywg
YW5kIHN5c2V4dC9jb25mZXh0Cj4gRERJcy4KPgo+IFRoZSBhZGRvbnMgYXJlIHRoZSBtb3N0IGlu
dGVyZXN0aW5nIGJ0dywgYmVjYXVzZSB3ZSBsb2FkIHRoZW0gaW50bwo+IG1lbW9yeSBhcyBQRSBm
aWxlcywgYW5kIGFzayB0aGUgVUVGSSB0byBhdXRoZW50aWNhdGUgdGhlbS4KPgo+ID4gPiBIZW5j
ZSwgd2hhdCdzIHRoZSBzdG9yeSB0aGVyZT8gaW1wbGVtZW50IHNvbWUgZm9ybSBvZiBmcyBkcml2
ZXIgKGZvcgo+ID4gPiB3aGF0IGZzIHByZWNpc2VseT8pIGluIHRoZSBlbXVsYXRvciB0b28/Cj4g
PiA+Cj4gPiBBcyBmb3IgYWRkb24sIHRoYXQgaXMgYSBtaXNzaW5nIHBhcnQgaW4gdGhpcyBzZXJp
ZXMuIEkgaGF2ZSBvdmVybG9va2VkCj4gPiB0aGlzIGlzc3VlLiBPcmlnaW5hbGx5LCBJIHRob3Vn
aHQgdGhhdCB0aGVyZSB3YXMgbm8gbmVlZCB0byBpbXBsZW1lbnQKPiA+IGEgZGlzayBkcml2ZXIg
YW5kIHZmYXQgZmlsZSBzeXN0ZW0sIGp1c3QgcHJlbG9hZCB0aGVtIGludG8gbWVtb3J5LCBhbmQK
PiA+IGZpbmFsbHkgcHJlc2VudCB0aGVtIHRocm91Z2ggdGhlIHVlZmkgQVBJLiBJIHdpbGwgdGFr
ZSBhIGNsb3NlciBsb29rCj4gPiBhdCBpdCBhbmQgY2hldyBvbiBpdC4KPgo+IEl0IGRvZXNuJ3Qg
aGF2ZSB0byBiZSBWRkFUIGJ0dy4gSXQganVzdCBoYXMgdG8gYmUgc29tZXRoaW5nLiBGb3IKPiBl
eGFtcGxlLCBpdCBtaWdodCBzdWZmaWNlIHRvIHRha2UgdGhlc2UgZmlsZXMsIHBhY2sgdGhlbSB1
cCBhcyBjcGlvIG9yCj4gc28gYW5kIHBhc3MgdGhlbSBhbG9uZyB3aXRoIHRoZSBVRUZJIGV4ZWN1
dGlvbi4gVGhlIFVFRkkgZW11bGF0b3IKPiB3b3VsZCB0aGVuIGhhdmUgdG8gZXhwb3NlIHRoZW0g
YXMgYSBmaWxlIHN5c3RlbSB0aGVuLgo+Cj4gV2UgYXJlIG5vdCB0YWxraW5nIG9mIGEgYmF6aWxs
aW9uIG9mIGZpbGVzIGhlcmUsIGl0J3MgbW9zdGx5IGEKPiBzbWFsbGlzaCBudW1iZXIgb2Ygc2lk
ZWNhciBmaWxlcyBJJ2QgZXhwZWN0Lgo+ClllcywgSSB0aGluayBhYm91dCB1c2luZyA8a2V5LCB2
YWx1ZT4sIHdoZXJlIGtleSBpcyB0aGUgZmlsZSBwYXRoLAp2YWx1ZSBpcyB0aGUgZmlsZSBjb250
ZW50LgoKPiA+ID4gQW5kIHJlZ2FyZGluZyB0cG0/IHRwbXMgcmVxdWlyZSBkcml2ZXJzIGFuZCBp
IGd1ZXNzIGF0IHRoZSBtb21lbnQgdWVmaQo+ID4gPiBlbXVsYXRvciB3b3VsZCBydW4gdGhvc2Ug
YXJlbid0IGF2YWlsYWJsZSBhbnltb3JlPyBidXQgd2UgcmVhbGx5Cj4gPiA+IHNob3VsZCBkbyBh
IHNlcGFyYXRvciBtZWFzdXJlbWVudCB0aGVuLiAoYWxzbyB0aGVyZSBuZWVkcyB0byBiZSBzb21l
Cj4gPiA+IHdheSB0byBwYXNzIG92ZXIgbWVhc3VyZW1lbnQgbG9nIG9mIHRoYXQgbWVhc3VyZW1l
bnQ/KQo+ID4KPiA+IEl0IGlzIGEgcGl0eSB0aGF0IGl0IGlzIGEgY29tbW9uIGlzc3VlIHBlcnNp
c3RlbnQgd2l0aCBrZXhlYy1yZWJvb3QKPiA+IGtlcm5lbCBub3dhZGF5cy4KPiA+IEkgYW0gbm90
IGZhbWlsaWFyIHdpdGggVFBNIGFuZCBoYXZlIG5vIGNsZWFyIGlkZWEgZm9yIHRoZSB0aW1lIGJl
aW5nLgo+ID4gKGVtdWxhdGluZyBQbGF0Zm9ybSBDb25maWd1cmF0aW9uIFJlZ2lzdGVycyA/KS4g
IEJ1dCBzaW5jZSB0aGlzCj4gPiBlbXVsYXRvciBpcyBoZWxkIGluc2lkZSBhIGxpbnV4IGtlcm5l
bCBpbWFnZSwgYW5kIHRoZSBVS0kncyBzaWduYXR1cmUKPiA+IGlzIGNoZWNrZWQgZHVyaW5nIGtl
eGVjX2ZpbGVfbG9hZC4gQWxsIG9mIHRoZW0gYXJlIHNhZmUgZnJvbQo+ID4gbW9kaWZpY2F0aW9u
LCB0aGlzIHNlY3VyaXR5IGlzIG5vdCBhbiB1cmdlbnQgaXNzdWUuCj4KPiBIbW0sIEknZCByZWFs
bHkgdGhpbmsgYWJvdXQgdGhpcyB3aXRoIHNvbWUgcHJpb3JpdHkuIFRoZSBtZWFzdXJlbWVudAo+
IHN0dWZmIHNob3VsZCBub3QgYmUgYW4gYWZ0ZXJ0aG91Z2h0LCBpdCB0eXBpY2FsbHkgaGFzIG1h
am9yCj4gaW1wbGljYXRpb25zIG9uIGhvdyB5b3UgZGVzaWduIHlvdXIgdHJhbnNpdGlvbnMsIGJl
Y2F1c2UgbWVhc3VyZW1lbnRzCj4gb2Ygc29tZSBjb21wb25lbnQgYWx3YXlzIG5lZWQgdG8gaGFw
cGVuICpiZWZvcmUqIHlvdSBwYXNzIGNvbnRyb2wgdG8KPiBpdCwgb3RoZXJ3aXNlIHRoZXkgYXJl
IHBvaW50bGVzcy4KPgoKT0ssIEkgd2lsbCBsb29rIGludG8gdGhlIGRldGFpbHMgb2YgVFBNIHRv
IHNlZSBob3cgdG8gYmFpbCBvdXQuCgpUaGFua3MsCgpQaW5nZmFuCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=
