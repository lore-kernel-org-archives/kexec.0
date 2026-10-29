Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06094606A31A
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 06:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ufMPn2f8;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=r3nA3HAs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3eZ+SoMnu12sewHRFp3F/WMN9Ay4/pVNLwAnsuFMHhI=; b=ufMPn2f8asag38ANYicZH+8uJe
	f4JRkwyUaBY9Qrfp68pkCEKqEPzeesXucUUKC0eBANi5xxJgtdEtsepETwyqFMx5AxalOlMr43NqW
	EjIoBDUohFzSChxZTYZRmyL+KX/HaMaHb4K1wG6sETJZeVpe3ic45etAepZLwm81OHv3bOaQZ139+
	e87YD/tDdKf01NKTcU+mIx1ZMfou5RUvlTO6iie/05v6t8hLbxBANlkCH75vitozjvknrwQSb4uyz
	oi1eQZBJG2eKBcnK9A2/oWLYfIAdBAfKP5oO6ATjbVuOub/PjmlIomfDNpoDsYA2W0bwyg0pe65Ee
	EqYluIUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMJEp-00000008QiD-1SHu;
	Thu, 29 Oct 2026 06:03:47 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMJEl-00000008QhU-3Gl5
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 06:03:46 +0000
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 131C120B7167; Wed, 28 Oct 2026 23:03:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 131C120B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793253810;
	bh=3eZ+SoMnu12sewHRFp3F/WMN9Ay4/pVNLwAnsuFMHhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r3nA3HAsPf/45QHfWD7s1e/ma8noywtC+3B9NxdDr6jsjn/l2AcmuS5Ir07zeglfB
	 fTbT9nDoyP069EfWfBycBbnvj6krk8jQohB51snAPOu1oD+kk2VRA88IqnrI3LoXZq
	 hVS2jbDwvwTjMfu0dS28bpLN+QEDwftkeFxw0/XA=
Date: Wed, 28 Oct 2026 23:03:30 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Mukesh Pilaniya <mpilaniy@redhat.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH v4 2/2] Drivers: hv: Run VMBus kexec cleanup from syscore
 shutdown
Message-ID: <auLhsrxHucnGdw8t@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261009102215.3360863-1-shradhagupta@linux.microsoft.com>
 <20261009102250.3361076-1-shradhagupta@linux.microsoft.com>
 <a01eea1a-32f6-4445-ba66-5bb48c957876@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a01eea1a-32f6-4445-ba66-5bb48c957876@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_230343_847453_F513B5A1 
X-CRM114-Status: GOOD (  40.35  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 03:52:27PM +0530, Mukesh Pilaniya wrote:
> 
> 
> On 09/10/26 3:52 pm, Shradha Gupta wrote:
> > ARM64 Hyper-V guests do not run the VMBus kexec cleanup before
> > secondary CPUs are stopped. Consequently, the old VMBus connection
> > and SynIC state remain active when the kexec kernel starts.
> > 
> > Run the VMBus kexec handler from the existing VMBus syscore shutdown
> > callback. syscore_shutdown() runs after device shutdown and before
> > machine shutdown, while all CPUs needed by the SynIC CPU hotplug
> > teardown are still available. Guard the callback with
> > kexec_is_in_progress() so normal restart, halt, and poweroff paths are
> > unchanged.
> > 
> > Use the same path on x86 and remove the architecture-specific handler
> > pointer and the weak setup/remove interfaces. VMBus teardown now
> > precedes hv_stimer_global_cleanup() on x86.
> > 
> > The new x86 ordering relies on commit be0cfab740e5 ("clocksource:
> > hyper-v: Remove support for stimer interrupts in message mode"), which
> > removed the synthetic timer's dependency on VMBus message delivery.
> > Older kernels that retain message-mode stimer interrupts must preserve
> > the existing x86 ordering and therefore require an ARM64-specific
> > backport.
> > 
> > Document the VMBus cleanup path and its position in shutdown ordering.
> > 
> > Fixes: 9bbb888824e3 ("arm64: hyperv: Initialize hypervisor on boot")
> > Link: https://lore.kernel.org/all/20260814093133.3191250-1-shradhagupta@linux.microsoft.com/
> > Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> > Suggested-by: Michael Kelley <mhklinux@outlook.com>
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> > Reviewed-by: Bradley Morgan <brads@mainlining.org>
> > Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
> > ---
> >  Documentation/virt/hyperv/overview.rst | 12 +++++++-----
> >  arch/x86/kernel/cpu/mshyperv.c         | 27 ++++++---------------------
> >  drivers/hv/hv_common.c                 | 10 ----------
> >  drivers/hv/vmbus_drv.c                 | 22 ++++++++++++++--------
> >  include/asm-generic/mshyperv.h         |  2 --
> >  5 files changed, 27 insertions(+), 46 deletions(-)
> > 
> > diff --git a/Documentation/virt/hyperv/overview.rst b/Documentation/virt/hyperv/overview.rst
> > index 77408a89d1a4..34a53ba7a122 100644
> > --- a/Documentation/virt/hyperv/overview.rst
> > +++ b/Documentation/virt/hyperv/overview.rst
> > @@ -114,11 +114,13 @@ a shared page or remove an overlay page after the new kernel is
> >  using the page for a different purpose, corrupting the new kernel.
> >  Hyper-V does not provide a single "set everything" operation to
> >  guest VMs, so Linux code must individually revoke all sharing before
> > -doing kexec.   See hv_kexec_handler() and hv_crash_handler().  But
> > -the crash/panic path still has holes in cleanup because some shared
> > -pages are set using per-CPU synthetic registers and there's no
> > -mechanism to revoke the shared pages for CPUs other than the CPU
> > -running the panic path.
> > +doing kexec.  For a normal kexec reboot, the VMBus driver calls
> > +hv_kexec_handler() from its syscore shutdown callback, after device
> > +shutdown and before the architecture-specific machine shutdown.  The
> > +crash/panic path uses hv_crash_handler(), but still has holes in
> > +cleanup because some shared pages are set using per-CPU synthetic
> > +registers and there is no mechanism to revoke the shared pages for
> > +CPUs other than the CPU running the panic path.
> >  
> >  CPU Management
> >  --------------
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index b4af7c0a70ac..fec1c37dafbf 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -148,7 +148,6 @@ EXPORT_SYMBOL_GPL(hv_set_msr);
> >  static void (*mshv_handler)(void);
> >  static void (*vmbus_handler)(void);
> >  static void (*hv_stimer0_handler)(void);
> > -static void (*hv_kexec_handler)(void);
> >  static void (*hv_crash_handler)(struct pt_regs *regs);
> >  
> >  DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
> > @@ -215,16 +214,6 @@ void hv_remove_stimer0_handler(void)
> >  	hv_stimer0_handler = NULL;
> >  }
> >  
> > -void hv_setup_kexec_handler(void (*handler)(void))
> > -{
> > -	hv_kexec_handler = handler;
> > -}
> > -
> > -void hv_remove_kexec_handler(void)
> > -{
> > -	hv_kexec_handler = NULL;
> > -}
> > -
> >  void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
> >  {
> >  	hv_crash_handler = handler;
> > @@ -240,17 +229,13 @@ static void hv_machine_shutdown(void)
> >  {
> >  	if (kexec_in_progress) {
> >  		hv_stimer_global_cleanup();
> > -
> > -		if (hv_kexec_handler)
> > -			hv_kexec_handler();
> > -	}
> > -
> > -	/*
> > -	 * Call hv_cpu_die() on all the CPUs, otherwise later the hypervisor
> > -	 * corrupts the old VP Assist Pages and can crash the kexec kernel.
> > -	 */
> > -	if (kexec_in_progress)
> > +		/*
> > +		 * Call hv_cpu_die() on all the CPUs, otherwise later the
> > +		 * hypervisor corrupts the old VP Assist Pages and can crash
> > +		 * the kexec kernel.
> > +		 */
> >  		cpuhp_remove_state(CPUHP_AP_HYPERV_ONLINE);
> > +	}
> >  
> After this patch, the x86 kexec path ends up with two
> cpuhp_remove_state() calls, one inside hv_kexec_handler() (now fired
> from syscore shutdown) on hyperv_cpuhp_online, and one in
> hv_machine_shutdown() on CPUHP_AP_HYPERV_ONLINE.
> 
> Could you confirm these refer to distinct CPUHP slots? If they resolve
> to the same slot, we'd be calling cpuhp_remove_state() twice on it,
> which would be a bug.
>

Hi Mukesh,

Yes, these refer to distinct CPUHP states.

hyperv_cpuhp_online holds the dynamic state allocated in vmbus_drv.c,
while CPUHP_AP_HYPERV_ONLINE is a seperate fixed state registered
in hv_init.c

Both removals already existed in the x86 kexec path. Previously,
hv_machine_shutdown() called hv_kexec_handler() removing the
VMBus/SynIC state, and then removed CPUHP_AP_HYPERV_ONLINE.


This patch moves the VMBus/SynIC cleanup into the common syscore
shutdown callback for both ARM64 and x86. The removal of the fixed
x86 Hyper-V state remains in hv_machine_shutdown(). Neither state
is removed twice.

Thanks,
Shradha
 
> >  	/* The function calls stop_other_cpus(). */
> >  	native_machine_shutdown();
> > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > index 31256cb22b39..bb290a5eaf1d 100644
> > --- a/drivers/hv/hv_common.c
> > +++ b/drivers/hv/hv_common.c
> > @@ -681,16 +681,6 @@ void __weak hv_setup_mshv_handler(void (*handler)(void))
> >  }
> >  EXPORT_SYMBOL_GPL(hv_setup_mshv_handler);
> >  
> > -void __weak hv_setup_kexec_handler(void (*handler)(void))
> > -{
> > -}
> > -EXPORT_SYMBOL_GPL(hv_setup_kexec_handler);
> > -
> > -void __weak hv_remove_kexec_handler(void)
> > -{
> > -}
> > -EXPORT_SYMBOL_GPL(hv_remove_kexec_handler);
> > -
> >  void __weak hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
> >  {
> >  }
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 5ebdbe24b5a1..3532ea779d34 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/sysfb.h>
> >  #include <linux/efi.h>
> >  #include <linux/kernel.h>
> > +#include <linux/kexec.h>
> >  #include <linux/syscore_ops.h>
> >  #include <linux/dma-map-ops.h>
> >  #include <linux/pci.h>
> > @@ -2904,6 +2905,12 @@ static void hv_kexec_handler(void)
> >  	cpuhp_remove_state(hyperv_cpuhp_online);
> >  };
> >  
> > +static void hv_vmbus_syscore_shutdown(void *data)
> > +{
> > +	if (kexec_is_in_progress())
> > +		hv_kexec_handler();
> > +}
> > +
> >  static void hv_crash_handler(struct pt_regs *regs)
> >  {
> >  	int cpu;
> > @@ -2958,14 +2965,15 @@ static void hv_synic_resume(void *data)
> >  	 */
> >  }
> >  
> > -/* The callbacks run only on CPU0, with irqs_disabled. */
> > -static const struct syscore_ops hv_synic_syscore_ops = {
> > +/* The suspend and resume callbacks run only on CPU0, with irqs_disabled. */
> > +static const struct syscore_ops hv_vmbus_syscore_ops = {
> >  	.suspend = hv_synic_suspend,
> >  	.resume = hv_synic_resume,
> > +	.shutdown = hv_vmbus_syscore_shutdown,
> >  };
> >  
> > -static struct syscore hv_synic_syscore = {
> > -	.ops = &hv_synic_syscore_ops,
> > +static struct syscore hv_vmbus_syscore = {
> > +	.ops = &hv_vmbus_syscore_ops,
> >  };
> >  
> >  static int __init hv_acpi_init(void)
> > @@ -3014,10 +3022,9 @@ static int __init hv_acpi_init(void)
> >  	if (ret)
> >  		goto cleanup;
> >  
> > -	hv_setup_kexec_handler(hv_kexec_handler);
> >  	hv_setup_crash_handler(hv_crash_handler);
> >  
> > -	register_syscore(&hv_synic_syscore);
> > +	register_syscore(&hv_vmbus_syscore);
> >  
> >  	return 0;
> >  
> > @@ -3039,9 +3046,8 @@ static void __exit vmbus_exit(void)
> >  		 */
> >  		return;
> >  
> > -	unregister_syscore(&hv_synic_syscore);
> > +	unregister_syscore(&hv_vmbus_syscore);
> >  
> > -	hv_remove_kexec_handler();
> >  	hv_remove_crash_handler();
> >  	vmbus_connection.conn_state = DISCONNECTED;
> >  	hv_stimer_global_cleanup();
> > diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> > index bf601d67cecb..98fe5c0f54ea 100644
> > --- a/include/asm-generic/mshyperv.h
> > +++ b/include/asm-generic/mshyperv.h
> > @@ -183,8 +183,6 @@ void hv_remove_vmbus_handler(void);
> >  void hv_setup_stimer0_handler(void (*handler)(void));
> >  void hv_remove_stimer0_handler(void);
> >  
> > -void hv_setup_kexec_handler(void (*handler)(void));
> > -void hv_remove_kexec_handler(void);
> >  void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
> >  void hv_remove_crash_handler(void);
> >  void hv_setup_mshv_handler(void (*handler)(void));
> 
> -- 
> Regards,
> Mukesh Pilaniya
> 
> 

