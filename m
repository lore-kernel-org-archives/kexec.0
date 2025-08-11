Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B1FCA0ED1
	for <kexec@archiver.kernel.org>; Mon, 11 Aug 2025 18:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=a7BVlmfeLs6ULRwadvx15tKMoMO9CIoW/Sg46vdX1wQ=; b=zAJ+OneAzL6pvYVnZrqYyRQvB2
	x787jTq4pMFcwi7hOJBxYcxwHYT2C6FVTDn7SlSuOYcE/QmxXkWPNveOQDMO9gGFnC2SGylydwBlL
	OzUjlLiiBq9k9ND2louU0VrPX6ceKaj4cyynDazGKXh7wbVpA3jgZqnTZVi9AGWk7iDImQusGPjhr
	vgdyz3UPDse0eQTt0afMpVa9cfj111VonysGh2nhgKkIFKpNSNLLtQQIM0FfWezFPH68469qzcaLg
	uBMZyzrgwqkqITK9Hf4uFr/6k4Ygjh2DISeucPgt1BeDvFrjVU3YUGx6M4kL6dHOqnJUTUzt3RnV9
	/eUf5wHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulXNT-00000008nou-2vKS;
	Mon, 11 Aug 2025 18:36:11 +0000
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulUaz-00000008Dyj-21d4
	for kexec@lists.infradead.org;
	Mon, 11 Aug 2025 15:37:58 +0000
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7e699d1179cso606566785a.2
        for <kexec@lists.infradead.org>; Mon, 11 Aug 2025 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754926676; x=1755531476; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a7BVlmfeLs6ULRwadvx15tKMoMO9CIoW/Sg46vdX1wQ=;
        b=Qzov5QsjntpsPKbxp9RiB+1MhPNQoONa6k3yS7+VT8I4Kzf5w4H3SHYob4e8mBDCxT
         O8WTcJPJ5rWxrLBVeh4oFeIcpWtYMK0f2cDtOhIKWHfrK8GHPMN17mOusAOKBGgEzi+z
         Js6GGHZTVpILEJVKSoAzhJYA/07pvh2LBVsO0ypNb+f6FBeSXy/DmnNzuIU8U1f+Z+k/
         rgxKKRg6hD4KIldyoCqkXg/TX7gR5rdoW8GtE/bImvXguBxNyROUaHymqI76U/GumnOq
         ml/nlsK8uxcOgsRW40JxP7JLdeRw2e4MZEUmh15wJKa/0lxss8lPQJ73NgtmOr6m6vcn
         bFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754926676; x=1755531476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7BVlmfeLs6ULRwadvx15tKMoMO9CIoW/Sg46vdX1wQ=;
        b=CnvexSPxcKFN9t8KFDdx/f9AMwXTL51JExGXP/A6B0wFIpcL9meE06PFxhYXjn9AjA
         ZNsaf+2rTmtghZkibNpp6pyABO2raCr2xdkXmvqEfahHcpbir4u0qRLOV0swq2fOcU0W
         3oU030Zn3vyjv4J1lwC+rdLDWTRJWSSH8G6kqzE5nV54Eaw8sInoKfJ3h5NOr+x2EXEf
         OL8RcdSkpd4zO+OV6K8L+11JWoIxHYuJ6lI87LQT0P393VH+zDRaaKekEuvM0Cd2MaWe
         KmEnxJoPW7x280iRB+T0i4m709uKNqnF952EgM+CzMwsYdWo5KaRepyTSly7IjrSkSxw
         4HSQ==
X-Gm-Message-State: AOJu0YzTSyuw8XyfXdlqnYdFooGYpYElifS9Y+gZb0BW52M4Dd8xjkzq
	UC84JXZ91ekZME0p7AY19J9Q4mHLIEq0DXWvtUSQ9zfJuCk8ZWGUYiMqR5Q05+KS
X-Gm-Gg: ASbGncvISeTpd76hlnxqIxPzaMZVaHwIqlI4KxE3KTy7S4egNMuED0y3JeRdEkM3K+g
	vAmqTsaWRNUu+slgQhbG1ZlkrmyGvOCnMHeZQRZMiQho0wdGqErhjXZMFpSrtactUr/eQMHPPKd
	BaLBtBH+4fmkTtq0LH9fI57RtashlGp22FWTCGwpvRwYqk9+o0Qp0ExZto1jwleoc7STuppPGSq
	AXikK9nmaE0QhrfLAa3U7DbE5SatCvZrBXc4T10G8DJm12w4v42VAm1YjLViBAl1UKNi6ympE0P
	cd/vyhl5+jHMPQAAlH+4HrFqG140ZxW+2tHtXDA3oMxHswZOlsnf1PsPoSE462gzTvwV8T/uJeS
	jaH664QJrqF4gy9WdjpgEtQSLsSlYxhY=
X-Google-Smtp-Source: AGHT+IGlXNxjc9NsUORI5uPug/HBzzyBRtKTarWlFgh1BxUDqVt8jTsl63xiGCkvHHDGP0I9vkndOQ==
X-Received: by 2002:a05:620a:6289:b0:7e8:2608:b8d4 with SMTP id af79cd13be357-7e8587fb726mr46427785a.4.1754926675765;
        Mon, 11 Aug 2025 08:37:55 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:74::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e818bd06c9sm803431785a.34.2025.08.11.08.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 08:37:55 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: kexec@lists.infradead.org,
	horms@verge.net.au
Cc: paulmck@kernel.org,
	leitao@debian.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [RFC] kexec: Add bootconfig support to get_command_line
Date: Mon, 11 Aug 2025 16:37:36 +0100
Message-ID: <20250811153736.3865487-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_083757_524880_D2A4698B 
X-CRM114-Status: GOOD (  22.36  )
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

If the kernel is enabled with CONFIG_BOOT_CONFIG_FORCE, it will
always append the bootconfig at the start of the kernel commandline.
If reuse-cmdline option is used in kexec, the bootconfig will be
repeatedly appended at the start of the commandline on every kexec.
As there is a limit on the size of kernel commandline that can be
used, --reuse-cmdline option will break kexec depending on the
size of bootconfig on repeated kexec.

Bootconfig is embedded in the kernel, so it should not be considered
when reusing kernel command line.
Modify get_command_line() to first attempt reading kernel parameters
from /proc/bootconfig before falling back to /proc/cmdline. This allows
kexec to use the original boot parameters without bootconfig which
is embedded in the kernel.

The function will fallback to /proc/cmdline behavior when:

- /proc/bootconfig doesn't exist
- /proc/bootconfig is empty
- /proc/bootconfig doesn't contain the expected marker format
- The extracted parameter line is empty

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 kexec/kexec.c | 50 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 6bf12d7..b31cb1f 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1235,15 +1235,53 @@ static char *slurp_proc_file(const char *filename, size_t *len)
  */
 char *get_command_line(void)
 {
-	char *p, *line;
+	char *p, *line = NULL;
 	size_t size;
+	char *bootconfig_line;
+	size_t bootconfig_size;
+
+	/* First try to get command line parameters from /proc/bootconfig */
+	bootconfig_line = slurp_proc_file("/proc/bootconfig", &bootconfig_size);
+	if (bootconfig_line && bootconfig_size > 0) {
+		/* Look for "# Parameters from bootloader:" */
+		char *params_marker = strstr(bootconfig_line, "# Parameters from bootloader:");
+		if (params_marker) {
+			/* Find the next line after the marker */
+			char *params_start = strchr(params_marker, '\n');
+			if (params_start) {
+				params_start++; /* Move past the newline */
+
+				/* Check if this line starts with "# " */
+				if (strncmp(params_start, "# ", 2) == 0) {
+					/* Skip the "# " prefix */
+					params_start += 2;
+
+					/* Find the end of the line */
+					char *params_end = strchr(params_start, '\n');
+					if (params_end) {
+						*params_end = '\0';
+					}
+
+					/* Check if the extracted line is not empty */
+					if (strlen(params_start) > 0) {
+						/* Allocate and copy the parameters */
+						line = xstrdup(params_start);
+					}
+				}
+			}
+		}
+		free(bootconfig_line);
+	}
 
-	line = slurp_proc_file("/proc/cmdline", &size);
-	if (!line || !size)
-		die("Failed to read /proc/cmdline\n");
+	/* Fall back to reading /proc/cmdline if we didn't get a line from bootconfig */
+	if (!line) {
+		line = slurp_proc_file("/proc/cmdline", &size);
+		if (!line || !size)
+			die("Failed to read /proc/cmdline\n");
 
-	/* strip newline */
-	line[size-1] = '\0';
+		/* strip newline */
+		line[size-1] = '\0';
+	}
 
 	p = strpbrk(line, "\r\n");
 	if (p)
-- 
2.47.3


