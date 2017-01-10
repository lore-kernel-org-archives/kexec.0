Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cR45n-0002I8-Uy
 for kexec@lists.infradead.org; Tue, 10 Jan 2017 21:36:35 +0000
Received: by mail-qt0-f177.google.com with SMTP id l7so129475476qtd.1
 for <kexec@lists.infradead.org>; Tue, 10 Jan 2017 13:36:11 -0800 (PST)
From: Laura Abbott <labbott@redhat.com>
Subject: [PATCHv7 04/11] kexec: Switch to __pa_symbol
Date: Tue, 10 Jan 2017 13:35:43 -0800
Message-Id: <1484084150-1523-5-git-send-email-labbott@redhat.com>
In-Reply-To: <1484084150-1523-1-git-send-email-labbott@redhat.com>
References: <1484084150-1523-1-git-send-email-labbott@redhat.com>
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
To: Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Eric Biederman <ebiederm@xmission.com>, Florian Fainelli <f.fainelli@gmail.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Thomas Gleixner <tglx@linutronix.de>, Laura Abbott <labbott@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>

__pa_symbol is the correct api to get the physical address of kernel
symbols. Switch to it to allow for better debug checking.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 kernel/kexec_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 5617cc4..a01974e 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1399,7 +1399,7 @@ void __weak arch_crash_save_vmcoreinfo(void)
 
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
