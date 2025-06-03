Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7663C5AD49
	for <kexec@archiver.kernel.org>; Tue,  3 Jun 2025 07:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0Yjr6NsrKkaYb/LNYm1mPKHuxqkR0iWhkNkzH9QSzrg=; b=iupvMRIxHy6FQfwmaDtYMFJStv
	zmlEJPJLd0OMh4e+U0ZTvtwiXEyuoFqLklHRXuzC3gzkbBfJoWUIrcVTOYh8jc0R0lWeduTCRqh5i
	WO10ViXf4Tjf9P0VOEhA3A1F75Ji1GD17iUfViMjZGHi+wtKifRE94nrcOOUstNKMlW+jtcVbVT6S
	BuHGaJZwprdIPe2cmaeE4PikG5QRPp20mk+79tU6arSzJGaL/ZYp8ziUi6WH9R9TIMaifNhD46rVZ
	lnDA3D9dZ9Rd4peguo745/YmtKNn9VNou9uuh3d/gkbfsxK6FeCg7YL6rkrY+QSLOE5MORKuBHigl
	S0dEOQOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMM87-0000000A8zO-1lh6;
	Tue, 03 Jun 2025 07:32:15 +0000
Received: from mail.fintara.pl ([51.68.214.200])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMM83-0000000A8xM-2VsL
	for kexec@lists.infradead.org;
	Tue, 03 Jun 2025 07:32:13 +0000
Received: by mail.fintara.pl (Postfix, from userid 1002)
	id 6762C47233; Tue,  3 Jun 2025 09:31:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fintara.pl; s=mail;
	t=1748935924; bh=0Yjr6NsrKkaYb/LNYm1mPKHuxqkR0iWhkNkzH9QSzrg=;
	h=Date:From:To:Subject:From;
	b=YGQTLC4xzpb4VlqSj3XUhIAz7hEChW4OQYGtQqMaYBcGxDdfRs4SzosgCUr73f9MX
	 13+eQa6NzdqIL+HfvWXJYdgLWGrDTvRMfYjYldgLlhOYsluVJxtXVLXXpLlhhplSH+
	 pTTM28PtXmiSN1uEJ87t0QjEJ3emElSDPpUCWz72o+wMAnmLmEsQF7EggGhcmen9si
	 TlA0gTbb8tI2p6eU2HbrT13yjk32NFQKYlus43m3ZvJclNeopMFAd9KN7OLWpOSwsl
	 eNyYNVbfr3q5H4oasvn8P8tPTIgEQs4/LbJzssckwRY6H7sA/vFTJZtxNynTav/uir
	 1GhT7nDRGZGxA==
Received: by mail.fintara.pl for <kexec@lists.infradead.org>; Tue,  3 Jun 2025 07:31:03 GMT
Message-ID: <20250603084500-0.1.9v.2geup.0.exyl9oq0jm@fintara.pl>
Date: Tue,  3 Jun 2025 07:31:03 GMT
From: "Dominik Lotka" <dominik.lotka@fintara.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Prosz=C4=99_o_kontakt?=
X-Mailer: mail.fintara.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250603_003212_336450_33179554 
X-CRM114-Status: UNSURE (   0.62  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Dzie=C5=84 dobry,

Czy jest mo=C5=BCliwo=C5=9B=C4=87 nawi=C4=85zania wsp=C3=B3=C5=82pracy z =
Pa=C5=84stwem?

Z ch=C4=99ci=C4=85 porozmawiam z osob=C4=85 zajmuj=C4=85c=C4=85 si=C4=99 =
dzia=C5=82aniami zwi=C4=85zanymi ze sprzeda=C5=BC=C4=85.

Pomagamy skutecznie pozyskiwa=C4=87 nowych klient=C3=B3w.

Zapraszam do kontaktu.


Pozdrawiam
Dominik Lotka

