Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD339CD37B0
	for <kexec@archiver.kernel.org>; Mon, 18 Sep 2023 08:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+ippIz2r5OQ49sWIUSGa9B2e8QJ5GPK0BzEFFFx+Rtc=; b=raTF1Y1qkTIAKB
	SDggrjX5NeMEA29E1A/xIsKMC9x6AvNf462cpQCCmCMXgunMuS1z7OYqJS2gLy/WFb4niaK0yZx0r
	P3ehzMA2BrcSBIWktTiS+0VPcFuT7UBojziN/YioCKPgA1sT89TeDw/1XU80CpPpPxWF3yUILv88h
	cREgr5d9vcEadnEJpFaoWF9I+XSQ3Wzl56sEypR/mNjJ3uuVHpsXD71bAJvn51d65Drk90ECaBqqi
	MGOtjsEIdAkaFcjBjkfdGxOsGAno4FPgtIKV00U0HO3TwdOyrO0RNCjFu4ZpSQhz+8tzeF53HOIqE
	LlIP4XLnMFlLveGw5dSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qi9R5-00EpSd-34;
	Mon, 18 Sep 2023 08:16:51 +0000
Received: from mail.blairton.pl ([141.94.250.72])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qi9R2-00EpRE-2X
	for kexec@lists.infradead.org;
	Mon, 18 Sep 2023 08:16:50 +0000
Received: by mail.blairton.pl (Postfix, from userid 1002)
	id 139EEA3C7C; Mon, 18 Sep 2023 08:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=blairton.pl; s=mail;
	t=1695024956; bh=SQg0cr+HABfTdkcZROAFSg8TR3/oubMNjysx8YYpX80=;
	h=Date:From:To:Subject:From;
	b=gGwqfSLWVv6BiB8eE2xUcqo+5JdMII7l+cZnv2c/Vb9+rvBVtvbsqOUx2Xna1xzCj
	 wn/mZK6NZtOhv4AufmPzwYJfECjH5U7tgu70ROF+wWB6VBbkv1RGiXk3+x0dlrIRGY
	 lJxO/sim9HK6ZaN56aukAVE9MmaBszuXCRdC90EAEzEggl8vbfqT2dq4hrsklW6nwC
	 nShuBKTZ1aBsig2JRNPVhvPjbjvc2q/lTyxMAGDowsoGWcX8cKvdOD5k27xaObkmwD
	 CSsKJIifR37VepvMvmEuUi93aFHotSj0CEL1yTKr7JkHePO0EYYTLepyD525kRcs/5
	 //wA3rd33PLYQ==
Received: by mail.blairton.pl for <kexec@lists.infradead.org>; Mon, 18 Sep 2023 08:15:20 GMT
Message-ID: <20230918064500-0.1.c3.gtvu.0.pacamkq09u@blairton.pl>
Date: Mon, 18 Sep 2023 08:15:20 GMT
From: =?UTF-8?Q?"Damian_Kwaczy=C5=84ski"?= <damian.kwaczynski@blairton.pl>
To: <kexec@lists.infradead.org>
Subject: Przechowywanie towaru w Gliwicach 
X-Mailer: mail.blairton.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_011648_997202_C1542125 
X-CRM114-Status: UNSURE (   1.59  )
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

RHppZcWEIGRvYnJ5LAoKY3p5IGplc3QgbW/FvGxpd2/Fm8SHIG5hd2nEhXphbmlhIHdzcMOzxYJw
cmFjeSB6IFBhxYRzdHdlbT8KClphcGV3bmlhbXkgb2JzxYJ1Z8SZIHRyYW5zcG9ydG93xIUgbmEg
dHJhc2llIFBvbHNrYSAod29qLiDFm2zEhXNraWUpIC0gV8WCb2NoeSBpIFfFgm9jaHkgLSBQb2xz
a2EgKHdvai4gxZtsxIVza2llKSBvYmVqbXVqxIVjxIUgb2RiacOzciwgdHJhbnNwb3J0IChjYcWC
b3BvamF6ZG93eSwgY3rEmcWbY2lvd3kgb3JheiBkcm9ibmljb3d5KSwgb2RwcmF3eSBjZWxuZSBv
cmF6IG1hZ2F6eW5vd2FuaWUgd3JheiB6IHVzxYJ1Z2FtaSBkb2RhbnltaS4gCgpaIG5hc3p5Y2gg
cm96d2nEhXphxYQgdHJhbnNwb3J0b3d5Y2gga29yenlzdGEgd2llbGUgbWFyZWsgdyBQb2xzY2Us
IHp5c2t1asSFYyBjacSFZ8WCb8WbxIcgxYJhxYRjdWNoYSBkb3N0YXcsIGpha2/Fm8SHIG9wZXJh
Y3lqbsSFIHBvdHdpZXJkem9uxIUgd2llbG9tYSByZWZlcmVuY2phbWksIG9wdHltYWxpemFjasSZ
IGtvc3p0w7N3IGkgc2tyw7Njb255IGN6YXMgdHJhbnp5dHUuCgpCxJlkxJkgd2R6acSZY3pueSB6
YSBpbmZvcm1hY2rEmSBjenkgbW/FvGVteSBwb3Jvem1hd2lhxIcuCgoKUG96ZHJhd2lhbQpEYW1p
YW4gS3dhY3p5xYRza2kKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
