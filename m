Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA74F606D835
	for <kexec@archiver.kernel.org>; Mon,  9 Nov 2026 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AwvmaV9B;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=dWCwP9LI;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=TOK70ySp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=QGPGgmuQu2fufOLJfGHUvsRMzAjWcvAMNtZA8gm+nvI=; b=AwvmaV9BoqsXyE
	YJzhErNJRgpxuFpBeVnkr7DqCr9hF9ENIH2JaYAAZ/cbE8VOuEEkUbqqIQ4wHJRuvPj+Hb/cEyiJg
	jFb/uowRwJUYiz2D5ssFKa+F9O4zIX9bG1oinfst9cPfKaVegAafO3hs387CTIjlo9nFDerZ4bRGT
	XXB986n7lJnBTZ9ADW3HPkbmrJQrIHvjjhMwQHet3YmbjmZiWU+Cd+fOJp9+erA9pgILzQ5RdDiCY
	xX+NQlYn3NGKBVcUo2KMn6WqdQUGx9g08UU2a/smWIME1NXOUtOWoS/i4z9BG903QOhamlAy5S3Ss
	x6NgsT/3UkBtaQhJI8KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQOXA-00000000gdz-23ND;
	Mon, 09 Nov 2026 12:31:36 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQOX7-00000000gd2-2Bsl
	for kexec@lists.infradead.org;
	Mon, 09 Nov 2026 12:31:34 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794227492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGPGgmuQu2fufOLJfGHUvsRMzAjWcvAMNtZA8gm+nvI=;
	b=dWCwP9LIP0FfMZO0Sr35ZuGCo+VAH9IXCEV+8Cu5RfqAt+MflGIngtFBsnr/SIABYMIk5x
	tWRBuEhfWoBAIAvtIqFTAlat7UO42/H9F4KmyYU3UnAmWGaKWk9CDjwrPYWp/ZkN0yf0kB
	zesBIuOJHG2WyKNdHbfhU//ExSeNe+oXAnWz5B0gJiPXNyqPsAcU6p4wveuw9vGGeZYooq
	efHJNUhUO2PIImz4irTE9oQepnv95VY/OOVboLqnEZ3nexnFa7T//sGzvykckv9Tlf8vbI
	7S5vvhz1xRZO0iwv6e7ziIbOfXVhVmV6MEMukLDDjyN49UUS/Wpy0Y6re5+csw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794227492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGPGgmuQu2fufOLJfGHUvsRMzAjWcvAMNtZA8gm+nvI=;
	b=TOK70ySpMFiIv8oWkfah1Ca9CjsT7PkF+cx7DzYQGjib/YDAuyeYj5pZ8S9MJ69wF7agG8
	raecUvWJCv16QoDA==
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
Subject: [PATCH printk 5/6] printk: Add panic+kexec flush point
Date: Mon,  9 Nov 2026 13:37:22 +0106
Message-ID: <20261109123127.489676-6-john.ogness@linutronix.de>
In-Reply-To: <20261109123127.489676-1-john.ogness@linutronix.de>
References: <20261109123127.489676-1-john.ogness@linutronix.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_043133_698038_25693974 
X-CRM114-Status: UNSURE (   7.10  )
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


