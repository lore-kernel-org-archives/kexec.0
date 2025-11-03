Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E709CCF9F8
	for <kexec@archiver.kernel.org>; Mon,  3 Nov 2025 06:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bCRxv5EtM0tvDW4JhQ+LpOOVgm4zkB9w1mcNoEZGj5U=; b=e/QXKiRVrJMF7cZlWT+mSoRD9w
	0R7cJui73BG8FAj3bdUSVeeS3wsyoH+x2aVwafMNTrjkqoHX0o6mXPX9v0JVE56UTd7pSGF5M8ggM
	NRpVtkGWgBZG9XXwS4eOjsiJyHWdyX1H3TXL3J7JPkN0XYTz7cAM5hpdtj3iF9sPtft/lEVTWaawR
	ByYvYgp8n3r1u7P98TdkOqiXa73+P47UKdz5cKiWlAmiNZjewV3RflHn3NkSeDve0s09xcP3Q2b+4
	QifQcm6H08K9GZ5YcdvR7WHSpexk8Uc/2I/IZk3CE9B5jSkiUOcLRDNEB5DgaDDQMp8/0szgiER00
	0WmY+BLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFoCp-00000009JFt-3gA8;
	Mon, 03 Nov 2025 06:38:19 +0000
Received: from smtpbg151.qq.com ([18.169.211.239])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFoCm-00000009JAp-2S0c
	for kexec@lists.infradead.org;
	Mon, 03 Nov 2025 06:38:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762151863;
	bh=bCRxv5EtM0tvDW4JhQ+LpOOVgm4zkB9w1mcNoEZGj5U=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gavmX8c3736K0IC+EbaGnB1ajjL7znUfFRFS5p8qM5br3WRxMtW7KsBeO3FOS/xVN
	 iLdHB8xO78wHrLSbbhgDjVM875M56YGPETeiEpq6wNOxdGvA23sWc1hUmwG+p3bf9t
	 eB/sbNrkv39AOHixrJq9RbGJL9UolSetxZhMaNI8=
X-QQ-mid: zesmtpgz4t1762151859td14c1dbe
X-QQ-Originating-IP: RhqAIz/08Wyxiq6Fw68hfnrDcEIHZXXUupI08eRw7Mc=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 03 Nov 2025 14:37:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10891316942982493356
EX-QQ-RecipientCnt: 5
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH v2 4/4] kexec_file: Fix the issue of mismatch between loop variable types
Date: Mon,  3 Nov 2025 14:34:40 +0800
Message-Id: <20251103063440.1681657-5-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251103063440.1681657-1-maqianga@uniontech.com>
References: <20251103063440.1681657-1-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: M/NR0wiIuy70E515xT9T6A/bvLkicHDLC/2+af/Gk9QQa4J1wPG/EEQG
	xr1Sodyf5gFjBymm74UzOogkv8TIv521xHSGvART/m2LW3MjQ2dgkckBIDlzu3k3MWjAz54
	0j+MA8Io/1vfL0aPnCpMz6VO2MOQsx8g5mHMIFXTZFLOBxuo8K3TRpnfyIMzMOwKJmKvpom
	yYTyG9jLz+vm0hLYVehK0RjwAaHjtazAgrCUnHn7TNwuGkhRElpib1kWTyOvTEk2iTX0Cmz
	xiAGT97IoBmfVkuH9iiSzYF4NIYHZRPFQJscUhWLMJ8NNX/Pgndav7LVR+Agq9nMbPDzt9X
	N0QNxOv3tabvvxvVReHMvtzrFw/C7Fs7hDGpk7ZYqh8i27rwGWm/ZqflLHYbiuYgJZWpzqK
	dR3oStu7T2xMyBr4sEnu8ZcxGNBc4GF6qiC+5KAMmItZAIqVrdziwyRYQpcOYkywt9YKmw5
	gr7Y17qnNLh1cH+LW7hSs4OnLcrbfasEjggLgBUH+4SvV+GVaZx8YzO5sX1UZ13WZiDtbLW
	341cI878p85PyrMdl2G2NJ3OtfUYvCTBbld/XNXL3e+ewjAhzEORwSspYOH61dUIpYK9W6g
	UWgbnlTeSi1aRd2wSO9L589KWcmUFTzFFRP+x/3Oj2ql5UbDGnmE/yub/YWFpaBMizdnum6
	E3B8R9pRkMWb4FpIfvZ2UHq0iw8goD1lgCpr/lXng9G5jYchihmaIqL4XWbC1bmBwfr0siu
	f6n5/IrXDn+oV2O5IDdi6SFC9cyF38h2Xn2O0CxL0MaWIIDVd8vvdWVGbGqrlptUHmaFjxm
	g6MpEhBk6rHC0TEGKnGFb90FPXMoWEalPRR1z/P2QM2TaussWgm4ZvDA1D64vBMQNvep7jR
	rXKYqHAEfs5teIvlBBvwrD1maTbdyZQ5FxXlMKPP9rKlBZ4gWISMf8l+2bcuxyVrqhJVHlP
	nh3k6kHAov36ayRFIFWzMVi05YrFLgpoFU3Ld3mCFUhJjU12gGnJ4pmffKCLqrigldJthcu
	YOJ4vDsAJEXBMD6PlpvrDK6vQE6lkKC0j8OAZxINVmKddtwToO
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_223817_115112_25B449D4 
X-CRM114-Status: UNSURE (   9.78  )
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

The type of the struct kimage member variable nr_segments is unsigned long.
Correct the loop variable i and the print format specifier type.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 kernel/kexec_file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 4a24aadbad02..7afdaa0efc50 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -366,7 +366,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	int image_type = (flags & KEXEC_FILE_ON_CRASH) ?
 			 KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
 	struct kimage **dest_image, *image;
-	int ret = 0, i;
+	int ret = 0;
+	unsigned long i;
 
 	/* We only trust the superuser with rebooting the system. */
 	if (!kexec_load_permitted(image_type))
@@ -432,7 +433,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 		struct kexec_segment *ksegment;
 
 		ksegment = &image->segment[i];
-		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
+		kexec_dprintk("segment[%lu]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
 			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
 			      ksegment->memsz);
 
-- 
2.20.1


