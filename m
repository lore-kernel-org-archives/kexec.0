Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE30606A6A1
	for <kexec@archiver.kernel.org>; Sat, 21 Nov 2026 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=g9Vjnq1j;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=BCL39XsV;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=0iwsuRgQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=gsY52QypeM8c+C0yp8+SKsiWC6bxLPvGiy93DlD6Rc8=; b=g9Vjnq1jeI8b0OeFzwIEd4mOl3
	jNc8TbZwJsNmaD36qCuSQBhvoG4OLiQgX1WjIX7XHffBqFFvxGN+XDkIVSOxCAEoYIke067TZ9vX5
	9WqiGju6BVqsNgqmxOSJnIGyCRV5BLP47JOF7aBhDEbcfrjLJ/KI3qmdaFi8ku8Hw/LYlqW0NIMBK
	zdgpxWCnVQR34RSzeoghBHdOzx2UsWbeHnW8KqcA8qfWLbJaAVzglXSb+hx4F5nyjkRNWbgsobIj5
	uI+h9InGHa0F6l7x5Nd3eK2p6HUkIhPKCntb40zZ00qeEKnDI71aht9pKJRemF6mDVI7/CdsFGa3+
	YCjrgZnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUo4U-0000000HUx2-22oM;
	Sat, 21 Nov 2026 16:36:14 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUo4J-0000000HUvh-1v5O
	for kexec@lists.infradead.org;
	Sat, 21 Nov 2026 16:36:12 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795278959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gsY52QypeM8c+C0yp8+SKsiWC6bxLPvGiy93DlD6Rc8=;
	b=BCL39XsVRlrz6KdxJFHHebR55BJvQHoCt8ZxPc7K8/ttdBwSNTGCtlptjA1cW4BY0+wBj4
	RH3WLbAaHmM0H+2IWsKQLwMcfFUzA6JTDaNt1T4rz01Ts6WJzvfd4Jp3POKAPsertmLMRM
	tzkAS+Hp3MRejMVTPR7dq4F2uwEdJiRQLcw4h3GZM5cxk5FJ8f9CrM+Fa49IHe/1hd9UWl
	zovlcNHQyrda5Ck/Kmhlmymz+vNuccTIuAJ+4mMVYWU+8YseGXDKwBNtZT4AWGHRvUSP5M
	zCM6eiVmVszGQdEr3HHzvsin4z6Blo74uU5/QX2ZdrxPsyrwKvzDn/ijzTq4/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795278959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gsY52QypeM8c+C0yp8+SKsiWC6bxLPvGiy93DlD6Rc8=;
	b=0iwsuRgQbQpmYxaVF/OaVWMavCV4vkXiwwuaaTU6NvadceOzaAC4RhVgvi9Bx+KiHBoRIo
	2JY6r0MKGTTfSzBQ==
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bradley Morgan <brads@mainlining.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Alessandro Carminati <acarmina@redhat.com>,
	Gal Pressman <gal@nvidia.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Bradley Morgan <include@grrlz.net>,
	Alex Elder <elder@riscstar.com>,
	"Cen Zhang (Microsoft)" <blbllhy@gmail.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	kexec@lists.infradead.org,
	Gustavo Luiz Duarte <gustavold@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH printk v4 0/8] Introduce policies for unsafe flushing
Date: Sat, 21 Nov 2026 17:41:48 +0106
Message-ID: <20261121163557.963029-1-john.ogness@linutronix.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261121_083603_686234_45A46B90 
X-CRM114-Status: GOOD (  11.59  )
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

v3 is here [0].

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
netconsole in patch 8/8. The justification is that this is not
less safe than the legacy netconsole.

Later these policy flags could be easily exposed to userspace
via /sys/class/consoles/, once the sysfs per-console interface
is available.

The first 5 patches have no functional changes.

Changes since v3:

- Restore WARN for non-panic hostile takeover attempts and
  expand the comment so I don't attempt this again.

- Rename nbcon_allow_unsafe_takeover() to nbcon_allow_unsafe()
  because it now allows general unsafe usage and not
  specifically hostile takeovers.

- In __nbcon_atomic_flush_pending(), additionally use
  panic_on_this_cpu() to determine if a hostile takeover is
  allowed.

John Ogness

[0] https://lore.kernel.org/lkml/20261118230345.808560-1-john.ogness@linutronix.de
[1] https://lore.kernel.org/lkml/20260915100140.3631650-1-ryan.roberts@arm.com

John Ogness (8):
  printk: Introduce and specify flush reasons
  printk: nbcon: Move unsafe takeover check to higher level
  printk: Move unsafe takeover check out of console_is_usable()
  printk: nbcon: Use @reason instead of global variable to check flush
    policy
  printk: nbcon: Expand unsafe takeover check for general unsafe
  console: Support unsafe flushing for panic/emergency restarts
  printk: Add unsafe flush points for panic+kexec and emergency_restart
  netconsole: Perform unsafe flushing on panic and emergency restart

 drivers/net/netconsole.c |   2 +
 include/linux/console.h  |  60 +++++++++++++++++-----
 include/linux/printk.h   |  20 +++++++-
 kernel/crash_core.c      |   1 +
 kernel/panic.c           |   2 +-
 kernel/printk/nbcon.c    | 105 ++++++++++++++++++++++++++++-----------
 kernel/reboot.c          |   1 +
 7 files changed, 147 insertions(+), 44 deletions(-)


base-commit: 52904cd86a5f8c83fd956d1b2b9cd12593597e7b
-- 
2.47.3


