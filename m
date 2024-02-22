Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C333FC48BEB
	for <kexec@archiver.kernel.org>; Thu, 22 Feb 2024 09:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VGXNGuOVIg2OpkL4NqZLsB+SGvlXy7SzwjYWQMt81Eg=; b=sqZ9mrTdF5TPiV
	mh/kaRMaBB2a5azFAdX8ukMdsvZidULKWCa7qY4CRBRoPYy3uJFoIMl5XhhKMrs+vbPLh9LpR0i2f
	aVEQKEXMV+2BAuQJ3dlNNt/GGZUfGFVrAZnwZOE2LPeJ1WWvmG67nH4eL/kBzxLax7YpWfVB9inIw
	lvAHIyHjYhk8jkofLmYzZcEsRIkrj28Q3N9VaFn+SgRbVkPDvk0OOKL9kYQbhP2UfLlqwNTmnxg8Y
	A2jMFA+fmaC+vc06nLZ5f28VHD+LFrMrC7FBtPi9Euyr+5/2DuSumLQaib5EfYKRWda3muxl6V3eN
	Fee+YmSE+A3K76qbb6Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd5Gt-00000004D4W-434O;
	Thu, 22 Feb 2024 09:21:39 +0000
Received: from m16.mail.163.com ([220.197.31.3])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd5Gq-00000004D3n-0Orv
	for kexec@lists.infradead.org;
	Thu, 22 Feb 2024 09:21:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=oCVce
	RJ4c78MPAjhinbj8feHNV7TeUxfiGEfqf5K8ws=; b=bh4IqpA6DUBrOMjpjwuIg
	a9XQAhUt7C9PAcjYXAq/cu4Ie4lnQ3ABCb8R6fwdqCY1+7yDrJU8PJkjMM4nTKqR
	BW0fQ0o/c40PIt4KJVKghjw4XuVh4VLh1/fOZRizSj5chzACLmGRMNJMqxDZwzdF
	kdEsvnUMBXV5URm5pbWyGY=
Received: from yangzhang2020.localdomain (unknown [60.27.226.204])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wDXD4USEtdlSNHNDg--.2170S2;
	Thu, 22 Feb 2024 17:21:23 +0800 (CST)
From: "yang.zhang" <gaoshanliukou@163.com>
To: ebiederm@xmission.com
Cc: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	bhe@redhat.com,
	"yang.zhang" <yang.zhang@hexintek.com>
Subject: [PATCH V3] kexec: copy only happens before uchunk goes to zero
Date: Thu, 22 Feb 2024 17:21:19 +0800
Message-Id: <20240222092119.5602-1-gaoshanliukou@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CM-TRANSID: _____wDXD4USEtdlSNHNDg--.2170S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFyfXFykCw4rJF1DXF4rAFb_yoW5XFyxp3
	9xGr1FkrW8Jr9rXr1ktF15CayfJ3s7GryrurW7CF95KrnI93Wvq34S93Wj93yUKryFkrn5
	Jw4qkF9Iga4UX37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jgR6rUUUUU=
X-Originating-IP: [60.27.226.204]
X-CM-SenderInfo: pjdr2x5dqox3xnrxqiywtou0bp/xtbB0BmM8mWXwByflwAAsR
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_012136_543833_B005A09B 
X-CRM114-Status: GOOD (  10.95  )
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

From: "yang.zhang" <yang.zhang@hexintek.com>

When loading segments, ubytes is <= mbytes. When ubytes is exhausted,
there could be remaining mbytes. Then in the while loop, the buf pointer
advancing with mchunk will causing meaningless reading even though it
doesn't harm.

So let's change to make sure that all of the copying and the rest only
happens before uchunk goes to zero.

Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: yang.zhang <yang.zhang@hexintek.com>

---
V2 -> V3:
- Add more detailed description in the commit message
v1 -> v2:
- Only copy before uchunk goes to zero

V1: https://lore.kernel.org/lkml/20240130101802.23850-1-gaoshanliukou@163.com/
---
 kernel/kexec_core.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index d08fc7b5db97..2fc3d0e3715a 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -800,22 +800,24 @@ static int kimage_load_normal_segment(struct kimage *image,
 				PAGE_SIZE - (maddr & ~PAGE_MASK));
 		uchunk = min(ubytes, mchunk);
 
-		/* For file based kexec, source pages are in kernel memory */
-		if (image->file_mode)
-			memcpy(ptr, kbuf, uchunk);
-		else
-			result = copy_from_user(ptr, buf, uchunk);
+		if (uchunk) {
+			/* For file based kexec, source pages are in kernel memory */
+			if (image->file_mode)
+				memcpy(ptr, kbuf, uchunk);
+			else
+				result = copy_from_user(ptr, buf, uchunk);
+			ubytes -= uchunk;
+			if (image->file_mode)
+				kbuf += uchunk;
+			else
+				buf += uchunk;
+		}
 		kunmap_local(ptr);
 		if (result) {
 			result = -EFAULT;
 			goto out;
 		}
-		ubytes -= uchunk;
 		maddr  += mchunk;
-		if (image->file_mode)
-			kbuf += mchunk;
-		else
-			buf += mchunk;
 		mbytes -= mchunk;
 
 		cond_resched();
@@ -866,11 +868,18 @@ static int kimage_load_crash_segment(struct kimage *image,
 			memset(ptr + uchunk, 0, mchunk - uchunk);
 		}
 
-		/* For file based kexec, source pages are in kernel memory */
-		if (image->file_mode)
-			memcpy(ptr, kbuf, uchunk);
-		else
-			result = copy_from_user(ptr, buf, uchunk);
+		if (uchunk) {
+			/* For file based kexec, source pages are in kernel memory */
+			if (image->file_mode)
+				memcpy(ptr, kbuf, uchunk);
+			else
+				result = copy_from_user(ptr, buf, uchunk);
+			ubytes -= uchunk;
+			if (image->file_mode)
+				kbuf += uchunk;
+			else
+				buf += uchunk;
+		}
 		kexec_flush_icache_page(page);
 		kunmap_local(ptr);
 		arch_kexec_pre_free_pages(page_address(page), 1);
@@ -878,12 +887,7 @@ static int kimage_load_crash_segment(struct kimage *image,
 			result = -EFAULT;
 			goto out;
 		}
-		ubytes -= uchunk;
 		maddr  += mchunk;
-		if (image->file_mode)
-			kbuf += mchunk;
-		else
-			buf += mchunk;
 		mbytes -= mchunk;
 
 		cond_resched();
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
