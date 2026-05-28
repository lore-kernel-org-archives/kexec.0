Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768BCCD4F54
	for <kexec@archiver.kernel.org>; Thu, 28 May 2026 17:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2tns20Jc2qFQBaO3MIIRuCNGNOwNtzQn34pDKtjl1l8=; b=2xBf5mK3Zwjn1D2qUYuLBtyYiT
	+8sjzS1LxNz5I7oH+ic/wi9MQsdThNjmwEqzA1FRx5hVxODNN+hXHaihADR7nFEFffIMcMVM1Uq8l
	hwunfp262jhd5sjuyzyvpf3Xht8zsdow3G/dJKvBhwDqSZ0t8IJiTW3ZL//UTUbFjxWetcUjDnSQ9
	l83yPkB5XW5NRh3+o+QhIX/9jAVR78yBWZ4+6qe3DzcwGzS8+hp+BrJTB4C5ttIr9272HMFNOmJYn
	QWlbf+yTw7l1daCRFnMj3Gg6vIDIAyeI5JD4BUHk9W0qQsmtNGJe54p+IqYWes+jB2n4BE5EQ98Xc
	Uwp1LLQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSejv-000000067SB-11VM;
	Thu, 28 May 2026 17:41:51 +0000
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSejt-000000067R0-2VAr
	for kexec@lists.infradead.org;
	Thu, 28 May 2026 17:41:50 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-82fa860e71eso6699167b3a.0
        for <kexec@lists.infradead.org>; Thu, 28 May 2026 10:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779990108; x=1780594908; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2tns20Jc2qFQBaO3MIIRuCNGNOwNtzQn34pDKtjl1l8=;
        b=iSfDlUvcq3whPrcapS85KiaQDNP5tP3QVs74P0eCgRsKEmQBsS209FLC6Pjfsu43S8
         paUkuVNVUZSjBIZ6eDwgMABnN/U/6Jo9h4j8yAILYTQwvaC3REHNvrDnAKQT15aBZUUh
         1kAa/k2Uvm9s2wPaCu9NhN67b6Gd9+WXAAxJpS9NID1cAdIRvv01rZ7w/LeVLtpJrBpi
         LsEGDf50ioTMQj7qrNBPFcd4hj0VLXCxAr45eDDetxWBeSCo6ucdTt5jprdw3cSUiuon
         kx1ismRO02LwKZtJdfis/caBMQd0tDlR2QxLj8mrDTcZSVEWkOURKz27xSAvT0crW30m
         fzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779990108; x=1780594908;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2tns20Jc2qFQBaO3MIIRuCNGNOwNtzQn34pDKtjl1l8=;
        b=sTplIcavoi7+pLvc492muquK8H5nYWDJr3VusPq9foWsVfDbDNdQxMqmyr/X2r4OKX
         w3kZGs+uQ5uZgGcKY+41viy9bNTqi853Dkjj6rESW9xZenuRUMXwILQuYwKHyFwLRMhv
         1Odpjm1RWBcIPTKSlUW9DYuNtJ94KRvMr3Ox0avr8167LO1lTgFyUkNo63treYuQ035S
         Vl3u+Ao2slN9B+MeBrnjrPqCjcRrYUDJi7ZhcOksvHW/wEGRfk5cQvY3MpXk35yq1mPW
         3f9ZWRchde9lG+CJzndIYmQVc4rLZg9a+G+QQJ1oloQ+AEGI/HzrBBjpFjrBw8J1f9kv
         3rkg==
X-Gm-Message-State: AOJu0Yz0DqUiWiG48XRNDej5dYioVgrbcmScQ3oTmSbwQdC/myJ2Ty1m
	W7rgfeXZDPopt6uMAR3QtAOSsncM3kr5kdRVCTrLf/5n4rQm9l1KhUO3zWJTXsCX9GF2hTfpoEU
	w5DvD3r2wr6fxgK+EVeeeuodU7olH0OBKB+zlpMa6EhkU/aVUjAIuhTqXmg9pfdHBf8aOzERxxK
	1mPCZNVQRRTCSxm23cbonaLaeda0P9dTW9hqgQAHQjqEk1l2p9Fy0=
X-Received: from pfbmc49.prod.google.com ([2002:a05:6a00:76b1:b0:82f:a959:4a7f])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1412:b0:81e:ef16:b288 with SMTP id d2e1a72fcca58-8415f37d836mr28903501b3a.22.1779990107456;
 Thu, 28 May 2026 10:41:47 -0700 (PDT)
Date: Thu, 28 May 2026 17:41:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528174140.1921129-1-dmatlack@google.com>
Subject: [PATCH 0/2] liveupdate: Small FLB fixes
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_104149_638777_74AADF9E 
X-CRM114-Status: UNSURE (   9.89  )
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

This series has 2 small fixes to how FLBs are managed. First is to
increase the outgoing FLB refcount during liveupdate_flb_get_outgoing()
so it cannot be freed while the caller is using it, and to align with
the semantics of liveupdate_flb_get_incoming(). The second is to prevent
FLB retrieve() from being called multiple times if the first attempt
fails.

Both of these changes are needed for the correctness of the PCI core
support for Live Update:

  https://lore.kernel.org/linux-pci/20260522202410.3104264-1-dmatlack@google.com/


David Matlack (2):
  liveupdate: Reference count outgoing FLB data
  liveupdate: Remember FLB retrieve() status

 include/linux/liveupdate.h  | 11 +++++++++--
 kernel/liveupdate/luo_flb.c | 20 ++++++++++++++------
 2 files changed, 23 insertions(+), 8 deletions(-)


base-commit: 5428435567cbe06c19914592fc22ca23c9ca1de5
-- 
2.54.0.823.g6e5bcc1fc9-goog


