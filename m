Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5561CC35274
	for <kexec@archiver.kernel.org>; Mon, 18 Dec 2023 05:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EH8/0BRR5EoW5GIQoTImbsT19fDfztUt6yQhDKYwvko=; b=eX90FyZWXGRS7g
	EsAKI/zK/hrqLWooE7tS6y/BmFblUxEpR4oruNmk8cJEGmUviFN+7oHlbKgMTGkN3TOPjotjVeew/
	LvnD7Jv0cKgB2AAsMqkU2kqVEk1A9Xk+3bovfIY4i894hkh5ku5o73zS2pqUKaB7iGOwgiO02vKT4
	PJpEtFec0QsYxP8RrQMy/tScSGw/gcmLE8bkh6XjXYEI1m8P+L9TiFIBU2V+7iL2ybCC/lBILynDz
	mIIss7uc7ui3SFAL2FpFEfn2VhqgDus1pf0KkDnoXt5cdt/p1HRbku9xRl9Nf4CM+eskOt6HlRDYK
	Q1+n7zQoDh7KMUhnr6MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rF66W-00973p-1T;
	Mon, 18 Dec 2023 05:23:48 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rF66R-009711-1f
	for kexec@lists.infradead.org;
	Mon, 18 Dec 2023 05:23:45 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5c21e185df5so2270352a12.1
        for <kexec@lists.infradead.org>; Sun, 17 Dec 2023 21:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702877022; x=1703481822; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qclET98uhTkk9hwWq++Cb5luLJ+bp3fPG0W58h4kPss=;
        b=T31zKFDM4z4iayjGMKED/kcqxC4IL2N2b7Vzw5ZS4IdI8bbENW/jleGHq+46Plxnzo
         uEjdi9it4YFAmwxHn4nmKTS50SetU9PSZ4Z0KY+rt01e0kumq/La5kY3FbywO0GHt2q/
         vZ+afT8U4bUXPaOqgC6YfaUDGvBu0evKwBiygDPexdLIdeUAYILBnWjLy4/T6tBMAPen
         +AGkho9LlYXILZbs1D6La0FsZ6XtU/QtmAHCaGlEVlXqtCouMfNctUAXGM8UKcuBmsmk
         qU9vBL37AfEeYAb7MG4AXoJarVDXKq7oxnRRDd1m7DL/CydLgWT2tRVp0f1fEOjdbKDm
         mLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702877022; x=1703481822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qclET98uhTkk9hwWq++Cb5luLJ+bp3fPG0W58h4kPss=;
        b=ko/xcQ12B9nr4URItCJNgzvMgSw0BNd0dc17UzCXffp4cFDJSBJzCmImSLo80M1z0o
         zy2bRwwF0OwJvAYIQEOULsI6bI74GqSWFHjnERIU7SIsHszANykB/zqIZQwA+8iafNnC
         EqldEyfys+Fa+giGPCXF9Mrm0HSj/fYUEd25Ircvemr5ZmGJDARN+vYPJg7fi1/70jAr
         beE+bAXLRS+efwImIep+xzm5UdfuXSHS4FHOreLeDiVyTCIHSfaGfpNGJLGAZ0blyUG2
         Y3TiEJIyYkLrF/FqrGb6hRanCi7ArVh90HM50mtRO0VUJ7u3kn8KNPeqSIrmuiB9BpNX
         Da6w==
X-Gm-Message-State: AOJu0Yx2NYV58h+TBfMRkpB5pFuOOU5sksbv7Vj5UeahNsIvUND5Nhzn
	ZLthSPs4x/DKtaMXCPZDHRer3FN1t2mK
X-Google-Smtp-Source: AGHT+IFY5oHDxcydRxcKQR5C2a/iOUS4gWcLAaHO+1Vbt+6kabAGh/znfxLD+Co0rgFeIrGtFs6Tdw==
X-Received: by 2002:a05:6a20:12cc:b0:18f:cbdd:8102 with SMTP id v12-20020a056a2012cc00b0018fcbdd8102mr19161775pzg.103.1702877021779;
        Sun, 17 Dec 2023 21:23:41 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d13-20020a170903230d00b001d3c0300c72sm582434plh.197.2023.12.17.21.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 21:23:41 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Philipp Rudo <prudo@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>
Subject: [RFC 1/3] crash_dump: Parse the CMA's mem_map in kdump
Date: Mon, 18 Dec 2023 13:23:23 +0800
Message-Id: <20231218052325.20982-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231218052325.20982-1-kernelfans@gmail.com>
References: <20231218052325.20982-1-kernelfans@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231217_212343_551457_7E515145 
X-CRM114-Status: GOOD (  17.01  )
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
 include/linux/kexec.h |  1 +
 init/main.c           |  4 +++
 kernel/crash_dump.c   | 80 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 8227455192b7..95e19c814c93 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -410,6 +410,7 @@ extern bool kexec_in_progress;
 
 int crash_shrink_memory(unsigned long new_size);
 ssize_t crash_get_memory_size(void);
+void kdump_kernel_reuse_mem(void);
 
 #ifndef arch_kexec_protect_crashkres
 /*
diff --git a/init/main.c b/init/main.c
index e24b0780fdff..ed90097caaa8 100644
--- a/init/main.c
+++ b/init/main.c
@@ -99,6 +99,7 @@
 #include <linux/init_syscalls.h>
 #include <linux/stackdepot.h>
 #include <linux/randomize_kstack.h>
+#include <linux/kexec.h>
 #include <net/net_namespace.h>
 
 #include <asm/io.h>
@@ -1068,6 +1069,9 @@ void start_kernel(void)
 	arch_post_acpi_subsys_init();
 	kcsan_init();
 
+	/* */
+	kdump_kernel_reuse_mem();
+
 	/* Do the rest non-__init'ed, we're now alive */
 	arch_call_rest_init();
 
diff --git a/kernel/crash_dump.c b/kernel/crash_dump.c
index 92da32275af5..4605005f9534 100644
--- a/kernel/crash_dump.c
+++ b/kernel/crash_dump.c
@@ -4,6 +4,7 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/cc_platform.h>
 
 /*
  * stores the physical address of elf header of crash image
@@ -39,3 +40,82 @@ static int __init setup_elfcorehdr(char *arg)
 	return end > arg ? 0 : -EINVAL;
 }
 early_param("elfcorehdr", setup_elfcorehdr);
+
+u64 kdump_cma_pfn;
+u64 kdump_cma_pg_cnt;
+u64 kdump_cma_pg_paddr;
+
+/* In old kernel, wreck should correspond to pfn */
+static void check_poison_page(struct page *wreck, int cnt, unsigned long pfn)
+{
+	int i = 0;
+	int order;
+	/* Info copied from old kernel */
+	struct page *check = wreck;
+	struct page *p;
+
+	/*
+	 * Strictly check, but there is still a rare case, where both _refcnt and
+	 * _mapcount are forged by some wrong code
+	 */
+	for (; i < cnt; i += 1 << order) {
+		order = folio_order((struct folio *)check);
+		if (PageBuddy(check)) {
+			if (page_count(check) != 0 || total_mapcount(check) != 0)
+				goto fail;
+			if (check->index != 0)
+				goto fail;
+			if (check->lru.next != LIST_POISON1 ||
+			    check->lru.prev != LIST_POISON2)
+			    goto fail;
+
+		} else if (folio_test_anon((struct folio *)check)) {
+			/* check PAGE_MAPPING_ANON bit in mapping */
+			if (!((unsigned long)check->mapping & PAGE_MAPPING_ANON))
+				goto fail;
+			if (page_count(check) == 0)
+				goto fail;
+			if (total_mapcount(check) != page_count(check))
+				goto fail;
+		} else {
+			goto fail;
+		}
+
+		p = pfn_to_page(pfn);
+		for (int j = 0; j < 1 << order; j++)
+			ClearPageReserved(p + j);
+		__free_pages(p, order);
+
+fail:
+		check += 1 << order;
+		pfn += 1 << order;
+	}
+}
+
+void kdump_kernel_reuse_mem(void)
+{
+	u64 size;
+	struct page *wreck;
+	struct kvec kvec;
+	struct iov_iter iter;
+	char *buf;
+
+	if (!is_kdump_kernel())
+		return;
+
+	if (!kdump_cma_pfn || !kdump_cma_pg_cnt || !kdump_cma_pg_paddr)
+		return;
+
+	size = kdump_cma_pg_cnt * sizeof(struct page);
+	/* copy the wreck's page[] */
+	buf = kmalloc(size, GFP_KERNEL);
+	if (!buf)
+		return;
+	wreck = (struct page *)buf;
+	kvec.iov_base = buf;
+	kvec.iov_len = size;
+	iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, size);
+	read_from_oldmem(&iter, size, &kdump_cma_pg_paddr,
+			cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT));
+	check_poison_page(wreck, kdump_cma_pg_cnt, kdump_cma_pfn);
+}
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
