Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01FFE95A67
	for <kexec@archiver.kernel.org>; Sun,  8 Oct 2023 01:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1L/kzPShO3Wq4yBj4H0pdhqPiTLyKlN7NCYpMXZDUI4=; b=pP7OeO3HxxJKqF
	L3DiEHofCrq2rh7nYfD5110evOMpsqOnk/oTKqycUc9kxgfkjtDf+UWwT894dR4Y+PHrKBK7qsAMT
	nwy20UFXSRRjj9bjtdSIGGoOYEUuHJwXezaYPsH3wSYwVHOfq8YxnnFK/NGE/lMkw/hRQqK6IGVuP
	W7WryRCjAIIBL1q8Undi3mW0bGbTdsqsPi3cTD/taPpWj45ewuGh1cJcctUruzD2yt7k/jQUMOUNP
	xF0dQLZc4idHCUZv90EqDO8A51sPxxzBL/mWLh14dLmta2JuEqyekYPEhQJZa2q30X/ILJV8mnlYC
	p0wjsYZhGgmk6hvIO8gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qpIdO-0089Am-1m;
	Sun, 08 Oct 2023 01:31:06 +0000
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qpIdK-0089A0-14
	for kexec@lists.infradead.org;
	Sun, 08 Oct 2023 01:31:03 +0000
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c131ddfeb8so38713161fa.3
        for <kexec@lists.infradead.org>; Sat, 07 Oct 2023 18:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1696728653; x=1697333453; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzfF/gGeCBC9V3v8liPcwyRygfYzpFCTXg7Z0Zkg6kM=;
        b=ULD77IkYkTspwrKa/cO+V5xmRVxH+lJc6XQfgEnEBYLeokqAs66OPIF4OGQVMeADGb
         hdCuFgz4zXtiv178CUvddQxX9+MInGPUYWTlOk3n/b+FttUeOXePnSTuOVQc9Tzrc+FE
         jrGyGPXk06fB4ukQfMgM8N6TZMrDMZ2YVGkkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696728653; x=1697333453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzfF/gGeCBC9V3v8liPcwyRygfYzpFCTXg7Z0Zkg6kM=;
        b=SxMjQyaqWsGQ0P8kF9lco+nHiJIPFwF486c+lC4nHjP4VkgNSNOHfcVu8wlCO18QPx
         rOpN6KsokWqdhoLTLVzPe8xOouMkQie3JdZcEPqIaHMVEMvMGxpjAFSE6HgQriIteF+I
         mxBLFAaB3Dv0k+QN23rhaZGj9DLTpRep2iOxrKG6kJGKKTet9NZT7zg86Q+RQhaP/nzH
         r62uB2BaHyRsHzfj4Gs3e3SZ/rdbtNYDRIAVxKrvhG25hQXtBzGjZzQ9WiAfYn2Etarl
         uQTXZ81IY6deWOW1vah6TWtxW7t+Ucc1k+MttGIar1MMkAWHtXfUqrNzKWWEFAzK8drm
         UScw==
X-Gm-Message-State: AOJu0YzG7de8CHGmJAAxgMVlZ8sO3DBnU636ASO5pv0OrO5+YqBSI+cI
	GKlObjDLmzO/H/3knUhKhawW+OjxUPwPbBe5uFBStQ==
X-Google-Smtp-Source: AGHT+IFN1xqQRQ+HT0bT9ifD2rfgW1rqc5g7tXGLjWLVl7dr7TJe7bThOu/yY/XNweHn8ACbixlwUe8dW5oUD4PtdTs=
X-Received: by 2002:a2e:9001:0:b0:2bf:aba1:d951 with SMTP id
 h1-20020a2e9001000000b002bfaba1d951mr10322222ljg.10.1696728653255; Sat, 07
 Oct 2023 18:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230929021213.2364883-1-joel@joelfernandes.org>
 <87bkdl55qm.fsf@email.froward.int.ebiederm.org> <CAEXW_YQ=HGok600ARtCKBNDs1OHSc=UM4hWmBdQ=sXZvif0Z5g@mail.gmail.com>
In-Reply-To: <CAEXW_YQ=HGok600ARtCKBNDs1OHSc=UM4hWmBdQ=sXZvif0Z5g@mail.gmail.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Sat, 7 Oct 2023 21:30:42 -0400
Message-ID: <CAEXW_YQ3YZExYb6FLg3fvWr9K+FGgNQx7xk3p-PngLG6rt8Ntw@mail.gmail.com>
Subject: Re: [PATCH] kexec: Fix reboot race during device_shutdown()
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Ricardo Ribalda <ribalda@google.com>, Ross Zwisler <zwisler@google.com>, Rob Clark <robdclark@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231007_183102_372057_9B9C55B5 
X-CRM114-Status: GOOD (  15.88  )
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

T24gTW9uLCBPY3QgMiwgMjAyMyBhdCAyOjE44oCvUE0gSm9lbCBGZXJuYW5kZXMgPGpvZWxAam9l
bGZlcm5hbmRlcy5vcmc+IHdyb3RlOgpbLi5dCj4gPiA+IFN1Y2ggZnJlZXppbmcgaXMgYWxyZWFk
eSBiZWluZyBkb25lIGlmIGtlcm5lbCBzdXBwb3J0cyBLRVhFQ19KVU1QIGFuZAo+ID4gPiBrZXhl
Y19pbWFnZS0+cHJlc2VydmVfY29udGV4dCBpcyB0cnVlLiBIb3dldmVyLCBkb2luZyBpdCBpZiBl
aXRoZXIgb2YgdGhlc2UgYXJlCj4gPiA+IG5vdCB0cnVlIHByZXZlbnRzIGNyYXNoZXMvcmFjZXMu
Cj4gPgo+ID4gVGhlIEtFWEVDX0pVTVAgY2FzZSBpcyBzb21ldGhpbmcgZWxzZSBlbnRpcmVseS4g
IEl0IGlzIHN1cHBvc2VkIHRvIHdvcmsKPiA+IGxpa2Ugc3VzcGVuZCB0byBSQU0uICBNYXliZSBy
ZWJvb3Qgc2hvdWxkIGFzIHdlbGwsIGJ1dCBJIGFtCj4gPiB1bmNvbWZvcnRhYmxlIG1ha2luZyBh
IGdlbmVyaWMgZGV2aWNlIGZpeCBrZXhlYyBzcGVjaWZpYy4KPgo+IEkgc2VlIHlvdXIgcG9pbnQg
b2Ygdmlldy4gSSB0aGluayByZWd1bGFyIHJlYm9vdCBzaG91bGQgYWxzbyBiZSBmaXhlZAo+IHRv
IGF2b2lkIHNpbWlsYXIgY3Jhc2ggcG9zc2liaWxpdGllcy4gSSBhbSBoYXBweSB0byBtYWtlIGEg
Y2hhbmdlIGZvcgo+IHRoYXQgc2ltaWxhciB0byB0aGlzIHBhdGNoIGlmIHdlIHdhbnQgdG8gcHJv
Y2VlZCB0aGF0IHdheS4KPgo+IFRob3VnaHRzPwoKSnVzdCBjaGVja2luZyBob3cgd2Ugd2FudCB0
byBwcm9jZWVkLCBpcyB0aGUgY29uc2Vuc3VzIHRoYXQgd2Ugc2hvdWxkCnByZXZlbnQga2VybmVs
IGNyYXNoZXMgd2l0aG91dCByZWx5aW5nIG9uIHVzZXJzcGFjZSBzdG9wcGluZyBhbGwKcHJvY2Vz
c2VzPyBTaG91bGQgd2UgZml4IHJlZ3VsYXIgcmVib290IHN5c2NhbGwgYXMgd2VsbCBhbmQgbm90
IGp1c3QKa2V4ZWMgcmVib290PwoKdGhhbmtzLAoKIC0gSm9lbAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9rZXhlYwo=
