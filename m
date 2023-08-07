Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253A2C001DF
	for <kexec@archiver.kernel.org>; Mon,  7 Aug 2023 02:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=STFNJ7aWeLNP6E35sxaRuJmI1CXgWm65es2k893iFZE=; b=Di01kO8veZb+xR
	VcyVvF3pJ185K0o4pZh6ot6LWq3g7IM18NZ00DLrkLz7mzCGtsw7WNykNq8NFI1mIfLx+wnxXLp3A
	UBcmiDdeRks8MamIi2H6iWS0gR6ksq0vz3WEll+F8ze9YYxJHnIKa+xRCNYR54nrtO76B2eaA/kvA
	YYdU7MtAi0G5jmOnHT3n+DB/noH+Ij0FvbYLQZ4M88wsbejthmeoxtjPmmnzrs7iBiIEaVuYCrGWe
	x038ssd5LOeerlCDgGMoxOVvt2Q5m/fSeEvy5WuGqIuAFtBchmrM8aRDJZCF2VVotxmxVCkuJgIKo
	iU+E7iACg/Z+MelNBPRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSqLt-00G2By-1a;
	Mon, 07 Aug 2023 02:52:13 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSqLo-00G29z-1M
	for kexec@lists.infradead.org;
	Mon, 07 Aug 2023 02:52:10 +0000
Received: from kwepemm600006.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RK1421ZTDz1Z1Tk;
	Mon,  7 Aug 2023 10:49:06 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemm600006.china.huawei.com
 (7.193.23.105) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 10:51:52 +0800
From: Wenyu Liu <liuwenyu7@huawei.com>
To: <ebiederm@xmission.com>, <zohar@linux.ibm.com>,
	<dmitry.kasatkin@gmail.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<linux-integrity@vger.kernel.org>
CC: <akpm@linux-foundation.org>, <vschneid@redhat.com>,
	<pmenzel@molgen.mpg.de>, <bhe@redhat.com>, <louhongxiang@huawei.com>
Subject: [PATCH v2 RESEND] kexec_lock: Replace kexec_mutex() by kexec_lock() in two comments
Date: Mon, 7 Aug 2023 10:52:06 +0800
Message-ID: <20230807025206.3682381-1-liuwenyu7@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600006.china.huawei.com (7.193.23.105)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230806_195208_645623_94B34F6E 
X-CRM114-Status: GOOD (  10.40  )
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

kexec_mutex is replaced by an atomic variable
in 05c6257433b (panic, kexec: make __crash_kexec() NMI safe).

But there are still two comments that referenced kexec_mutex,
replace them by kexec_lock.

Signed-off-by: Wenyu Liu <liuwenyu7@huawei.com>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v1 -> v2
 - fixed some mistakes in the submission information

 kernel/kexec_file.c                | 2 +-
 security/integrity/ima/ima_kexec.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 881ba0d1714c..b5bbb2fe0668 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -624,7 +624,7 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
  * kexec_add_buffer - place a buffer in a kexec segment
  * @kbuf:	Buffer contents and memory parameters.
  *
- * This function assumes that kexec_mutex is held.
+ * This function assumes that kexec_lock is held.
  * On successful return, @kbuf->mem will have the physical address of
  * the buffer in memory.
  *
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 419dc405c831..ad133fe120db 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -77,7 +77,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
  * Called during kexec_file_load so that IMA can add a segment to the kexec
  * image for the measurement list for the next kernel.
  *
- * This function assumes that kexec_mutex is held.
+ * This function assumes that kexec_lock is held.
  */
 void ima_add_kexec_buffer(struct kimage *image)
 {
-- 
2.33.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
