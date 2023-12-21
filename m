Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA24C35274
	for <kexec@archiver.kernel.org>; Thu, 21 Dec 2023 13:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LtTXoxmy19daOhcCb0Fw5y0qFyv3/b0JgqWq9bh0bcc=; b=D/pQg5LcVfGcXC
	PrlTpc0G1DrJ8eHCWGFYfczYNb5kiVv1jBq2WMzTdzpmLrAyhJYuPXseITC7rjGkYZ1oV2YF37oeL
	v4X5V/Rf4fih/fI4fZqBEpfVaK8voa9xvvjno1VdwKypLIBnjyHQsfkTq2vwr/WjXW05G/YlNvuZh
	oPxpjGo9jqI8A8O/KpkNpEk+9sHCm0Publ0zgZiNX0kA+VLF0HNmBSBY1F6uVUQJiFzadxIZGehja
	4cDvJ2EFyOy7EaWrJD3AUi1Wzwq6RBj/HXs4DJNqyAPWbnBkA+UkMoir/9/chpuCg43+agfSid20m
	xsxIZzMrRDKD4PfyWp2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGIkc-002tSQ-1k;
	Thu, 21 Dec 2023 13:06:10 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGIkZ-002tRQ-0H;
	Thu, 21 Dec 2023 13:06:08 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6d7395ab92cso461659b3a.2;
        Thu, 21 Dec 2023 05:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703163965; x=1703768765; darn=lists.infradead.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+JuPQ8wqNJlzJagstC7ldl3dtxeJYdR1Fvwuzn2zf0=;
        b=ijvmX/qg4nX1eLu9YEgqH6Yo2JneQi5mMWTYGZH/i48W4SFIhjgb9JUspinNZAcXUb
         J3GuRDcmtxPXgW3TckkWCUjaYQsCEi9bwRvxMWH0KyZz3fbrKD1nFDMN6LTDcQ0Rya3X
         6QVe/D5cExZn7ceseB31q33wz0d7GOPBzoxrgGLhIYeeQ0WqD2rRULNXxgnxOXnyGndd
         n3uUlNq9Usi+Xr2e4qNRm8JwzmIEFYsesLH8RvuLO2o2TKiLLrAQUCcmZ6+X0pBxpMq1
         nIZT0r3TGPsLuH2eN33iDksu0eJn24iCv0tPjABCr3UijRoYe0RIPfkby18M9kSo8Dvm
         wspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703163965; x=1703768765;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+JuPQ8wqNJlzJagstC7ldl3dtxeJYdR1Fvwuzn2zf0=;
        b=o7KaEOzFOk6SYoFt/m5JKwaIbW4baJgAg5vc8aYRqGjMnwutrpP3kcm+I8wJEaOL5v
         9vgInhu768lgybEsjIrk144pFnfox+YwdYFwA/6+Prdrf1NiimQfbGkigZ7gWw+w/x8O
         PiOFr6dFIYhH0H5PFlGXhaLtFfUvIbXwGUh3w94tGbWDBR+KPfpk0xnAq5/x60IoGoQ1
         bU98g9tJe3OvrLXAa/b7N6lhxoaU6trglNXLifVQj58CtbNxyKCAPTi3so2ca4CsN7j2
         fWdgiJwt91PVjee/cxGmq7go+HsUsf85WKJzeq578tDyXQlMz6cQnNs6uYstKCU/q425
         hERA==
X-Gm-Message-State: AOJu0YzUpkceAgSbtJvb3DxHsumWB8K9GEeQZSyI6DsFJhYOr1gjOsOQ
	MMuZSO+y9jetCpRZwDuhhrI=
X-Google-Smtp-Source: AGHT+IHy7BDWEANLiGAImZQLqW1L1FrUfcyW89dxfgSoRdp/XfgRewLLnqOMWdZvV7yq1pzZCQwpXA==
X-Received: by 2002:a05:6a00:982:b0:6d8:1493:5a89 with SMTP id u2-20020a056a00098200b006d814935a89mr5469741pfg.59.1703163964996;
        Thu, 21 Dec 2023 05:06:04 -0800 (PST)
Received: from ruipeng-ThinkCentre-M730e-N010.company.local (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id m2-20020a62f202000000b006d97eaba6cesm289326pfh.21.2023.12.21.05.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 05:06:04 -0800 (PST)
From: Ruipeng Qi <ruipengqi7@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Cc: zalbassam@google.com,
	dianders@chromium.org,
	mark.rutland@arm.com,
	lecopzer.chen@mediatek.com,
	maz@kernel.org,
	arnd@arndb.de,
	yury.norov@gmail.com,
	brauner@kernel.org,
	mcgrof@kernel.org,
	maninder1.s@samsung.com,
	michael.christie@oracle.com,
	samitolvanen@google.com,
	linux-arm-kernel@lists.infradead.org,
	qiruipeng@lixiang.com
Subject: [RFC PATCH 0/7] osdump: Add one new os minidump module
Date: Thu, 21 Dec 2023 21:05:55 +0800
Message-Id: <20231221130555.32551-1-ruipengqi7@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_050607_121333_5CDEED2E 
X-CRM114-Status: UNSURE (   9.50  )
X-CRM114-Notice: Please train this message.
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: qiruipeng <qiruipeng@lixiang.com>

Osdump is a new crash dumping solution aiming at specific embedded
devices within automotive or Industrial.
 - limited memory.
 - reboot as soon as possible when system fault.

In order to reduce dump file size and speed up dump process, it has the
following features:
 - no userspace memory, just designed for solving os issues.
 - no const data, such as text segment
 - dump core os data only.
   - bss, data segments which alloc static.
   - dynamic data
     - slub data for little size data.
     - some large size data.
 - compress dump data to reduce dump file size.

consist of large massive of uncontinuous data,so use binary data format
directly.

reasemble a standard elf format file with dump file and vmlinux, and
then parse it with crash tool.

Signed-off-by: qiruipeng <qiruipeng@lixiang.com>

qiruipeng (7):
  [RFC PATCH 1/7] osdump: Add one new os minidump module
  [RFC PATCH 2/7] osdump: reuse some code from crash_core to get
    vmcoreinfo
  [RFC PATCH 3/7] doc: Add osdump guide
  [RFC PATCH 4/7] dt-bindings: reserved-memory: Support osdump module
  [RFC PATCH 5/7] sched: access to runqueues by function
  [RFC PATCH 6/7] mm/slub: make slab data more observable
  [RFC PATCH 7/7] panic: invoke osdump when panic

 Documentation/admin-guide/index.rst           |   1 +
 Documentation/admin-guide/osdump.rst          |  94 +++
 .../bindings/reserved-memory/osdump.yaml      |  45 ++
 arch/arm64/Kconfig                            | 169 +++++
 arch/arm64/kernel/Makefile                    |   1 +
 drivers/of/platform.c                         |   1 +
 include/linux/buildid.h                       |   3 +-
 include/linux/osdump.h                        |   7 +
 kernel/Makefile                               |   2 +
 kernel/crash_core_mini.c                      | 275 ++++++++
 kernel/osdump/Makefile                        |   1 +
 kernel/osdump/compr.c                         | 252 ++++++++
 kernel/osdump/core.c                          | 608 ++++++++++++++++++
 kernel/osdump/extern.h                        |  13 +
 kernel/osdump/inode.c                         |  77 +++
 kernel/osdump/internal.h                      |  95 +++
 kernel/panic.c                                |   7 +
 kernel/printk/printk.c                        |   2 +-
 kernel/sched/core.c                           |   8 +
 lib/buildid.c                                 |   3 +-
 mm/slab.h                                     |   2 +
 mm/slub.c                                     |  38 +-
 22 files changed, 1700 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/admin-guide/osdump.rst
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/osdump.yaml
 create mode 100644 include/linux/osdump.h
 create mode 100644 kernel/crash_core_mini.c
 create mode 100644 kernel/osdump/Makefile
 create mode 100644 kernel/osdump/compr.c
 create mode 100644 kernel/osdump/core.c
 create mode 100644 kernel/osdump/extern.h
 create mode 100644 kernel/osdump/inode.c
 create mode 100644 kernel/osdump/internal.h

-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
