Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F043C433EF
	for <kexec@archiver.kernel.org>; Thu,  7 Jul 2022 18:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=AAwZgs/0D1yeKtkSRvT2siqTP6emxyD1Yr1+AqVY8d8=; b=MpK6eGemLBqNwz
	/QX+4BrneZ6BrCbizLwYZ/HGczxVfX/TK+v3Z2vxUCJycCfKPWzbNIBFTlOBQZALaRJYHW2fNOv8B
	1fGhoedGyZmkWUNeUES8etIUy/qNe7fsae3Wv+YJPP2BKFnuqqoDgY140n73NKwvkUb5Sxr+e4LT8
	QfiPwXTZ6tzUYxMJHFdPd4i3MA/uXXsussa5JqG00/tD3CUyoB9X1j8d6EY7q8htTzGdpVWDEMu6O
	34QUyQW5q/353mUSvgAtuIWRpRjtHlINelrthjehnG/sYSaqFI3YWxjkh5eFje2qidRL+mdGUgceM
	N8JUY9iu7hElpicxWc1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9WZV-00HSvr-24; Thu, 07 Jul 2022 18:49:53 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9WZQ-00HSuT-O9
	for kexec@lists.infradead.org; Thu, 07 Jul 2022 18:49:51 +0000
Received: by mail-wm1-x32e.google.com with SMTP id o19-20020a05600c4fd300b003a0489f414cso11206856wmq.4
        for <kexec@lists.infradead.org>; Thu, 07 Jul 2022 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=By3T6Z5JDK5VvmvI0n3THPKQqdtLxJBkH/DaezIVYE0=;
        b=UcJwhV8pPQf4CAMOaf2znH1HntdU1cBMU8tyt9pzArCbkZGGDwErnBt8m86tQK9dxa
         HcLrCVCOdiHht2vDiwCi4rzwEvLi5Cmu6JhEAmHMJvK2W1eODp6clKPUTA4El1iWyRQY
         6RXW5TWyrX9LsIxjY64M6+jfyEpylCJGLL3Ii2DxkW9GhJG4CtiXaB1YsrKPcnTfmvno
         Bg7chmUDKYbyao8BwLr4ICGm+tOc99ag/ZCBIvshf5C3c9gois6pyyQuiNsTbhC2LswA
         ZLJqpybLLTbFd5bYNrRA+1YcC1AQwEvEPq2PA5vjU57nBou97z3stLYQNuOO+lZspdfB
         FfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=By3T6Z5JDK5VvmvI0n3THPKQqdtLxJBkH/DaezIVYE0=;
        b=vVjeEHt1ZvkLpiTPVFXKhxZzl0dGwc6MCnjhijY3Xf+kb/QxQSAOUiXA060cS0iRau
         Q7EQYgr6A0lRNrciutWCBKT5wQrjr64lsbUIJwfyn84agVbT91gcfUagHoYL26Mkl2Up
         ugskjGUoxlb2xr+u59v0wi3JrS8mGrAqbgFcSgkBw11Vj+YzyAfMo4LYUgVTx7vKog7T
         TLp0pNXVRsVbbw5UpH03fzX0F+FAhrgsw356QAur4HYnaJAtOSWMhm7FFeobwtGD+aoV
         bs8pUNgHXkjr+G09iHLQGjDL9R7BSrDEDiEfAhdhZzWRYVVv7gpNH/Kf5nE5UbJuX0rj
         Xgmg==
X-Gm-Message-State: AJIora+oMIx1fODUJL+34vdJEKb0B4nfMiXTAANREBD1gQe5M9QwL0Hm
	Uz/Cli1WvKPlRrK9GmB3wJ6WQeQUiXk=
X-Google-Smtp-Source: AGRyM1uvGngSRhvIh90pdnM0bN+cxnFl4K5RjbtOcM7uxxaM69tVEFlfF+Ip5tKu6NDKHKV07V4/9w==
X-Received: by 2002:a1c:19c3:0:b0:39c:6479:3ca with SMTP id 186-20020a1c19c3000000b0039c647903camr6037084wmz.27.1657219785494;
        Thu, 07 Jul 2022 11:49:45 -0700 (PDT)
Received: from localhost.localdomain (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id z5-20020adfe545000000b0021b81855c1csm47280088wrm.27.2022.07.07.11.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 11:49:43 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] kexec: Replace kmap() with kmap_local_page()
Date: Thu,  7 Jul 2022 20:49:39 +0200
Message-Id: <20220707184939.6086-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220707_114948_841951_30ABC3CC 
X-CRM114-Status: GOOD (  11.43  )
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

Therefore, use kmap_local_page() in aio.c because these mappings are per
thread, CPU local, and not globally visible.

Tested on a QEMU + KVM 32-bits VM booting a kernel with HIGHMEM64GB
enabled.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
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
