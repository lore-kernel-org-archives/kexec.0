Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gFyea-0005W1-8y
 for kexec@lists.infradead.org; Fri, 26 Oct 2018 09:43:42 +0000
Date: Fri, 26 Oct 2018 10:43:21 +0100
In-Reply-To: <20181026093630.8520-1-lijiang@redhat.com>
References: <20181026093630.8520-1-lijiang@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
From: Boris Petkov <bp@alien8.de>
Message-ID: <053CC83A-9A95-4C12-9627-AABD1427DA9C@alien8.de>
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
To: Lianbo Jiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org
Cc: bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com

On October 26, 2018 10:36:30 AM GMT+01:00, Lianbo Jiang <lijiang@redhat.com> wrote:
>For AMD machine with SME feature, makedumpfile tools need to know
>whether the crash kernel was encrypted or not. 

Why?

> So it is necessary
>to write the sme_me_mask to vmcoreinfo.
>
>Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>---
> arch/x86/kernel/machine_kexec_64.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/arch/x86/kernel/machine_kexec_64.c
>b/arch/x86/kernel/machine_kexec_64.c
>index 4c8acdfdc5a7..dcfdb64d1097 100644
>--- a/arch/x86/kernel/machine_kexec_64.c
>+++ b/arch/x86/kernel/machine_kexec_64.c
>@@ -357,6 +357,8 @@ void arch_crash_save_vmcoreinfo(void)
> 	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
> 			pgtable_l5_enabled());
> 
>+	VMCOREINFO_NUMBER(sme_me_mask);

No we're not going to expose a kernel-internal mask to userspace. 

If at all needed, add functions to kexec which figure out whether we are encrypted or not and export that result as a kexec variable.


-- 
Sent from a small device: formatting sux and brevity is inevitable. 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
