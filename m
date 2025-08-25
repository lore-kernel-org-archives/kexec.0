Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E08CA1008
	for <kexec@archiver.kernel.org>; Sat, 30 Aug 2025 17:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QVC8azoXPoxosuCvm1eCBz9SCYhPLAwxnPZ8goaQCGw=; b=g7ynreci1D+r+YxrpvYR5zNwnw
	sgQfzgHlWgxOzhZnDKOpjSsUhKQHwvOEVs2o1uJp5GPeOyFGz7f7C1vinndYkXesp0DEv2paN/P8m
	k1x9aqzNQcYlpL7bXeppjbGelx2TpZ4HCaeLuGSBBFBPXB0G2HrxkUNmfKz1SqcA20FGTh+0PZ3Jn
	D2rAVFmJoL1Eqnau3aWARrHIMQxihjKKF4Ng44NLw2heq2JZq8SGcypqA57ZzDreAnuZTDETrMBJ3
	CkvI2/4nrUud7Db3++O5VCoa0S4ac99orhfRXEFjM/Irzn3mDMe9TCkWJ3sLPLKnARPo4jxQJMESL
	eloVPEtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usPg9-00000008G6B-1T24;
	Sat, 30 Aug 2025 17:47:53 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqMzb-00000006kAH-01qt
	for kexec@lists.infradead.org;
	Mon, 25 Aug 2025 02:31:32 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-b47175d02dcso3252325a12.3
        for <kexec@lists.infradead.org>; Sun, 24 Aug 2025 19:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756089090; x=1756693890; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVC8azoXPoxosuCvm1eCBz9SCYhPLAwxnPZ8goaQCGw=;
        b=i5Pdo8gVhOJD6cS+SabQS3aWkEZ/DiMvR63jc9eR8Ovbyme9m288c4Xi65kDeXh+ZX
         keYkdM8VmJuHXSofk7qh0ujY3OWQJOuk7+oQOoP0YZJyGYOqclxB6wHxjBkGJeE23ZSa
         RO1jiTNsq6UNsw3kuxOcYJyGh9N7DV/beDg7QWNcoI6G6OWEfgDNGLpaNiQrsAwBhpzi
         yl03uQgUq7qy18d6Yw+fgwdmBF2Tt/eCsLIwqQl6qAr0TdDuKsqo9/SJNfPkkpCa1VjT
         rpNQIfL80K/ROvKcqBcITiil7P+DgtrFmobJ8Gu+XcTcwKn6XZhkBMDheq2K3FTQ/Rbr
         P/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756089090; x=1756693890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVC8azoXPoxosuCvm1eCBz9SCYhPLAwxnPZ8goaQCGw=;
        b=fWyZ7iOrP05Pqf0sYuiGYHAQeGsTjtdekum2bD+cdKkcZHKCUz/N/CQDQrAXeEcbxm
         1lu7mSqCg6te48cHW0xAdzreaFscnBgNLFO6jsVpBFUB3Oq45bXYyUsbu//bwWEA0OyV
         SHRhnFyX5476T9KQAgszij5xH6QAWyNJ7lGNxcuG5eH3wnX+7A1YGi5W7A2MGJkVKOq3
         PdIyR4wMUIjOZvD9gYJWfSyF3M4g8mDO3lOqK4jrXUIHR1p3H33f0HqotIrm3wTbXqO6
         tYP0gb015vk8ReEQmUbacumdAwIM6lECK36Ag8ciB9DFqxJcxfQ1bX17GZmAOXamBnC6
         tRSg==
X-Forwarded-Encrypted: i=1; AJvYcCWAQC7ejpYBK/wNBr03j7yxHEf4ztIu6/doOilP8O2mw5h3789MI359CO6RMUKfbASiBcwKNA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyro81DcPLItExxyG6mVQw98l7HG54fF42xjqdrLZCTCiUiOD59
	zTd0J6pZqiZgCaxhaDmDQ0phWeWBR3r3Nl4DWyGWbEWk/xoLaAw+P7q9
X-Gm-Gg: ASbGnctw+Zb5Cz95sat6nXfellEFILvyiAU+ThskOPpRW33FDWtdTM2xnO1eDJSWaoA
	g/8zuaDbBXTmR4qETvCo25CC0ETcOoxNZ2ehofUiB60H2rDG6407uIgyMtGo3A+q5shEtt/iHIS
	aaRdvDrmFtaz51b47upPCo24jFFljoMdmHMTD93kVXUrymucykoaFmTVMoCn2C9frLZ3sqA2pGT
	p7iZ5Mfv62N1ZKySRyBzM1ilZrb9y8cFHShGMIYKaENv+IW3MpC9nC/fo2xZCoqet7POS/d54pm
	uXgrmbGcPsR+Jk+HsWd5E1K/TsW0nSMTE1h5Du8fIlDCR6tY6GnqyWITkM918yHfbjv4vi0FLbf
	dE5Rf+YPxPjQ2TnA0m40A1SakxG+YJrpcWzi6Qhok35uzkmZnLPNgmaN+Q/Azgx/f6R3quI0voI
	w=
X-Google-Smtp-Source: AGHT+IEJ/RxmV9vk0nXMb491fT4XTeycZujwgAzjS69NOeWahllc9+DZTfyHZl2PP7ynSHAO+OZuag==
X-Received: by 2002:a17:903:1ae4:b0:240:a889:554d with SMTP id d9443c01a7336-2462ef8e723mr143141775ad.45.1756089090224;
        Sun, 24 Aug 2025 19:31:30 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af234sm53905175ad.48.2025.08.24.19.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 19:31:29 -0700 (PDT)
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
Subject: [PATCH v2 6/9] printk/nbcon: use panic_on_this_cpu() helper
Date: Mon, 25 Aug 2025 10:29:34 +0800
Message-ID: <20250825022947.1596226-7-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825022947.1596226-1-wangjinchao600@gmail.com>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250824_193131_048997_C2188202 
X-CRM114-Status: GOOD (  14.66  )
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

nbcon_context_try_acquire() compared panic_cpu directly with
smp_processor_id().  This open-coded check is now provided by
panic_on_this_cpu().

Switch to panic_on_this_cpu() to simplify the code and improve readability.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/printk/nbcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 646801813415..7490865e2f44 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -2,6 +2,7 @@
 // Copyright (C) 2022 Linutronix GmbH, John Ogness
 // Copyright (C) 2022 Intel, Thomas Gleixner
 
+#include "linux/panic.h"
 #include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/console.h>
@@ -589,7 +590,6 @@ static struct printk_buffers panic_nbcon_pbufs;
  */
 static bool nbcon_context_try_acquire(struct nbcon_context *ctxt, bool is_reacquire)
 {
-	unsigned int cpu = smp_processor_id();
 	struct console *con = ctxt->console;
 	struct nbcon_state cur;
 	int err;
@@ -614,7 +614,7 @@ static bool nbcon_context_try_acquire(struct nbcon_context *ctxt, bool is_reacqu
 	/* Acquire succeeded. */
 
 	/* Assign the appropriate buffer for this context. */
-	if (atomic_read(&panic_cpu) == cpu)
+	if (panic_on_this_cpu())
 		ctxt->pbufs = &panic_nbcon_pbufs;
 	else
 		ctxt->pbufs = con->pbufs;
-- 
2.43.0


