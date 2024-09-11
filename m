Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157D3EE4991
	for <kexec@archiver.kernel.org>; Wed, 11 Sep 2024 10:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jCUT3h6F06g33bpnTFOUNio+ANQrynx8vdeU3E48KNo=; b=mBqWJfA/vIh06D
	fsc3vwVGy9z2tDGhJq5wBQlSxDcUMNQD5jNqqoykDVr0/ZviTWNcSHAK96E393zxajLZ97ccXVXvi
	nRgzbaSWnvQ3fLxU6agTPFGqbdWqGii1WVa9LnwOLa7e8qNSHicF6KRWmjUwk1KXZOj/6AbplkCcm
	DF2udj43rK/t65MRD2ZtQhGSysaExYythZLsbBo+GOg7cPHcChdmKEiEYFywdOrFyiv0LQ1IORe4X
	LIuQZL8Y8Ix3vJ2ZMoY7KcWThhffq3ShPKZoUzBzIjUPegM6Ae/H+cPV6NKHea47/83a9VTvaYuyb
	wsy3+e2HR6YTvJVb/KkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soKos-0000000995M-3knv;
	Wed, 11 Sep 2024 10:43:30 +0000
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soKmf-000000098RV-45az
	for kexec@lists.infradead.org;
	Wed, 11 Sep 2024 10:41:15 +0000
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7a7f8b0b7d0so332472885a.2
        for <kexec@lists.infradead.org>; Wed, 11 Sep 2024 03:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726051272; x=1726656072; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1edNQlk5ea4r0KquDgZgNfAFToaTDxkGFM4S8J4/mCg=;
        b=JwYtUSR4gRgNsj85Vi+QCWw00GQCSIeFmc/UzmquNLwKkg0QMZ0cImVbi0takTVbOo
         gN/51mQOjIuLnfxadDOLFhnWmMNawNYdPGk3Eoec3m/6sq6tNN40r0kjHlRZwgkG1TPR
         PzSoHVuTsL/iVVQv72O1ulHk2hfPBFUDTKwHlYTPPrZ7FBNCPX9FYAll1h3C3mx0I42a
         23yCeZYpwD3XAmlVPt0pf+c0qzSm+oSnpBL/wsFDeT6y33QP9tZFgu1NK0GsK4xxxuyA
         8GbFblpkSwFtc6xAXAa3Fuhyx4XcU89wQAS4eUpU/CaTR471f7XbmTb0YDYCd4csy5hh
         YVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726051272; x=1726656072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1edNQlk5ea4r0KquDgZgNfAFToaTDxkGFM4S8J4/mCg=;
        b=gPLARUzHZYwwW+CNbI3obab2urjuvpATGNPv6SsByaQLr3P6zyxg9+cX/WcN9GpxWx
         3LXlFYIuFYt4LHLh9ihA8G/e2pKAGm3hTKkLOzDlfkKfbwacGqNEKT4G9lPagEXAeg8x
         d4LSUx6TJ0xccbv479hqQKVwGWgYZZ+74xhpVpenrmUdzJaanlivOIN6dnf/ZsL9vmzf
         KEycmgNnWWpp+Q0Ne1sLeRNpS62czJ7HGIdRvGSsGx8DXlDih+QgwOc1LuvsCKeOIHpu
         zjF55somQ7jGf5MWq4p03HOi6PU1bU9GgTmP5iuPC/l7NgQFXlsgg6PyeNOtsug8ZTIR
         WY9w==
X-Forwarded-Encrypted: i=1; AJvYcCWGAC961bDzb6KzfN1qoZ/UGoZj5qhm2erMTLxqIjNG1W5Rz775RmF9c2WtiTlMv1WrNGdEIw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx4C8nbt+dEzRuRTD+IuMJInnjYTzBYggzimpwL7XryhYTxo+e+
	vh1ALYSue45do/DGowNd6qC60Du/ydbVDh0TemRXAs/CrPgZS8k9
X-Google-Smtp-Source: AGHT+IEAJQ13VovN3MOTS+6Hjw3x8lAetl1VfnJ5y1/hS1UwpDsIO/+d03FxCjNQtSx+nHmHmIIoDA==
X-Received: by 2002:a05:620a:294c:b0:7a3:51ed:38b5 with SMTP id af79cd13be357-7a99727cb11mr3087991685a.0.1726051272264;
        Wed, 11 Sep 2024 03:41:12 -0700 (PDT)
Received: from localhost (fwdproxy-ash-001.fbsv.net. [2a03:2880:20ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a79455b1sm407594885a.19.2024.09.11.03.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:41:11 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: linux-efi@vger.kernel.org,
	devel@edk2.groups.io,
	kexec@lists.infradead.org
Cc: ardb@kernel.org,
	ebiederm@xmission.com,
	bhe@redhat.com,
	vgoyal@redhat.com,
	tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	leitao@debian.org,
	rmikey@meta.com,
	gourry@gourry.net,
	Usama Arif <usamaarif642@gmail.com>
Subject: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
Date: Wed, 11 Sep 2024 11:41:08 +0100
Message-ID: <20240911104109.1831501-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_034114_039465_839A5B37 
X-CRM114-Status: GOOD (  19.27  )
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

TG9va2luZyBhdCB0aGUgVFBNIHNwZWMgWzFdCgpJZiB0aGUgQUNQSSBUUE0yIHRhYmxlIGNvbnRh
aW5zIHRoZSBhZGRyZXNzIGFuZCBzaXplIG9mIHRoZSBQbGF0Zm9ybQpGaXJtd2FyZSBUQ0cgbG9n
LCBmaXJtd2FyZSDigJxwaW5z4oCdIHRoZSBtZW1vcnkgYXNzb2NpYXRlZCB3aXRoIHRoZQpQbGF0
Zm9ybSBGaXJtd2FyZVRDRyBsb2csIGFuZCByZXBvcnRzIHRoaXMgbWVtb3J5IGFzIOKAnFJlc2Vy
dmVk4oCdIG1lbW9yeQp2aWEgdGhlIElOVCAxNWgvRTgyMCBpbnRlcmZhY2UuCgpJdCBsb29rcyBs
aWtlIHRoZSBmaXJtd2FyZSBzaG91bGQgcGFzcyB0aGlzIGFzIHJlc2VydmVkIGluIGU4MjAgbWVt
b3J5Cm1hcC4gSG93ZXZlciwgaXQgZG9lc24ndCBzZWVtIHRvLiBUaGUgZmlybXdhcmUgYmVpbmcg
dGVzdGVkIG9uIGlzOgpkbWlkZWNvZGUgLXMgYmlvcy12ZXJzaW9uCmVkazItMjAyNDAyMTQtMi5l
bDkKCldoZW4gdGhpcyBhcmVhIGlzIG5vdCByZXNlcnZlZCwgaXQgY29tZXMgdXAgYXMgdXNhYmxl
IGluCi9zeXMvZmlybXdhcmUvbWVtbWFwLiBUaGlzIG1lYW5zIHRoYXQga2V4ZWMsIHdoaWNoIHVz
ZXMgdGhhdCBtZW1tYXAKdG8gZmluZCB1c2FibGUgbWVtb3J5IHJlZ2lvbnMsIGNhbiBzZWxlY3Qg
dGhlIHJlZ2lvbiB3aGVyZSBlZmkudHBtX2xvZwppcyBhbmQgb3ZlcndyaXRlIGl0IGFuZCByZWxv
Y2F0ZV9rZXJuZWwuCgpIYXZpbmcgYSBmaXggaW4gZmlybXdhcmUgY2FuIGJlIGRpZmZpY3VsdCB0
byBnZXQgdGhyb3VnaC4gQXMgYSBzZWNvbmRhcnkKZml4LCB0aGlzIHBhdGNoIG1hcmtzIHRoYXQg
cmVnaW9uIGFzIHJlc2VydmVkIGluIGU4MjBfdGFibGVfZmlybXdhcmUgaWYgaXQKaXMgY3VycmVu
dGx5IEU4MjBfVFlQRV9SQU0gc28gdGhhdCBrZXhlYyBkb2Vzbid0IHVzZSBpdCBmb3Iga2VybmVs
IHNlZ21lbnRzLgoKWzFdIGh0dHBzOi8vdHJ1c3RlZGNvbXB1dGluZ2dyb3VwLm9yZy93cC1jb250
ZW50L3VwbG9hZHMvUEMtQ2xpZW50UGxhdGZvcm1fUHJvZmlsZV9mb3JfVFBNXzJwMF9TeXN0ZW1z
X3Y0OV8xNjExMTRfcHVibGljLXJldmlldy5wZGYKClNpZ25lZC1vZmYtYnk6IFVzYW1hIEFyaWYg
PHVzYW1hYXJpZjY0MkBnbWFpbC5jb20+Ci0tLQogYXJjaC94ODYvaW5jbHVkZS9hc20vZTgyMC9h
cGkuaCB8IDIgKysKIGFyY2gveDg2L2tlcm5lbC9lODIwLmMgICAgICAgICAgfCA2ICsrKysrKwog
YXJjaC94ODYvcGxhdGZvcm0vZWZpL2VmaS5jICAgICB8IDkgKysrKysrKysrCiBkcml2ZXJzL2Zp
cm13YXJlL2VmaS90cG0uYyAgICAgIHwgMiArLQogaW5jbHVkZS9saW51eC9lZmkuaCAgICAgICAg
ICAgICB8IDcgKysrKysrKwogNSBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vZTgyMC9hcGkuaCBi
L2FyY2gveDg2L2luY2x1ZGUvYXNtL2U4MjAvYXBpLmgKaW5kZXggMmU3NGE3ZjBlOTM1Li40ZTlh
YTI0ZjAzYmQgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2U4MjAvYXBpLmgKKysr
IGIvYXJjaC94ODYvaW5jbHVkZS9hc20vZTgyMC9hcGkuaApAQCAtMTYsNiArMTYsOCBAQCBleHRl
cm4gYm9vbCBlODIwX19tYXBwZWRfYWxsKHU2NCBzdGFydCwgdTY0IGVuZCwgZW51bSBlODIwX3R5
cGUgdHlwZSk7CiAKIGV4dGVybiB2b2lkIGU4MjBfX3JhbmdlX2FkZCAgICh1NjQgc3RhcnQsIHU2
NCBzaXplLCBlbnVtIGU4MjBfdHlwZSB0eXBlKTsKIGV4dGVybiB1NjQgIGU4MjBfX3JhbmdlX3Vw
ZGF0ZSh1NjQgc3RhcnQsIHU2NCBzaXplLCBlbnVtIGU4MjBfdHlwZSBvbGRfdHlwZSwgZW51bSBl
ODIwX3R5cGUgbmV3X3R5cGUpOworZXh0ZXJuIHU2NCAgZTgyMF9fcmFuZ2VfdXBkYXRlX2Zpcm13
YXJlKHU2NCBzdGFydCwgdTY0IHNpemUsIGVudW0gZTgyMF90eXBlIG9sZF90eXBlLAorCQkJCQll
bnVtIGU4MjBfdHlwZSBuZXdfdHlwZSk7CiBleHRlcm4gdTY0ICBlODIwX19yYW5nZV9yZW1vdmUo
dTY0IHN0YXJ0LCB1NjQgc2l6ZSwgZW51bSBlODIwX3R5cGUgb2xkX3R5cGUsIGJvb2wgY2hlY2tf
dHlwZSk7CiBleHRlcm4gdTY0ICBlODIwX19yYW5nZV91cGRhdGVfdGFibGUoc3RydWN0IGU4MjBf
dGFibGUgKnQsIHU2NCBzdGFydCwgdTY0IHNpemUsIGVudW0gZTgyMF90eXBlIG9sZF90eXBlLCBl
bnVtIGU4MjBfdHlwZSBuZXdfdHlwZSk7CiAKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9l
ODIwLmMgYi9hcmNoL3g4Ni9rZXJuZWwvZTgyMC5jCmluZGV4IDQ4OTNkMzBjZTQzOC4uOTEyNDAw
MTYxNjIzIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvZTgyMC5jCisrKyBiL2FyY2gveDg2
L2tlcm5lbC9lODIwLmMKQEAgLTUzOCw2ICs1MzgsMTIgQEAgdTY0IF9faW5pdCBlODIwX19yYW5n
ZV91cGRhdGVfdGFibGUoc3RydWN0IGU4MjBfdGFibGUgKnQsIHU2NCBzdGFydCwgdTY0IHNpemUs
CiAJcmV0dXJuIF9fZTgyMF9fcmFuZ2VfdXBkYXRlKHQsIHN0YXJ0LCBzaXplLCBvbGRfdHlwZSwg
bmV3X3R5cGUpOwogfQogCit1NjQgX19pbml0IGU4MjBfX3JhbmdlX3VwZGF0ZV9maXJtd2FyZSh1
NjQgc3RhcnQsIHU2NCBzaXplLCBlbnVtIGU4MjBfdHlwZSBvbGRfdHlwZSwKKwkJCQkgICAgICAg
ZW51bSBlODIwX3R5cGUgbmV3X3R5cGUpCit7CisJcmV0dXJuIF9fZTgyMF9fcmFuZ2VfdXBkYXRl
KGU4MjBfdGFibGVfZmlybXdhcmUsIHN0YXJ0LCBzaXplLCBvbGRfdHlwZSwgbmV3X3R5cGUpOwor
fQorCiAvKiBSZW1vdmUgYSByYW5nZSBvZiBtZW1vcnkgZnJvbSB0aGUgRTgyMCB0YWJsZTogKi8K
IHU2NCBfX2luaXQgZTgyMF9fcmFuZ2VfcmVtb3ZlKHU2NCBzdGFydCwgdTY0IHNpemUsIGVudW0g
ZTgyMF90eXBlIG9sZF90eXBlLCBib29sIGNoZWNrX3R5cGUpCiB7CmRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9wbGF0Zm9ybS9lZmkvZWZpLmMgYi9hcmNoL3g4Ni9wbGF0Zm9ybS9lZmkvZWZpLmMKaW5k
ZXggODhhOTY4MTZkZTlhLi5hYTk1Zjc3ZDdhMzAgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L3BsYXRm
b3JtL2VmaS9lZmkuYworKysgYi9hcmNoL3g4Ni9wbGF0Zm9ybS9lZmkvZWZpLmMKQEAgLTE3MSw2
ICsxNzEsMTUgQEAgc3RhdGljIHZvaWQgX19pbml0IGRvX2FkZF9lZmlfbWVtbWFwKHZvaWQpCiAJ
ZTgyMF9fdXBkYXRlX3RhYmxlKGU4MjBfdGFibGUpOwogfQogCisvKiBSZXNlcnZlIGZpcm13YXJl
IGFyZWEgaWYgaXQgd2FzIG1hcmtlZCBhcyBSQU0gKi8KK3ZvaWQgYXJjaF91cGRhdGVfZmlybXdh
cmVfYXJlYSh1NjQgYWRkciwgdTY0IHNpemUpCit7CisJaWYgKGU4MjBfX2dldF9lbnRyeV90eXBl
KGFkZHIsIGFkZHIgKyBzaXplKSA9PSBFODIwX1RZUEVfUkFNKSB7CisJCWU4MjBfX3JhbmdlX3Vw
ZGF0ZV9maXJtd2FyZShhZGRyLCBzaXplLCBFODIwX1RZUEVfUkFNLCBFODIwX1RZUEVfUkVTRVJW
RUQpOworCQllODIwX191cGRhdGVfdGFibGUoZTgyMF90YWJsZV9maXJtd2FyZSk7CisJfQorfQor
CiAvKgogICogR2l2ZW4gYWRkX2VmaV9tZW1tYXAgZGVmYXVsdHMgdG8gMCBhbmQgdGhlcmUgaXMg
bm8gYWx0ZXJuYXRpdmUKICAqIGU4MjAgbWVjaGFuaXNtIGZvciBzb2Z0LXJlc2VydmVkIG1lbW9y
eSwgaW1wb3J0IHRoZSBmdWxsIEVGSSBtZW1vcnkKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdh
cmUvZWZpL3RwbS5jIGIvZHJpdmVycy9maXJtd2FyZS9lZmkvdHBtLmMKaW5kZXggZThkNjliZDU0
OGYzLi44ZTZlNzEzMWQ3MTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL3RwbS5j
CisrKyBiL2RyaXZlcnMvZmlybXdhcmUvZWZpL3RwbS5jCkBAIC02MCw2ICs2MCw3IEBAIGludCBf
X2luaXQgZWZpX3RwbV9ldmVudGxvZ19pbml0KHZvaWQpCiAJfQogCiAJdGJsX3NpemUgPSBzaXpl
b2YoKmxvZ190YmwpICsgbG9nX3RibC0+c2l6ZTsKKwlhcmNoX3VwZGF0ZV9maXJtd2FyZV9hcmVh
KGVmaS50cG1fbG9nLCB0Ymxfc2l6ZSk7CiAJbWVtYmxvY2tfcmVzZXJ2ZShlZmkudHBtX2xvZywg
dGJsX3NpemUpOwogCiAJaWYgKGVmaS50cG1fZmluYWxfbG9nID09IEVGSV9JTlZBTElEX1RBQkxF
X0FERFIpIHsKQEAgLTEwNyw0ICsxMDgsMyBAQCBpbnQgX19pbml0IGVmaV90cG1fZXZlbnRsb2df
aW5pdCh2b2lkKQogCWVhcmx5X21lbXVubWFwKGxvZ190YmwsIHNpemVvZigqbG9nX3RibCkpOwog
CXJldHVybiByZXQ7CiB9Ci0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZWZpLmggYi9pbmNs
dWRlL2xpbnV4L2VmaS5oCmluZGV4IDZiZjNjNGZlODUxMS4uOWMyMzljZGZmNzcxIDEwMDY0NAot
LS0gYS9pbmNsdWRlL2xpbnV4L2VmaS5oCisrKyBiL2luY2x1ZGUvbGludXgvZWZpLmgKQEAgLTEz
NzEsNCArMTM3MSwxMSBAQCBleHRlcm4gc3RydWN0IGJsb2NraW5nX25vdGlmaWVyX2hlYWQgZWZp
dmFyX29wc19uaDsKIHZvaWQgZWZpdmFyc19nZW5lcmljX29wc19yZWdpc3Rlcih2b2lkKTsKIHZv
aWQgZWZpdmFyc19nZW5lcmljX29wc191bnJlZ2lzdGVyKHZvaWQpOwogCisjaWZkZWYgQ09ORklH
X1g4Nl82NAordm9pZCBfX2luaXQgYXJjaF91cGRhdGVfZmlybXdhcmVfYXJlYSh1NjQgYWRkciwg
dTY0IHNpemUpOworI2Vsc2UKK3N0YXRpYyBpbmxpbmUgdm9pZCBfX2luaXQgYXJjaF91cGRhdGVf
ZmlybXdhcmVfYXJlYSh1NjQgYWRkciwgdTY0IHNpemUpCit7Cit9CisjZW5kaWYKICNlbmRpZiAv
KiBfTElOVVhfRUZJX0ggKi8KLS0gCjIuNDMuNQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4
ZWMK
