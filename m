Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022DEC6FD1F
	for <kexec@archiver.kernel.org>; Sat, 30 Mar 2024 14:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g5FjYjx90haakICgqtZDBr8b7OAu3TwOZBNgJoBA9xA=; b=y9kiiDrv0rDtRo
	n6K0xM7fYmwIhFmk232rCVSMgnjY7LqWzdFSWYOUtpQ46Qpei1i1A521Y0CmTsjgqdBklkHE7Mx2g
	oYTi3IqLFoBwGKO/ghHT5kL/5MkpKM2zQ+lKA0bSvc7RxP55joRClBLUmkkkDN7BMmdUBKnLlg93K
	LmtdAgEQ1DGiDdKX5grWwSSjtag2HHyte3dY0TlJz1DShcpuI2h5/whTg2jsTwyaTyzW4KpW4erUC
	L0V/W9FpMsecmR5ju9AT5JceTDaTwCcQtS+S4zkld6fZMRt6T3w/B7eCibFJJERER08PwbIgHChNH
	iGeLx7X4GxZpELmbQ+PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqZd6-00000003cPo-1Jsp;
	Sat, 30 Mar 2024 14:24:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqZd3-00000003cPO-48xf
	for kexec@lists.infradead.org;
	Sat, 30 Mar 2024 14:24:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711808656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8HbCGyy1GVrVUNL7zlMzVEy/UJRgHTJ0kZQntvsmDig=;
	b=VhsZYwqkzQsUZyo0OdPkV9zY3G4/tckLsctVOLe+11dbutSY+VEAGT1UCf/dPynUXEeFUs
	jTJr3mjQVrEQPofanNM+s2/8aJvCT7n9JJ/nY8sMqrZZkToUf3Fp8eBmbbdbqqWWbOqhP2
	k/jDl/PBSfV5qpEXuZkAht/E9NLAWLI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-oZ4t53_4MXydy8zt9jpAOA-1; Sat,
 30 Mar 2024 10:24:12 -0400
X-MC-Unique: oZ4t53_4MXydy8zt9jpAOA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9EE4638000A5;
	Sat, 30 Mar 2024 14:24:11 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 468433C20;
	Sat, 30 Mar 2024 14:24:09 +0000 (UTC)
Date: Sat, 30 Mar 2024 22:23:47 +0800
From: Baoquan He <bhe@redhat.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kexec@lists.infradead.org, akpm@linux-foundation.org,
	geert@linux-m68k.org, WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev
Subject: Re: [PATCH 1/2] arch/loongarch: clean up the left code and Kconfig
 item related to CRASH_CORE
Message-ID: <ZgggcyeJ1bnkfGOp@MiWiFi-R3L-srv>
References: <20240329132825.1102459-1-bhe@redhat.com>
 <20240329132825.1102459-2-bhe@redhat.com>
 <CAAhV-H76-FOvcTXB_rW1B1wFthYK6txVtC+brfzk6nwOhar8iQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H76-FOvcTXB_rW1B1wFthYK6txVtC+brfzk6nwOhar8iQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240330_072418_135837_E0ED6DBF 
X-CRM114-Status: GOOD (  17.12  )
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

T24gMDMvMzAvMjQgYXQgMDk6NTlwbSwgSHVhY2FpIENoZW4gd3JvdGU6Cj4gUXVldWVkLCB0aGFu
a3MuCgpUaGFua3MsIEh1YWNhaS4gV2hpbGUgSSBub3RpY2VkIEFuZHJldyBoYXMgcXVldWVkIHRo
aXMgcGF0Y2hzZXQgaW4gaGlzCm1tLXVuc3RhYmxlIGJyYW5jaC4KCj4gCj4gSHVhY2FpCj4gCj4g
T24gRnJpLCBNYXIgMjksIDIwMjQgYXQgOToyOOKAr1BNIEJhb3F1YW4gSGUgPGJoZUByZWRoYXQu
Y29tPiB3cm90ZToKPiA+Cj4gPiBJbiBjb21taXQgODVmY2RlNDAyZGIxICgia2V4ZWM6IHNwbGl0
IGNyYXNoa2VybmVsIHJlc2VydmF0aW9uIGNvZGUKPiA+IG91dCBmcm9tIGNyYXNoX2NvcmUuYyIp
LCBjcmFzaGtlcm5lbCByZXNlcnZhdGlvbiBjb2RlIGlzIHNwbGl0IG91dCBmcm9tCj4gPiBjcmFz
aF9jb3JlLmMsIGFuZCBhZGQgQ1JBU0hfUkVTRVJWRSB0byBjb250cm9sIGl0LiBBbmQgYWxzbyBy
ZW5hbWUgZWFjaAo+ID4gQVJDSCdzIDxhc20vY3Jhc2hfY29yZS5oPiB0byA8YXNtL2NyYXNoX3Jl
c2VydmUuaD4gYWNjb3JkaW5nbHkuCj4gPgo+ID4gQnV0IHRoZSByZWxldmFudCBwYXJ0IGluIGxv
b25nYXJjaCBpcyBtaXNzZWQuIERvIGl0IG5vdy4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBCYW9x
dWFuIEhlIDxiaGVAcmVkaGF0LmNvbT4KPiA+IENjOiBIdWFjYWkgQ2hlbiA8Y2hlbmh1YWNhaUBr
ZXJuZWwub3JnPgo+ID4gQ2M6IFdBTkcgWHVlcnVpIDxrZXJuZWxAeGVuMG4ubmFtZT4KPiA+IENj
OiBsb29uZ2FyY2hAbGlzdHMubGludXguZGV2Cj4gPiAtLS0KPiA+ICBhcmNoL2xvb25nYXJjaC9L
Y29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAyICstCj4gPiAg
YXJjaC9sb29uZ2FyY2gvaW5jbHVkZS9hc20ve2NyYXNoX2NvcmUuaCA9PiBjcmFzaF9yZXNlcnZl
Lmh9IHwgNCArKy0tCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCj4gPiAgcmVuYW1lIGFyY2gvbG9vbmdhcmNoL2luY2x1ZGUvYXNtL3tjcmFzaF9j
b3JlLmggPT4gY3Jhc2hfcmVzZXJ2ZS5ofSAoNzUlKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9hcmNo
L2xvb25nYXJjaC9LY29uZmlnIGIvYXJjaC9sb29uZ2FyY2gvS2NvbmZpZwo+ID4gaW5kZXggYTVm
MzAwZWM2ZjI4Li41NGFkMDRkYWNkZWUgMTAwNjQ0Cj4gPiAtLS0gYS9hcmNoL2xvb25nYXJjaC9L
Y29uZmlnCj4gPiArKysgYi9hcmNoL2xvb25nYXJjaC9LY29uZmlnCj4gPiBAQCAtNTk1LDcgKzU5
NSw3IEBAIGNvbmZpZyBBUkNIX1NFTEVDVFNfQ1JBU0hfRFVNUAo+ID4gICAgICAgICBzZWxlY3Qg
UkVMT0NBVEFCTEUKPiA+Cj4gPiAgY29uZmlnIEFSQ0hfSEFTX0dFTkVSSUNfQ1JBU0hLRVJORUxf
UkVTRVJWQVRJT04KPiA+IC0gICAgICAgZGVmX2Jvb2wgQ1JBU0hfQ09SRQo+ID4gKyAgICAgICBk
ZWZfYm9vbCBDUkFTSF9SRVNFUlZFCj4gPgo+ID4gIGNvbmZpZyBSRUxPQ0FUQUJMRQo+ID4gICAg
ICAgICBib29sICJSZWxvY2F0YWJsZSBrZXJuZWwiCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9sb29u
Z2FyY2gvaW5jbHVkZS9hc20vY3Jhc2hfY29yZS5oIGIvYXJjaC9sb29uZ2FyY2gvaW5jbHVkZS9h
c20vY3Jhc2hfcmVzZXJ2ZS5oCj4gPiBzaW1pbGFyaXR5IGluZGV4IDc1JQo+ID4gcmVuYW1lIGZy
b20gYXJjaC9sb29uZ2FyY2gvaW5jbHVkZS9hc20vY3Jhc2hfY29yZS5oCj4gPiByZW5hbWUgdG8g
YXJjaC9sb29uZ2FyY2gvaW5jbHVkZS9hc20vY3Jhc2hfcmVzZXJ2ZS5oCj4gPiBpbmRleCAyMThi
ZGJmYTUyN2IuLmExZDliODRiMWM3ZCAxMDA2NDQKPiA+IC0tLSBhL2FyY2gvbG9vbmdhcmNoL2lu
Y2x1ZGUvYXNtL2NyYXNoX2NvcmUuaAo+ID4gKysrIGIvYXJjaC9sb29uZ2FyY2gvaW5jbHVkZS9h
c20vY3Jhc2hfcmVzZXJ2ZS5oCj4gPiBAQCAtMSw2ICsxLDYgQEAKPiA+ICAvKiBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5ICovCj4gPiAtI2lmbmRlZiBfTE9PTkdBUkNIX0NS
QVNIX0NPUkVfSAo+ID4gLSNkZWZpbmUgX0xPT05HQVJDSF9DUkFTSF9DT1JFX0gKPiA+ICsjaWZu
ZGVmIF9MT09OR0FSQ0hfQ1JBU0hfUkVTRVJWRV9ICj4gPiArI2RlZmluZSBfTE9PTkdBUkNIX0NS
QVNIX1JFU0VSVkVfSAo+ID4KPiA+ICAjZGVmaW5lIENSQVNIX0FMSUdOICAgICAgICAgICAgICAg
ICAgICBTWl8yTQo+ID4KPiA+IC0tCj4gPiAyLjQxLjAKPiA+Cj4gCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=
