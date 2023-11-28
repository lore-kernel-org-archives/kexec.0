Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C99EC07E98
	for <kexec@archiver.kernel.org>; Tue, 28 Nov 2023 05:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=HyxzSXy9qHI4KfYem8h5+qdvp2eSdNVahETTJL7Cle4=; b=GC1imdAoOSB+0J
	TQGbbNQW1fe6LZOypC8AWeWC/CbTiXQmw2L03vnm2lGzLRjjzjqjsUZR359MdbOTekWzDsaOKymty
	oWKwu1DoknaVl3EQF5mJ84tX4YS48/rHe6l04RwivlEyoIga+3Apm9FgP39HsQPlP/Hi7rK/15rac
	5AuUVsKL3GMyu9RcEQvtiB5uVcItLD+JTlIrIh5RMBLBm/GzoBvg5vMwH39516uBdH6vXHUY48rmD
	TaAZqM2tk3G1lb2oDtMN9/MbWnaCgj0g04mBNL2OlVc9Eeb804lokSm/xSNItNYKGpaJjxx+n6qQC
	e8R3Ts5d+ZKt9Sjw/y/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7r1p-004C5G-2f;
	Tue, 28 Nov 2023 05:53:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7r1m-004C39-1J
	for kexec@lists.infradead.org;
	Tue, 28 Nov 2023 05:52:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701150777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gMr7SNIGWG+LCt67HL84oAYmHREAbz0FAtMx7hLa0hk=;
	b=g2OOUDIfYwtBjOKT3FjoS6N8Asmb83Qg9wkeAwaMnPTw0u5zaEZg/t+wfI8WyGWusNLvqL
	BoFWNfvMmWo7w9VT9tXoAIEsDH1RYIj34bE0wTJEZ7of/JK8Dn84GbDXwVQkCl7ir5ye+h
	PC+w9vrQOjyXR0O5IbEpEtBI6XAFs4c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-QrJwYi1qPxyK5xc4SEBPyQ-1; Tue, 28 Nov 2023 00:52:55 -0500
X-MC-Unique: QrJwYi1qPxyK5xc4SEBPyQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6CCE85A5BD;
	Tue, 28 Nov 2023 05:52:54 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.30])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A2E725028;
	Tue, 28 Nov 2023 05:52:51 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	x86@kernel.org,
	akpm@linux-foundation.org,
	eric_devolder@yahoo.com,
	ignat@cloudflare.com,
	agordeev@linux.ibm.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2] drivers/base/cpu: crash data showing should depends on KEXEC_CORE
Date: Tue, 28 Nov 2023 13:52:48 +0800
Message-ID: <20231128055248.659808-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_215258_523407_849A43C2 
X-CRM114-Status: GOOD (  12.26  )
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

QWZ0ZXIgY29tbWl0IDg4YTZmODk5NDQyMSAoImNyYXNoOiBtZW1vcnkgYW5kIENQVSBob3RwbHVn
IHN5c2ZzCmF0dHJpYnV0ZXMiKSwgb24geDg2XzY0LCBpZiBvbmx5IGJlbG93IGtlcm5lbCBjb25m
aWdzIHJlbGF0ZWQgdG8ga2R1bXAKYXJlIHNldCwgY29tcGlsaW5nIGVycm9yIGFyZSB0cmlnZ2Vy
ZWQuCgotLS0tCkNPTkZJR19DUkFTSF9DT1JFPXkKQ09ORklHX0tFWEVDX0NPUkU9eQpDT05GSUdf
Q1JBU0hfRFVNUD15CkNPTkZJR19DUkFTSF9IT1RQTFVHPXkKLS0tLS0tCgotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KZHJpdmVycy9iYXNlL2Nw
dS5jOiBJbiBmdW5jdGlvbiDigJhjcmFzaF9ob3RwbHVnX3Nob3figJk6CmRyaXZlcnMvYmFzZS9j
cHUuYzozMDk6NDA6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhj
cmFzaF9ob3RwbHVnX2NwdV9zdXBwb3J04oCZOyBkaWQgeW91IG1lYW4g4oCYY3Jhc2hfaG90cGx1
Z19zaG934oCZPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICAzMDkg
fCAgICAgICAgIHJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiVkXG4iLCBjcmFzaF9ob3RwbHVnX2Nw
dV9zdXBwb3J0KCkpOwogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjcmFzaF9ob3RwbHVnX3Nob3cKY2MxOiBzb21lIHdhcm5pbmdz
IGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKQ09ORklHX0tFWEVDIGlzIHVzZWQgdG8gZW5hYmxlIGtl
eGVjX2xvYWQgaW50ZXJmYWNlLCB0aGUKY3Jhc2hfbm90ZXMvY3Jhc2hfbm90ZXNfc2l6ZS9jcmFz
aF9ob3RwbHVnIHNob3dpbmcgZGVwZW5kcyBvbgpDT05GSUdfS0VYRUMgaXMgaW5jb3JyZWN0LiBJ
dCBzaG91bGQgZGVwZW5kIG9uIEtFWEVDX0NPUkUgaW5zdGVhZC4KCkZpeCBpdCBub3cuCgpGaXhl
czogY29tbWl0IDg4YTZmODk5NDQyMSAoImNyYXNoOiBtZW1vcnkgYW5kIENQVSBob3RwbHVnIHN5
c2ZzIGF0dHJpYnV0ZXMiKQpTaWduZWQtb2ZmLWJ5OiBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNv
bT4KLS0tCiBkcml2ZXJzL2Jhc2UvY3B1LmMgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2Uv
Y3B1LmMgYi9kcml2ZXJzL2Jhc2UvY3B1LmMKaW5kZXggOWVhMjJlMTY1YWNkLi41NDg0OTFkZTgx
OGUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYmFzZS9jcHUuYworKysgYi9kcml2ZXJzL2Jhc2UvY3B1
LmMKQEAgLTE0NCw3ICsxNDQsNyBAQCBzdGF0aWMgREVWSUNFX0FUVFIocmVsZWFzZSwgU19JV1VT
UiwgTlVMTCwgY3B1X3JlbGVhc2Vfc3RvcmUpOwogI2VuZGlmIC8qIENPTkZJR19BUkNIX0NQVV9Q
Uk9CRV9SRUxFQVNFICovCiAjZW5kaWYgLyogQ09ORklHX0hPVFBMVUdfQ1BVICovCiAKLSNpZmRl
ZiBDT05GSUdfS0VYRUMKKyNpZmRlZiBDT05GSUdfS0VYRUNfQ09SRQogI2luY2x1ZGUgPGxpbnV4
L2tleGVjLmg+CiAKIHN0YXRpYyBzc2l6ZV90IGNyYXNoX25vdGVzX3Nob3coc3RydWN0IGRldmlj
ZSAqZGV2LApAQCAtMTg5LDE0ICsxODksMTQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1
dGVfZ3JvdXAgY3Jhc2hfbm90ZV9jcHVfYXR0cl9ncm91cCA9IHsKICNlbmRpZgogCiBzdGF0aWMg
Y29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCAqY29tbW9uX2NwdV9hdHRyX2dyb3Vwc1tdID0g
ewotI2lmZGVmIENPTkZJR19LRVhFQworI2lmZGVmIENPTkZJR19LRVhFQ19DT1JFCiAJJmNyYXNo
X25vdGVfY3B1X2F0dHJfZ3JvdXAsCiAjZW5kaWYKIAlOVUxMCiB9OwogCiBzdGF0aWMgY29uc3Qg
c3RydWN0IGF0dHJpYnV0ZV9ncm91cCAqaG90cGx1Z2FibGVfY3B1X2F0dHJfZ3JvdXBzW10gPSB7
Ci0jaWZkZWYgQ09ORklHX0tFWEVDCisjaWZkZWYgQ09ORklHX0tFWEVDX0NPUkUKIAkmY3Jhc2hf
bm90ZV9jcHVfYXR0cl9ncm91cCwKICNlbmRpZgogCU5VTEwKLS0gCjIuNDEuMAoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlz
dAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8va2V4ZWMK
