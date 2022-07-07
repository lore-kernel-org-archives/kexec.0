Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C53C433EF
	for <kexec@archiver.kernel.org>; Thu,  7 Jul 2022 23:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KcyCnWFfsIeLHETKccFqYGuXaZOV9IHMNFrS1Xx+Dog=; b=MRz74G2CQ4X7CN
	YU6/jiRwf/tNepRnyAGf1fuinv7VKYpVgrgrsxlUGG2PetqzdJKkDPlR1rCPSl6jRBiumLCBaSiy6
	mgItd0ueM2H+juTVwA5FOeQfZ9v6+IDl+lOnGGLhDKQ4Hb05uguNjNzq4ldDbjAhtO74CSqoRT0gc
	wpwey3L/NvcnsciOcLsd2RkInbrVA8nzcCeDB8uM/ftpTWZpWX+pqCyud1fQ8vPoOmQsphPNfkwb3
	C8RJnUi0PFBCwtBOk+YKlfoFwZUOXORJKgGM2PVm/c3+bbES31UjfIlDywQRNbrYzAFpEmOLjPT+d
	SfYOY93vk4K/b+lTkIgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9ahW-000ePt-9K; Thu, 07 Jul 2022 23:14:26 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9ahT-000eO5-4K
	for kexec@lists.infradead.org; Thu, 07 Jul 2022 23:14:24 +0000
Received: by mail-wr1-x436.google.com with SMTP id b26so28327976wrc.2
        for <kexec@lists.infradead.org>; Thu, 07 Jul 2022 16:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=izEW/QlWsYwAv1ZochY3FjaPww57C5kdq40cLp75WW8=;
        b=IHvyQzKUsj6cmYt0GoU0JO/vGfv/QZ0SGCghTNipvbOxddWPTpllfdqd6WPZzJ5yfS
         nmpXVBhxWR3VLak28+xTua7DJ7ThAUcOcyyIJ0I/BJa+3tLiKD4P35J0LBuXePIy8fyg
         acNnxmifaxhC9p/P6L5kRGRaNWrosuFX8g67kNSObnRuamv1OdAteTf1Qrves5CowcCq
         xqEa/TaraYD8x9YnR1+vADPqqsDoNkjbqKUuQri+vRSylWapjeZmU3qnHHoSJZWjZGzS
         o8/cRY+egbj9YuTOrmSWcqzvzems3cK2Oq6dGGFnS/LhnvQnuyG0rq/KU9shqeDo87E8
         7pIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=izEW/QlWsYwAv1ZochY3FjaPww57C5kdq40cLp75WW8=;
        b=HkuDDre1TmPrSi6opqHVwk/O6c/ub7DAKDhbJfa9MCZMJBchdkMTjc6tQRhnHVUtpo
         t0GebSRzX89p46bo1vHilT1PWX8oBWYnub0lbIMzVr1/Oxtjw+kQfuxEzHlHrT38holv
         ibWad83q3jvNdBA602BwxBk+ATW+u+16b9e+LcJ7AjMF3Ahix2UL7IoQbGss/5SU4Qsb
         6kFxEtQoeor52hodkKb8nuG7yuYWR1/jk8RXZ7hvJ4DQA/RgcZDhUCpkOxvWyQFcp3UC
         BP5yI41so99Sa565YbRDrrF0ijrvEKI0+HgJvT1qtY6GVfjC43trxatCBpgkTvbvOZIy
         no5A==
X-Gm-Message-State: AJIora9uKR6UcRCUQ9cEfwo0gZqMpRCO/HtdXEDzwTq98Q+Crb0MJgeK
	QYABauuibkBk1mdnrhxFn3c=
X-Google-Smtp-Source: AGRyM1uBioqFu9xhYE1r6Pp52kKGi0yIK42RApLLOjdIK5CTwaDJdYl19OuGfydqU02oB42al4MyKA==
X-Received: by 2002:adf:facc:0:b0:21d:8c8f:4b51 with SMTP id a12-20020adffacc000000b0021d8c8f4b51mr267095wrs.307.1657235657684;
        Thu, 07 Jul 2022 16:14:17 -0700 (PDT)
Received: from localhost.localdomain (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id q6-20020a1cf306000000b003a033177655sm201922wmq.29.2022.07.07.16.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:14:16 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] kexec: Replace kmap() with kmap_local_page()
Date: Fri,  8 Jul 2022 01:14:12 +0200
Message-Id: <20220707231412.1404-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220707_161423_231932_4B211858 
X-CRM114-Status: GOOD (  12.54  )
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
