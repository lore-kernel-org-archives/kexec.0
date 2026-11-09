Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CD2606EE80
	for <kexec@archiver.kernel.org>; Mon,  9 Nov 2026 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=P2kiAEI4;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=BVn6goM5;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=icg2C3zy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=fIXMPIsA/87cWvB95KQ+/8m1Qdamj/60DkL4G69W9RI=; b=P2kiAEI4+dw4JstiJBNSDQGj3l
	Ep9MmwF7/P2k49LOXPoz6m3T77KWIq6XDu5D90HRQsAvt2Io5MMz45nhkMt6nQRsqNGS7a+CPU5Zg
	XeWeihgHyrb7sDaL0bQ7nIZDriNykL0tRMs6HSYGVnzOSitxqdCxaK0sTKMgIiTBcLtND6/dpxdbt
	c1v1Z9nbZEWQMvr+U6CPyXXQinH8synIrIfApbOYFzXyGH5mDD34fONe6v7laRxDDsm6KcZZ0DOwn
	9cfFTI1gQXyLhMfVLMzAjUO+KS9eVcj7u3FdPs2IeEVGXnHWRpWfvMgc2i+A+D9/b4fkgxjzU1bTK
	HGP+3sQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQOXB-00000000geY-2eW5;
	Mon, 09 Nov 2026 12:31:37 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQOX7-00000000gcl-2AVb
	for kexec@lists.infradead.org;
	Mon, 09 Nov 2026 12:31:35 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794227489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fIXMPIsA/87cWvB95KQ+/8m1Qdamj/60DkL4G69W9RI=;
	b=BVn6goM5DdOyungF+KCccmht5x5GkRSV4guGwd3HLRCXTbHqP2RNiBFSjb1lRM13W51iy0
	nY5UzEMxxhDgwT2yZpZWahcO/gFqmk3egT5469koNPX/h3rPNizr+IxKAMVVirbhfly6wZ
	GbApcLMlTK56edrSa23nENBu4lALoN/Ok5UUwxPBZYFgFD7oMltFdIPLKmBFoHAyZIGP0j
	cb4g0qnyjR42YZWtEp19Jh/oUNlIxTbjt+nejaridLx/hizJ/F3Xx4LHIMDbfB8aQOFq+s
	DON4vr114yGTh1Dsj3tBOMazfCEaQiC5hHj1AzT8sR88fGghX5fUPWaOAyaCRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794227489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fIXMPIsA/87cWvB95KQ+/8m1Qdamj/60DkL4G69W9RI=;
	b=icg2C3zy263T42rXs/vcrNrmpaVc6W/Byd9Lrj/krqLWZRCOZgtpnTqaiIvsOkFPEgixus
	tgqbc4XsQzsLndDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Breno Leitao <leitao@debian.org>,
	printk@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Bradley Morgan <include@grrlz.net>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	"Cen Zhang (Microsoft)" <blbllhy@gmail.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	linuxppc-dev@lists.ozlabs.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Bradley Morgan <brads@mainlining.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alessandro Carminati <acarmina@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	kexec@lists.infradead.org,
	Gustavo Luiz Duarte <gustavold@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH printk 0/6] Introduce policies for unsafe flushing
Date: Mon,  9 Nov 2026 13:37:17 +0106
Message-ID: <20261109123127.489676-1-john.ogness@linutronix.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_043133_695217_DD317B0F 
X-CRM114-Status: GOOD (  10.48  )
X-Spam-Score: -3.9 (---)
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
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Until now unsafe flushing is only performed at the very end of
panic(), before entering the infinite loop. For other situations
(such as panic-kexec or panic-reboot or emergency-reboot) no
unsafe flushing is performed. The reasoning for this is because
an unsafe flush could lead to fireworks, which could prevent the
kexec or reboot from occurring.

However, some users may be willing to take on such risks in order
to see panic output. Indeed, for the netconsole (which does not
support safe atomic printing) it is a regression that such unsafe
printing does not occur. [0] 

This series adds unsafe flushing policy flags per-console to
allow individual consoles to perform unsafe flushing for such
scenarios. The unsafe flushing is hard-code-enabled for the
netconsole in patch 6/6. The justification is that this is not
less safe than the legacy netconsole.

Later these policy flags could be easily exposed to userspace
via /sys/class/consoles/, once the sysfs per-console interface
is available.

John Ogness

[0] https://lore.kernel.org/lkml/20260915100140.3631650-1-ryan.roberts@arm.com

John Ogness (6):
  printk: Introduce and specify flush reasons
  console: Introduce unsafe flush policy flags
  printk: Evaluate flush policy in nbcon_allow_unsafe_takeover()
  printk: Remove nbcon_atomic_flush_unsafe()
  printk: Add panic+kexec flush point
  netconsole: Always perform unsafe flushing on panic/kdb/restart

 arch/powerpc/kernel/watchdog.c |   2 +-
 drivers/net/netconsole.c       |   4 ++
 include/linux/console.h        |  37 ++++++++---
 include/linux/printk.h         |  27 ++++++--
 kernel/crash_core.c            |   1 +
 kernel/panic.c                 |   2 +-
 kernel/printk/internal.h       |   4 +-
 kernel/printk/nbcon.c          | 117 ++++++++++++++++++++++-----------
 kernel/printk/printk.c         |  16 ++---
 kernel/reboot.c                |   2 +-
 lib/nmi_backtrace.c            |   2 +-
 11 files changed, 146 insertions(+), 68 deletions(-)


base-commit: d01f86a7da8161aac8c6304b377cf58fb75861ca
-- 
2.47.3


