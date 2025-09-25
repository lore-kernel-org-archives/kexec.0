Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6D6CAC5A5
	for <kexec@archiver.kernel.org>; Thu, 25 Sep 2025 06:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H8KirMZXkDogL5Rt3LJjmjFOI+dBy22aB5FM1tZfR9w=; b=mAnJHp6eqrtG1lUhM8vFD5qfqz
	/537CWANr3XA/f3zUzb3ACC66TzFxdF/7ci5FYJ0F10N4i8DJ7NcruzHxHzwtEqdfw9OPvchqREXg
	TQ04pHkfzM3j2FcTddiQoW8YrBd9ipJ9FiJHROaMgggmqQYwkNg1h09p00TGqFSZJxfN6Q/nZ2oYF
	c9lKo5JiZKvg4nZ2uSq8nIC9a/sh/4r46LgLKochQn302Vb1mJfmEP+y/UpnQ4J1VAXh5Yd/KYcRL
	YUsMsbuZHO7EuG4VmS+a1SSdkfUslENCJyBCwDV+IrxsahPHE2gwAY0Z1iEvVX+pLt/09D8qQkJOr
	b/HZ1IUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1fXZ-00000006JN5-08Xg;
	Thu, 25 Sep 2025 06:33:17 +0000
Received: from out-187.mta1.migadu.com ([2001:41d0:203:375::bb])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1fXV-00000006JH8-3d0V
	for kexec@lists.infradead.org;
	Thu, 25 Sep 2025 06:33:16 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758781987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8KirMZXkDogL5Rt3LJjmjFOI+dBy22aB5FM1tZfR9w=;
	b=ROiiZNSANcvA3WEZ4iZ4c03D08yauaY0caiE99M8ds4q1MBX90MFdMbQaNrfDXOAEWyZ4r
	Vx72LBiPDy4HdV0wZQG8z72VJjTL3n6kNpj5ezIlJ2IhSclzc+IpCMZEmwTA2f4n6mlYy5
	uuFOJzUGeZDg5qPew7L5wNOEXgQ0r5g=
From: Youling Tang <youling.tang@linux.dev>
To: Simon Horman <horms@kernel.org>
Cc: Simon Horman <horms@verge.net.au>,
	kexec@lists.infradead.org,
	Huacai Chen <chenhuacai@kernel.org>,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 2/2] LoongArch: Refactor command line processing
Date: Thu, 25 Sep 2025 14:32:41 +0800
Message-ID: <20250925063241.337897-2-youling.tang@linux.dev>
In-Reply-To: <20250925063241.337897-1-youling.tang@linux.dev>
References: <20250925063241.337897-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_233314_169648_9350E6E3 
X-CRM114-Status: GOOD (  14.45  )
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

From: Youling Tang <tangyouling@kylinos.cn>

Refactor the cmdline_add_xxx code flow, and simultaneously display
the content of parameters such as initrd in hexadecimal format to
improve readability.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 kexec/arch/loongarch/kexec-loongarch.c | 138 ++++++++++---------------
 1 file changed, 55 insertions(+), 83 deletions(-)

diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
index 240202f..c2503de 100644
--- a/kexec/arch/loongarch/kexec-loongarch.c
+++ b/kexec/arch/loongarch/kexec-loongarch.c
@@ -35,83 +35,49 @@
 #define _O_BINARY 0
 #endif
 
-#define CMDLINE_PREFIX "kexec "
-static char cmdline[COMMAND_LINE_SIZE] = CMDLINE_PREFIX;
+/* Add the "kexec" command line parameter to command line. */
+static void cmdline_add_loader(unsigned long *cmdline_tmplen, char *modified_cmdline)
+{
+	int loader_strlen;
+
+	loader_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "kexec ");
+	*cmdline_tmplen += loader_strlen;
+}
 
-/* Adds "initrd=start,size" parameters to command line. */
-static int cmdline_add_initrd(char *cmdline, unsigned long addr,
-		unsigned long size)
+/* Add the "initrd=start,size" command line parameter to command line. */
+static void cmdline_add_initrd(unsigned long *cmdline_tmplen, char *modified_cmdline,
+			       unsigned long initrd_base, unsigned long initrd_size)
 {
-	int cmdlen, len;
-	char str[50], *ptr;
-
-	ptr = str;
-	strcpy(str, " initrd=");
-	ptr += strlen(str);
-	ultoa(addr, ptr);
-	strcat(str, ",");
-	ptr = str + strlen(str);
-	ultoa(size, ptr);
-	len = strlen(str);
-	cmdlen = strlen(cmdline) + len;
-	if (cmdlen > (COMMAND_LINE_SIZE - 1))
-		die("Command line overflow\n");
-	strcat(cmdline, str);
+	int initrd_strlen;
 
-	return 0;
+	initrd_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "initrd=0x%lx,0x%lx ",
+				initrd_base, initrd_size);
+	*cmdline_tmplen += initrd_strlen;
 }
 
-/* Adds the appropriate "mem=size@start" options to command line, indicating the
- * memory region the new kernel can use to boot into. */
-static int cmdline_add_mem(char *cmdline, unsigned long addr,
-		unsigned long size)
+/*
+ * Add the "mem=size@start" command line parameter to command line, indicating the
+ * memory region the new kernel can use to boot into.
+ */
+static void cmdline_add_mem(unsigned long *cmdline_tmplen, char *modified_cmdline,
+			    unsigned long mem_start, unsigned long mem_sz)
 {
-	int cmdlen, len;
-	char str[50], *ptr;
-
-	addr = addr/1024;
-	size = size/1024;
-	ptr = str;
-	strcpy(str, " mem=");
-	ptr += strlen(str);
-	ultoa(size, ptr);
-	strcat(str, "K@");
-	ptr = str + strlen(str);
-	ultoa(addr, ptr);
-	strcat(str, "K");
-	len = strlen(str);
-	cmdlen = strlen(cmdline) + len;
-	if (cmdlen > (COMMAND_LINE_SIZE - 1))
-		die("Command line overflow\n");
-	strcat(cmdline, str);
+	int mem_strlen = 0;
 
-	return 0;
+	mem_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "mem=0x%lx@0x%lx ",
+			     mem_sz, mem_start);
+	*cmdline_tmplen += mem_strlen;
 }
 
-/* Adds the "elfcorehdr=size@start" command line parameter to command line. */
-static int cmdline_add_elfcorehdr(char *cmdline, unsigned long addr,
-			unsigned long size)
+/* Add the "elfcorehdr=size@start" command line parameter to command line. */
+static void cmdline_add_elfcorehdr(unsigned long *cmdline_tmplen, char *modified_cmdline,
+				   unsigned long elfcorehdr_start, unsigned long elfcorehdr_sz)
 {
-	int cmdlen, len;
-	char str[50], *ptr;
-
-	addr = addr/1024;
-	size = size/1024;
-	ptr = str;
-	strcpy(str, " elfcorehdr=");
-	ptr += strlen(str);
-	ultoa(size, ptr);
-	strcat(str, "K@");
-	ptr = str + strlen(str);
-	ultoa(addr, ptr);
-	strcat(str, "K");
-	len = strlen(str);
-	cmdlen = strlen(cmdline) + len;
-	if (cmdlen > (COMMAND_LINE_SIZE - 1))
-		die("Command line overflow\n");
-	strcat(cmdline, str);
+	int elfcorehdr_strlen = 0;
 
-	return 0;
+	elfcorehdr_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "elfcorehdr=0x%lx@0x%lx ",
+				    elfcorehdr_sz, elfcorehdr_start);
+	*cmdline_tmplen += elfcorehdr_strlen;
 }
 
 /* Return a sorted list of memory ranges. */
@@ -329,18 +295,17 @@ int loongarch_load_other_segments(struct kexec_info *info, unsigned long hole_mi
 	unsigned long initrd_min, hole_max;
 	char *initrd_buf = NULL;
 	unsigned long pagesize = getpagesize();
+	unsigned long cmdline_tmplen = 0;
+	char *cmdline = NULL;
 	int i;
 
-	if (arch_options.command_line) {
-		if (strlen(arch_options.command_line) >
-		    sizeof(cmdline) - 1) {
-			fprintf(stderr,
-				"Kernel command line too long for kernel!\n");
-			return EFAILED;
-		}
+	cmdline = calloc(1, COMMAND_LINE_SIZE);
+	if (!cmdline)
+		return EFAILED;
 
-		strncat(cmdline, arch_options.command_line, sizeof(cmdline) - 1);
-	}
+	/* Ensure it's null terminated */
+	cmdline_add_loader(&cmdline_tmplen, cmdline);
+	cmdline[COMMAND_LINE_SIZE - 1] = '\0';
 
 	/* Put the other segments after the image. */
 
@@ -360,21 +325,29 @@ int loongarch_load_other_segments(struct kexec_info *info, unsigned long hole_mi
 						pagesize), hole_max, -1);
 		dbgprintf("initrd_base: %lx, initrd_size: %lx\n", initrd_base, initrd_size);
 
-		cmdline_add_initrd(cmdline, initrd_base, initrd_size);
+		cmdline_add_initrd(&cmdline_tmplen, cmdline, initrd_base, initrd_size);
 	}
 
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
-		cmdline_add_elfcorehdr(cmdline, elfcorehdr_mem.start,
-				elfcorehdr_mem.end - elfcorehdr_mem.start + 1);
+		cmdline_add_elfcorehdr(&cmdline_tmplen, cmdline, elfcorehdr_mem.start,
+				       elfcorehdr_mem.end - elfcorehdr_mem.start + 1);
 
 		for(i = 0;i < usablemem_rgns.size; i++) {
-			cmdline_add_mem(cmdline, crash_reserved_mem[i].start,
-			crash_reserved_mem[i].end -
-			crash_reserved_mem[i].start + 1);
+			cmdline_add_mem(&cmdline_tmplen, cmdline, crash_reserved_mem[i].start,
+					crash_reserved_mem[i].end - crash_reserved_mem[i].start + 1);
+		}
+	}
+
+	if (arch_options.command_line) {
+		if (strlen(arch_options.command_line) + cmdline_tmplen > COMMAND_LINE_SIZE) {
+			fprintf(stderr, "Kernel command line too long for kernel!\n");
+			free(cmdline);
+			return EFAILED;
 		}
+		memcpy(cmdline + cmdline_tmplen, arch_options.command_line,
+		       strlen(arch_options.command_line));
 	}
 
-	cmdline[sizeof(cmdline) - 1] = '\0';
 	add_buffer(info, cmdline, sizeof(cmdline), sizeof(cmdline),
 		sizeof(void *), _ALIGN_UP(hole_min, getpagesize()),
 		hole_max, 1);
@@ -382,7 +355,6 @@ int loongarch_load_other_segments(struct kexec_info *info, unsigned long hole_mi
 	dbgprintf("%s:%d: command_line: %s\n", __func__, __LINE__, cmdline);
 
 	return 0;
-
 }
 
 int arch_compat_trampoline(struct kexec_info *UNUSED(info))
-- 
2.48.1


