Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0926CC02196
	for <kexec@archiver.kernel.org>; Fri,  7 Feb 2025 08:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SAfH8CaZcdNlX6bGu3s15qKUzaN5EneIuMEhM/Mtjyc=; b=Gye3JBGsYYBKhJ4C0QKJCwb1fC
	Ci8nr5hqartA7WosCbzXVpGDXXPZ8OPv8NQ6XpQ2Q+2bm1uzolWtD2kxIQEPTgvQfdHDDPotsYZgg
	OHmcO4+KLJVGHQOkurtmMUUaZblwH7HQBCBIOpUrSAkAxmry+kWposb3LjrX/Ck5psRFdDlnbQ5M8
	rmchbAkx3c2tZiTPphdl6+tfWZj9anA2LcYtrgpCgKOzOXc82IOzH+xunpjWbFENq5u/nFR/MJDft
	3YOF8wIwnt4CjztF2QP8vUk0LJX6Ffwbvczn7fu/B+338cMv3cdCoaGQxGvn1sjIn83CoAu8qp8xQ
	Gu/YMDXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgJQw-00000008l8p-33IW;
	Fri, 07 Feb 2025 08:09:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgJPZ-00000008kat-46xA
	for kexec@lists.infradead.org;
	Fri, 07 Feb 2025 08:08:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738915709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAfH8CaZcdNlX6bGu3s15qKUzaN5EneIuMEhM/Mtjyc=;
	b=cEgYv4tuh7Z6TFtX1QMiUlLRETomrYRuSyXGdk8Z9lIBmb/1JyGQN/1Cc2egPjJ3RgD8sQ
	OdX9BA6AgwEJs7elIcjbDgOkDCVJ/BEVE49CKSAzWM6zlzWJooPptb2/b9FV55e5Bs9Exw
	klgDXpeQxtyJgPGfyV0X/P3OWY2C1WE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-uD7PR90tMe6IHu1FMBnxQA-1; Fri, 07 Feb 2025 03:08:28 -0500
X-MC-Unique: uD7PR90tMe6IHu1FMBnxQA-1
X-Mimecast-MFC-AGG-ID: uD7PR90tMe6IHu1FMBnxQA
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21f444af89fso18545175ad.1
        for <kexec@lists.infradead.org>; Fri, 07 Feb 2025 00:08:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738915706; x=1739520506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAfH8CaZcdNlX6bGu3s15qKUzaN5EneIuMEhM/Mtjyc=;
        b=ifarPe2yefIYMFHIkutQKOD6Ypb5aC2VQQ7qHsllNq+G5zdjT1ZXNld0cwR/FZPr5n
         2xO9unUaUip8h6cwHc4Q+/nP8hmCz4YLrZ2YmhGibrXnv3dFiJqIJaC5T0/jwk94R6FR
         aXrhhsvjWkFtkef3/APYkmnoELjTjLISlyRIdHQMIO7TSrR4zoSgCOf61NxGYChNeuBP
         sNxQ1Q9L1w8ea2EgLgWHh4vmdgowzqAAXAbe5JjtrpO4ubXELNT9qNam7G31zrBEIxvH
         vPI/SYphzAY7kBL7qLuSQsjDNVWZgFjIVRjyCB1qouRob4C3HxvCGScxJCkwfSXBQiul
         4EPA==
X-Gm-Message-State: AOJu0YyjohSccxVrYTT+5hdXLijXSWyHSdnB3ymTqdfizmRkED526Oo9
	a1nzgyo/xFZM00lWj6unvLegyjkW9j0BMxlWWiXAFyjdOa8H7ugLjlrG4CIxUwRP4B09D2Onw3X
	SizMLdwobLrAdelT6NJcg5ozOptcYd7omTf0XgmfKY1dhAv7hqwSkd1m/80PKUzidLG5/11op3g
	L2zu7pYLG6yX+vt6RdhGhrXHJDatJ+Q7TzO2DDfnQN6A==
X-Gm-Gg: ASbGncta4BddC5PPHgJVTIdb1gDIizC9QUmYmdlv3GBbmhRXYKsLwkqUIL90xMnaCHe
	1Fq/LGWE2tSfZwTS4Iz1kbQU9dXaomVPR3Th1jLa9U11uckgHSzyHWN5QwUeeQ52mDsmLaEuJq/
	AmoI1KSxNZtKGyIjr58Zq7sYFNYYHRB+crNQyzuRTL54lXNGHM6/XpFczxitPORi/F0a8uu3cLf
	7/Kkyr9ucpVwcpBJj9rg4q+i4mYFBd0ZsiGJZNbEz7wIVWrQi3i3qtmi+zo65AOTpuLQZBa
X-Received: by 2002:a17:902:ef51:b0:215:6995:1ef3 with SMTP id d9443c01a7336-21f4e6a1125mr40433775ad.3.1738915706612;
        Fri, 07 Feb 2025 00:08:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPE/gqMkWPnB/djnJNY/obb5cFGvAP4LjWDnm8O0PsSmswh+uBBdXKftkoZyy8le1irXB8Pg==
X-Received: by 2002:a17:902:ef51:b0:215:6995:1ef3 with SMTP id d9443c01a7336-21f4e6a1125mr40433315ad.3.1738915706122;
        Fri, 07 Feb 2025 00:08:26 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650ce21sm24790205ad.26.2025.02.07.00.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 00:08:25 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v8 1/7] kexec_file: allow to place kexec_buf randomly
Date: Fri,  7 Feb 2025 16:08:09 +0800
Message-ID: <20250207080818.129165-2-coxu@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207080818.129165-1-coxu@redhat.com>
References: <20250207080818.129165-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e7iNLtnAUc3MggASx-8e0ylhMXU1ueCFHXXVm3rVPws_1738915707
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_000830_089507_C71FB73A 
X-CRM114-Status: GOOD (  15.14  )
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

Currently, kexec_buf is placed in order which means for the same
machine, the info in the kexec_buf is always located at the same
position each time the machine is booted. This may cause a risk for
sensitive information like LUKS volume key. Now struct kexec_buf has a
new field random which indicates it's supposed to be placed in a random
position.

Note this feature is enabled only when CONFIG_CRASH_DUMP is enabled. So
it only takes effect for kdump and won't impact kexec reboot.

Suggested-by: Jan Pazdziora <jpazdziora@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kexec.h | 30 ++++++++++++++++++++++++++++++
 kernel/kexec_file.c   |  3 +++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3..61269e97502a 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -25,6 +25,10 @@
 
 extern note_buf_t __percpu *crash_notes;
 
+#ifdef CONFIG_CRASH_DUMP
+#include <linux/prandom.h>
+#endif
+
 #ifdef CONFIG_KEXEC_CORE
 #include <linux/list.h>
 #include <linux/compat.h>
@@ -171,6 +175,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
  * @buf_min:	The buffer can't be placed below this address.
  * @buf_max:	The buffer can't be placed above this address.
  * @top_down:	Allocate from top of memory.
+ * @random:	Place the buffer at a random position.
  */
 struct kexec_buf {
 	struct kimage *image;
@@ -182,8 +187,33 @@ struct kexec_buf {
 	unsigned long buf_min;
 	unsigned long buf_max;
 	bool top_down;
+#ifdef CONFIG_CRASH_DUMP
+	bool random;
+#endif
 };
 
+
+#ifdef CONFIG_CRASH_DUMP
+static inline void kexec_random_range_start(unsigned long start,
+					    unsigned long end,
+					    struct kexec_buf *kbuf,
+					    unsigned long *temp_start)
+{
+	unsigned short i;
+
+	if (kbuf->random) {
+		get_random_bytes(&i, sizeof(unsigned short));
+		*temp_start = start + (end - start) / USHRT_MAX * i;
+	}
+}
+#else
+static inline void kexec_random_range_start(unsigned long start,
+					    unsigned long end,
+					    struct kexec_buf *kbuf,
+					    unsigned long *temp_start)
+{}
+#endif
+
 int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
 int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 				   void *buf, unsigned int size,
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3eedb8c226ad..875fe108cc83 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -445,6 +445,7 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 
 	temp_end = min(end, kbuf->buf_max);
 	temp_start = temp_end - kbuf->memsz + 1;
+	kexec_random_range_start(temp_start, temp_end, kbuf, &temp_start);
 
 	do {
 		/* align down start */
@@ -483,6 +484,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 
 	temp_start = max(start, kbuf->buf_min);
 
+	kexec_random_range_start(temp_start, end, kbuf, &temp_start);
+
 	do {
 		temp_start = ALIGN(temp_start, kbuf->buf_align);
 		temp_end = temp_start + kbuf->memsz - 1;
-- 
2.48.1


