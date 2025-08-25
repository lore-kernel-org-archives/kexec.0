Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E15CA0FFF
	for <kexec@archiver.kernel.org>; Sat, 30 Aug 2025 17:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F7yKzJNb2rx6SiyelcSe/xXvw8ffKUxo6CoK3itAFgM=; b=JGwR1P9hREQhDOvHLN/+ULwrzl
	uxB5cFdq7PmkBr81GCyE/P8qjiIbHnaEM+Dam3WcCKksLLiKZfdOS7NqXUr66iCiBWJBLHzb6r7It
	GdZotHN2jQWXopS2p9TYKDVuDYokTk9EM9WH3m3zCj87NLcfkAYpbxW3m+eD82HMLA8JD9khbKniy
	0W+kGrKoIuJNZmY++MpvMJx+VhY8NWeJBJRb1e5wL2IXUWL1CAEaj4yCjOBE/whjKJeK01ztUFGod
	ngFW0VXe35uXNAR6pvdIZgxScWWjlZuJI7qHJc5yaY+ID0iy33T3YZi1Fd/IE4QjF719yMTRDpYQy
	rTmPUdRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usPg8-00000008G4s-2rzn;
	Sat, 30 Aug 2025 17:47:52 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqMzO-00000006k8r-46bQ
	for kexec@lists.infradead.org;
	Mon, 25 Aug 2025 02:31:20 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2445824dc27so36346355ad.3
        for <kexec@lists.infradead.org>; Sun, 24 Aug 2025 19:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756089078; x=1756693878; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7yKzJNb2rx6SiyelcSe/xXvw8ffKUxo6CoK3itAFgM=;
        b=lOUyKj0px2HG6Zpq2tub9xl20HH7Wrcj+39C7dcFDyeK16RB+IZaBKomFVuN0nPgw8
         BChB19rwEM9yDh1RSFBmAuBiFNSr0SlT5q1hu258Sw9JgjRXQQ0MMB4a7zVaHjvtlNi7
         vAYZGcOauVDF3UYDO34Ia5+KB0naiwCV5ZfZWQF72oc00fseXTZsGkZcK9qLQfU0rFGm
         DWa8hCuBS0/fCMKqYkiUTA7ixtJoREccaAYXKKvuMI9YPgckEIk9sJNR23SMUGuv0Ug8
         AuyJ6RlnntpYFqrcr/jApdII/8OrONd8SpkUQVBcdVkoTXS9A8jOZsdogjzmdcABMgUk
         XGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756089078; x=1756693878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7yKzJNb2rx6SiyelcSe/xXvw8ffKUxo6CoK3itAFgM=;
        b=OdGJo0UqsenmzgXsiG1vh4AVPc6rITE5l821Y70a1MUn4wMIOePwxJAe31nfc03+YA
         ZLXdNO+xtkgmeJjT5+iiaJHQxS4HKRAPFFqNVS/DYi9ep35N/2AGI5vyI0qFpRX7/4U5
         w8rnvhyZaVvyjEr4GNLNqHcxb1N30Aw3ztNZrdb1J670JwXa6dON2gOJN7/nrkQsgTuc
         dr2IDNIyLmzA2ZyflBsWte/gGfAgO7zPKPUvVosc/sBHF6NBNgWL/RZINShmTjcjAQmu
         azJSsUYgQgSzyH5TnQ4RRIOJ70BmR8PL11C7RFcqq5g2TXenTYBWQb8rwEwlUiXMh3/g
         Iqnw==
X-Forwarded-Encrypted: i=1; AJvYcCUMso0e79G2CHZWW2KoFmPgH4l0qgaGsuTWPvpGz8UHqlyaU3uRRynEKKqDoNQQtT9tH11l3g==@lists.infradead.org
X-Gm-Message-State: AOJu0YwGFWXCTCFUPr2RRcwEyCJllJWG96IhncoPyegkTQ8Pzqga0+6c
	g59xeSa95g9E6Wyln1y98u31B4Aaop2jrzu6vrYFBuxAKZW9frJOiN57
X-Gm-Gg: ASbGncv+gp3PPbB8YVYkSbS/ByMBzywhgMIvncaupnpbxoN5Yv26eotCTlfBBvjutYC
	Ngr/wadZq4FI/bS2leOr4fbHTCnC4hdfGN0yHkqF200c6E0eTrEfsbAV/GZ4dXy7Y4u/vB2t0xc
	b97lCBRM3ZUre7SrCsAjkT2K1HF3itjFc7EDXJaCln81fwVW2e6WcZwAn9Xlyc0Ftd8bumXopbE
	D8NWS960pMkNkHXw+hlhf9qz3OhMNX9WxzED+9k1k9TvfyqGyM3yMavkcAveTHgkfHx4paXOu/L
	51IfT25WLe13XK0HvMUNK/V9zva6B/Wk+mn2Y1zeQDu+MVXmzfSCDWsPVBD7f2jCOsEUbEaOg0v
	1ik7YCL4Ee3c8tjwVCGG/pUz8Kp+C3FSKUmYdFtX4JbFxmKF4PUzqg7dOqL2kD8921BAGYGwNt1
	EEogIjq++xkg==
X-Google-Smtp-Source: AGHT+IGGk8nOO00I8QY6Ycp9jgs1ZyfKkaugn7N1DZdz8CRfy99hpUtZQbqKZx4/jp/Z5JOoCix/CQ==
X-Received: by 2002:a17:903:40ca:b0:246:ece3:de0b with SMTP id d9443c01a7336-246ed0267f5mr4431665ad.16.1756089078131;
        Sun, 24 Aug 2025 19:31:18 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af234sm53905175ad.48.2025.08.24.19.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 19:31:17 -0700 (PDT)
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
Subject: [PATCH v2 5/9] panic: use panic_try_start() in vpanic()
Date: Mon, 25 Aug 2025 10:29:33 +0800
Message-ID: <20250825022947.1596226-6-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825022947.1596226-1-wangjinchao600@gmail.com>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250824_193119_200674_2781BF62 
X-CRM114-Status: GOOD (  13.49  )
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

vpanic() had open-coded logic to claim panic_cpu with atomic_try_cmpxchg.
This is already handled by panic_try_start().

Switch to panic_try_start() and use panic_on_other_cpu() for the fallback
path.

This removes duplicate code and makes panic handling consistent across
functions.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/panic.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index cd86d37d124c..5266e195f5ac 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -415,7 +415,6 @@ void vpanic(const char *fmt, va_list args)
 	static char buf[1024];
 	long i, i_next = 0, len;
 	int state = 0;
-	int old_cpu, this_cpu;
 	bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
 
 	if (panic_on_warn) {
@@ -452,13 +451,10 @@ void vpanic(const char *fmt, va_list args)
 	 * `old_cpu == this_cpu' means we came from nmi_panic() which sets
 	 * panic_cpu to this CPU.  In this case, this is also the 1st CPU.
 	 */
-	old_cpu = PANIC_CPU_INVALID;
-	this_cpu = raw_smp_processor_id();
-
 	/* atomic_try_cmpxchg updates old_cpu on failure */
-	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
+	if (panic_try_start()) {
 		/* go ahead */
-	} else if (old_cpu != this_cpu)
+	} else if (panic_on_other_cpu())
 		panic_smp_self_stop();
 
 	console_verbose();
-- 
2.43.0


