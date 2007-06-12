Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wip-ectls-mx1.wipro.com ([203.91.193.21])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HxwV4-0002Vt-RM
	for kexec@lists.infradead.org; Mon, 11 Jun 2007 22:52:57 -0400
Subject: [KJ PATCH] Replacing memcpy(dest,src,PAGE_SIZE) with
	copy_page(dest,src) in arch/i386/kernel/machine_kexec.c
From: Shani Moideen <shani.moideen@wipro.com>
Date: Tue, 12 Jun 2007 08:15:41 +0530
Message-Id: <1181616342.2282.8.camel@shani-win>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: ebiederm@xmission.com
Cc: kernel-janitors@lists.osdl.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org


Hi,
Replacing memcpy(dest,src,PAGE_SIZE) with copy_page(dest,src) in arch/i386/kernel/machine_kexec.c.

Signed-off-by: Shani Moideen <shani.moideen@wipro.com>
----

diff --git a/arch/i386/kernel/machine_kexec.c b/arch/i386/kernel/machine_kexec.c
index 91966ba..ce79a44 100644
--- a/arch/i386/kernel/machine_kexec.c
+++ b/arch/i386/kernel/machine_kexec.c
@@ -110,7 +110,7 @@ NORET_TYPE void machine_kexec(struct kimage *image)
 	local_irq_disable();
 
 	control_page = page_address(image->control_code_page);
-	memcpy(control_page, relocate_kernel, PAGE_SIZE);
+	copy_page(control_page, relocate_kernel);
 
 	page_list[PA_CONTROL_PAGE] = __pa(control_page);
 	page_list[VA_CONTROL_PAGE] = (unsigned long)relocate_kernel;

-- 
Shani 


The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy all copies of this message and any attachments. 

WARNING: Computer viruses can be transmitted via email. The recipient should check this email and any attachments for the presence of viruses. The company accepts no liability for any damage caused by any virus transmitted by this email.
 
www.wipro.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
