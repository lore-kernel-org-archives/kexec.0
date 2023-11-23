Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A383C624B4
	for <kexec@archiver.kernel.org>; Thu, 23 Nov 2023 11:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fVrNq+GEAhRlysPoGdEiC9CwziHBATi2yp1PeM6Ez/Q=; b=vGpspzTM1DH5Oa
	dyjZBw1xSp97z+eYqPLlVBvsS3FvXTBNTGL4si35s0tMa0gNd4dxDYaAVlgKNyDF4wPdGwP5VEJqu
	jflgYwojOqWI9e/WbhsjAxnlwtU2ATRkOvepD/UgIRbAeptElPHFWrd2GQlifQMNlkwc0SsRGKoys
	JBUmYXM3UfvFmj1/E/vkokU1GbR5rLkFdvlwVKu+LVkIAg+a3k7B/LYqVEnB4uKVz1tG/k3mnYbSi
	T6p2HS4yqDMVqV8MqUfQi8IiPyO6QN2OU3QTnn//xJTrEi4Tiqk4WYrWTMMYq8OMyoErAU6NAvmle
	1mdVNg6WoZtorRmyZ4cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r67ga-004U6I-2W;
	Thu, 23 Nov 2023 11:15:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r67gY-004U4p-0J
	for kexec@lists.infradead.org;
	Thu, 23 Nov 2023 11:15:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700738150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UPT2U9J2gb9jrypkSZPZI2ymrj+w1YFF8nXGNIVDMoo=;
	b=EBR14AYd5KVFMw8xqXGqRTOyJ7LVsoq0Ve4NIvaEYGiagtp2P9/HI4a37RilxR44so5Wc0
	VA0OmfKCsi7+RgXEoAnWjcKRGCnS8PDFxw9xrgHB+uKIGl0AoBohTGhOti6Ky2CGiKKKIg
	Q0l9yLtBcSBCOpUIgWkWEQUmp+LWiRc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-dJ5YYMAQPvK5kn4CTwm6KA-1; Thu, 23 Nov 2023 06:15:47 -0500
X-MC-Unique: dJ5YYMAQPvK5kn4CTwm6KA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D78BD811E7E;
	Thu, 23 Nov 2023 11:15:46 +0000 (UTC)
Received: from localhost (unknown [10.72.112.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 35424492BFA;
	Thu, 23 Nov 2023 11:15:45 +0000 (UTC)
Date: Thu, 23 Nov 2023 19:15:43 +0800
From: Baoquan He <bhe@redhat.com>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
	akpm@linux-foundation.org, eric_devolder@yahoo.com,
	kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH 2/3] drivers/base/cpu: crash data showing should depends
 on KEXEC_CORE
Message-ID: <ZV80X+lf2iOOTboW@MiWiFi-R3L-srv>
References: <20231123073652.507034-1-bhe@redhat.com>
 <20231123073652.507034-3-bhe@redhat.com>
 <CALrw=nFzy2zq-khLUCXsuf8J5_mka0YPyTosO190OUst2QSjVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALrw=nFzy2zq-khLUCXsuf8J5_mka0YPyTosO190OUst2QSjVQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231123_031554_232062_86B4DD51 
X-CRM114-Status: GOOD (  22.49  )
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

T24gMTEvMjMvMjMgYXQgMDg6MzRhbSwgSWduYXQgS29yY2hhZ2luIHdyb3RlOgo+IE9uIFRodSwg
Tm92IDIzLCAyMDIzIGF0IDc6MzfigK9BTSBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4gPgo+ID4gV2hlbiBiZWxvdyBrZXJuZWwgY29uZmlnIGl0ZW1zIGFyZSBzZXQsIGNvbXBp
bGluZyBlcnJvciBhcmUgdHJpZ2dlcmVkLgo+ID4KPiA+IENPTkZJR19DUkFTSF9DT1JFPXkKPiA+
IENPTkZJR19LRVhFQ19DT1JFPXkKPiA+IENPTkZJR19DUkFTSF9EVU1QPXkKPiA+IENPTkZJR19D
UkFTSF9IT1RQTFVHPXkKPiA+Cj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+IGRyaXZlcnMvYmFzZS9jcHUuYzogSW4gZnVuY3Rpb24g
4oCYY3Jhc2hfaG90cGx1Z19zaG934oCZOgo+ID4gZHJpdmVycy9iYXNlL2NwdS5jOjMwOTo0MDog
ZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGNyYXNoX2hvdHBsdWdf
Y3B1X3N1cHBvcnTigJk7IGRpZCB5b3UgbWVhbiDigJhjcmFzaF9ob3RwbHVnX3Nob3figJk/IFst
V2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQo+ID4gICAzMDkgfCAgICAgICAg
IHJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiVkXG4iLCBjcmFzaF9ob3RwbHVnX2NwdV9zdXBwb3J0
KCkpOwo+ID4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4gPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGNyYXNoX2hvdHBsdWdfc2hvdwo+ID4gY2MxOiBzb21lIHdhcm5p
bmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+Cj4gPiBDT05GSUdfS0VYRUMgaXMgdXNl
ZCB0byBlbmFibGUga2V4ZWNfbG9hZCBpbnRlcmZhY2UsIHRoZQo+ID4gY3Jhc2hfbm90ZXMvY3Jh
c2hfbm90ZXNfc2l6ZS9jcmFzaF9ob3RwbHVnIHNob3dpbmcgZGVwZW5kcyBvbgo+ID4gQ09ORklH
X0tFWEVDIGlzIGluY29ycmVjdC4gSXQgc2hvdWxkIGRlcGVuZCBvbiBLRVhFQ19DT1JFIGluc3Rl
YWQuCj4gPgo+ID4gRml4IGl0IG5vdy4KPiAKPiBDYW4gd2UgYWRkIEZpeGVzL0NDIHN0YWJsZSwg
c28gaXQgZ2V0cyBldmVudHVhbGx5IGJhY2twb3J0ZWQgaW50byA2LjY/CgpNYWtlcyBzZW5zZS4g
V2lsbCBhZGQgaXQgaW4gdjIgc2luY2UgSSBuZWVkIHJlc3BpbiB0byBhZGQgdGhlIG1pc3NpbmcK
c3R1ZmYgaW4gcGF0Y2ggMS4gVGhhbmtzLgoKPiAKPiA+IFNpZ25lZC1vZmYtYnk6IEJhb3F1YW4g
SGUgPGJoZUByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9iYXNlL2NwdS5jIHwgNiAr
KystLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvY3B1LmMgYi9kcml2ZXJzL2Jhc2Uv
Y3B1LmMKPiA+IGluZGV4IDllYTIyZTE2NWFjZC4uNTQ4NDkxZGU4MThlIDEwMDY0NAo+ID4gLS0t
IGEvZHJpdmVycy9iYXNlL2NwdS5jCj4gPiArKysgYi9kcml2ZXJzL2Jhc2UvY3B1LmMKPiA+IEBA
IC0xNDQsNyArMTQ0LDcgQEAgc3RhdGljIERFVklDRV9BVFRSKHJlbGVhc2UsIFNfSVdVU1IsIE5V
TEwsIGNwdV9yZWxlYXNlX3N0b3JlKTsKPiA+ICAjZW5kaWYgLyogQ09ORklHX0FSQ0hfQ1BVX1BS
T0JFX1JFTEVBU0UgKi8KPiA+ICAjZW5kaWYgLyogQ09ORklHX0hPVFBMVUdfQ1BVICovCj4gPgo+
ID4gLSNpZmRlZiBDT05GSUdfS0VYRUMKPiA+ICsjaWZkZWYgQ09ORklHX0tFWEVDX0NPUkUKPiA+
ICAjaW5jbHVkZSA8bGludXgva2V4ZWMuaD4KPiA+Cj4gPiAgc3RhdGljIHNzaXplX3QgY3Jhc2hf
bm90ZXNfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsCj4gPiBAQCAtMTg5LDE0ICsxODksMTQgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgY3Jhc2hfbm90ZV9jcHVfYXR0cl9n
cm91cCA9IHsKPiA+ICAjZW5kaWYKPiA+Cj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1
dGVfZ3JvdXAgKmNvbW1vbl9jcHVfYXR0cl9ncm91cHNbXSA9IHsKPiA+IC0jaWZkZWYgQ09ORklH
X0tFWEVDCj4gPiArI2lmZGVmIENPTkZJR19LRVhFQ19DT1JFCj4gPiAgICAgICAgICZjcmFzaF9u
b3RlX2NwdV9hdHRyX2dyb3VwLAo+ID4gICNlbmRpZgo+ID4gICAgICAgICBOVUxMCj4gPiAgfTsK
PiA+Cj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgKmhvdHBsdWdhYmxl
X2NwdV9hdHRyX2dyb3Vwc1tdID0gewo+ID4gLSNpZmRlZiBDT05GSUdfS0VYRUMKPiA+ICsjaWZk
ZWYgQ09ORklHX0tFWEVDX0NPUkUKPiA+ICAgICAgICAgJmNyYXNoX25vdGVfY3B1X2F0dHJfZ3Jv
dXAsCj4gPiAgI2VuZGlmCj4gPiAgICAgICAgIE5VTEwKPiA+IC0tCj4gPiAyLjQxLjAKPiA+Cj4g
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
