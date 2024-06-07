Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEE3C27C53
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 12:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LzJnHXg2duOgftNctzXIE+ukvApyopLbjkXUrW5TjhQ=; b=N4+RQB+e05j5Re
	AOtThUOHL3UV9x3yApSNsxk343PtHu5qdguArRdE4o19N+SR1kP5nnTkvfo0Y0ub7xJ/AjM1qfBHP
	vD0aqavo79LQwsWr7n0poBBdcvvr2jp8T/aTDGPZc5Vkl8rlMYB/gJRxqJ/w5BRtN7JbbF5bgMUpw
	lQDsJcq2nLaCE2y4Wu6BAbgNRyeXt0ZiFMJPaJeBMpZP0Y2ZCYNHTa8IlxL1TxeICa9yDqnq9BoOA
	KmxFfO74AP8c3XzEtJ7VSiUZkReiVcSoBcFu58cLz9yFOIjXwMluXnpY81uyfk6oNOAMGKQ9F0sXL
	oyeIX8lK//Mwe87pivSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYgO-0000000DudO-00WB;
	Fri, 07 Jun 2024 12:27:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYgL-0000000Duao-0A3T
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 12:26:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGp8yBhj1+knJlcnzRysXoXCImiASNI+KRbes2MGqNg=;
	b=fj3E2k4nrK+ubScsdvzzGgttgTpV5H1D1AqLr663xd0WJCDu5tZjIl+5WGAo3F/7JmJjgv
	L++AOg1sX0v21COhGEbi6ONmzs+ePcLx4XB313QtAm5JEJJc3MrjJbnj++Z1IUvNO/0dGi
	SBJSQh7y2AcRDs8WCSb5TN7k2868/A4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-o5mYoKyvOAaayOSIBuTXPA-1; Fri, 07 Jun 2024 08:26:51 -0400
X-MC-Unique: o5mYoKyvOAaayOSIBuTXPA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1f6768af0b3so22228385ad.0
        for <kexec@lists.infradead.org>; Fri, 07 Jun 2024 05:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763210; x=1718368010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGp8yBhj1+knJlcnzRysXoXCImiASNI+KRbes2MGqNg=;
        b=fcNvy7TAioQafMStSg+jnFQwkcVVpuWvuJx+YwiiUaslE7N0/6niTkoGo1m9BdNdA7
         dO8h6wWSk6LWarrdxXXublOjxEkGfMPoapxcNZRCbYr23RMzRbhQNXZvhaRojN2Vb1Bb
         vcv1gbrO+9lx+870afIreVQ/AA0UC3j+TnVDEM7TW6iUm63JcG1mCK/RAK3iokAo0K2s
         Zze0nNzTbAT1fPSHZ6+quGmXgNyFapWEIGTgu0aj593K4QTNHN5FfS3ro1mCLMZFUNtX
         OjrbOd9Y0aTYp08l42ui7OGYkHIJYhmsbaJ52Y4XD8UVyFJQXpMQpuPyBsMZew1n+g5H
         aooQ==
X-Gm-Message-State: AOJu0YxbeR4/OpYpMp/Jf47YxpFnjYx68aQz6yUt+7SUycQQrkzEdWXt
	2BLqvCh5XXfdzExXh3Lxaj45BBu7b0Pv06RooYMvgfOdEWYD3wL2lvWsAgD3o2xycaFh9pOz5zy
	Ghh+CXna1OopN3ujmWSwpTOQB+DaXqQ10TkhDBeLTy6peWbbD4nEZoNSsbzQF/T5HTLD/ftJFdv
	FPm1JniCL2sBHb8lK2i6pxpia7vrfMXWS1dMJHLTk0Ip+V
X-Received: by 2002:a17:903:950:b0:1f6:e338:348f with SMTP id d9443c01a7336-1f6e3383556mr8776895ad.3.1717763210027;
        Fri, 07 Jun 2024 05:26:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXnqypVfmxKF1aFiPxUul2uqRYNx6AqzNM8EiDs+ZbbmDh4kF2hq/Ga42bgvJ6dM0meVp4Qg==
X-Received: by 2002:a17:903:950:b0:1f6:e338:348f with SMTP id d9443c01a7336-1f6e3383556mr8776405ad.3.1717763209330;
        Fri, 07 Jun 2024 05:26:49 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7ccdc3sm33218575ad.131.2024.06.07.05.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:26:48 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v5 4/7] crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging
Date: Fri,  7 Jun 2024 20:26:14 +0800
Message-ID: <20240607122622.167228-5-coxu@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607122622.167228-1-coxu@redhat.com>
References: <20240607122622.167228-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_052657_201306_A6B1A8FA 
X-CRM114-Status: GOOD (  17.42  )
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

When there are CPU and memory hot un/plugs, the crash elfcorehdr which
describes CPUs and memory in the system needs to be updated for the
kdump kernel.

Currently, there are two solutions to support this case. One is to
utilizes udev to instruct user space to reload the kdump kernel image
and initrd, elfcorehdr and etc. again. The other is to only update the
elfcorehdr segment. For the 1st solution, the dm crypt keys need to be
reloaded again. The user space can write the "reuse" command to
/sys/kernel/crash_dm_crypt_key so the stored keys can be re-saved again.

Note only x86 (commit ea53ad9cf73b ("x86/crash: add x86 crash
hotplug support")) and ppc (WIP) supports the new infrastructure
(commit 247262756121 ("crash: add generic infrastructure for crash
hotplug support")). If the new infrastructure get extended to all arches,
this patch can be dropped.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 Documentation/ABI/testing/crash_dm_crypt_keys |  2 ++
 kernel/crash_dump_dm_crypt.c                  | 32 ++++++++++++++++---
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/crash_dm_crypt_keys b/Documentation/ABI/testing/crash_dm_crypt_keys
index e6a6f6be5a9e..7426c9d8de97 100644
--- a/Documentation/ABI/testing/crash_dm_crypt_keys
+++ b/Documentation/ABI/testing/crash_dm_crypt_keys
@@ -15,6 +15,8 @@ Description:	read/write
         Record a key description. For security reason, the key must be a logon
         key whose payload can't be read by user space. For details, please refer
         to security/keys/core.rst.
+      - "reuse"
+        Reuse the dm crypt keys stored in kdump reserved memory.
 
     And you can also read this API to know the command eructation status,
       - fresh
diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 0033152668ae..9a6bd39adf76 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -15,13 +15,15 @@ static enum STATE_ENUM {
 	INITIALIZED,
 	RECORDED,
 	LOADED,
+	REUSE,
 } state;
 
 static const char * const STATE_STR[] = {
 	[FRESH] = "fresh",
 	[INITIALIZED] = "initialized",
 	[RECORDED] = "recorded",
-	[LOADED] = "loaded"
+	[LOADED] = "loaded",
+	[REUSE] = "reuse"
 };
 
 static unsigned int key_count;
@@ -107,12 +109,32 @@ static int record_key_desc(const char *buf, struct dm_crypt_key *dm_key)
 	return 0;
 }
 
+static void get_keys_from_kdump_reserved_memory(void)
+{
+	struct keys_header *keys_header_loaded;
+
+	arch_kexec_unprotect_crashkres();
+
+	keys_header_loaded = kmap_local_page(pfn_to_page(
+		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
+
+	memcpy(keys_header, keys_header_loaded, keys_header_size);
+	kunmap_local(keys_header_loaded);
+	state = RECORDED;
+	arch_kexec_protect_crashkres();
+}
+
 static int process_cmd(const char *buf, size_t count)
 {
 	if (strncmp(buf, "init ", 5) == 0)
 		return init(buf);
 	else if (strncmp(buf, "record ", 7) == 0 && count == KEY_DESC_LEN + 6)
 		return record_key_desc(buf, &keys_header->keys[key_count]);
+	else if (!strcmp(buf, "reuse")) {
+		state = REUSE;
+		get_keys_from_kdump_reserved_memory();
+		return 0;
+	}
 
 	return -EINVAL;
 }
@@ -192,9 +214,11 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	}
 
 	image->dm_crypt_keys_addr = 0;
-	r = build_keys_header();
-	if (r)
-		return r;
+	if (state != REUSE) {
+		r = build_keys_header();
+		if (r)
+			return r;
+	}
 
 	kbuf.buffer = keys_header;
 	kbuf.bufsz = keys_header_size;
-- 
2.45.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
