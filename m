Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49])
 by casper.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zbcb5-0005CE-Hh
 for kexec@lists.infradead.org; Mon, 14 Sep 2015 22:51:40 +0000
Received: by padhk3 with SMTP id hk3so155789921pad.3
 for <kexec@lists.infradead.org>; Mon, 14 Sep 2015 15:51:19 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 12/13] Remove AT_VECTOR_SIZE_ARCH on x86
Date: Mon, 14 Sep 2015 15:50:46 -0700
Message-Id: <1442271047-4908-13-git-send-email-palmer@dabbelt.com>
In-Reply-To: <1442271047-4908-1-git-send-email-palmer@dabbelt.com>
References: <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
 <1442271047-4908-1-git-send-email-palmer@dabbelt.com>
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
To: arnd@arndb.de, dhowells@redhat.com
Cc: dave@sr71.net, linux-xtensa@linux-xtensa.org, jcmvbkbc@gmail.com, hpa@zytor.com, mingo@kernel.org, ast@plumgrid.com, aarcange@redhat.com, bhe@redhat.com, x86@kernel.org, tomi.valkeinen@ti.com, 3chas3@gmail.com, paulmck@linux.vnet.ibm.com, plagnioj@jcrosoft.com, vgoyal@redhat.com, aishchuk@linux.vnet.ibm.com, linux-arch@vger.kernel.org, a.p.zijlstra@chello.nl, jikos@kernel.org, josh@joshtriplett.org, acme@kernel.org, mathieu.desnoyers@efficios.com, viro@zeniv.linux.org.uk, luto@kernel.org, tglx@linutronix.de, drysdale@google.com, chris@zankel.net, iulia.manda21@gmail.com, geoff@infradead.org, gregkh@linuxfoundation.org, dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, ebiederm@xmission.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, davem@davemloft.net

It looks like there aren't actually users of this macro anywhere:

 * The kernel doesn't use it on x86 because we don't suppor ELF FDPIC.

 * The only Google results point to LMKL patches, both the one that
   wrote this (from 2010) and my patch to hide it behind __KERNEL__.

 * I grep'd through all the source tarballs on my machine, and the
   only packages that matched were the kernel and crui (which copied a
   PPC kernel header).

Since I'm not sure how to actually provide the right answer (if I
understand correctly, CONFIG_IA32_EMULATION is not __i386__), the only
thing I can think of to do is to just remove the definition.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
---
 arch/x86/include/uapi/asm/auxvec.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/include/uapi/asm/auxvec.h b/arch/x86/include/uapi/asm/auxvec.h
index 77203ac352de..1316b4c35425 100644
--- a/arch/x86/include/uapi/asm/auxvec.h
+++ b/arch/x86/include/uapi/asm/auxvec.h
@@ -9,11 +9,4 @@
 #endif
 #define AT_SYSINFO_EHDR		33
 
-/* entries in ARCH_DLINFO: */
-#if defined(CONFIG_IA32_EMULATION) || !defined(CONFIG_X86_64)
-# define AT_VECTOR_SIZE_ARCH 2
-#else /* else it's non-compat x86-64 */
-# define AT_VECTOR_SIZE_ARCH 1
-#endif
-
 #endif /* _ASM_X86_AUXVEC_H */
-- 
2.4.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
