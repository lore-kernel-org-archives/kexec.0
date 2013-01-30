Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0aBF-0001kF-3J
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 16:06:33 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/3] x86 e820: Check for exactmap appearance when parsing
 first memmap option
Date: Wed, 30 Jan 2013 17:06:24 +0100
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <bfc13f3d-3ee2-4b7c-8d25-04718536a05a@email.android.com>
 <201301301703.42601.trenn@suse.de>
In-Reply-To: <201301301703.42601.trenn@suse.de>
MIME-Version: 1.0
Message-Id: <201301301706.25004.trenn@suse.de>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: yinghai@kernel.org, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, x86@kernel.org, vgoyal@redhat.com

From: Yinghai Lu <yinghai@kernel.org>

memmap=exactmap will throw away all original, but also until then
user defined (through other provided memmap= parameters) areas.
That means all memmap= boot parameters passed before a memmap=exactmap
parameter are not recognized.
Without this fix:
memmap=x@y memmap=exactmap memmap=i#k
only i#k would get recognized.

This is wrong, this fix will only throw away all original e820 areas once
when memmap=exactmap is found in the whole boot command line and before
any other memmap= option is parsed.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Reviewed-by: Thomas Renninger <trenn@suse.de>
---
 arch/x86/kernel/e820.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux-2.6/arch/x86/kernel/e820.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/e820.c
+++ linux-2.6/arch/x86/kernel/e820.c
@@ -835,6 +835,8 @@ static int __init parse_memopt(char *p)
 }
 early_param("mem", parse_memopt);
 
+static bool __initdata exactmap_parsed;
+
 static int __init parse_memmap_one(char *p)
 {
 	char *oldp;
@@ -844,6 +846,10 @@ static int __init parse_memmap_one(char
 		return -EINVAL;
 
 	if (!strncmp(p, "exactmap", 8)) {
+		if (exactmap_parsed)
+			return 0;
+
+		exactmap_parsed = true;
 #ifdef CONFIG_CRASH_DUMP
 		/*
 		 * If we are doing a crash dump, we still need to know
@@ -879,6 +885,12 @@ static int __init parse_memmap_one(char
 }
 static int __init parse_memmap_opt(char *str)
 {
+	char *p = boot_command_line;
+
+	p = strstr(p, "exactmap");
+	if (p)
+		parse_memmap_one("exactmap");
+
 	while (str) {
 		char *k = strchr(str, ',');
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
