Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38908C48BF6
	for <kexec@archiver.kernel.org>; Wed, 21 Feb 2024 09:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fZ5w9gsoN3FNFiZ53dQgRm4iKT4fnX7M6tEoDSsF6qM=; b=YWTzgTRYEYf1ZP
	0BCX+5tOgwyMF7r40pBn9QnbYfU3/LY6eRMmUNlvK1F3eEijKVZW+lpH83BnXAwrWhhRFHlkL4LNT
	NCmthjsB3g3I2fivKkqq0kjgsCpRfLkpLr9WqaiWJWW2ILUYM2MbMQb3IAiCvL4Jz/+6CwC64122p
	uUpKnudiuuymKBHutAVro6lqWMY/HVvlTMB64cUJ43uq0XwRCFJlwuyhuOmJPjIJ7a7znXd5feaDm
	HK47KzaYrrLmYhWQ6EnkcyW6w2WH17RRTkoq4uhzdn9HSiNYyvyxuZqn4FkRhzlFd+PpzC6ByFDEq
	WK56b7e4XS3t4EukaGog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcidK-00000000BdQ-3L7V;
	Wed, 21 Feb 2024 09:11:18 +0000
Received: from mail.salesoptimize.pl ([162.19.245.89])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcid9-00000000BYa-3SLs
	for kexec@lists.infradead.org;
	Wed, 21 Feb 2024 09:11:17 +0000
Received: by mail.salesoptimize.pl (Postfix, from userid 1002)
	id 9114747B6E; Wed, 21 Feb 2024 09:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=salesoptimize.pl;
	s=mail; t=1708506654;
	bh=R5qtZczg8ebXMPa1Kykxd0TdK5L5taut80rC6pjGdEs=;
	h=Date:From:To:Subject:From;
	b=OrQUx3M+vALOlIHgxTDDltf/G1XIcDVqZdDGlE/r6/aBuuWq9+3zn9wtAntUQaDah
	 ExEUYcrS5uG+ntJj7Ge22zEJjLMCyD10MO1hMNUDy+7+xTBYPjnU9Y3HGcR1IEBvG1
	 FT0j3XRotiPrj5F60oJxxSYY8u8Abg35apzryHo12WwGf7vFL87OZGEJ0wL0a6XLos
	 KTzeDnGWr+hunXxWHFADnAmqzv5N9BhJ5FNHsaB03RMpLGcN9gOls0KDX/sBgrR8SZ
	 BGzRXOsn8M609F2c9rwCO4jJHF1gQlpCmxgFIT+o7/rakbfBmIYEWtiv82qt2VHDM4
	 Ljj1ORYpHOy1A==
Received: by mail.salesoptimize.pl for <kexec@lists.infradead.org>; Wed, 21 Feb 2024 09:10:49 GMT
Message-ID: <20240221074500-0.1.t.6zzw.0.i2ke1cpyka@salesoptimize.pl>
Date: Wed, 21 Feb 2024 09:10:49 GMT
From: "Tomasz Wawrzyniak" <tomasz.wawrzyniak@salesoptimize.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Nale=C5=BCno=C5=9B=C4=87_za_faktur=C4=99_?=
X-Mailer: mail.salesoptimize.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_011109_872784_5C6666EF 
X-CRM114-Status: UNSURE (   1.51  )
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

RHppZcWEIGRvYnJ5LAoKY2hjaWHFgmJ5bSBwb2luZm9ybW93YcSHIG8gbW/FvGxpd2/Fm2NpIHd5
ZMWCdcW8ZW5pYSBQYcWEc3R3YSBzcMWCYXR5IHphIHRvd2FyLgoKTW9nxIUgUGHFhHN0d28gesWC
b8W8ecSHIHphbcOzd2llbmllIHUgc3dvamVnbyBkb3N0YXdjeSB6YSBrdMOzcmUgbXkgemFwxYJh
Y2lteSB3ZSB3c2themFueW0gcHJ6ZXogbmllZ28gdGVybWluaWUuIFBvIHdwxYJhY2llIHd5c3Rh
d2lhbXkgUGHFhHN0d3UgZnYgc3ByemVkYcW8eSB6IG9kcm9jem9ueW0gdGVybWluZW0gcMWCYXRu
b8WbY2kgKDMwLTkwIGRuaSkuCgpKZcWbbGkgdGFraWUgcm96d2nEhXphbmllIGplc3QgZGxhIFBh
xYRzdHdhIGludGVyZXN1asSFY2UgYsSZZMSZIHdkemnEmWN6bnkgemEgb2Rwb3dpZWTFuiBjenkg
bW9nxJkgcHJ6ZWRzdGF3acSHIHN6Y3plZ8OzxYJ5LgoKClBvemRyYXdpYW0KVG9tYXN6IFdhd3J6
eW5pYWsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtl
eGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
