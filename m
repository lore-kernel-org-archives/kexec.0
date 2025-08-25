Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AF7CA1001
	for <kexec@archiver.kernel.org>; Sat, 30 Aug 2025 17:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WUEa4tYSS0p5DNjOCVeWcyYJH7ruf9/pefat3lfo8dQ=; b=b89JFnjgcr7Qf9g2IvHXgJsFrY
	wCPPkrSpXgtN13uKQnFH3DkdnAX+omJhRJg0lPXNym9JhaObZ7VRrLlqwioniYcIIXXmSlZSmRIRm
	vBT9p9uiI7hDsdy1NuSdLbrEr731zDSuT2Qr8hAtUnBC7q6KCC2mlVAKVdCEfFJ4RDlWQVO0NWaRX
	YU2umKoe5MhOHMyMc+Shy6jFiQUaj7tB6o7c+KCfZNBYSRsCb1X5SgMz9cotu/CX3LXTdu2MaSWjO
	UDCX9o8NhElcMoHsEoAmfOyhhr6schiUVRyU4oEvrQpop2QxyttePxeKbUj7tFyjAVfSeRhSIc9Bd
	1AOEN/OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usPg9-00000008G74-3dGk;
	Sat, 30 Aug 2025 17:47:53 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqMzm-00000006kBo-08J2
	for kexec@lists.infradead.org;
	Mon, 25 Aug 2025 02:31:43 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-24458272c00so44574755ad.3
        for <kexec@lists.infradead.org>; Sun, 24 Aug 2025 19:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756089101; x=1756693901; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUEa4tYSS0p5DNjOCVeWcyYJH7ruf9/pefat3lfo8dQ=;
        b=BUEeDmnZosJIc9/rnrcXvOYIb1eeb45F55Qp2NVS84Fe0vXptXP1Hrk9PLzT3QJcCH
         OVINnJyWkPOy1EPQ9plz6xW8idqJ3pH0sbZFgBb2t8AaPF/f7BxdZW40T/zkknvv/EVI
         ZwWrfg3usat4b1f7I9F7dxEATU7s5BPrN5oLHTUkgb0Sguvc3ydlPC8jmuSS04/RkLuZ
         2pdrI6Z06LwGiowZ/VtOz2XIDcRDT/ptjBIkaADY3Hjsqsk8FIEuuvhxYjCH21H/7L2S
         qH/m43/IzFiGn4u85mN3ldyCDWcrePZ8Z53neESQzPUI+8QDuo9ysVKlC5+wTvj2V0Ke
         q2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756089101; x=1756693901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUEa4tYSS0p5DNjOCVeWcyYJH7ruf9/pefat3lfo8dQ=;
        b=HIax99fP0Aoc6+gGLXVjv0cHorglq8bW5yeSkufcljvgB+xPaD0wYR1EnlX4WvJ7FM
         CX02yGD69Xsab7wo+tqqQuOQeynv73nq5L2Ti5YKjxQGMS6VvXizROMe6aclw75M0WfB
         s/xP5zjbcyJqzbSvc7njM/Mdpci0GSf3vgzK37i48jlDVQEISSF4FIhOnCW0u6nzDwnF
         NiOY7oy3r55MtXLXswUsrGcWG6fNY1b52tWXFTL63OhVQCrtkBgzWIn0Axgj0XBTNoN5
         B+HpQB/F+Ms27dXGNklSS8xPGJhUvia74K9YSqCupXeQCWALbApZoCC1xIG2bTW5ezKl
         8hIg==
X-Forwarded-Encrypted: i=1; AJvYcCVYEQkKndM77aiXfXOLGKgv7XGZv5X2zjZllBiQZrL1zC3CCvh9yblMRFwNAn3Bp/mH1wwCGg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwHrXE3KaDeSXZfhN/bMTJ+PzGu4LZMMysWiPweKHjLNmJ1vdJC
	7r7U+cQxYlZDg13GVP2SpUemQ+MRnFJvsUUcwEKuEpOWrK3ndZBtmvnD
X-Gm-Gg: ASbGncs5foNDn2+xE5vP3OnTLcOMOQCrs+AMwyL8/+LQOKQ5rdYUAyp0WyrD2+U01Zg
	D2tgUL6Jmu4D7hrFsJZa9ahQzl5uO+lBom4LNTSS00j3XmZ/DyWQuC+6cz1NDT285iHJFJrz1QF
	97XMcDwxjIhmnh+QlKgTyP7zgfCSbNXhjGsg8c6V5IPJr+WoUe2V22WFvgQM/b4Emu/9mrs4lIe
	8WcD8IvS/xKcMPyz/q8zDuklGJJ8Tv385J8xfAhTwLHdzWYbfVHtMHx0P4OLp7Aw+SIxxr2N1xl
	vaDZn+ooJSDWlXgRmzm9W6pdFRhR6ubQDczHrQcStnaM8IDL8r36sQy436HczvbtW0FuZaskCpJ
	QQeLTs/h/gyOxVg06+raFRF549GHRQiJbXmj+H8sYpN2Tv8VIUw27hboX6sh6qtwIhIJgTVQmVo
	Y=
X-Google-Smtp-Source: AGHT+IEsHHne9AMztJo7a8IjD1y4loI/AihrgL9BB/L9e0AetCJaQuYxWX/l7xlWh7T6OVyIoYtcqA==
X-Received: by 2002:a17:903:283:b0:246:61c:a67e with SMTP id d9443c01a7336-2462efdd639mr124786615ad.61.1756089101128;
        Sun, 24 Aug 2025 19:31:41 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af234sm53905175ad.48.2025.08.24.19.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 19:31:40 -0700 (PDT)
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
Subject: [PATCH v2 7/9] panic/printk: replace this_cpu_in_panic() with panic_on_this_cpu()
Date: Mon, 25 Aug 2025 10:29:35 +0800
Message-ID: <20250825022947.1596226-8-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825022947.1596226-1-wangjinchao600@gmail.com>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250824_193142_070415_7942AD4A 
X-CRM114-Status: GOOD (  17.71  )
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

The helper this_cpu_in_panic() duplicated logic already provided by
panic_on_this_cpu().

Remove this_cpu_in_panic() and switch all users to panic_on_this_cpu().

This simplifies the code and avoids having two helpers for the same check.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/printk.h            |  2 --
 kernel/panic.c                    |  2 +-
 kernel/printk/nbcon.c             |  2 +-
 kernel/printk/printk.c            | 15 ++-------------
 kernel/printk/printk_ringbuffer.c |  2 +-
 lib/dump_stack.c                  |  2 +-
 6 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 5d22b803f51e..45c663124c9b 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -330,8 +330,6 @@ static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
 
 #endif
 
-bool this_cpu_in_panic(void);
-
 #ifdef CONFIG_SMP
 extern int __printk_cpu_sync_try_get(void);
 extern void __printk_cpu_sync_wait(void);
diff --git a/kernel/panic.c b/kernel/panic.c
index 5266e195f5ac..8415e4073da1 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -343,7 +343,7 @@ EXPORT_SYMBOL(panic_on_this_cpu);
  */
 bool panic_on_other_cpu(void)
 {
-	return (panic_in_progress() && !this_cpu_in_panic());
+	return (panic_in_progress() && !panic_on_this_cpu());
 }
 EXPORT_SYMBOL(panic_on_other_cpu);
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 7490865e2f44..c6d1a4a747e9 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1394,7 +1394,7 @@ enum nbcon_prio nbcon_get_default_prio(void)
 {
 	unsigned int *cpu_emergency_nesting;
 
-	if (this_cpu_in_panic())
+	if (panic_on_this_cpu())
 		return NBCON_PRIO_PANIC;
 
 	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5fe35f377b79..faa8b1f0585b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -17,6 +17,7 @@
  *	01Mar01 Andrew Morton
  */
 
+#include "linux/panic.h"
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kernel.h>
@@ -345,18 +346,6 @@ static void __up_console_sem(unsigned long ip)
 }
 #define up_console_sem() __up_console_sem(_RET_IP_)
 
-/* Return true if a panic is in progress on the current CPU. */
-bool this_cpu_in_panic(void)
-{
-	/*
-	 * We can use raw_smp_processor_id() here because it is impossible for
-	 * the task to be migrated to the panic_cpu, or away from it. If
-	 * panic_cpu has already been set, and we're not currently executing on
-	 * that CPU, then we never will be.
-	 */
-	return unlikely(atomic_read(&panic_cpu) == raw_smp_processor_id());
-}
-
 /*
  * Return true if a panic is in progress on a remote CPU.
  *
@@ -365,7 +354,7 @@ bool this_cpu_in_panic(void)
  */
 bool other_cpu_in_panic(void)
 {
-	return (panic_in_progress() && !this_cpu_in_panic());
+	return (panic_in_progress() && !panic_on_this_cpu());
 }
 
 /*
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index d9fb053cff67..e2a1b2d34d2b 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -2143,7 +2143,7 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			 * But it would have the sequence number returned
 			 * by "prb_next_reserve_seq() - 1".
 			 */
-			if (this_cpu_in_panic() &&
+			if (panic_on_this_cpu() &&
 			    (!debug_non_panic_cpus || legacy_allow_panic_sync) &&
 			    ((*seq + 1) < prb_next_reserve_seq(rb))) {
 				(*seq)++;
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index b3a85fe8b673..f0c78b5b5324 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -102,7 +102,7 @@ static void __dump_stack(const char *log_lvl)
  */
 asmlinkage __visible void dump_stack_lvl(const char *log_lvl)
 {
-	bool in_panic = this_cpu_in_panic();
+	bool in_panic = panic_on_this_cpu();
 	unsigned long flags;
 
 	/*
-- 
2.43.0


