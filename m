Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D68C624D7
	for <kexec@archiver.kernel.org>; Tue,  1 Sep 2026 18:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=abQNPJxLdJSbNwggArhdklh2mCXd2+hz+eKc3bSV4GE=; b=yT0XTvBMJS+KEEoTCXOFNa8F7I
	osjPcU+oZJJ+R0hQVErcXe9PLfuAhss78w9LZLhmkf50k+8xVvW7QgwrgHlApXcALWIDx032yDhq/
	gJJvsjHi8bBZeU+x1XrTxdOIe4XTY7e5bdtjVlfsmlLxy1PGoEYcJGINmDdre1wNuLTyFFDhFfLSM
	WiygUDxphDvCtx7Y+ae3itn2wn7U8+fZ/2gjz5slviaMOBX0igfu+R5q1s6NH/FxucEfbxmEf4Vfg
	np0plYaAqKHxgnn6DNNi0ihMUJ3aBKtCveabLJP7bQs1JEC1Ap1gCHuBPy8p8i/nzTI8wcODr3D+i
	B1mCZ+lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1StU-0000000CuyT-32uG;
	Tue, 01 Sep 2026 18:07:36 +0000
Received: from mail-pg1-x547.google.com ([2607:f8b0:4864:20::547])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1StP-0000000Cutk-09XQ
	for kexec@lists.infradead.org;
	Tue, 01 Sep 2026 18:07:34 +0000
Received: by mail-pg1-x547.google.com with SMTP id 41be03b00d2f7-cc21bc2923fso214697a12.2
        for <kexec@lists.infradead.org>; Tue, 01 Sep 2026 11:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788286048; x=1788890848; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=abQNPJxLdJSbNwggArhdklh2mCXd2+hz+eKc3bSV4GE=;
        b=fnX6qdggKpLUgnnDl13ld55saL9U2benOwtjhvDjU+coHJ5VYe4DhCzJKJDqVKBq8S
         IjDZhDuCDHg/MmBmgPQlRjPG0KM0Fq63nvr57e1Psf/YXP8G64hixpQploH8u4d9u2IV
         mr9UcOeHkZIYRI3O5CI4qHqL0sHygImAfIvVqiSnkMTP/RMHh3HNt2WfMGFaFQvK3u+G
         Iy6Uu2BvFzZFrVwZpX/vxLTc/X/95pEPqfErYDeW0+wI4K0pgDOgoPMctAzycbwkOU5p
         K+bHkr/67i2/gBTq8520VA2cX9WxZs3dLM5DpS3p6zFval1hRUSWfADYPyxDElY1EkMK
         W1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788286048; x=1788890848;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=abQNPJxLdJSbNwggArhdklh2mCXd2+hz+eKc3bSV4GE=;
        b=GHQn6GgL+kUBtAL/5T3OYfrs4Ju1fQrTqMcT62+NkGunaSv45Fi/XTMPCvM5RBgdfg
         u3zA9Si5Hk4wELfRN3q5WnVmq+2DBCkYz064bh/OEWwm2mFvjFo8X/wNk1dH7Pv2P8Rk
         8d1JkwM6snudC+U+fAhXmPuYojpC8VS1+Ug/lrgyh+BxymnlOuFhozbDaxYrEyusuJYB
         x2Khi5Ql9Bj0XZdjgtqRvemKTwuXH6li97n3vYX/0q4oxoA7voJocJCQ47MYOWq963LN
         y0NsqLLfwLPy/Exlvm5r3DVFeWrW57oR9KLSbCAX5VD9CIl8N5Uoq13QeFFbgxVXkb4A
         avqA==
X-Gm-Message-State: AFuF++kinEzBnYEIoxslNsYTlfHs/8B40+tqF5Q8pawYXU2GUrtKtKtp
	jBX8KQiypwGewcwmGyBrj+U3D9O0Ce7kbDoM8F15rI9dSCf595yfeVe68xUp1XG/3rnJUwv1prj
	3UygdYrMf6toJyRugfMZsVLuPDbgPF1lrpWsp0UFAh9UEKMNJKbytZOa532qF6te4vSekMKHNmG
	DKtbTpvLBX/w9vQuFFua1w8Eupawskm6adHwoLLHl9Ph+sfwY25Fs=
X-Received: from pfux35.prod.google.com ([2002:a05:6a00:be3:b0:848:7bbd:284b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3309:b0:835:6388:655d with SMTP id d2e1a72fcca58-8562ba7dae0mr58420543b3a.14.1788286047461;
 Tue, 01 Sep 2026 11:07:27 -0700 (PDT)
Date: Tue,  1 Sep 2026 18:07:12 +0000
In-Reply-To: <20260901180713.4185641-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260901180713.4185641-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901180713.4185641-5-dmatlack@google.com>
Subject: [RFC PATCH 4/5] mm/memfd_luo: Expand support beyond memfd to all
 generic shmem inodes
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_110731_077645_17EDCB2A 
X-CRM114-Status: GOOD (  15.74  )
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

Relax the early validation checks in the Live Update preservation path
to allow general shmem-backed files, completely dropping the requirement
that the file be unlinked (!inode->i_nlink).

This officially enables userspace to push standard, path-backed tmpfs
file descriptors through the LUO session ioctl instead of being
artificially restricted strictly to anonymous memfd pseudofiles.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 mm/memfd_luo.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index dcda5bf98646..107115c97bd8 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -9,14 +9,15 @@
  */
 
 /**
- * DOC: Memfd Preservation via LUO
+ * DOC: Memfd and Tmpfs Preservation via LUO
  *
  * Overview
  * ========
  *
- * Memory file descriptors (memfd) can be preserved over a kexec using the Live
- * Update Orchestrator (LUO) file preservation. This allows userspace to
- * transfer its memory contents to the next kernel after a kexec.
+ * Memory file descriptors (memfd) and generic tmpfs files can be preserved
+ * over a kexec using the Live Update Orchestrator (LUO) file preservation.
+ * This allows userspace to transfer its memory contents to the next kernel
+ * after a kexec.
  *
  * The preservation is not intended to be transparent. Only select properties of
  * the file are preserved. All others are reset to default. The preserved
@@ -24,16 +25,17 @@
  *
  * .. note::
  *    The LUO API is not stabilized yet, so the preserved properties of a memfd
- *    are also not stable and are subject to backwards incompatible changes.
+ *    or tmpfs file are also not stable and are subject to backwards
+ *    incompatible changes.
  *
  * .. note::
- *    Currently a memfd backed by Hugetlb is not supported. Memfds created
+ *    Currently a file backed by Hugetlb is not supported. Memfds created
  *    with ``MFD_HUGETLB`` will be rejected.
  *
  * Preserved Properties
  * ====================
  *
- * The following properties of the memfd are preserved across kexec:
+ * The following properties of the memfd/tmpfs file are preserved across kexec:
  *
  * File Contents
  *   All data stored in the file is preserved.
@@ -580,9 +582,7 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 static bool memfd_luo_can_preserve(struct liveupdate_file_handler *handler,
 				   struct file *file)
 {
-	struct inode *inode = file_inode(file);
-
-	return shmem_file(file) && !inode->i_nlink;
+	return shmem_file(file) || shmem_mapping(file->f_mapping);
 }
 
 static unsigned long memfd_luo_get_id(struct file *file)
-- 
2.55.0.966.g6673acef38-goog


