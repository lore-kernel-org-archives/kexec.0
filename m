Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56626C4332F
	for <kexec@archiver.kernel.org>; Sat, 16 Dec 2023 01:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cgh+5izzppX67kuf+PZLOQpiYhDw9pq95DdGI/P8VT4=; b=2YgaCMF5cy3TK5
	7tZ2iBrJYyBm+Zgl3mo6LcmoNzMFxaCU70YRix+BdLy1RrNQ2vm3JRfd+iOIWvBd98YUI74Ta80SG
	yYtB4hD+M/dByQQ3VP88aAuiypNdaAU4OxnImkaOdlD8rrQ2XMxUDZrKi8oGwOVTekL7JNCFzasw7
	6pHsw8h4xqLjbvVrp9e52gnfS4UGKUeF04FQgAFjPo03/sdLMV+wNTAFJe6UBNCSZ3bbQfWdB//9G
	E5HNpPdwTtgOzCFkTo5MGyjXt5NbymCSyeAwY4ezwpmZeCd50HdgH0/qY5jim9mle4U5NsWcg9bdK
	+9rx8gdTe2l4plSIVw5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEJ9e-00544v-25;
	Sat, 16 Dec 2023 01:07:46 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEJ9c-00542P-01
	for kexec@lists.infradead.org;
	Sat, 16 Dec 2023 01:07:45 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id EA10920B3CC1;
	Fri, 15 Dec 2023 17:07:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EA10920B3CC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702688860;
	bh=F9K7Rc9TpRNNFu6bus4pmdllRgh3199Skv9ZQY0T4F4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GU/bb5UnCHXdTAijfRo8dmDKT43lYFPcnqtovspj7ZNB1YY9gROuyuNHlcAw+r1ea
	 04V9ylonliFf4XvbMBBVYQF6iRGns4+rJoRYHaMt/zyk+ufpXOZdkauKukoDbhfX7a
	 VdB1rTanfcAYntWkGGDcnO1rvsdJ+/WSOZBJ+fH0=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com,
	eric.snowberg@oracle.com,
	stefanb@linux.ibm.com,
	ebiederm@xmission.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH v3 4/7] kexec: update kexec_file_load syscall to alloc ima buffer after load
Date: Fri, 15 Dec 2023 17:07:26 -0800
Message-Id: <20231216010729.2904751-5-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_170744_094906_C2B87A32 
X-CRM114-Status: UNSURE (   9.19  )
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

Implement function kimage_file_post_load() to call ima_kexec_post_load()
This ensures the IMA buffer allocated at kexec 'load' is mapped to a
segment in the next loaded Kernel image.

Modify the kexec_file_load() syscall to call kimage_file_post_load() after
the image has been loaded and prepared for kexec.  Call the function
kimage_file_post_load() only for kexec soft reboot scenarios and not
for KEXEC_FILE_ON_CRASH scenarios.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 kernel/kexec_file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index bf758fd5062c..ee38799ff1a3 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -184,6 +184,11 @@ kimage_validate_signature(struct kimage *image)
 }
 #endif
 
+void kimage_file_post_load(struct kimage *image)
+{
+	ima_kexec_post_load(image);
+}
+
 /*
  * In file mode list of segments is prepared by kernel. Copy relevant
  * data from user space, do error checking, prepare segment list
@@ -399,6 +404,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 	kimage_terminate(image);
 
+	if (!(flags & KEXEC_FILE_ON_CRASH))
+		kimage_file_post_load(image);
+
 	ret = machine_kexec_post_load(image);
 	if (ret)
 		goto out;
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
