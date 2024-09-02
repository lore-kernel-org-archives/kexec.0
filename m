Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C4BCD13CF
	for <kexec@archiver.kernel.org>; Mon,  2 Sep 2024 08:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=D790/xkWZjT0SOz3fcdwPBkWlwQ7PL9Qaiws/Q+SGVI=; b=uROXrUZo8JkZ4P
	xY0IcJ2LnJ+BomkQfRz7ScQlgkcY3sYx713wST0zf6QqdSCcdktxWZJOfpU//REpB0WHh8pZFMHyx
	uklMNeqM65Z7hcPe6Fp/snI/3KjSKy5jAKDMLmmhPGRISDcQ+WAwYNBJ77nDTfqTBQy8LjnksKmcz
	cfo4+yMncVeM61miFN9yarPKgc7bRlLC4fGT875sPYrXSnGGLygCLMe/szy/iMSLoGdpbez+9OgPR
	oWd0xonYHJhX+3WazdKreBChnzaDvY9VEbDf1dTIKCqEEias5UoAE2ShMZMEOlu8PtIoOraEiJlFg
	4u4lybGI1SLPEMlr7Neg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl2Az-0000000DSLD-3mEh;
	Mon, 02 Sep 2024 08:12:41 +0000
Received: from mail.bizexpand.pl ([51.195.45.234])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl2As-0000000DSIg-0bWA
	for kexec@lists.infradead.org;
	Mon, 02 Sep 2024 08:12:36 +0000
Received: by mail.bizexpand.pl (Postfix, from userid 1002)
	id 7F93DA3B0B; Mon,  2 Sep 2024 10:10:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bizexpand.pl; s=mail;
	t=1725264661; bh=b66vnmQcMiRaXeBI0KU0YYi7oojxhjRqLgY47/BnoWM=;
	h=Date:From:To:Subject:From;
	b=GvMICFueQvR+WtKduhvxCnvODoALKym9mVI08ym7nO7K6Qd5MF/sJHzxR9w57zONK
	 yDbh0R1fxDpdeht4bEfNDG6xpZueTGOE2BAhcLI4eZry619h/KOvvGSTizjQR6fFLM
	 LOouYDE17fZuJBj0NRZR2n4sOrdI1kGIk76oLJqhWpR+u+r5ti/SyJAVfeAAb5nf44
	 b6piLHwsOkeJjkSFpWotaQfdnB8PFmxt6/+ADzS8xZV8Bb63nNuVNDjUsQ8PwK4qTw
	 FsDzebWg2Kgy1CYDiBHvWguxwM1AV2h0ufQqZqFGbXM/0D2JEQ7cOpB/I229jzu9wZ
	 8fN9OAJLvkrSQ==
Received: by mail.bizexpand.pl for <kexec@lists.infradead.org>; Mon,  2 Sep 2024 08:10:34 GMT
Message-ID: <20240902084500-0.1.jp.2g7nt.0.4629w5qawa@bizexpand.pl>
Date: Mon,  2 Sep 2024 08:10:34 GMT
From: "Wojciech Barglik" <wojciech.barglik@bizexpand.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Termin_odbioru_przesy=C5=82ki___?=
X-Mailer: mail.bizexpand.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_011234_892988_54080FB6 
X-CRM114-Status: UNSURE (   1.29  )
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

U3phbm93bmkgUGHFhHN0d28sCgp6d3JhY2FtIHNpxJkgZG8gUGHFhHN0d2EgamFrbyBwcnplZHN0
YXdpY2llbCBkb3N0YXdjeSBzcHJ6xJl0dSBrb21wdXRlcm93ZWdvIGRsYSBmaXJtLiAKCk5hc3ph
IGJvZ2F0YSBvZmVydGEgb2Jlam11amUgc3plcm9raSB3eWLDs3IgbGFwdG9ww7N3LCBkZXNrdG9w
w7N3LCBzdGFjamkgcm9ib2N6eWNoIG9yYXogc2Vyd2Vyw7N3LiBQcmFnbsSZIHBvZGtyZcWbbGnE
hywgxbxlIG9ic8WCdWd1amVteSB3acSZa3N6ZSB6YW3Ds3dpZW5pYSwgbmllIHBvamVkeW5jemUg
c3p0dWtpLgoKQ28gd2HFvG5lLCBwb3NpYWRhbXkgbmFqd3nFvHN6ZSBjZXJ0eWZpa2F0eSBwYXJ0
bmVyYSBmaXJteSBEZWxsIHcgUG9sc2NlLCBhIHRha8W8ZSBqZXN0ZcWbbXkgcGFydG5lcmFtaSB0
YWtpY2ggcmVub21vd2FueWNoIG1hcmVrIGphayBMZW5vdm8sIEhQLCBDaXNjbywgTWljcm9zb2Z0
LCBWTXdhcmUgaSBTY2huZWlkZXIgRWxlY3RyaWMuIER6acSZa2kgdGVtdSB6YXBld25pYW15IFBh
xYRzdHd1IGF0cmFrY3lqbmUsIGtvbmt1cmVuY3lqbmUgY2VueS4KCkN6eSBpbnRlcmVzdWplIFBh
xYRzdHdhIGtvbmtyZXRueSBzcHJ6xJl0IGx1YiBtb2RlbD8KCgpQb3pkcmF3aWFtCldvamNpZWNo
IEJhcmdsaWsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
