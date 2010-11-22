Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:4e20:1eda::1] (helo=caramon.arm.linux.org.uk)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PKUZJ-00046O-5B
	for kexec@lists.infradead.org; Mon, 22 Nov 2010 11:28:22 +0000
Date: Mon, 22 Nov 2010 11:27:59 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] Add call to non-crashing cores through IPI
Message-ID: <20101122112759.GA31227@n2100.arm.linux.org.uk>
References: <1290161310-22808-1-git-send-email-per.xx.fransson@stericsson.com>
	<20101122072420.GC14080@gw.healthdatacare.com>
	<AANLkTikJiXFG_kGV4=wTKOzViy-h9VtGRHKVBuh76fE2@mail.gmail.com>
	<20101122104740.GA30744@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20101122104740.GA30744@n2100.arm.linux.org.uk>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Per Fransson <per.fransson.ml@gmail.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Mon, Nov 22, 2010 at 10:47:40AM +0000, Russell King - ARM Linux wrote:
> However, we do need smp_send_stop() to wait for a limited time for the
> other CPUs to respond to the request.

ARM: smp: make smp_send_stop() wait for secondary CPUs to stop

Wait up to one second for secondary CPUs to respond to a request to
stop.  This avoids the sender CPU continuing and possibly destroying
state before the recipients have had a chance to respond to the stop.
However, if the recipients have crashed, we won't hang the sender
CPU indefinitely.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/smp.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 5d0dc16..32a2158 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -589,10 +589,16 @@ void smp_send_reschedule(int cpu)
 
 void smp_send_stop(void)
 {
+	unsigned long timeout;
 	cpumask_t mask = cpu_online_map;
 	cpu_clear(smp_processor_id(), mask);
 	if (!cpus_empty(mask))
 		send_ipi_message(&mask, IPI_CPU_STOP);
+
+	/* Wait up to one second for other CPUs to stop */
+	timeout = USEC_PER_SEC;
+	while (num_online_cpus() > 1 && timeout--)
+		udelay(1);
 }
 
 /*


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
