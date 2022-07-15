Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BCDC433EF
	for <kexec@archiver.kernel.org>; Fri, 15 Jul 2022 09:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m61n4xYXliqv5Iv297ymL03jvsIQjt0cuLGDMLh1O98=; b=a/GsGf1VjkA5uM
	XQHATX8JTmUaTEGGjdgQ8F5eomvOcg01os5QU5fC7Z4HqHxKzPRGFqRvXh0VyU0a5c0r88HCTK8ZT
	q9PzKnKwpGcVGd6SzWGuIPcdcGGKfYPgpJG14V9YwNVJffUgsTFcfN+lycuvD2E7QzEsiQnT099gV
	f3QErAudNyQQ8Iou+WF5CMSvKMUZkfhhHCR6bZMXy7vBckRD29gTc58EB+5ePBABiRqkfj9cWb3YM
	Sh8T0AB0NZqUh9XC/pYN+XAkkEa+gflvur1y0nBlwyQK258EonD5krSmIVeGszJDJr6Ue067aIVZ6
	WgCZGiSdJa69dy7NGdvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCHbf-0067nL-9B; Fri, 15 Jul 2022 09:27:31 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCHbd-0067lf-5D
	for kexec@lists.infradead.org; Fri, 15 Jul 2022 09:27:30 +0000
Received: from momiji.horms.nl (2a02-a46e-7b6b-703-d63d-7eff-fe99-ac9d.fixed6.kpn.net [IPv6:2a02:a46e:7b6b:703:d63d:7eff:fe99:ac9d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id 48A8920088;
	Fri, 15 Jul 2022 09:26:54 +0000 (UTC)
Received: by momiji.horms.nl (Postfix, from userid 7100)
	id E69649401C4; Fri, 15 Jul 2022 11:26:53 +0200 (CEST)
Date: Fri, 15 Jul 2022 11:26:53 +0200
From: Simon Horman <horms@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH kexec-tools] i386: pass rng seed via setup_data
Message-ID: <YtEy3fuky4llAJqg@vergenet.net>
References: <20220711154110.156015-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220711154110.156015-1-Jason@zx2c4.com>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.6 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220715_022729_386206_5CEB77A4 
X-CRM114-Status: UNSURE (   9.35  )
X-CRM114-Notice: Please train this message.
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

T24gTW9uLCBKdWwgMTEsIDIwMjIgYXQgMDU6NDE6MTBQTSArMDIwMCwgSmFzb24gQS4gRG9uZW5m
ZWxkIHdyb3RlOgo+IExpbnV4IOKJpTUuMjAgZXhwZWN0cyBhIFJORyBzZWVkIHZpYSBzZXR1cF9k
YXRhIGFzIG9mIHRoZSB1cHN0cmVhbSBjb21taXQKPiBpbiB0aGUgbGluayBiZWxvdy4gVGhhdCBj
b21taXQgYWRqdXN0cyBrZXhlY19maWxlX2xvYWQgdG8gcGFzcwo+IFNFVFVQX1JOR19TRUVELiBr
ZXhlYy10b29scyBzaG91bGQgZm9sbG93IHN1aXRlLCBzbyBhZGQgbW9yZSBvciBsZXNzIHRoZQo+
IHNhbWUgY29kZSBoZXJlLgo+IAo+IExpbms6IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvdGlwL3Rp
cC9jLzY4YjhlOTcxM2M4Cj4gU2lnbmVkLW9mZi1ieTogSmFzb24gQS4gRG9uZW5mZWxkIDxKYXNv
bkB6eDJjNC5jb20+CgpUaGFua3MsIGFwcGxpZWQuCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCg==
