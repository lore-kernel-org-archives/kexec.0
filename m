Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C4ACA1003
	for <kexec@archiver.kernel.org>; Sat, 30 Aug 2025 17:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D22H5WgHrRDr6Rs9uj/QpBbAQMcw3KfQsKqL222d6ec=; b=a4Z/3JwItRJti6uDySl9mWv6Qu
	cJPumg7ylo70p9YcxYQzCqeXcD8i29l3M3L2EEDF6FlUUm9iOfI2qq2nt5H4jw2O8AAyxFMeAQMRm
	C6yZY0SJkDzx6p5J5m8SX4zGCxdytF0+NL4ySbZUHz0zqtD6p6Y0cna72APkxcIMJS2jasszG2d0s
	DvL6t6MMmS6QCMSPjSbL2EFsISclwbflobnaJN5EVSer1IwHT90sW9KVDbwnUqtnJ/N6YH0alOlwP
	aNcv/cBCDto/SbzsQ3s7QL95BX6stm6pHUvyx1bw6MtX0LhN1Hb0JadF8BZ14x1Iynmsx8mvdgr1Q
	Cb3e+RsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usPg6-00000008G2f-3yXV;
	Sat, 30 Aug 2025 17:47:50 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqMyd-00000006jzg-3T95
	for kexec@lists.infradead.org;
	Mon, 25 Aug 2025 02:30:32 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2445827be70so36444015ad.3
        for <kexec@lists.infradead.org>; Sun, 24 Aug 2025 19:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756089031; x=1756693831; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D22H5WgHrRDr6Rs9uj/QpBbAQMcw3KfQsKqL222d6ec=;
        b=B4FheQVC6VfDcE1+S6hCju2UYpNMJ9yD5z5YlsRpbjIg6pPzYSJonDbmEkqTPs0ybg
         yVN+uMHqBPnBdRbxjuHmY75DcHlFqDByCF7ujQ/UpFuQlPzdgrAWeSbllN9N+Njp0efV
         QFeenJZYuN+FneEee3osb0MgVkWhElWzstOErAbpYjNgLaxpL+JEtMUViV58W8hgETp9
         OpBjaq9c9i3qsPKgdvgc4FwRUFaZXVd1OIJ2bRdGmiD01OO/qKTDG4P83uaw4vv5lx8c
         JLqkC3ifrlJr+v2PiM98ztwUWK0A6d7y9IW3TceoJqU/pH+iUzLhJWKuCQ8ABSge/Ww4
         Ss8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756089031; x=1756693831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D22H5WgHrRDr6Rs9uj/QpBbAQMcw3KfQsKqL222d6ec=;
        b=W1U6ivqGDeTUg+4QHd5UhA1C4VphPBqWL5QtQy8FPm+tLuXrRTI19iYs1l9tR5caER
         qZlctARc42tiyF6El2Hu7PFrSEyn8dLQictj0a8mt5d5tMqAz7PwmHq7UUrlqWQm+Uba
         LgcYm1BZSAyrAwVdOBGDWRMINmY6RuAwqiYAlwiw0Kq0GBBfQJ59/9Nmv013JiwCoTW6
         A35ZZUIyYzT/m844LICS/N+sUYU7oNk/J6m3bWQm+v5Ha7IwswgOI/d8gQuPXwHHkkVK
         Z6UQH328s78uSoy3LpMn0GrQBEHJ6TdapRlY+ze/6Vl+qRYumyO/ZhWyKJkpvEokjsy+
         AU8A==
X-Forwarded-Encrypted: i=1; AJvYcCXZcCooZiDZmIp/WSVV5bJfRe9Vy9W5xnPCKeItym/fLZhke8AOg62WcK1WQmJTsuMpa7epMQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YynuaaCgCy50qNi92phXS1lMvTkamES00LkL8bObkghAUpqL72I
	BDbcV8NZ8LCcfv+nKDuhnR0Hy+sr2+IOY/XmYZmoYhfqI1lBlq5PjlSi
X-Gm-Gg: ASbGncsj6FrJYt+F2Z2nbY00TAtKfsH2b/N1fJ2AzYiR8uNe0SeVGSn1C+kO2uFYkVM
	KmSYaiegNfBKCvz7C+ARO8w+N3NfIeQgJJ8SD8M+YqkbU1jwpuDc4nEoEyK6025JWuy/YxgvadC
	D2Ec+V9eNLbgnmtGcJGhUs3hkmhpP4QHehPIiEtQYX0/tAmsuD0x+gdQ3VTxcGDG3GnEno1eKlZ
	yk7jQInlGxQ4+psvOsGTOQ1WlWjmM4kYySCobv1wLcPR6Z6MX0wqYAc3C0053q4tGof7ECujLHY
	OOCdJeNFIGcyh5pv5BsCTpG/0XJ11QXxY/NO8RAHJs31YD/ydUZv77JTS10to/F2LzGUWsXijWY
	efyuWr11hFl6LeBnO6RSL7RnYv8nvEe/ZbwjNc5IfKSsWS3II7cyITdyE8xaayRTGbv9e06EPDr
	o=
X-Google-Smtp-Source: AGHT+IHvUbvFr57GAj/hQE8xfxiDlLg1TWgL+5HGU9dNUcnxRdGMO81pVBBt5RpnalyVwaK4Xtg7ig==
X-Received: by 2002:a17:903:1a2c:b0:234:a139:11f0 with SMTP id d9443c01a7336-2462edab80amr150747455ad.7.1756089031108;
        Sun, 24 Aug 2025 19:30:31 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af234sm53905175ad.48.2025.08.24.19.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 19:30:30 -0700 (PDT)
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
Subject: [PATCH v2 1/9] panic: Introduce helper functions for panic state
Date: Mon, 25 Aug 2025 10:29:29 +0800
Message-ID: <20250825022947.1596226-2-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825022947.1596226-1-wangjinchao600@gmail.com>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250824_193031_866146_5849C545 
X-CRM114-Status: GOOD (  18.90  )
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

This patch introduces four new helper functions to abstract the
management of the panic_cpu variable. These functions will be used in
subsequent patches to refactor existing code.

The direct use of panic_cpu can be error-prone and ambiguous, as it
requires manual checks to determine which CPU is handling the panic.
The new helpers clarify intent:

panic_try_start():
Atomically sets the current CPU as the panicking CPU.

panic_reset():
Reset panic_cpu to PANIC_CPU_INVALID.

panic_in_progress():
Checks if a panic has been triggered.

panic_on_this_cpu():
Returns true if the current CPU is the panic originator.

panic_on_other_cpu():
Returns true if a panic is on another CPU.

This change lays the groundwork for improved code readability
and robustness in the panic handling subsystem.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/panic.h  |  6 +++++
 kernel/panic.c         | 53 ++++++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c |  5 ----
 3 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index 7be742628c25..6f972a66c13e 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -43,6 +43,12 @@ void abort(void);
 extern atomic_t panic_cpu;
 #define PANIC_CPU_INVALID	-1
 
+bool panic_try_start(void);
+void panic_reset(void);
+bool panic_in_progress(void);
+bool panic_on_this_cpu(void);
+bool panic_on_other_cpu(void);
+
 /*
  * Only to be used by arch init code. If the user over-wrote the default
  * CONFIG_PANIC_TIMEOUT, honor it.
diff --git a/kernel/panic.c b/kernel/panic.c
index 72fcbb5a071b..eacb0c972110 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -294,6 +294,59 @@ void __weak crash_smp_send_stop(void)
 
 atomic_t panic_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
 
+bool panic_try_start(void)
+{
+	int old_cpu, this_cpu;
+
+	/*
+	 * Only one CPU is allowed to execute the crash_kexec() code as with
+	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
+	 * may stop each other.  To exclude them, we use panic_cpu here too.
+	 */
+	old_cpu = PANIC_CPU_INVALID;
+	this_cpu = raw_smp_processor_id();
+
+	return atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu);
+}
+EXPORT_SYMBOL(panic_try_start);
+
+void panic_reset(void)
+{
+	atomic_set(&panic_cpu, PANIC_CPU_INVALID);
+}
+EXPORT_SYMBOL(panic_reset);
+
+bool panic_in_progress(void)
+{
+	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
+}
+EXPORT_SYMBOL(panic_in_progress);
+
+/* Return true if a panic is in progress on the current CPU. */
+bool panic_on_this_cpu(void)
+{
+	/*
+	 * We can use raw_smp_processor_id() here because it is impossible for
+	 * the task to be migrated to the panic_cpu, or away from it. If
+	 * panic_cpu has already been set, and we're not currently executing on
+	 * that CPU, then we never will be.
+	 */
+	return unlikely(atomic_read(&panic_cpu) == raw_smp_processor_id());
+}
+EXPORT_SYMBOL(panic_on_this_cpu);
+
+/*
+ * Return true if a panic is in progress on a remote CPU.
+ *
+ * On true, the local CPU should immediately release any printing resources
+ * that may be needed by the panic CPU.
+ */
+bool panic_on_other_cpu(void)
+{
+	return (panic_in_progress() && !this_cpu_in_panic());
+}
+EXPORT_SYMBOL(panic_on_other_cpu);
+
 /*
  * A variant of panic() called from NMI context. We return if we've already
  * panicked on this CPU. If another CPU already panicked, loop in
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0efbcdda9aab..5fe35f377b79 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -345,11 +345,6 @@ static void __up_console_sem(unsigned long ip)
 }
 #define up_console_sem() __up_console_sem(_RET_IP_)
 
-static bool panic_in_progress(void)
-{
-	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
-}
-
 /* Return true if a panic is in progress on the current CPU. */
 bool this_cpu_in_panic(void)
 {
-- 
2.43.0


