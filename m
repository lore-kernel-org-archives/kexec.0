Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bv1bO-0006AY-VW
 for kexec@lists.infradead.org; Fri, 14 Oct 2016 12:28:44 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.8 26/37] arch/x86: Handle non enumerated CPU after physical
 hotplug
Date: Fri, 14 Oct 2016 14:27:12 +0200
Message-Id: <20161014122553.581193322@linuxfoundation.org>
In-Reply-To: <20161014122549.411962735@linuxfoundation.org>
References: <20161014122549.411962735@linuxfoundation.org>
MIME-Version: 1.0
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
To: linux-kernel@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dyoung@redhat.com, kexec@lists.infradead.org, stable@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, Jiri Olsa <jolsa@redhat.com>

4.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prarit Bhargava <prarit@redhat.com>

commit 2a51fe083eba7f99cbda72f5ef90cdf2f4df882c upstream.

When a CPU is physically added to a system then the MADT table is not
updated.

If subsequently a kdump kernel is started on that physically added CPU then
the ACPI enumeration fails to provide the information for this CPU which is
now the boot CPU of the kdump kernel.

As a consequence, generic_processor_info() is not invoked for that CPU so
the number of enumerated processors is 0 and none of the initializations,
including the logical package id management, are performed.

We have code which relies on the correctness of the logical package map and
other information which is initialized via generic_processor_info().
Executing such code will result in undefined behaviour or kernel crashes.

This problem applies only to the kdump kernel because a normal kexec will
switch to the original boot CPU, which is enumerated in MADT, before
jumping into the kexec kernel.

The boot code already has a check for num_processors equal 0 in
prefill_possible_map(). We can use that check as an indicator that the
enumeration of the boot CPU did not happen and invoke generic_processor_info()
for it. That initializes the relevant data for the boot CPU and therefore
prevents subsequent failure.

[ tglx: Refined the code and rewrote the changelog ]

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Fixes: 1f12e32f4cd5 ("x86/topology: Create logical package id")
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: dyoung@redhat.com
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org
Link: http://lkml.kernel.org/r/1475514432-27682-1-git-send-email-prarit@redhat.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/smpboot.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1406,9 +1406,21 @@ __init void prefill_possible_map(void)
 {
 	int i, possible;
 
-	/* no processor from mptable or madt */
-	if (!num_processors)
-		num_processors = 1;
+	/* No boot processor was found in mptable or ACPI MADT */
+	if (!num_processors) {
+		int apicid = boot_cpu_physical_apicid;
+		int cpu = hard_smp_processor_id();
+
+		pr_warn("Boot CPU (id %d) not listed by BIOS\n", cpu);
+
+		/* Make sure boot cpu is enumerated */
+		if (apic->cpu_present_to_apicid(0) == BAD_APICID &&
+		    apic->apic_id_valid(apicid))
+			generic_processor_info(apicid, boot_cpu_apic_version);
+
+		if (!num_processors)
+			num_processors = 1;
+	}
 
 	i = setup_max_cpus ?: 1;
 	if (setup_possible_cpus == -1) {



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
