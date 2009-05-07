Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga06.intel.com ([134.134.136.21] helo=orsmga101.jf.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1M2C3p-0008RP-GS
	for kexec@lists.infradead.org; Thu, 07 May 2009 22:27:32 +0000
From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: [PATCH 05/14] kbuild: allow compressors (gzip, bzip2,
	lzma) to take multiple inputs
Date: Thu,  7 May 2009 15:26:53 -0700
Message-Id: <1241735222-6640-6-git-send-email-hpa@linux.intel.com>
In-Reply-To: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
References: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org, hbabu@us.ibm.com, ebiederm@xmission.com, ying.huang@intel.com, mingo@elte.hu, sam@ravnborg.org, tglx@linutronix.de, vgoyal@redhat.com

From: H. Peter Anvin <hpa@zytor.com>

Allow the compression commands in Kbuild (i.e. gzip, bzip2, lzma) to
take multiple input files and emit the concatenated compressed
output.  This avoids an intermediate step when a kernel image is built
from multiple components, such as the relocatable x86-32 kernel.

[ Impact: new build feature, not yet used ]

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/Makefile.lib |   11 ++++++++---
 scripts/bin_size     |    8 ++++++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 9796195..35dfdf6 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -183,7 +183,8 @@ cmd_objcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
 # ---------------------------------------------------------------------------
 
 quiet_cmd_gzip = GZIP    $@
-cmd_gzip = gzip -f -9 < $< > $@
+cmd_gzip = (cat $(filter-out FORCE,$^) | gzip -f -9 > $@) || \
+	(rm -f $@ ; false)
 
 
 # Bzip2
@@ -193,10 +194,14 @@ cmd_gzip = gzip -f -9 < $< > $@
 size_append=$(CONFIG_SHELL) $(srctree)/scripts/bin_size
 
 quiet_cmd_bzip2 = BZIP2    $@
-cmd_bzip2 = (bzip2 -9 < $< && $(size_append) $<) > $@ || (rm -f $@ ; false)
+cmd_bzip2 = (cat $(filter-out FORCE,$^) | \
+	bzip2 -9 && $(size_append) $(filter-out FORCE,$^)) > $@ || \
+	(rm -f $@ ; false)
 
 # Lzma
 # ---------------------------------------------------------------------------
 
 quiet_cmd_lzma = LZMA    $@
-cmd_lzma = (lzma -9 -c $< && $(size_append) $<) >$@ || (rm -f $@ ; false)
+cmd_lzma = (cat $(filter-out FORCE,$^) | \
+	lzma -9 && $(size_append) $(filter-out FORCE,$^)) > $@ || \
+	(rm -f $@ ; false)
diff --git a/scripts/bin_size b/scripts/bin_size
index 43e1b36..55f2161 100644
--- a/scripts/bin_size
+++ b/scripts/bin_size
@@ -1,10 +1,14 @@
 #!/bin/sh
 
 if [ $# = 0 ] ; then
-   echo Usage: $0 file
+   echo Usage: $0 file...
 fi
 
-size_dec=`stat -c "%s" $1`
+size_dec=0
+for file; do
+  fsize=`stat -c "%s" $file`
+  size_dec=`expr $size_dec + $fsize`
+done
 size_hex_echo_string=`printf "%08x" $size_dec |
      sed 's/\(..\)\(..\)\(..\)\(..\)/\\\\x\4\\\\x\3\\\\x\2\\\\x\1/g'`
 /bin/echo -ne $size_hex_echo_string
-- 
1.6.0.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
