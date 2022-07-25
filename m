Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D5CC433EF
	for <kexec@archiver.kernel.org>; Mon, 25 Jul 2022 08:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UL7zhZvOCGggzc8tQUd5JpFG76rJwpCQ9cz5dQ6sK4g=; b=uXCRXc9MrW1MFR
	1wmZsIBl63F3to0A3BSsGC3LuavqriZdvuNnHxJ5PxhdhVuNY7FxBr86SoC9Ja3tdxnwQDV2SsKoq
	qPkvI48wTQTsnRQciUSixsrxqu7NzAUM/hOtrNVNMY3LPxefzM/SLVU4b8+Nwq9mQRagQmdfpEekn
	w2vHquPafv7EaACExyQPXixOcFpyJV+8Sw9RWCfD7tKfPpzCCVqzNcWVu65Aa2XhIqPPsydx5u8+m
	0QjAZCCX92uf3zmETjAmYhDnyWdvKas4YHa8kmD29QohJW0Hg8HAlgTPfHbJLJH5Qapeozo+ecamY
	K2SSEgnr+M21GmvzceoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFtdt-0073TB-JV; Mon, 25 Jul 2022 08:40:45 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFtdq-0073Li-Ee
	for kexec@lists.infradead.org; Mon, 25 Jul 2022 08:40:43 +0000
Received: by mail-pj1-x1030.google.com with SMTP id ru18so3864727pjb.0
        for <kexec@lists.infradead.org>; Mon, 25 Jul 2022 01:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JRx05kPh3Ii0mpG7hTQJSpxflPSjOu6HTrFUf3L55sY=;
        b=b/gJd3iUl8OERmp+WyI5dC15jE1/7lh4kN0ML2m8TDjjg5+A09Zs5c/jcux/umjCNB
         E9b2j3m11+23MfAV2gUuOIwI4Tafw/ldONvsGh4u2J8Vpdcvltmgs6t+k5KXpZzo0VZ9
         Y1b6DFFSZs/j7GucnJod6cEQ+zQ5+1cbLlm3Gk94Vu/bqLd4ImYU+t3/WYn7oY+2dhKr
         B5ZHR1BDmNOKRNaElyjk4HYwq9sdhws0NKdtm4Z0V+ls3QKwWfZFpeMSsVggUD+tsR9v
         ydOTI29C1Ubsavi5EufYYWVC6mJ2f1KC1HCQCHSHAQ8jJXNmCUzdmst8S5xXiUUZic+Q
         lmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JRx05kPh3Ii0mpG7hTQJSpxflPSjOu6HTrFUf3L55sY=;
        b=XeKGD9UeKuv/mxxddP9FRF9TKqY9MR8ny7Nn85+RpumBLDkCwEgIcRhq08XdeD5ZW0
         BXtz9ebEgQWnhMySbsicASknlZuQFzNtLLZQpG3l5KRBZzS2UwK63V7UfhLP94Qizoby
         dNZari1YjVwuKay5dkjw2POEAnzT33RVnc1A4lO1kJCvGJZ9xAgNHgVpNg0A+pNHY369
         +71NT9NO5T+53TtZZ9q0aCc9g86UE2pBqP3JSgYnpf85akNdfzk9hq/0xbObF1KYdDSX
         WQiMgE0P945WmiOoCxsGAXxEfevutxXVKHVroQT8JEVh9sR+okqmvrohYNuvaVPk/dPo
         SOjQ==
X-Gm-Message-State: AJIora9HG3qb7R+dOihr2LhIXLFGwy/ShAZOT3R0X2cvYO6CAncgwsUb
	KM/nnGOZRPiYCVPViCDpCcrtBg==
X-Google-Smtp-Source: AGRyM1vlctvOgVdFh/Fgb7CwxXla4DK2/n69hV3Zju/JQYHyXfZs1xGC4mXFAdMg4Fh/tEID47FsXQ==
X-Received: by 2002:a17:902:c401:b0:16d:8109:4f18 with SMTP id k1-20020a170902c40100b0016d81094f18mr2037084plk.32.1658738439453;
        Mon, 25 Jul 2022 01:40:39 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 128-20020a621886000000b0052abc2438f1sm8893479pfy.55.2022.07.25.01.40.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2022 01:40:39 -0700 (PDT)
From: Albert Huang <huangjie.albert@bytedance.com>
To: 
Cc: "huangjie.albert" <huangjie.albert@bytedance.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Michal Marek <michal.lkml@markovi.net>,
	Nick Desaulniers <ndesaulniers@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH 4/4] x86: boot: avoid memory copy if kernel is uncompressed
Date: Mon, 25 Jul 2022 16:38:56 +0800
Message-Id: <20220725083904.56552-5-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220725083904.56552-1-huangjie.albert@bytedance.com>
References: <20220725083904.56552-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_014042_525605_141A97E6 
X-CRM114-Status: GOOD (  18.92  )
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

RnJvbTogImh1YW5namllLmFsYmVydCIgPGh1YW5namllLmFsYmVydEBieXRlZGFuY2UuY29tPgoK
MeOAgWlmIGtlcm5lbCBpcyB1bmNvbXByZXNzZWQuIHdlIGRvIG5vdCBuZWVkIHRvIHJlbG9jYXRl
Cmtlcm5lbCBpbWFnZSBmb3IgZGVjb21wcmVzc2lvbgoKMuOAgWlmIGthc2xyIGlzIGRpc2FibGVk
LCB3ZSBkbyBub3QgbmVlZCB0byBkbyBhIG1lbW9yeSBjb3B5CmJlZm9yZSBwcmFzZV9lbGYuCgpU
d28gbWVtb3J5IGNvcGllcyBjYW4gYmUgc2tpcHBlZCB3aXRoIHRoaXMgcGF0Y2guIHRoaXMgY2Fu
CnNhdmUgYWJvYXQgMjBtcyBkdXJpbmcgYm9vdGluZy4KClNpZ25lZC1vZmYtYnk6IGh1YW5namll
LmFsYmVydCA8aHVhbmdqaWUuYWxiZXJ0QGJ5dGVkYW5jZS5jb20+Ci0tLQogYXJjaC94ODYvYm9v
dC9jb21wcmVzc2VkL2hlYWRfNjQuUyB8ICA4ICsrKysrKy0tCiBhcmNoL3g4Ni9ib290L2NvbXBy
ZXNzZWQvbWlzYy5jICAgIHwgMjIgKysrKysrKysrKysrKysrKystLS0tLQogMiBmaWxlcyBjaGFu
Z2VkLCAyMyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2Jvb3QvY29tcHJlc3NlZC9oZWFkXzY0LlMgYi9hcmNoL3g4Ni9ib290L2NvbXByZXNzZWQv
aGVhZF82NC5TCmluZGV4IGQzM2YwNjA5MDBkMi4uOWU3NzcwYzcwNDdiIDEwMDY0NAotLS0gYS9h
cmNoL3g4Ni9ib290L2NvbXByZXNzZWQvaGVhZF82NC5TCisrKyBiL2FyY2gveDg2L2Jvb3QvY29t
cHJlc3NlZC9oZWFkXzY0LlMKQEAgLTM5OCwxMCArMzk4LDEzIEBAIFNZTV9DT0RFX1NUQVJUKHN0
YXJ0dXBfNjQpCiAxOgogCiAJLyogVGFyZ2V0IGFkZHJlc3MgdG8gcmVsb2NhdGUgdG8gZm9yIGRl
Y29tcHJlc3Npb24gKi8KKyNpZmRlZiBDT05GSUdfS0VSTkVMX1VOQ09NUFJFU1NFRAorCW1vdnEg
JXJicCwgJXJieAorI2Vsc2UKIAltb3ZsCUJQX2luaXRfc2l6ZSglcnNpKSwgJWVieAogCXN1YmwJ
JCBydmEoX2VuZCksICVlYngKIAlhZGRxCSVyYnAsICVyYngKLQorI2VuZGlmCiAJLyogU2V0IHVw
IHRoZSBzdGFjayAqLwogCWxlYXEJcnZhKGJvb3Rfc3RhY2tfZW5kKSglcmJ4KSwgJXJzcAogCkBA
IC01MjIsNiArNTI1LDcgQEAgdHJhbXBvbGluZV9yZXR1cm46CiAgKiBDb3B5IHRoZSBjb21wcmVz
c2VkIGtlcm5lbCB0byB0aGUgZW5kIG9mIG91ciBidWZmZXIKICAqIHdoZXJlIGRlY29tcHJlc3Np
b24gaW4gcGxhY2UgYmVjb21lcyBzYWZlLgogICovCisjaWZuZGVmIENPTkZJR19LRVJORUxfVU5D
T01QUkVTU0VECiAJcHVzaHEJJXJzaQogCWxlYXEJKF9ic3MtOCkoJXJpcCksICVyc2kKIAlsZWFx
CXJ2YShfYnNzLTgpKCVyYngpLCAlcmRpCkBAIC01MzEsNyArNTM1LDcgQEAgdHJhbXBvbGluZV9y
ZXR1cm46CiAJcmVwCW1vdnNxCiAJY2xkCiAJcG9wcQklcnNpCi0KKyNlbmRpZgogCS8qCiAJICog
VGhlIEdEVCBtYXkgZ2V0IG92ZXJ3cml0dGVuIGVpdGhlciBkdXJpbmcgdGhlIGNvcHkgd2UganVz
dCBkaWQgb3IKIAkgKiBkdXJpbmcgZXh0cmFjdF9rZXJuZWwgYmVsb3cuIFRvIGF2b2lkIGFueSBp
c3N1ZXMsIHJlcG9pbnQgdGhlIEdEVFIKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2Jvb3QvY29tcHJl
c3NlZC9taXNjLmMgYi9hcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvbWlzYy5jCmluZGV4IGMyM2Mw
ZjUyNWQ5My4uZDg0NDU1NjJkNGU5IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9ib290L2NvbXByZXNz
ZWQvbWlzYy5jCisrKyBiL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9taXNjLmMKQEAgLTI5MCw3
ICsyOTAsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgaGFuZGxlX3JlbG9jYXRpb25zKHZvaWQgKm91
dHB1dCwgdW5zaWduZWQgbG9uZyBvdXRwdXRfbGVuLAogeyB9CiAjZW5kaWYKIAotc3RhdGljIHZv
aWQgcGFyc2VfZWxmKHZvaWQgKm91dHB1dCkKK3N0YXRpYyB2b2lkIHBhcnNlX2VsZih2b2lkICpv
dXRwdXQsIHZvaWQgKmlucHV0KQogewogI2lmZGVmIENPTkZJR19YODZfNjQKIAlFbGY2NF9FaGRy
IGVoZHI7CkBAIC0zMDIsNyArMzAyLDcgQEAgc3RhdGljIHZvaWQgcGFyc2VfZWxmKHZvaWQgKm91
dHB1dCkKIAl2b2lkICpkZXN0OwogCWludCBpOwogCi0JbWVtY3B5KCZlaGRyLCBvdXRwdXQsIHNp
emVvZihlaGRyKSk7CisJbWVtY3B5KCZlaGRyLCBpbnB1dCwgc2l6ZW9mKGVoZHIpKTsKIAlpZiAo
ZWhkci5lX2lkZW50W0VJX01BRzBdICE9IEVMRk1BRzAgfHwKIAkgICBlaGRyLmVfaWRlbnRbRUlf
TUFHMV0gIT0gRUxGTUFHMSB8fAogCSAgIGVoZHIuZV9pZGVudFtFSV9NQUcyXSAhPSBFTEZNQUcy
IHx8CkBAIC0zMTcsNyArMzE3LDcgQEAgc3RhdGljIHZvaWQgcGFyc2VfZWxmKHZvaWQgKm91dHB1
dCkKIAlpZiAoIXBoZHJzKQogCQllcnJvcigiRmFpbGVkIHRvIGFsbG9jYXRlIHNwYWNlIGZvciBw
aGRycyIpOwogCi0JbWVtY3B5KHBoZHJzLCBvdXRwdXQgKyBlaGRyLmVfcGhvZmYsIHNpemVvZigq
cGhkcnMpICogZWhkci5lX3BobnVtKTsKKwltZW1jcHkocGhkcnMsIGlucHV0ICsgZWhkci5lX3Bo
b2ZmLCBzaXplb2YoKnBoZHJzKSAqIGVoZHIuZV9waG51bSk7CiAKIAlmb3IgKGkgPSAwOyBpIDwg
ZWhkci5lX3BobnVtOyBpKyspIHsKIAkJcGhkciA9ICZwaGRyc1tpXTsKQEAgLTMzNCw3ICszMzQs
NyBAQCBzdGF0aWMgdm9pZCBwYXJzZV9lbGYodm9pZCAqb3V0cHV0KQogI2Vsc2UKIAkJCWRlc3Qg
PSAodm9pZCAqKShwaGRyLT5wX3BhZGRyKTsKICNlbmRpZgotCQkJbWVtbW92ZShkZXN0LCBvdXRw
dXQgKyBwaGRyLT5wX29mZnNldCwgcGhkci0+cF9maWxlc3opOworCQkJbWVtbW92ZShkZXN0LCBp
bnB1dCArIHBoZHItPnBfb2Zmc2V0LCBwaGRyLT5wX2ZpbGVzeik7CiAJCQlicmVhazsKIAkJZGVm
YXVsdDogLyogSWdub3JlIG90aGVyIFBUXyogKi8gYnJlYWs7CiAJCX0KQEAgLTQ2Nyw5ICs0Njcs
MjEgQEAgYXNtbGlua2FnZSBfX3Zpc2libGUgdm9pZCAqZXh0cmFjdF9rZXJuZWwodm9pZCAqcm1v
ZGUsIG1lbXB0ciBoZWFwLAogI2VuZGlmCiAKIAlkZWJ1Z19wdXRzdHIoIlxuRGVjb21wcmVzc2lu
ZyBMaW51eC4uLiAiKTsKKworI2lmZGVmIENPTkZJR19LRVJORUxfVU5DT01QUkVTU0VECisJaWYg
KGNtZGxpbmVfZmluZF9vcHRpb25fYm9vbCgibm9rYXNsciIpKSB7CisJCXBhcnNlX2VsZihvdXRw
dXQsIGlucHV0X2RhdGEpOworCX0gZWxzZSB7CisJCV9fZGVjb21wcmVzcyhpbnB1dF9kYXRhLCBp
bnB1dF9sZW4sIE5VTEwsIE5VTEwsIG91dHB1dCwgb3V0cHV0X2xlbiwKKwkJCQlOVUxMLCBlcnJv
cik7CisJCXBhcnNlX2VsZihvdXRwdXQsIG91dHB1dCk7CisJfQorI2Vsc2UKIAlfX2RlY29tcHJl
c3MoaW5wdXRfZGF0YSwgaW5wdXRfbGVuLCBOVUxMLCBOVUxMLCBvdXRwdXQsIG91dHB1dF9sZW4s
CiAJCQlOVUxMLCBlcnJvcik7Ci0JcGFyc2VfZWxmKG91dHB1dCk7CisJcGFyc2VfZWxmKG91dHB1
dCwgb3V0cHV0KTsKKyNlbmRpZgorCiAJaGFuZGxlX3JlbG9jYXRpb25zKG91dHB1dCwgb3V0cHV0
X2xlbiwgdmlydF9hZGRyKTsKIAlkZWJ1Z19wdXRzdHIoImRvbmUuXG5Cb290aW5nIHRoZSBrZXJu
ZWwuXG4iKTsKIAotLSAKMi4zMS4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
