Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC3BC25B74
	for <kexec@archiver.kernel.org>; Thu, 16 May 2024 04:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DG8h9s/E/zONxL29WvMTlqevTb61UgJi1rFNyMICHJI=; b=fngsBsdSqKPZW9
	u3Bh6ZBgGFqUzxVE+ua+zzncsjEASUUapZAPuXZDzjqmiRn3YpsGrSTdHQjRDAB44jEIsxMgzNYyO
	uCmiLOuTf95hOkXH9nhaHON3TRS5z0kOAz+dgocd7a9v87ug+XCWx4Q+08XYiUJ2msFKPtdqIMhqi
	lnez+sznRwwLiRDVn0/ps6S6gY5pvAoXnWnSqRwDLHX7HNe+X38MhBLlrHnphOYDbp/yUPu6llyCL
	8SsM61twGh9sVfZfVExr5CtO79jQzknb6j+wcfDMrlzGLmZyQUji3+pf+vgSeMbv7mJW1kOB9Mis3
	hwRJtOZ46bVvoL1A0edA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7Spn-00000003gaO-2Nx7;
	Thu, 16 May 2024 04:35:15 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7Spj-00000003gY1-2Gaw
	for kexec@lists.infradead.org;
	Thu, 16 May 2024 04:35:13 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso60774975ad.0
        for <kexec@lists.infradead.org>; Wed, 15 May 2024 21:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715834110; x=1716438910; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TSyX4IKmv0M/F0cEsT0z8dvxs0NrUNIdZAWKWF2wA+s=;
        b=X+MDlxo94iQYg9SoKGR0v4teFtLZpeElFVfTpCdpeOEgiHp4g4eytNY1iQsp0XBBu2
         h53N0jspx1NPG/RK4SO72Io6g6BPZEJlwvz8E7bcEjRmU9fmbG0oiOQq16Qv7MGduepQ
         OOVMfwpK4CT6EOETiXQs4xCTbtMJNWzqqwtGrPYqpmRk6GvQ1yKcYP+nfJUpBnGmHbOQ
         6VUHEqiM3/9XURrwhIowQG4Sehxl1zysXz5aNBDi0xIrCD/QTjJ+a6tF7C4be7zdmiHy
         mkYq0snx9KKho/+yCDvjffeKrj9b34wRCpuvCcN0HFJf6DI72J7vVHaD7AkLINtgIdNP
         7ZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715834110; x=1716438910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSyX4IKmv0M/F0cEsT0z8dvxs0NrUNIdZAWKWF2wA+s=;
        b=a/fz9r0RA/SQAFuia4h0swbkpWBJqUq+OrYXmj0FGX5gGBYQK7ND6yWVoLIfS+ptBN
         vCypKboOIRh0IRzIt4F8JfDgKApnacJYIbqdNm/zxK5yzZaj2App4AG/8Jn469P0IZsQ
         Pl2Wihg1hjkn+5pbo0IImMTAA4WOh7i3CSRhNdhIHvlKdLLnLnN5hsVFVGSoga3JYAuw
         1sHU/oEEx4EQ5LDuiq2SfdI0ZFeSqQeB9exLv/qiV3uzPIy4IUt+olx7lnXdpqmZhJpw
         mbPgxdA70BAeSv/w6ESPyHcGXvaUT+w0jsLHyRJ6Wg+e1lbL6817o7RVJCn2xBNLq3KF
         V6mQ==
X-Gm-Message-State: AOJu0YyMp3szirj0+pEtRSdO4WMV3QFXRPNzG1zPuxZLRXe76/aReu5Q
	WsyYlvIJYrD1Om6WqcNszSBfWh87N/uuLsOpFUrSqigxzzLSsyM6BRR0Y9zz/4Y=
X-Google-Smtp-Source: AGHT+IG9hv8kg9ix6c/ozgd784mF2OcYGRK2+kdYWi5VKCTvduAkD2ReS1frM6hOiz9f6kCXbT/IHQ==
X-Received: by 2002:a17:903:40c8:b0:1eb:3d24:3f7a with SMTP id d9443c01a7336-1ef43d181dcmr231888275ad.26.1715834109691;
        Wed, 15 May 2024 21:35:09 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9d80:4380::6fff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf316f7sm127615225ad.164.2024.05.15.21.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 21:35:09 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: kexec@lists.infradead.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] x86-linux-setup.c: Use POSIX basename API
Date: Wed, 15 May 2024 21:35:05 -0700
Message-ID: <20240516043505.4048330-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240515_213511_628807_04997BF3 
X-CRM114-Status: GOOD (  11.39  )
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

Musl C library only supports POSIX basename function. while glibc has
both GNU extention as well as POSIX basename implemented. Switch to
using posix version, so it can work across musl and glibc

basename prototype has been removed from string.h from latest musl [1]
compilers e.g. clang-18/GCC-14 flags the absense of prototype as error.
therefore include libgen.h for providing it.

[1] https://git.musl-libc.org/cgit/musl/commit/?id=725e17ed6dff4d0cd22487bb64470881e86a92e7

Upstream-Status: Pending
Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 kexec/arch/i386/x86-linux-setup.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index 9a281dc..73251b9 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -14,6 +14,7 @@
  *
  */
 #define _GNU_SOURCE
+#include <libgen.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <string.h>
@@ -329,12 +330,14 @@ static int add_edd_entry(struct x86_linux_param_header *real_mode,
 	memset(edd_info, 0, sizeof(struct edd_info));
 
 	/* extract the device number */
-	if (sscanf(basename(sysfs_name), "int13_dev%hhx", &devnum) != 1) {
+	char* sysfs_name_copy = strdup(sysfs_name);
+	if (sscanf(basename(sysfs_name_copy), "int13_dev%hhx", &devnum) != 1) {
 		fprintf(stderr, "Invalid format of int13_dev dir "
-				"entry: %s\n", basename(sysfs_name));
+				"entry: %s\n", basename(sysfs_name_copy));
+		free(sysfs_name_copy);
 		return -1;
 	}
-
+	free(sysfs_name_copy);
 	/* if there's a MBR signature, then add it */
 	if (file_scanf(sysfs_name, "mbr_signature", "0x%x", &mbr_sig) == 1) {
 		real_mode->edd_mbr_sig_buffer[*current_mbr] = mbr_sig;
-- 
2.45.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
