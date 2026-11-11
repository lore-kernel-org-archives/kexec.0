Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1467C60A260F
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BxulU0ud;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rXyV+V8m;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=67f/wVrW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=miHmWkTPhUcAEvpsJtGNKtqPm0O9WXg4DLHkHhO3x30=; b=BxulU0udfq6At954sXVllROf6Z
	qjEOuD+LRuHzkM8gJ+l/QR+YPjerNKZhpAY0NOptB8VG1eExM8yye0BS1EUjd+QUgb7hf54u+Bvyv
	XXjvg8yTpP3up8JCFSsGcBHoiqfl3ihlTq5uPibMIeivBQHklLBKPyzqTVWwrP3a3Iu8Fwpk2n5Ky
	7kgtz2yB4Lhr3EHD0KolB1hcyRRysryl6MbooMRmnNBh/BXNtRGs/jPDPwv2FDDx31v1z9+FlX/2h
	hcRumSKbfLrrciJmrxqnCKp4q8Ae4CmAoYtcqpoQ68DUt26hpOrVP2nHPAaUyOalLA3MPKt5W6jBx
	ugQl9aOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRCvH-00000007O1x-19ze;
	Wed, 11 Nov 2026 18:19:51 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRCvE-00000007O10-0aHb
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 18:19:50 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794421184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=miHmWkTPhUcAEvpsJtGNKtqPm0O9WXg4DLHkHhO3x30=;
	b=rXyV+V8mB3WGQYt0D1cbKm+3TdQH5P7EkBB0BuarwzijqP3FTDgXeDtU+702Qha3Vjesjd
	ZOM+Cs2Cjqf95W9HPfwGmTijj2qXHfWvu2anJBtqLqoaWKO9FjvL7fGv6zbAmkaqKvsvsQ
	RLNM7MfGFGooJ30UY9ORSGfoi0Y4Pd/bLfBvxxCuZ0XnCWN6lhknFqGFfTdjfbjgodCXyL
	9khOfeXGPBb8Che0NlD4shfupUeTEen9ahuAZgPlfkyLNV7YY0wetUpUm0wM8itMWW7+PD
	8f+X28nEXLQlCNh1FQ2LsARwu+5HxRkTrDJVnz2voRACc/e1f7hBk3Crxa9Caw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794421184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=miHmWkTPhUcAEvpsJtGNKtqPm0O9WXg4DLHkHhO3x30=;
	b=67f/wVrWqykxVxVPvO3YPpqenX7yBp2KyE+jBcUbzvEX+HrwwBjv1vgxB6QxoqLtZqXPOF
	cVUFfC/MqkcyEyAw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Breno Leitao <leitao@debian.org>,
	printk@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Gal Pressman <gal@nvidia.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Oleg Nesterov <oleg@redhat.com>,
	"Cen Zhang (Microsoft)" <blbllhy@gmail.com>,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	kgdb-bugreport@lists.sourceforge.net,
	Randy Dunlap <rdunlap@infradead.org>,
	Alessandro Carminati <acarmina@redhat.com>,
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
Subject: [PATCH printk v2 0/6] Introduce policies for unsafe flushing
Date: Wed, 11 Nov 2026 19:25:16 +0106
Message-ID: <20261111181942.593695-1-john.ogness@linutronix.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_101948_490043_4AF9D22F 
X-CRM114-Status: GOOD (  12.18  )
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

v1 is here [0].

Until now unsafe flushing is only performed at the very end of
panic(), before entering the infinite loop. For other situations
(such as panic-kexec or panic-reboot or emergency-reboot) no
unsafe flushing is performed. The reasoning for this is because
an unsafe flush could lead to fireworks, which could prevent the
kexec or reboot from occurring.

However, some users may be willing to take on such risks in order
to see panic output. Indeed, for the netconsole (which does not
support safe atomic printing) it is a regression that such unsafe
printing does not occur. [1] 

This series adds unsafe flushing policy flags per-console to
allow individual consoles to perform unsafe flushing for such
scenarios. The unsafe flushing is hard-code-enabled for the
netconsole in patch 6/6. The justification is that this is not
less safe than the legacy netconsole.

Later these policy flags could be easily exposed to userspace
via /sys/class/consoles/, once the sysfs per-console interface
is available.

Changes since v1:

- Make console.unsafe_flush_flags unsigned.

- Add missing kerneldoc description for printk_trigger_flush().

- Remove the WARN_ON_ONCE() in
  nbcon_context_try_acquire_hostile() since hostile takeovers
  are now possible from non-panic contexts.

- Also provide a flush reason for console_flush_on_panic().

- Add a global variable @legacy_flush_reason to track reason
  for legacy flushing.

- Explicitly set PR_FLUSH_RUNTIME to 0 since it is now used to
  initialize @legacy_flush_reason.

- Temporarily set @legacy_flush_reason during legacy flushing
  of console_flush_on_panic() and printk_trigger_flush().

- Also set/check ctxt->allow_unsafe_takeover in
  nbcon_legacy_emit_next_record() to enforce flush policies
  for legacy flushing.

John Ogness

[0] https://lore.kernel.org/lkml/20261109123127.489676-1-john.ogness@linutronix.de
[1] https://lore.kernel.org/lkml/20260915100140.3631650-1-ryan.roberts@arm.com

John Ogness (6):
  printk: Introduce and specify flush reasons
  console: Introduce unsafe flush policy flags
  printk: Evaluate flush policy in nbcon_allow_unsafe_takeover()
  printk: Remove nbcon_atomic_flush_unsafe()
  printk: Add panic+kexec flush point
  netconsole: Always perform unsafe flushing on panic/kdb/restart

 arch/loongarch/kernel/reset.c  |   2 +-
 arch/powerpc/kernel/traps.c    |   2 +-
 arch/powerpc/kernel/watchdog.c |   2 +-
 drivers/net/netconsole.c       |   4 +
 include/linux/console.h        |  39 +++++++---
 include/linux/printk.h         |  27 +++++--
 kernel/crash_core.c            |   1 +
 kernel/debug/debug_core.c      |   2 +-
 kernel/panic.c                 |   8 +-
 kernel/printk/internal.h       |   5 +-
 kernel/printk/nbcon.c          | 129 ++++++++++++++++++++++-----------
 kernel/printk/printk.c         |  38 +++++++---
 kernel/reboot.c                |   2 +-
 lib/nmi_backtrace.c            |   2 +-
 14 files changed, 181 insertions(+), 82 deletions(-)


base-commit: d01f86a7da8161aac8c6304b377cf58fb75861ca
-- 
2.47.3


