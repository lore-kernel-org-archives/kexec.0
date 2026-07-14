Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C44C43458
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 07:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:
	To:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=oYv+WYvsJmwUffDXJsF84xjDBeDofLq6gH5nkZPSFUM=; b=flRPM+uGsZ6SlH
	agYiXl+iU5ilnzRID/QUNEv7J+/fb4G7Rqpn7mXP8QDThG3Hu1J8X4QCCJdjUGtoZWm6zau5b21l8
	QJaAmLp+rQDpwBGAxbr5JYfxPBLVxocpHq1w2aE+dRkMeQKj4GXn95uZjgYx43Abhz+Iw68PPnwxI
	BRape7rrkTC/1TwVJ3QOa11MW5W7vguiJM95NIdf9XO4ceQd05gwMOHy5hYl9WnTYUBsxbztygmUB
	jhZXush1CvNyi0qsgf77WyEz4xG4h1PoQ/D1aCRZaLhEgJRlR4y4LAkiwKd6Ewdc2Z6JgNv7IJKp2
	g5ui90KixIl/9KGgDs1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjXF6-0000000B7mn-0KTb;
	Tue, 14 Jul 2026 07:07:48 +0000
Received: from ns1.suksangroup.com ([103.13.31.55])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjXF1-0000000B7mQ-19HF
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 07:07:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=suksangroup.co.th; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oYv+WYvsJmwUffDXJsF84xjDBeDofLq6gH5nkZPSFUM=; b=Rv/ooYH7xEgrnOT9lZwVB4mX2/
	hIhaBM7EeutoH3c+4H3/8hglarEt+UVmsL0L4ciRrrlGdtVm7GAcYeUfLzanZdYrHUHr5EqoV+v2y
	1UixEf3FSGD2OeVCsgZiD09e9LhH+YGOymlP9Aiv8vzCKUR+8QZsf/s65PASpdBwE+qjJ/zpd/ts6
	+iBCSXqdmsWcY1ZxQU9+Tu3W3stmjz7LTGjg0qCtfoONHyZfRpyeYAc3+qMoj7HQxvAdHO0BR9Ykf
	LXgjUcsqTeF8/a2pNFJQmzupu1Q7O5jx41/UA6pLLjvSeUeyGKNTmco8yQbIhEuddAV5ouW4/w4TI
	lcGVwlrg==;
Received: from [207.189.26.187] (port=57631)
	by ns1.suksangroup.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <info@inbox.org>)
	id 1wjVKL-0000000FkYv-1RW6
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 12:05:04 +0700
From: Harry Schofield ESQ <info@inbox.org>
To: kexec@lists.infradead.org
Subject: Dear kexec@lists.infradead.org, project stage
Date: 14 Jul 2026 00:04:58 -0500
Message-ID: <20260714000458.D4525941B9073923@inbox.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns1.suksangroup.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - inbox.org
X-Get-Message-Sender-Via: ns1.suksangroup.com: authenticated_id: smtp@suksangroup.co.th
X-Authenticated-Sender: ns1.suksangroup.com: smtp@suksangroup.co.th
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_000743_499805_E2F0424E 
X-CRM114-Status: UNSURE (  -2.34  )
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
Reply-To: hanns.schofield@lexcapitalgrowth.com
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


Re:Good day kexec,

Please let me know if this is best email to send you the project=20
info.

Kind regards,

Harry Schofield, ceMBA



