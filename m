Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A886C32789
	for <kexec@archiver.kernel.org>; Sun, 21 Aug 2022 18:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=HnSZEDVNI716wQsgboMLGtEm7teBBESVNq8vuRw6AvQ=; b=oX1Lrvw7pvK2B/
	HzyRNUxdaKJaNy76/rZxyQ+H4Ba53+jc+owTfsdLXYE8YrPkk98GawoYsXdp641QaWBAmd1rhAnKO
	W3D5vag/girAYbmRigXNdXYBBgCOuM7nNlUoElb05xxd85NP9mlHVEepayAk90H19+6AZdud8a63/
	KdZvRER51/K1YXtUlsXqrR3jevJayA9cyq3xT44dP815sPFT4MRfK2C8RDtBOADFwHISF6TvOHGyb
	Hci/kwTlYsILVA9vOktWDw+7SCEfsYARxV2iol59HKaw3c9rcq3wW0/vzcL0hEL7wVHoCSyl6/DaX
	KqCk3Zy0mnEVcv8HcHIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPpdj-00DKRJ-Uq; Sun, 21 Aug 2022 18:25:40 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPpdX-00DKOV-Ir
	for kexec@lists.infradead.org; Sun, 21 Aug 2022 18:25:29 +0000
Received: by mail-ej1-x62a.google.com with SMTP id gi31so10918441ejc.5
        for <kexec@lists.infradead.org>; Sun, 21 Aug 2022 11:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=5U5zU5oXxguyJCAtCcE2r9M+BIs+bxw2F5L0kHaD1EY=;
        b=DT1Y3xdSeXplcTETEuE4uhCY4yUkNa1Ix0OXL9y1tJwp2UpBWzBB/wo3tVvCD91XX3
         FsNWz+IRlziNNl+yLYRcjlMoqPET4PyWkxSVkkSX/zyRW5ft8oN9UqdyxiPtksrBa6q0
         hSiK5tnye6ypgISwXYS6j44z1HsasSpF4YzMjZ2oP/XjP8jPTMYblbvTaarOZc4Utryj
         /j6/q7mZ4a7frLW4gaqV3kP3Mj97uPoyHD8Du3Pw2PXwt/xULxvQA0iJD42+8DHcbrp0
         MNC0aBNSo2OBQFFNXOysKEUn1rR4jQfyndFXohH3NNad9EvEV3mzCzkPOgZBljQRUqUM
         pULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=5U5zU5oXxguyJCAtCcE2r9M+BIs+bxw2F5L0kHaD1EY=;
        b=vMboqtZFs1JzOlDbvZ9moHAyoFqKEKLLsWW4Z0HNm2NWUFA3tAyvJy67FSxmcewMRe
         AsYz9hYGAFfDXCk24NL42XFg7wE7qK9Rpzwb/sxkBRtPylzwX3eOAsvK7VPWFMBtOdoV
         i+GR61veZ5MKR/docPug1ryBAi8lvXMGsKblWhK58EdSzxiBmgrpI5sqZ4ArM1tFSEaQ
         iecWj+q2Q5DHmbysPuje6aM8ygNJerlyVSrpxbNXhokyF6S723iVeN170p8BDc5v8uX9
         P1wNQSi0Vnn1fcG47rX4JupU8HD09ekvJA71AnpTmYEX2+iFjUgLgMTcZVcyBQPmLwet
         kjHA==
X-Gm-Message-State: ACgBeo2PBRgi7H+ouLEtcGCDdMrpiKEEEStB5c/amyZW3O/ZfCGesOUR
	RpxW9vr7oPox0E3kdChrBGc=
X-Google-Smtp-Source: AA6agR485P1k1WGO2X5KEiAkTAS+u9iUbOXwucVHeLUconht5K9JPTkt+NFXwbtYQsQkp6Wx7JbIOg==
X-Received: by 2002:a17:907:c10:b0:731:58aa:7783 with SMTP id ga16-20020a1709070c1000b0073158aa7783mr11187802ejc.19.1661106325105;
        Sun, 21 Aug 2022 11:25:25 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id ft8-20020a170907800800b0073d68d2fc29sm2097482ejc.218.2022.08.21.11.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:25:23 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ira Weiny <ira.weiny@intel.com>,
	Baoquan He <bhe@redhat.com>
Subject: [RESEND PATCH v3] kexec: Replace kmap() with kmap_local_page()
Date: Sun, 21 Aug 2022 20:25:19 +0200
Message-Id: <20220821182519.9483-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220821_112527_680454_7160E639 
X-CRM114-Status: GOOD (  15.63  )
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
TSwgYm9vdGluZyBhIGtlcm5lbCB3aXRoCkhJR0hNRU02NEdCIGVuYWJsZWQuCgpDYzogQW5kcmV3
IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4KU3VnZ2VzdGVkLWJ5OiBJcmEgV2Vp
bnkgPGlyYS53ZWlueUBpbnRlbC5jb20+ClJldmlld2VkLWJ5OiBJcmEgV2VpbnkgPGlyYS53ZWlu
eUBpbnRlbC5jb20+CkFja2VkLWJ5OiBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNvbT4KU2lnbmVk
LW9mZi1ieTogRmFiaW8gTS4gRGUgRnJhbmNlc2NvIDxmbWRlZnJhbmNlc2NvQGdtYWlsLmNvbT4K
LS0tCgpGZXcgZGF5cyBhZ28sIEkndmUgYmVlbiByZXF1ZXN0ZWQgYnkgQW5kcmV3IHRvIHJlc2Vu
ZCB0aGlzIChhbmQgb3RoZXIKcGF0Y2hlcykgYW5kLCB0aGlzIHRpbWUsIHRvIG5vdCBmb3JnZXQg
dG8gQ2MgaGltIDotKQoKdjItPnYzOiBBZGQgbW9yZSBpbmZvcm1hdGlvbiBpbiB0aGUgY29tbWl0
IG1lc3NhZ2UgYXMgcmVxdWVzdGVkIGJ5IEJhb3F1YW4KSGUgYW5kIGZvcndhcmQgdHdvIHRhZ3Ms
IHJlc3BlY3RpdmVseSBmcm9tIElyYSBXZWlueSBhbmQgQmFvcXVhbiBIZSAobWFueQp0aGFua3Mg
dG8gdGhlbSB0d28hKS4KCnYxLT52MjogQSBzZW50ZW5jZSBvZiB0aGUgY29tbWl0IG1lc3NhZ2Ug
Y29udGFpbmVkIGFuIGVycm9yIGR1ZSB0byBhCm1pc3Rha2UgaW4gY29weS1wYXN0aW5nIGZyb20g
YSBwcmV2aW91cyBwYXRjaC4gUmVwbGFjZSAiYWlvLmMiIHdpdGgKImtleGVjX2NvcmUuYyIuCgog
a2VybmVsL2tleGVjX2NvcmUuYyB8IDggKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEva2VybmVsL2tleGVjX2NvcmUu
YyBiL2tlcm5lbC9rZXhlY19jb3JlLmMKaW5kZXggNGQzNGM3ODMzNGNlLi42Zjk4Mjc0NzY1ZDQg
MTAwNjQ0Ci0tLSBhL2tlcm5lbC9rZXhlY19jb3JlLmMKKysrIGIva2VybmVsL2tleGVjX2NvcmUu
YwpAQCAtODE0LDcgKzgxNCw3IEBAIHN0YXRpYyBpbnQga2ltYWdlX2xvYWRfbm9ybWFsX3NlZ21l
bnQoc3RydWN0IGtpbWFnZSAqaW1hZ2UsCiAJCWlmIChyZXN1bHQgPCAwKQogCQkJZ290byBvdXQ7
CiAKLQkJcHRyID0ga21hcChwYWdlKTsKKwkJcHRyID0ga21hcF9sb2NhbF9wYWdlKHBhZ2UpOwog
CQkvKiBTdGFydCB3aXRoIGEgY2xlYXIgcGFnZSAqLwogCQljbGVhcl9wYWdlKHB0cik7CiAJCXB0
ciArPSBtYWRkciAmIH5QQUdFX01BU0s7CkBAIC04MjcsNyArODI3LDcgQEAgc3RhdGljIGludCBr
aW1hZ2VfbG9hZF9ub3JtYWxfc2VnbWVudChzdHJ1Y3Qga2ltYWdlICppbWFnZSwKIAkJCW1lbWNw
eShwdHIsIGtidWYsIHVjaHVuayk7CiAJCWVsc2UKIAkJCXJlc3VsdCA9IGNvcHlfZnJvbV91c2Vy
KHB0ciwgYnVmLCB1Y2h1bmspOwotCQlrdW5tYXAocGFnZSk7CisJCWt1bm1hcF9sb2NhbChwdHIp
OwogCQlpZiAocmVzdWx0KSB7CiAJCQlyZXN1bHQgPSAtRUZBVUxUOwogCQkJZ290byBvdXQ7CkBA
IC04NzgsNyArODc4LDcgQEAgc3RhdGljIGludCBraW1hZ2VfbG9hZF9jcmFzaF9zZWdtZW50KHN0
cnVjdCBraW1hZ2UgKmltYWdlLAogCQkJZ290byBvdXQ7CiAJCX0KIAkJYXJjaF9rZXhlY19wb3N0
X2FsbG9jX3BhZ2VzKHBhZ2VfYWRkcmVzcyhwYWdlKSwgMSwgMCk7Ci0JCXB0ciA9IGttYXAocGFn
ZSk7CisJCXB0ciA9IGttYXBfbG9jYWxfcGFnZShwYWdlKTsKIAkJcHRyICs9IG1hZGRyICYgflBB
R0VfTUFTSzsKIAkJbWNodW5rID0gbWluX3Qoc2l6ZV90LCBtYnl0ZXMsCiAJCQkJUEFHRV9TSVpF
IC0gKG1hZGRyICYgflBBR0VfTUFTSykpOwpAQCAtODk0LDcgKzg5NCw3IEBAIHN0YXRpYyBpbnQg
a2ltYWdlX2xvYWRfY3Jhc2hfc2VnbWVudChzdHJ1Y3Qga2ltYWdlICppbWFnZSwKIAkJZWxzZQog
CQkJcmVzdWx0ID0gY29weV9mcm9tX3VzZXIocHRyLCBidWYsIHVjaHVuayk7CiAJCWtleGVjX2Zs
dXNoX2ljYWNoZV9wYWdlKHBhZ2UpOwotCQlrdW5tYXAocGFnZSk7CisJCWt1bm1hcF9sb2NhbChw
dHIpOwogCQlhcmNoX2tleGVjX3ByZV9mcmVlX3BhZ2VzKHBhZ2VfYWRkcmVzcyhwYWdlKSwgMSk7
CiAJCWlmIChyZXN1bHQpIHsKIAkJCXJlc3VsdCA9IC1FRkFVTFQ7Ci0tIAoyLjM3LjEKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5n
IGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
