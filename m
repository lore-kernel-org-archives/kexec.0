Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EF4C43334
	for <kexec@archiver.kernel.org>; Thu,  7 Jul 2022 23:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KcyCnWFfsIeLHETKccFqYGuXaZOV9IHMNFrS1Xx+Dog=; b=GgIY4AQcHYVZ+B
	I+ycqVwvvADdHl5EhJg+eD1WzdTAESC93asIGIpKk/mfoLPuij+IMHKOQrPN20rJ88Pb1daWNTDIk
	WjgPQ21/RlTcpQ89QII4ATnrINsw2WenFgu97zRJAiwW3vWdKfBd/j+cYV+O6gU8KEQnPrvWv6iLp
	MmTuepvxUSrSDrxchkVJrYN7PkIyDdlGBL5BS4yl95DUhBZHFYT0aBwlbCk18QxEhQqv+LHxe4NlV
	iBUFvGe9TbkLY2P5lGKWEssGABKDu5fsq9y/hl3a4S+EtkiJLCqKVAmaXaaKxl6/L2bDaf8n51H5o
	w/jo21y9v8Ho67EWXcNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9aj3-000eqC-FF; Thu, 07 Jul 2022 23:16:01 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9aj0-000eoq-TY
	for kexec@lists.infradead.org; Thu, 07 Jul 2022 23:16:00 +0000
Received: by mail-wr1-x429.google.com with SMTP id v14so28313676wra.5
        for <kexec@lists.infradead.org>; Thu, 07 Jul 2022 16:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=izEW/QlWsYwAv1ZochY3FjaPww57C5kdq40cLp75WW8=;
        b=bN/UI+7lQeB65atynzKqp9nMLADS1qCkhGg5AFy7k9JTlnDD+Zfmk48B2FRQd+hC0Z
         U4CKu5nG4vjGJCXcV2zhrMRVj5UyORVGZ0Wvcq6fki/MJbwmIrZUPJ6dJ5thhHkq+45r
         trErrsYkpiZKrv56HldNIjMgl5ylRyWM2frA870ii9xsEWsxGBxvQw9GZER8kL4TcltL
         A9S9IZChyrVI1WMBCy00qnuXGolCRiTd3a6aLoa4W8Ximf+e2l9LEQ0uIXtbfAokdAId
         ANb1ZhVUMrfkHBXJMCKs8voDoToWbTf2WtwrcXSUQTDgagsSYKsBMdxLfxtkqPy6PGSe
         /AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=izEW/QlWsYwAv1ZochY3FjaPww57C5kdq40cLp75WW8=;
        b=VtglQMW+dwj37daRFHJpWipIUr+dnc8xP3HElpvTdBfKulh2UsMSjuvrVGs5ZUC/5b
         KHZnQkIvwyzblfwdD+gY3MKaMeH0fcjKBkzJjZ1zqFSMsRuzn42ywsHLS1CAeV2HkO7i
         m5BBzGkVQrnqZ2vwDS1zZcwY/Uty2F4wnGakKchvgmJknkP1tz3+Eq6DEJ/etFcwsxXc
         tWUMvEU35SvjdbgNA3pzpD3ysdDvxMgx3CIBH6WsMCn+ZbKH+rR97gy+y4wb2kBw5mGs
         g0Vu8A3Owgil9mO/SN16RBTuqXq0Ym4TvhkdzxgpKFikPCboz33q5sIjP6l2K2UH9aaM
         Ty9w==
X-Gm-Message-State: AJIora+5LN1ELHBhhCBKcDpmH+ZWTKGw9j6VQvwVTVXx8O3oIT2khJUR
	l0fAhvHrKb6OpDWMbWjzgC4=
X-Google-Smtp-Source: AGRyM1vb1t9Pd03LkoGzBnp8Qn8oJ174NaaaEi0Rd2+luP9y+glv1E3K+ONHUCDrq6cJFue2klElbQ==
X-Received: by 2002:adf:f9c9:0:b0:21d:2cec:63e9 with SMTP id w9-20020adff9c9000000b0021d2cec63e9mr276271wrr.301.1657235755382;
        Thu, 07 Jul 2022 16:15:55 -0700 (PDT)
Received: from localhost.localdomain (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id r129-20020a1c4487000000b003a0499df21asm229785wma.25.2022.07.07.16.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:15:54 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2] kexec: Replace kmap() with kmap_local_page()
Date: Fri,  8 Jul 2022 01:15:50 +0200
Message-Id: <20220707231550.1484-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220707_161558_984584_AF7E40E2 
X-CRM114-Status: GOOD (  12.74  )
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

The use of kmap() and kmap_atomic() are being deprecated in favor of
kmap_local_page().

With kmap_local_page(), the mappings are per thread, CPU local and not
globally visible. Furthermore, the mappings can be acquired from any
context (including interrupts).

Therefore, use kmap_local_page() in kexec_core.c because these mappings are
per thread, CPU local, and not globally visible.

Tested on a QEMU + KVM 32-bits VM booting a kernel with HIGHMEM64GB
enabled.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: A sentence of the commit message contained an error due to a
mistake in copy-pasting from a previous patch. Replace "aio.c" with
"kexec_core.c".

 kernel/kexec_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 4d34c78334ce..6f98274765d4 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -814,7 +814,7 @@ static int kimage_load_normal_segment(struct kimage *image,
 		if (result < 0)
 			goto out;
 
-		ptr = kmap(page);
+		ptr = kmap_local_page(page);
 		/* Start with a clear page */
 		clear_page(ptr);
 		ptr += maddr & ~PAGE_MASK;
@@ -827,7 +827,7 @@ static int kimage_load_normal_segment(struct kimage *image,
 			memcpy(ptr, kbuf, uchunk);
 		else
 			result = copy_from_user(ptr, buf, uchunk);
-		kunmap(page);
+		kunmap_local(ptr);
 		if (result) {
 			result = -EFAULT;
 			goto out;
@@ -878,7 +878,7 @@ static int kimage_load_crash_segment(struct kimage *image,
 			goto out;
 		}
 		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
-		ptr = kmap(page);
+		ptr = kmap_local_page(page);
 		ptr += maddr & ~PAGE_MASK;
 		mchunk = min_t(size_t, mbytes,
 				PAGE_SIZE - (maddr & ~PAGE_MASK));
@@ -894,7 +894,7 @@ static int kimage_load_crash_segment(struct kimage *image,
 		else
 			result = copy_from_user(ptr, buf, uchunk);
 		kexec_flush_icache_page(page);
-		kunmap(page);
+		kunmap_local(ptr);
 		arch_kexec_pre_free_pages(page_address(page), 1);
 		if (result) {
 			result = -EFAULT;
-- 
2.36.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
