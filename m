Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04DDC46CD2
	for <kexec@archiver.kernel.org>; Tue,  2 Jan 2024 14:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4JGvaoj4Hbw6YbaCGDeCN13W99Mj+eKujMJqjHA8l/o=; b=CPl0TkVFXflqNt
	iEP3LYZlNZ67p/a54L4KkSC96okHyHGmBUif8vPHSe+RD1+8LlFwT3f5YgMEcKASnrZwnkF58NCNU
	bj4El0bfaMQfkErt1aU0uVOgvDXhtF5RRGYQpvfIhYiwoEOrax0NrSD0lrDFPmMwjjh8SQBNnnma5
	/mlC7rl9HTPHNAigb4OfJxOCF4r4cskBmlf/4qWNUXE2V9LwFc7DHvTtc+ZFTO7AU8jT2W42/j1jk
	bz4Rysg5FnnvMthHYkbp7jTT+v7hGPg14/XpmW+bNmG4kwJU9hk4Dti74kZcu8ZusqMN6QqVyMWXq
	KxAS6tklz2YoyLYt3lrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKg5Z-008Hps-35;
	Tue, 02 Jan 2024 14:49:53 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKg5W-008Hon-1j
	for kexec@lists.infradead.org;
	Tue, 02 Jan 2024 14:49:51 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-28bfdf3cd12so3683524a91.3
        for <kexec@lists.infradead.org>; Tue, 02 Jan 2024 06:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704206988; x=1704811788; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YDhrdw2EFatZsZwpVBL+5yckJoyULeS7zHGr7sK85zc=;
        b=DsMq4Riza4VAcOcUdPj5CyK+pNU2TRbTQxR+a/jSJr7NL4pkyBwksfFZgyfOGGC1wz
         gN0m1b94ny/NZO1oTZraCWkMHE/Nyq99eG2LIblXBMIRX6AssmJvMMXekYRm0gsafP5F
         xnNWAkhQAFFrZQT4dZWozwNzB0+/y60SxKGfejupmGBOtG5F2ucAqucGaZt+0rShQo/D
         1aDVUDtIUvRPdDkVxO7XsLOhcqKT96t1mjN7gQciAuHRgehfIMWKWVXu2kirowJYBQpF
         DhIKfGSbY1xBwbSWgrgMb9GzFM7MqqmezqfXejUmWJG4kYQBzxbPXVQ+dlUoDmsOjxsS
         Ne+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704206988; x=1704811788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDhrdw2EFatZsZwpVBL+5yckJoyULeS7zHGr7sK85zc=;
        b=mqUrX3M3k4dQ9/B34+D3B4o1MLzz9kXq2qMYgCRbYFovJ2Ev2PZFUqUXeBk6B9jiLH
         acf4TOfvZyVOlXsCn8+fN3ew6QTwP6H22ZIf96h7or+sj2DV5YVSILRC3XRGMU9Jc8Ry
         RlsDH7b0wXIx++CT73FEWLUnC1IX5AWwmcpBnCcsGp0VifqGuZ7AbUZBKr9nu36gyTlP
         T8QKcl7/vGprtsC1x68OvfPhQJ4FZJne1JVolbrC22C2YEJI2G2LwyLGdWWjK83E4SbL
         cGpbPKkIvrZ8l2g3lVPQ1hMk08UDCszGZml0fWSxn+j5POiPV9jk1RQMQqQTuM0qiNnH
         Xw1Q==
X-Gm-Message-State: AOJu0YzEdNLxjPGc//poG5m2thDGq2/9tgYtgOacZMwZ13wO8LqY3aKU
	LpPrDWKKbMZ0GNpaB6soeDY=
X-Google-Smtp-Source: AGHT+IGzJFyW9a5iYIIvP/E1B6Aq5OU4Dd2tRSLGwh0HbPDRNg3iINd607/Z9goxsovbYD0ClJHHwQ==
X-Received: by 2002:a17:90a:4708:b0:28b:be23:67a6 with SMTP id h8-20020a17090a470800b0028bbe2367a6mr5269342pjg.80.1704206988582;
        Tue, 02 Jan 2024 06:49:48 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a005300b0028be216595csm25836878pjb.4.2024.01.02.06.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:49:48 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Takashi Iwai <tiwai@suse.de>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH v2 0/3] crash: Some cleanups and fixes
Date: Tue,  2 Jan 2024 22:49:02 +0800
Message-ID: <20240102144905.110047-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_064950_572856_96595EA1 
X-CRM114-Status: GOOD (  11.60  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

This patchset includes two cleanups and one fix.

v1 -> v2:
  Patch 1 and 2 have no changes.

  Patch 3 has no functional changes. I just squashed the following patch
  into it based on Baoquan's suggestion, to make it easier to merge.

  [PATCH] crash_core: optimize crash_exclude_mem_range()
  https://lore.kernel.org/all/20231219163418.108591-1-ytcoode@gmail.com/T/#u

  The link to the v1 version of this patchset is:
  https://lore.kernel.org/lkml/ZZPMLextp0n3lwbD@MiWiFi-R3L-srv/t/#m4d20eee5aee48a1daf0a754b5570afb4b5d4fa03

Yuntao Wang (3):
  x86/crash: remove the unused image parameter from
    prepare_elf_headers()
  x86/crash: use SZ_1M macro instead of hardcoded value
  crash_core: fix and simplify the logic of crash_exclude_mem_range()

 arch/x86/kernel/crash.c | 12 +++----
 kernel/crash_core.c     | 80 +++++++++++++++--------------------------
 2 files changed, 35 insertions(+), 57 deletions(-)

-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
