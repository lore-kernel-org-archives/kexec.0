Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C6EC2BD09
	for <kexec@archiver.kernel.org>; Mon, 24 Jun 2024 08:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tX79Mbdw6LXAb+6zvDf1xCtDpLU5DgJs2sZNY4MFGHQ=; b=SDFzewXSFPt0dB
	r1Q5tQk9zJMuTBosGVgTQim4vH8qNuOv74PrYUdkpTSgOkA1IIqLbujAT/XLzvXfzGqZw/aDlS3y2
	K4WUNr2xGs/4gca8O6qO3kWl/phMkl79OcoBmnpRxPPxjCgqRAfLJQISHoN3+TJd+8cW2mKGrAStS
	dK7S0AsusvriMZ8L/h+N/gRY/Eu+FJH9tl97ilfUCRKp8a5W5zQ6lnh5UKW3YLXhCQvR2Nsqdb22g
	xTkm+WKYVymYpwQ89XtGkASt6o4hIigVetuYn3tDmkkUXPvQFMQvd2tJSZIeF8CHXptV6zIQI2bi7
	1aderdgP1138vACST1JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLerV-0000000FzQQ-2g6I;
	Mon, 24 Jun 2024 08:15:41 +0000
Received: from mail.envisioncraftsman.com ([162.19.67.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLerR-0000000FzNk-2nqT
	for kexec@lists.infradead.org;
	Mon, 24 Jun 2024 08:15:40 +0000
Received: by mail.envisioncraftsman.com (Postfix, from userid 1002)
	id 90C682021C; Mon, 24 Jun 2024 10:15:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=envisioncraftsman.com; s=mail; t=1719216932;
	bh=uGTmdNfeKWYppKfROrYtp0X+RK7/pRJQsBUrarqToyk=;
	h=Date:From:To:Subject:From;
	b=R6CArPetWSpQY1l/ZHtFjZJMjeXi71nbfShDXaK4X9rCJAkWtj87vnzYA5jpImbYd
	 bSbE292eFANahkvFwngJp4FWMmeDhG/zipxH2nI0P1nh8A+Ob/LsTfsvZ67ae1qRZW
	 HxI7yMx003kxKa+jzswr6dUE/Nl95875elgWyXJLNd8ZyGj7OsTfe8YG0NOj+me9JC
	 ydohIuB5OCZA7S9BqAkUN5Ip1QxIVlMPmq64b+okxEGBArGMvq9qS9IGulPFIUbJFe
	 Rj+JREfhKj1azSYH9qvIGOci2E0rVlOtYfRFgl/oWasjh+TkHx4gebQNCWhKAhn4Oe
	 3k+b7u4TZye6w==
Received: by mail.envisioncraftsman.com for <kexec@lists.infradead.org>; Mon, 24 Jun 2024 08:15:27 GMT
Message-ID: <20240624084500-0.1.3e.n05y.0.qpffagpzhj@envisioncraftsman.com>
Date: Mon, 24 Jun 2024 08:15:27 GMT
From: =?UTF-8?Q?"Jan_Pol=C3=A1=C5=A1ek"?= <jan.polasek@envisioncraftsman.com>
To: <kexec@lists.infradead.org>
Subject: Quick Question About Collaboration
X-Mailer: mail.envisioncraftsman.com
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_011538_497443_C2F20CC1 
X-CRM114-Status: UNSURE (   1.86  )
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

SGVsbG8hCgpJIGFtIHZlcnkgaW1wcmVzc2VkIHdpdGggdGhlIHByb2R1Y3RzIGFuZCBzZXJ2aWNl
cyB5b3Ugb2ZmZXIuCgpJIHRob3VnaHQgd2UgY291bGQgaGVscCB5b3UgcmVhY2ggYSBsYXJnZXIg
YXVkaWVuY2Ugd2l0aCB5b3VyIG9mZmVyaW5ncy4gV291bGQgeW91IGJlIGludGVyZXN0ZWQgaW4g
Y29sbGFib3JhdGluZyB3aXRoIHVzIGluIGFuIGFmZmlsaWF0ZSBtYXJrZXRpbmcgY2FtcGFpZ24/
CgpGb3IgZXhhbXBsZSwgb3VyIHByb2dyYW0gZm9yIGEgY29tcGFueSBpbiB0aGUgZS1jb21tZXJj
ZSBzZWN0b3IgcmVzdWx0ZWQgaW4gYW4gaW5jcmVhc2UgaW4gcmV2ZW51ZSBmcm9tIDglIHRvIGFu
IGltcHJlc3NpdmUgMTklIChvbiBhdmVyYWdlIHBlciBxdWFydGVyKS4KCldlIGFjaGlldmUgdXAg
dG8gMTMlIHR1cm5vdmVyIGluIEdBNCwgd2hpbGUgc3RhbmRhcmQgYWZmaWxpYXRlIG5ldHdvcmtz
IGdlbmVyYXRlIG9ubHkgMy02JS4KCldvdWxkIHlvdSBoYXZlIHRpbWUgZm9yIGEgc2hvcnQgY29u
dmVyc2F0aW9uIGluIHRoZSBuZXh0IGZldyBkYXlzPwoKCkJlc3QgcmVnYXJkcwpKYW4gUG9sw6HF
oWVrCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhl
YyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
