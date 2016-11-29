Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cBnZi-0004jR-5Z
 for kexec@lists.infradead.org; Tue, 29 Nov 2016 18:56:22 +0000
Received: by mail-qk0-f171.google.com with SMTP id x190so184728396qkb.0
 for <kexec@lists.infradead.org>; Tue, 29 Nov 2016 10:55:58 -0800 (PST)
From: Laura Abbott <labbott@redhat.com>
Subject: [PATCHv4 07/10] kexec: Switch to __pa_symbol
Date: Tue, 29 Nov 2016 10:55:26 -0800
Message-Id: <1480445729-27130-8-git-send-email-labbott@redhat.com>
In-Reply-To: <1480445729-27130-1-git-send-email-labbott@redhat.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
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
To: Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Eric Biederman <ebiederm@xmission.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Thomas Gleixner <tglx@linutronix.de>, Laura Abbott <labbott@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>


__pa_symbol is the correct api to get the physical address of kernel
symbols. Switch to it to allow for better debug checking.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
Found during review of the kernel. Untested.
---
 kernel/kexec_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 5616755..e1b625e 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1397,7 +1397,7 @@ void __weak arch_crash_save_vmcoreinfo(void)
 
 phys_addr_t __weak paddr_vmcoreinfo_note(void)
 {
-	return __pa((unsigned long)(char *)&vmcoreinfo_note);
+	return __pa_symbol((unsigned long)(char *)&vmcoreinfo_note);
 }
 
 static int __init crash_save_vmcoreinfo_init(void)
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
