Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1ceL5O-0006M7-Id
 for kexec@lists.infradead.org; Thu, 16 Feb 2017 12:23:00 +0000
Date: Thu, 16 Feb 2017 13:22:16 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/mce: Keep quiet in case of broadcasted mce after
 system panic
Message-ID: <20170216122215.uvrckt25g2msfxhe@pd.tnic>
References: <20170123125157.u2kefedwpvgcdyfo@pd.tnic>
 <588606B9.3070604@redhat.com>
 <20170123145056.fyraeehjfnwmmfb6@pd.tnic>
 <5886AD91.10803@redhat.com>
 <20170124122212.3dpdex5wjallypis@pd.tnic>
 <5889976A.9020802@redhat.com>
 <20170126064400.wfsn5pzxnpi6gcuk@pd.tnic>
 <58A53A65.3000405@redhat.com>
 <20170216101845.vkmnde4v6v72dgzx@pd.tnic>
 <58A59269.3050706@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <58A59269.3050706@redhat.com>
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

On Thu, Feb 16, 2017 at 07:52:09PM +0800, Xunlei Pang wrote:
>     then mce will be broadcast to the other cpus which are still running
>     in the first kernel(i.e. looping in crash_nmi_callback).

Simple: the crash code should really mark CPUs as not being online:

void do_machine_check(struct pt_regs *regs, long error_code)

	...

        /* If this CPU is offline, just bail out. */
        if (cpu_is_offline(smp_processor_id())) {
                u64 mcgstatus;

                mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
                if (mcgstatus & MCG_STATUS_RIPV) {
                        mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
                        return;
                }
        }

because looping in crash_nmi_callback() does not really denote them as
CPUs being online.

And just so that you don't disturb the machine too much during crashing,
you could simply clear them from the online masks, i.e., perhaps call
remove_cpu_from_maps() with the proper locking around it instead of
doing a full cpu_down().

The machine will be killed anyway after kdump is done writing out
memory.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
