Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Tfysy-0002Dr-Fw
 for kexec@lists.infradead.org; Tue, 04 Dec 2012 20:14:33 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <50B43299.9030409@cn.fujitsu.com> <50B432CA.70804@cn.fujitsu.com>
Date: Tue, 04 Dec 2012 12:14:15 -0800
In-Reply-To: <50B432CA.70804@cn.fujitsu.com> (Zhang Yanfei's message of "Tue, 
 27 Nov 2012 11:26:02 +0800")
Message-ID: <87zk1t4lt4.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v9 1/2] x86/kexec: VMCLEAR VMCSs loaded on all cpus if
 necessary
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
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Zhang Yanfei <zhangyanfei@cn.fujitsu.com> writes:

> This patch provides a way to VMCLEAR VMCSs related to guests
> on all cpus before executing the VMXOFF when doing kdump. This
> is used to ensure the VMCSs in the vmcore updated and
> non-corrupted.

Apologies for the delay I have been travelling, and I wanted
to at least read through the code.

Overall I think this is good but I have one nit, and I see one real
problem with this code.

> +/*
> + * This is used to VMCLEAR all VMCSs loaded on the
> + * processor. And when loading kvm_intel module, the
> + * callback function pointer will be assigned.
> + */
> +void (*crash_vmclear_loaded_vmcss)(void) = NULL;
> +EXPORT_SYMBOL_GPL(crash_vmclear_loaded_vmcss);
> +
> +static inline void cpu_emergency_vmclear_loaded_vmcss(void)
> +{
> +	if (crash_vmclear_loaded_vmcss)
> +		crash_vmclear_loaded_vmcss();
> +}

The nit is the use of emergency instead of crash in the name.

The problem is that this is potentially a NULL pointer dereference if
kvm-intel is removed.  The easist fix would be in your second patch to
just make it impossible to unload the kvm-intel module.  Otherwise
there the deference of crash_vmclear_loaded_vmcss needs to be rcu
protected, with a syncrhonize_rcu after the pointer is set to NULL in
the unload path.

Otherwise I have no objections to this code.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
