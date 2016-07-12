Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bMmdm-0004gW-W6
 for kexec@lists.infradead.org; Tue, 12 Jul 2016 01:37:39 +0000
Received: by mail-pf0-x235.google.com with SMTP id h14so803038pfe.1
 for <kexec@lists.infradead.org>; Mon, 11 Jul 2016 18:37:18 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 1/3] syscall: add kexec_file_load to generic unistd.h
Date: Tue, 12 Jul 2016 10:41:59 +0900
Message-Id: <20160712014201.11456-2-takahiro.akashi@linaro.org>
In-Reply-To: <20160712014201.11456-1-takahiro.akashi@linaro.org>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
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
To: ebiederm@xmission.com, vgoyal@redhat.com, dyoung@redhat.com, bhe@redhat.com, bauerman@linux.vnet.ibm.com, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>

Currently kexec_file_load is supported only on x86, but it will be
supported on powerpc and arm64 in near future. Since both archs
use asm-generic/unistd.h, this patch adds the entry to this file.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 include/uapi/asm-generic/unistd.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a26415b..9ead10f 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -724,9 +724,15 @@ __SYSCALL(__NR_copy_file_range, sys_copy_file_range)
 __SC_COMP(__NR_preadv2, sys_preadv2, compat_sys_preadv2)
 #define __NR_pwritev2 287
 __SC_COMP(__NR_pwritev2, sys_pwritev2, compat_sys_pwritev2)
+#define __NR_kexec_file_load 288
+#ifdef CONFIG_KEXEC_FILE
+__SYSCALL(__NR_kexec_file_load, sys_kexec_file_load)
+#else
+__SYSCALL(__NR_kexec_file_load, sys_ni_syscall)
+#endif /* CONFIG_KEXEC_FILE */
 
 #undef __NR_syscalls
-#define __NR_syscalls 288
+#define __NR_syscalls 289
 
 /*
  * All syscalls below here should go away really,
-- 
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
