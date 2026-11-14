Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDD9606A33E
	for <kexec@archiver.kernel.org>; Sat, 14 Nov 2026 03:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rDm4QTQO;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pQp1k5/c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=/G7/lmek4y2FIJhQPQXzBX6rPtR2uzbHmwhsN2tO0nU=; b=rDm4QTQOg7qYX9AQENBkzrLUKp
	8Q1TM2mDaGC1Kl+sgLIEWY896R+hWVrStJqBCaiJgS6nCF7L7oW6wsGTPmLnDMNd6A5zUi+FkgPGP
	D5sAhN6FpK23mdqieEgZ4O+iQxeg1vT2yBYEqb5pSCEgXvOkCob9tujcU1+g0LPEalEtLPrXkxqZq
	Psyc+fjITox+QGjes0tFBRLzJRlyXkFl8nYHBBzjTTM9+W1PyV4ol1ufoYGyVYNXtWMTimGNmCPS3
	hMdXKSayLTcsljRS7XxAwFOj27a6QYPY27T8w/Q1UZxUNgiQ+6NdX/i6CXvIPhpwxC9tPUt/velkm
	UO9J6Z1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4lH-0000000FJVZ-16VU;
	Sat, 14 Nov 2026 03:49:07 +0000
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS4lE-0000000FJUk-3mDO
	for kexec@lists.infradead.org;
	Sat, 14 Nov 2026 03:49:06 +0000
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso2101088eec.0
        for <kexec@lists.infradead.org>; Fri, 13 Nov 2026 19:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794628144; x=1795232944; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/G7/lmek4y2FIJhQPQXzBX6rPtR2uzbHmwhsN2tO0nU=;
        b=pQp1k5/cPR2iibmWVZ72ZtpoNUVK0iWJUAptM6K1EbJFbib7cCtye6OsAbNl/mTf0s
         CECl/n2pP47wb99VrxptgxaemIzs5w9r/nGnVyTuL3kcBKiIHsJB4D4dZZBeLK5vsm1w
         /BjXi9adI15NoMfFz9VkKrhDXo2Z8zUiMF3fCrH/8X42lxJe6+pwXCzk6roM5sLe9yNO
         n3V5ogzHWFZPpGMs/hBISsCYR563SMDCt0OXCB2PjPwPNnKdXQNeeMTnn0KP17Ah5Xy7
         2i+TbBfNfcq5d9r0Unk7r8J+l/pj/Xx3BiePDGwKU7ks1M5uex4bu8WxtrUcdRjiBMgx
         OJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794628144; x=1795232944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/G7/lmek4y2FIJhQPQXzBX6rPtR2uzbHmwhsN2tO0nU=;
        b=E9DRyjzxOoe1m9tIg+x2OiqaQR/4mWNOLmlFcf5JdjyQ7BHkwhXNd8XIeTl2Sc17yS
         YXEEUdNsL702TUHrImrUUz2FfJFrmWWgRooUceFVz6X3xWDuKh/Op0nDqnD4pRC45wE5
         5jwz1y4cxlywzMZcIwHHAGOLil6O6K4qNdwpLhZh4X9Y/WWBP4zAAgSFZ0px++ThJfIF
         wNh04EkVwdQb76AdXf30Tbwjt5vrmqv11xWtYig+UI6T6BsOHoD+AOJd5SQljmqx5wcC
         +58QXbAxqnI3Vz0xFZDT23x3+Es62tfG/hnniZqSlP2h2vP1ZWRyN8CXiSJZ9AVFwtTn
         zH+g==
X-Forwarded-Encrypted: i=1; AL+hErHgFGtqllWl3jtI+FsIv8qNK/qJeNcUcAzTKeN8jLDfYq7AUgvZtjH7g6juSSF3H1LJXcIbLg==@lists.infradead.org
X-Gm-Message-State: APuU4Z8/mO16bXh7xPDkIkj/9dtYt6V/z9M6duoHhyXNdb8pDV5ANn0e
	qyD1g9I8IeUPOnEc4dMBHozVQAf6p+KOe0I3sAxG4nYOIPk6rFTuAflW
X-Gm-Gg: AYBFou0EOlSkmdDl7OuLXEx+zWzJyFF5QX61tXIDqSIVZWIl6gICsb2pZifG8cHzr9H
	UFn0XFwbfI5uMrr6ITzWy9uaDJuMx4JDvAtsNCbaAU35y/R8YZy5PELHV/2RzkBtccec4tfFfVz
	Ivl0XeYmrcFAtV8dhU5nF5MLut6MRY/HfY/rxWeJzZFoZMFzQRmX2i1e5BFIxhGmonldEp+Yt3q
	2i2chin/WtN9LnjbYUquDxpf39PtxwhgqIci45XFaQVx1nAKhkyE/K/oVdq+FwGoi6RGvSbQL8a
	AHrHfi6n1a6Lbw9JCfaj7ydkTAwZvWgc5b3cNNl9KGMTvoy+yRBVeKZUpgzIkQ5dUunTHqKfDR2
	8a4TCxAUJFI3y4UC/Dj+9q2BqWypcdp6m7tRoaf0aM6HZy0sZNoOvq8m8w0HuyZsnoQSMUvRSFu
	v5yInfbNbQcdJWKzvYENCn0JDEaTrMKghScW55I0m9PKewpbF0yR1hTiJq0oDuZyExQhCmpcv7y
	cLiQeMSMx94rtIKhWmPB9S25r90jAapI8TXgA/wDJfyq+qp+6PbnlWO6hqtkClHFYj3QDLFKzf5
	pkPMyALNNP4ojGOo3xSx0if3MZ+2FqyWWfawhfXHbcMAWfrGvC3mK1tSuR8yrkQUXWc7gTAM5iN
	VcY3c0AgtpQU5
X-Received: by 2002:a05:7300:fb17:b0:36f:6d81:3f99 with SMTP id 5a478bee46e88-3796676fd59mr3950614eec.7.1794628143470;
        Fri, 13 Nov 2026 19:49:03 -0800 (PST)
Received: from pop-os.tail4adac7.ts.net ([2601:647:4084:777d:f1b2:179a:680c:6345])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm19901637eec.21.2026.11.13.19.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:49:02 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org
Cc: Song Shuai <songshuaishuai@tinylab.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Han Gao <gaohan@iscas.ac.cn>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Mike Rapoport <rppt@kernel.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Guo Ren <guoren@kernel.org>,
	kexec@lists.infradead.org,
	Cong Wang <cwang@multikernel.io>
Subject: [PATCH] riscv: kexec_file: Keep segments out of the new kernel's PMD padding
Date: Fri, 13 Nov 2026 19:49:00 -0800
Message-ID: <20261114034901.107028-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_194904_935286_924C526F 
X-CRM114-Status: GOOD (  14.48  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Cong Wang <cwang@multikernel.io>

A 64-bit kernel with STRICT_KERNEL_RWX reserves itself up to the next
PMD boundary past _end in setup_bootmem(). load_extra_segments() only
keeps the other segments above kernel_start + kernel_len, which is the
unaligned _end of the new kernel, so they may be placed in that padding.

The segments are placed top-down, which normally keeps them far from
the kernel. A kdump kernel's segments are confined to the crashkernel
region though, and when it has little room to spare, the lowest of
them, the initrd and the device tree, end up in the padding. The kdump
kernel then finds its initrd in memory it reserved for itself, drops
it, and panics without a root file system:

  crashkernel reserved: 0x000000017be00000 - 0x000000017fe00000 (64 MB)
  Loaded kernel at 0x17be00000 bufsz=0x1c40600 memsz=0x1cb1000
  Loaded initrd at 0x17db58000
  ...
  Starting crashdump kernel...
  INITRD: 0x17db58000+0x022a4000 overlaps in-use memory region
  ...
  Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)

The load itself succeeds, so this only shows once the system crashes.

The kernel being loaded may be any version or configuration that
reserves the padding, so the loader has to keep clear of it. Start the
other segments at the next PMD boundary. A crashkernel region too small
for them now fails the load with -EADDRNOTAVAIL, and one with enough
room boots the kdump kernel with its initrd.

This was found while testing multikernel, which loads a kernel with
kexec_file and hits the same overlap.

Fixes: 809a11eea8e8 ("riscv: kexec_file: Support loading Image binary file")
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/riscv/kernel/machine_kexec_file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index 26cd2a8bd0cd..0d2d43a7dbfa 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -251,7 +251,8 @@ int load_extra_segments(struct kimage *image, unsigned long kernel_start,
 	char *modified_cmdline = NULL;
 
 	kbuf.image = image;
-	kbuf.buf_min = kernel_start + kernel_len;
+	/* The new kernel reserves itself up to the next PMD boundary */
+	kbuf.buf_min = ALIGN(kernel_start + kernel_len, PMD_SIZE);
 	kbuf.buf_max = PFN_PHYS(max_low_pfn);
 
 #ifdef CONFIG_CRASH_DUMP
-- 
2.43.0


