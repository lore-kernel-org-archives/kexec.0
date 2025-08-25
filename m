Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C71CA1007
	for <kexec@archiver.kernel.org>; Sat, 30 Aug 2025 17:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hEDXk3YI1ppq8XrZvysREbE40c1EqMSzH1Ycau0V0x0=; b=eVd4nLmfqHkBCLuMyigLBFvKct
	ZUK4AB2qsUWkx4dS5Y1wuSv+SEqMELuHo4NIBiQcMtoAkeYkRXxc45btmgfynhYDDgcEJuOhZAM6n
	D42NcGiEqnMypCj8bTUtreoJP5JNa4mHflwK1mhx+ezu2DaCYyQX8Vd4MpoJMqodhLLB2wclq0XxG
	iU/VYU4gtLUf99rv/6SYsLK5Pn1Py3Q4RQp0pWYuZauNTspkjtYpIuPC4HnklfqhE3HDh/TIch9Mj
	iMx8AInZL9f2/yuyPD+8ntKaqJOdgAzulKRA9fjuHkz1dqkWpHKkmi/enbLldi4r1m+BpstHG5xjU
	iYWwAMtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usPgA-00000008G7q-1cKL;
	Sat, 30 Aug 2025 17:47:54 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqMzx-00000006kEa-1RfY
	for kexec@lists.infradead.org;
	Mon, 25 Aug 2025 02:31:54 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-24458272c00so44575705ad.3
        for <kexec@lists.infradead.org>; Sun, 24 Aug 2025 19:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756089112; x=1756693912; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hEDXk3YI1ppq8XrZvysREbE40c1EqMSzH1Ycau0V0x0=;
        b=CHDiFh3Q/j09sEQa9sf270Ua9lyhw8LICOLjyNLcHPfTcerbu1IzhXmOCnW1DxXE/o
         0QbKoHCSMEnp4Xot4+Qkj3N8A/u60OWpAGDO5+nceJbHox3MfT3YTZAm0O9JbrpetQKA
         GCBnX6XI6+mYqrO1ezBlRJwrzqx5RMXjBBPueUaCPsEgP72zV3i4G+Xp6I16THE+CaDu
         8XRzOqvxOvhhED1HvN141WFtOShTh1uxmWA9PZPPNqmkq/85Wjv7TL94rad2EnXcZd+c
         B5u3rJ/+xrs1kmoTYzSMgZSMp295rCY0b4yO39Xs1baqySOSDGP30ZwrwF4SYkA9JX2a
         88ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756089112; x=1756693912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEDXk3YI1ppq8XrZvysREbE40c1EqMSzH1Ycau0V0x0=;
        b=lRKHB1p/zibf/lhU/fc/j4p5v0Dy/oWOymhbL2drKkQTbrkRbvaf+njF39agZVleqb
         58nyuOMZjMA4KxAcVjkbAXnI3Px2OXroo3yYgaA/iINNVr5Q+rRusoLcCQppAuaUaLbu
         Ubq4Ev23ReSJtsDrZv5wbgtFaOwBOCXvcqQg8bZEM/fX19doYlDCReFtDP81MBZmvwGE
         URVng4zedvkgPIRnqO9KVsUstD5EAzY7nubIYy3a4jwUc8nEdV45wS+CmvO16Swx0OtS
         z1e/sk+/8rcKX9SNLszD6x5Q9SXJOyiUu28do6VNTlT03l+++OJYt0m8P/uRLkJ81d0u
         3X/g==
X-Forwarded-Encrypted: i=1; AJvYcCVwhKJ956eAfofbnK1nJtbqLk5SnnMnXD+gzurQQLueUMz1CnAaOzRWrpW+TtgYPge3tYmctg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwFEDn/7uvdI49lV17Lllmjf6rZP011FJgmGZnQrd6POkCoruOY
	cquJTGw8HNpDg0nxzvm+wDRHzPL6BXHdQwh/y3Jnzv884Bw65xxM4FXM
X-Gm-Gg: ASbGncv1KsfgGtAfipWWKhVF6qbLmCYjktrI90rW5J7SP8kjL66YCThGk2sYQwTgCSD
	p5jvjxT+n2Jqbt82x5yaFF7T6l69sD6e0NKDZCfhD2qFA1ShAqHt6PRV6mhMUxPr2gi9SnauyQ2
	6mP7p00g9/e5UnDprVHJSZyBlfL4F9cio0h/u4WMEY8vQQP8dkv2pEK+OCnF+CDfWiDYfmguw1j
	9t4vKuJLZSa/WyF193BWIXP7HxMTeMAmMn8r4Ku9wfV4e9SyD8BIKFwepsd/fDVLz/WHjyUbFE7
	9uZasHvfmEyg9UnzcK8yJrGOk7c7wPXv9dMNpWxLi4bBuc/NBbwC3BbM9j4M8PoQqcBEmph4tmU
	ILYBtbGSkFzXqGUCH5wmR+4cR5IyiS+SrBiJ5eCumqq5ASQQ7/gLPocFpY61B59/jr89AkE8ws5
	o=
X-Google-Smtp-Source: AGHT+IGvyPlqdqig4mXFsHmtjBV9YF8gxzZSDkAdZlQGY1e3N0SakBpd1QLytsyfS5huP+/UcwJ3nw==
X-Received: by 2002:a17:903:238e:b0:240:50ef:2f00 with SMTP id d9443c01a7336-2462eea80fbmr165661135ad.26.1756089112460;
        Sun, 24 Aug 2025 19:31:52 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af234sm53905175ad.48.2025.08.24.19.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 19:31:51 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Qianqiang Liu <qianqiang.liu@163.com>,
	Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Shixiong Ou <oushixiong@kylinos.cn>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Zsolt Kajtar <soci@c64.rulez.org>,
	Ingo Molnar <mingo@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Joel Granados <joel.granados@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Sravan Kumar Gundu <sravankumarlpu@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Max Kellermann <max.kellermann@ionos.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Luo Gengkun <luogengkun@huaweicloud.com>,
	Li Huafei <lihuafei1@huawei.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	kexec@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] panic/printk: replace other_cpu_in_panic() with panic_on_other_cpu()
Date: Mon, 25 Aug 2025 10:29:36 +0800
Message-ID: <20250825022947.1596226-9-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825022947.1596226-1-wangjinchao600@gmail.com>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250824_193153_383257_8FDBF94E 
X-CRM114-Status: GOOD (  19.79  )
X-Mailman-Approved-At: Sat, 30 Aug 2025 10:29:56 -0700
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

The helper other_cpu_in_panic() duplicated logic already provided by
panic_on_other_cpu().

Remove other_cpu_in_panic() and update all users to call
panic_on_other_cpu() instead.

This removes redundant code and makes panic handling consistent.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/printk/internal.h |  1 -
 kernel/printk/nbcon.c    |  8 ++++----
 kernel/printk/printk.c   | 19 ++++---------------
 3 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index ef282001f200..f72bbfa266d6 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -332,7 +332,6 @@ struct printk_message {
 	unsigned long		dropped;
 };
 
-bool other_cpu_in_panic(void);
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 			     bool is_extended, bool may_supress);
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index c6d1a4a747e9..171480135830 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -255,7 +255,7 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
 		 * opportunity to perform any necessary cleanup if they were
 		 * interrupted by the panic CPU while printing.
 		 */
-		if (other_cpu_in_panic() &&
+		if (panic_on_other_cpu() &&
 		    (!is_reacquire || cur->unsafe_takeover)) {
 			return -EPERM;
 		}
@@ -310,7 +310,7 @@ static bool nbcon_waiter_matches(struct nbcon_state *cur, int expected_prio)
 	 * Event #2 implies the new context is PANIC.
 	 * Event #3 occurs when panic() has flushed the console.
 	 * Event #4 occurs when a non-panic CPU reacquires.
-	 * Event #5 is not possible due to the other_cpu_in_panic() check
+	 * Event #5 is not possible due to the panic_on_other_cpu() check
 	 *          in nbcon_context_try_acquire_handover().
 	 */
 
@@ -349,7 +349,7 @@ static int nbcon_context_try_acquire_requested(struct nbcon_context *ctxt,
 	struct nbcon_state new;
 
 	/* Note that the caller must still remove the request! */
-	if (other_cpu_in_panic())
+	if (panic_on_other_cpu())
 		return -EPERM;
 
 	/*
@@ -447,7 +447,7 @@ static int nbcon_context_try_acquire_handover(struct nbcon_context *ctxt,
 	 * nbcon_waiter_matches(). In particular, the assumption that
 	 * lower priorities are ignored during panic.
 	 */
-	if (other_cpu_in_panic())
+	if (panic_on_other_cpu())
 		return -EPERM;
 
 	/* Handover is not possible on the same CPU. */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index faa8b1f0585b..236f03937107 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -346,17 +346,6 @@ static void __up_console_sem(unsigned long ip)
 }
 #define up_console_sem() __up_console_sem(_RET_IP_)
 
-/*
- * Return true if a panic is in progress on a remote CPU.
- *
- * On true, the local CPU should immediately release any printing resources
- * that may be needed by the panic CPU.
- */
-bool other_cpu_in_panic(void)
-{
-	return (panic_in_progress() && !panic_on_this_cpu());
-}
-
 /*
  * This is used for debugging the mess that is the VT code by
  * keeping track if we have the console semaphore held. It's
@@ -2391,7 +2380,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	 * non-panic CPUs are generating any messages, they will be
 	 * silently dropped.
 	 */
-	if (other_cpu_in_panic() &&
+	if (panic_on_other_cpu() &&
 	    !debug_non_panic_cpus &&
 	    !panic_triggering_all_cpu_backtrace)
 		return 0;
@@ -2827,7 +2816,7 @@ void console_lock(void)
 	might_sleep();
 
 	/* On panic, the console_lock must be left to the panic cpu. */
-	while (other_cpu_in_panic())
+	while (panic_on_other_cpu())
 		msleep(1000);
 
 	down_console_sem();
@@ -2847,7 +2836,7 @@ EXPORT_SYMBOL(console_lock);
 int console_trylock(void)
 {
 	/* On panic, the console_lock must be left to the panic cpu. */
-	if (other_cpu_in_panic())
+	if (panic_on_other_cpu())
 		return 0;
 	if (down_trylock_console_sem())
 		return 0;
@@ -3227,7 +3216,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 			any_progress = true;
 
 			/* Allow panic_cpu to take over the consoles safely. */
-			if (other_cpu_in_panic())
+			if (panic_on_other_cpu())
 				goto abandon;
 
 			if (do_cond_resched)
-- 
2.43.0


