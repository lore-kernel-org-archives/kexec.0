Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59262C46CD4
	for <kexec@archiver.kernel.org>; Mon, 18 Dec 2023 05:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RSNHWbkE5saKHqQmYEQsK3p7wdFmRDE6Vt/99fkoG30=; b=bdgGPhwtiXBblA
	0rUQpcZLoZoAWpTwep5yQ4GVTlaIUR+t80uS+njzfwKW2WljaKwS+hKtdUZdhxLj8Os4SKrN1/SJl
	ceMTZXPAtEhtNGlwPrr6npfoa7/7ZGgleZkFFPSOEY0iXoBXYbfPiL5oo4LgWYssAHQnVOkrQAU9m
	kXOPOmR5/0U1MqSpYJaUEqAtFbeIwzOShXwIP6fXll1Fqv/49iJ1B3/bDN7T2j+sqiHuj7JYX7/N9
	UKIJauSp/iOxhka1e2aOu3BjLLDVcwJ+WJuI9AetRJooiekbB4/NVBTUzMvDEhoZKnNONA65hMt43
	U4QkDNsE9b6DGRE+wz6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rF66X-00974F-00;
	Mon, 18 Dec 2023 05:23:49 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rF66U-00972I-2B
	for kexec@lists.infradead.org;
	Mon, 18 Dec 2023 05:23:47 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d098b87eeeso22687775ad.0
        for <kexec@lists.infradead.org>; Sun, 17 Dec 2023 21:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702877024; x=1703481824; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUDEjuz7dTh6U48nS5xqrEvupkrEdoF0zsI9VXIhXHQ=;
        b=a/xQ5QqNXOVhhZUNRIqnrzY9+bNW5prTDHAdz7cK3fMZZTpJ3tn/rAdraOqMNI5RYR
         AvwmkHb1011R3GG1pC/KGP/SbxMjV0hI3xbOBvgoq6wn5metqvrBT5iLVA5pqbHKXOG1
         dwbX+i47Brfb2dwNkEI3dtf5ky2sgbXt7bNyRS9/q3grLa1vifXhtQ7swQWFIhXWUyyS
         cGd/m+iOF7+QEjsD81sCRRfzKWWxQqSbDQYi0AzsOq7o8MAv/NSqynvC+I/WbwmUb6bx
         e3UHQ8L17RZDJL6hQGvVXdexUC1zQtY5BQVmIWsA5UWBzkCY93G/sYrJjCSTDJaV1ylb
         XLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702877024; x=1703481824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUDEjuz7dTh6U48nS5xqrEvupkrEdoF0zsI9VXIhXHQ=;
        b=pMNjZ3xz4ZsX5zUMZ5uQcyGe8XdSawLWjcgPUhlojXuGqnZsatZbY54OMDkEyJkXnB
         q0agGQy3Iu7LZYs721c9OndZaTCyhkJ9xdT6Bjt0Z8Ua9auNHPDH8o70z2Ij52+AUJpe
         7fGqOV02j4Sz8xMp0apKQaUUFUJMznw4uEotPguslRbHJf8vUFRAj88VKPVSvF/kZfrJ
         EaAkAwlbw/vM0ZJZZl0AOzY4S5OyQNCEQnHFDuZgfsR7kX3HMaKvBwma8FYBIl0/86Y9
         5dyl5ygCIzw0o/y0+D76TYjwOs90Xl8YysABZKLCAVXjbM55wmNpS8YyIAe6zG2uYFFE
         qZtw==
X-Gm-Message-State: AOJu0Yzr3eHdT+pkFRbbjLztCuqK8iYrMPlHm+LaGaIJH381+hN5LR9d
	dVRXnnXxF8ofPtRN0sz89eop2kFcSgqs
X-Google-Smtp-Source: AGHT+IHEjaBg3W8+ZNgbgNN0NJk6dr0/z7jB+nbIMxPgmI4Yba/GPQLUgblj6PYFPb+ZQQdqlDkGDg==
X-Received: by 2002:a17:903:2447:b0:1d3:c58f:404d with SMTP id l7-20020a170903244700b001d3c58f404dmr268284pls.114.1702877024081;
        Sun, 17 Dec 2023 21:23:44 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d13-20020a170903230d00b001d3c0300c72sm582434plh.197.2023.12.17.21.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 21:23:43 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Philipp Rudo <prudo@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>
Subject: [RFC 2/3] of: kexec: Set up properties for reusing CMA in kdump
Date: Mon, 18 Dec 2023 13:23:24 +0800
Message-Id: <20231218052325.20982-3-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231218052325.20982-1-kernelfans@gmail.com>
References: <20231218052325.20982-1-kernelfans@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231217_212346_711912_7C92690C 
X-CRM114-Status: UNSURE (   9.07  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Pingfan Liu <piliu@redhat.com>

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
To: kexec@lists.infradead.org
---
 drivers/of/kexec.c    | 14 ++++++++++++++
 include/linux/kexec.h |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 68278340cecf..471b6cdf34ff 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -410,6 +410,20 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 			if (ret)
 				goto out;
 		}
+
+		ret = fdt_appendprop_u64(fdt, chosen_node,
+				"kdump,cma_pfn", kdump_cma_pfn);
+		if (ret)
+			goto out;
+		ret = fdt_appendprop_u64(fdt, chosen_node,
+				"kdump,cma_pg_cnt", kdump_cma_pg_cnt);
+		if (ret)
+			goto out;
+		ret = fdt_appendprop_u64(fdt, chosen_node,
+				"kdump,cma_pg_paddr", kdump_cma_pg_paddr);
+		if (ret)
+			goto out;
+
 	}
 
 	/* add bootargs */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 95e19c814c93..bf2d8b9d8c07 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -408,6 +408,10 @@ bool kexec_load_permitted(int kexec_image_type);
 /* flag to track if kexec reboot is in progress */
 extern bool kexec_in_progress;
 
+extern u64 kdump_cma_pfn;
+extern u64 kdump_cma_pg_cnt;
+extern u64 kdump_cma_pg_paddr;
+
 int crash_shrink_memory(unsigned long new_size);
 ssize_t crash_get_memory_size(void);
 void kdump_kernel_reuse_mem(void);
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
