Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1miIlF-005doM-9O
 for kexec@lists.infradead.org; Wed, 03 Nov 2021 16:05:14 +0000
Date: Wed, 3 Nov 2021 17:05:04 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 05/12] x86/sev: Use GHCB protocol version 2 if supported
Message-ID: <YYKzMMyhI1M72YIQ@zn.tnic>
References: <20210913155603.28383-1-joro@8bytes.org>
 <20210913155603.28383-6-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210913155603.28383-6-joro@8bytes.org>
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
To: Joerg Roedel <joro@8bytes.org>, Brijesh Singh <brijesh.singh@amd.com>
Cc: x86@kernel.org, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>, Martin Radev <martin.b.radev@gmail.com>, Arvind Sankar <nivedita@alum.mit.edu>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org

On Mon, Sep 13, 2021 at 05:55:56PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Check whether the hypervisor supports GHCB version 2 and use it if
> available.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/boot/compressed/sev.c | 10 ++++++++--
>  arch/x86/include/asm/sev.h     |  4 ++--
>  arch/x86/kernel/sev-shared.c   | 17 ++++++++++++++---
>  3 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 101e08c67296..7f8416f76be7 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -119,16 +119,22 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
>  /* Include code for early handlers */
>  #include "../../kernel/sev-shared.c"
>  
> +static unsigned int ghcb_protocol;

I guess you need to sync up with Brijesh on what to use:

https://lore.kernel.org/r/20211008180453.462291-7-brijesh.singh@amd.com

And if ghcb_version there is __ro_after_init I think that's perfectly
fine and doesn't need an accessor...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
