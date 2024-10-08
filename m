Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84157CEF15B
	for <kexec@archiver.kernel.org>; Tue,  8 Oct 2024 11:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VbU4GHyH6aRKDO3DxfXQr+G71lbl+hvvJHvA7UiA300=; b=lTD8Fp3+ELFFVp
	gyG6kpCYxvT5xnNVArwQnCKuoj00xMVrSK8HptTnD2Gt3StatqnlQj9DEy0m9/9RRwdutDb0evRDF
	x3Uar7Lfzc3/jbK9t9Cy+7mECdW0TJlGRfLw1yS8ENnbnjxqQejdaqf77WcHsOjIIzbSxV5BcWbHv
	EtIqZ0SRRLSg/u9gSraQnXYHE2Xy6khy+w2/AwfoirPs2oV7waMQZe+MRjve9ICvf1C7qj4vqGVKH
	W337qPD9fW8V+yO+DtxuQBc4O+GwE5LxB0dCbZOjSpYec7awqGAyiOb1V+/Wg1oRrAT+DMu20OfKM
	WB1gnO+HQvz2lwYmJRTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy8sd-00000005jHt-0xc9;
	Tue, 08 Oct 2024 11:59:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy8sZ-00000005jFt-2DBQ
	for kexec@lists.infradead.org;
	Tue, 08 Oct 2024 11:59:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728388790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIFABVwlYN6z1gPY1Am/qwHJ+gGFXbVoWW3PcOPdoLQ=;
	b=Q+xcJE6KdIqwVj0zTk/sDNTIKs5sHNt4Ds25rP27jcckVN9ViWqSYVoav+9KU2A+0gl6FU
	4nnY+sadKF17zA3VEDIcYlfmRsVJC9m1pMU+cVo8WGBKy5FS4xpie1EVwPb3wbo9kbPlFa
	9b8G0p7m+Hy4JE7DvJWzDcIwipMgfiM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-VgBuZv8mM4CnVd-qVOfNOg-1; Tue, 08 Oct 2024 07:59:48 -0400
X-MC-Unique: VgBuZv8mM4CnVd-qVOfNOg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cb4619a542so107730286d6.0
        for <kexec@lists.infradead.org>; Tue, 08 Oct 2024 04:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728388788; x=1728993588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIFABVwlYN6z1gPY1Am/qwHJ+gGFXbVoWW3PcOPdoLQ=;
        b=kx3ZBDaPIAANlptI3ITgkgvh+xTfoHu25dWqavMabXr9ng9DEb4l6dX+mrHlkytJAm
         3zk5Svq1lcz+B+ipzbQ4wKOYJN6JSm271wnMgtasBABsWDHwGwF4dLOaNAyZFBwc4TVo
         sxExHSt/5hs/4l4makNvK/59ZUKV/RLW+dIALA2/VcDUpGtCel5M5Nyu54klYBfJzCU4
         scLBEnPnDQ427VxjiFZC3AgEK9O98Bb9l5kSEub0zHNNuepj6UtsVQnmv43u5T8SQ78A
         WZvD97SGz/zTpjYSKmbJSUgQdLK+4CkKakx5p9+FpDxyzwEa4Cgm6phKCrI50B504pBs
         rG3A==
X-Forwarded-Encrypted: i=1; AJvYcCXq2kOIIhFytsAIW7XK8ohrhqAc1O+mkjMdC2WWH/+a0l+PGADofMTc+BE4eyGKOCjuPaoKdw==@lists.infradead.org
X-Gm-Message-State: AOJu0YywJHbEKtIcrucoeF4pGUh2wIVxL1HRipSLi295SqciBhYaWslI
	sKBLvxJkSxN3zOW68nSE/13reF2aGtoQwGPPxwMM+YLZV2iKL9I5mt2o60RAY1tyEWahPSgkMIZ
	pwRFgqZXSBvXmizsI2zNxyIHGMw5rn1ePzlVHXUSg88ixGlAVaxOAxZ9WnE/Q6J017H9Xc/r1LY
	ca26vh9nelB3zgfZmxpRmqRBHLOvL5HCss
X-Received: by 2002:a05:6214:4341:b0:6cb:3d9e:4f0f with SMTP id 6a1803df08f44-6cb9a2ed6a6mr239302356d6.1.1728388788050;
        Tue, 08 Oct 2024 04:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyTU2oDPRA8pDwdxAwmkXFDkUDJtk+0gQ1yQnI6Iw1CeZllQSy0r3Wl4WVMcMUozYzPXRgfmAZg4oe2m9uSyE=
X-Received: by 2002:a05:6214:4341:b0:6cb:3d9e:4f0f with SMTP id
 6a1803df08f44-6cb9a2ed6a6mr239302016d6.1.1728388787608; Tue, 08 Oct 2024
 04:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
In-Reply-To: <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 8 Oct 2024 19:59:35 +0800
Message-ID: <CAF+s44RqwOXVQ_t=w922GAAdQAqx4H_EsccDmDd1h8qWAGvPBg@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Lennart Poettering <mzxreary@0pointer.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_045951_689099_DDB4ABA5 
X-CRM114-Status: GOOD (  36.83  )
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

T24gVGh1LCBBdWcgMjksIDIwMjQgYXQgMTowOOKAr0FNIEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtl
cm5lbC5vcmc+IHdyb3RlOgo+ClsuLi5dCj4KPiBUaGFua3MgZm9yIHB1dHRpbmcgdGhpcyBSRkMg
dG9nZXRoZXIuIFRoaXMgaXMgdXNlZnVsIHdvcmssIGFuZCBnaXZlcwo+IHVzIGZvb2QgZm9yIHRo
b3VnaHQgYW5kIGRpc2N1c3Npb24uCj4KPiBUaGVyZSBhcmUgYSBmZXcgcHJvYmxlbXMgdGhhdCBi
ZWNvbWUgYXBwYXJlbnQgd2hlbiBnb2luZyB0aHJvdWdoIHRoZXNlIGNoYW5nZXMuCj4KPiAxLiBJ
bXBsZW1lbnRpbmcgVUVGSSBlbnRpcmVseSBpcyBpbnRyYWN0YWJsZSwgYW5kIHVubmVjZXNzYXJ5
Lgo+IEltcGxlbWVudGluZyB0aGUgc3Vic2V0IG9mIFVFRkkgdGhhdCBpcyBhY3R1YWxseSBuZWVk
ZWQgdG8gYm9vdCBMaW51eAo+ICppcyogdHJhY3RhYmxlLCB0aG91Z2gsIGJ1dCB3ZSBuZWVkIHRv
IHdvcmsgdG9nZXRoZXIgdG8gd3JpdGUgdGhpcwo+IGRvd24gc29tZXdoZXJlLgo+ICAgLSB0aGUg
RUZJIHN0dWIgbmVlZHMgdGhlIGJvb3Qgc2VydmljZXMgZm9yIHRoZSBFRkkgbWVtb3J5IG1hcCBh
bmQKPiB0aGUgYWxsb2NhdGlvbiByb3V0aW5lcwo+ICAgLSBHUlVCIG5lZWRzIGJsb2NrIEkvTwo+
ICAgLSBzeXN0ZW1kLXN0dWIvVUtJIG5lZWRzIGZpbGUgSS9PIHRvIGxvb2sgZm9yIHNpZGVjYXJz
Cj4gICAtIGV0YyBldGMKPgoKSSBoYXZlIGNyZWF0ZWQgYSBnaXQgcmVwbyB0byBob2xkIHRoZSBy
ZWNvcmQgZm9yIHRoZSBjdXJyZW50IHN0YXR1cy4KW2h0dHBzOi8vZ2l0aHViLmNvbS9yaGtkdW1w
L2tleGVjX3VlZmkuZ2l0XQpBbmQgdWVmaV9zdWJzZXQubWQgcmVjb3JkcyB0aGUgbWluaW1hbCBy
ZXF1aXJlbWVudCBvZiB1ZWZpLgoKQnV0IEkgaGF2ZSBhIHF1ZXN0aW9uIGFib3V0ICJHUlVCIG5l
ZWRzIGJsb2NrIEkvTyIsIGlzIGl0IHJlcXVpcmVkPyBBcwpJIGtub3csIHRoZSBrZXJuZWwgaW1h
Z2UgZS5nLiBVS0ksIHpib290IHdpbGwgYmUgc3VwcG9ydGVkLiBCdXQgd2h5CnNob3VsZCBncnVi
IGJlIHN1cHBvcnRlZCB0b28/CgpUaGFua3MsCgpQaW5nZmFuCgo+IEkgaW1wbGVtZW50ZWQgYSBS
dXN0ICdlZmlsb2FkZXInIGNyYXRlIGEgd2hpbGUgYWdvIHRoYXQgZW5jYXBzdWxhdGVzCj4gbW9z
dCBvZiB0aGlzIChpdCBjYW4gYm9vdCBMaW51eC9hcm02NCBvbiBRRU1VIGFuZCBib290IHg4NiB2
aWEgR1JVQiBpbgo+IHVzZXIgc3BhY2UgKiopLiBBZGRpbmcgZmlsZSBJL08gdG8gdGhpcyBzaG91
bGQgYmUgc3RyYWlnaHQtZm9yd2FyZCAtCj4gYXMgTGVubmFydCBwb2ludHMgb3V0LCB3ZSBvbmx5
IG5lZWQgdGhlIHByb3RvY29sLCBpdCBkb2Vzbid0IG5lZWQgdG8KPiBiZSBiYWNrZWQgYnkgYW4g
YWN0dWFsIGZpbGUgc3lzdGVtLCBpdCBqdXN0IG5lZWRzIHRvIGJlIGFibGUgdG8gZXhwb3NlCj4g
b3RoZXIgZmlsZXMgaW4gdGhlIHJpZ2h0IHdheS4KPgo+IDIuIFJ1bm5pbmcgdGhlIFVFRkkgZW11
bGF0b3Igb24gYmFyZSBtZXRhbCBpcyBub3QgZ29pbmcgdG8gc2NhbGUuCj4gQ2xvbmluZyBVQVJU
IGRyaXZlciBjb2RlIGFuZCBNTVUgY29kZSBldGMgaXMgYSBjYW4gb2Ygd29ybXMgdGhhdCB5b3UK
PiB3YW50IHRvIGxlYXZlIGNsb3NlZC4gQW5kIGFzIExlbm5hcnQgcG9pbnRzIG91dCwgdGhlcmUg
aXMgb3RoZXIKPiBoYXJkd2FyZSAoVFBNKSB0aGF0IG5lZWRzIHRvIGJlIGFjY2Vzc2libGUgYXMg
d2VsbC4gUHJvdmlkaW5nIGEKPiBzZXBhcmF0ZSBzZXQgb2YgZHJpdmVycyBmb3IgYWxsIGhhcmR3
YXJlIHRoYXQgdGhlIEVGSSBlbXVsYXRvciBtYXkKPiBuZWVkIHRvIGFjY2VzcyBpcyBub3QgYSB0
cmFjdGFibGUgcHJvYmxlbSBlaXRoZXIuCj4KPiBUaGUgZml4IGZvciB0aGlzLCBhcyBJIHNlZSBp
dCwgaXMgdG8gcnVuIHRoZSBFRkkgZW11bGF0b3IgaW4gdXNlcgo+IHNwYWNlLCB0byB0aGUgcG9p
bnQgd2hlcmUgdGhlIHBheWxvYWQgY2FsbHMgRXhpdEJvb3RTZXJ2aWNlcygpLiBUaGlzCj4gd2ls
bCBhbGxvdyBhbGwgSS9PIGFuZCBtZW1vcnkgcHJvdG9jb2wgdG8gYmUgaW1wbGVtZW50ZWQgdHJp
dmlhbGx5LAo+IHVzaW5nIEMgbGlicmFyeSByb3V0aW5lcy4gSSBoYXZlIGEgY3J1ZGUgcHJvdG90
eXBlKiogb2YgdGhpcyBydW5uaW5nCj4gdG8gdGhlIHBvaW50IHdoZXJlIEV4aXRCb290U2Vydmlj
ZXMoKSBpcyBjYWxsZWQgKGFuZCB0aGVuIGl0IGNyYXNoZXMpLgo+IFRoZSB0cmlja3kgeWV0IGlu
dGVyZXN0aW5nIGJpdCBoZXJlIGlzIGhvdyB3ZSBtaWdyYXRlIGEgY2h1bmsgb2YgdXNlcgo+IHNw
YWNlIG1lbW9yeSB0byB0aGUgYmFyZSBtZXRhbCBjb250ZXh0IHRoYXQgd2lsbCBiZSBjcmVhdGVk
IGJ5IHRoZQo+IGtleGVjIHN5c2NhbGwgbGF0ZXIgKGluIHdoaWNoIHRoZSBjYWxsIHRvIEV4aXRC
b290U2VydmljZXMoKSB3b3VsZAo+IHJldHVybiBhbmQgcHJvY2VlZCB3aXRoIHRoZSBib290KS4g
QnV0IHRoZSBwcmluY2lwbGUgaXMgcmF0aGVyCj4gc3RyYWlnaHQtZm9yd2FyZCwgYW5kIHdvdWxk
IHBlcm1pdCB1cywgZS5nLiwgdG8ga2V4ZWMgYW4gT1MgaW5zdGFsbGVyCj4gdG9vLgo+Cj4gMy4g
V2UgbmVlZCB0byBmaWd1cmUgb3V0IGhvdyB0byBzdXBwb3J0IFRQTSBhbmQgUENScyBpbiB0aGUg
Y29udGV4dCBvZgo+IGtleGVjLiBUaGlzIGlzIGEgZnVuZGFtZW50YWwgaXNzdWUgd2l0aCB2ZXJp
ZmllZCBib290LCBnaXZlbiB0aGF0IHRoZQo+IGtleGVjIFBDUiBzdGF0ZSBpcyBuZWNlc3Nhcmls
eSBkaWZmZXJlbnQgZnJvbSB0aGUgYm9vdCBzdGF0ZSwgYW5kIHNvCj4gd2UgY2Fubm90IHJldXNl
IHRoZSBUUE0gZGlyZWN0bHkgaWYgd2Ugd2FudCB0byBwcmV0ZW5kIHRoYXQgd2UgYXJlCj4gZG9p
bmcgYW4gb3JkaW5hcnkgYm9vdCBpbiBrZXhlYy4gVGhlIGFsdGVybmF0aXZlIGlzIHRvIGxlYXZl
IHRoZSBUUE0KPiBpbiBhIHN0YXRlIHdoZXJlIHRoZSBrZXhlYyBrZXJuZWwgY2FuIGFjY2VzcyBp
dHMgc2VhbGVkIHNlY3JldHMsIGFuZAo+IG1vY2sgdXAgdGhlIFRDRzIgRUZJIHByb3RvY29scyB1
c2luZyBhIHNoaW0gdGhhdCBzaXRzIGJldHdlZW4gdGhlIFRQTQo+IGhhcmR3YXJlIChhcyB0aGUg
cmVhbCBUQ0cyIHByb3RvY29scyB3aWxsIGJlIGxvbmcgZ29uZSkgYW5kIHRoZSBFRkkKPiBwYXls
b2FkLiBCdXQgYXMgSSBzYWlkLCB0aGlzIGlzIGEgZnVuZGFtZW50YWwgaXNzdWUsIGFzIHRoZSBh
YmlsaXR5IHRvCj4gcHJldGVuZCB0aGF0IGEga2V4ZWMgYm9vdCBpcyBhIHByaXN0aW5lIGJvb3Qg
d291bGQgbWVhbiB0aGF0IHZlcmlmaWVkCj4gYm9vdCBpcyBicm9rZW4uCj4KPgo+IEFzIGZ1dHVy
ZSB3b3JrLCBJJ2QgbGlrZSB0byBwcm9wb3NlIHRvIGNvbGxhYm9yYXRlIG9uIHNvbWUgYWxpZ25t
ZW50Cj4gcmVnYXJkaW5nIGEgVUVGSSBiYXNlbGluZSBmb3IgTGludXgsIGkuZS4sIHRoZSBwYXJ0
cyB0aGF0IHdlIGFjdHVhbGx5Cj4gbmVlZCB0byBib290IExpbnV4Lgo+Cj4gRm9yIHRoaXMgc2Vy
aWVzIGluIHBhcnRpY3VsYXIsIEkgZG9uJ3Qgc2VlIGEgd2F5IGZvcndhcmQgd2hlcmUgd2UKPiBh
ZG9wdCB0aGlzIGFwcHJvYWNoLCBhbmQgY2FycnkgYWxsIHRoaXMgY29kZSBpbnNpZGUgdGhlIGtl
cm5lbC4KPgo+IFRoYW5rcy4KPiBBcmQuCj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVj
Cg==
