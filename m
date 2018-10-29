Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gH2xQ-0005PF-TO
 for kexec@lists.infradead.org; Mon, 29 Oct 2018 08:31:35 +0000
Date: Mon, 29 Oct 2018 16:31:18 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181029083118.GC1884@MiWiFi-R3L-srv>
References: <20181026222517.GB26927@nazgul.tnic>
 <20181027081343.GA1884@MiWiFi-R3L-srv>
 <20181027091007.GB1046@nazgul.tnic>
 <20181027093917.GA14493@MiWiFi-R3L-srv>
 <20181027101221.GC1046@nazgul.tnic>
 <20181027110858.GB14493@MiWiFi-R3L-srv>
 <C5F8ED8E-F361-4C6C-B9E2-E3C8BCD8E050@alien8.de>
 <c55bef2a-b972-7e6e-b698-6ac1bc736046@redhat.com>
 <20181027145151.GA7338@nazgul.tnic>
 <390b16ba-05d7-3590-c3b2-4b69aa3ae051@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <390b16ba-05d7-3590-c3b2-4b69aa3ae051@redhat.com>
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
To: lijiang <lijiang@redhat.com>
Cc: kexec@lists.infradead.org, x86@kernel.org, Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org, mingo@redhat.com, Borislav Petkov <bp@alien8.de>, tglx@linutronix.de, dyoung@redhat.com

On 10/29/18 at 03:59pm, lijiang wrote:
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 4c8acdfdc5a7..de363796ed20 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -29,6 +29,9 @@
>  #include <asm/setup.h>
>  #include <asm/set_memory.h>
> 
> +u64 sme_mask;
> +EXPORT_SYMBOL(sme_mask);

Wondering why it is global. Who else will use it?

> +
>  #ifdef CONFIG_KEXEC_FILE
>  const struct kexec_file_ops * const kexec_file_loaders[] = {
>                 &kexec_bzImage64_ops,
> @@ -357,6 +360,9 @@ void arch_crash_save_vmcoreinfo(void)
>         vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
>                         pgtable_l5_enabled());
> 
> +       sme_mask = sme_me_mask;
> +       VMCOREINFO_NUMBER(sme_mask);
> +
>  #ifdef CONFIG_NUMA
>         VMCOREINFO_SYMBOL(node_data);
>         VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
