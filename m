Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B7ECA1003
	for <kexec@archiver.kernel.org>; Sat, 30 Aug 2025 17:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O10Bl4oetUFVZeVcIyFTPuGNIUEAVGF7F9sLfkbwSS4=; b=B1frXhyH+c+S3e3RiF5sbs3hFu
	1LBJwIvke59WGUN9f3k09AncTjP44az//k/5IMIvrxJCTObGbgonsUT62cBaMzLxOl4UJRInnLvjT
	5WVYTMDXRf8qglbKtQXo6V3KZ92K4m5lPQ25N0S7uJHgCwplCnyBGYoFmtu31rUuHqPyJ5W7oRxMO
	SSFxcTsve9Xk/F2jHuC2iaIsPNRaEgXQzDDfwn9zUwYGRe+u0tEXXKQhRXtJiZiOToc//bUzVIU7f
	Y8UHe+pwrbL/1COVIqUjvyM0Kves5kRh3FD8aZ5f3b8atxTjv+pPWeQDduFL2csCzFiV5ypW651q7
	TfgJeHNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usPgA-00000008G8j-3oMT;
	Sat, 30 Aug 2025 17:47:54 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqN08-00000006kGM-32KS
	for kexec@lists.infradead.org;
	Mon, 25 Aug 2025 02:32:08 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-246ef40cf93so414105ad.0
        for <kexec@lists.infradead.org>; Sun, 24 Aug 2025 19:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756089124; x=1756693924; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O10Bl4oetUFVZeVcIyFTPuGNIUEAVGF7F9sLfkbwSS4=;
        b=UOtiTgGKpvupKv5c2uNvVXDKdSBVGqipSD7/QVoYaiC2uO0ELjSXqiZFxfeCarSe3c
         ijulmhr10BMAUD/NbrFNjM4GIZuVzg3MvQzfm+VeHqctf9/W5ULpkjsGmHhb8tZdCd6D
         GzGu7bXgZCDFCQXrLLpn/H3oxglS61f8YscqBqFrW20YrRUKNljtgV3Qhq+jHxNjZJ5c
         uJ7f3NppRwcH+wk17efwJiHKo3xrjSveh3SAM88E8vVU8WgGl5K0Pbi7PKzk9+fklfD9
         5lheD7CkIPHyMtk/iSXqkKQQfXumShKHpGRvPd2wPSoC8QdQ8Rd1I5+IQYK+0B+m8m3j
         LFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756089124; x=1756693924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O10Bl4oetUFVZeVcIyFTPuGNIUEAVGF7F9sLfkbwSS4=;
        b=GqAd8r7SPFcaFVoTTw7ZzUVaURtO5fxsBGvi9WF++AjopOX1DHlFpAmBIqxWbgB22v
         0f5g6ZiSVdz7j7jXHeP4txYZSnlbcz7pG4G9yam9gRd34d5YSTtfLDIpQrMk3/fegm/o
         bKumPVRKtDBZZ0fa/aoXf3Tyx0gp68DHeMtHrfRYhlC3Meyg1NPn9W3hKavH2bQttrUB
         d7b/pPaC8b0DzD7SsErLfyyTI3th/YvjJLN2s+1TRKKmZw5iO6nn5M741L/FonXXlvof
         gTa6GAdC/Dhk9je+pFbJioGQTzAvETiAuDZBvwlI40R/K7jwg/BfxtopCWBrHcavXAi+
         qT+w==
X-Forwarded-Encrypted: i=1; AJvYcCVa0G3IlnQoet+1ZFZuBHxLqwT7nuWAuY/xDKikbK2VaSAgzzGwh7NnG9luUx+gwGjsIE1R7w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy4dC5dHFb1ChLbatmqi0USxMuwSaYovjLBNJrt7hdTzEgyqbvp
	CyfmFxY2LE/UJ93ehQV1CM21/id4Czf+gu6d6yVS1607CDLhVuFekrzd
X-Gm-Gg: ASbGncuLzHzQYugg0/2xFUtpjh5xQErk57gImVE40fNNnNxRRUhiEHECVn/XJ6ftnp3
	RW7A0R2eUfEiXQkTmlkuh4tLfV8s2iqz1Py2CsPlQac0NH3KABykL8QhdZ0TLZqprLCqQKfS4WS
	rZ0XjBs/wHYW/MhteG5IzQHfqj3YaRAhaackzShKMq7jaGDszIhZ5/JwIwdo6jBLhW7HDV/XB2i
	A68jCyiE1V7VXb20Ud0zzJ4VFLEXvMsKohKlaUlj1QJIEWEiqHSuIf+Hos99iQeJVN10/ubu//x
	J1tj4KuxuZJKogg8FMmcg4Em3T05kRTUWxT9w6TQkCLazd51PqtD1VECU7q73ttSvb/Koe5DccG
	gods1TuLJY6fCC3bokivjTC8epqo7712HC6cXPkHe9ExKH772qnNnb4PEHcEcwjbF8mKqQcQJoQ
	U=
X-Google-Smtp-Source: AGHT+IHiK6ZNzGbxD1aVZDdpEIJSJdRVCIVYu6qhCycor6e6tzkhdDgkg9nCBYkly1FiN66XhTD6Bw==
X-Received: by 2002:a17:903:38c4:b0:240:5bde:532d with SMTP id d9443c01a7336-2462ef4c8eemr131114705ad.38.1756089123935;
        Sun, 24 Aug 2025 19:32:03 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af234sm53905175ad.48.2025.08.24.19.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 19:32:03 -0700 (PDT)
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
Subject: [PATCH v2 9/9] watchdog: skip checks when panic is in progress
Date: Mon, 25 Aug 2025 10:29:37 +0800
Message-ID: <20250825022947.1596226-10-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825022947.1596226-1-wangjinchao600@gmail.com>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250824_193204_764614_86D8E54B 
X-CRM114-Status: GOOD (  15.55  )
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

This issue was found when an EFI pstore was configured for kdump
logging with the NMI hard lockup detector enabled. The efi-pstore
write operation was slow, and with a large number of logs, the
pstore dump callback within kmsg_dump() took a long time.

This delay triggered the NMI watchdog, leading to a nested panic.
The call flow demonstrates how the secondary panic caused an
emergency_restart() to be triggered before the initial pstore
operation could finish, leading to a failure to dump the logs:

  real panic() {
	kmsg_dump() {
		...
		pstore_dump() {
			start_dump();
			... // long time operation triggers NMI watchdog
			nmi panic() {
				...
				emergency_restart(); // pstore unfinished
			}
			...
			finish_dump(); // never reached
		}
	}
  }

Both watchdog_buddy_check_hardlockup() and watchdog_overflow_callback() may
trigger during a panic. This can lead to recursive panic handling.

Add panic_in_progress() checks so watchdog activity is skipped once a panic
has begun.

This prevents recursive panic and keeps the panic path more reliable.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
Reviewed-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 kernel/watchdog.c      | 6 ++++++
 kernel/watchdog_perf.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 80b56c002c7f..597c0d947c93 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -740,6 +740,12 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	if (!watchdog_enabled)
 		return HRTIMER_NORESTART;
 
+	/*
+	 * pass the buddy check if a panic is in process
+	 */
+	if (panic_in_progress())
+		return HRTIMER_NORESTART;
+
 	watchdog_hardlockup_kick();
 
 	/* kick the softlockup detector */
diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index 9c58f5b4381d..d3ca70e3c256 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -12,6 +12,7 @@
 
 #define pr_fmt(fmt) "NMI watchdog: " fmt
 
+#include <linux/panic.h>
 #include <linux/nmi.h>
 #include <linux/atomic.h>
 #include <linux/module.h>
@@ -108,6 +109,9 @@ static void watchdog_overflow_callback(struct perf_event *event,
 	/* Ensure the watchdog never gets throttled */
 	event->hw.interrupts = 0;
 
+	if (panic_in_progress())
+		return;
+
 	if (!watchdog_check_timestamp())
 		return;
 
-- 
2.43.0


