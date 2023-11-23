Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41946C5AD4C
	for <kexec@archiver.kernel.org>; Thu, 23 Nov 2023 14:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CP5UbU41Vf66YYuNfX51ahNlPyUlXY2tYrpbJ7ij1Xc=; b=NM1tazXgO2y6Bs
	2ZWlGsW39Yj6PWDEfIcPQRwTL4ondYCsjOQsph8IPaVPhQW5MzbOJAp/ShdtUayyk9IWZzwarxQ0Y
	JU2Ss2P5uv6NZCStFENnBO6Wkd4Zn+m9VaDqPSxib4PXoee05abTmuFo7UB2xRhT3EnCx/pet0Cmp
	1ZXAHATgDN8htngB+tVdTeVJpcLmF71GdIhQuWueorF7Rs8vabCqMZ6MXzr0I3Q0WQVGBtOSwOEbO
	nI7DfaNcEV854cX1ibAwHgefFa/vl2RFxQp3HbpeX+iC52ULI64hH+gVZqynkXKShuH77KLr4fnjl
	cVRO1m9upuvA4XvQ34Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6Afv-0050ng-0V;
	Thu, 23 Nov 2023 14:27:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6Afr-0050m7-39
	for kexec@lists.infradead.org;
	Thu, 23 Nov 2023 14:27:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700749643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPYmWVJiio69jB+wuetIWO6yNFF7oZKH/nujKKk+JfY=;
	b=aHbaZmkLPUvy405oANpEN9EEe9S5W2q/amrL4QVsaFClemm+yyYsRox8OFgzLvhkvjsSKi
	NbG5xMkB7LMusqVQ4MfSNl5YFxIwcBJ4o15F7/Zawm1FJ56dnZHm7YAEpd0u/BCLWvdySE
	e8h6mJbcd9gNudt8Q5YZ7bl2WmOwxEo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-uwyJZVJuNfucj7yT_WV1hg-1; Thu,
 23 Nov 2023 09:27:18 -0500
X-MC-Unique: uwyJZVJuNfucj7yT_WV1hg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78228280CFA4;
	Thu, 23 Nov 2023 14:27:17 +0000 (UTC)
Received: from localhost (unknown [10.72.112.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C20F4C1596F;
	Thu, 23 Nov 2023 14:27:16 +0000 (UTC)
Date: Thu, 23 Nov 2023 22:27:13 +0800
From: Baoquan He <bhe@redhat.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
	akpm@linux-foundation.org, ignat@cloudflare.com,
	eric_devolder@yahoo.com
Subject: Re: [PATCH 2/3] drivers/base/cpu: crash data showing should depends
 on KEXEC_CORE
Message-ID: <ZV9hQfugDw2gDTRy@MiWiFi-R3L-srv>
References: <20231123073652.507034-1-bhe@redhat.com>
 <20231123073652.507034-3-bhe@redhat.com>
 <ZV9eCBm5uy7/VgOX@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZV9eCBm5uy7/VgOX@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231123_062724_084211_F6BEC90F 
X-CRM114-Status: GOOD (  15.97  )
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

T24gMTEvMjMvMjMgYXQgMDM6MTNwbSwgQWxleGFuZGVyIEdvcmRlZXYgd3JvdGU6Cj4gT24gVGh1
LCBOb3YgMjMsIDIwMjMgYXQgMDM6MzY6NTFQTSArMDgwMCwgQmFvcXVhbiBIZSB3cm90ZToKPiA+
IFdoZW4gYmVsb3cga2VybmVsIGNvbmZpZyBpdGVtcyBhcmUgc2V0LCBjb21waWxpbmcgZXJyb3Ig
YXJlIHRyaWdnZXJlZC4KPiA+IAo+ID4gQ09ORklHX0NSQVNIX0NPUkU9eQo+ID4gQ09ORklHX0tF
WEVDX0NPUkU9eQo+ID4gQ09ORklHX0NSQVNIX0RVTVA9eQo+ID4gQ09ORklHX0NSQVNIX0hPVFBM
VUc9eQo+ID4gCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KPiA+IGRyaXZlcnMvYmFzZS9jcHUuYzogSW4gZnVuY3Rpb24g4oCYY3Jhc2hf
aG90cGx1Z19zaG934oCZOgo+ID4gZHJpdmVycy9iYXNlL2NwdS5jOjMwOTo0MDogZXJyb3I6IGlt
cGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGNyYXNoX2hvdHBsdWdfY3B1X3N1cHBv
cnTigJk7IGRpZCB5b3UgbWVhbiDigJhjcmFzaF9ob3RwbHVnX3Nob3figJk/IFstV2Vycm9yPWlt
cGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQo+ID4gICAzMDkgfCAgICAgICAgIHJldHVybiBz
eXNmc19lbWl0KGJ1ZiwgIiVkXG4iLCBjcmFzaF9ob3RwbHVnX2NwdV9zdXBwb3J0KCkpOwo+ID4g
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+Cj4gPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNyYXNoX2hvdHBsdWdfc2hvdwo+ID4gY2MxOiBzb21lIHdhcm5pbmdzIGJlaW5n
IHRyZWF0ZWQgYXMgZXJyb3JzCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+IAo+ID4gQ09ORklHX0tFWEVDIGlzIHVzZWQgdG8gZW5h
YmxlIGtleGVjX2xvYWQgaW50ZXJmYWNlLCB0aGUKPiA+IGNyYXNoX25vdGVzL2NyYXNoX25vdGVz
X3NpemUvY3Jhc2hfaG90cGx1ZyBzaG93aW5nIGRlcGVuZHMgb24KPiA+IENPTkZJR19LRVhFQyBp
cyBpbmNvcnJlY3QuIEl0IHNob3VsZCBkZXBlbmQgb24gS0VYRUNfQ09SRSBpbnN0ZWFkLgo+ID4g
Cj4gPiBGaXggaXQgbm93Lgo+IAo+IElmIHRoaXMgZXJyb3IgaW50cm9kdWNlZCB3aXRoIHRoZSBw
cmV2b3VzIHBhdGNoPwo+IElmIHNvLCB0aGUgcGF0Y2hlcyBuZWVkIHRvIGJlIHN3YXBwZWQgSSBn
dWVzcy4KCkZyb20gdGhlIHBoZW5vbWVub24sIHllcy4gSW4gZmFjdCBpdCdzIHRoZSBwYXRjaCAx
IHdoaWNoIGV4cG9zZXMKdGhlIHdyb25nIGlmZGVmZmVyeS4gSSBjYW4gc2hpZnQgdGhlIG9yZGVy
IGluIHYyLiBUaGFua3MuCgo+IAo+ID4gU2lnbmVkLW9mZi1ieTogQmFvcXVhbiBIZSA8YmhlQHJl
ZGhhdC5jb20+Cj4gCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
