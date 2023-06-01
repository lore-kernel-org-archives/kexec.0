Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7743C77B7E
	for <kexec@archiver.kernel.org>; Thu,  1 Jun 2023 07:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YHGbfsp7ih5yzKi6eiEINJlVvumT38Rmid3H6Gp4RWg=; b=g/wazMSNsUpotn
	rrqybab/Ui7bTuqrpeAwfaAI0zCirDxNuZ+d9FXpJSVmS9D+8rjSsEU4dnNmgzQav44aE2I9sOatB
	aUOQG2vYs+sJ9Nm9wqrehhaK9nJs0PRU5McrGhXUqDhXrCf4sgPfm7c0TIuXHi0hMNOPBjFniRXUw
	6l/fsULmLJ1ci3ORezcRFuSY12ppSPXAtDRyUYqMVqIP9QJkfkV1rqr1kcRT31808ZD3SFJr2BDux
	zDzSJIZcfGItMn3Koefr9IcjujAf/6U/yC+EhfuMqFsZS2aeAmHr/fp+ChApbPZESq9iXz4T2lLWn
	aywiPaIkLwlUhH1KZVlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4ciD-002M0X-0B;
	Thu, 01 Jun 2023 07:27:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4ci6-002LxM-1Z
	for kexec@lists.infradead.org;
	Thu, 01 Jun 2023 07:27:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685604421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AV8aUvr4ixGLZyIesmYQLsbGSBUr0/xlhliel/t7Lh8=;
	b=AH1URn8B2HovRQ+uvclrnX09ibpnOHs1KfjD6gZ/QkKrwAluhy0Bh9xrQdRBhXwYIZrc0L
	7EpR3Wl+5U9FH3DK9U5FUTzYv3kvPYd+G45BtCCJqRvPGsFXD1fdqqoKtVfyl2rG1OyAMb
	Bl+R2cNJ4t8M85huOseB9xEnIKPcCFU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-gOSVzEH8PYC5qyD_j7qF6w-1; Thu, 01 Jun 2023 03:24:53 -0400
X-MC-Unique: gOSVzEH8PYC5qyD_j7qF6w-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1b031a8fbe5so1757525ad.2
        for <kexec@lists.infradead.org>; Thu, 01 Jun 2023 00:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685604292; x=1688196292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AV8aUvr4ixGLZyIesmYQLsbGSBUr0/xlhliel/t7Lh8=;
        b=CIxqUXucQPeK4PCkN/tK9ui1CQ4yvfB1mL7BPU85CBQjGA2T+sDcZK7DWwaNw/hpMD
         xIucSaBhY16raVl7IIdIdfVG1hpMvXRwRTmvQ6zqgEOiYpn9K8A6DiqFOcsEpPYb3zAC
         dTNv1utcguxksx+FUWKGbL0mi0AlFjuVtfWCR3ZlfCjfjWzP1aZjilGFhQ52cdRHOjFA
         RgAreQeaIoKi2/C+4ZdoHQU1DU2B4zCV+X5rA/uO+ZgvEUjM1Z5m+07zQDZHCDMgY6pp
         wStjOfHjcWeU0SzWfcrWhyE7OeopjqF4Gsj0l8FBrE4iUDM7CyPWGawX+rqjptpEZzXo
         SH6A==
X-Gm-Message-State: AC+VfDy91KkSaw+GNh91e8GrbP2XvKqKndOdNj0PA7LOqhGJUPb/u0q3
	DoewoihqZ+uNSwKTCpnQmXFLXrExZp4mWfNi9slDkO32ozVdzwWbX8UeMkyjT9cQ/iPqx16YYM7
	jp3QnwmvLvTKevH7ceZU3fErJ1yknNJellu5JEvTU3UwqIkVOQJRTxX/I+e797Zbr5dr7HVliWA
	zvUfsv
X-Received: by 2002:a17:902:e811:b0:1b0:5e97:ee2e with SMTP id u17-20020a170902e81100b001b05e97ee2emr6960546plg.19.1685604292090;
        Thu, 01 Jun 2023 00:24:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ662P0lLrFIg86H16E966109yZnfDIKygWQtWOgjwFAIugqodl1XMDNcj6+cm1VNgP+uGfilg==
X-Received: by 2002:a17:902:e811:b0:1b0:5e97:ee2e with SMTP id u17-20020a170902e81100b001b05e97ee2emr6960516plg.19.1685604291629;
        Thu, 01 Jun 2023 00:24:51 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00199203a4fa3sm2666890plg.203.2023.06.01.00.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 00:24:51 -0700 (PDT)
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
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH 1/5] kexec_file: allow to place kexec_buf randomly
Date: Thu,  1 Jun 2023 15:24:40 +0800
Message-Id: <20230601072444.2033855-2-coxu@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601072444.2033855-1-coxu@redhat.com>
References: <20230601072444.2033855-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_002702_622030_0B54DAF2 
X-CRM114-Status: GOOD (  14.61  )
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
index 22b5cd24f581..5b2440444112 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -172,6 +172,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
  * @buf_min:	The buffer can't be placed below this address.
  * @buf_max:	The buffer can't be placed above this address.
  * @top_down:	Allocate from top of memory.
+ * @random:	Place the buffer at a random position.
  */
 struct kexec_buf {
 	struct kimage *image;
@@ -183,6 +184,7 @@ struct kexec_buf {
 	unsigned long buf_min;
 	unsigned long buf_max;
 	bool top_down;
+	bool random;
 };
 
 int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f989f5f1933b..5dbfc119eb6a 100644
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
@@ -419,6 +420,16 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
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
@@ -427,6 +438,8 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 
 	temp_end = min(end, kbuf->buf_max);
 	temp_start = temp_end - kbuf->memsz;
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, temp_end);
 
 	do {
 		/* align down start */
@@ -464,6 +477,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 	unsigned long temp_start, temp_end;
 
 	temp_start = max(start, kbuf->buf_min);
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, end);
 
 	do {
 		temp_start = ALIGN(temp_start, kbuf->buf_align);
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
