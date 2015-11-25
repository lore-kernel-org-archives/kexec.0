Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a1YaU-0002nl-8T
 for kexec@lists.infradead.org; Wed, 25 Nov 2015 11:50:15 +0000
Date: Wed, 25 Nov 2015 12:49:48 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [V5 PATCH 4/4] x86/apic: Introduce apic_extnmi boot option
Message-ID: <20151125114948.GA4227@pd.tnic>
References: <20151120093641.4285.97253.stgit@softrs>
 <20151120093650.4285.94971.stgit@softrs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151120093650.4285.94971.stgit@softrs>
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
To: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: x86@kernel.org, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Fri, Nov 20, 2015 at 06:36:50PM +0900, Hidehiro Kawai wrote:
> This patch introduces new boot option, apic_extnmi:
> 
>  apic_extnmi={ bsp | all | none}
> 
> The default value is "bsp" and this is the current behavior; only
> BSP receives external NMI.  "all" allows external NMIs to be
> broadcast to all CPUs.  This would raise the success rate of panic
> on NMI when BSP hangs up in NMI context or the external NMI is
> swallowed by other NMI handlers on BSP.  If you specified "none",
> any CPUs don't receive external NMIs.  This is useful for dump
> capture kernel so that it wouldn't be shot down while saving a
> crash dump.
> 
> V5:
> - Rename the option from "noextnmi" to "apic_extnmi"
> - Add apic_extnmi=all feature
> - Fix the wrong documentation about "noextnmi" (apic_extnmi=none)
> 
> Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/kernel-parameters.txt |    9 +++++++++
>  arch/x86/include/asm/apic.h         |    5 +++++
>  arch/x86/kernel/apic/apic.c         |   31 ++++++++++++++++++++++++++++++-
>  3 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index f8aae63..ceed3bc 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -472,6 +472,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  			Change the amount of debugging information output
>  			when initialising the APIC and IO-APIC components.
>  
> +	apic_extnmi=	[APIC,X86] External NMI delivery setting
> +			Format: { bsp (default) | all | none }
> +			bsp:  External NMI is delivered to only CPU 0

							only to

> +			all:  External NMIs are broadcast to all CPUs as a
> +			      backup of CPU 0
> +			none: External NMI is masked for all CPUs. This is
> +			      useful so that a dump capture kernel won't be
> +			      shot down by NMI
> +
>  	autoconf=	[IPV6]
>  			See Documentation/networking/ipv6.txt.
>  
> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> index 7f62ad4..c80f6b6 100644
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -23,6 +23,11 @@
>  #define APIC_VERBOSE 1
>  #define APIC_DEBUG   2
>  
> +/* Macros for apic_extnmi which controls external NMI masking */
> +#define APIC_EXTNMI_BSP		0 /* Default */
> +#define APIC_EXTNMI_ALL		1
> +#define APIC_EXTNMI_NONE	2
> +
>  /*
>   * Define the default level of output to be very little
>   * This can be turned up by using apic=verbose for more
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 2f69e3b..a2a8074 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -82,6 +82,12 @@ physid_mask_t phys_cpu_present_map;
>  static unsigned int disabled_cpu_apicid __read_mostly = BAD_APICID;
>  
>  /*
> + * This variable controls which CPUs receive external NMIs.  By default,
> + * external NMIs are delivered to only BSP.

				  only to the BSP.

> + */
> +static int apic_extnmi = APIC_EXTNMI_BSP;
> +
> +/*
>   * Map cpu index to physical APIC ID
>   */
>  DEFINE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid, BAD_APICID);
> @@ -1161,6 +1167,8 @@ void __init init_bsp_APIC(void)
>  	value = APIC_DM_NMI;
>  	if (!lapic_is_integrated())		/* 82489DX */
>  		value |= APIC_LVT_LEVEL_TRIGGER;
> +	if (apic_extnmi == APIC_EXTNMI_NONE)
> +		value |= APIC_LVT_MASKED;
>  	apic_write(APIC_LVT1, value);
>  }
>  
> @@ -1380,7 +1388,8 @@ void setup_local_APIC(void)
>  	/*
>  	 * only the BP should see the LINT1 NMI signal, obviously.
>  	 */

That comment needs adjusting.

> -	if (!cpu)
> +	if ((!cpu && apic_extnmi != APIC_EXTNMI_NONE) ||
> +	    apic_extnmi == APIC_EXTNMI_ALL)
>  		value = APIC_DM_NMI;
>  	else
>  		value = APIC_DM_NMI | APIC_LVT_MASKED;
> @@ -2548,3 +2557,23 @@ static int __init apic_set_disabled_cpu_apicid(char *arg)
>  	return 0;
>  }
>  early_param("disable_cpu_apicid", apic_set_disabled_cpu_apicid);
> +
> +static int __init apic_set_extnmi(char *arg)
> +{
> +	if (!arg)
> +		return -EINVAL;
> +
> +	if (strcmp("all", arg) == 0)

	if (!strncmp("all", arg, 3))

ditto for the rest

> +		apic_extnmi = APIC_EXTNMI_ALL;
> +	else if (strcmp("none", arg) == 0)
> +		apic_extnmi = APIC_EXTNMI_NONE;
> +	else if (strcmp("bsp", arg) == 0)
> +		apic_extnmi = APIC_EXTNMI_BSP;
> +	else {
> +		pr_warn("Unknown external NMI delivery mode `%s' is ignored\n",

s/is //

Also, if there's no other delivery mode which makes sense, you can do:

	pr_warn("Unknown external NMI delivery mode `%s', defaulting to	'bsp'\n", arg);
	apic_extnmi = APIC_EXTNMI_BSP;

Btw, you can let the pr_warn line be longer than 80 cols.

And if you don't default, you need

		return -EINVAL;

here.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
