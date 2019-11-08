Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iT08q-0004nC-MO
 for kexec@lists.infradead.org; Fri, 08 Nov 2019 09:01:21 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 3/3 v9] kexec: Fix i386 build warnings that missed declaration
 of struct kimage
Date: Fri,  8 Nov 2019 17:00:27 +0800
Message-Id: <20191108090027.11082-4-lijiang@redhat.com>
In-Reply-To: <20191108090027.11082-1-lijiang@redhat.com>
References: <20191108090027.11082-1-lijiang@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: jgross@suse.com, Thomas.Lendacky@amd.com, bhe@redhat.com, horms@verge.net.au, x86@kernel.org, kexec@lists.infradead.org, dhowells@redhat.com, mingo@redhat.com, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, d.hatayama@fujitsu.com, vgoyal@redhat.com

Kbuild test robot reported some build warnings as follow:

arch/x86/include/asm/crash.h:5:32: warning: 'struct kimage' declared
inside parameter list will not be visible outside of this definition
or declaration
    int crash_load_segments(struct kimage *image);
                                   ^~~~~~
    int crash_copy_backup_region(struct kimage *image);
                                        ^~~~~~
    int crash_setup_memmap_entries(struct kimage *image,
                                          ^~~~~~
The 'struct kimage' is defined in the header file include/linux/kexec.h,
before using it, need to include its header file or make a declaration.
Otherwise the above warnings may be triggered.

Add a declaration of struct kimage to the file arch/x86/include/asm/
crash.h, that will solve these compile warnings.

Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system call")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Link: https://lkml.kernel.org/r/201910310233.EJRtTMWP%25lkp@intel.com
---
 arch/x86/include/asm/crash.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
index 3dff55f4ed9d..88eadd08ad70 100644
--- a/arch/x86/include/asm/crash.h
+++ b/arch/x86/include/asm/crash.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_CRASH_H
 #define _ASM_X86_CRASH_H
 
+struct kimage;
+
 int crash_load_segments(struct kimage *image);
 int crash_copy_backup_region(struct kimage *image);
 int crash_setup_memmap_entries(struct kimage *image,
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
