Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1ceeWa-0002mg-6r
 for kexec@lists.infradead.org; Fri, 17 Feb 2017 09:08:23 +0000
Date: Fri, 17 Feb 2017 10:07:35 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/mce: Keep quiet in case of broadcasted mce after
 system panic
Message-ID: <20170217090735.ls5pmtsfwkf3q5h6@pd.tnic>
References: <20170123145056.fyraeehjfnwmmfb6@pd.tnic>
 <5886AD91.10803@redhat.com>
 <20170124122212.3dpdex5wjallypis@pd.tnic>
 <5889976A.9020802@redhat.com>
 <20170126064400.wfsn5pzxnpi6gcuk@pd.tnic>
 <58A53A65.3000405@redhat.com>
 <20170216101845.vkmnde4v6v72dgzx@pd.tnic>
 <58A59269.3050706@redhat.com>
 <20170216122215.uvrckt25g2msfxhe@pd.tnic>
 <58A65791.4090600@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <58A65791.4090600@redhat.com>
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
To: xlpang@redhat.com
Cc: Prarit Bhargava <prarit@redhat.com>, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Feb 17, 2017 at 09:53:21AM +0800, Xunlei Pang wrote:
> It changes the value of cpu_online_mask/etc which will cause confusion to vmcore analysis.

Then export the crashing_cpu variable, initialize it to something
invalid in the first kernel, -1 for example, and test it in the #MC
handlier like this:

	int cpu;

	...

	cpu = smp_processor_id();

	if (cpu_is_offline(cpu) ||
	    ((crashing_cpu != -1) && (crashing_cpu != cpu)) {
                u64 mcgstatus;

                mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
                if (mcgstatus & MCG_STATUS_RIPV) {
                        mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
			return;
		}
	}

> Moreover, for the code(see comment inlined)
> 
>         if (cpu_is_offline(smp_processor_id())) {
>                 u64 mcgstatus;
> 
>                 mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
>                 if (mcgstatus & MCG_STATUS_RIPV) { // This condition may be not true, the mce triggered on kdump cpu 
>                                                                      // doesn't need to have this bit set for the other cpus remain in 1st kernel. 

Is this on kvm or on a real hardware? Because for kvm I don't care. And
don't say "theoretically".

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
