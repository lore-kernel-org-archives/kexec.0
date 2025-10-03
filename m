Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F85CCA470
	for <kexec@archiver.kernel.org>; Fri,  3 Oct 2025 08:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=W6pc+5/xPhSbH0zr9bjAiMmMFYb2K/+gFLzIJwDWd9Q=; b=LZ79YlV1dtEoTRqIL9F5Mfw20h
	M4UGT1346Yoxsv0+Rnr8QMW7rnp2/GGmOFa0G3ErPa7/5/cnDkuoWs9tAokh16L9F4QL8cLkyPgHh
	SCg8hQnH7KXDWRBpVfVA9K6aL7wB3uecAosDROuqSBQ93m0pVkRPqQOwfeVrB5p1aa4JJWPPNXqx5
	WapIgmN5vR5hpoj2qRTJqn+oirJERDhC8gZmdI3cM+r4rC7SwazWr8b4QR+to/2pYhfWzZOLT01DE
	vHaFEfCPMA9xFD6ddZ0Ha6hKNu5akbERKrk24Kll+twHBW6hgyjeMy/xaaTx9TtAzWc4Rjlt0SWPv
	szuXh1Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4aqx-0000000BrEJ-0Lyo;
	Fri, 03 Oct 2025 08:09:23 +0000
Received: from mail.primefinix.com ([141.95.160.218])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4aqu-0000000BrCG-1Koh
	for kexec@lists.infradead.org;
	Fri, 03 Oct 2025 08:09:21 +0000
Received: by mail.primefinix.com (Postfix, from userid 1002)
	id 62401A8DFC; Fri,  3 Oct 2025 10:00:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=primefinix.com;
	s=mail; t=1759478439;
	bh=W6pc+5/xPhSbH0zr9bjAiMmMFYb2K/+gFLzIJwDWd9Q=;
	h=Date:From:To:Subject:From;
	b=D7IpfYd5KS75klM6VxUIpsz1QQfmcmstd+/E8eev6u1ITV9pWmwlx6iAhSv5he89l
	 kpLG0qJ+b0hoYQHbGREUl8qt3Bj/7OvcIooAC8Pn2wok4TRTjnyl4RqeRDVXnkjYYM
	 ule1y/pNLcz+GUZJX83HkwBYU9MqRTgkC0g+UzwebdhbdAU/KQeaoWYPeHa35m4IzP
	 XPmAJnmocBloS6TmtPN4S5xjLsnONmcBcp0Qrk1xpOZ3CDAtTByNZMY0Sel6xe6MI+
	 EhNFks6d8UgDWmLOQ1GrEtemJ959RxpOVWF2Ktlb7dpSQiYUsszag6NKwIU9t09HgR
	 lByA4PXx3X8Bg==
Received: by mail.primefinix.com for <kexec@lists.infradead.org>; Fri,  3 Oct 2025 08:00:17 GMT
Message-ID: <20251003084500-0.1.nc.44j74.0.ba2glb3kzi@primefinix.com>
Date: Fri,  3 Oct 2025 08:00:17 GMT
From: "Brendon Roy" <brendon.roy@primefinix.com>
To: <kexec@lists.infradead.org>
Subject: No stock, no hassle
X-Mailer: mail.primefinix.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251003_010920_649423_4067E9B6 
X-CRM114-Status: UNSURE (   3.35  )
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

Hi,

I know you're probably bombarded with offers every day, so I'll get strai=
ght to the point =E2=80=93 we have mattresses that are selling very well,=
 so we're offering collaboration.

We're looking for partners to work with us in a dropshipping model =E2=80=
=93 no warehousing, no logistics, and customers receive their shipments d=
irectly from us. You focus solely on sales and margins.

Does this sound interesting to you?


Best regards
Brendon Roy

