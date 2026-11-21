Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E50606A331
	for <kexec@archiver.kernel.org>; Sat, 21 Nov 2026 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QD7s3FOZ;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=nQ8KiLDX;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=D/S1Z6+c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=pIeG/X/94duY8UPmUKyn4l6H/vTS0d4bIEK2ndG/QD4=; b=QD7s3FOZrXCtgU
	Bf2PiHjOqIBHYIHfxoQ8R+Vw7IBUbi9OR8AHZ2eTuV1yMpipAfDVMBQFdcITUmerY+WqcQ/I7ZGQc
	Hn0uoTHW/DHBjMNbcc7MB0xZkr68uGcdI/UwQXbQEfs5isfPe1xl+Rv7UbXZt8mEVSip6yhsbmYah
	ZPwshrKsg54YsgfoW/GGwGg5pEIsmvMkS/pwWhtleONuyEjGYJYc5Z1YOkcrvc4WwIAKGYVFtvMMT
	7BaSWNXqe8EcQf0e8DzTEZlCd1b67YEhwgn5DeQ+VIQN7Os0q0EEhyX52WKCJ/HIp0ggruHILP4zQ
	Omw0se501vW2h06OsLfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUo4U-0000000HUx9-2NDx;
	Sat, 21 Nov 2026 16:36:14 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUo4M-0000000HUwF-1ajQ
	for kexec@lists.infradead.org;
	Sat, 21 Nov 2026 16:36:12 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795278964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pIeG/X/94duY8UPmUKyn4l6H/vTS0d4bIEK2ndG/QD4=;
	b=nQ8KiLDX3s7hSKwLICbB9eHjqBQk4po22YSK4jlZNPGTbC+Esz0H2dk33AFaV1wHhCbYhx
	eyd0/CzTjtT9kg0mydTvRn1zmouMFY1P723dJ0cZifux29PUIvAvnqreWB6vXYild2vPVS
	/tHVeLscsEbSh9v3lYmMTZb1wwR9IiTVh5QlUMiTuIIM4Eb4f2/vvQEXBc2tNEUdt29rfk
	NoqQxj0wyh68jfa1H/sO/FXDaMugILEYzVc6G6qJ0C0l3KZYMO+02JgZzp49DuQvV6O0f7
	zbIwm3VlO2wdWK2CHaSOIe56Sdm0TR1Zq6teYxtzy9sq95Ug3xGI+6wMhhhjzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795278964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pIeG/X/94duY8UPmUKyn4l6H/vTS0d4bIEK2ndG/QD4=;
	b=D/S1Z6+c9PxhC8o2n1gU5fmCQqLoUYz1+XNoo9grVzlE3fv+IyQiHf3zjO5FUTdfJQ/tH8
	D+OjVtJfsRvK3EBw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Breno Leitao <leitao@debian.org>,
	printk@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
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
	kexec@lists.infradead.org
Subject: [PATCH printk v4 7/8] printk: Add unsafe flush points for panic+kexec and emergency_restart
Date: Sat, 21 Nov 2026 17:41:55 +0106
Message-ID: <20261121163557.963029-8-john.ogness@linutronix.de>
In-Reply-To: <20261121163557.963029-1-john.ogness@linutronix.de>
References: <20261121163557.963029-1-john.ogness@linutronix.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261121_083609_507332_4CA02CC5 
X-CRM114-Status: UNSURE (   7.70  )
X-CRM114-Notice: Please train this message.
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
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

During emergency and panic, nbcon consoles transition to atomic printing.
However, there are consoles that do not support safe atomic printing
(CON_NBCON_ATOMIC_UNSAFE). Such consoles will only flush when an unsafe
flush is explicitly invoked and their unsafe policy permits unsafe
flushing for that context.

Call nbcon_atomic_flush_unsafe(PR_FLUSH_RESTART) before performing kexec
and emergency restarts in order to allow such consoles to perform an
unsafe flush (if their unsafe policy permits).

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/crash_core.c | 1 +
 kernel/reboot.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index d0bd2d0cf8990..79a67956743ac 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -140,6 +140,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
 
 			crash_setup_regs(&fixed_regs, regs);
 			crash_save_vmcoreinfo();
+			nbcon_atomic_flush_unsafe(PR_FLUSH_RESTART);
 			machine_crash_shutdown(&fixed_regs);
 			crash_cma_clear_pending_dma();
 			machine_kexec(kexec_crash_image);
diff --git a/kernel/reboot.c b/kernel/reboot.c
index a93c23b9e1948..b26d131c54151 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -102,6 +102,7 @@ void emergency_restart(void)
 	 */
 	nbcon_cpu_emergency_enter();
 	printk_trigger_flush();
+	nbcon_atomic_flush_unsafe(PR_FLUSH_RESTART);
 
 	machine_emergency_restart();
 }
-- 
2.47.3


