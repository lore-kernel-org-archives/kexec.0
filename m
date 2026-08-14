Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B56C5CFC1
	for <kexec@archiver.kernel.org>; Fri, 14 Aug 2026 07:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sVy5eupMj6U8yhxVl4udhSYO6Z3nBvNgoXNhq373xRY=; b=p0bRu5aCxBIly5e3hsDUSaZG8C
	yRjM8HH2lZ6IB3Veb11fHH5rNJgcUFeiU0h/K4juJkMDWqt0sUxxeY6EDuxhj1e89xy69JR1Bf2IV
	DB6KBFeU0YdjcBcqv7z5BcstV3exx4cb4tGzPL3F6k9lqJt8rrSkjcQyUyTJUm5l5F8OaVGK9TouB
	bJfaRmKt0GcKkBvFybXc/U1wAqxmrzs+7yM/bfeJ/j+cWYQ0gZxKIfsrUbk1s05Sp/8eIyoBxlmCn
	y9Rt/vKijeKjSP7+s0OZEB4Uwuiqzof7Hlgt+IDJAxqQ1FFaWKrKPBIpyxGEw2lHto93C5WcgkqRy
	ZjXWcNKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wumjl-00000002DwT-079G;
	Fri, 14 Aug 2026 07:53:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wumjh-00000002Dvl-3D3d
	for kexec@lists.infradead.org;
	Fri, 14 Aug 2026 07:53:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786694031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sVy5eupMj6U8yhxVl4udhSYO6Z3nBvNgoXNhq373xRY=;
	b=AXH32+F7H0/JEIs/mVNXBN5VSkwrBrfUyjDkA9MNHVNUFzgvyMGurhjaRjtn/9uWtV9RGI
	V1vK0sP3a8R7GpPZX+QUHSDIFGkPM1ryb+QQ1hHDxT0xkWVJjzi9WftdqOfJEnKQFnyVcr
	djiBwdyGxtDumTdLPG86c8h8EU45dnM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-cjyrn2fhNMGgkHW9-Ezalg-1; Fri, 14 Aug 2026 03:53:44 -0400
X-MC-Unique: cjyrn2fhNMGgkHW9-Ezalg-1
X-Mimecast-MFC-AGG-ID: cjyrn2fhNMGgkHW9-Ezalg_1786694024
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso852230a91.3
        for <kexec@lists.infradead.org>; Fri, 14 Aug 2026 00:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786694023; x=1787298823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sVy5eupMj6U8yhxVl4udhSYO6Z3nBvNgoXNhq373xRY=;
        b=CZ497sPZhsvOm5vLPsBgNZoQUWUvSIOK/QBQ9maUEU9q9Cdb6iHrdvmTZzBN/Qd2K7
         RWjs9sVNA7jnjus3AyZLhpQHoO51QIUtXCi1yW9o0gg38M/7jSon6Q6aMejfM4v5Ypsf
         w+LekL5K1Fii7Cx0jmEe/2DbqOyFUAJObC/fK/zJH6npREzzv4YJE5vPhDsWrdJ4C0YT
         SzzJUKr9dTfF5m1OBnaY+kKoUGdqyrfQLYEvKqJxt63XlX/d42bdsSasBbfrp9t56wHu
         t2+lm8tgrjgj2GPVOWsSwB0SL7EtNEAESw+/DmekE3Q9Oqd+8yrsCSQXklvlh5ke87gy
         l1HQ==
X-Gm-Message-State: AOJu0Yzh0t9FYiflneE9GtDThy8WRh8LNFr8ObX2kLrvooJQ4OKCr0ib
	YAcfzSUqyA0+NQ8Kkfr5UMVuhKF8VTqMJxGyt4lx/3FjcE1fYOO4U13iJjHTr9UXL+z1WaQeUIM
	/3V9mGXJyihNHxtt8XFuCZlx7dhnCNykRDyp4zs69iqbFQRQHSY/aW4ArGxSSkhelpiabQ61Kg7
	YXMVit3TS8kaF9L0aJV4thP3hX2dqnUV9EIFLYYr3I9VgNgA==
X-Gm-Gg: AR+sD10VzDqSMRnlkWiDDYBFm5XRAQ+kHeSt9Xh75SSRQENvAoXRP0UPI8tdPqcCvE5
	jWN/et1zRHgLVFhIX3Txui5lNp2Nfifva9TY1X/70lrCCxd0lytA+nk/M9PgvIwwJGKHsvNPR03
	LEWQT8AH8KOw4Pmy0T3vURN86SIi6vXP6F0HSu1w/migkJFXikYJE/Z4nOhXlU+VMzTcAquHSR3
	s2loALvWkUPbKpQ/anK8OchTi00PLppMD00Mfle1ISkI19J4cDYXdzYnDzfNGgZP2tVek0bxDLu
	vJwt8w5S/WDNGHB1Yz/JS60p5EtEo+OH1AqhBomOPYAneMFNobVMOhF5zeuMMqcImNIUj8jDz5N
	iD3PGFuWs75HBpSLgTl2UUMhKV1RGPBW/
X-Received: by 2002:a17:90a:ec87:b0:38e:485c:ebd3 with SMTP id 98e67ed59e1d1-3933ba79ea4mr4218111a91.15.1786694023394;
        Fri, 14 Aug 2026 00:53:43 -0700 (PDT)
X-Received: by 2002:a17:90a:ec87:b0:38e:485c:ebd3 with SMTP id 98e67ed59e1d1-3933ba79ea4mr4218005a91.15.1786694022288;
        Fri, 14 Aug 2026 00:53:42 -0700 (PDT)
Received: from mpilaniy-mac.redhat.corp ([122.171.16.134])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933b626d4esm880975a91.2.2026.08.14.00.53.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Aug 2026 00:53:41 -0700 (PDT)
From: Mukesh Pilaniya <mpilaniy@redhat.com>
To: kexec@lists.infradead.org,
	Philipp Rudo <prudo@redhat.com>,
	Tao Liu <ltao@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Mukesh pilaniya <mpilaniy@redhat.com>
Subject: [PATCH] kexec: fix kexec_file_load fallback error handling
Date: Fri, 14 Aug 2026 13:23:29 +0530
Message-ID: <20260814075329.30203-1-mpilaniy@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 88--gyvj0NiIggjxkpBuMKb0AKvOBcyCVeP65-HgTCc_1786694024
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_005353_892619_EB2FC0D9 
X-CRM114-Status: GOOD (  20.86  )
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

With the default -a (--kexec-syscall-auto) option, kexec-tools first
tries kexec_file_load() and falls back to kexec_load() when the syscall
is not implemented (ENOSYS) or the kernel does not have a loader for the
image format (ENOEXEC/ENOTSUP).  With -s (--kexec-file-syscall),
kexec-tools uses only kexec_file_load() and does not fall back.
Falling back on EINVAL hides the real error, because EINVAL means
something went wrong during loading.

Remove EINVAL from the fallback path.  Print the actual errno for
ENOEXEC/ENOTSUP before falling back and track it so the final message
distinguishes a missing syscall from other failures.

Several kexec_file_load() image probe functions incorrectly return
-EINVAL rather than -ENOEXEC when encountering an unrecognized image
format. This kernel patch fixes the issue:
https://lore.kernel.org/all/20260813-mpilaniy-v1-1-777d4d0e30f7@redhat.com/

Signed-off-by: Mukesh Pilaniya <mpilaniy@redhat.com>
Reviewed-by: Tao Liu <ltao@redhat.com>
Reviewed-by: Philipp Rudo <prudo@redhat.com>

---
kernel patch:
https://lore.kernel.org/all/20260813-mpilaniy-v1-1-777d4d0e30f7@redhat.com/
---
 kexec/kexec.c | 63 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 4a49ad4..0726996 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -68,6 +68,8 @@ int do_hotplug = 0;
 static unsigned long kexec_flags = 0;
 /* Flags for kexec file (fd) based syscall */
 static unsigned long kexec_file_flags = 0;
+/* errno from kexec_file_load when it returned EFALLBACK */
+static int kexec_file_load_errno;
 /* initrd detected in probe phase */
 int implicit_initrd_fd = -1;
 int kexec_debug = 0;
@@ -869,12 +871,16 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 				    info.nr_segments, info.segment,
 				    info.kexec_flags);
 	if (result != 0) {
-		/* The load failed, print some debugging information */
-		fprintf(stderr, "kexec_load failed: %s\n", 
-			strerror(errno));
-		fprintf(stderr, "entry       = %p flags = 0x%lx\n", 
-			info.entry, info.kexec_flags);
-		print_segments(stderr, &info);
+		if (errno == ENOSYS) {
+			fprintf(stderr,
+				"syscall kexec_load is not available on this system.\n");
+		} else {
+			fprintf(stderr, "kexec_load failed: %s\n",
+				strerror(errno));
+			fprintf(stderr, "entry       = %p flags = 0x%lx\n",
+				info.entry, info.kexec_flags);
+			print_segments(stderr, &info);
+		}
 	}
 	return result;
 }
@@ -883,12 +889,15 @@ static int kexec_file_unload(unsigned long kexec_file_flags)
 {
 	int ret = 0;
 
-	if (!is_kexec_file_load_implemented())
+	if (!is_kexec_file_load_implemented()) {
+		kexec_file_load_errno = ENOSYS;
 		return EFALLBACK;
+	}
 
 	ret = kexec_file_load(-1, -1, 0, NULL, kexec_file_flags);
 	if (ret != 0) {
 		if (errno == ENOSYS) {
+			kexec_file_load_errno = ENOSYS;
 			ret = EFALLBACK;
 		} else {
 			/*
@@ -919,9 +928,12 @@ static int k_unload (unsigned long kexec_flags)
 	else
 		result = kexec_load(NULL, 0, NULL, kexec_flags);
 	if (result != 0) {
-		/* The unload failed, print some debugging information */
-		fprintf(stderr, "kexec unload failed: %s\n",
-			strerror(errno));
+		if (errno == ENOSYS)
+			fprintf(stderr,
+				"syscall kexec_load is not available on this system.\n");
+		else
+			fprintf(stderr, "kexec unload failed: %s\n",
+				strerror(errno));
 	}
 	return result;
 }
@@ -1336,8 +1348,10 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 	info.kernel_fd = -1;
 	info.initrd_fd = -1;
 
-	if (!is_kexec_file_load_implemented())
+	if (!is_kexec_file_load_implemented()) {
+		kexec_file_load_errno = ENOSYS;
 		return EFALLBACK;
+	}
 
 	if (argc - fileind <= 0) {
 		fprintf(stderr, "No kernel specified\n");
@@ -1441,13 +1455,14 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 
 			/* Not implemented. */
 		case ENOSYS:
+			kexec_file_load_errno = ENOSYS;
+			ret = EFALLBACK;
+			break;
+
 			/*
-			 * Parsing image or other options failed
-			 * The image may be invalid or image
-			 * type may not supported by kernel so
-			 * retry parsing in kexec-tools.
+			 * The kernel does not have a loader for this
+			 * image format, retry parsing in kexec-tools.
 			 */
-		case EINVAL:
 		case ENOEXEC:
 			/*
 			 * ENOTSUP can be unsupported image
@@ -1455,6 +1470,9 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 			 * wrapper type, duh.
 			 */
 		case ENOTSUP:
+			kexec_file_load_errno = errno;
+			fprintf(stderr, "kexec_file_load failed: %s\n",
+				strerror(errno));
 			ret = EFALLBACK;
 			break;
 		}
@@ -1823,8 +1841,17 @@ int main(int argc, char *argv[])
 	if ((result == 0) && do_load_jump_back_helper) {
 		result = my_load_jump_back_helper(kexec_flags, entry);
 	}
-	if (result == EFALLBACK)
-		fputs("syscall kexec_file_load not available.\n", stderr);
+	/*
+	 * When fallback to kexec_load was attempted, my_load()
+	 * already reported the kexec_load error and overwrote
+	 * result with its own return value, so this condition
+	 * is only true when no fallback was attempted and
+	 * kexec_file_load does not exist.
+	 */
+	if (result == EFALLBACK && kexec_file_load_errno == ENOSYS) {
+		fputs("syscall kexec_file_load is not available on this system.\n",
+		      stderr);
+	}
 
 	fflush(stdout);
 	fflush(stderr);
-- 
2.50.1 (Apple Git-155)


