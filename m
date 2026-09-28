Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4449CCA5FA2
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 17:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p+oiZYN5anlVv9s+aMa0ZbcmkVGe0RnDqM3OKTw5q4I=; b=c/xx1cGiUBTqHM
	DmyzOo0T3r5PGkxUATOHB6UErw4LkqXQLsB+yT7JtRneTqxB2DZjq/5lQ3S7qJRm7eN50pjoGXwbj
	cL8z1H2HuClx7ywVkzCHli5OsDbIKsNByGIxVuZtgpYi0dsPGiiTxNeOEdpSRIDvoFJkyEjYXoYID
	tsnWD5zYchMPXBnhVt2CZ6K831Mr7bydZN6NrK1lSUzX7tUEe9Zjbcd33Ohkh9EfKtbgbwyTho0o9
	B3nCfnkru7c5+ah1kDqQAz8pPkD3A4hsEVsYBI59nHBdZC1YIpzuNhAOQPqJ4gBEIgjumzBYsPxh3
	GznS6shVFJbfl1goucPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFaR-00000001FNy-1Azh;
	Mon, 28 Sep 2026 17:56:23 +0000
Received: from mail-pf1-x464.google.com ([2607:f8b0:4864:20::464])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFaO-00000001FM5-0P5v
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 17:56:21 +0000
Received: by mail-pf1-x464.google.com with SMTP id d2e1a72fcca58-883aed04362so55346b3a.1
        for <kexec@lists.infradead.org>; Mon, 28 Sep 2026 10:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618179; x=1791222979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p+oiZYN5anlVv9s+aMa0ZbcmkVGe0RnDqM3OKTw5q4I=;
        b=JqHJo0Bv6WBxWP9gMC6bfZqWGVxlN9LRq/xV5mtCz/02eQmdV/mgPSPYJ40s5sK3Au
         +i1eltvs/GoZWI2MbRcxRut9UOUKSVCGgjIKaYqicWfpmEwOa8U+73iodSBTEINP94wx
         GNR5dFLSBiAVASjHlWgIaMUwzcv56h03p3mwan2kaz9orpvVT52hkFZMY1ZijFCKPh45
         ZJUkf+wdAK/5tB4cGiwCtvSKAv68vWd9JgDYcIIJOJ1rDsMOo1he1iupfCssxwJorBSw
         fQIpNapuzIb1ALdyXYIPKLIAvziPAmGelveCPq47ybifPyB/Dk7pRGh37cFVcPo2IW2k
         3u1g==
X-Forwarded-Encrypted: i=1; AKwUvBySYrYhjVdgz1Nx4pj65VMCau3Cszxu33QsbGhU/rL10wzb0iFvYC4dNBZ6oSKb5ExhMJa1fA==@lists.infradead.org
X-Gm-Message-State: AFuF++nRfb8I2N2RmIbgRZu+bncfXL/vyAEBBcEs12WHxPjWqYu5QncC
	kk7PAoHDHUMwDv2ARwVeRuxgl6v/z4HjQUqWfdYWtbsnLZmOK0zoEbcjA4h2z0LTO1W9IV+ihQ4
	nTf3rrTNQD6mahR44wu+dWCs41OQuv0OuIVpiZJT9AxZimRW8cO89WagS2HSTML438rwcHpfR2y
	po0+hgP+VoJr0RoHOMxG4PklEM+T1XgxmLRH7jc3cgU22eoNkes0xwojaXJl81UZybyQHyvbQM8
	zimWQ2VYk8w
X-Gm-Gg: AYBFou2UYoD2xFVRQxzU82F717iyCCBse7onNcnBJkarCamWg+8qvdpMix9zIdqPcg2
	u7dAjuUCqPV4KVieynXtGX2Y9jWFaXqxQVUubOiXjU2LbnmYrLhzCC6oevArcbh3tnUtozxBtAk
	F7Fywp8xt98RGYblhuDIlOZjYvsjc1S7ldErvfQW1K7TBbjvX2R3YxnsDD3YddFA3uDFUP9fp+e
	DuAor9ZPgabnnzpzupuobLpGLMmcMe7bRYWSvGTPw0pwMh60H0oXhuZP5udM4vyoKksnHMT2S4j
	6OtJTUCqea7fwvVNeF3SmEQda7g8jqnUpE6iRrYbOLyXcIr1dtui9yQTj0eGMdLWE6H+9ihDarL
	T0t2K1zpL2AZWwkZiQXlMDF5qEcdQNFzAas2Xf+O9fp5OXr2Q+LnvEaeFlA5RL/SlnKpE5Z7+vL
	e/zxleK7RWK5LJeq/hm5C741J2ledMLcDy
X-Received: by 2002:a05:6a00:3399:b0:880:8fe8:a3f5 with SMTP id d2e1a72fcca58-88561d2d39cmr34252b3a.22.1790618178869;
        Mon, 28 Sep 2026 10:56:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8807594ba4bsm5049232b3a.1.2026.09.28.10.56.18
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 10:56:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-343eadc0ff3so27825eec.1
        for <kexec@lists.infradead.org>; Mon, 28 Sep 2026 10:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790618177; x=1791222977; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p+oiZYN5anlVv9s+aMa0ZbcmkVGe0RnDqM3OKTw5q4I=;
        b=Kd3HCAL8OJzkGb1NR7B+eQd1SFSFJ+PFoLYtGttnUA880AKRgfvUBenaQ1pdk/yulM
         j2NHMWFNl9V3mTrfoA1+zKvq9NpJOOBFxWzAMTbyW6zPJMd05AkMQ9WMjvn4sBJG/HI0
         tOMSggL+ztqCK7mDIWx6l+XmFJOAjs/2FsIZg=
X-Forwarded-Encrypted: i=1; AKwUvByJ7Uf7vJ9h4NUUx2dT5Rc1ByuNcXmnxPwr8+/vFTD+WyBlQS5V8ras7S2yTdF18tZ+BPMruQ==@lists.infradead.org
X-Received: by 2002:a05:7022:d42:b0:148:ece:8cc3 with SMTP id a92af1059eb24-14b2ea0652fmr138524c88.24.1790618177028;
        Mon, 28 Sep 2026 10:56:17 -0700 (PDT)
X-Received: by 2002:a05:7022:d42:b0:148:ece:8cc3 with SMTP id a92af1059eb24-14b2ea0652fmr138487c88.24.1790618176363;
        Mon, 28 Sep 2026 10:56:16 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm26076069eec.10.2026.09.28.10.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:56:10 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>
Subject: [PATCH v2 2/6] crash: Notify pre-kdump callbacks before switching kernels
Date: Mon, 28 Sep 2026 13:55:36 -0400
Message-ID: <9ef573cdbbf5e659eea16fa23afeaf2488049198.1790014793.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790014793.git.zack.rusin@broadcom.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_105620_135324_3B64E55F 
X-CRM114-Status: GOOD (  11.25  )
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
Cc: linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Fatal x86 oopses can call crash_kexec() without reaching panic(). Run the
pre-kdump chain from __crash_kexec() as well, after finding a loaded image
under the kexec lock and capturing the original registers.

This covers direct crash entry without moving all panic notifiers ahead
of kdump. A missing image or failed trylock leaves callbacks uncalled;
the shared guard skips callbacks already invoked by panic().

Link: https://lore.kernel.org/r/aquttpMVKX8e6zGB@pathway.suse.cz
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
New in v2: cover direct crash-kexec entry in a separate core patch.

 kernel/crash_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 2b36aa9fade0..5d9fe9e00f39 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -23,6 +23,7 @@
 #include <linux/objtool.h>
 #include <linux/delay.h>
 #include <linux/panic.h>
+#include <linux/panic_notifier.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -139,6 +140,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
 			struct pt_regs fixed_regs;
 
 			crash_setup_regs(&fixed_regs, regs);
+			panic_notify_pre_kdump(NULL);
 			crash_save_vmcoreinfo();
 			machine_crash_shutdown(&fixed_regs);
 			crash_cma_clear_pending_dma();

