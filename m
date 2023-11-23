Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0DEC61D85
	for <kexec@archiver.kernel.org>; Thu, 23 Nov 2023 11:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jTumi9Hao8L5zK3fA2m6YKIydkaUqCaBmfcroEKGcyM=; b=2wnaQb+ZPCvqHf
	SXHhSIofvnXfTUfjawhr4WL9P44Ij6Ljv+i1wFVi4Ll91h/s6UBTtfDnjXZTD7bjeE4YAgeXTB0cE
	+WwV2j7yWij80H/CWkor+N5KYKAPOKacV121Z9knBlvEKFtLvUbZdfmOC3NTcbb2nz3wdyFTkDdIv
	p2MD3q9DKGY9qkXxA34dfF9FATPl7LqnnvrHQKWNXd4iCHeZC1NqIDuoQ49oXNtB08FJ5BdqcFb23
	cWVKtCBuNT9TOQVpgXWQ71Uc8xeQ96PDKIAnJOEGpZ9a8aK0lbpqwgCIpIwQuoq5pmvcFxv8zSHfb
	eUVPj2COpLS8U24SxcZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r67Yz-004TPY-0m;
	Thu, 23 Nov 2023 11:08:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r67Yw-004TOk-1z
	for kexec@lists.infradead.org;
	Thu, 23 Nov 2023 11:08:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700737681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4Skc8GoRCulLSc1L8sW+fd+URsNyF4CrxboNaek2t8=;
	b=cFCD1DCwxBMLv0xjWJwtXbs8I5AKGW7s/dV8kCtONIzyLpsizrxxnUfwM05UvvKj2n/PNY
	hnh+SgAnK2ZRDgNmHHNobA8XtxX+HGLKfgpAs7ENGXrHiiG5e1AGwjkVpMiKyqQUP8pcq1
	HK4edGHptvi1j7Rajaskg06n1r0UKIg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-WTlpL2kTM2OxbsT10NKmbg-1; Thu, 23 Nov 2023 06:07:59 -0500
X-MC-Unique: WTlpL2kTM2OxbsT10NKmbg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DF9981B562;
	Thu, 23 Nov 2023 11:07:59 +0000 (UTC)
Received: from localhost (unknown [10.72.112.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 982EAC1596F;
	Thu, 23 Nov 2023 11:07:58 +0000 (UTC)
Date: Thu, 23 Nov 2023 19:07:55 +0800
From: Baoquan He <bhe@redhat.com>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
	akpm@linux-foundation.org, eric_devolder@yahoo.com,
	kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH 1/3] kernel/Kconfig.kexec: drop select of KEXEC for
 CRASH_DUMP
Message-ID: <ZV8yi86cA5mhYNll@MiWiFi-R3L-srv>
References: <20231123073652.507034-1-bhe@redhat.com>
 <20231123073652.507034-2-bhe@redhat.com>
 <CALrw=nEO3A2MPeSXhO3=cPdrAFB07sQcnjNN5V5jj2YcqAZ+bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALrw=nEO3A2MPeSXhO3=cPdrAFB07sQcnjNN5V5jj2YcqAZ+bQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231123_030802_730931_20578EDD 
X-CRM114-Status: GOOD (  18.89  )
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

T24gMTEvMjMvMjMgYXQgMDg6MjNhbSwgSWduYXQgS29yY2hhZ2luIHdyb3RlOgo+IE9uIFRodSwg
Tm92IDIzLCAyMDIzIGF0IDc6MzfigK9BTSBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4gPgo+ID4gSWduYXQgS29yY2hhZ2luIGNvbXBsYWluZWQgdGhhdCBhIHBvdGVudGlhbCBj
b25maWcgcmVncmVzc2lvbiB3YXMKPiA+IGludHJvZHVjZWQgYnkgY29tbWl0IDg5Y2RlNDU1OTE1
ZiAoImtleGVjOiBjb25zb2xpZGF0ZSBrZXhlYyBhbmQKPiA+IGNyYXNoIG9wdGlvbnMgaW50byBr
ZXJuZWwvS2NvbmZpZy5rZXhlYyIpLiBCZWZvcmUgdGhlIGNvbW1pdCwKPiA+IENPTkZJR19DUkFT
SF9EVU1QIGhhcyBubyBkZXBlbmRlbmN5IG9uIENPTkZJR19LRVhFQy4gQWZ0ZXIgdGhlIGNvbW1p
dCwKPiA+IENSQVNIX0RVTVAgc2VsZWN0cyBLRVhFQy4gVGhhdCBlbmZvcmNlcyBzeXN0ZW0gdG8g
aGF2ZSBDT05GSUdfS0VYRUM9eQo+ID4gYXMgbG9uZyBhcyBDT05GSUdfQ1JBU0hfRFVNUD1ZIHdo
aWNoIHBlb3BsZSBtYXkgbm90IHdhbnQuCj4gPgo+ID4gSW4gSWduYXQncyBjYXNlLCBoZSBzZXRz
IENPTkZJR19DUkFTSF9EVU1QPXksIENPTkZJR19LRVhFQ19GSUxFPXkgYW5kCj4gPiBDT05GSUdf
S0VYRUM9biBiZWNhdXNlIGtleGVjX2xvYWQgaW50ZXJmYWNlIGNvdWxkIGhhdmUgc2VjdXJpdHkg
aXNzdWUgaWYKPiA+IGtlcm5lbC9pbml0cmQgaGFzIG5vIGNoYW5jZSB0byBiZSBzaWduZWQgYW5k
IHZlcmlmaWVkLgo+ID4KPiA+IENSQVNIX0RVTVAgaGFzIHNlbGVjdCBvZiBLRVhFQyBiZWNhdXNl
IEVyaWMsIGF1dGhvciBvZiBhYm92ZSBjb21taXQsCj4gPiBtZXQgYSBMS1AgcmVwb3J0IG9mIGJ1
aWxkIGZhaWx1cmUgd2hlbiBwb3N0aW5nIHBhdGNoIG9mIGVhcmxpZXIgdmVyc2lvbi4KPiA+IFBs
ZWFzZSBzZWUgYmVsb3cgbGluayB0byBnZXQgZGV0YWlsIG9mIHRoZSBMS1AgcmVwb3J0Ogo+ID4K
PiA+ICAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvM2U4ZWVjZDEtYTI3Ny0yY2ZiLTY5
MGUtNWRlMmViN2I5ODhlQG9yYWNsZS5jb20vVC8jdQo+ID4KPiA+IEluIGZhY3QsIHRoYXQgTEtQ
IHJlcG9ydCBpcyB0cmlnZ2VyZWQgYmVjYXVzZSBhcm0ncyA8YXNtL2tleGVjLmg+IGlzCj4gPiB3
cmFwcGVkIGluIENPTkZJR19LRVhFQyBpZmRlZmZlcnkgc2NvcGUuIFRoYXQgaXMgd3JvbmcuIENP
TkZJR19LRVhFQwo+ID4gY29udHJvbHMgdGhlIGVuYWJsaW5nL2Rpc2FibGluZyBvZiBrZXhlY19s
b2FkIGludGVyZmFjZSwgYnV0IG5vdCBrZXhlYwo+ID4gZmVhdHVyZS4gUmVtb3ZpbmcgdGhlIHdy
b25nbHkgYWRkZWQgQ09ORklHX0tFWEVDIGlmZGVmZmVyeSBzY29wZSBpbgo+ID4gPGFzbS9rZXhl
Yy5oPiBvZiBhcm0gYWxsb3dzIHVzIHRvIGRyb3AgdGhlIHNlbGVjdCBLRVhFQyBmb3IgQ1JBU0hf
RFVNUC4KPiAKPiBIbS4uLiBXaXRoIHRoZSBwYXRjaCwgd2hlbiBjcm9zcyBjb21waWxpbmcgZm9y
IGFybSBhbmQKPiBDT05GSUdfS0VYRUNfQ09SRT15Cj4gIyBDT05GSUdfS0VYRUMgaXMgbm90IHNl
dAo+IENPTkZJR19DUkFTSF9EVU1QPXkKPiAKPiBJIGdldCB0aGUgZm9sbG93aW5nIGxpbmtlciBl
cnJvciBhdCB0aGUgZW5kOgo+IAo+ICAgQ0FMTCAgICBzY3JpcHRzL2NoZWNrc3lzY2FsbHMuc2gK
PiAgIFVQRCAgICAgaW5jbHVkZS9nZW5lcmF0ZWQvdXRzdmVyc2lvbi5oCj4gICBDQyAgICAgIGlu
aXQvdmVyc2lvbi10aW1lc3RhbXAubwo+ICAgTEQgICAgICAudG1wX3ZtbGludXgua2FsbHN5bXMx
Cj4gYXJtLWxpbnV4LWdudWVhYmktbGQ6IGtlcm5lbC9rZXhlY19jb3JlLm86IGluIGZ1bmN0aW9u
IGBraW1hZ2VfZnJlZSc6Cj4ga2V4ZWNfY29yZS5jOigudGV4dCsweGY1Yyk6IHVuZGVmaW5lZCBy
ZWZlcmVuY2UgdG8gYG1hY2hpbmVfa2V4ZWNfY2xlYW51cCcKPiBhcm0tbGludXgtZ251ZWFiaS1s
ZDoga2VybmVsL2tleGVjX2NvcmUubzogaW4gZnVuY3Rpb24gYF9fY3Jhc2hfa2V4ZWMnOgo+IGtl
eGVjX2NvcmUuYzooLnRleHQrMHgxNWJjKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgbWFjaGlu
ZV9jcmFzaF9zaHV0ZG93bicKPiBhcm0tbGludXgtZ251ZWFiaS1sZDoga2V4ZWNfY29yZS5jOigu
dGV4dCsweDE1YzQpOiB1bmRlZmluZWQgcmVmZXJlbmNlCj4gdG8gYG1hY2hpbmVfa2V4ZWMnCj4g
YXJtLWxpbnV4LWdudWVhYmktbGQ6IGtlcm5lbC9rZXhlY19jb3JlLm86IGluIGZ1bmN0aW9uIGBr
ZXJuZWxfa2V4ZWMnOgo+IGtleGVjX2NvcmUuYzooLnRleHQrMHgxYTA0KTogdW5kZWZpbmVkIHJl
ZmVyZW5jZSB0byBgbWFjaGluZV9rZXhlYycKPiBtYWtlWzJdOiAqKiogW3NjcmlwdHMvTWFrZWZp
bGUudm1saW51eDozNzogdm1saW51eF0gRXJyb3IgMQo+IG1ha2VbMV06ICoqKiBbL2hvbWUvaWdu
YXQvZ2l0L2xpbnV4LXVwc3RyZWFtL01ha2VmaWxlOjExNTQ6IHZtbGludXhdIEVycm9yIDIKPiBt
YWtlOiAqKiogW01ha2VmaWxlOjIzNDogX19zdWItbWFrZV0gRXJyb3IgMgoKT29wcywgSSBmb3Jn
b3QgdGhpcyBwYXJ0LiBUaGlzIHNob3VsZCBmaXggdGhlIGxpbmsgZXJyb3IuCgpkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0va2VybmVsL01ha2VmaWxlIGIvYXJjaC9hcm0va2VybmVsL01ha2VmaWxlCmlu
ZGV4IGQ1M2Y1NmQ2Zjg0MC4uNzcxMjY0ZDQ3MjZhIDEwMDY0NAotLS0gYS9hcmNoL2FybS9rZXJu
ZWwvTWFrZWZpbGUKKysrIGIvYXJjaC9hcm0va2VybmVsL01ha2VmaWxlCkBAIC01OSw3ICs1OSw3
IEBAIG9iai0kKENPTkZJR19GVU5DVElPTl9UUkFDRVIpCSs9IGVudHJ5LWZ0cmFjZS5vCiBvYmot
JChDT05GSUdfRFlOQU1JQ19GVFJBQ0UpCSs9IGZ0cmFjZS5vIGluc24ubyBwYXRjaC5vCiBvYmot
JChDT05GSUdfRlVOQ1RJT05fR1JBUEhfVFJBQ0VSKQkrPSBmdHJhY2UubyBpbnNuLm8gcGF0Y2gu
bwogb2JqLSQoQ09ORklHX0pVTVBfTEFCRUwpCSs9IGp1bXBfbGFiZWwubyBpbnNuLm8gcGF0Y2gu
bwotb2JqLSQoQ09ORklHX0tFWEVDKQkJKz0gbWFjaGluZV9rZXhlYy5vIHJlbG9jYXRlX2tlcm5l
bC5vCitvYmotJChDT05GSUdfS0VYRUNfQ09SRSkJKz0gbWFjaGluZV9rZXhlYy5vIHJlbG9jYXRl
X2tlcm5lbC5vCiAjIE1haW4gc3RhZmZzIGluIEtQUk9CRVMgYXJlIGluIGFyY2gvYXJtL3Byb2Jl
cy8gLgogb2JqLSQoQ09ORklHX0tQUk9CRVMpCQkrPSBwYXRjaC5vIGluc24ubwogb2JqLSQoQ09O
RklHX09BQklfQ09NUEFUKQkrPSBzeXNfb2FiaS1jb21wYXQubwoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0Bs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8va2V4ZWMK
