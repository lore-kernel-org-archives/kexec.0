Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FFACA1000
	for <kexec@archiver.kernel.org>; Sat, 30 Aug 2025 17:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nYO/YmS5jL3ZM2fX1JrJ0oWdxchh893vzLzAxL1PuNk=; b=fTATSrPfKOlo1isRN20Lc+wrBW
	mTO5RZ3Bk0EJhWcp4p/kb5CIx5DzoN8puGLLOt63WizQvqIUpqahhvsfouVyMIUE6LKVEgIuxSaec
	I9bF3Qro5h2CxFyU5Y3zKpbBzwtE5NHrfzfdxHNcu6ge4GSXGxxgMw1nk/Qj3plyJCYE8zrorW0gR
	Plti5yT4oKh5MmAgZB+qP/iU5Yn4k0xQUJA3EbBfqKW2fJanu6x83aoWgmyHBwwUI5HI8OFoQHuFx
	oSARng+Ho3i3tJDM7PQfcSB0DmFLMNfjBv84f8d7ckSEbPiqSlvxj2hBjiCZmzqjR8ksMz32p9Bne
	VB5u70Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usPg6-00000008G2T-2Eub;
	Sat, 30 Aug 2025 17:47:50 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqMyT-00000006jyN-0qcs
	for kexec@lists.infradead.org;
	Mon, 25 Aug 2025 02:30:22 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-244580523a0so36581305ad.1
        for <kexec@lists.infradead.org>; Sun, 24 Aug 2025 19:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756089020; x=1756693820; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nYO/YmS5jL3ZM2fX1JrJ0oWdxchh893vzLzAxL1PuNk=;
        b=fsH2AyvUbxdEZ1Rmsobpi7+OH2ZZrsrgQYXY7GkD6Z+/IL3kDy7KJ1+P+K772kHj85
         HgZYHTn3GcolbX4x9uXRomm+ken8hml+BXrZJglp/0zLYvvHb0GYcWiuKBYQVL4VEJc0
         eJnOAPGG8fHK/rD10X54TJsxyglzr+gSOAO9v/Oqfj5Rl4mGiQR3G1g0MW8IK3Y8teUu
         shGMUHQL44fbAG8X5UqHbQGM7BwVGIYaxg0pkuLSFpo3PVUK4QyfS3uu3fFvkUd+hRQc
         zzAqst6RdqKKZZmgekZxTn1Sr7iESk99usgjJmU2OChFVB/s0KH2dYK31hiz7gj1KAPj
         6BBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756089020; x=1756693820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYO/YmS5jL3ZM2fX1JrJ0oWdxchh893vzLzAxL1PuNk=;
        b=gYL7EqsE5e3Pi6T6TqU2f7BPBPPv0sVWFmOYmKSd+2lkBSoHDo5+xBfLWqbTh5Kp1b
         eQxEykOfEj0vfULxXh3kbif5ZgaTs3Ok9s7MYJ1ZO397lw0im50qgG9LmUmYRoKaLS4o
         OOqvmx1SUt5pHQ1v9hZqsRuSUdt2Z8dA7anr48uyKd+u33RYrcCrUc2BdQGRi76YT2Co
         hE/IMJv3JN9UnItygoza3+XDZik0r5ZMlrlz9jeAraaRSDjE30KJqLd+FAAkxcV1w2nL
         TIUP8KdlEU+/quM0fMITMjo4tKTdhobwF44WSAQTNge6oR7m8OR7qYpy11AlgTR4DRYI
         Bjsg==
X-Forwarded-Encrypted: i=1; AJvYcCVKIpU3tzlRdTa8CM0f0gTQ9Fm2jmtgXiJCO6oRoQnRlodsTBduAOS0BRxmgTMsERrDmhhkew==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy2aHZuyUpbZUuSSH69xMv9mvITziZzt6LoNwKp0DV1C78E9M0h
	AEPLigMRYLHp1bDnPGgRu3wa7CIaGOpOCPkrk8sXNwnmz51AEYShRnWJ
X-Gm-Gg: ASbGnctLRTfbqyqlGa3MdOG8eYcqF+Kiz7eksowxj6693LWOyG96bwmaYbonRRRfQqH
	Rjs44yDhFM/3er3rVEQUK5DJLO1X+tMYbXC1lJ+Sm0VMW8eQMFKJCvzUdP+7jtMXN3EhBP4aspH
	uM6ON/GLZIMbT8T53aGNiDP1LNYTvxjh28X83ucJGEA9SirTRCZYBkFI8EO/PxItpakY3RpGQJz
	AAJ4PgbIjYXhqGtS0NR/+FApaHSLZujz++30ODNvz3tVsa2BxwiQ9QAS7XNSZcu4E7HtUShavOt
	/d1Ce+HGovQDoH3Y9ZfF7q4apmVzJsJ67cDhz2vF4OqtEOti/TnbVE76cx7xiqsIT3FtX6hQ0EQ
	xZguBPUxovEMsjz33PzGVG+LryTIB+TC9wYFXdrbAPh5U1R/vZDdXTLPH5kg7zrUlObyl2mTTOt
	U=
X-Google-Smtp-Source: AGHT+IGcXL928gw4jZtFeS2GjzwHFx9joFXeGHPpEdrU46U9OgXBCfZHOfrutnNUpiMm/H6uh+w8Yw==
X-Received: by 2002:a17:902:cec2:b0:236:9726:7264 with SMTP id d9443c01a7336-2462edc37a2mr159709745ad.5.1756089020026;
        Sun, 24 Aug 2025 19:30:20 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687af234sm53905175ad.48.2025.08.24.19.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 19:30:19 -0700 (PDT)
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
Subject: [PATCH v2 0/9] panic: introduce panic status function family
Date: Mon, 25 Aug 2025 10:29:28 +0800
Message-ID: <20250825022947.1596226-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250824_193021_264765_D626094B 
X-CRM114-Status: GOOD (  15.24  )
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

This series introduces a family of helper functions to manage panic state and
updates existing code to use them.

Before this series, panic state helpers were scattered and inconsistent. For
example, panic_in_progress() was defined in printk/printk.c, not in panic.c or
panic.h. As a result, developers had to look in unexpected places to understand
or re-use panic state logic. Other checks were open- coded, duplicating logic
across panic, crash, and watchdog paths.

The new helpers centralize the functionality in panic.c/panic.h:
  - panic_try_start()
  - panic_reset()
  - panic_in_progress()
  - panic_on_this_cpu()
  - panic_on_other_cpu()

Patches 1–8 add the helpers and convert panic/crash and printk/nbcon code to
use them.

Patch 9 fixes a bug in the watchdog subsystem by skipping checks when a panic
is in progress, avoiding interference with the panic CPU.

Together, this makes panic state handling simpler, more discoverable, and more
robust.

-- 

Changes from v1:

  - The commit messages have been re-formatted based on Baoquan He's suggestions.
  - The panic_in_progress() check has been moved to be the first check in
    watchdog_overflow_callback(), as suggested by Yury Norov.

Link to v1:
https://lore.kernel.org/all/20250820091702.512524-1-wangjinchao600@gmail.com/

Jinchao Wang (9):
  panic: Introduce helper functions for panic state
  fbdev: Use panic_in_progress() helper
  crash_core: use panic_try_start() in crash_kexec()
  panic: use panic_try_start() in nmi_panic()
  panic: use panic_try_start() in vpanic()
  printk/nbcon: use panic_on_this_cpu() helper
  panic/printk: replace this_cpu_in_panic() with panic_on_this_cpu()
  panic/printk: replace other_cpu_in_panic() with panic_on_other_cpu()
  watchdog: skip checks when panic is in progress

 drivers/video/fbdev/core/fbcon.c  |  9 +---
 include/linux/panic.h             |  6 +++
 include/linux/printk.h            |  2 -
 kernel/crash_core.c               | 15 ++-----
 kernel/panic.c                    | 71 +++++++++++++++++++++++++------
 kernel/printk/internal.h          |  1 -
 kernel/printk/nbcon.c             | 14 +++---
 kernel/printk/printk.c            | 37 +++-------------
 kernel/printk/printk_ringbuffer.c |  2 +-
 kernel/watchdog.c                 |  6 +++
 kernel/watchdog_perf.c            |  4 ++
 lib/dump_stack.c                  |  2 +-
 12 files changed, 91 insertions(+), 78 deletions(-)

-- 
2.43.0


