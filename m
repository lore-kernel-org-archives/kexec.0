Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-co1nam11on2138.outbound.protection.outlook.com
 ([40.107.220.138] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUtLQ-004d0M-VZ
 for kexec@lists.infradead.org; Fri, 09 Apr 2021 15:46:54 +0000
Date: Fri, 9 Apr 2021 11:46:42 -0400
From: Joe Korty <joe.korty@concurrent-rt.com>
Subject: [PATCH] kexec-tools: fix failure when kernel version patchlevel >255
Message-ID: <20210409154642.GA30739@zipoli.concurrrent-rt.com>
Content-Disposition: inline
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, Khalid Aziz <khalid@gonehiking.org>, Hariprasad Nellitheertha <hari@in.ibm.com>, Tim Deegan <tjd21@cl.cam.ac.uk>, Hongyan Xia <hongyxia@amazon.com>, David Hildenbrand <david@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>

[PATCH] kexec-tools: fix kexec failure when kernel version patchlevel >255

[ 2nd try, to a larger cc: list, and this time submitted
  with a patch rather than just a bug report   ]

Kexec blows up when the kernel version patchlevel is >255.
This was first noticed when a 4.4.262 kernel was booted
on a CentOS 7 system.  The message on the console is of
the form:

  Unsupported utsname.release: 4.4.262

The attached patch should fix this.  Untested.  There might
be a few places where a hardcoded constant rather than
KERNEL_VERSION is used, but I did not see any.

Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com

diff --git a/kexec/kernel_version.c b/kexec/kernel_version.c
index 21fb13adf095..36c06ffd603d 100644
--- a/kexec/kernel_version.c
+++ b/kexec/kernel_version.c
@@ -47,7 +47,7 @@ long kernel_version(void)
 		patch = 0;
 	}
 
-	if (major >= 256 || minor >= 256 || patch >= 256) {
+	if (major >= 256 || minor >= 256 || patch >= 65536) {
 		fprintf(stderr, "Unsupported utsname.release: %s\n",
 			utsname.release);
 		return -1;
diff --git a/kexec/kexec.h b/kexec/kexec.h
index f0f347d5e9e0..b388475ffa5a 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -180,7 +180,7 @@ extern const struct arch_map_entry arches[];
 long physical_arch(void);
 
 #define KERNEL_VERSION(major, minor, patch) \
-	(((major) << 16) | ((minor) << 8) | patch)
+	(((major) << 24) | ((minor) << 16) | patch)
 long kernel_version(void);
 
 void usage(void);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
