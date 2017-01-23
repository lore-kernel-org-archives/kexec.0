Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cViwo-0006fY-KH
 for kexec@lists.infradead.org; Mon, 23 Jan 2017 18:02:32 +0000
Date: Mon, 23 Jan 2017 10:01:53 -0800
From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH] x86/mce: Keep quiet in case of broadcasted mce after
 system panic
Message-ID: <20170123180153.GA5646@intel.com>
References: <1485158511-22374-1-git-send-email-xlpang@redhat.com>
 <20170123125157.u2kefedwpvgcdyfo@pd.tnic>
 <588606B9.3070604@redhat.com>
 <20170123145056.fyraeehjfnwmmfb6@pd.tnic>
 <20170123174008.GA4945@intel.com>
 <20170123175130.l7c7mnmu74ln5v6h@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170123175130.l7c7mnmu74ln5v6h@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: Prarit Bhargava <prarit@redhat.com>, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, xlpang@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Dave Young <dyoung@redhat.com>

On Mon, Jan 23, 2017 at 06:51:30PM +0100, Borislav Petkov wrote:
> Hey Tony,
> 
> a "welcome back" is in order? :-)

Yes - first day back today. Lots of catching up to do.

> And apparently crash knows about poisoned pages and handles them:
> 
> static int __init crash_save_vmcoreinfo_init(void)
> {
> 	...
> #ifdef CONFIG_MEMORY_FAILURE
>         VMCOREINFO_NUMBER(PG_hwpoison);
> #endif
> 
> so if that works, the kexeced kernel should know about that list.

Oh good ... it is smarter than I thought.

> Doesn't matter, right? The new copy is as clueless as the old one about
> those MCEs.

If things are well enough initialized that we don't reset, and
get to do_machine_check(), then this code from Ashok:

        /* If this CPU is offline, just bail out. */
        if (cpu_is_offline(smp_processor_id())) {
                u64 mcgstatus;

                mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
                if (mcgstatus & MCG_STATUS_RIPV) {
                        mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
                        return;
                }
        }

will ignore the machine check on the other cpus ... assuming
that "cpu_is_offline(smp_processor_id())" does the right thing
in the kexec case where this is an "old" cpu that isn't online
in the new kernel.

-Tony

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
