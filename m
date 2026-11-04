Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AABC606A31B
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2VZjzYTH;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=m1/TBuwl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=4IqEotgPDT1hegyi7/J8DGunAd5SP02PqdK9DhD9Exc=; b=2VZjzYTHXVW5y6
	KUUPC83LBJmjUechurarjAXVJrkSq1Yb0+HXAOLjSl6//t6wjfQ9FD8gaTRRIfOoSTbf8iKeJZhbD
	AGd0vMEUVZmv2IzbQs+zlDEVGlKj9wn9qZripoODOtKzuSA75XYReBj4peSVFfMPLR9nQnEDBbJ3H
	A5JRZtVM5ftaftrDeXlEdDeAqteApY+giph+6CT/94TbUakHGV3eBGnB7++1tWXQefb67T5UqAv0F
	r6351mtzD6xhM81dgUQa6k0nZntw5RfUlwGVNwrGn9QOTf4q7xV0OKeoNKWXIsYk+rIoFY9Dz994a
	gIgmobqL9jJctbt38wsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObFa-00000005VMh-0sj5;
	Wed, 04 Nov 2026 13:42:02 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObFX-00000005VLC-11ZO
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 13:42:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793799715; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4IqEotgPDT1hegyi7/J8DGunAd5SP02PqdK9DhD9Exc=;
	b=m1/TBuwluJUKU9g0aPAqQr0SgawskW5qRgQsyijNC5RnRFR+8C4FGgYE8LXPk1udR8IKKA3paslVHFCz7DNBwpxBKmkOt/6WhOiWl8HsvzqQENxJR8AmmJxOj+aaU3ZSMY4ZDMfbMzKTm2RnuyfUn3ZrQQfIxHUA075lLESdo5c=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0XE5r9Xj_1793799708;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XE5r9Xj_1793799708 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Nov 2026 21:41:54 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: pratyush@kernel.org
Cc: graf@amazon.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	rppt@kernel.org
Subject: Re: [PATCH] kho: Skip zero-sized bootmem areas
Date: Wed,  4 Nov 2026 21:39:56 +0800
Message-ID: <20261104134147.1695-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2vxz8q38lqp4.fsf@kernel.org>
References: <20261026131851.9942-1-cp0613@linux.alibaba.com> <2vxzld7kpmmi.fsf@kernel.org> <20261027074028.13042-1-cp0613@linux.alibaba.com> <2vxz8q38lqp4.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_054159_502332_0E10CD5A 
X-CRM114-Status: UNSURE (   4.04  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Mike sent out [0] recently which should fix this problem. Please take a
> look at that, and see if it works for you.

Yes, that covers it. The zero check sits in the one helper all three
allocations go through, so the three cases in my other mail are all
handled and my patch is not needed - please consider it withdrawn, there
is no competing change from my side.

Thanks for pointing me at it, and thanks Mike for picking this up.

Best regards,
Chen

