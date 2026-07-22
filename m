Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B8BC44532
	for <kexec@archiver.kernel.org>; Wed, 22 Jul 2026 16:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=C8H3B3jgYUm7X2Pio7mt3v4d6UjIw+eyDS/YNc88Saw=; b=OdHjo5SqodVsbQCc+1HLouKe/r
	d3qRzc2THs5wU+wE0I1Uc61Z4tTTbAYejyxPdOA4ZjYJBFuCmB2wmwVVLtubF4A0LKzp5d6FiZ3ed
	FKGh53LIn+UXgK+16Cr6rOlhVSbLtNnKpXhkzv3ZsBO2eH9nzYCunt40njCnuKEwWp2NB78aQgcBT
	A9u7/B+gJPw1nQVF3+KZqz7w+iV3CQegUg6Yw1pfVFJ9GCKM3z44jp0Stqb0KCMxyF7AaQ+/VkUwE
	sfAlbo+IC0xj0CCepZZgVe9bd7mg+elNw9HzBPwv4Pl8F8fPnGF/4k7oczAvUBWrKJrDUQz6Xs3tH
	934gd4TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmZlF-0000000CKmQ-3tLw;
	Wed, 22 Jul 2026 16:25:33 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmZlE-0000000CKlr-03Uh
	for kexec@lists.infradead.org;
	Wed, 22 Jul 2026 16:25:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 31014600AF;
	Wed, 22 Jul 2026 16:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E011F000E9;
	Wed, 22 Jul 2026 16:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784737530;
	bh=C8H3B3jgYUm7X2Pio7mt3v4d6UjIw+eyDS/YNc88Saw=;
	h=From:To:Cc:Subject:Date;
	b=SKoFURD45Fm4IiUlx1Y6FAQg6Tgr8f/UO0xZPra6YqZgak3peqHby48PjKGrGeG9y
	 bJeg6KB7yz+9UiKhzdeZVOEJil9ZgSfuBXS86xsZ4pNdiLZMWw3xHdX1lIzzQzm6Yl
	 4+k4ViwgKYtmoKwvGTSFfSLIKJrb25fvqzOlSvurOBdUFrNsUfsKAoshvFzXdzvV3f
	 AC1zLZYTJW9/ws308EUW8ryuKTcwWGpXoXztfjZgUOGUtKkDzwe3PNZdboFjcb2Bxs
	 aGTDs3ODoTXt3SPPHVcFw7nTfWzQOmXKvG03vcfWngcchjllZYkJY16nTqKY6NBhlF
	 miqspc6V/vWvA==
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Jackie Liu <liuyun01@kylinos.cn>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] liveupdate: a fix for v7.2-rc5
Date: Wed, 22 Jul 2026 19:25:07 +0300
Message-ID: <20260722162524.1014269-1-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Linus,

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git tags/liveupdate-fixes-2026-07-22

for you to fetch changes up to 4416f8a9ed5f49256dc69c664f1386b496ca16a1:

  liveupdate: fix GET_NAME ioctl argument validation (2026-07-16 09:25:30 +0300)

----------------------------------------------------------------
liveupdate: a fix for v7.2-rc5

* Fix validation of LIVEUPDATE_SESSION_GET_NAME ioctl argument caused by a
  wrong resolution of a merge conflict during the last merge window

----------------------------------------------------------------
Jackie Liu (1):
      liveupdate: fix GET_NAME ioctl argument validation

 kernel/liveupdate/luo_session.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

