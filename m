Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eoouV-0002fz-FK
 for kexec@lists.infradead.org; Thu, 22 Feb 2018 11:20:19 +0000
Received: by mail-pl0-x241.google.com with SMTP id i6so2706715plt.7
 for <kexec@lists.infradead.org>; Thu, 22 Feb 2018 03:19:25 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v8 06/13] asm-generic: add kexec_file_load system call to
 unistd.h
Date: Thu, 22 Feb 2018 20:17:25 +0900
Message-Id: <20180222111732.23051-7-takahiro.akashi@linaro.org>
In-Reply-To: <20180222111732.23051-1-takahiro.akashi@linaro.org>
References: <20180222111732.23051-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, bauerman@linux.vnet.ibm.com, dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, akpm@linux-foundation.org, mpe@ellerman.id.au, dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org, julien.thierry@arm.com
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The initial user of this system call number is arm64.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/asm-generic/unistd.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 8b87de067bc7..33761525ed2f 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -732,9 +732,11 @@ __SYSCALL(__NR_pkey_alloc,    sys_pkey_alloc)
 __SYSCALL(__NR_pkey_free,     sys_pkey_free)
 #define __NR_statx 291
 __SYSCALL(__NR_statx,     sys_statx)
+#define __NR_kexec_file_load 292
+__SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
 
 #undef __NR_syscalls
-#define __NR_syscalls 292
+#define __NR_syscalls 293
 
 /*
  * All syscalls below here should go away really,
-- 
2.16.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
