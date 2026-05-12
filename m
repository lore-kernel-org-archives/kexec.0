Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEF0CD4F39
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 19:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ljg+98L2Wc2yizBAt6Gvu0fP3XnfuPS9FfSkO2m0vXM=; b=dgR12c9a0Q0+VQARG6GjttFqx6
	ShPF/RpVRD1EqRWN2riGsNN4geliyxVU7WFZGuL30QaqTPHhz5lVeJPkGYOtkklnnhLRBrddup3tJ
	DTugcCkx3HVVwSiNKIXhZ1DQCtgsk9BZag8pJFOpMhm3M6FQM+cdjsoDuzeTohdXIAjbEvXH5RUjW
	wGAwEwxT7rYnuqxAbanbYMpLDAEesFzl+FgGRDXLF5zEjOun++6fHbSt7j2x1OclEQzzmULRajPyV
	yf0Se2nb6kYUmTOgYbUFTn/mT3I65pLU6hPS8cLaOZDuktfj4BttW7tqyif/eQ5lwAvYG/Ip/cLV3
	4YKYC3HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMt8n-00000000GhR-1lGJ;
	Tue, 12 May 2026 19:51:41 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMt8k-00000000GfY-13yE
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 19:51:39 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2baf7748d0aso51900865ad.1
        for <kexec@lists.infradead.org>; Tue, 12 May 2026 12:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778615497; x=1779220297; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ljg+98L2Wc2yizBAt6Gvu0fP3XnfuPS9FfSkO2m0vXM=;
        b=dkRoj8QcCNIqUiroeRSIcR1LHtHOemLAgJYlhVAuIhLjIxGhCcTV9GbCjsx/QnMEfK
         riTvHZtvy3hIs5UcnoLMtqyrhbZJfIeLplSOuCLsUQ/KG11vEHfDJp3i4Rx+gYSgZo5K
         Vz+UpIeQ/ivVhKrVM0q8qgOb+Aq2HatOPzvq5g/zDNDSbYu4FqFrhFIVzZv7ALMEtR/2
         NS+SUwvb5R/4UgFljPD1AMZv2aAliyeG4+72RGBVJ+5NKATJxlWxK7nWHuzVrbsURd+F
         h3kXG6e5Dq06VnFiOvKlHPtesf5/a28Kt44EFZmk8FqczPMh2Bx7J8SCcd55WR6szbkY
         vXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778615497; x=1779220297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ljg+98L2Wc2yizBAt6Gvu0fP3XnfuPS9FfSkO2m0vXM=;
        b=igcX9MUO1asnt9cuV9sRcyim9rjMjvlIhfEUI5NGbQ59FPjXq5YiTnvcZ5y2iEr+s3
         bzozNbD3arlsztN9aZzZcZf31BCmM8yRyOSPA7CtvAHjSPpagRTXle/hHqJk2L08FBHl
         EOSVfF+4akbmJv+jDBrwtUcNR7mIvZEU1ufaE6s2NVS7in04akEihZeZynSn4VtLfmA+
         lyUpvTTHxE/q9X+NTHHWzqutdpxKtH2Zh2+PeEKfnQizrJjvOivhrURP0+Xz1Q4V2zYT
         5C7FQUU/o+aVHxRxqyFrcvw27wgt9XcqbaA0LSNsjilQ1/u0QnNLZ6XeQ9oonIaeFAgE
         rZKw==
X-Forwarded-Encrypted: i=1; AFNElJ+UDQy09YG8xZkFIrzRe2P65BmNp6rI12zzUkw+h/kmbJNhX7XE54DYjVeMO38+1uvYnmcuxQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx2mA0ibe2/0CBGVCvWaRB55C0+wOBKFDejwdvB4EDreBjoYucB
	KX/wkGEE+AbvEIUBDI29EWZlvmV/J4iWZJhWGgdMVir0u4ZOMCMjaMQ1DC4rBNMq5rcpdMHUhtt
	ubUtes23nolmPhg==
X-Received: from play21.prod.google.com ([2002:a17:902:e195:b0:2bd:15bf:f9c7])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1b45:b0:2b0:a957:304 with SMTP id d9443c01a7336-2bd270fb799mr4241965ad.6.1778615496629;
 Tue, 12 May 2026 12:51:36 -0700 (PDT)
Date: Tue, 12 May 2026 19:51:33 +0000
In-Reply-To: <20260512195135.804833-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260512195135.804833-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512195135.804833-2-skhawaja@google.com>
Subject: [PATCH 1/3] kho: Add kunit static stubs
From: Samiullah Khawaja <skhawaja@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_125138_292368_F11BC537 
X-CRM114-Status: GOOD (  12.01  )
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

Add kunit stubs in kho_restore_folio() and kho_restore_pages() so the
users can mock these functions in kunit tests.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 kernel/liveupdate/kexec_handover.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index d5718bef6d4d..1375291d9b07 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt) "KHO: " fmt
 
 #include <linux/cleanup.h>
+#include <kunit/static_stub.h>
 #include <linux/cma.h>
 #include <linux/kmemleak.h>
 #include <linux/count_zeros.h>
@@ -437,7 +438,11 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
  */
 struct folio *kho_restore_folio(phys_addr_t phys)
 {
-	struct page *page = kho_restore_page(phys, true);
+	struct page *page;
+
+	KUNIT_STATIC_STUB_REDIRECT(kho_restore_folio, phys);
+
+	page = kho_restore_page(phys, true);
 
 	return page ? page_folio(page) : NULL;
 }
@@ -459,6 +464,8 @@ struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages)
 	const unsigned long end_pfn = start_pfn + nr_pages;
 	unsigned long pfn = start_pfn;
 
+	KUNIT_STATIC_STUB_REDIRECT(kho_restore_pages, phys, nr_pages);
+
 	while (pfn < end_pfn) {
 		const unsigned int order =
 			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
-- 
2.54.0.563.g4f69b47b94-goog


