Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48737C3ABC3
	for <kexec@archiver.kernel.org>; Tue, 13 May 2025 14:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CrG5JCMO4jYURJHK9ELmzS8KkDxV+BeLbEnzcZyD8y8=; b=Ifv4DkTCrC2DyDe7hff4FDGqP5
	M/WkLi1M4OKNFvKDzY5qr9v92yNd/AwU2nwJHk+z+tjK4tNLwus0uILvwZ9wllI2ZZwCxULevW2ED
	fGFhHY7kjQZ4vFhF2/glKa41rlw92WIxUmVcyJghpko1tyNNMQzdwD7Aq31BH0+3v9sq7Y6LkwiaM
	opl7lJd86TiuzAeg7pj+c7vQr0TGmw2wqf5DEBNx086xcVG1O3vY4QqVMOIITouaGEswgHLr2uehN
	q3PODB94CwAzukpiRS3fwTF79GCEYHQtbf2LGLc+uixxXy4zNd2OTDvCvxWtyA76J0L+CCYtU5Wls
	GSo8XbCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEqkB-0000000Cd2X-1dS2;
	Tue, 13 May 2025 14:36:31 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEqfV-0000000CcR1-3A7T
	for kexec@lists.infradead.org;
	Tue, 13 May 2025 14:31:42 +0000
Received: from DESKTOP-VOT081N.hsd1.ga.comcast.net (unknown [20.110.218.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id DEAB3201DB25;
	Tue, 13 May 2025 07:31:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DEAB3201DB25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747146699;
	bh=CrG5JCMO4jYURJHK9ELmzS8KkDxV+BeLbEnzcZyD8y8=;
	h=From:To:Cc:Subject:Date:From;
	b=OSMGaQmM5SwvZO3A1bwH2mUdhDs/VhcR0TgRB6kul68ZhUrtKwLxKU5ZpLGEdqvKE
	 GvFZ0bzAmSYhqg0GN/fisk0jkE5eRn6yVFGNw1fwrPPzDHUZPKuoJkl/H9HpgSsjuC
	 9Ls8Ot60JbL8UcoHNGs8PYZpm5zN8kiteKH/ctG8=
From: steven chen <chenste@linux.microsoft.com>
To: zohar@linux.ibm.com,
	stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com,
	eric.snowberg@oracle.com,
	ebiederm@xmission.com,
	paul@paul-moore.com,
	code@tyhicks.com,
	bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com,
	nramas@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	bhe@redhat.com
Subject: [PATCH V2] ima: do not copy measurement list to kdump kernel
Date: Tue, 13 May 2025 07:31:29 -0700
Message-ID: <20250513143129.1165-1-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_073141_821207_B23ABB82 
X-CRM114-Status: UNSURE (   9.71  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Steven Chen <chenste@linux.microsoft.com>

Kdump kernel doesn't need IMA to do integrity measurement.
Hence the measurement list in 1st kernel doesn't need to be copied to
kdump kernel.

Here skip allocating buffer for measurement list copying if loading
kdump kernel. Then there won't be the later handling related to
ima_kexec_buffer.

Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
Tested-by: Baoquan He <bhe@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
V1 - https://lore.kernel.org/all/20250502200337.6293-1-chenste@linux.microsoft.com/
V2 - Incorporated feedback from the community (Baoquan He and Mimi Zohar) on v1

 security/integrity/ima/ima_kexec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 38cb2500f4c3..7362f68f2d8b 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -146,6 +146,9 @@ void ima_add_kexec_buffer(struct kimage *image)
 	void *kexec_buffer = NULL;
 	int ret;
 
+	if (image->type == KEXEC_TYPE_CRASH)
+		return;
+
 	/*
 	 * Reserve extra memory for measurements added during kexec.
 	 */
-- 
2.43.0


