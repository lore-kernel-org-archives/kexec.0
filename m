Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815B5CA1000
	for <kexec@archiver.kernel.org>; Sat, 30 Aug 2025 17:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G+OueiTUtaQ+cl4byHqQJI84zYdm0M5wQwtNQy1rpWk=; b=QnSx7yjywrYGHOUrPPzhlwulNq
	KZRFUi1taMt8uBB9pmPXr/Aoh7l1x3ErNRwx8ClTPI8nj5zvMbRAbW4ltgsf6Y3FbKK9GT/+teDUU
	3mOfdOJHAgsxc79EbRNJYiMpfvnl96yh38vxm9xJrnvOXVvV5BR0TO6x/kAzoDAq56Ki0P4Tls86/
	yvd1N5pAB4l1irwYzAQyAxs4ro/BOAOPQ0sWQEMQjU9txjunrVP3RVXIGz69cb0lB4zIA76w++5B3
	H1zc+bwsyUMiiTsd2uUJldpgFTI9bKaHt6VFJhHIZZ4vUA5BPwB31Shji+yacnfFWcV8sWBMjHKBw
	PDj6A+jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usPg8-00000008G4R-141A;
	Sat, 30 Aug 2025 17:47:52 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqMzD-00000006k6P-0vl1
	for kexec@lists.infradead.org;
	Mon, 25 Aug 2025 02:31:08 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-32326e5f058so2577982a91.3
        for <kexec@lists.infradead.org>; Sun, 24 Aug 2025 19:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756089066; x=1756693866; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+OueiTUtaQ+cl4byHqQJI84zYdm0M5wQwtNQy1rpWk=;
        b=I/tXDRemRfDUhPF7SgbNN2Qd8gEdeFfZNQPPmDpUuFhXMMVu4i6SZDfvY/4PplQLfV
         2kJ8lmyU0TjXurcRM/u/7Cr+m8E9bcFOA64ehVWK0AQfFHUeJVWE8cmx1c4r9TP8+D7f
         BLjtzbICu602Zwradtp2YrfJjfMgJCw05l9/UKa7jjQQcr2Oyin85nMxbc7//SPoBQ6+
         /JyOy4/R1b0P/JskqRh0wNF3hdsLy1c4E9FGs7w5MpFGo0fkc1nr7gSlXA4UT0PyPviH
         lnrwKo5lW7EqmlnLiBaNmq1SjGsofEOD4a+bUVZFDR7W1uyUIs7w45CsQqWxiUWfo60n
         xHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756089066; x=1756693866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+OueiTUtaQ+cl4byHqQJI84zYdm0M5wQwtNQy1rpWk=;
        b=wtEfxMmDPECVVLStTsY79OpXBiU1aC0Tvlfnr0l6ZCFjL6CmOpj9f+9MFkPmO66oXf
         iJPe32mER7Z/Fkpi8DcPdyg9FDbhOIrWu7EjEuuotySF/PJgLyO1TW7omkjMhahfRj0f
         9gSgXPeeJorWEGGAOfjAMLN3ii6eIPuJFJ2gLXP70dww+REIiLRcL9BxCsGdCdL9hH2C
         Qr1MiFaSATbKf4SLt76QPsdlU12+V/V5gxk0tahc+iaWRDnWSfODqwVArM08XNrsZWlY
         s+hHJXCPnKerhbiB3qXTWFRb0sAoPEMoyKucQAThMn68sBa8uiE8yyn9cQJ7J1w5xjDJ
         k3Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUeCkdI5qSCPiEsqNYhcjTiE9ImSBW1NvXKxGWS/GcEBV7vQ/qV/fgldpgxFoby3Z0CidEWBA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw2ZuU90jWMWUlk8CO7gt9ScVyXGqc1oiBxon8NeFyLT5UutTcW
	unOrDFqK6o0fdn/iQt5U5HkCCftPlhqFnmpgKATw43VxOMBCgPQ5jAAJ
X-Gm-Gg: ASbGncv/XN3RJDpNHZIE9JFvMBH87gl4BFDuPDjHoxJkdpMsLOCiSWDp1LsP2g+rnaP
	dOm9Ty3TRKr0LrT5/2nqKp4j6SODHawrzO2l7jZEnHDPHYglps1m8JQGtkgaHsQRMn92GIBwBoH
	P4OOotxP+Db7LKs+sUd2Vb3RMwjGwvsYahgznqZa+hesYcfoaLTEDDdJsp2GKYTKBjtlqL4m6Nr
	rxyuMPXXiJLTEpAGilzrBchKq1bh1kmJ69UBU3jNA9A+/2o6du5VeYC6pGhAwHq+HT5/B7Lu/DE
	U/DQNhWuF/X1S4F51Qk9j8a1AozjcZ7+BRmzqiitltz+rDXMf3i7fJ7DnEoFyaqtIu4OdLIT+6r
	ZsKRCq3TwOUAAfM8wkIYNMqqxICSCM/jS4UbFETMqifCqF/d5EFiOzRV5+au+r+R+Xf82U3ttay
	g=
X-Google-Smtp-Source: AGHT+IGGTCfkkziinXGfm5OQ/klvHSQOorcEs0SZvFKbeIqW5aKv9q5QfSmua5wLs2b3iOYngv2Dpw==
X-Received: by 2002:a17:903:37cb:b0:240:1bdc:afc3 with SMTP id d9443c01a7336-2462ef6f678mr124826755ad.44.1756089066318;
        Sun, 24 Aug 2025 19:31:06 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af234sm53905175ad.48.2025.08.24.19.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 19:31:05 -0700 (PDT)
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
Subject: [PATCH v2 4/9] panic: use panic_try_start() in nmi_panic()
Date: Mon, 25 Aug 2025 10:29:32 +0800
Message-ID: <20250825022947.1596226-5-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825022947.1596226-1-wangjinchao600@gmail.com>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250824_193107_259596_D5DAD429 
X-CRM114-Status: GOOD (  12.21  )
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

nmi_panic() duplicated the logic to claim panic_cpu with atomic_try_cmpxchg.
This is already wrapped in panic_try_start().

Replace the open-coded logic with panic_try_start(), and use
panic_on_other_cpu() for the fallback path.

This removes duplication and keeps panic handling code consistent.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/panic.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index eacb0c972110..cd86d37d124c 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -355,15 +355,9 @@ EXPORT_SYMBOL(panic_on_other_cpu);
  */
 void nmi_panic(struct pt_regs *regs, const char *msg)
 {
-	int old_cpu, this_cpu;
-
-	old_cpu = PANIC_CPU_INVALID;
-	this_cpu = raw_smp_processor_id();
-
-	/* atomic_try_cmpxchg updates old_cpu on failure */
-	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu))
+	if (panic_try_start())
 		panic("%s", msg);
-	else if (old_cpu != this_cpu)
+	else if (panic_on_other_cpu())
 		nmi_panic_self_stop(regs);
 }
 EXPORT_SYMBOL(nmi_panic);
-- 
2.43.0


