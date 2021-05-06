Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leg9y-006Aqv-OZ
 for kexec@lists.infradead.org; Thu, 06 May 2021 15:43:32 +0000
Received: by mail-pf1-x433.google.com with SMTP id e15so5388876pfv.10
 for <kexec@lists.infradead.org>; Thu, 06 May 2021 08:43:28 -0700 (PDT)
Date: Thu, 6 May 2021 15:43:23 +0000
From: Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 1/2] kexec: Allow architecture code to opt-out at runtime
Message-ID: <YJQOmxx1EMUqNpNn@google.com>
References: <20210506093122.28607-1-joro@8bytes.org>
 <20210506093122.28607-2-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210506093122.28607-2-joro@8bytes.org>
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
Cc: Eric Biederman <ebiederm@xmission.com>, x86@kernel.org, kexec@lists.infradead.org, Joerg Roedel <jroedel@suse.de>, stable@vger.kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Martin Radev <martin.b.radev@gmail.com>, Arvind Sankar <nivedita@alum.mit.edu>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org

On Thu, May 06, 2021, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Allow a runtime opt-out of kexec support for architecture code in case
> the kernel is running in an environment where kexec is not properly
> supported yet.
> 
> This will be used on x86 when the kernel is running as an SEV-ES
> guest. SEV-ES guests need special handling for kexec to hand over all
> CPUs to the new kernel. This requires special hypervisor support and
> handling code in the guest which is not yet implemented.
> 
> Cc: stable@vger.kernel.org # v5.10+
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  kernel/kexec.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index c82c6c06f051..d03134160458 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -195,11 +195,25 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>   * that to happen you need to do that yourself.
>   */
>  
> +bool __weak arch_kexec_supported(void)
> +{
> +	return true;
> +}
> +
>  static inline int kexec_load_check(unsigned long nr_segments,
>  				   unsigned long flags)
>  {
>  	int result;
>  
> +	/*
> +	 * The architecture may support kexec in general, but the kernel could
> +	 * run in an environment where it is not (yet) possible to execute a new
> +	 * kernel. Allow the architecture code to opt-out of kexec support when
> +	 * it is running in such an environment.
> +	 */
> +	if (!arch_kexec_supported())
> +		return -ENOSYS;

This misses kexec_file_load.  Also, is a new hook really needed?  E.g. the
SEV-ES check be shoved into machine_kexec_prepare().  The downside is that we'd
do a fair amount of work before detecting failure, but that doesn't seem hugely
problematic.

> +
>  	/* We only trust the superuser with rebooting the system. */
>  	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
>  		return -EPERM;
> -- 
> 2.31.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
