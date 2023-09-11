Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB3CEE7FF4
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 06:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2SMbXUiAY04zh7Wrf5dvsV73DP3ODBtEAi90aFkN33w=; b=XyX/s6IxZI0i85
	+DWg6lEH4NQTpKYTN0a8A0GbgS3L/2EJpCdqzrd9dp95OJcmpTh0Clao33h9Thr7qqmm/1KmhW1QA
	h9pHuLiy4BQGvmfwORqE6e93W6L+4uMI3nL3NxvoPZTU9Un+bvdy6bQJdSmX0OIgLDKhDlolR4nJ+
	6oBo1XtGEOzlr22MwrwFl1sMN2tmHN1zBsq+UC7a10Y6gIFqI1mSRkHOTW+CEhECax2yhKxbCQ61O
	d51zdxNZkMN9Q2hk4fJYzMxMrISnFPWIP4eCfsjewhib1wrZm+vmRC5Je84ItXbNvuXQ+UhIz64u4
	CqXVFACniF1cBHM/fHjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfat0-00HMo6-2P;
	Mon, 11 Sep 2023 06:59:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfasy-00HMnG-0t
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 06:59:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694415542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oihrCx/51GvIUOiskZZtCUX0GlK6XGu37mMY6acgYXU=;
	b=RaEXubzPMxd/WkNrG+T31B1BO90zToZEcv1TAS3iPhoKethm9EYsGGYCMpxx6q+cwtAuTV
	cQ3NJuxhfKQM+REWl4akpi5EwEVwjRtjpNTG66voa7Hu4M7MKjcFqPxuK1PYjEArzsQbHU
	WQWrbtevZHbs/Rs9ibztqFoHELJ8SGo=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-TnFFobmCOnijlbWPsiETuQ-1; Mon, 11 Sep 2023 02:56:55 -0400
X-MC-Unique: TnFFobmCOnijlbWPsiETuQ-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7951cb322aeso96172539f.1
        for <kexec@lists.infradead.org>; Sun, 10 Sep 2023 23:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694415414; x=1695020214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oihrCx/51GvIUOiskZZtCUX0GlK6XGu37mMY6acgYXU=;
        b=mZStSckul4NtfLe8Vv1gscDeESY5oZ1Yf/aQlp9HyuqMMxV9TofQHSJmZp6ITqU8Ib
         GSK+uI0wZTPm942SAa018BaAy4zxvw4AO8vi6qtMPbBcmRzroQ17W7iLaLQ8U1qfvluY
         ZN4JilCD2VDpo9ZCbpvt/SzoP6BvYGyEag5hGqLPJRcTNxsC+kzYs/BZ5AEzvRnGIb2+
         lOQNGJNrvhmozSXv7YFhZHzbU9v3NxvnDfwbajgv5Pt35r/baN+QEWyKd3DQwx4/kxk/
         A3GwRPxDXd8sjGfBpFdbFFqQIYDOzaXk1Ur+xEvoowYHlaH7xohdSo4t8yGOGk5ba5kn
         Oang==
X-Gm-Message-State: AOJu0YzPcxXYw9ajqsp1XOFW3rBii0761FMCjnpBiH4Gp9WxP259TUVh
	90xkLg/2GjPZDNayPFshYdvcIg5ZZeP3r72lPBbws7pxG3pQTlVboeOWUoo8dnNYNEm3PpUg/Dp
	tpFeS41bYPQqtudJyyFJ86nl3j/NJbAbTh1Ao
X-Received: by 2002:a92:c087:0:b0:34f:36ae:e8d2 with SMTP id h7-20020a92c087000000b0034f36aee8d2mr9317096ile.3.1694415414373;
        Sun, 10 Sep 2023 23:56:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWzVZx4uLY0ZXfBjH7yOsx9fXZt5AC5zvCsH+DVV/WR5BNmh5v2LMfTp2OSLT8oU4BVVDpgnUtvHz5cjmj/5k=
X-Received: by 2002:a92:c087:0:b0:34f:36ae:e8d2 with SMTP id
 h7-20020a92c087000000b0034f36aee8d2mr9317077ile.3.1694415413992; Sun, 10 Sep
 2023 23:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230829114816.GA508985@ziqianlu-dell> <ZO3hQ0rbr8QuUjVI@debian.me>
 <20230829125134.GA509331@ziqianlu-dell> <20230829125939.bcg2r6hwqf45npko@box.shutemov.name>
 <20230829140451.GA509854@ziqianlu-dell> <20230907131409.masxz42ik6u456qp@box.shutemov.name>
 <20230908060230.GA283801@ziqianlu-dell> <20230908123233.dpbpohgrbyyxekzk@box.shutemov.name>
 <202309080856.F066F92C98@keescook> <CAGnOC3aG9BuoVEGs4LQhhczdhAF0gFBmXR7GXKAf4Z8FPTb1PQ@mail.gmail.com>
 <20230909113209.actnan6hczrclz2d@box.shutemov.name>
In-Reply-To: <20230909113209.actnan6hczrclz2d@box.shutemov.name>
From: Dave Young <dyoung@redhat.com>
Date: Mon, 11 Sep 2023 22:56:36 +0800
Message-ID: <CALu+AoSKpgbbKmsL8iuWpQB2ANqnhhfXR5pN5m0EsKZeFUBPkw@mail.gmail.com>
Subject: Re: kexec reboot failed due to commit 75d090fd167ac
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ard Biesheuvel <ardb@google.com>, Kees Cook <keescook@chromium.org>, 
	Aaron Lu <aaron.lu@intel.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Borislav Petkov <bp@alien8.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230910_235904_410832_C343E984 
X-CRM114-Status: GOOD (  39.75  )
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

QWRkIGtleGVjIGxpc3QgaW4gY2MKCk9uIFNhdCwgOSBTZXB0IDIwMjMgYXQgMTk6MzQsIEtpcmls
bCBBLiBTaHV0ZW1vdgo8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4gd3JvdGU6Cj4K
PiBPbiBGcmksIFNlcCAwOCwgMjAyMyBhdCAwNjoxNzo1M1BNICswMjAwLCBBcmQgQmllc2hldXZl
bCB3cm90ZToKPiA+IE9uIEZyaSwgU2VwIDgsIDIwMjMgYXQgNTo1OOKAr1BNIEtlZXMgQ29vayA8
a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gRnJpLCBTZXAgMDgs
IDIwMjMgYXQgMDM6MzI6MzNQTSArMDMwMCwgS2lyaWxsIEEuIFNodXRlbW92IHdyb3RlOgo+ID4g
PiA+IE9uIEZyaSwgU2VwIDA4LCAyMDIzIGF0IDAyOjAyOjMwUE0gKzA4MDAsIEFhcm9uIEx1IHdy
b3RlOgo+ID4gPiA+ID4gT24gVGh1LCBTZXAgMDcsIDIwMjMgYXQgMDQ6MTQ6MDlQTSArMDMwMCwg
S2lyaWxsIEEuIFNodXRlbW92IHdyb3RlOgo+ID4gPiA+ID4gPiBPbiBUdWUsIEF1ZyAyOSwgMjAy
MyBhdCAxMDowNDo1MVBNICswODAwLCBBYXJvbiBMdSB3cm90ZToKPiA+ID4gPiA+ID4gPiA+IENv
dWxkIHlvdSBzaG93IGRtZXNnIG9mIHRoZSBmaXJzdCBrZXJuZWwgYmVmb3JlIGtleGVjPwo+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gQXR0YWNoZWQuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiBCVFcsIGtleGVjIGlzIGludm9rZWQgbGlrZSB0aGlzOgo+ID4gPiA+ID4gPiA+IGt2ZXI9
Ni40LjAtcmM1LTAwMDA5LWc3NWQwOTBmZDE2N2EKPiA+ID4gPiA+ID4gPiBrZGlyPSRIT01FL2tl
cm5lbHMvJGt2ZXIKPiA+ID4gPiA+ID4gPiBzdWRvIGtleGVjIC1sICRrZGlyL3ZtbGludXotJGt2
ZXIgLS1pbml0cmQ9JGtkaXIvaW5pdHJhbWZzLSRrdmVyLmltZyAtLWFwcGVuZD0icm9vdD1VVUlE
PTQzODEzMjFlLWUwMWUtNDU1YS05ZDQ2LTVlOGM0YzViMmQwMiBybyBuZXQuaWZuYW1lcz0wIGFj
cGlfcnNkcD0weDcyOGU4MDE0IG5vX2hhc2hfcG9pbnRlcnMgc2NoZWRfdmVyYm9zZSBzZWxpbnV4
PTAiCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgaXQgaGFw
cGVucy4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gQ291bGQgeW91IGNoZWNrIGlmIHRoaXMgcGF0
Y2ggY2hhbmdlcyBhbnl0aGluZzoKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9taXNjLmMgYi9hcmNoL3g4Ni9ib290L2NvbXByZXNz
ZWQvbWlzYy5jCj4gPiA+ID4gPiA+IGluZGV4IDk0YjdhYmNmNjI0Yi4uMTcyYzQ3NmZmNmYzIDEw
MDY0NAo+ID4gPiA+ID4gPiAtLS0gYS9hcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvbWlzYy5jCj4g
PiA+ID4gPiA+ICsrKyBiL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9taXNjLmMKPiA+ID4gPiA+
ID4gQEAgLTQ1NiwxMCArNDU2LDEyIEBAIGFzbWxpbmthZ2UgX192aXNpYmxlIHZvaWQgKmV4dHJh
Y3Rfa2VybmVsKHZvaWQgKnJtb2RlLCBtZW1wdHIgaGVhcCwKPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gICBkZWJ1Z19wdXRzdHIoIlxuRGVjb21wcmVzc2luZyBMaW51eC4uLiAiKTsKPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gKyNpZiAwCj4gPiA+ID4gPiA+ICAgaWYgKGluaXRfdW5hY2NlcHRlZF9t
ZW1vcnkoKSkgewo+ID4gPiA+ID4gPiAgICAgICAgICAgZGVidWdfcHV0c3RyKCJBY2NlcHRpbmcg
bWVtb3J5Li4uICIpOwo+ID4gPiA+ID4gPiAgICAgICAgICAgYWNjZXB0X21lbW9yeShfX3BhKG91
dHB1dCksIF9fcGEob3V0cHV0KSArIG5lZWRlZF9zaXplKTsKPiA+ID4gPiA+ID4gICB9Cj4gPiA+
ID4gPiA+ICsjZW5kaWYKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gICBfX2RlY29tcHJlc3MoaW5w
dXRfZGF0YSwgaW5wdXRfbGVuLCBOVUxMLCBOVUxMLCBvdXRwdXQsIG91dHB1dF9sZW4sCj4gPiA+
ID4gPiA+ICAgICAgICAgICAgICAgICAgIE5VTEwsIGVycm9yKTsKPiA+ID4gPiA+ID4gLS0KPiA+
ID4gPiA+Cj4gPiA+ID4gPiBJdCBzb2x2ZWQgdGhlIHByb2JsZW0uCj4gPiA+ID4KPiA+ID4gPiBM
b29rcyBsaWtlIGluY3JlYXNpbmcgQk9PVF9JTklUX1BHVF9TSVpFIGZpeGVzIHRoZSBpc3N1ZS4g
SSBkb24ndCB5ZXQKPiA+ID4gPiB1bmRlcnN0YW5kIHdoeSBhbmQgaG93IHVuYWNjZXB0ZWQgbWVt
b3J5IGlzIGludm9sdmVkLiBJIHdpbGwgbG9vayBtb3JlCj4gPiA+ID4gaW50byBpdC4KPiA+ID4g
Pgo+ID4gPiA+IEVuYWJsaW5nIENPTkZJR19SQU5ET01JWkVfQkFTRSBhbHNvIG1ha2VzIHRoZSBp
c3N1ZSBnbyBhd2F5Lgo+ID4gPgo+ID4gPiBJcyB0aGlzIHBlcmhhcHMganVzdCBsdWNrPyBJLmUu
IGRvZXMgaXMgYnJlYWsgZXZlciBvbiwgc2F5LCAxMDAwIGJvb3QKPiA+ID4gYXR0ZW1wdHM/IChp
LmUuIG1heWJlIHNvbWUgcG9zaXRpb24gaXMgYmFkIGFuZCBLQVNMUiBoYXBwZW5zIHRvIHVzdWFs
bHkKPiA+ID4gYXZvaWQgaXQ/KQo+Cj4gWWVzLCBpdCBjYW4gYmUgbHVjay4KPgo+ID4gPiA+IEtl
ZXMsIG1heWJlIHlvdSBoYXZlIGEgY2x1ZT8KPiA+ID4KPiA+ID4gVGhlIG9ubHkgdGhpbmcgSSBj
YW4gdGhpbmsgb2YgaXMgdGhhdCBzb21ldGhpbmcgaXNuJ3QgYmVpbmcgY291bnRlZAo+ID4gPiBj
b3JyZWN0bHkgZHVlIHRvIHRoZSBzaXplIG9mIGNvZGUsIGFuZCBpdCBqdXN0IGhhcHBlbnMgdGhh
dCB0aGlzIGNvbW1pdAo+ID4gPiBtYWtlcyB0aGUgY29kZSBsYXJnZSBlbm91Z2ggdG8gZXhjZWVk
IHNvbWUgc2V0IG9mIG1hcHBpbmdzPwo+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2luY2x1ZGUvYXNtL2Jvb3QuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2Jvb3Qu
aAo+ID4gPiA+IGluZGV4IDkxOTEyODBkOWVhMy4uMjZjY2NlNDFkNzgxIDEwMDY0NAo+ID4gPiA+
IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2Jvb3QuaAo+ID4gPiA+ICsrKyBiL2FyY2gveDg2
L2luY2x1ZGUvYXNtL2Jvb3QuaAo+ID4gPiA+IEBAIC00MCw3ICs0MCw3IEBACj4gPiA+ID4gICNp
ZmRlZiBDT05GSUdfWDg2XzY0Cj4gPiA+ID4gICMgZGVmaW5lIEJPT1RfU1RBQ0tfU0laRSAgICAg
MHg0MDAwCj4gPiA+ID4KPiA+ID4gPiAtIyBkZWZpbmUgQk9PVF9JTklUX1BHVF9TSVpFICAoNio0
MDk2KQo+ID4gPiA+ICsjIGRlZmluZSBCT09UX0lOSVRfUEdUX1NJWkUgICg3KjQwOTYpCj4gPiA+
Cj4gPiA+IFRoYXQncyB3aHkgdGhpcyBtaWdodCBiZSB3b3JraW5nLCBmb3IgZXhhbXBsZT8gSG93
IGxhcmdlIGlzIHRoZSBib290Cj4gPiA+IGltYWdlIGJlZm9yZS9hZnRlciB0aGUgY29tbWl0LCBl
dGM/Cj4gPiA+Cj4gPgo+ID4gTm90IHN1cmUgd2h5IHRoZXNlIGNoYW5nZXMgd291bGQgbWFrZSBh
IGRpZmZlcmVuY2UgaGVyZSwgYnV0IGNob2tpbmcKPiA+IG9uIGFjY2VwdF9tZW1vcnkoKSBvbiBh
IG5vbi1URFggc3VnZ2VzdHMgdGhhdCBpbml0X3VuYWNjZXB0ZWRfbWVtb3J5KCkKPiA+IGlzIHBv
a2luZyBpbnRvIHVubWFwcGVkIG1lbW9yeSBiZWZvcmUgaXQgZXZlbiBkZWNpZGVzIHRoYXQgdGhl
Cj4gPiB1bmFjY2VwdGVkIG1lbW9yeSBkb2VzIG5vdCBleGlzdC4KPiA+Cj4gPiBpbml0X3VuYWNj
ZXB0ZWRfbWVtb3J5KCkgaGFzCj4gPgo+ID4gICAgICAgICByZXQgPSBlZmlfZ2V0X2NvbmZfdGFi
bGUoYm9vdF9wYXJhbXMsICZjZmdfdGFibGVfcGEsICZjZmdfdGFibGVfbGVuKTsKPiA+ICAgICAg
ICAgaWYgKHJldCkgewo+ID4gICAgICAgICAgICAgICAgIHdhcm4oIkVGSSBjb25maWcgdGFibGUg
bm90IGZvdW5kLiIpOwo+ID4gICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsKPiA+ICAgICAg
ICAgfQo+ID4KPiA+IHdoaWNoIGxvb2tzIGZvciA8Z3VpZCwgcGh5c19hZGRyPiB0dXBsZXMgaW4g
YW4gYXJyYXkgcG9pbnRlZCB0byBieSB0aGUKPiA+IEVGSSBzeXN0ZW0gdGFibGUsIGFuZCBpZiBl
aXRoZXIgb2YgdGhvc2UgaXMgbm90IG1hcHBlZCwgdGhpbmdzIGNhbiBiZQo+ID4gZXhwZWN0ZWQg
dG8gZXhwbG9kZS4KPiA+Cj4gPiBUaGUgb25seSBvZGQgdGhpbmcgdGhlcmUgaXMgdGhhdCB0aGlz
IGNvZGUgaXMgaW52b2tlZCBhZnRlciBzZXR0aW5nIHVwCj4gPiB0aGUgJ2RlbWFuZCBwYWdpbmcn
IGxvZ2ljIGluIHRoZSBkZWNvbXByZXNzb3IuCj4gPgo+ID4gSWYgeW91IGhhdmVuJ3QgeWV0LCBj
b3VsZCB5b3UgcGxlYXNlIHJldHJ5IHRoZSBrZXhlYyBib290IHdpdGgKPiA+IGVhcmx5cHJpbnRr
PXR0eTxpbnNlcnQgeW91ciBVQVJUIHBhcmFtcyBoZXJlPj8KPgo+IGVhcmx5IGNvbnNvbGUgaW4g
ZXh0cmFjdF9rZXJuZWwKPiBpbnB1dF9kYXRhOiAweDAwMDAwMDgwN2ViNDMzYTgKPiBpbnB1dF9s
ZW46IDB4MDAwMDAwMDAwMGQyNjI3MQo+IG91dHB1dDogMHgwMDAwMDA4MDdiMDAwMDAwCj4gb3V0
cHV0X2xlbjogMHgwMDAwMDAwMDA0ODAwYzEwCj4ga2VybmVsX3RvdGFsX3NpemU6IDB4MDAwMDAw
MDAwM2UyODAwMAo+IG5lZWRlZF9zaXplOiAweDAwMDAwMDAwMDRhMDAwMDAKPiB0cmFtcG9saW5l
XzMyYml0OiAweDAwMDAwMDAwMDAwOWQwMDAKPgo+IERlY29tcHJlc3NpbmcgTGludXguLi4gb3V0
IG9mIHBndF9idWYgaW4gYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL2lkZW50X21hcF82NC5jIT8K
PiBwYWdlcy0+cGd0X2J1Zl9vZmZzZXQ6IDB4MDAwMDAwMDAwMDAwNjAwMAo+IHBhZ2VzLT5wZ3Rf
YnVmX3NpemU6IDB4MDAwMDAwMDAwMDAwNjAwMAo+Cj4KPiBFcnJvcjoga2VybmVsX2lkZW50X21h
cHBpbmdfaW5pdCgpIGZhaWxlZAo+Cj4gSXQgY3Jhc2hlcyBvbiAjUEYgZHVlIHRvIHN0YmwtPm5y
X3RhYmxlcyBkZXJlZmVyZW5jZSBpbgo+IGVmaV9nZXRfY29uZl90YWJsZSgpIGNhbGxlZCBmcm9t
IGluaXRfdW5hY2NlcHRlZF9tZW1vcnkoKS4KPgo+IEkgZG9uJ3Qgc2VlIGFueXRoaW5nIHNwZWNp
YWwgYWJvdXQgc3RibCBsb2NhdGlvbjogMHg3NzVkNjAxOC4KPgo+IE9uZSBvdGhlciBiaXQgb2Yg
aW5mb3JtYXRpb246IGRpc2FibGluZyA1LWxldmVsIHBhZ2luZyBhbHNvIGhlbHBzIHRoZQo+IGlz
c3VlLgo+Cj4gSSB3aWxsIGRlYnVnIGZ1cnRoZXIuCj4KPiAtLQo+ICAgS2lyeWwgU2h1dHNlbWF1
IC8gS2lyaWxsIEEuIFNodXRlbW92Cj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
