Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x849.google.com ([2607:f8b0:4864:20::849])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8XnJ-0004ci-97
 for kexec@lists.infradead.org; Mon, 25 Mar 2019 22:10:15 +0000
Received: by mail-qt1-x849.google.com with SMTP id b3so11682743qtr.21
 for <kexec@lists.infradead.org>; Mon, 25 Mar 2019 15:10:09 -0700 (PDT)
Date: Mon, 25 Mar 2019 15:09:31 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
Subject: [PATCH 04/27] kexec_load: Disable at runtime if the kernel is locked
 down
From: Matthew Garrett <matthewgarrett@google.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: jmorris@namei.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Garrett <matthewgarrett@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, Dave Young <dyoung@redhat.com>

From: Matthew Garrett <mjg59@srcf.ucam.org>

The kexec_load() syscall permits the loading and execution of arbitrary
code in ring 0, which is something that lock-down is meant to prevent. It
makes sense to disable kexec_load() in this situation.

This does not affect kexec_file_load() syscall which can check for a
signature on the image to be booted.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Dave Young <dyoung@redhat.com>
cc: kexec@lists.infradead.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 kernel/kexec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 68559808fdfa..8ea0ce31271f 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -207,6 +207,13 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	if (result < 0)
 		return result;
 
+	/*
+	 * kexec can be used to circumvent module loading restrictions, so
+	 * prevent loading in that case
+	 */
+	if (kernel_is_locked_down("kexec of unsigned images"))
+		return -EPERM;
+
 	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.
-- 
2.21.0.392.gf8f6787159e-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
