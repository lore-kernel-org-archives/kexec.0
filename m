Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D82C001E0
	for <kexec@archiver.kernel.org>; Thu, 27 Jul 2023 11:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oT+Mv3LHLTv+tNBYIQW4qz95AXoBGAOkHzjAzl8AG6I=; b=RWqUHs/xJoY0Ga
	jtRaUS0viz56jR1WXtyUHx6/3L1F7QZX53LoMqMGLd1mSnr3s3gKoZltiJv8e1PMjp/LK38fAYinR
	ru0agJUyDly6wR1JjmRRmceCvxyD00S+qbFeJyNApHM3iWfj8xJhjItPD9926u7T7yNjjoPp6KBXP
	0l/ZGTM05JR4iHxpfvTnoaoktO0GwxsCJBPlzDSLK71uZbDGn/bvmpzWHz8y1HVdkKLu5mLd4OiK2
	R4bnhDPCVJJPB+5f/zU0L+pQBrVlalxRk2e/1FXJcLCVP5hwxSGmBer5AVUaG0/4BWHPkKyRMq4pl
	3MTFlbU8GBJuQlWEx4BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOyn1-00DCcU-2G;
	Thu, 27 Jul 2023 11:04:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOymu-00DCWJ-1S
	for kexec@lists.infradead.org;
	Thu, 27 Jul 2023 11:04:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690455845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dk3LN9ysCMp0nX/c571qwFAAMC2Qp+rntI/6p9s/CFU=;
	b=U3NuZVGQwSwuLwWTmTtzjcntHvaj3sRMmpjQhgDuhwFaJuUbnH6INY6nXRSiuWj2KciT8G
	q68MhdiUkFOENuXzBS+YR6HIPxreA+Zk7cdoSX2R/tbk9JTRY2vVPBCMmW2a07Ss+WVcUR
	6qUK+vGD6YoSFovCcOq8DCd05QNfwLg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-EPVRe_LBNdCJVxlHmAKjEg-1; Thu, 27 Jul 2023 07:04:04 -0400
X-MC-Unique: EPVRe_LBNdCJVxlHmAKjEg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-50daa85e940so541614a12.0
        for <kexec@lists.infradead.org>; Thu, 27 Jul 2023 04:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690455843; x=1691060643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dk3LN9ysCMp0nX/c571qwFAAMC2Qp+rntI/6p9s/CFU=;
        b=F4AWaPKM1Z9n8EPSbRx8JI8c5JYSjpRTk7AJRxJz56KGZpPppv9MWQ6TfVKcbfttWh
         V2VWIBPyxweNzaX9haF/Fxqu7d/lkvBnY6E45AWRGZ83h31QntZniknhcbIqEgkYpqcV
         NI4glz8vTgtjexjB3yFeb44Cn2G6CLI8kOr+ijU0N2S31vsdyAYFd/z5KCKk3nZ0aHeV
         5gm6GRiqfVaDyFz9DjzcUmQz3t2iEowx8++qw6PrIxiI8gobnmxgCSYOjjUlXKgspK6/
         JHaRET++7rzbOeOQTgxi8l44HB8U4loDf7bs9zd0F8C/BneFO2Bus+as5uFdzNDZhPhO
         k17g==
X-Gm-Message-State: ABy/qLbLfTbO5c9GUroIId/aHweueQjegZQDX/DGumyE0gi6pydjm5GN
	ZNmw7zBo6+ebDw1sGUs6+hs4nfWgptE1yZLPMG6QvHHOgmK9G7zl2hOmILXo+k7Fhg2C1iZ7dr1
	Yy6O1XAKBLRRf5a0J7ukrJRlo3VIPy1wehSTRsbBQFmpqL+iJ8Q==
X-Received: by 2002:a05:6402:1816:b0:522:3790:1303 with SMTP id g22-20020a056402181600b0052237901303mr1439878edy.32.1690455843444;
        Thu, 27 Jul 2023 04:04:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGVNw/Z6wVqm/KZzUEarit/lmkOUef30Ga5juO1p3ACM6osXPaYMMA5sLXXHwivu6UQMvBnH0lT00nmKBGSQa4=
X-Received: by 2002:a05:6402:1816:b0:522:3790:1303 with SMTP id
 g22-20020a056402181600b0052237901303mr1439861edy.32.1690455843131; Thu, 27
 Jul 2023 04:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com> <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local>
In-Reply-To: <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local>
From: Tao Liu <ltao@redhat.com>
Date: Thu, 27 Jul 2023 19:03:26 +0800
Message-ID: <CAO7dBbXJv9JzDbSa-DLT03+osYCQXNUXFwz63gbq=NGDxEVyEA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, ardb@kernel.org, linux-kernel@vger.kernel.org, 
	bhe@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230727_040408_711700_D0039518 
X-CRM114-Status: GOOD (  24.23  )
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

SGkgQm9yaXNsYXYsCgpTb3JyeSBmb3IgdGhlIGxhdGUgcmVzcG9uc2UuIEkgc3BlbnQgc29tZSB0
aW1lIHJldGVzdGluZyB5b3VyIHBhdGNoCmFnYWluc3QgNi41LjAtcmMxIGFuZCA2LjUuMC1yYzMs
IGFuZCBpdCBpcyBPSy4gU28KClJlcG9ydGVkLWFuZC10ZXN0ZWQtYnk6IFRhbyBMaXUgPGx0YW9A
cmVkaGF0LmNvbT4KCkFuZCB3aWxsIHdlIHVzZSB0aGlzIHBhdGNoIGFzIGEgd29ya2Fyb3VuZCBv
ciB3aWxsIHdlIHdhaXQgZm9yIGEKYmV0dGVyIHNvbHV0aW9uIGFzIHByb3Bvc2VkIGJ5IE1pY2hh
ZWw/CgpPbiBNb24sIEp1bCAxNywgMjAyMyBhdCAxMDoxNOKAr1BNIEJvcmlzbGF2IFBldGtvdiA8
YnBAYWxpZW44LmRlPiB3cm90ZToKPgo+IE9uIE1vbiwgSnVsIDE3LCAyMDIzIGF0IDA5OjUzOjA2
UE0gKzA4MDAsIFRhbyBMaXUgd3JvdGU6Cj4gPiAuLi5zbmlwLi4uCj4gPiBbICAgMjEuMzYwNzYz
XSAgbnZtZTBuMTogcDEgcDIgcDMKPiA+IFsgICAyMS4zNjQyMDddIGlnYyAwMDAwOjAzOjAwLjA6
IFBUTSBlbmFibGVkLCA0bnMgZ3JhbnVsYXJpdHkKPiA+IFsgICAyMS40MjEwOTddIHBwcyBwcHMx
OiBuZXcgUFBTIHNvdXJjZSBwdHAxCj4gPiBbICAgMjEuNDI1Mzk2XSBpZ2MgMDAwMDowMzowMC4w
ICh1bm5hbWVkIG5ldF9kZXZpY2UpICh1bmluaXRpYWxpemVkKTogUEhDIGFkZGVkCj4gPiBbICAg
MjEuNDU3MDA1XSBpZ2MgMDAwMDowMzowMC4wOiA0LjAwMCBHYi9zIGF2YWlsYWJsZSBQQ0llIGJh
bmR3aWR0aAo+ID4gKDUuMCBHVC9zIFBDSWUgeDEgbGluaykKPiA+IFsgICAyMS40NjUyMTBdIGln
YyAwMDAwOjAzOjAwLjAgZXRoMTogTUFDOiAuLi5zbmlwLi4uCj4gPiBbICAgMjEuNDczNDI0XSBp
Z2MgMDAwMDowMzowMC4wIGVucDNzMDogcmVuYW1lZCBmcm9tIGV0aDEKPiA+IFsgICAyMS40Nzk0
NDZdIEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgYWRkcmVzczogMDAwMDAw
MDAwMDAwMDAwOAo+ID4gWyAgIDIxLjQ4NjQwNV0gI1BGOiBzdXBlcnZpc29yIHJlYWQgYWNjZXNz
IGluIGtlcm5lbCBtb2RlCj4gPiBbICAgMjEuNDkxNTE5XSBtbWMxOiBGYWlsZWQgdG8gaW5pdGlh
bGl6ZSBhIG5vbi1yZW1vdmFibGUgY2FyZAo+ID4gWyAgIDIxLjQ5MTUzOF0gI1BGOiBlcnJvcl9j
b2RlKDB4MDAwMCkgLSBub3QtcHJlc2VudCBwYWdlCj4gPiBbICAgMjEuNTAyMjI5XSBQR0QgMCBQ
NEQgMAo+ID4gWyAgIDIxLjUwNDc3M10gT29wczogMDAwMCBbIzFdIFBSRUVNUFQgU01QIE5PUFRJ
Cj4gPiBbICAgMjEuNTA5MTMzXSBDUFU6IDMgUElEOiA0MDIgQ29tbTogc3lzdGVtZC11ZGV2ZCBO
b3QgdGFpbnRlZCA2LjUuMC1yYzErICMxCj4gPiBbICAgMjEuNTE1OTA1XSBIYXJkd2FyZSBuYW1l
OiAuLi5zbmlwLi4uCj4gPiBbICAgMjEuNTIyODUxXSBSSVA6IDAwMTA6a2VybmZzX2RvcF9yZXZh
bGlkYXRlKzB4MmIvMHgxMjAKPgo+IFNvIHNvbWV0aGluZydzIHdlaXJkIGhlcmUgLSBteSBwYXRj
aCBzaG91bGQgbm90IGNhdXNlIGEgbnVsbCBwdHIgZGVyZWYKPiBoZXJlLgoKVGhlIHJhbmRvbSBr
ZXJuZWwgcGFuaWMgSSBlbmNvdW50ZXJlZCBpcyBpcnJlbGV2YW50IHRvIHRoaXMgcGF0Y2gsIGFu
ZApJJ20gcHJldHR5IHN1cmUgaXQgaXMgY2F1c2VkIGJ5IHNvbWUgZHJpdmVyLCBoaWdobHkgc3Vz
cGljaW91cyBpdCBpcwp0aGUgZ3JhcGhpYyBjYXJkIGRyaXZlciBpOTE1LmtvLiBXaGVuIEkgYXBw
bHkgdGhpcyBwYXRjaCwgMSkKZGlzY29ubmVjdCB0aGUgbW9uaXRvcih1c2luZyBzZXJpYWwgcG9y
dCB0byBsb2dpbikgYW5kIGtlZXAgaTkxNSwgb3IKMikgY29ubmVjdCB0aGUgbW9uaXRvciBidXQg
cmVtb3ZlIGk5MTUsIHRoZSBrZXhlYyBrZXJuZWwgd2lsbCBub3QKZmFpbC4gVGhvdWdoIGk5MTUg
aGFzIHByb3ZpZGVkIGEgcGNpIHNodXRkb3duIGZ1bmN0aW9uLCBtYXliZSBzb21lIGJ1Zwp0cmln
Z2VyZWQgYW5kIGNhdXNlZCBtZW1vcnkgb3ZlcndyaXRlIGFmdGVyIGtleGVjLiBBbnl3YXksIGl0
IGlzCmFub3RoZXIgaXNzdWUuCgpUaGFua3MsClRhbyBMaXUKCj4KPiA+IFsgICAyMS41Mjc5OTVd
IENvZGU6IDFmIDQ0IDAwIDAwIDgzIGU2IDQwIDBmIDg1IDA3IDAxIDAwIDAwIDQxIDU1IDQxCj4g
PiA1NCA1NSA1MyA0OCA4YiA0NyAzMCA0OCA4OSBmYiA0OCA4NSBjMCAwZiA4NCBhMiAwMCAwMCAw
MCA0OCA4YiBhODcKPgo+IFRoaXMgbG9va3Mgd2VpcmQgdG9vLiBUaGVyZSdzIG5vICI8PiIgYnJh
Y2tldHMgZGVub3Rpbmcgd2hpY2ggYnl0ZSBpdAo+IHdhcyBleGFjdGx5IHdoZXJlIFJJUCBwb2lu
dGVkIHRvIHdoZW4gdGhlIE5VTEwgcHRyIGhhcHBlbmVkLgo+Cj4gRG8KPgo+IG1ha2UgZnMva2Vy
bmZzL2Rpci5zCj4KPiBhbmQgdXBsb2FkIGRpci5zIGFuZCB0aGUgZGlyLm8gZmlsZSBzb21ld2hl
cmUuCj4KPiBJbiBhbnkgY2FzZSwgbXkgcGF0Y2ggc2hvdWxkbid0IGJlIGNhdXNpbmcgdGhpcy4g
QXQgbGVhc3QgSSBkb24ndCBzZWUKPiBpdC4KPgo+IEknbSB0ZXN0aW5nIGEgYmV0dGVyIHZlcnNp
b24gb2YgdGhlIHBhdGNoIGFuZCBpdCBzaG91bGQgbm90IGNhdXNlIHRoaXMKPiB0aGluZyBldmVu
IGxlc3MuCj4KPiA+IFRoZSBzdGFjayB0cmFjZSBtYXkgbm90IGJlIHRoZSBzYW1lIGFsbCB0aGUg
dGltZSwgSSBkaWRuJ3QgZGl2ZSBkZWVwCj4gPiBpbnRvIHRoZSByb290IGNhdXNlLCBidXQgaXQg
bG9va3MgdG8gbWUgdGhlIHBhdGNoIHdpbGwgY2F1c2UgYW4KPiA+IHVua25vd24gaXNzdWUuIEFs
c28gSSB0ZXN0ZWQgdGhlIHBhdGNoIG9uIGtlcm5lbC01LjE0LjAtMzE4LmVsOSwgaXQKPgo+IFRo
aXMgaXMgdGhlIHVwc3RyZWFtIGtlcm5lbCBtYWlsaW5nIGxpc3Qgc28gdGhvc2UgRnJhbmtlbnN0
ZWluIGtlcm5lbHMKPiBhcmUgYWxsIGxlZnQgdG8geW91Lgo+Cj4gR29vZCBsdWNrLiA6LSkKPgo+
IC0tCj4gUmVnYXJkcy9HcnVzcywKPiAgICAgQm9yaXMuCj4KPiBodHRwczovL3Blb3BsZS5rZXJu
ZWwub3JnL3RnbHgvbm90ZXMtYWJvdXQtbmV0aXF1ZXR0ZQo+CgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9rZXhlYwo=
