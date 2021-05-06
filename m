Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lejE9-006JTe-K4
 for kexec@lists.infradead.org; Thu, 06 May 2021 19:00:03 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20210506093122.28607-1-joro@8bytes.org>
 <20210506093122.28607-3-joro@8bytes.org>
 <m17dkb4v4k.fsf@fess.ebiederm.org> <YJQ4QTtvG76WpcNf@suse.de>
Date: Thu, 06 May 2021 13:59:42 -0500
In-Reply-To: <YJQ4QTtvG76WpcNf@suse.de> (Joerg Roedel's message of "Thu, 6 May
 2021 20:41:05 +0200")
Message-ID: <m1o8dn1ye9.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] x86/kexec/64: Forbid kexec when running as an SEV-ES
 guest
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Joerg Roedel <jroedel@suse.de>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, kexec@lists.infradead.org, stable@vger.kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>, Martin Radev <martin.b.radev@gmail.com>, Arvind Sankar <nivedita@alum.mit.edu>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org

Joerg Roedel <jroedel@suse.de> writes:

> On Thu, May 06, 2021 at 12:42:03PM -0500, Eric W. Biederman wrote:
>> I don't understand this.
>> 
>> Fundamentally kexec is about doing things more or less inspite of
>> what the firmware is doing.
>> 
>> I don't have any idea what a SEV-ES is.  But the normal x86 boot doesn't
>> do anything special.  Is cross cpu IPI emulation buggy?
>
> Under SEV-ES the normal SIPI-based sequence to re-initialize a CPU does
> not work anymore. An SEV-ES guest is a special virtual machine where the
> hardware encrypts the guest memory and the guest register state. The
> hypervisor can't make any modifications to the guests registers at
> runtime. Therefore it also can't emulate a SIPI sequence and reset the
> vCPU.
>
> The guest kernel has to reset the vCPU itself and hand it over from the
> old kernel to the kexec'ed kernel. This isn't currently implemented and
> therefore kexec needs to be disabled when running as an SEV-ES guest.
>
> Implementing this also requires an extension to the guest-hypervisor
> protocol (the GHCB Spec[1]) which is only available in version 2. So a
> guest running on a hypervisor supporting only version 1 will never
> properly support kexec.

Why does it need that?

Would it not make sense to instead teach kexec how to pass a cpu from
one kernel to another.  We could use that everywhere.

Even the kexec-on-panic case should work as even in that case we have
to touch the cpus as they go down.

The hardware simply worked well enough that it hasn't mattered enough
for us to do something like that, but given that we need to do something
anyway.  It seems like it would make most sense do something that
will work everywhere, and does not introduce unnecessary dependencies
on hypervisors.

>> What is the actual problem you are trying to avoid?
>
> Currently, if someone tries kexec in an SEV-ES guest, the kexec'ed
> kernel will only be able to bring up the boot CPU, not the others. The
> others will wake up with the old kernels CPU state in the new kernels
> memory and do undefined things, most likely triple-fault because their
> page-table is not existent anymore.
>
> So since kexec currently does not work as expected under SEV-ES, it is
> better to hide it until everything is implemented so it can do what the
> user expects.

I can understand temporarily disabling the functionality.

>> And yes for a temporary hack the suggestion of putting code into
>> machine_kexec_prepare seems much more reasonable so we don't have to
>> carry special case infrastructure for the forseeable future.
>
> As I said above, for protocol version 1 it will stay disabled, so it is
> not only a temporary hack.

Why does bringing up a cpu need hypervisor support?

I understand why we can't do what we do currently, but that doesn't seem
to preclude doing something without hypervisor support.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
