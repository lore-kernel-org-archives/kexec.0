Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A4FC3271E
	for <kexec@archiver.kernel.org>; Mon,  8 Jul 2024 08:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=IMIY5l0Qk6CCT9YaKGHUnNhn+D6qzzgVZZWygACIJxA=; b=WDXHwKrIhSbOy/
	/cYcP3uCzOcSElw9TH6bjzZyze6iBxLch2r5GVWNMjcXMtUB4VMLsxiRtHGHEmp0QCDGSdFx8eMYc
	XeKcLwbOry71W9Z75+yo2KuST9tE2oVNqa9ngbttd21bkQR6YutND0gFYeH4PgUI2ktjrPA/FGYg2
	bueOtcW1F0ZwJu+KnYQuK7VgAjlrcG2fqvhV3aaKjlUAR/lNmdUyy9Y5HJkkOCX/DB3BDlnSPuY9w
	LI3t5SM1zxIT6FlFMqK9YqbAgLGJMeGfUT/VARaKiHdKI278jOAJJdJjDi7NmtYJS13i8KODvm0iY
	FvbqJpygIZcumYKTouuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQjYE-0000000396w-3rFH;
	Mon, 08 Jul 2024 08:16:46 +0000
Received: from mail.creationavenue.pl ([217.61.16.184])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQjYB-0000000395j-23ym
	for kexec@lists.infradead.org;
	Mon, 08 Jul 2024 08:16:45 +0000
Received: by mail.creationavenue.pl (Postfix, from userid 1002)
	id DAC3A8262E; Mon,  8 Jul 2024 10:16:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=creationavenue.pl;
	s=mail; t=1720426576;
	bh=ChscJKp3Om3FoG8SjFzTAmp7diEPSUZN/W3lUPFw6JM=;
	h=Date:From:To:Subject:From;
	b=zW18ce7+EqWIIuwwD02dGxMb+EN5vi5BSgiWAvn8ym+oCp/So4x9kKNrrLBWZfKRe
	 Cn80CaUzyR8hLwnhadkkEOA/QFdxJ/mAEqZhSgkGl4fD1r3VY9mRQsLxNVfNkr4L1v
	 JCtA6NNeM/cqFdVska+9KhstDrgj+vrdPAR7qLJrdoGMKE19Yc0ZX20N07tdQGokT8
	 Cgvee9lbDNHAudHS1+y/h8CBymZJtD2jAjtXTmFol+eaGaH0gaVDjKIJ8ZT2LeGFQY
	 37MmeFroCSqc/fC0kOaRjd5ZWFSt7IFwMsBhyFjHQ64FpTs3yIqwgtMl80Oqzm0/hM
	 TPuyM7RDM58OA==
Received: by mail.creationavenue.pl for <kexec@lists.infradead.org>; Mon,  8 Jul 2024 08:16:03 GMT
Message-ID: <20240708084501-0.1.4n.m2bb.0.erj4rj4q40@creationavenue.pl>
Date: Mon,  8 Jul 2024 08:16:03 GMT
From: "Karol Winiarski" <karol.winiarski@creationavenue.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?S=C5=82owa_kluczowe_do_wypozycjonowania?=
X-Mailer: mail.creationavenue.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_011644_216732_2E76E32A 
X-CRM114-Status: UNSURE (   1.02  )
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

RHppZcWEIGRvYnJ5LAoKemFwb3puYcWCZW0gc2nEmSB6IFBhxYRzdHdhIG9mZXJ0xIUgaSB6IHBy
enlqZW1ub8WbY2nEhSBwcnp5em5hasSZLCDFvGUgcHJ6eWNpxIVnYSB1d2FnxJkgaSB6YWNoxJlj
YSBkbyBkYWxzenljaCByb3ptw7N3LiAKClBvbXnFm2xhxYJlbSwgxbxlIG1vxbxlIG3Ds2fFgmJ5
bSBtaWXEhyBzd8OzaiB3a8WCYWQgdyBQYcWEc3R3YSByb3p3w7NqIGkgcG9tw7NjIGRvdHJ6ZcSH
IHogdMSFIG9mZXJ0xIUgZG8gd2nEmWtzemVnbyBncm9uYSBvZGJpb3Jjw7N3LiBQb3p5Y2pvbnVq
xJkgc3Ryb255IHd3dywgZHppxJlraSBjemVtdSBnZW5lcnVqxIUgxZt3aWV0bnkgcnVjaCB3IHNp
ZWNpLgoKTW/FvGVteSBwb3Jvem1hd2lhxIcgdyBuYWpibGnFvHN6eW0gY3phc2llPwoKClBvemRy
YXdpYW0KS2Fyb2wgV2luaWFyc2tpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
