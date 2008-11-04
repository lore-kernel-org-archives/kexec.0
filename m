Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KxQRi-00036w-6B
	for kexec@lists.infradead.org; Tue, 04 Nov 2008 18:16:06 +0000
Date: Tue, 4 Nov 2008 16:15:40 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 07/16] x86: Make nmi_shootdown_cpus() available on !SMP
	and !X86_LOCAL_APIC
Message-ID: <20081104181540.GK23893@blackpad>
References: <1225810364-8990-1-git-send-email-ehabkost@redhat.com>
	<1225810364-8990-8-git-send-email-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1225810364-8990-8-git-send-email-ehabkost@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, Vivek Goyal <vgoyal@redhat.com>



On Tue, Nov 04, 2008 at 12:52:35PM -0200, Eduardo Habkost wrote:
> The X86_LOCAL_APIC #ifdef was for kdump. For !SMP, the function simply
> does nothing.
> 

The bit below is also needed. It can be added to the series right before
patch 07/16.

After getting some review, I will resubmit the series with it, and with
a few style fixes suggested by checkpatch.

---
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 06.1/16] x86: Disable IRQs before doing anything on nmi_shootdown_cpus()

We need to know on which CPU we are running on, and we don't want to be
preempted while doing this.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/kernel/reboot.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 23a9d78..407106e 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -577,6 +577,7 @@ static struct notifier_block crash_nmi_nb = {
 void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 {
 	unsigned long msecs;
+	local_irq_disable();
 
 	/* Make a note of crashing cpu. Will be used in NMI callback.*/
 	crashing_cpu = safe_smp_processor_id();
-- 
1.5.5.GIT


-- 
Eduardo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
