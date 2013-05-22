Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uf4ry-0002ow-H8
 for kexec@lists.infradead.org; Wed, 22 May 2013 08:58:04 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 4/4] kexec-tools: Add cgroup_disable=memory to crash kernel
 parameters
Date: Wed, 22 May 2013 10:57:36 +0200
Message-Id: <1369213056-77661-5-git-send-email-trenn@suse.de>
In-Reply-To: <1369213056-77661-1-git-send-email-trenn@suse.de>
References: <1369213056-77661-1-git-send-email-trenn@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: kexec@lists.infradead.org, yinghai@kernel.org, ebiederm@xmission.com, vgoyal@redhat.com, Thomas Renninger <trenn@suse.de>

cgroup memory subsystem pre-allocates quite some memory at boot up.
Example dmesg:
allocated 469762048 bytes of page_cgroup
please try 'cgroup_disable=memory' option if you don't want memory cgroups

Due to maxcpu=1 it is by far not that much than in a productive kernel.
It still seem to be around 4M statically as no Numa overhead exists with
only one active CPU. It is still worth to disable cgroup memory
pre-allocating in crash kernel environment.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Thomas Renninger <Thomas Renninger" trenn@suse.de>
---
 kexec/arch/i386/crashdump-x86.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 7fd1c5b..e6d60a9 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -757,6 +757,23 @@ static int cmdline_add_elfcorehdr(char *cmdline, unsigned long addr)
 	return 0;
 }
 
+static void cmdline_disable_cgroup(char *cmdline)
+{
+	int cmdlen;
+	char str[30] = " cgroup_disable=memory";
+
+	cmdlen = strlen(cmdline) + strlen(str);
+	if (cmdlen > (COMMAND_LINE_SIZE - 1)) {
+		/* Not fatal if cgroup memory is not disabled */
+		dbgprintf(
+		  "Command line overflow, cgroup memory not disabled\n");
+		return;
+	}
+	strcat(cmdline, str);
+
+	dbgprintf("Command line after adding adding cgroup_disable=memory\n");
+	dbgprintf("%s\n", cmdline);
+}
 
 /*
  * This routine is specific to i386 architecture to maintain the
@@ -1037,6 +1054,11 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 		end = mem_range[i].end;
 		cmdline_add_memmap_acpi(mod_cmdline, start, end);
 	}
+	/* 
+	 * Always add disabling cgroup_diable=memory param at the end,
+	 * it's not critical if it falls off
+	 */
+	cmdline_disable_cgroup(mod_cmdline);
 	return 0;
 }
 
-- 
1.7.6.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
