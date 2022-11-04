Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D716C43217
	for <kexec@archiver.kernel.org>; Fri,  4 Nov 2022 11:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=55ToJK0fDtJymLckUvBXuRbbMkryCbtqq108rg192bw=; b=yt3ypV9Hr8O4jd
	kgSvfeoy7UecsFHeVSoyaVgQiEAwePjecYiIb6PcQXtMT79mQiRndm2xmZLYyIAPBOeF/ukDyx0Fo
	QOJgXdM3ksWblRyTlp1I/etKrqNgA6yYgWTvQbN88TSEMugZGNqO1KSeLJ94BU4jvBkMDczqLMeHj
	5031xQPmwge/UiCNMoey8um27v7+QihnNWrNVyESh1P08eJDUSrWbnK4ZFLJdJeUJlSaVFeF1G27Y
	jFYEX2/E4hzlpdiioO7R6ZBdJHO44zK60ocvL5RvOw02WKJrRDqBsuhxTHMvwH38PMUB+qd/RBf36
	FTuqgVLNwu5qZ787zLog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oquvf-003M3g-BM; Fri, 04 Nov 2022 11:32:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oquvb-003M27-8I
	for kexec@lists.infradead.org; Fri, 04 Nov 2022 11:32:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667561521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uJy9Oiy5cpKmClijTkDe6KXjFE6VRuxm2Fp2gVJ4PwQ=;
	b=D4XfM2fRohQfERs8AGGPSFfgugAUX1M3iyY/OP5S+hxhw1f+xpYVykXArGjRV9Tm/hsfRL
	iNTB9J1t9Z2J+cEJ7biyX0G7nYmW0mR5zRmtR4Hg+MAjNAIay9aZMczvzHMG0GGut+0fng
	niBJz7Fu4x/9x5dsqoOS6+aMk/0JnZU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-141-jUkdeUI_NtCBobQd63JGtQ-1; Fri, 04 Nov 2022 07:30:20 -0400
X-MC-Unique: jUkdeUI_NtCBobQd63JGtQ-1
Received: by mail-pl1-f198.google.com with SMTP id t3-20020a170902e84300b00186ab03043dso3425878plg.20
        for <kexec@lists.infradead.org>; Fri, 04 Nov 2022 04:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJy9Oiy5cpKmClijTkDe6KXjFE6VRuxm2Fp2gVJ4PwQ=;
        b=dA2wXSTcpeYFKITjFXNyKg2IAe23T/eY7PxwiuNRlwrLyfzZjyjgTjALaRdFO0lAHC
         VSDqoG6+z24rwtIfHjCsLknmNSiA4Pzx+iLEW/vru1dZVDqMgTva+SJMO5Qio2W7EztA
         UltYouGh6j15URvBBoypkuEuyRQFsbA+u/WC67k3FZFVqSMVCRcvZaygdmLump+EaXl/
         3EaNYUWE3fusMJBEc/VUiZ1AnX3+iP+2EOF08RBHbCPeennmHIcW2eBPMTAI+9+riRPQ
         dLVuHINyF+BdR7aieEeVO3U+GzoIM4WeHfbhLGcW8B2gf1xYDT2C8HMBq6xGf2YOuLu7
         Fo/w==
X-Gm-Message-State: ACrzQf2W9vqch0lGw4LkKPquf2vv54X0Cu7Z8WA9Q1haCsAi+aZcsB9O
	Usz3jztHAPx1NYIonnNQdP3xNhhT/n/d5hKz6abqE6vGS7HfMrnlH5Smp+mWGRHDgTcDe5MQuZ5
	Oj+5HOoTiezXzVoiMq3NkvK7739Wa0Y8EZgR6rPLTvc79sC2uCPHsa7qN2sM2+0Kn2aM=
X-Received: by 2002:a17:902:aa46:b0:186:e220:11d4 with SMTP id c6-20020a170902aa4600b00186e22011d4mr35254843plr.163.1667561419410;
        Fri, 04 Nov 2022 04:30:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5pcZ6tNaPqq0YoJX850E6WOJZ5lbYOLfvzVTVy1cDIH4ecstbrpazqOrRO+fSBQKpe6bAfZw==
X-Received: by 2002:a17:902:aa46:b0:186:e220:11d4 with SMTP id c6-20020a170902aa4600b00186e22011d4mr35254808plr.163.1667561419017;
        Fri, 04 Nov 2022 04:30:19 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902684b00b0018855a22ccfsm2430982pln.91.2022.11.04.04.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 04:30:18 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Kairui Song <ryncsn@gmail.com>,
	dm-devel@redhat.com,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>
Subject: [RFC v2 1/5] kexec_file: allow to place kexec_buf randomly
Date: Fri,  4 Nov 2022 19:29:56 +0800
Message-Id: <20221104113000.487098-2-coxu@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221104113000.487098-1-coxu@redhat.com>
References: <20221104113000.487098-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221104_043203_404707_84CCEE69 
X-CRM114-Status: GOOD (  13.79  )
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

Currently, kexec_buf is placed in order which means for the same
machine, the info in the kexec_buf is always located at the same
position each time the machine is booted. This may cause a risk for
sensitive information like LUKS volume key. Now struct kexec_buf has a
new field random which indicates it's supposed to be placed in a random
position.

Suggested-by: Jan Pazdziora <jpazdziora@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kexec.h |  2 ++
 kernel/kexec_file.c   | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 13e6c4b58f07..c0edb64bf6c4 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -171,6 +171,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
  * @buf_min:	The buffer can't be placed below this address.
  * @buf_max:	The buffer can't be placed above this address.
  * @top_down:	Allocate from top of memory.
+ * @random:	Place the buffer at a random position.
  */
 struct kexec_buf {
 	struct kimage *image;
@@ -182,6 +183,7 @@ struct kexec_buf {
 	unsigned long buf_min;
 	unsigned long buf_max;
 	bool top_down;
+	bool random;
 };
 
 int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index a7b411c22f19..ed9fcc369312 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -25,6 +25,7 @@
 #include <linux/elfcore.h>
 #include <linux/kernel.h>
 #include <linux/kernel_read_file.h>
+#include <linux/prandom.h>
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
@@ -412,6 +413,16 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	return ret;
 }
 
+static unsigned long kexec_random_start(unsigned long start, unsigned long end)
+{
+	unsigned long temp_start;
+	unsigned short i;
+
+	get_random_bytes(&i, sizeof(unsigned short));
+	temp_start = start + (end - start) / USHRT_MAX * i;
+	return temp_start;
+}
+
 static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 				    struct kexec_buf *kbuf)
 {
@@ -420,6 +431,8 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 
 	temp_end = min(end, kbuf->buf_max);
 	temp_start = temp_end - kbuf->memsz;
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, temp_end);
 
 	do {
 		/* align down start */
@@ -457,6 +470,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 	unsigned long temp_start, temp_end;
 
 	temp_start = max(start, kbuf->buf_min);
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, end);
 
 	do {
 		temp_start = ALIGN(temp_start, kbuf->buf_align);
-- 
2.37.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
