Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f1AvV-0002Cx-Ud
 for kexec@lists.infradead.org; Wed, 28 Mar 2018 13:15:43 +0000
From: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH v6 2/5] kexec: Fix option checks to take KEXEC_FILE_LOAD into
 account
Date: Wed, 28 Mar 2018 15:15:15 +0200
Message-Id: <bf36a4623b5ef67b3ae9722972fc135c608df963.1522242915.git.msuchanek@suse.de>
In-Reply-To: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1522242915.git.msuchanek@suse.de>
References: <20180327095955.GB4681@dhcp-128-65.nay.redhat.com>
 <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1522242915.git.msuchanek@suse.de>
In-Reply-To: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1522242915.git.msuchanek@suse.de>
References: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1522242915.git.msuchanek@suse.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Tony Jones <tonyj@suse.com>, Dave Young <dyoung@redhat.com>, Michal Suchanek <msuchanek@suse.de>, Petr Tesarik <ptesarik@suse.cz>, horms@verge.net.au

When kexec_file_load support was added some sanity checks were not updated.

Some options are set only in the kexec_load flags so cannot be supported
wiht kexec_file_load. On the other hand, reserved memory is needed for
kdump with both kexec_load and kexec_file_load.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
Added in v5
---
 kexec/kexec.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index ab8cff7fe083..b793f31ea501 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1415,7 +1415,9 @@ int main(int argc, char *argv[])
 		do_load_jump_back_helper = 0;
 	}
 
-	if (do_load && (kexec_flags & KEXEC_ON_CRASH) &&
+	if (do_load &&
+	    ((kexec_flags & KEXEC_ON_CRASH) ||
+	     (kexec_file_flags & KEXEC_FILE_ON_CRASH)) &&
 	    !is_crashkernel_mem_reserved()) {
 		die("Memory for crashkernel is not reserved\n"
 		    "Please reserve memory by passing"
@@ -1447,6 +1449,12 @@ int main(int argc, char *argv[])
 			}
 		}
 	}
+	if (do_kexec_file_syscall) {
+		if (do_load_jump_back_helper)
+			die("--load-jump-back-helper not supported with kexec_file_load\n");
+		if (kexec_flags & KEXEC_PRESERVE_CONTEXT)
+			die("--load-preserve-context not supported with kexec_file_load\n");
+	}
 
 	if (do_reuse_initrd){
 		check_reuse_initrd();
-- 
2.13.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
