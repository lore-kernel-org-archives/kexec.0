Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF5DCD6E60
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 15:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UVuqg44DqjC3e/SQPK/tkU683sZS0aLJie25Af2tmn8=; b=l2AKMcOOnjgG1Ov+3fFaOgq0fw
	hmlleTgMVmTD7Bfr7apQ9BnKc/FR7eexnxp8gnvScmCYLBDGZEsLji8qDnftFtk7ZMNnAUoKdR0Ex
	r2mxxuZyha9SSD3hNXQ50SlLYkpy3stHaJ95aLNItAEfTK/M/TsmV1kX2czeR/XNucU0j7cwb4MS6
	+s1ZR4D14C44gSrR9UdMW5Yu2ZjCDchWNobFfqDA/R5PJhJ3vI295mD/NafIwvttcRNpOYLSauopy
	p7TG5IITJJvtV9aleXYqA6GH5ts/eLAseHRDNEz2XNrTfb1sYTbXiFOOlOJ7aHzzLn/pKqj7BOqeP
	oDZYpRMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUQrh-0000000DIDN-2A2M;
	Tue, 02 Jun 2026 15:17:13 +0000
Received: from [111.201.25.229] (helo=gmail.com)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRClb-0000000FMOq-0kum
	for kexec@lists.infradead.org;
	Sun, 24 May 2026 17:37:36 +0000
From: Yifei Chu <yifeichu24@gmail.com>
To: kexec@lists.infradead.org
Subject: [BUG] liveupdate/memfd: duplicate memfd preserve restores same KHO folio twice
Date: Mon, 25 May 2026 01:31:39 +0800
Message-ID: <177964389908.73725.16571980458640176052@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260524_103735_387855_1582CB60 
X-CRM114-Status: UNSURE (   6.61  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Tue, 02 Jun 2026 08:17:10 -0700
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

Hello,

Resending this to kexec@lists.infradead.org in plain text only. The
previous copy to this list was rejected because it was sent as HTML mail.
The original report was also sent to the liveupdate maintainers,
linux-kernel, linux-mm, and the related reviewers.

Short version: I found that the same memfd can be preserved more than once
in a single liveupdate session under different tokens. After kexec, those
tokens can both refer to the same preserved KHO folio, and the second
restore path hits kho_restore_page(). With panic_on_warn=1, this is a
reproducible panic.

The core issue seems to be that mm/memfd_luo.c records the same underlying
folio PFNs for each preserved token, while KHO page preservation is one-shot
state rather than reference-counted ownership.

I reproduced two variants.

Variant A: duplicate preserve, retrieve both tokens

  1. Create one liveupdate session.
  2. Create one 4 KiB memfd and write a marker.
  3. Call LIVEUPDATE_SESSION_PRESERVE_FD twice for the same memfd with two
     distinct tokens.
  4. Keep the session fd alive across kexec.
  5. In the second kernel, retrieve token A successfully.
  6. Retrieve token B, which attempts to restore the same KHO folio again.

Observed result:

  [stage2] token A marker='duplicate-preserve-marker'
  [stage2] retrieving token B should hit duplicate KHO folio restore
  WARNING: kernel/liveupdate/kexec_handover.c:256 at kho_restore_page+0x11e/0x280
  memfd_luo_retrieve+0x1aa/0x490
  luo_session_retrieve_fd+0x73/0x130
  Kernel panic - not syncing: kernel: panic_on_warn set ...

Variant B: duplicate preserve, FINISH an unretrieved session

  1. Preserve the same memfd twice under different tokens.
  2. Kexec into the second kernel.
  3. Retrieve the session but do not retrieve individual fds.
  4. Call LIVEUPDATE_SESSION_FINISH.

Observed result:

  [stage2] finishing session should hit duplicate KHO restore
  WARNING: kernel/liveupdate/kexec_handover.c:256 at kho_restore_page+0x11e/0x280
  memfd_luo_finish+0x10f/0x190
  luo_session_finish+0x31/0xa0
  Kernel panic - not syncing: kernel: panic_on_warn set ...

Tested environment:

  Linux version 7.0.9, x86_64 QEMU
  gcc 12.3.0, GNU ld 2.38
  CONFIG_LIVEUPDATE=y
  CONFIG_LIVEUPDATE_MEMFD=y
  CONFIG_KEXEC_HANDOVER=y
  CONFIG_KASAN=y in the tested config
  Boot args included: kho=on liveupdate=on panic_on_warn=1

My read is that duplicate preservation of the same underlying memfd/inode
should either be rejected within a session, or KHO preserved-page ownership
would need reference-counted semantics so duplicate logical owners cannot
independently consume the same physical folio.

The full report artifacts are available and were included with the original
mail sent to the other recipients:

  liveupdate_duplicate_memfd_warn_panic.tar.gz

It contains both PoC directories, full QEMU serial logs, kernel configs, and
README files. I can resend the artifacts in plain-text-friendly form if that
is preferred.

I reproduced the panics on the 7.0.9 QEMU build above. I also checked current
mainline mm/memfd_luo.c for an obvious duplicate-preserve guard, but I have
not yet runtime-tested current mainline.

Thanks,
Chuyifei

