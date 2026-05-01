Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5489DCCFA13
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 23:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u2raLWGOHXV7U+bBCWk9otg1RvLIEFkuq+ZFzNDCnUU=; b=o19CsDb7jtrv3U9RE1zAY9YAwa
	h6VynTI5eSY5MYsD+ZogFB8QPz/5lrfL4xCThAajY7hB/XdnlVLlPpSTySlFK3EblZ5+vRuVzrE9O
	HHoHIN6CaIjiCF82zlvrSRZo6PcEn+XB1ANJ5JSapO0VCt6zFrfaU5NluEEWmwA2oo/7X3pigOm8S
	GmHIVDo2GVdQ+Iae6VGvYZv7DeOdYAWM2yczICYGPN34ImQaAWW35G9oiYumZ2BHya2Uw4j6Oaqnm
	1xu8pfKicwlKbhRFgHyyzJt2sbT7x0G2BjNWSIZtxhllmmfDBSfbsUK35+evoJILGvpQvndaEveDw
	LGbspSjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIxX4-00000007qf2-0KPU;
	Fri, 01 May 2026 23:44:30 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIxX1-00000007qdl-3ie4
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 23:44:29 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-358ed696623so1039140a91.0
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 16:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777679067; x=1778283867; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2raLWGOHXV7U+bBCWk9otg1RvLIEFkuq+ZFzNDCnUU=;
        b=l5KH2qCbGmt+XNmTQhZtln05r9moYe2fNsVx3haeCt+hSG0QI093JrjnGzkFRTvYMN
         5nNZ/JPSxVg09ugVDhdekcs/0/xia60mBI219j6t4QlLu4pQMuIzPE9L2PXFDYoiVeUt
         iq6q+MeNI3yfNpxaOO44P/tqsmqG1BOL2dkQzO2NiEQxRaq9X3JSZSnIlqojrcY7MS/g
         oGUmLx0FmxXiEmKTNNcRnHvG08S+xrIo3HW1AeCictUX8wTWglxRK01Z+HkBmp6cTkY6
         pwWMnV5Dv9nd0CfMAaGihsQUyU+KWlt612OQlImFiKpopQof4QqfHd0AeWvW+yQ6N1z1
         6WzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777679067; x=1778283867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u2raLWGOHXV7U+bBCWk9otg1RvLIEFkuq+ZFzNDCnUU=;
        b=Ep17cgwQySLid4L3xadh8pJgNAOtvkyt7/ZaW0z2ztkGVWL0+zVwLYjH8xOg65aZW7
         NCybpTEdgCS4lOUsAobM4Sm/gEk0UpdNaG1nLyo2dZHIQ6lnCdkJL2drRyRFLpv25LjB
         6pe3T5mwUie47duTxefu4V7kZBlw9QVBN7zfBUA1kcsuCrD8395RKwQihiDHQ6Ddzc/I
         CS5tpvkZSIJmZBluiz+uly8wF970jgayh+lgT/4XbWsglkif9eNQPYv2IBJqMuH/bKrz
         Qkqrq/PWOJ0YZ6rnybDieDcaQYkMTj4mB0woTi4HBAaHaL5If2ymgF7QBg/V7i/+2e1k
         p4Pg==
X-Gm-Message-State: AOJu0Yw5KSVXl3sEMX0kSlhl+mT/A6QzAxwm/JX7wlrfP6PSqHN38EIM
	0s9pdbNlVWLCOGib7l/5nNl7soaOtl8Zze8sqk0V2RmxbpZSEGImKVhgZxCswc7VXP1MUA==
X-Gm-Gg: AeBDiesvKaazaLqmOpmhyKQHfbXcfHv7P89UJb6noby96csRjTrQ+Jj8kqyA1AeD+DS
	mpmLXmgSYth6rqRnrVDyipGu/Jzms4PBn0hIxGtg2ooGQY+A6RU2OXSH7o5kADVocGW02g9LVR1
	EDzEJDDRkiG4UNCHQmdrKeitU5tfZx492MERNLft3HqR6kCdMJIoAJizPlkqLhf9yLZWOWInf+w
	AF5NCd8NrMgTeLNyPM5Piu9ywaE5tmMpdaNkdMRwqGFfcDpfHKrFTyo/T8sXqtMIAeL2zm/I21W
	j65d3g1cPlI5OlOpjvxTFEPrWF22yNhVtPKLp6Vgq7EQULVjAZX7ZjY5nUDoDWEvCn9NKxKxiXL
	865W7Ix/HDj77d2/F9GDy/KQU2C/6dXZLgEuIyPeHw1gtwjO6gOQJr+QQKJpdK/qDj6Xwx9cBPj
	CgGaeebEtTaxAL+yrpJ0FR3khorjtLGw==
X-Received: by 2002:a17:90b:580e:b0:364:534b:a898 with SMTP id 98e67ed59e1d1-3650cdfe2b3mr1282078a91.8.1777679067061;
        Fri, 01 May 2026 16:44:27 -0700 (PDT)
Received: from localhost ([121.237.249.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ec00a280sm3433586a91.10.2026.05.01.16.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:44:26 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Coiby Xu <coxu@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/9] crash_dump: Read the number of dm-crypt keys from reserved memory
Date: Sat,  2 May 2026 07:43:33 +0800
Message-ID: <20260501234342.2518281-5-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501234342.2518281-1-coiby.xu@gmail.com>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_164427_925877_95CEDDE5 
X-CRM114-Status: GOOD (  13.68  )
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

In case user adds/deletes the keys by mistake, it's safer to read the
number of keys from reserved memory.

Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
Reported-and-Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 6377ee86ec50..a3e460714d23 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -88,21 +88,31 @@ static int get_keys_from_kdump_reserved_memory(void)
 {
 	struct keys_header *keys_header_loaded;
 	size_t keys_header_size;
-
-	keys_header_size = get_keys_header_size(key_count);
-	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
-	if (!keys_header)
-		return -ENOMEM;
+	int r = 0;
 
 	arch_kexec_unprotect_crashkres();
 	keys_header_loaded = kmap_local_page(pfn_to_page(
 		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
 
+	if (keys_header_loaded->total_keys <= 0 ||
+	    keys_header_loaded->total_keys > KEY_NUM_MAX) {
+		pr_warn("keys_header saved to reserved memory may be corrupt\n");
+		r = -EINVAL;
+		goto kunmap;
+	}
+
+	keys_header_size = get_keys_header_size(keys_header_loaded->total_keys);
+	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
+	if (!keys_header) {
+		r = -ENOMEM;
+		goto kunmap;
+	}
+
 	memcpy(keys_header, keys_header_loaded, keys_header_size);
+kunmap:
 	kunmap_local(keys_header_loaded);
 	arch_kexec_protect_crashkres();
-
-	return 0;
+	return r;
 }
 
 static int restore_dm_crypt_keys_to_thread_keyring(void)
@@ -431,12 +441,12 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 
 	mutex_lock(&config_keys_subsys.su_mutex);
 
-	if (key_count <= 0) {
-		kexec_dprintk("No dm-crypt keys\n");
-		return 0;
-	}
-
 	if (!is_dm_key_reused) {
+		if (key_count <= 0) {
+			kexec_dprintk("No dm-crypt keys\n");
+			return 0;
+		}
+
 		r = build_keys_header();
 		if (r)
 			goto out;
@@ -447,7 +457,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	 * cleaned up at the end of kexec_file_load syscall
 	 */
 	kbuf.buffer = keys_header;
-	kbuf.bufsz = get_keys_header_size(key_count);
+	kbuf.bufsz = get_keys_header_size(keys_header->total_keys);
 
 	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
-- 
2.54.0


