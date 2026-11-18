Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E00F60A3834
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 23:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=elzJzDjO;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=GWTc4g5k;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=+hgwRrve
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=leI1FFs3wJSFLMy2XFplwoNsj0EC2A+qYx8KybwPYGI=; b=elzJzDjOy59/HfD6l/DLHT19B2
	ogw1BWI0lktFRL/a9yEYZWrUw2Hr8NdmCHiJif+ievycdF0hShLe7j2swrf3NnbHOy4tqd/N08dm0
	KBqabTpWtvVXNK/Pwm5U5zvJDVTDpsvkRURUnYojRfvQw9A7g4HCV8MgAwbF6q7qWrw/+3PIAJ8P2
	v+L9MwBIqJIDkjtvCaqG8MOmgFlKsazJfGMpnHEeC30GpnVpRLCay0ys3Rdpmt2PK1e1Tv5R+hkSA
	oY4Ytm3EqOdeIC2YN3bI97RHm5So3ar1uXp0arbtjgbgYf315KT61dGnC/Tf9Dq25wzNef99M8NO4
	wCxwi+WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToh0-0000000AS3A-2tKJ;
	Wed, 18 Nov 2026 23:03:54 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTogx-0000000AS2U-1ccT
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 23:03:53 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795043026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=leI1FFs3wJSFLMy2XFplwoNsj0EC2A+qYx8KybwPYGI=;
	b=GWTc4g5krJCo/IU3KT4WlFaHCvB8m9M/xw8MeC2cfC1s0cjtUbe5NG8yILU83QC6s3imyx
	/8HCRV9PridoX7WomHLKgFCtV1ZhW5SqYGViN7lYoeOMNFVZQHT92dgzxDbex6gtpTgG4a
	nyObo8wXZsFCBM9Bz0kH7PIW0f1W2bstVPEuznhefzIIViRWPsaffS0ph4Bpppb7Htrg1C
	v/qIrjOKuWGvYqaODtam8QY5oilpxz7PJo93yQSajnFeVtnA9yce5gG9NZS8Za1ZwiB39o
	QCHIumEOh3jg9FvOPWOihVHGNY97xfWeuWe8/jk5+x3Gkee5XUk75Ouu7o8G1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795043026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=leI1FFs3wJSFLMy2XFplwoNsj0EC2A+qYx8KybwPYGI=;
	b=+hgwRrveBfg7slz3C4Vs75suxSJVdS1shAjY/DRaX0xP4hfUqwuXZ3KAMpp7efAl3obEwA
	aK+OVSrV3WC8w2AQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Breno Leitao <leitao@debian.org>,
	printk@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alessandro Carminati <acarmina@redhat.com>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Gal Pressman <gal@nvidia.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Bradley Morgan <include@grrlz.net>,
	Oleg Nesterov <oleg@redhat.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	"Cen Zhang (Microsoft)" <blbllhy@gmail.com>,
	kexec@lists.infradead.org,
	Gustavo Luiz Duarte <gustavold@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH printk v3 0/7] Introduce policies for unsafe flushing
Date: Thu, 19 Nov 2026 00:09:36 +0106
Message-ID: <20261118230345.808560-1-john.ogness@linutronix.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_150351_796532_871B11C5 
X-CRM114-Status: GOOD (  13.64  )
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

v2 is here [0].

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
netconsole in patch 7/7. The justification is that this is not
less safe than the legacy netconsole.

Later these policy flags could be easily exposed to userspace
via /sys/class/consoles/, once the sysfs per-console interface
is available.

For this version I reduced the unsafe flush policies to the
minimum required by the netconsole: panic+restart and
emergency+restart. I also keep nbcon_atomic_flush_unsafe() and
use only this function for specifying the flush reasons. This
allows us to pinpoint where unsafe flushing is evaluated and,
as a nice bonus, to avoid all the legacy madness.

The first 4 patches have no functional changes. Hopefully they
are each small enough that a review is relatively trivial. The
functional changes (5-7) are also compact.

Changes since v2:

- Specify flush reason in nbcon_atomic_flush_unsafe() instead
  of console_flush_on_panic() and printk_trigger_flush(). This
  automatically avoids the need for any legacy handling.

- Remove KDB, PRINTK, NOTHREAD unsafe flush policies. (Not
  needed for now.)

- Add EMERGENCY_RESTART unsafe flush policy to be used for
  emergency_restart() when non-panic.

- Rename console.unsafe_flush_flags to
  console.allow_unsafe_policy.

- Change console_is_usable() to _never_ report
  CON_NBCON_ATOMIC_UNSAFE as usable.

- Introduce nbcon_is_unsafe_usable() as a variant to
  console_is_usable() to report CON_NBCON_ATOMIC_UNSAFE as
  usable. The caller decides if unsafe printing should occur.
  This is only used for nbcon+atomic flushing.

- Perform unsafe flush policy check higher up in
  __nbcon_atomic_flush_pending() instead of
  __nbcon_atomic_flush_pending_con().

John Ogness

[0] https://lore.kernel.org/lkml/20261111181942.593695-1-john.ogness@linutronix.de
[1] https://lore.kernel.org/lkml/20260915100140.3631650-1-ryan.roberts@arm.com

John Ogness (7):
  printk: Introduce and specify flush reasons
  printk: nbcon: Move unsafe takeover check to higher level
  printk: Move unsafe takeover check out of console_is_usable()
  printk: Use @reason instead of global variable to check flush policy
  console: Support unsafe flushing for panic/emergency restarts
  printk: Add unsafe flush points for panic+kexec and emergency_restart
  netconsole: Perform unsafe flushing on panic and emergency restart

 drivers/net/netconsole.c |  2 +
 include/linux/console.h  | 60 ++++++++++++++++++++------
 include/linux/printk.h   | 20 ++++++++-
 kernel/crash_core.c      |  1 +
 kernel/panic.c           |  2 +-
 kernel/printk/nbcon.c    | 91 +++++++++++++++++++++++++++-------------
 kernel/reboot.c          |  1 +
 7 files changed, 131 insertions(+), 46 deletions(-)


base-commit: ef19063ad84f8ed58ee44ebd49ba035fd5159e74
-- 
2.47.3


