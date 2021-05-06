Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lei0y-006GAz-Sw
 for kexec@lists.infradead.org; Thu, 06 May 2021 17:42:23 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20210506093122.28607-1-joro@8bytes.org>
 <20210506093122.28607-3-joro@8bytes.org>
Date: Thu, 06 May 2021 12:42:03 -0500
In-Reply-To: <20210506093122.28607-3-joro@8bytes.org> (Joerg Roedel's message
 of "Thu, 6 May 2021 11:31:22 +0200")
Message-ID: <m17dkb4v4k.fsf@fess.ebiederm.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, kexec@lists.infradead.org, Joerg Roedel <jroedel@suse.de>, stable@vger.kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>, Martin Radev <martin.b.radev@gmail.com>, Arvind Sankar <nivedita@alum.mit.edu>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org

Joerg Roedel <joro@8bytes.org> writes:

> From: Joerg Roedel <jroedel@suse.de>
>
> For now, kexec is not supported when running as an SEV-ES guest. Doing
> so requires additional hypervisor support and special code to hand
> over the CPUs to the new kernel in a safe way.
>
> Until this is implemented, do not support kexec in SEV-ES guests.

I don't understand this.

Fundamentally kexec is about doing things more or less inspite of
what the firmware is doing.

I don't have any idea what a SEV-ES is.  But the normal x86 boot doesn't
do anything special.  Is cross cpu IPI emulation buggy?

If this is a move in your face hypervisor like Xen is sometimes I can
see perhaps needing a little bit of different work during bootup.
Perhaps handing back a cpu on system shutdown and asking for more cpus
on system boot up.

What is the actual problem you are trying to avoid?

And yes for a temporary hack the suggestion of putting code into
machine_kexec_prepare seems much more reasonable so we don't have to
carry special case infrastructure for the forseeable future.

Eric


> Cc: stable@vger.kernel.org # v5.10+
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index c078b0d3ab0e..f902cc9cc634 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -620,3 +620,11 @@ void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages)
>  	 */
>  	set_memory_encrypted((unsigned long)vaddr, pages);
>  }
> +
> +/*
> + * Kexec is not supported in SEV-ES guests yet
> + */
> +bool arch_kexec_supported(void)
> +{
> +	return !sev_es_active();
> +}

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
