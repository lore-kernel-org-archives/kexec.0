Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283FB606A31B
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 03:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rwL4KQsL;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TC+CnXRP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=C3bbcV4jOv7yHyE1B1LNNqja0PzYKDvjOLb3BlCeaAM=; b=rwL4KQsL152ATw
	xCC1lWDajUiW360zWQxFMg2+SoQk4WOQDlZERsMkvE+hLR59+zYsjh1PppoXB+ABuAWcFz8fzJBLD
	biGes5gld8G2aL0cKKAzkw3lBms7bujVxKIi5Jbj47/1PpY+e8dGgzCSb6gwvTGcUZk7KSMblFwRs
	0BfoFmUnkeq7x7qQ+EyEKZhAyIkvPB6sJF9HWrw5wfB+TUcMoCmYiY4ijVLmJSKig3UUcjwHFYsIq
	s00mVZvptpjG50HvwY1vet782ENmaZARNnc+SnBhpu9rFS1BCWIemryt1XP4teKT4Dridnlh47qZn
	RIQCVFRgzNAg+XTb9Fag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPAqR-0000000BBBP-2x4S;
	Fri, 06 Nov 2026 03:42:27 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPAqL-0000000BBAu-1WL8;
	Fri, 06 Nov 2026 03:42:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793936536; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=C3bbcV4jOv7yHyE1B1LNNqja0PzYKDvjOLb3BlCeaAM=;
	b=TC+CnXRPGCtS8jx6esP5Ogbm1K+gBcnD/K54itEsLgXIhnnnPxI6efUxs5sF5wabteu+1sLrmoaG7NH2Mp1Yj1Xm2fRAzyFEfg38PTn6LCji8ldDGQ1Up562XW4u0iUevm55wLpKSG3RnQG/8sPxPyZdhVyOIGQhs6S3HovE2Ss=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0XEAEe5H_1793936513;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XEAEe5H_1793936513 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 11:42:15 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: rppt@kernel.org
Cc: alex@ghiti.fr,
	graf@amazon.com,
	guoren@kernel.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pasha.tatashin@soleen.com,
	pjw@kernel.org,
	pratyush@kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH v2 1/5] kho: Do not translate the handover FDT address in is_kho_boot()
Date: Fri,  6 Nov 2026 11:41:40 +0800
Message-ID: <20261106034153.1462-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aux_dPnvXk3LYDxs@kernel.org>
References: <20261103080926.2079-1-cp0613@linux.alibaba.com> <20261103080926.2079-2-cp0613@linux.alibaba.com> <aux_dPnvXk3LYDxs@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_194222_051502_D4F1EBAE 
X-CRM114-Status: UNSURE (   7.18  )
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> There was very similar patch:
> https://lore.kernel.org/all/20261023054518.3258350-1-gthelen@google.com
> and while both Greg's and your patch are correct they both have that wall
> of text with too many details commit messages that I don't like.

Hi Mike,

Thanks for the pointer. Greg's change is the same one，and his post
predates the fix in my series and already has Pratyush's review tag
on it. I will drop patch 1 in the next revision.

On the commit messages: they do restate what the diff already shows.
That comes out, and I will trim the other patches in the series the
same way.

Best regards,
Chen

