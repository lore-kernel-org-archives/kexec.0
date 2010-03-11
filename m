Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NpdeC-0006Jo-V6
	for kexec@lists.infradead.org; Thu, 11 Mar 2010 08:21:41 +0000
Subject: [PATCH 2/3] kexec: Figure out our native architecture before load
References: <m1k4tjb7d1.fsf@fess.ebiederm.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 11 Mar 2010 00:21:33 -0800
In-Reply-To: <m1k4tjb7d1.fsf@fess.ebiederm.org> (Eric W. Biederman's message
	of "Thu\, 11 Mar 2010 00\:16\:58 -0800")
Message-ID: <m1bpevb75e.fsf@fess.ebiederm.org>
MIME-Version: 1.0
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
To: Simon Horman <horms@verge.net.au>
Cc: Kexec Mailing List <kexec@lists.infradead.org>


This moves the computing of our native archtecture earlier so
that load can use it, as arch/i386/crashdump-x86.c has been
trying to.

Signed-off-by: Eric W. Biederman <ebiederm@aristanetworks.com>
---
 kexec/kexec.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 43d0189..16a0ec9 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -695,17 +695,19 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 			}
 		}
 	}
+	/* Figure out our native architecture before load */
+	native_arch = physical_arch();
+	if (native_arch < 0) {
+		return -1;
+	}
+	info.kexec_flags |= native_arch;
+
 	if (file_type[i].load(argc, argv, kernel_buf,
 			      kernel_size, &info) < 0) {
 		fprintf(stderr, "Cannot load %s\n", kernel);
 		return -1;
 	}
 	/* If we are not in native mode setup an appropriate trampoline */
-	native_arch = physical_arch();
-	if (native_arch < 0) {
-		return -1;
-	}
-	info.kexec_flags |= native_arch;
 	if (arch_compat_trampoline(&info) < 0) {
 		return -1;
 	}
-- 
1.6.6.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
