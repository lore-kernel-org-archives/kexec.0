Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B866C636CC
	for <kexec@archiver.kernel.org>; Tue,  7 Feb 2023 15:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u4is1X//Ms+3VqlYBbRJvpFucM5CT51vk7vG/g3hBzA=; b=EcaUBGls9EPbCn
	dmUgztI6ZZAcvu+NKeqWF4ebVXhuNoaq0QIP/3ikNaY4IIeWiVH0sUqu62echQEEwTc3FFyXU0IBG
	gh/UwnMpFzH7QvLeD3XEliy9+1PdaL/9TxyV1P241u8sXmYUfZ74DD5C+CdpHqYZWTu06Tkvqr2wZ
	VRbSVgK5xWVLvqffR+Y9vKWb5qC0vPgo3HyhR1DUCqtnHQu7MqRLsf2z929HcAt6F49rzyr70jKwq
	PHMLPkI2ikX0CdYVKR4Auk8dyYbRfgKNqcGETdUYPDobWURbteM8eHd5s4BGl+ArsgmAIeNXpfz2i
	HWyKVqzpwLM8sAqSmLmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPPjC-00CgQ9-IH; Tue, 07 Feb 2023 15:17:50 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPPj9-00CgOv-Nr
	for kexec@lists.infradead.org; Tue, 07 Feb 2023 15:17:49 +0000
Received: from momiji.horms.nl (86-93-216-223.fixed.kpn.net [86.93.216.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id 0F2272013E;
	Tue,  7 Feb 2023 15:08:11 +0000 (UTC)
Received: by momiji.horms.nl (Postfix, from userid 7100)
	id BF7249404F6; Tue,  7 Feb 2023 16:08:10 +0100 (CET)
Date: Tue, 7 Feb 2023 16:08:10 +0100
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org, 1030248@bugs.debian.org
Subject: Re: [PATCH] kexec: make -a the default
Message-ID: <Y+JpWoAQmZjJWT4X@vergenet.net>
References: <20230201151658.wvalwoz2jmjejcll@babtop.nabijaczleweli.xyz>
 <20230202231018.fnyq4ech4tiivgbi@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230202231018.fnyq4ech4tiivgbi@tarta.nabijaczleweli.xyz>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.7 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230207_071747_937319_707FA64A 
X-CRM114-Status: UNSURE (   9.67  )
X-CRM114-Notice: Please train this message.
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

T24gRnJpLCBGZWIgMDMsIDIwMjMgYXQgMTI6MTA6MThBTSArMDEwMCwgQWhlbGVuaWEgWmllbWlh
xYRza2Egd3JvdGU6Cj4gQUZBSUNULCB0aGVyZSdzIG5vIGRvd25zaWRlIHRvIHRoaXMsIGFuZCBy
dW5uaW5nIGludG8gdGhpcyBlYWNoIHRpbWUKPiBJIHdhbnQgdG8ga2V4ZWMgKGFuZCwgcHJlc3Vt
YWJseSwgYSBzaWduaWZpY2FudCBjaHVuayBvZiB0aGUgcG9wdWxhdGlvbiwKPiBzaW5jZSBsb2Nr
ZG93biBpcyBxdWl0ZSBwb3B1bGFyKSBvbiBzb21lIG1hY2hpbmVzLAo+IHRoZW4gZ29pbmcgdG8g
dGhlIG1hbnVhbCwgdGhlbiBmaW5kaW5nIG91dCBJIHdhbnQgdGhlIC9hdXRvLyBmbGFnKCEpCj4g
aXMgcXVpdGUgYW5ub3lpbmc6Cj4gICAjIGtleGVjIC1sIC9ib290L3ZtbGludXotNi4xLjAtMy1h
bWQ2NCAtLWluaXRyZCAvYm9vdC9pbml0cmQuaW1nLTYuMS4wLTMtYW1kNjQgLS1yZXVzZS1jbWRs
aW5lCj4gICBrZXhlY19sb2FkIGZhaWxlZDogT3BlcmF0aW9uIG5vdCBwZXJtaXR0ZWQKPiAgIGVu
dHJ5ICAgICAgID0gMHg0NmVmZjc3NjAgZmxhZ3MgPSAweDNlMDAwMAo+ICAgbnJfc2VnbWVudHMg
PSA3Cj4gICBzZWdtZW50WzBdLmJ1ZiAgID0gMHg1NTdjZDMwM2VmYTAKPiAgIHNlZ21lbnRbMF0u
YnVmc3ogPSAweDcwCj4gICBzZWdtZW50WzBdLm1lbSAgID0gMHgxMDAwMDAKPiAgIHNlZ21lbnRb
MF0ubWVtc3ogPSAweDEwMDAKPiAgIHNlZ21lbnRbMV0uYnVmICAgPSAweDU1N2NkMzA0NmZlMAo+
ICAgc2VnbWVudFsxXS5idWZzeiA9IDB4MTkwCj4gICBzZWdtZW50WzFdLm1lbSAgID0gMHgxMDEw
MDAKPiAgIHNlZ21lbnRbMV0ubWVtc3ogPSAweDEwMDAKPiAgIHNlZ21lbnRbMl0uYnVmICAgPSAw
eDU1N2NkMzAzZjZlMAo+ICAgc2VnbWVudFsyXS5idWZzeiA9IDB4MzAKPiAgIHNlZ21lbnRbMl0u
bWVtICAgPSAweDEwMjAwMAo+ICAgc2VnbWVudFsyXS5tZW1zeiA9IDB4MTAwMAo+ICAgc2VnbWVu
dFszXS5idWYgICA9IDB4N2Y2NThmYTM3MDEwCj4gICBzZWdtZW50WzNdLmJ1ZnN6ID0gMHgxMmE1
MWI1Cj4gICBzZWdtZW50WzNdLm1lbSAgID0gMHg0NmE1NWEwMDAKPiAgIHNlZ21lbnRbM10ubWVt
c3ogPSAweDEyYTYwMDAKPiAgIHNlZ21lbnRbNF0uYnVmICAgPSAweDdmNjU5MGNlMTIxMAo+ICAg
c2VnbWVudFs0XS5idWZzeiA9IDB4N2U5OWUwCj4gICBzZWdtZW50WzRdLm1lbSAgID0gMHg0NmI4
MDAwMDAKPiAgIHNlZ21lbnRbNF0ubWVtc3ogPSAweDM3N2MwMDAKPiAgIHNlZ21lbnRbNV0uYnVm
ICAgPSAweDU1N2NkMzAzOTM1MAo+ICAgc2VnbWVudFs1XS5idWZzeiA9IDB4NDJmYQo+ICAgc2Vn
bWVudFs1XS5tZW0gICA9IDB4NDZlZmYyMDAwCj4gICBzZWdtZW50WzVdLm1lbXN6ID0gMHg1MDAw
Cj4gICBzZWdtZW50WzZdLmJ1ZiAgID0gMHg1NTdjZDMwMzIwMDAKPiAgIHNlZ21lbnRbNl0uYnVm
c3ogPSAweDcwZTAKPiAgIHNlZ21lbnRbNl0ubWVtICAgPSAweDQ2ZWZmNzAwMAo+ICAgc2VnbWVu
dFs2XS5tZW1zeiA9IDB4OTAwMAo+IAo+IENsb3NlczogaHR0cHM6Ly9idWdzLmRlYmlhbi5vcmcv
MTAzMDI0OAo+IFNpZ25lZC1vZmYtYnk6IEFoZWxlbmlhIFppZW1pYcWEc2thIDxuYWJpamFjemxl
d2VsaUBuYWJpamFjemxld2VsaS54eXo+CgpUaGFua3MsIGFwcGxpZWQuCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4
ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2tleGVjCg==
