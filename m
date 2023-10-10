Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3FDCD80C1
	for <kexec@archiver.kernel.org>; Tue, 10 Oct 2023 13:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=rbOs1N0mT3hXMuNlTHFTLT5gA59uX0Oa6V79DhRG7zw=; b=sgkuim+MwE7zvA
	OVJef5dHtC9G8Dt8ZNSz+2MtMdf8SjIz/CuLSMzVzeXrexrf8eXi+JwClVNSD8wjlr5LdJ1Pja5I2
	XMq62gso58S8oTZ1/wkO0nLGk57F03tzZn7nAJeBanP4YJDayOhBKflR2azCOQ+YtH2TXHn67DbT/
	38bY761pFcwO7yzAC+UIoSN7gkdRNUvL7dWIeDPpdqjjoYcy+d44TEPEPvn9DmcZJrfyD5CEy4ozM
	PfEYlr1EWNTZ+eg30dKkeuVsVPCfEK3Si4IgT3xb1kkkdBPDQOW8x+Kn/1D+r42CeYKGZRJe+RN/s
	kk9xsnYdPtaN3bJ5LqoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqCMf-00DP3F-2p;
	Tue, 10 Oct 2023 13:01:33 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqCMc-00DP1e-2t
	for kexec@lists.infradead.org;
	Tue, 10 Oct 2023 13:01:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DF41261648;
	Tue, 10 Oct 2023 13:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA152C433C7;
	Tue, 10 Oct 2023 13:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696942889;
	bh=VZLGTC9j7qJsgrn/w4xrXdl31rjXSnGevoSbJE697Qw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZkQPxhyYzY+DuPunaUR+T9STrPsWI2/T+3s2xTcRMel1/Ho/oQ6UKE3E+xFNaux3C
	 K985C6u4wr+BuqXiFlUvZUkgPWINYLIUapMiiz4oSdZLXuOrdPpzY5FkotDiU46u+L
	 GAEyFDKnzqzFGYtUmv7/otIvvo+aXeW4cPUMgELKIoxbYSg447AYzbKi7jRYIRUxag
	 dJckOO8zbWFXuPePtPi0v5Y79ssiHb34OmPKJKvxsWhFtDBvbhnjZJhREKpYo+z7zS
	 yHl3Z0xOwVDcW/KMxpud8nzEtbSiOXH2tKdMzJgMkMgcW/lAnZm7TlVl9SDkzdyL6m
	 Dm7egOo9Ro+yA==
Date: Tue, 10 Oct 2023 15:01:26 +0200
From: Simon Horman <horms@kernel.org>
To: Ming Wang <wangming01@loongson.cn>
Cc: kexec@lists.infradead.org
Subject: Re: [kexec-tools] Archive file is missed iomem.h file under
 loongarch architecture.
Message-ID: <ZSVLJgZ31ZhijOYt@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <41eb6420-915a-4746-8fe9-8778a46d9479@loongson.cn>
 <561b3717-0ce4-42ae-8846-6c0154a91557@loongson.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_060130_976606_95B63D65 
X-CRM114-Status: GOOD (  16.01  )
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

T24gTW9uLCBPY3QgMDksIDIwMjMgYXQgMDU6NDc6NDNQTSArMDgwMCwgTWluZyBXYW5nIHdyb3Rl
Ogo+IEhpLMKgIG1haW50YWluZXJzLAo+IAo+IAo+IEkgZ2V0IHRoZSBrZXhlYy10b29scyAyLjAu
MjcgZnJvbSBodHRwOi8va2VybmVsLm9yZy9wdWIvbGludXgvdXRpbHMva2VybmVsL2tleGVjL2tl
eGVjLXRvb2xzLTIuMC4yNy50YXIuZ3oswqAKPiAKPiBCdXQgSSBub3RpY2VkIHRoYXQgdGhlIGtl
eGVjLXRvb2xzLTIuMC4yNy9rZXhlYy9hcmNoL2xvb25nYXJjaC9pb21lbS5oIGZpbGUgd2FzIG1p
c3NpbmcgZnJvbQo+IAo+IHRoaXMgYXJjaGl2ZS4KPiAKPiAKPiBUaGlzIGNhdXNlcyBidWlsZCBl
cnJvcnMgaW4gbWFueSBkaXN0cmlidXRpb25zLCBsaWtlIGRlYmlhbi7CoCBUaGUgZXJyb3IgbWVz
c2FnZSBpcyBhcyBmb2xsb3dzLAo+IAo+IG1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTIzOiBrZXhl
Yy9hcmNoL2xvb25nYXJjaC9jcmFzaGR1bXAtbG9vbmdhcmNoLm9dIEVycm9yIDEKPiBrZXhlYy9h
cmNoL2xvb25nYXJjaC9rZXhlYy1sb29uZ2FyY2guYzoyNzoxMDogZmF0YWwgZXJyb3I6IGlvbWVt
Lmg6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKPiAgICAyNyB8ICNpbmNsdWRlICJpb21lbS5o
Igo+IAo+IFNlZSBhbHNvOiBodHRwczovL2J1aWxkZC5kZWJpYW4ub3JnL3N0YXR1cy9wYWNrYWdl
LnBocD9wPWtleGVjLXRvb2xzJnN1aXRlPXNpZAo+IAo+IAo+IENhbiB0aGlzIGFyY2hpdmUgYmUg
cmVwYWlyZWQgYW5kIHVwZGF0ZWQ/Cj4gCj4gCj4gVGhhbmtzLCBNaW5nCgpIaSwKCkkgbmVlZCB0
byB0aGluayBhYm91dCBob3cgdG8gZGVhbCB3aXRoIHRoaXMgZnJvbSBhIHJlbGVhc2UgUG9WLgpC
dXQgY2FuIHlvdSBjaGVjayBpZiB0aGUgcGF0Y2ggYmVsb3cgcmVzb2x2ZXMgeW91ciBwcm9ibGVt
PwoKZGlmZiAtLWdpdCBhL2tleGVjL2FyY2gvbG9vbmdhcmNoL01ha2VmaWxlIGIva2V4ZWMvYXJj
aC9sb29uZ2FyY2gvTWFrZWZpbGUKaW5kZXggY2VlN2U1NjlhMmEyLi5mOTFkMGJhZjA0OWEgMTAw
NjQ0Ci0tLSBhL2tleGVjL2FyY2gvbG9vbmdhcmNoL01ha2VmaWxlCisrKyBiL2tleGVjL2FyY2gv
bG9vbmdhcmNoL01ha2VmaWxlCkBAIC0xOSw1ICsxOSw2IEBAIGxvb25nYXJjaF9WSVJUX1RPX1BI
WVMgPQogZGlzdCArPSBrZXhlYy9hcmNoL2xvb25nYXJjaC9NYWtlZmlsZSAkKGxvb25nYXJjaF9L
RVhFQ19TUkNTKQkJCVwKIAlrZXhlYy9hcmNoL2xvb25nYXJjaC9rZXhlYy1sb29uZ2FyY2guaAkJ
CQkJXAogCWtleGVjL2FyY2gvbG9vbmdhcmNoL2ltYWdlLWhlYWRlci5oCQkJCQlcCisJa2V4ZWMv
YXJjaC9sb29uZ2FyY2gvaW9tZW0uaAkJCQkJCVwKIAlrZXhlYy9hcmNoL2xvb25nYXJjaC9jcmFz
aGR1bXAtbG9vbmdhcmNoLmgJCQkJXAogCWtleGVjL2FyY2gvbG9vbmdhcmNoL2luY2x1ZGUvYXJj
aC9vcHRpb25zLmgKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
