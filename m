Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gH5yD-0003AM-Ft
 for kexec@lists.infradead.org; Mon, 29 Oct 2018 11:44:39 +0000
Date: Mon, 29 Oct 2018 19:44:14 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181029114414.GA11408@MiWiFi-R3L-srv>
References: <20181027101221.GC1046@nazgul.tnic>
 <20181027110858.GB14493@MiWiFi-R3L-srv>
 <C5F8ED8E-F361-4C6C-B9E2-E3C8BCD8E050@alien8.de>
 <c55bef2a-b972-7e6e-b698-6ac1bc736046@redhat.com>
 <20181027145151.GA7338@nazgul.tnic>
 <390b16ba-05d7-3590-c3b2-4b69aa3ae051@redhat.com>
 <20181029083118.GC1884@MiWiFi-R3L-srv>
 <d6f93848-c750-f29c-4ca7-9661596cad62@redhat.com>
 <20181029095738.GB20101@zn.tnic>
 <15897206-c1a6-ced6-3a1b-f71da8fc9c83@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <15897206-c1a6-ced6-3a1b-f71da8fc9c83@redhat.com>
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

On 10/29/18 at 06:12pm, lijiang wrote:
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 4c8acdfdc5a7..3cc975e7ff8f 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -352,11 +352,16 @@ void machine_kexec(struct kimage *image)
> 
 void arch_crash_save_vmcoreinfo(void)
 {
+       u64 sme_mask = sme_me_mask;
+

This may looks better.

        VMCOREINFO_NUMBER(phys_base);
        VMCOREINFO_SYMBOL(init_top_pgt);
        vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
                        pgtable_l5_enabled());

+       VMCOREINFO_NUMBER(sme_mask);
+
 #ifdef CONFIG_NUMA
        VMCOREINFO_SYMBOL(node_data);
        VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
