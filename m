Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn7nam10on2084.outbound.protection.outlook.com
 ([40.107.92.84] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6Jb6-00HHtP-Tz
 for kexec@lists.infradead.org; Wed, 21 Jul 2021 21:17:47 +0000
Subject: Re: [PATCH 04/12] x86/sev: Do not hardcode GHCB protocol version
References: <20210721142015.1401-1-joro@8bytes.org>
 <20210721142015.1401-5-joro@8bytes.org>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <1eef6235-a8d0-1012-969e-ef6f0804d054@amd.com>
Date: Wed, 21 Jul 2021 16:17:38 -0500
In-Reply-To: <20210721142015.1401-5-joro@8bytes.org>
Content-Language: en-US
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
To: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>, Martin Radev <martin.b.radev@gmail.com>, Arvind Sankar <nivedita@alum.mit.edu>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org

On 7/21/21 9:20 AM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Introduce the sev_get_ghcb_proto_ver() which will return the negotiated
> GHCB protocol version and use it to set the version field in the GHCB.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/boot/compressed/sev.c | 5 +++++
>  arch/x86/kernel/sev-shared.c   | 5 ++++-
>  arch/x86/kernel/sev.c          | 5 +++++
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 1a2e49730f8b..101e08c67296 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -119,6 +119,11 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
>  /* Include code for early handlers */
>  #include "../../kernel/sev-shared.c"
>  
> +static u64 sev_get_ghcb_proto_ver(void)
> +{
> +	return GHCB_PROTOCOL_MAX;
> +}
> +
>  static bool early_setup_sev_es(void)
>  {
>  	if (!sev_es_negotiate_protocol(NULL))
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 73eeb5897d16..36eaac2773ed 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -28,6 +28,9 @@ struct sev_ghcb_protocol_info {
>  	unsigned int vm_proto;
>  };
>  
> +/* Returns the negotiated GHCB Protocol version */
> +static u64 sev_get_ghcb_proto_ver(void);
> +
>  static bool __init sev_es_check_cpu_features(void)
>  {
>  	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
> @@ -122,7 +125,7 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
>  	enum es_result ret;
>  
>  	/* Fill in protocol and format specifiers */
> -	ghcb->protocol_version = GHCB_PROTOCOL_MAX;
> +	ghcb->protocol_version = sev_get_ghcb_proto_ver();

So this probably needs better clarification in the spec, but the GHCB
version field is for the GHCB structure layout. So if you don't plan to
use the XSS field that was added for version 2 of the layout, then you
should report the GHCB structure version as 1.

Thanks,
Tom

>  	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
>  
>  	ghcb_set_sw_exit_code(ghcb, exit_code);
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 8084bfd7cce1..5d3422e8b25e 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -498,6 +498,11 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt
>  /* Negotiated GHCB protocol version */
>  static struct sev_ghcb_protocol_info ghcb_protocol_info __ro_after_init;
>  
> +static u64 sev_get_ghcb_proto_ver(void)
> +{
> +	return ghcb_protocol_info.vm_proto;
> +}
> +
>  static noinstr void __sev_put_ghcb(struct ghcb_state *state)
>  {
>  	struct sev_es_runtime_data *data;
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
