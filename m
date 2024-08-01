Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA93C3DA4A
	for <kexec@archiver.kernel.org>; Thu,  1 Aug 2024 08:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=W8s9K40XenBiGuhJjyGFnMrPECFgvwCicrCr5IPjc3E=; b=LE7D09r+DAn+cj
	ioCqOgrCoS+sJb/yj9OeRN/Ct4jEH3XRo7u4ki+Nu4dhUnwWREnDLjRwWsLb4ctkmDSgb9/2RYnjh
	Gh8ur0jX2bmUUxmbJ9yMayaSRgh+2zRnh/bz01yfyKrx6OhC9lA2sV9NCwSXTPBiPXgYJ6JeYXaAL
	sBm8OX+tj4Wv1jIlGR/tFnniyeweM+aVeYjDZAcRCVoXWRDuxnEVuvOG0eDxhJ3sLo1N9xLB6PSKP
	NzxT0IQO6iUHAq0LKttDlunY46d3lDj4qVNCue+D8+qFW5x8pE5qqJJhwYEdNg8Nf6hsMx144QGVW
	4xWB3RzZkJCCM0UtCwHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZQoa-00000004HVF-3HwE;
	Thu, 01 Aug 2024 08:05:36 +0000
Received: from mail.growthsyne.pl ([94.177.230.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZQoX-00000004HSM-2LZi
	for kexec@lists.infradead.org;
	Thu, 01 Aug 2024 08:05:35 +0000
Received: by mail.growthsyne.pl (Postfix, from userid 1002)
	id 2CACB82D80; Thu,  1 Aug 2024 10:05:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=growthsyne.pl;
	s=mail; t=1722499528;
	bh=5VcxIlPmFWOJUScI3jvqGABB0GWSb9ZnqX77Jpd1Tx4=;
	h=Date:From:To:Subject:From;
	b=e8Z3unxtiZzc/9CbM54ND8kqkZtk9GTQb/hj7u0uetWHAwsOX467Om3R8FvpWodf3
	 zudRZhCwbHTEdrRsk1n02WYYk4Jww8QVEvBvQ1Z1kZAeoY0J5EblF8/xzdUwzDiKzm
	 TCcYcmBEFJkg2W1qii0oQmxFaZ1ZMKyg6VMKy0FpoyJIpRGAfKP28IdYgMrClnKy+e
	 KQ/XwklQUACDcOjKN1W5B97xyJbcpS0UqHY7eWSeCsJVg7StT+HeK6msxJehlGhXiN
	 nBszztjGdLgqMG63O23LAWKWJcEuvAJE9a0Zn6iLXEp4OLta6pfgbPa5PoeeumaYKd
	 1RGcuqwLdM8+A==
Received: by mail.growthsyne.pl for <kexec@lists.infradead.org>; Thu,  1 Aug 2024 08:05:16 GMT
Message-ID: <20240801084500-0.1.24.63se.0.ptmhrotc7n@growthsyne.pl>
Date: Thu,  1 Aug 2024 08:05:16 GMT
From: "Katarzyna Jarosz" <katarzyna.jarosz@growthsyne.pl>
To: <kexec@lists.infradead.org>
Subject: Zmiana w dokumencie
X-Mailer: mail.growthsyne.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240801_010534_305269_4606ADFB 
X-CRM114-Status: UNSURE (   1.38  )
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

RHppZcWEIGRvYnJ5LAoKY2hjaWHFgmJ5bSB6YXByb3Bvbm93YcSHIHdzdMSZcG7EhSByb3ptb3fE
mSBuYSB0ZW1hdCB3c3DDs8WCcHJhY3kgeiBQYcWEc3R3ZW0uCgpDZW50cmFsbmEgYmF6YSBkb2t1
bWVudMOzdywga3TDs3JhIGdyb21hZHppIGRhbmUgaSBpbmZvcm1hY2plIHcgemFrcmVzaWUgZS1t
YWlsaSwgZG9rdW1lbnTDs3csIGtsaWVudMOzdywgc3ByYXcvcHJvamVrdMOzdyAtIHcgcGXFgm5l
aiBpbnRlZ3JhY2ppIHogTVMgT3V0bG9vayBwb3p3b2xpIFBhxYRzdHd1IHN0d29yennEhyBrb3J6
eXN0bmllanN6ZSB3YXJ1bmtpIHByYXduby1iaXpuZXNvd2UgZGxhIHByb3dhZHpvbnljaCBkemlh
xYJhxYQuCgpOYXNpIEtsaWVuY2ksIG5pZW1hbCB3IGthxbxkeW0gcHJ6eXBhZGt1IG9zacSFZ2Fq
xIUgd3ltaWVybmUga29yennFm2NpIHBvIHphc3Rvc293YW5pdSBwcm9wb25vd2FuZWdvIHByemV6
IG5hcyByb3p3acSFemFuaWEgdyBwb3N0YWNpIHpuYWpkb3dhcmtpIGRva3VtZW50w7N3LgoKQ3p5
IG1vZ8SZIHphZHp3b25pxIcsIGFieSBvcG93aWVkemllxIcgbyB0eW0sIHcgamFraW0gemFrcmVz
aWUgbW9nbGliecWbbXkgd2VzcHJ6ZcSHIFBhxYRzdHdhIGZpcm3EmT8KCgpQb3pkcmF3aWFtCkth
dGFyenluYSBKYXJvc3oKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
