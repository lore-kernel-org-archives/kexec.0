Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC4CE6FE49
	for <kexec@archiver.kernel.org>; Mon,  9 Sep 2024 08:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hNM8EXp1sNtMrZyp9JQxPiZ9rseckud58iEvlEehqJg=; b=yK4qwUqR7avkSP
	kZ5dHuut0sF1KqLu+SPBHUFCemgqoSif50AxDG7EnFaT2+XorcKaapvCW0V9AyA6McUShlWonJYCT
	egujikxZs8KqlB5+4TeUPOH5kiLnxAyGhbuJfUMbSs052NXvBtlmiTQxddfdAx9Wy8VQSACsKQ0Y/
	CcXWZUuUrwfTpAvAy5Nu4ZW1Zm3k5cuLHf+fMpPpkGba2+O5p6bQ8HAOakSjdX0dnYAsg/K0VLd+T
	CBL6jdusdS/M1BtRU0khuBjcg97G9lmTxXkWvESotPF5LOuVrV4C8X7bucY5R/v8PvcLZkwz6OKGD
	fh1pI+OLlzzsO+eQLEqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snZLo-00000000yMn-07el;
	Mon, 09 Sep 2024 08:02:20 +0000
Received: from mail.originateinc.pl ([217.61.97.94])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snZLl-00000000yLf-00NA
	for kexec@lists.infradead.org;
	Mon, 09 Sep 2024 08:02:18 +0000
Received: by mail.OriginateInc.pl (Postfix, from userid 1001)
	id 234148473C; Mon,  9 Sep 2024 09:01:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=OriginateInc.pl;
	s=mail; t=1725868934;
	bh=EywM+E+OIUr7RnYatSz3YfoNTVB6dOfImeA7tdj3yJA=;
	h=Date:From:To:Subject:From;
	b=uEVZh+SPuJSm7PzSQs8lt+b+wjpfk1aK79PJxC+LewrkTY/Vx7YdDBupF/VJdlBCn
	 Pr4Gb2ylq2gp0lc1g2jVvJMYuymuAS4+lpXh9Mb28uyug/K0ch2YkRjEKz7tjX/q8y
	 9aTpEMDm+VmKeOf6MyMpIvzFm1e5Q7FbdCAASxGffWKv9oTLN2rP34ch6jSezX7x0q
	 tt8B5yDHP3IXXoHypsQU4nsyGJMhriUvrSJzeTy6femLkQrrNS+KJzzT0RaY6wheYC
	 KgjCCfoKB7PD1q+qufApCvPO7aH1TlkRjURSC9IbPcPXOd3hvy5I60mis/sdaU8xOQ
	 QhO3khhXTuHDg==
Received: by mail.OriginateInc.pl for <kexec@lists.infradead.org>; Mon,  9 Sep 2024 08:01:15 GMT
Message-ID: <20240909074501-0.1.f1.1ojhj.0.0eooednj0e@OriginateInc.pl>
Date: Mon,  9 Sep 2024 08:01:15 GMT
From: "Kamil Tralewski" <kamil.tralewski@originateinc.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?S=C5=82owa_kluczowe_do_wypozycjonowania?=
X-Mailer: mail.OriginateInc.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_010217_186254_B953727A 
X-CRM114-Status: UNSURE (   2.13  )
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
YXdpYW0KS2FtaWwgVHJhbGV3c2tpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
