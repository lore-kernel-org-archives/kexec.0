Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F8BCA1006
	for <kexec@archiver.kernel.org>; Sat, 30 Aug 2025 17:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IH8YhLChJO+46PfNNdyjwrwQJKBLxU7b8IaUufHISe4=; b=HddnBUJr/XcHTGXnhkR3mdBUkO
	eO0sawgBmsGWD2NkLcf/+zy2mq+i5nEiBrg+bN2JPKHpa9fq9TXVLDruhD7N7QdLDIVc6NNeYKUUj
	7zWcoeV4boJNFvio/9/+gBig6XCX2uHiX5kL55oKwgyFxSCsFxyk4i3t2Nfazv3w3m4JFzbJnS0v4
	9ztORHOmL5ivch3NxjYd+8soJdRg0cVM4Qr16xtt+SsfejLgytaRGDUfJzWbvA7yKA4p7xxITQvMR
	L/FrmoeETffl7RyKBltVlhUnXoU7xnXJRJvOwwzoX9UXyNn9dI4+VhmcT2kdm26mMIDJHpvD/MgQe
	MjgjV8Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usPg7-00000008G42-3RNb;
	Sat, 30 Aug 2025 17:47:51 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqMz1-00000006k4G-1YZA
	for kexec@lists.infradead.org;
	Mon, 25 Aug 2025 02:30:56 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso3438726a12.3
        for <kexec@lists.infradead.org>; Sun, 24 Aug 2025 19:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756089054; x=1756693854; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IH8YhLChJO+46PfNNdyjwrwQJKBLxU7b8IaUufHISe4=;
        b=nMYuvVkvhcJf2aa0IHbVF6BiiqzuSAjQ6pCnYPs7IG/+vyqPLNFi6NyhjQ8IoY1Xx5
         QiuWe0lngToEC3MwLursAUXzT/S4jAcD5AxIQBaVVn3lBMXm96O/zSOL1pYC0KH4LBgl
         04CDvrV9wMEitlfSJI6c3zIQv4JWe9K+e2y6ynE2q7Oodl3ZfZYaKfx3B9EpTaTyIS3Z
         cy4PO8XXYJPVm9+h9bvzDviFBrQVQOwiKt0EnfmjyxXm7UbE5Z9L5aFsMBjk89GWRUCC
         it56T7hKRZTlkvpcQJ0WEcpOiUwp8q1DD/s1W2wrNVD/ELtYjOeRslA4BQquxP3uN/XD
         MXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756089054; x=1756693854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IH8YhLChJO+46PfNNdyjwrwQJKBLxU7b8IaUufHISe4=;
        b=BudDPeRYei56tedbrwC0g0H/JiS+V12659e3eGkJ7akHwW0QcY0tAlh741MlfmXCQT
         X1lJGWHQS8I0r9wp6Jx+z2yemCCNVJAVYXxsvSj4EbsRN3C2wvA29ZpjzujKP2T8geg7
         2qaStntYukk6pD5cBTrfv6fMYvkJNSpjL1cwRn3/va/2WCU7QVZ8dwonnTYvxdRetp3X
         maTlCE0MOoNGfGaa7EiX891xGC+2upbTEi7iPhHBt+H1bdRF3fm4CntaLtIZameq67Ja
         GSArKN6PMaUnJu37Kfx5wxlPm/8re4FZ+oAd4UPHTEgo7HPVtfXRJihK6hQDXO4CYd1e
         TpMw==
X-Forwarded-Encrypted: i=1; AJvYcCVdopGLkUBbDY8o61s0GHCB4XUtZkeuj2+QKZysw5Zhi7oSDcmANuSOFKUDtSkZnXumMKz12g==@lists.infradead.org
X-Gm-Message-State: AOJu0YwAMAzf+TbhrHHXEEs5h7UBs7JB3O7VuoiELFZfP4HA8lpMvwdk
	Jeb3GMMiI1Q04gfpXT70KaOqmOs5irPVroIwV2d8lFaA1tbwIypWiT6S
X-Gm-Gg: ASbGncv+s4H3PWDnko+ROZ71tprrM8U3im5YJZ0Meao4tqNDdD77/tl15FpJPnhp0s/
	2w4mT3ThVtHzAoQzdgLpjaTn+rSADcHaMgjHm4X+GScnoaJYDjRBQA2b+ksFZUwJNHEyIX07XYf
	SoIoHTvPfd4qK+nnMyUbpT2i8TT9HTLmeYysVGFVoJiKH04SRrzcxpGj3/bCM679i2esEmLeRQy
	brvcYXjG+xTlW1s14eIOYnTdrmgBbarN4UdIdAQ2TU9TFR2+ir2Hcwnn5C8lnF512XYJfozsQgj
	3tw5AFSYqGyk780fDlLXNhOL6i3ykuZ8L0R71NfO86tSRyLjLvYdi0r1HAFXDVfp1pWOqH2M+FA
	P9xI93zQ2AmVMG4cPEWZXuJ+eUjlIKUKjZcA1qs5oiHXSlC28Lqi9TO7Q1rD6B1mmdhThGi7gVg
	g=
X-Google-Smtp-Source: AGHT+IH6pBx05EUggFYxitz83mZVXTIxwPpm1bcXy5QtfKJU32rVyZCwSo5s5hfxiY5yh80orLgZOQ==
X-Received: by 2002:a17:902:dad1:b0:240:8262:1a46 with SMTP id d9443c01a7336-2462ee54512mr139147305ad.25.1756089054419;
        Sun, 24 Aug 2025 19:30:54 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af234sm53905175ad.48.2025.08.24.19.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 19:30:54 -0700 (PDT)
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
Subject: [PATCH v2 3/9] crash_core: use panic_try_start() in crash_kexec()
Date: Mon, 25 Aug 2025 10:29:31 +0800
Message-ID: <20250825022947.1596226-4-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825022947.1596226-1-wangjinchao600@gmail.com>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250824_193055_408055_107D801B 
X-CRM114-Status: GOOD (  14.05  )
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

crash_kexec() had its own code to exclude parallel execution by setting
panic_cpu. This is already handled by panic_try_start(). Switch to
panic_try_start() to remove the duplication and keep the logic consistent.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/crash_core.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index a4ef79591eb2..bb38bbaf3a26 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
  */
 
+#include "linux/panic.h"
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/buildid.h>
@@ -143,17 +144,7 @@ STACK_FRAME_NON_STANDARD(__crash_kexec);
 
 __bpf_kfunc void crash_kexec(struct pt_regs *regs)
 {
-	int old_cpu, this_cpu;
-
-	/*
-	 * Only one CPU is allowed to execute the crash_kexec() code as with
-	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
-	 * may stop each other.  To exclude them, we use panic_cpu here too.
-	 */
-	old_cpu = PANIC_CPU_INVALID;
-	this_cpu = raw_smp_processor_id();
-
-	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
+	if (panic_try_start()) {
 		/* This is the 1st CPU which comes here, so go ahead. */
 		__crash_kexec(regs);
 
@@ -161,7 +152,7 @@ __bpf_kfunc void crash_kexec(struct pt_regs *regs)
 		 * Reset panic_cpu to allow another panic()/crash_kexec()
 		 * call.
 		 */
-		atomic_set(&panic_cpu, PANIC_CPU_INVALID);
+		panic_reset();
 	}
 }
 
-- 
2.43.0


