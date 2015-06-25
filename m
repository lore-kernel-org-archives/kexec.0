Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z83ve-00083E-88
 for kexec@lists.infradead.org; Thu, 25 Jun 2015 09:58:42 +0000
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v3 4/5] Drivers: hv: don't do hypercalls when hypercall_page
 is NULL
Date: Thu, 25 Jun 2015 11:58:05 +0200
Message-Id: <1435226286-24842-5-git-send-email-vkuznets@redhat.com>
In-Reply-To: <1435226286-24842-1-git-send-email-vkuznets@redhat.com>
References: <1435226286-24842-1-git-send-email-vkuznets@redhat.com>
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
To: devel@linuxdriverproject.org
Cc: Olaf Hering <olaf@aepfle.de>, Greg KH <gregkh@linuxfoundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "K. Y. Srinivasan" <kys@microsoft.com>

At the very late stage of kexec a driver (which are not being unloaded) can
try to post a message or signal an event. This will crash the kernel as we
already did hv_cleanup() and the hypercall page is NULL.

Move all common (between 32 and 64 bit code) declarations to the beginning
of the do_hypercall() function. Unfortunately we have to write the
!hypercall_page check twice to not mix declarations and code.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/hv.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 5b87042..41d8072 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -93,11 +93,14 @@ static int query_hypervisor_info(void)
  */
 static u64 do_hypercall(u64 control, void *input, void *output)
 {
-#ifdef CONFIG_X86_64
-	u64 hv_status = 0;
 	u64 input_address = (input) ? virt_to_phys(input) : 0;
 	u64 output_address = (output) ? virt_to_phys(output) : 0;
 	void *hypercall_page = hv_context.hypercall_page;
+#ifdef CONFIG_X86_64
+	u64 hv_status = 0;
+
+	if (!hypercall_page)
+		return (u64)ULLONG_MAX;
 
 	__asm__ __volatile__("mov %0, %%r8" : : "r" (output_address) : "r8");
 	__asm__ __volatile__("call *%3" : "=a" (hv_status) :
@@ -112,13 +115,13 @@ static u64 do_hypercall(u64 control, void *input, void *output)
 	u32 control_lo = control & 0xFFFFFFFF;
 	u32 hv_status_hi = 1;
 	u32 hv_status_lo = 1;
-	u64 input_address = (input) ? virt_to_phys(input) : 0;
 	u32 input_address_hi = input_address >> 32;
 	u32 input_address_lo = input_address & 0xFFFFFFFF;
-	u64 output_address = (output) ? virt_to_phys(output) : 0;
 	u32 output_address_hi = output_address >> 32;
 	u32 output_address_lo = output_address & 0xFFFFFFFF;
-	void *hypercall_page = hv_context.hypercall_page;
+
+	if (!hypercall_page)
+		return (u64)ULLONG_MAX;
 
 	__asm__ __volatile__ ("call *%8" : "=d"(hv_status_hi),
 			      "=a"(hv_status_lo) : "d" (control_hi),
-- 
2.4.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
