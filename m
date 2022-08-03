Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AF7C19F28
	for <kexec@archiver.kernel.org>; Wed,  3 Aug 2022 16:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=umVvvqo9DM7o+I7/FH2U9pBZO1CTg8FE+vE85ocV3ac=; b=SxbuswDU1oSGja
	vk7smIxFJWRs0O1sY6rHdXYGamgkrFVOq9izNbZOC6K2oerq5Ye4Eq2KyrUIbnvvtJZ3LsKLkeokQ
	JB7RhcBs9zkFb0Jps+S6CbD8CgNkhTEW5O0soko5BVWE0ZIrX2tHVjasp47FFau2yoDNcyJm5GfBG
	EFMtx2pTbUdT6NBBXPrl+k3nacFQlasRoTucx4VlC3w8PKy9zDwK68PdWcTV6F5zJ+aXP3vV8+RHh
	vN/B6kJEeTn6gxU1H5/D5HKB5IBWu4FdGe7bT3+VTAdFiv//GWl7q3c5v/WeCTwxHo0RwNEriv8QE
	gow8gKGG8Ga4w+2ulloA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJGnp-007LL0-BM; Wed, 03 Aug 2022 16:00:57 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJGnj-007LIO-GF
	for kexec@lists.infradead.org; Wed, 03 Aug 2022 16:00:55 +0000
Received: by mail-wm1-x334.google.com with SMTP id r67-20020a1c4446000000b003a34ac64bdfso778918wma.1
        for <kexec@lists.infradead.org>; Wed, 03 Aug 2022 09:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QzJ33F4bJ7lwM5+m7mFsAcHdJMltjNvGnkKDEEt7hbs=;
        b=GPH5p6d1RDaRq+0Zommh1vpqc/rVqUPvZhgldr8qZLtuDtE+SjR13i2nnWrfSbH75X
         qH5TcRiDQCDkmHTRELxZKGL/gFt67o+6ViJ+oDt9+KG1Lwic6XzFNMun+N8rPczXN8W4
         MTDKYbO2iyKrdEidEOrGgAiFv4c/E4OYYPnl+cs+s62wkPZkf3e5TOXU+l/Z0JyESNA7
         NsIzQl7NiZdXhG+lljjL0B+6CtN9qZkrY72e6LOe5lCyspAg2xuxetRXFIBHg5s0VnJ0
         V23kNJBsAeweX1hyiYcF36v1+dLZFqZ7JgEOqKBihdHIUGBen9+3IkYt51PmcNaaTJVB
         WT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QzJ33F4bJ7lwM5+m7mFsAcHdJMltjNvGnkKDEEt7hbs=;
        b=cCkB+gegOCgNPPhFjKb+UivPUlre6hii0qZDw2UDDzFS0V7UheQrgxfDZUsxFhxNqe
         JOa3vwr8/fk2FFVFEoHlLmY5AsIOZzA6/re2PzPyz1BBfXQaRvAPSE67ApakOPMozjDy
         nsOndwSFA5rY2MyvdNPJIRxy2hAwWwZyCM0f4zuJr8KxzZNYafDIN3Q6Wf9WJvLw5/7x
         UjT2HvSdJTUMaiS+Nl6nyF/pp2/pSVZfgpfVu2p664+g4OHuVwyAXRbVfd/GZnO6lUoa
         iMA/dhhVEp9nC99vS002mt2hThe3BieDIlBB65ceobOYVDGTyDiBzHel+zeNl4ERtJgP
         sowg==
X-Gm-Message-State: ACgBeo1CjHb8tZ5gQgSsU7Adgk960ig1dEDcjFLp3mxYkpkFUzuxRqrs
	668Zbvbz8uqGENzFWC21500=
X-Google-Smtp-Source: AA6agR7gh74XwmyAbfY14lbZQdG53vZykNPX0zVuHCQF2W2ATYMiBkU9yNmH2ufnF7yDHKBOcRrXaQ==
X-Received: by 2002:a05:600c:35c6:b0:3a3:4217:f06e with SMTP id r6-20020a05600c35c600b003a34217f06emr3167664wmq.95.1659542445094;
        Wed, 03 Aug 2022 09:00:45 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c19cb00b003a302fb9df7sm3240896wmq.21.2022.08.03.09.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 09:00:43 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Baoquan He <bhe@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3] kexec: Replace kmap() with kmap_local_page()
Date: Wed,  3 Aug 2022 18:00:38 +0200
Message-Id: <20220803160038.22322-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220803_090054_081987_B4491D97 
X-CRM114-Status: GOOD (  15.05  )
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

a21hcCgpIGlzIGJlaW5nIGRlcHJlY2F0ZWQgaW4gZmF2b3Igb2Yga21hcF9sb2NhbF9wYWdlKCku
CgpUaGVyZSBhcmUgdHdvIG1haW4gcHJvYmxlbXMgd2l0aCBrbWFwKCk6ICgxKSBJdCBjb21lcyB3
aXRoIGFuIG92ZXJoZWFkIGFzCm1hcHBpbmcgc3BhY2UgaXMgcmVzdHJpY3RlZCBhbmQgcHJvdGVj
dGVkIGJ5IGEgZ2xvYmFsIGxvY2sgZm9yCnN5bmNocm9uaXphdGlvbiBhbmQgKDIpIGl0IGFsc28g
cmVxdWlyZXMgZ2xvYmFsIFRMQiBpbnZhbGlkYXRpb24gd2hlbiB0aGUKa21hcOKAmXMgcG9vbCB3
cmFwcyBhbmQgaXQgbWlnaHQgYmxvY2sgd2hlbiB0aGUgbWFwcGluZyBzcGFjZSBpcyBmdWxseQp1
dGlsaXplZCB1bnRpbCBhIHNsb3QgYmVjb21lcyBhdmFpbGFibGUuCgpXaXRoIGttYXBfbG9jYWxf
cGFnZSgpIHRoZSBtYXBwaW5ncyBhcmUgcGVyIHRocmVhZCwgQ1BVIGxvY2FsLCBjYW4gdGFrZQpw
YWdlIGZhdWx0cywgYW5kIGNhbiBiZSBjYWxsZWQgZnJvbSBhbnkgY29udGV4dCAoaW5jbHVkaW5n
IGludGVycnVwdHMpLgpJdCBpcyBmYXN0ZXIgdGhhbiBrbWFwKCkgaW4ga2VybmVscyB3aXRoIEhJ
R0hNRU0gZW5hYmxlZC4gRnVydGhlcm1vcmUsCnRoZSB0YXNrcyBjYW4gYmUgcHJlZW1wdGVkIGFu
ZCwgd2hlbiB0aGV5IGFyZSBzY2hlZHVsZWQgdG8gcnVuIGFnYWluLCB0aGUKa2VybmVsIHZpcnR1
YWwgYWRkcmVzc2VzIGFyZSByZXN0b3JlZCBhbmQgYXJlIHN0aWxsIHZhbGlkLgoKU2luY2UgaXRz
IHVzZSBpbiBrZXhlY19jb3JlLmMgaXMgc2FmZSBldmVyeXdoZXJlLCBpdCBzaG91bGQgYmUgcHJl
ZmVycmVkLgoKVGhlcmVmb3JlLCByZXBsYWNlIGttYXAoKSB3aXRoIGttYXBfbG9jYWxfcGFnZSgp
IGluIGtleGVjX2NvcmUuYy4KClRlc3RlZCBvbiBhIFFFTVUvS1ZNIHg4Nl8zMiBWTSwgNkdCIFJB
TSwgYm9vdGluZyBhIGtlcm5lbCB3aXRoCkhJR0hNRU02NEdCIGVuYWJsZWQuCgpTdWdnZXN0ZWQt
Ynk6IElyYSBXZWlueSA8aXJhLndlaW55QGludGVsLmNvbT4KUmV2aWV3ZWQtYnk6IElyYSBXZWlu
eSA8aXJhLndlaW55QGludGVsLmNvbT4KQWNrZWQtYnk6IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQu
Y29tPgpTaWduZWQtb2ZmLWJ5OiBGYWJpbyBNLiBEZSBGcmFuY2VzY28gPGZtZGVmcmFuY2VzY29A
Z21haWwuY29tPgotLS0KCnYyLT52MzogQWRkIG1vcmUgaW5mb3JtYXRpb24gaW4gdGhlIGNvbW1p
dCBtZXNzYWdlIGFzIHJlcXVlc3RlZCBieSBCYW9xdWFuCkhlIGFuZCBmb3J3YXJkIHR3byB0YWdz
LCByZXNwZWN0aXZlbHkgZnJvbSBJcmEgV2VpbnkgYW5kIEJhb3F1YW4gSGUgKG1hbnkKdGhhbmtz
IHRvIHRoZW0gdHdvISkuCgp2MS0+djI6IEEgc2VudGVuY2Ugb2YgdGhlIGNvbW1pdCBtZXNzYWdl
IGNvbnRhaW5lZCBhbiBlcnJvciBkdWUgdG8gYQptaXN0YWtlIGluIGNvcHktcGFzdGluZyBmcm9t
IGEgcHJldmlvdXMgcGF0Y2guIFJlcGxhY2UgImFpby5jIiB3aXRoCiJrZXhlY19jb3JlLmMiLgoK
IGtlcm5lbC9rZXhlY19jb3JlLmMgfCA4ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2tlcm5lbC9rZXhlY19jb3Jl
LmMgYi9rZXJuZWwva2V4ZWNfY29yZS5jCmluZGV4IDRkMzRjNzgzMzRjZS4uNmY5ODI3NDc2NWQ0
IDEwMDY0NAotLS0gYS9rZXJuZWwva2V4ZWNfY29yZS5jCisrKyBiL2tlcm5lbC9rZXhlY19jb3Jl
LmMKQEAgLTgxNCw3ICs4MTQsNyBAQCBzdGF0aWMgaW50IGtpbWFnZV9sb2FkX25vcm1hbF9zZWdt
ZW50KHN0cnVjdCBraW1hZ2UgKmltYWdlLAogCQlpZiAocmVzdWx0IDwgMCkKIAkJCWdvdG8gb3V0
OwogCi0JCXB0ciA9IGttYXAocGFnZSk7CisJCXB0ciA9IGttYXBfbG9jYWxfcGFnZShwYWdlKTsK
IAkJLyogU3RhcnQgd2l0aCBhIGNsZWFyIHBhZ2UgKi8KIAkJY2xlYXJfcGFnZShwdHIpOwogCQlw
dHIgKz0gbWFkZHIgJiB+UEFHRV9NQVNLOwpAQCAtODI3LDcgKzgyNyw3IEBAIHN0YXRpYyBpbnQg
a2ltYWdlX2xvYWRfbm9ybWFsX3NlZ21lbnQoc3RydWN0IGtpbWFnZSAqaW1hZ2UsCiAJCQltZW1j
cHkocHRyLCBrYnVmLCB1Y2h1bmspOwogCQllbHNlCiAJCQlyZXN1bHQgPSBjb3B5X2Zyb21fdXNl
cihwdHIsIGJ1ZiwgdWNodW5rKTsKLQkJa3VubWFwKHBhZ2UpOworCQlrdW5tYXBfbG9jYWwocHRy
KTsKIAkJaWYgKHJlc3VsdCkgewogCQkJcmVzdWx0ID0gLUVGQVVMVDsKIAkJCWdvdG8gb3V0OwpA
QCAtODc4LDcgKzg3OCw3IEBAIHN0YXRpYyBpbnQga2ltYWdlX2xvYWRfY3Jhc2hfc2VnbWVudChz
dHJ1Y3Qga2ltYWdlICppbWFnZSwKIAkJCWdvdG8gb3V0OwogCQl9CiAJCWFyY2hfa2V4ZWNfcG9z
dF9hbGxvY19wYWdlcyhwYWdlX2FkZHJlc3MocGFnZSksIDEsIDApOwotCQlwdHIgPSBrbWFwKHBh
Z2UpOworCQlwdHIgPSBrbWFwX2xvY2FsX3BhZ2UocGFnZSk7CiAJCXB0ciArPSBtYWRkciAmIH5Q
QUdFX01BU0s7CiAJCW1jaHVuayA9IG1pbl90KHNpemVfdCwgbWJ5dGVzLAogCQkJCVBBR0VfU0la
RSAtIChtYWRkciAmIH5QQUdFX01BU0spKTsKQEAgLTg5NCw3ICs4OTQsNyBAQCBzdGF0aWMgaW50
IGtpbWFnZV9sb2FkX2NyYXNoX3NlZ21lbnQoc3RydWN0IGtpbWFnZSAqaW1hZ2UsCiAJCWVsc2UK
IAkJCXJlc3VsdCA9IGNvcHlfZnJvbV91c2VyKHB0ciwgYnVmLCB1Y2h1bmspOwogCQlrZXhlY19m
bHVzaF9pY2FjaGVfcGFnZShwYWdlKTsKLQkJa3VubWFwKHBhZ2UpOworCQlrdW5tYXBfbG9jYWwo
cHRyKTsKIAkJYXJjaF9rZXhlY19wcmVfZnJlZV9wYWdlcyhwYWdlX2FkZHJlc3MocGFnZSksIDEp
OwogCQlpZiAocmVzdWx0KSB7CiAJCQlyZXN1bHQgPSAtRUZBVUxUOwotLSAKMi4zNy4xCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
