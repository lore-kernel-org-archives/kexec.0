Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDF1CA1004
	for <kexec@archiver.kernel.org>; Sat, 30 Aug 2025 17:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zFHAHU/+z+yhl9VER8s4Wp+oPk3FiOJt9Cdy6eMoyvc=; b=JZuxaH6uIJzDCnP0JA6SgTy6FH
	9z5Psbrpo+fk+BjF8CkPTBBywtcfeWbU18ei89GiTVrOnxziITCL3vDS5jtNpnUEjiZCGK7fnhtWs
	lbNXlaV+owQ4x5XxTABkqYrZ8KIZ62EyzWj86AWsqF23L3mOGjHgjtXnu70+YyKSY/nUhSwq3rL2L
	T6yS4+qln6Y605ozReOv4s4H3251CQod+QNiezbHBNJh5sOtFj2KVSYXPUoU1oKnw0/ViT1FqyQ52
	ehcMblXeyRsrt4PvMP6KGHHXXsr5JMsgCK/1z28ng3tl/1T1RFrEajnOQP2bE5eNdPJWKMcXt+Q/s
	DaGfYDOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usPg7-00000008G3a-1a0Z;
	Sat, 30 Aug 2025 17:47:51 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqMyp-00000006k1a-0iG9
	for kexec@lists.infradead.org;
	Mon, 25 Aug 2025 02:30:44 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso3438624a12.3
        for <kexec@lists.infradead.org>; Sun, 24 Aug 2025 19:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756089042; x=1756693842; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFHAHU/+z+yhl9VER8s4Wp+oPk3FiOJt9Cdy6eMoyvc=;
        b=FUhmC1hMvvypDCD611l9oj/arlzI/txZV3R1c7AxwZNk/tudCEyEIxWqpK2t7OSalg
         Ey/HsHsQD40Jx7s06EgJUw0sveS7uDwpgTv3vzutpLIa7mbmPRS5PQdCvaODuWS2nApa
         dRBMomcxdnMvL8ihU8x/fnixfeyxpQ+IZMH4y5wu7shWg4ZAqmVux8W1CLrPyytZrBbu
         da8Chp3dwswu3V97YaisS38sQbVqbO1hlb6p3UWACUYHPUmVfHh7okK4HmWMK8VQlqLu
         V77QcFAzi0eFlJKvaZJQt+65PlfgQq15/9u16xAEWcf3Gbp+UM6k9DDZ2Q0oD1yLiFAY
         K+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756089042; x=1756693842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFHAHU/+z+yhl9VER8s4Wp+oPk3FiOJt9Cdy6eMoyvc=;
        b=MVDqPrlq+/BnsDgWalk0lE6ws8EkJpsHKzkulKQUCjle++/sJomAmu0xs3bEZMpo54
         UoOyyeOfklEHjNAXZYPoarVW/Hfr29RELGFumcG5xuYBdNQSv/uQLZFtpohuLzRdN2/s
         8WnL99uzQVW2M0PWp0SwtivKqNgIAHcALpAhsYy1ef4ZOG6AQpeyha+ELlZAuRH/9pVl
         g40jPWywgA+qquiv3spzeV4RcQ/w4meeH1lAQUApA7PtQP4J1ifwLRpOV7OUX8I3JFjs
         QT1WuFbtrFLFNQFptZyJTzqBcNED4o02O8RoMVBKvD9C+vOhwRlPMf7BSzt8h+/kuH5+
         WrLA==
X-Forwarded-Encrypted: i=1; AJvYcCXliLeTATw3LX10KTCOFxm8v1c6Y6TejycM5OONvsSjztranNwbTNzfEh030DG/gDxNWx4URw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxnTm2pNmr6Cn4X10MX9GPzqGtgmUWv2goRm4/6TMgYehR9jBIO
	mNg+3+BeGDRX1L4R30o7/PO6bZqODAPAqmMkVLQxyVS06XLtY8LBtNV8
X-Gm-Gg: ASbGncvPfEcyOS/YR5K/tOOYaKAugsTo+/nOeufK5N/eqqbOy2XZULbjquEa4aps9TB
	L3Zb7f+WyHD3e5kULsYtKLQ+pT5ErkMFWAjqF6u2hZSdDnVkhkRrHp2DVPe0GlZ0UWQvR8Fhmty
	QCbF2V7/hyIqdmqw0fT29305oV1AIBNnzhKLESWG3y3Ol8qlJGO2KMeVfcrljahH/9njGWcn79R
	FFRMv9V0q1u7IZev5VLWxhazuB7luTTiwjQJhXFDINPrAAM1tr8UTc4WGOGj9iZo7wsgwhTWEGY
	KhFs7IcPFfV5yzt3+psVoGl3k8kdZVzAGUHfaSnaNI/Nm7y9/5mclA1JJxYNZm7rYDEIfumml7n
	LJ8aH0m/ZZIgbw/4xWMM8K6tCNggqng35+0cTHVOtP+jovvRW9fgMu7h6p+o5Tb+Qdvd32Xurc1
	c=
X-Google-Smtp-Source: AGHT+IHERO/1eHRkEF6AC+dBVfTjpOtqq/Unp7jmksVhNk83icoLby3erE1Gst+iT6A6gassubAXtA==
X-Received: by 2002:a17:903:41cc:b0:246:b58b:8b86 with SMTP id d9443c01a7336-246b58b8f44mr31066895ad.32.1756089042108;
        Sun, 24 Aug 2025 19:30:42 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af234sm53905175ad.48.2025.08.24.19.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 19:30:41 -0700 (PDT)
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
Subject: [PATCH v2 2/9] fbdev: Use panic_in_progress() helper
Date: Mon, 25 Aug 2025 10:29:30 +0800
Message-ID: <20250825022947.1596226-3-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825022947.1596226-1-wangjinchao600@gmail.com>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250824_193043_205862_82A4E5D2 
X-CRM114-Status: GOOD (  11.71  )
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

This patch updates the fbcon_skip_panic() function to use the
panic_in_progress() helper.

The previous direct access to panic_cpu is less readable and is being
replaced by a dedicated function that more clearly expresses the intent.

This change is part of a series to refactor the kernel's panic handling
logic for better clarity and robustness.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
Acked-by Qianqiang Liu <qianqiang.liu@163.com>
---
 drivers/video/fbdev/core/fbcon.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 55f5731e94c3..b062b05f4128 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -279,14 +279,7 @@ static int fbcon_get_rotate(struct fb_info *info)
 
 static bool fbcon_skip_panic(struct fb_info *info)
 {
-/* panic_cpu is not exported, and can't be used if built as module. Use
- * oops_in_progress instead, but non-fatal oops won't be printed.
- */
-#if defined(MODULE)
-	return (info->skip_panic && unlikely(oops_in_progress));
-#else
-	return (info->skip_panic && unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID));
-#endif
+	return (info->skip_panic && unlikely(panic_in_progress()));
 }
 
 static inline bool fbcon_is_active(struct vc_data *vc, struct fb_info *info)
-- 
2.43.0


