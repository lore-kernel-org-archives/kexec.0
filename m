Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8161DC05052
	for <kexec@archiver.kernel.org>; Tue,  1 Aug 2023 18:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+KdklXwBw1Xv44SFlKpnhF9mUu1mnJNOjcrPFvEXo7M=; b=O8HjwxUfmolc0d
	W4JQXxGF7xScbhjXv9FP9f2EAfkoaZlelcA6DFv01Hp7NNSy3lyTQsPH+kAcR25Ln58qee/Kl/lLp
	+R2BJRgZGB3yWOykirR1Lh+ieNrbT2JL1A+XBJPnWvaS+cWOJB4x7hYNvXRzu3IzVs8vZxtcjtGz/
	DVYuWSa3nLuFV19vt3K+Ugg15J1n0GxYp4KnrYfXxmO1pBLeyCYW6HHP66YfKK5aak4is9zNX8fOV
	DczT6HTytun2gx5iO6MUGNT5tsRfnyes9xC4exPtA6VC0yyyvnMhHz3Alx/4dCIJD5YXddQZbrPS7
	qY8PhVd/3PcSp8ZBw1Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQty2-0030nh-03;
	Tue, 01 Aug 2023 18:19:34 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQtxy-0030m7-1O
	for kexec@lists.infradead.org;
	Tue, 01 Aug 2023 18:19:31 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 359E5238AEA9;
	Tue,  1 Aug 2023 11:19:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 359E5238AEA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1690913969;
	bh=wudBVQFohkkzXxCbB2YMhOCNd/qTfMjxbpTBbqY9dK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PfaY43aUZRm8DwP24QcvpHl3eVWh3GmSYwFS/W0vNbyTGX5CwEmejnSwQ1M8NolHn
	 KaXAqV6CkHLBVlWThL4p+EqN2M8bBxXM2n6vJFinHjJRhhMihb7do9qxe/ly7y4MN4
	 VVideAkJST33sRJmHVBaLZ9/gG0MTPGTgyleEA6s=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	ebiederm@xmission.com,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH 6/6] kexec: measure TPM update counter in ima log at kexec load
Date: Tue,  1 Aug 2023 11:19:17 -0700
Message-Id: <20230801181917.8535-7-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230801_111930_493733_E00B46EA 
X-CRM114-Status: UNSURE (   9.69  )
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

IMA measurements snapshot occurs at kexec 'load', but any additional
measurements between 'load' and kexec 'execute' aren't carried over
post kexec soft-reboot.[1] This may lead to TPM PCRs extending with
events that are not reflected in the new Kernel's IMA log.  By measuring
the TPM update counter at kexec 'load' and at ima_init after the kexec
soft-reboot, the remote attestation service can identify potentially
lost events by comparing the log event count with the counter difference.

Measure the TPM update counter at kexec image load.

[1] https://lore.kernel.org/all/20230703215709.1195644-1-tusharsu@linux.microsoft.com/
    ima: measure events between kexec load and execute

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 kernel/kexec_file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f1a0e4e3fb5c..4b6391b02c5a 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -246,6 +246,9 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 				  image->cmdline_buf_len - 1);
 	}
 
+	/* Measures TPM update counter at kexec load. */
+	ima_measure_update_counter("kexec_load_tpm_update_counter");
+
 	/* IMA needs to pass the measurement list to the next kernel. */
 	ima_add_kexec_buffer(image);
 
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
