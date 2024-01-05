Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3529C3DA6E
	for <kexec@archiver.kernel.org>; Fri,  5 Jan 2024 10:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GGloQ0T1/Bl0ty0Ct8+f9OIMrr5S8AE0/dsc7V6Gb7w=; b=xcl0X9vzRW7GNf
	xJDs3wxJVPE0DLhdzYL6ILPvAU4BOADQcg4ZFWB7sBKxnzHuzXhtCYgvedVggv3Jw1CegNxSKzP3r
	6gDpjFsqYGj3G6nlDeUSI5IzmyIyrdvtoYm7EEuG2PbYj9Y/di7vu9uhGdKfJO/r5+thYRlGWN5t3
	Y6Y4axc88p+QmqnOWLXFd55fdwJiTTo3+7IXgdex9nM7Vkc53Jti2pWMgcQFKEhIrOLZKtuIkIrS9
	tzjggmwIq/p9c4hBYtyHmR8BXm2RIcVw4bANnDOk96a3jNpGkAqwVetVLDAFOyDdxkUq5I2smn53g
	RWLq0LrIupOno/BFu5+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLhXr-00GZ3H-0a;
	Fri, 05 Jan 2024 10:35:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLhXo-00GZ1s-1l
	for kexec@lists.infradead.org;
	Fri, 05 Jan 2024 10:35:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704450915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwQeRErFiP9ALDlhlMD7G5tnPyyzVuVb4LWP16+Hv2E=;
	b=TiBpeUeQDQXLPBuSS/ZojQWtQrpdD8/+owSsqWbiYhDVdL/qTQSklxS4AH8rF8Z5P8Egbe
	QlHMFXayknz6r80qGDkaOZDeyU07aR3ucBy6/nLfDvFphbMsQ+4Zq200sv703ro4Kf6IfR
	K2Ja+9CABFZa6i0E0JX4HzIMZaolQmg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-APlWCB4HOHWJeQR4MKcRbA-1; Fri, 05 Jan 2024 05:33:44 -0500
X-MC-Unique: APlWCB4HOHWJeQR4MKcRbA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BC5A833944;
	Fri,  5 Jan 2024 10:33:43 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 19A3B492BC6;
	Fri,  5 Jan 2024 10:33:35 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	kexec@lists.infradead.org,
	hbathini@linux.ibm.com,
	arnd@arndb.de,
	ignat@cloudflare.com,
	eric_devolder@yahoo.com,
	viro@zeniv.linux.org.uk,
	ebiederm@xmission.com,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 4/5] crash: remove dependency of FA_DUMP on CRASH_DUMP
Date: Fri,  5 Jan 2024 18:33:04 +0800
Message-ID: <20240105103305.557273-5-bhe@redhat.com>
In-Reply-To: <20240105103305.557273-1-bhe@redhat.com>
References: <20240105103305.557273-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_023516_737456_812EA30D 
X-CRM114-Status: GOOD (  14.68  )
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

SW4ga2R1bXAga2VybmVsLCAvcHJvYy92bWNvcmUgaXMgYW4gZWxmIGZpbGUgd2hpY2ggbWFwcyB0
aGUgY3Jhc2hlZCBrZXJuZWwncwpyZWFkX2Zyb21fb2xkbWVtbWVtb3J5IGNvbnRlbnQuIEl0cyBl
bGYgaGVhZGVyIGlzIGNvbnN0cnVjdGVkIGluIDFzdCBrZXJuZWwgYW5kIHBhc3NlZAp0byBrZHVt
cCBrZXJuZWwgdmlhIGVsZmNvcmVoZHJfYWRkci4gQ29uZmlnIENSQVNIX0RVTVAgZW5hYmxlcyB0
aGUgY29kZQpvZiAxc3Qga2VybmVsJ3Mgb2xkIG1lbW9yeSBhY2Nlc3NpbmcgaW4gZGlmZmVyZW50
IGFyY2hpdGVjdHVyZXMuCgpDdXJyZW50bHksIGNvbmZpZyBGQV9EVU1QIGhhcyBkZXBlbmRlbmN5
IG9uIENSQVNIX0RVTVAgYmVjYXVzZSBmYWR1bXAKbmVlZHMgYWNjZXNzIGdsb2JhbCB2YXJpYWJs
ZSAnZWxmY29yZWhkcl9hZGRyJyB0byBqdWRnZSBpZiBpdCdzIGluCmtkdW1wIGtlcm5lbCB3aXRo
aW4gZnVuY3Rpb24gaXNfa2R1bXBfa2VybmVsKCkuIEluIGtlcm5lbC9jcmFzaF9kdW1wLmMsCnZh
cmlhYmxlICdlbGZjb3JlaGRyX2FkZHInIGlzIGRlZmluZWQsIGFuZCBmdW5jdGlvbiBzZXR1cF9l
bGZjb3JlaGRyKCkKaXMgdXNlZCB0byBwYXJzZSBrZXJuZWwgcGFyYW1ldGVyICdlbGZjb3JlaGRy
JyB0byBmZXRjaCB0aGUgcGFzc2VkCnZhbHVlIG9mIGVsZmNvcmVoZHJfYWRkci4gV2l0aCB0aGUg
bmVlZCBvZiBhY2Nlc3NpbmcgZWxmY29yZWhkcl9hZGRyLApGQV9EVU1QIGRvZXNuJ3QgaGF2ZSB0
byBkZXBlbmRzIG9uIENSQVNIX0RVTVAuCgpUbyByZW1vdmUgdGhlIGRlcGVuZGVuY3kgb2YgRkFf
RFVNUCBvbiBDUkFTSF9EVU1QIHRvIGF2b2lkIGNvbmZ1c2lvbiwKcmVuYW1lIGtlcm5lbC9jcmFz
aF9kdW1wLmMgdG8ga2VybmVsL2VsZmNvcmVoZHIuYywgYW5kIGJ1aWxkIGl0IHdoZW4KQ09ORklH
X1ZNQ09SRV9JTkZPIGlzIGViYWJsZWQuIFdpdGggdGhpcywgRkFfRFVNUCBkb2Vzbid0IG5lZWQg
dG8gZGVwZW5kCm9uIENSQVNIX0RVTVAuCgpJbiBmaWxlIGluY2x1ZGVkIGZyb20ga2VybmVsL3Zt
Y29yZV9pbmZvLmM6MjU6Cmtlcm5lbC9rZXhlY19pbnRlcm5hbC5oOjExOjU0OiB3YXJuaW5nOiDi
gJhzdHJ1Y3Qga2V4ZWNfc2VnbWVudOKAmSBkZWNsYXJlZCBpbnNpZGUgcGFyYW1ldGVyIGxpc3Qg
d2lsbCBub3QgYmUgdmlzaWJsZSBvdXRzaWRlIG9mIHRoaXMgZGVmaW5pdGlvbiBvciBkZWNsYXJh
dGlvbgogICAxMSB8IGludCBraW1hZ2VfbG9hZF9zZWdtZW50KHN0cnVjdCBraW1hZ2UgKmltYWdl
LCBzdHJ1Y3Qga2V4ZWNfc2VnbWVudCAqc2VnbWVudCk7CiAgICAgIHwgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+CgpTaWdu
ZWQtb2ZmLWJ5OiBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNvbT4KLS0tCiBhcmNoL3Bvd2VycGMv
S2NvbmZpZyAgICAgICAgICAgICAgICAgIHwgMSAtCiBrZXJuZWwvTWFrZWZpbGUgICAgICAgICAg
ICAgICAgICAgICAgIHwgMyArLS0KIGtlcm5lbC97Y3Jhc2hfZHVtcC5jID0+IGVsZmNvcmVoZHIu
Y30gfCAwCiBrZXJuZWwva2V4ZWNfaW50ZXJuYWwuaCAgICAgICAgICAgICAgIHwgMiArKwogNCBm
aWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCiByZW5hbWUga2Vy
bmVsL3tjcmFzaF9kdW1wLmMgPT4gZWxmY29yZWhkci5jfSAoMTAwJSkKCmRpZmYgLS1naXQgYS9h
cmNoL3Bvd2VycGMvS2NvbmZpZyBiL2FyY2gvcG93ZXJwYy9LY29uZmlnCmluZGV4IGQzOTFlOGNk
ZGY2Yy4uMjJhMDQ4OTFjNjhkIDEwMDY0NAotLS0gYS9hcmNoL3Bvd2VycGMvS2NvbmZpZworKysg
Yi9hcmNoL3Bvd2VycGMvS2NvbmZpZwpAQCAtNjkxLDcgKzY5MSw2IEBAIGNvbmZpZyBGQV9EVU1Q
CiAJZGVwZW5kcyBvbiBQUEM2NCAmJiAoUFBDX1JUQVMgfHwgUFBDX1BPV0VSTlYpCiAJc2VsZWN0
IFZNQ09SRV9JTkZPCiAJc2VsZWN0IENSQVNIX1JFU0VSVkUKLQlzZWxlY3QgQ1JBU0hfRFVNUAog
CWhlbHAKIAkgIEEgcm9idXN0IG1lY2hhbmlzbSB0byBnZXQgcmVsaWFibGUga2VybmVsIGNyYXNo
IGR1bXAgd2l0aAogCSAgYXNzaXN0YW5jZSBmcm9tIGZpcm13YXJlLiBUaGlzIGFwcHJvYWNoIGRv
ZXMgbm90IHVzZSBrZXhlYywKZGlmZiAtLWdpdCBhL2tlcm5lbC9NYWtlZmlsZSBiL2tlcm5lbC9N
YWtlZmlsZQppbmRleCAwODk4MGU1YzIwODAuLjI1YWM5MzQ1ZWY3OSAxMDA2NDQKLS0tIGEva2Vy
bmVsL01ha2VmaWxlCisrKyBiL2tlcm5lbC9NYWtlZmlsZQpAQCAtNjgsNyArNjgsNyBAQCBvYmot
JChDT05GSUdfTU9EVUxFX1NJR19GT1JNQVQpICs9IG1vZHVsZV9zaWduYXR1cmUubwogb2JqLSQo
Q09ORklHX0tBTExTWU1TKSArPSBrYWxsc3ltcy5vCiBvYmotJChDT05GSUdfS0FMTFNZTVNfU0VM
RlRFU1QpICs9IGthbGxzeW1zX3NlbGZ0ZXN0Lm8KIG9iai0kKENPTkZJR19CU0RfUFJPQ0VTU19B
Q0NUKSArPSBhY2N0Lm8KLW9iai0kKENPTkZJR19WTUNPUkVfSU5GTykgKz0gdm1jb3JlX2luZm8u
bworb2JqLSQoQ09ORklHX1ZNQ09SRV9JTkZPKSArPSB2bWNvcmVfaW5mby5vIGVsZmNvcmVoZHIu
bwogb2JqLSQoQ09ORklHX0NSQVNIX1JFU0VSVkUpICs9IGNyYXNoX3Jlc2VydmUubwogb2JqLSQo
Q09ORklHX0tFWEVDX0NPUkUpICs9IGtleGVjX2NvcmUubwogb2JqLSQoQ09ORklHX0tFWEVDKSAr
PSBrZXhlYy5vCkBAIC0xMjAsNyArMTIwLDYgQEAgb2JqLSQoQ09ORklHX1BFUkZfRVZFTlRTKSAr
PSBldmVudHMvCiAKIG9iai0kKENPTkZJR19VU0VSX1JFVFVSTl9OT1RJRklFUikgKz0gdXNlci1y
ZXR1cm4tbm90aWZpZXIubwogb2JqLSQoQ09ORklHX1BBREFUQSkgKz0gcGFkYXRhLm8KLW9iai0k
KENPTkZJR19DUkFTSF9EVU1QKSArPSBjcmFzaF9kdW1wLm8KIG9iai0kKENPTkZJR19KVU1QX0xB
QkVMKSArPSBqdW1wX2xhYmVsLm8KIG9iai0kKENPTkZJR19DT05URVhUX1RSQUNLSU5HKSArPSBj
b250ZXh0X3RyYWNraW5nLm8KIG9iai0kKENPTkZJR19UT1JUVVJFX1RFU1QpICs9IHRvcnR1cmUu
bwpkaWZmIC0tZ2l0IGEva2VybmVsL2NyYXNoX2R1bXAuYyBiL2tlcm5lbC9lbGZjb3JlaGRyLmMK
c2ltaWxhcml0eSBpbmRleCAxMDAlCnJlbmFtZSBmcm9tIGtlcm5lbC9jcmFzaF9kdW1wLmMKcmVu
YW1lIHRvIGtlcm5lbC9lbGZjb3JlaGRyLmMKZGlmZiAtLWdpdCBhL2tlcm5lbC9rZXhlY19pbnRl
cm5hbC5oIGIva2VybmVsL2tleGVjX2ludGVybmFsLmgKaW5kZXggNzRkYTE0MDljZDE0Li4yNTk1
ZGVmZThjMGQgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9rZXhlY19pbnRlcm5hbC5oCisrKyBiL2tlcm5l
bC9rZXhlY19pbnRlcm5hbC5oCkBAIC00LDYgKzQsOCBAQAogCiAjaW5jbHVkZSA8bGludXgva2V4
ZWMuaD4KIAorc3RydWN0IGtleGVjX3NlZ21lbnQ7CisKIHN0cnVjdCBraW1hZ2UgKmRvX2tpbWFn
ZV9hbGxvY19pbml0KHZvaWQpOwogaW50IHNhbml0eV9jaGVja19zZWdtZW50X2xpc3Qoc3RydWN0
IGtpbWFnZSAqaW1hZ2UpOwogdm9pZCBraW1hZ2VfZnJlZV9wYWdlX2xpc3Qoc3RydWN0IGxpc3Rf
aGVhZCAqbGlzdCk7Ci0tIAoyLjQxLjAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
