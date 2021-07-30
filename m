Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m9bDB-00ARiB-Rv
 for kexec@lists.infradead.org; Fri, 30 Jul 2021 22:42:39 +0000
Received: by mail-pj1-x1033.google.com with SMTP id ca5so17237218pjb.5
 for <kexec@lists.infradead.org>; Fri, 30 Jul 2021 15:42:35 -0700 (PDT)
Date: Fri, 30 Jul 2021 22:42:30 +0000
From: Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 11/12] x86/sev: Handle CLFLUSH MMIO events
Message-ID: <YQSAVo0CXUKHXdLF@google.com>
References: <20210721142015.1401-1-joro@8bytes.org>
 <20210721142015.1401-12-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210721142015.1401-12-joro@8bytes.org>
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
Cc: x86@kernel.org, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Martin Radev <martin.b.radev@gmail.com>, Arvind Sankar <nivedita@alum.mit.edu>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org

On Wed, Jul 21, 2021, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Handle CLFLUSH instruction to MMIO memory in the #VC handler. The
                               ^
			       |- emulated

> instruction is ignored by the handler, as the Hypervisor is
> responsible for cache management of emulated MMIO memory.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/kernel/sev-shared.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index a7a0793c4f98..682fa202444f 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -632,6 +632,15 @@ static enum es_result vc_handle_mmio_twobyte_ops(struct ghcb *ghcb,
>  	long *reg_data;
>  
>  	switch (insn->opcode.bytes[1]) {
> +		/* CLFLUSH */
> +	case 0xae:
> +		/*
> +		 * Ignore CLFLUSHes - those go to emulated MMIO anyway and the
> +		 * hypervisor is responsible for cache management.

This wording can be misread as "the hypervisor is responsible for _all_ cache
management".  Maybe just:

		/*
		 * Ignore CLFLUSHes - the hyperivsor is responsible for cache
		 * management of emulated MMIO.
		 */

Side topic, out of curisoity, what's mapping/accessing emulated MMIO as non-UC?

> +		 */
> +		ret = ES_OK;
> +		break;
> +
>  		/* MMIO Read w/ zero-extension */
>  	case 0xb6:
>  		bytes = 1;
> -- 
> 2.31.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
