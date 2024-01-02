Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF7AC46CD2
	for <kexec@archiver.kernel.org>; Tue,  2 Jan 2024 14:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JIV5BST0QD43cZj75qdI0+a7dL+HYHCF3ibe/xms+eo=; b=ZuldqBjvOQ0A+0
	yGGDeABpGDUFKQvmdsGZkxDiqPfw8bIDY2k14O+Yd6Pu2k+R90kQ3uwYI2w08RAUdInBsXAjoFVnF
	/UbjEqA/sThzhBLuLajGZlbgsoV6zoK34W/ENnWcv1JAnUrHSdkc8qBsJc7l+TAK1v0weaLtH1SpT
	UZAoFnFnjaShg9mYF1eGcA8IaLp7rHGVclp9Dl0EIFEk3dM5uRcB3oX5pTXQg1mktMZ+qTjOi67yZ
	qCLpypsd0KLWUfydOxbZfkwngCeUeCBAt2lunrhHfkSsXMQPd56cZZ23DVh+Tzh9whhL1cWSB/C8g
	QJ54B5BwPod/HradF7uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKg5u-008HwW-3A;
	Tue, 02 Jan 2024 14:50:15 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKg5r-008HvX-2k
	for kexec@lists.infradead.org;
	Tue, 02 Jan 2024 14:50:13 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5cd51c0e8ebso3143654a12.3
        for <kexec@lists.infradead.org>; Tue, 02 Jan 2024 06:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704207010; x=1704811810; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvEmLr+UaTr62j3UG+52tMfBhddUI6/cULZMLMKbxpo=;
        b=gWJpbPBMshagxm1Y7EKWqUT44WvwnsZKWOCeLmMIDxWZQAPV4E6V2UUghgEhnKpcaF
         ZsjY6QxIdsKoBWMLr20C1B446BaYjWoGRb7a83q8A7hD1xY86bcUlFXlTXIuNKuC1DOs
         V9MjDf+crSICOzSXZ5PEe0CJSrODXq8OHpTsvO2xHHp7YLinnlVdI7W5YqPHVQaSLZTq
         6UMJx20k2+nNrN1uBVO2DjWPmBz00CJ/pAhvR0WBRkC18U2TjKKfdNFdrVP6rcovknKK
         I/JcTo+PRQHjmeprqWe6ef4AlGKkqku8L7pmiJW+6cHoMk8Hw17UlGlu0X8rgSbp4j/Y
         wwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704207010; x=1704811810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvEmLr+UaTr62j3UG+52tMfBhddUI6/cULZMLMKbxpo=;
        b=lAO4HFEmlTbGp42WonMcr04KAfQ/4nCxeJyxAmz4qCGNofoC9/TzxSpZS5kPKRGyQX
         bEF+XIkhZWlWVDjKLl5fPQ9Jpp8KjrYKeCRYER1v5tIUSlBBxwHmjrDX6K9Q9OWkTP1i
         sUrkqoMTEnsCRGAAaC91SvpryBq52Apl3Lz7YV2dpOl9DIvCbm3TUw9BkLLkR2cA2R92
         udJNp/qGZVY3Z7bnDLYAAcUhHxx5rl0op8e8m3ZywA2FWd5MP7IHL6rIYNRmSySXNOvq
         qJM7CUYqFgFBd4cUpX59V7BYEILf9d9ALw6SV/iivk9fP/2lUz8gsCGPywvRI+0ONAA9
         t5cA==
X-Gm-Message-State: AOJu0Yx7fqaToHtr79aRYJ8UM1n6WUjNJEBPiMuSgI+vr+lLAD7Lfb6A
	TtGWJMOh4BBN9M1KuaUbYNE=
X-Google-Smtp-Source: AGHT+IFNmn5V6rq7TK2Nmxo31rOyhLq839u1k8G5xOyK4HuBoRPhSjdEBFSmj7nj+1BJk9QdvNEOGw==
X-Received: by 2002:a05:6a20:37a5:b0:197:22c2:2c3 with SMTP id q37-20020a056a2037a500b0019722c202c3mr783310pze.38.1704207010538;
        Tue, 02 Jan 2024 06:50:10 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a005300b0028be216595csm25836878pjb.4.2024.01.02.06.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:50:10 -0800 (PST)
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
Subject: [PATCH v2 1/3] x86/crash: remove the unused image parameter from prepare_elf_headers()
Date: Tue,  2 Jan 2024 22:49:03 +0800
Message-ID: <20240102144905.110047-2-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102144905.110047-1-ytcoode@gmail.com>
References: <20240102144905.110047-1-ytcoode@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_065011_883761_C2A54CC7 
X-CRM114-Status: GOOD (  14.60  )
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

The image parameter is no longer in use, remove it. Also, tidy up the code
formatting.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c92d88680dbf..792231a56d11 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -198,8 +198,8 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 }
 
 /* Prepare elf headers. Return addr and size */
-static int prepare_elf_headers(struct kimage *image, void **addr,
-					unsigned long *sz, unsigned long *nr_mem_ranges)
+static int prepare_elf_headers(void **addr, unsigned long *sz,
+			       unsigned long *nr_mem_ranges)
 {
 	struct crash_mem *cmem;
 	int ret;
@@ -221,7 +221,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	*nr_mem_ranges = cmem->nr_ranges;
 
 	/* By default prepare 64bit headers */
-	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
+	ret = crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
 out:
 	vfree(cmem);
@@ -349,7 +349,7 @@ int crash_load_segments(struct kimage *image)
 				  .buf_max = ULONG_MAX, .top_down = false };
 
 	/* Prepare elf headers and add a segment */
-	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz, &pnum);
+	ret = prepare_elf_headers(&kbuf.buffer, &kbuf.bufsz, &pnum);
 	if (ret)
 		return ret;
 
@@ -452,7 +452,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
 	 * Create the new elfcorehdr reflecting the changes to CPU and/or
 	 * memory resources.
 	 */
-	if (prepare_elf_headers(image, &elfbuf, &elfsz, &nr_mem_ranges)) {
+	if (prepare_elf_headers(&elfbuf, &elfsz, &nr_mem_ranges)) {
 		pr_err("unable to create new elfcorehdr");
 		goto out;
 	}
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
