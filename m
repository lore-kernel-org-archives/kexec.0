Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD52EB64DA
	for <kexec@archiver.kernel.org>; Wed,  5 Jul 2023 08:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jpciE83ESaa6poOJE8sGhXeygqy91mU+OS6MjhhHjA4=; b=VDzMiTZ1qX6YRY
	Wa/QIXNiFEJWemOPWsE3SCv5bZ4eNLMqXb5WPLIOIhIE/1Qght0y7BM8yDY247eg5q0lj45D+UNTG
	gj+bwF8ifqVYMyiZILPqatVAbSvm7Hqk30MOeFpfezFokIy5fzlO52UQ3mWn7KZbLl9CVqIZE8A4+
	g2kpBgySbB8hQQa9orKUGg6f9ErRHeB4G7m1E6YEksBgj4LWJ3FXhwRB7K04rj4/Sik2oJoqJoldu
	BhJG2cevY6xGEpwYHiNpzSvQlv2wApNCNYYW8XKSMt01n/Sy363/0CYu0ZVhOWnnpAbTT687CdBiN
	aPYlw2K8La1mlfWkyqdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGyMG-00FHsY-1I;
	Wed, 05 Jul 2023 08:59:32 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGyMD-00FHpW-1G
	for kexec@lists.infradead.org;
	Wed, 05 Jul 2023 08:59:30 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1688547563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hf4glG5RrjzsZDHEwCTkoyrZ5ilmAB1pGZBJhpzC2Ts=;
	b=E2tkiAQP8nJBMn1PkgdEZ69sQ2IlnvWWTH85RSq6aBRgUxQ8D7EPMNlv1NPOaOK8tPq9uM
	Vb7PNvXF/RH+Cne8w8ZXUUdEr4mvq/AtNGXWSclItV1Q67rt3N67l9a9h4B5BQc/sCplKI
	Ti4fkDAb9sWazTqTsoA1f8k7TjuY5y24Tb9eDS2Y58xE/nlSnssvI3XxGfw8KbnAlfhXU0
	Oi5daN0zBbBTb45zKy9c/nURvGDq5WQGrkRfKT7YCdVG+0+C5NCFjRimZG4xXw1N71lfaS
	k5gNIpjqhlrwjM0SIdFRtUUKWtR/7E2aaM8p/h2T3gHx8BUvoChj90oihUtkVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1688547563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hf4glG5RrjzsZDHEwCTkoyrZ5ilmAB1pGZBJhpzC2Ts=;
	b=WXuFSKXOCh1bWDYSwOVlOTwwgaxNSLNZrIvGR6iUs0KHjqUewYG+1ALcpaqMWc2qLLu8J1
	r2WKhuAza3mrCBDw==
To: Baokun Li <libaokun1@huawei.com>
Cc: arjan@linux.intel.com, ashok.raj@intel.com, ashok.raj@linux.intel.com,
 ebiederm@xmission.com, linux-kernel@vger.kernel.org,
 mario.limonciello@amd.com, thomas.lendacky@amd.com, tony.luck@intel.com,
 tonyb@cybernetics.com, x86@kernel.org, yangerkun <yangerkun@huawei.com>,
 Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org
Subject: Re: [BUG REPORT] Triggering a panic in an x86 virtual machine does
 not wait
In-Reply-To: <71578392-63ed-02a9-24da-2adf8cce38c7@huawei.com>
References: <20230615193330.608657211@linutronix.de>
 <71578392-63ed-02a9-24da-2adf8cce38c7@huawei.com>
Date: Wed, 05 Jul 2023 10:59:23 +0200
Message-ID: <87ttui91jo.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230705_015929_580223_149605C1 
X-CRM114-Status: GOOD (  14.09  )
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

T24gTW9uLCBKdWwgMDMgMjAyMyBhdCAxMTo0NCwgQmFva3VuIExpIHdyb3RlOgoKPiBXaGVuIEkg
bWFudWFsbHkgdHJpZ2dlciBwYW5pYyBpbiBhIHF1bWUgeDg2IFZNIHdpdGgKPgo+ICDCoMKgwqDC
oMKgwqAgYGVjaG8gYyA+IC9wcm9jL3N5c3JxLXRyaWdnZXJgLAo+Cj4gIMKgSSBmaW5kIHRoYXQg
dGhlIFZNIHdpbGwgcHJvYmFibHkgcmVib290IGRpcmVjdGx5LCBidXQgdGhlIAo+IFBBTklDX1RJ
TUVPVVQgaXMgMC4KPiBUaGlzIHByZXZlbnRzIHVzIGZyb20gZXhwb3J0aW5nIHRoZSB2bWNvcmUg
dmlhIHBhbmljLCBhbmQgZXZlbiBpZiB3ZSBzdWNjZWVkCj4gaW4gcGFuaWMgZXhwb3J0aW5nIHRo
ZSB2bWNvcmUsIHRoZSBwcm9jZXNzZXMgaW4gdGhlIHZtY29yZSBhcmUgbW9zdGx5Cj4gc3RvcF90
aGlzX2NwdSgpLiBCeSBkaWNob3RvbWl6aW5nIHdlIGZvdW5kIHRoZSBwYXRjaCB0aGF0IGludHJv
ZHVjZWQgdGhlCj4gYmVoYXZpb3IgY2hhbmdlCj4KPiAgwqDCoCA0NWUzNGM4YWY1OGYgKCJ4ODYv
c21wOiBQdXQgQ1BVcyBpbnRvIElOSVQgb24gc2h1dGRvd24gaWYgcG9zc2libGUiKSwKCkJhaCwg
SSBtaXNzZWQgdGhhdCB0aGlzIGlzIHVzZWQgYnkgY3Jhc2ggdG9vLiBTbyBpZiB0aGlzIGhhcHBl
bnMgdG8gYmUKaW52b2tlZCBvbiBhbiBBUCwgaS5lLiBub3Qgb24gQ1BVIDAsIHRoZW4gdGhlIElO
SVQgd2lsbCByZXNldCB0aGUKbWFjaGluZS4gRml4IGJlbG93LgoKVGhhbmtzLAoKICAgICAgICB0
Z2x4Ci0tLQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3NtcGJvb3QuYyBiL2FyY2gveDg2
L2tlcm5lbC9zbXBib290LmMKaW5kZXggZWQyZDUxOTYwYTdkLi5lMWFhMmNkNzczNGIgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9zbXBib290LmMKKysrIGIvYXJjaC94ODYva2VybmVsL3Nt
cGJvb3QuYwpAQCAtMTM0OCw2ICsxMzQ4LDE0IEBAIGJvb2wgc21wX3Bhcmtfb3RoZXJfY3B1c19p
bl9pbml0KHZvaWQpCiAJaWYgKGFwaWMtPndha2V1cF9zZWNvbmRhcnlfY3B1XzY0IHx8IGFwaWMt
Pndha2V1cF9zZWNvbmRhcnlfY3B1KQogCQlyZXR1cm4gZmFsc2U7CiAKKwkvKgorCSAqIElmIHRo
aXMgaXMgYSBjcmFzaCBzdG9wIHdoaWNoIGRvZXMgbm90IGV4ZWN1dGUgb24gdGhlIGJvb3QgQ1BV
LAorCSAqIHRoZW4gdGhpcyBjYW5ub3QgdXNlIHRoZSBJTklUIG1lY2hhbmlzbSBiZWNhdXNlIElO
SVQgdG8gdGhlIGJvb3QKKwkgKiBDUFUgd2lsbCByZXNldCB0aGUgbWFjaGluZS4KKwkgKi8KKwlp
ZiAodGhpc19jcHUpCisJCXJldHVybiBmYWxzZTsKKwogCWZvcl9lYWNoX3ByZXNlbnRfY3B1KGNw
dSkgewogCQlpZiAoY3B1ID09IHRoaXNfY3B1KQogCQkJY29udGludWU7CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4
ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2tleGVjCg==
