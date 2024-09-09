Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AE5CD4F4C
	for <kexec@archiver.kernel.org>; Mon,  9 Sep 2024 05:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j6/v7ZrAdvYidwrvgJeAh7BqBBVSxL0fJkxHOI5dSug=; b=qKXAJM0EQbKyIB
	ZWFA48gXUKOk+gMYgNVfA5G+Yks6IKMce5oeMAGyBZpAn4JQnmQlJ7aFpVibxa28JZCru/K5/6K4g
	6Pu0oLiGrwFaUaem2p7GXa4TN65KK+ubE1jcloH644/CNo59nAdAmHBOsQp4iSuo3ft/ZcuGvhEmh
	6fWk+nXszSA2wRDplglSe670QRIaZsBd/U2MBOQjt9ynhbzvQLATlK3PCXkLwc/8Go6b8LfDnXX8p
	SNsIoUs2pYjRSdClC3TQwlGqiATfIddgyl1QVHz4GgXTv4ZO0orTBzLFZizG8Ncheok4DHggxKKp3
	k/+q94raBG60E+SLZ3oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snWsk-00000000Vg7-0bfN;
	Mon, 09 Sep 2024 05:24:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snWrt-00000000VVt-1x4v
	for kexec@lists.infradead.org;
	Mon, 09 Sep 2024 05:23:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725859396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzLkUxdBpwgP0gzmAUnHOrx/rBDL95koWZdpypmHSGY=;
	b=hzzyhXzX1Il0dkSoWQM+Br1q3ASrCwmET8WGEWOR0r8E6mK2K+/kTUG3p8z+qZMiRmmKVN
	AOz9foB8EHByrtF076zKVn2v31+f1SXGFVaylP0MkOcFPoYr7u4C/2MY39KAKxjhbg1qDK
	uFpu8nSAnh2vl2L2R0wfCAQZ4Yx7/Hk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-Ag5vyR1NOH6F5UWm4Ua-FA-1; Mon,
 09 Sep 2024 01:23:12 -0400
X-MC-Unique: Ag5vyR1NOH6F5UWm4Ua-FA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FD2B1955F06;
	Mon,  9 Sep 2024 05:23:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E18191956054;
	Mon,  9 Sep 2024 05:23:07 +0000 (UTC)
Date: Mon, 9 Sep 2024 13:23:02 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
Message-ID: <Zt6GNqIUbEl8M4QD@MiWiFi-R3L-srv>
References: <10c666ae-d528-4f49-82e9-8e0fee7099e0@linux.ibm.com>
 <355b58b1-6c51-4c42-b6ea-dcd6b1617a18@linux.ibm.com>
 <ZsLjGJvAUIaxrG6x@MiWiFi-R3L-srv>
 <1e4a8e18-cda9-45f5-a842-8ffcd725efc9@linux.ibm.com>
 <ZtGqTSMvx6Ljf5Xi@MiWiFi-R3L-srv>
 <0dd94920-b13f-4da7-9ea6-4f008af1f4b3@linux.ibm.com>
 <ZtkkIoUIu8shp/ut@MiWiFi-R3L-srv>
 <c6f30e31-69fe-4ece-b251-c49f1ab59a04@linux.ibm.com>
 <Zt18yUCWRK8178uv@MiWiFi-R3L-srv>
 <9eba8dc4-ceb3-4234-b352-aeb34c840e70@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9eba8dc4-ceb3-4234-b352-aeb34c840e70@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240908_222317_605727_5A3D37E4 
X-CRM114-Status: GOOD (  47.18  )
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

T24gMDkvMDkvMjQgYXQgMTA6MzVhbSwgU291cmFiaCBKYWluIHdyb3RlOgo+IAo+IAo+IE9uIDA4
LzA5LzI0IDE2OjAwLCBCYW9xdWFuIEhlIHdyb3RlOgo+ID4gT24gMDkvMDUvMjQgYXQgMDI6MDdw
bSwgU291cmFiaCBKYWluIHdyb3RlOgo+ID4gPiBIZWxsbyBCYW9xdWFuLAo+ID4gPiAKPiA+ID4g
T24gMDUvMDkvMjQgMDg6NTMsIEJhb3F1YW4gSGUgd3JvdGU6Cj4gPiA+ID4gT24gMDkvMDQvMjQg
YXQgMDI6NTVwbSwgU291cmFiaCBKYWluIHdyb3RlOgo+ID4gPiA+ID4gSGVsbG8gQmFvcXVhbiwK
PiA+ID4gPiA+IAo+ID4gPiA+ID4gT24gMzAvMDgvMjQgMTY6NDcsIEJhb3F1YW4gSGUgd3JvdGU6
Cj4gPiA+ID4gPiA+IE9uIDA4LzIwLzI0IGF0IDEyOjEwcG0sIFNvdXJhYmggSmFpbiB3cm90ZToK
PiA+ID4gPiA+ID4gPiBIZWxsbyBCYW9xdWFuLAo+ID4gPiA+ID4gPiA+IAo+ID4gPiA+IC4uLi4u
LnNuaXAuLi4KPiA+ID4gPiA+ID4gPiAyLiBBIHBhdGNoIHRvIHJldHVybiBlYXJseSBmcm9tIHRo
ZSBgY3Jhc2hfaGFuZGxlX2hvdHBsdWdfZXZlbnQoKWAgZnVuY3Rpb24KPiA+ID4gPiA+ID4gPiBp
ZiBga2V4ZWNfaW5fcHJvZ3Jlc3NgIGlzCj4gPiA+ID4gPiA+ID4gICAgwqDCoCBzZXQgdG8gVHJ1
ZS4gVGhpcyBpcyBlc3NlbnRpYWxseSBteSBvcmlnaW5hbCBwYXRjaC4KPiA+ID4gPiA+ID4gVGhl
cmUncyBhIHJhY2UgZ2FwIGJldHdlZW4gdGhlIGtleGVjX2luX3Byb2dyZXNzIGNoZWNraW5nIGFu
ZCB0aGUKPiA+ID4gPiA+ID4gc2V0dGluZyBpdCB0byB0cnVlIHdoaWNoIE1pY2hhZWwgaGFzIG1l
bnRpb25lZC4KPiA+ID4gPiA+IFRoZSB3aW5kb3cgd2hlcmUga2VybmVsIGlzIGhvbGRpbmcga2V4
ZWNfbG9jayB0byBkbyBrZXhlYyBib290Cj4gPiA+ID4gPiBidXQga2V4ZWNfaW5fcHJvZ3Jlc3Mg
aXMgeWV0IG5vdCBzZXQgdG8gVHJ1ZS4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gSWYga2VybmVsIG5l
ZWRzIHRvIGhhbmRsZSBjcmFzaCBob3RwbHVnIGV2ZW50LCB0aGUgZnVuY3Rpb24KPiA+ID4gPiA+
IGNyYXNoX2hhbmRsZV9ob3RwbHVnX2V2ZW50KCnCoCB3aWxsIG5vdCBnZXQgdGhlIGtleGVjX2xv
Y2sgYW5kCj4gPiA+ID4gPiBlcnJvciBvdXQgYnkgcHJpbnRpbmcgZXJyb3IgbWVzc2FnZSBhYm91
dCBub3QgYWJsZSB0byB1cGRhdGUKPiA+ID4gPiA+IGtkdW1wIGltYWdlLgo+ID4gPiA+IEJ1dCB5
b3Ugd2FudGVkIHRvIGF2b2lkIHRoZSBlcnJvcmluZyBvdXQgaWYgaXQncyBiZWluZyBpbgo+ID4g
PiA+IGtlcm5lbF9rZXhlYygpLiAgTm93IHlvdSBhcmUgc2VlaW5nIGF0IGxlYXN0IG9uZSB0aGUg
bm9pc2luZwo+ID4gPiA+IG1lc3NhZ2UsIGFyZW4ndCB5b3U/Cj4gPiA+IFllcywgYnV0IGl0IGlz
IHZlcnkgcmFyZSB0byBlbmNvdW50ZXIuCj4gPiA+IAo+ID4gPiBNeSBjb21tZW50cyBvbiB5b3Vy
IHVwZGF0ZWQgY29kZSBhcmUgaW5saW5lIGJlbG93Lgo+ID4gPiAKPiA+ID4gPiA+IEkgdGhpbmsg
aXQgc2hvdWxkIGJlIGZpbmUuIEdpdmVuIHRoYXQgbG9jayBpcyBhbHJlYWR5IHRha2VuIGZvcgo+
ID4gPiA+ID4ga2V4ZWMga2VybmVsIGJvb3QuCj4gPiA+ID4gPiAKPiA+ID4gPiA+IEFtIEkgbWlz
c2luZyBzb21ldGhpbmcgbWFqb3I/Cj4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gVGhhdCdzIHdoeSBJ
IHRoaW5rCj4gPiA+ID4gPiA+IG1heWJlIGNoZWNraW5nIGtleGVjX2luX3Byb2dyZXNzIGFmdGVy
IGZhaWxpbmcgdG8gcmV0cml2aW5nCj4gPiA+ID4gPiA+IF9fa2V4ZWNfbG9jayBpcyBhIGxpdHRs
ZSBiZXR0ZXIsIG5vdCB2ZXJ5IHN1cmUuCj4gPiA+ID4gPiBUcnkgZm9yIGtleGVjIGxvY2sgYmVm
b3JlIGtleGVjX2luX3Byb2dyZXNzIGNoZWNrIHdpbGwgbm90IHNvbHZlCj4gPiA+ID4gPiB0aGUg
b3JpZ2luYWwgcHJvYmxlbSB0aGlzIHBhdGNoIHRyeWluZyB0byBzb2x2ZS4KPiA+ID4gPiA+IAo+
ID4gPiA+ID4gWW91IHByb3Bvc2VkIHRoZSBiZWxvdyBjaGFuZ2VzIGVhcmxpZXI6Cj4gPiA+ID4g
PiAKPiA+ID4gPiA+IC0JaWYgKCFrZXhlY190cnlsb2NrKCkpIHsKPiA+ID4gPiA+ICsJaWYgKCFr
ZXhlY190cnlsb2NrKCkgJiYga2V4ZWNfaW5fcHJvZ3Jlc3MpIHsKPiA+ID4gPiA+ICAgIAkJcHJf
aW5mbygia2V4ZWNfdHJ5bG9jaygpIGZhaWxlZCwgZWxmY29yZWhkciBtYXkgYmUgaW5hY2N1cmF0
ZVxuIik7Cj4gPiA+ID4gPiAgICAJCWNyYXNoX2hvdHBsdWdfdW5sb2NrKCk7Cj4gPiA+ID4gQWgs
IEkgbWVhbnQgYXMgYmVsb3csIGJ1dCB3cm90ZSBpdCBtaXN0YWtlbmx5Lgo+ID4gPiA+IAo+ID4g
PiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvY3Jhc2hfY29yZS5jIGIva2VybmVsL2NyYXNoX2NvcmUu
Ywo+ID4gPiA+IGluZGV4IDYzY2Y4OTM5M2M2ZS4uZTdjN2FhNzYxZjQ2IDEwMDY0NAo+ID4gPiA+
IC0tLSBhL2tlcm5lbC9jcmFzaF9jb3JlLmMKPiA+ID4gPiArKysgYi9rZXJuZWwvY3Jhc2hfY29y
ZS5jCj4gPiA+ID4gQEAgLTUwNCw3ICs1MDQsNyBAQCBpbnQgY3Jhc2hfY2hlY2tfaG90cGx1Z19z
dXBwb3J0KHZvaWQpCj4gPiA+ID4gICAgCWNyYXNoX2hvdHBsdWdfbG9jaygpOwo+ID4gPiA+ICAg
IAkvKiBPYnRhaW4gbG9jayB3aGlsZSByZWFkaW5nIGNyYXNoIGluZm9ybWF0aW9uICovCj4gPiA+
ID4gLQlpZiAoIWtleGVjX3RyeWxvY2soKSkgewo+ID4gPiA+ICsJaWYgKCFrZXhlY190cnlsb2Nr
KCkgJiYgIWtleGVjX2luX3Byb2dyZXNzKSB7Cj4gPiA+ID4gICAgCQlwcl9pbmZvKCJrZXhlY190
cnlsb2NrKCkgZmFpbGVkLCBlbGZjb3JlaGRyIG1heSBiZSBpbmFjY3VyYXRlXG4iKTsKPiA+ID4g
PiAgICAJCWNyYXNoX2hvdHBsdWdfdW5sb2NrKCk7Cj4gPiA+ID4gICAgCQlyZXR1cm4gMDsKPiA+
ID4gPiAKPiA+ID4gPiAKPiA+ID4gPiA+IE9uY2UgdGhlIGtleGVjX2luX3Byb2dyZXNzIGlzIHNl
dCB0byBUcnVlIHRoZXJlIGlzIG5vIHdheSBvbmUgY2FuIGdldAo+ID4gPiA+ID4ga2V4ZWNfbG9j
ay4gU28ga2V4ZWNfdHJ5bG9jaygpIGJlZm9yZSBrZXhlY19pbl9wcm9ncmVzcyBpcyBub3QgaGVs
cGZ1bAo+ID4gPiA+ID4gZm9yIHRoZSBwcm9ibGVtIEkgYW0gdHJ5aW5nIHRvIHNvbHZlLgo+ID4g
PiA+IFdpdGggeW91ciBwYXRjaCwgeW91IGNvdWxkIHN0aWxsIGdldCB0aGUgZXJyb3IgbWVzc2Fn
ZSBpZiB0aGUgcmFjZSBnYXAKPiA+ID4gPiBleGlzdC4gV2l0aCBhYm92ZSBjaGFuZ2UsIHlvdSB3
b24ndCBnZXQgaXQuIFBsZWFzZSBjb3JyZWN0IG1lIGlmIEkgYW0KPiA+ID4gPiB3cm9uZy4KPiA+
ID4gVGhlIGFib3ZlIGNvZGUgd2lsbCBwcmludCBhbiBlcnJvciBtZXNzYWdlIGR1cmluZyB0aGUg
cmFjZSBnYXAuIEhlcmUncyB3aHk6Cj4gPiA+IAo+ID4gPiBMZXTigJlzIHNheSB0aGUga2V4ZWMg
bG9jayBpcyBhY3F1aXJlZCBpbiB0aGUga2VybmVsX2tleGVjKCkgZnVuY3Rpb24sCj4gPiA+IGJ1
dCBrZXhlY19pbl9wcm9ncmVzcyBpcyBub3QgeWV0IHNldCB0byBUcnVlLiBJbiB0aGlzIHNjZW5h
cmlvLCB0aGUgY29kZQo+ID4gPiB3aWxsIHByaW50Cj4gPiA+IGFuIGVycm9yIG1lc3NhZ2UuCj4g
PiA+IAo+ID4gPiBUaGVyZSBpcyBhbm90aGVyIGlzc3VlIEkgc2VlIHdpdGggdGhlIGFib3ZlIGNv
ZGU6Cj4gPiA+IAo+ID4gPiBDb25zaWRlciB0aGF0IHRoZSBzeXN0ZW0gaXMgb24gdGhlIGtleGVj
IGtlcm5lbCBib290IHBhdGgsIGFuZAo+ID4gPiBrZXhlY19pbl9wcm9ncmVzcwo+ID4gPiBpcyBz
ZXQgdG8gVHJ1ZS4gSWYgY3Jhc2hfaG90cGx1Z191bmxvY2soKSBpcyBjYWxsZWQsIHRoZSBrZXJu
ZWwgd2lsbCBub3QKPiA+ID4gb25seSB1cGRhdGUKPiA+ID4gdGhlIGtkdW1wIGltYWdlIHdpdGhv
dXQgYWNxdWlyaW5nIHRoZSBrZXhlYyBsb2NrLCBidXQgaXQgd2lsbCBhbHNvIHJlbGVhc2UKPiA+
ID4gdGhlCj4gPiA+IGtleGVjIGxvY2sgaW4gdGhlIG91dCBsYWJlbC4gSSBiZWxpZXZlIHRoaXMg
aXMgaW5jb3JyZWN0Lgo+ID4gPiAKPiA+ID4gUGxlYXNlIHNoYXJlIHlvdXIgdGhvdWdodHMuCj4g
PiBIb3cgYWJvdXQgdGhpcz8KPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC9jcmFzaF9jb3Jl
LmMgYi9rZXJuZWwvY3Jhc2hfY29yZS5jCj4gPiBpbmRleCA2M2NmODkzOTNjNmUuLjhiYTdiMWRh
MGRlZCAxMDA2NDQKPiA+IC0tLSBhL2tlcm5lbC9jcmFzaF9jb3JlLmMKPiA+ICsrKyBiL2tlcm5l
bC9jcmFzaF9jb3JlLmMKPiA+IEBAIC01MDUsNyArNTA1LDggQEAgaW50IGNyYXNoX2NoZWNrX2hv
dHBsdWdfc3VwcG9ydCh2b2lkKQo+ID4gICAJY3Jhc2hfaG90cGx1Z19sb2NrKCk7Cj4gPiAgIAkv
KiBPYnRhaW4gbG9jayB3aGlsZSByZWFkaW5nIGNyYXNoIGluZm9ybWF0aW9uICovCj4gPiAgIAlp
ZiAoIWtleGVjX3RyeWxvY2soKSkgewo+ID4gLQkJcHJfaW5mbygia2V4ZWNfdHJ5bG9jaygpIGZh
aWxlZCwgZWxmY29yZWhkciBtYXkgYmUgaW5hY2N1cmF0ZVxuIik7Cj4gPiArCQlpZiAoIWtleGVj
X2luX3Byb2dyZXNzKQo+ID4gKwkJCXByX2luZm8oImtleGVjX3RyeWxvY2soKSBmYWlsZWQsIGVs
ZmNvcmVoZHIgbWF5IGJlIGluYWNjdXJhdGVcbiIpOwo+ID4gICAJCWNyYXNoX2hvdHBsdWdfdW5s
b2NrKCk7Cj4gPiAgIAkJcmV0dXJuIDA7Cj4gPiAgIAl9Cj4gPiBAQCAtNTQwLDcgKzU0MSw4IEBA
IHN0YXRpYyB2b2lkIGNyYXNoX2hhbmRsZV9ob3RwbHVnX2V2ZW50KHVuc2lnbmVkIGludCBocF9h
Y3Rpb24sIHVuc2lnbmVkIGludCBjcHUsCj4gPiAgIAljcmFzaF9ob3RwbHVnX2xvY2soKTsKPiA+
ICAgCS8qIE9idGFpbiBsb2NrIHdoaWxlIGNoYW5naW5nIGNyYXNoIGluZm9ybWF0aW9uICovCj4g
PiAgIAlpZiAoIWtleGVjX3RyeWxvY2soKSkgewo+ID4gLQkJcHJfaW5mbygia2V4ZWNfdHJ5bG9j
aygpIGZhaWxlZCwgZWxmY29yZWhkciBtYXkgYmUgaW5hY2N1cmF0ZVxuIik7Cj4gPiArCQlpZiAo
IWtleGVjX2luX3Byb2dyZXNzKQo+ID4gKwkJCXByX2luZm8oImtleGVjX3RyeWxvY2soKSBmYWls
ZWQsIGVsZmNvcmVoZHIgbWF5IGJlIGluYWNjdXJhdGVcbiIpOwo+ID4gICAJCWNyYXNoX2hvdHBs
dWdfdW5sb2NrKCk7Cj4gPiAgIAkJcmV0dXJuOwo+ID4gICAJfQo+IAo+IFllcyBwdXR0aW5nIHBy
X2luZm8gdW5kZXIga2V4ZWMgaW4gcHJvZ3Jlc3MgY2hlY2sgd291bGQgd29yay4KPiAKPiBJIHdp
bGwgcmViYXNlIHRoZSBwYXRjaCBvbiB0b3Agb24gbmV4dC0yMDI0MDkwNiB0byBhdm9pZCBjb25m
bGljdCB3aXRoCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwODEyMDQxNjUxLjcw
MzE1Ni0xLXNvdXJhYmhqYWluQGxpbnV4LmlibS5jb20vVC8jdQo+IGFuZCBzZW5kIHYyLgoKR3Jl
YXQuIFdoZW4geW91IHJlcG9zdCwgY2FuIHlvdSBwbGVhc2UgYWxzbyBhZGQgd2h5IHBwYyB3aWxs
IGhvdCBhZGQgY3B1CmludG8gcGF0Y2ggbG9nIHdoZW4gY3Jhc2ggdHJpZ2dlcmVkPyBPdGhlcndp
c2Ugb3RoZXIgcGVvcGxlIG1heSBiZQpjb25mdXNlZCB3aGVuIHJlYWRpbmcgY29kZSBoZXJlIG9y
IHRyYWNlIGJhY2sgdGhlIGNvZGUgY2hhbmdlLgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4
ZWMK
