Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DD3606C14B
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lHdmfHZt;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=QBt0qep0;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=iIhaDXlt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=QGPGgmuQu2fufOLJfGHUvsRMzAjWcvAMNtZA8gm+nvI=; b=lHdmfHZt7uvtOc
	20+1B0Nm/jJnBablwaTiocT/fcZDNYpQxlOQkYLuuzSzMWce+PobVTEALgwOQOByhT1f9Fm7D+O1l
	Wb8DR7LDcqQfrMQKARqX4PwKy6oPmX+S1zxGAD+zMpKiKBLH7nm7IQHK1//2Xs9xqwpCyXwsxtRIu
	NfI6I0MesdeDjxhew0nqio2p70k2Y9hZjYD/e12dlfeG8AiGOYX8MfuTTzhwDDfOYcmZ43sqcG+EF
	PNgVr+7e9TIL5x0gBI5+G8m4AL90NHN5yPGZH7sMlHwfH9KuwywJ9K+u9HHudPINL/+N/Ku6Lrv6B
	Uq47aSE7DG8HpLS2BHAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRCvK-00000007O3N-1hM4;
	Wed, 11 Nov 2026 18:19:54 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRCvF-00000007O1A-3GaO
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 18:19:51 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794421187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGPGgmuQu2fufOLJfGHUvsRMzAjWcvAMNtZA8gm+nvI=;
	b=QBt0qep0KaZaK1m8yU1ZmzaDfPE9YDMX2zsTTb9XauAlI04CnnhJgcabnb2L8h2as+50hE
	pXwJEPklkUXrdDEK8apt/q2n9LSv20XMK1YCmtrJGngtDJ2Yg8SEeLBKmE1zrnQc6PcNqo
	Da3eaonLeIBUVxUX44T/rBM1yYWlr0Rm+ECzA+IDJ6zmJ9bVDqhM030x/2qM643yXG8pyG
	LiogVCai/jSmBzBVmYtsXxfVlWNjjYVf7jSSPVC3xEYLF6OdAOgec0Qwf4qleajZeuGi4H
	jTd9pwUbQwbu6G7ZOgxYS3sscnBaAzWdSIUcnv8SZs6oROovzpDpdtGJ0pi76Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794421187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGPGgmuQu2fufOLJfGHUvsRMzAjWcvAMNtZA8gm+nvI=;
	b=iIhaDXltg9sgD4xI3Yb8DaG0/kXGpDC6XhejljfNSBdorzysTOaVh9z8cAdb8VHfy1tvTX
	wsrlDcWHjztRfeAA==
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
	kexec@lists.infradead.org
Subject: [PATCH printk v2 5/6] printk: Add panic+kexec flush point
Date: Wed, 11 Nov 2026 19:25:21 +0106
Message-ID: <20261111181942.593695-6-john.ogness@linutronix.de>
In-Reply-To: <20261111181942.593695-1-john.ogness@linutronix.de>
References: <20261111181942.593695-1-john.ogness@linutronix.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_101949_955084_D4C9FC01 
X-CRM114-Status: UNSURE (   6.62  )
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

During panic, nbcon consoles transition to atomic printing. However,
there are consoles that do not support safe atomic printing
(CON_NBCON_ATOMIC_UNSAFE). Such consoles will only flush during
panic if their unsafe flush policy allows them to do so.

The unsafe flush policy NBCON_PANIC_FLUSH only allows unsafe
flushing when particular flushes are explicitly invoked. Call
printk_trigger_flush(PR_FLUSH_RESTART) before performing the kexec
in order to give such consoles a chance to perform an unsafe flush.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/crash_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index d0bd2d0cf8990..064b0af903c38 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -140,6 +140,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
 
 			crash_setup_regs(&fixed_regs, regs);
 			crash_save_vmcoreinfo();
+			printk_trigger_flush(PR_FLUSH_RESTART);
 			machine_crash_shutdown(&fixed_regs);
 			crash_cma_clear_pending_dma();
 			machine_kexec(kexec_crash_image);
-- 
2.47.3


