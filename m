Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([78.46.96.112])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1cVimz-0001dK-Ey
 for kexec@lists.infradead.org; Mon, 23 Jan 2017 17:52:23 +0000
Date: Mon, 23 Jan 2017 18:51:30 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/mce: Keep quiet in case of broadcasted mce after
 system panic
Message-ID: <20170123175130.l7c7mnmu74ln5v6h@pd.tnic>
References: <1485158511-22374-1-git-send-email-xlpang@redhat.com>
 <20170123125157.u2kefedwpvgcdyfo@pd.tnic>
 <588606B9.3070604@redhat.com>
 <20170123145056.fyraeehjfnwmmfb6@pd.tnic>
 <20170123174008.GA4945@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170123174008.GA4945@intel.com>
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
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Prarit Bhargava <prarit@redhat.com>, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, xlpang@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Dave Young <dyoung@redhat.com>

Hey Tony,

a "welcome back" is in order? :-)

On Mon, Jan 23, 2017 at 09:40:09AM -0800, Luck, Tony wrote:
> If the system had experienced some memory corruption, but
> recovered ... then there would be some pages sitting around
> that the old kernel had marked as POISON and stopped using.
> The kexec'd kernel doesn't know about these, so may touch that
> memory while taking a crash dump ...

Hmm, pass a list of poisoned pages to the kdump kernel so as not to
touch. Looks like there's already functionality for that:

"makedumpfile can exclude the following types of pages while copying
VMCORE to DUMPFILE, and a user can choose which type of pages will be
excluded.

- Pages filled with zero
- Cache pages
- User process data pages
- Free pages"

 (there is a makedumpfile manpage somewhere)

And apparently crash knows about poisoned pages and handles them:

static int __init crash_save_vmcoreinfo_init(void)
{
	...
#ifdef CONFIG_MEMORY_FAILURE
        VMCOREINFO_NUMBER(PG_hwpoison);
#endif

so if that works, the kexeced kernel should know about that list.

> and then you have a broadcast machine check (on older[1] Intel CPUs
> that don't support local machine check).

Right.

> This is hard to work around. You really need all the CPUs to have set
> CR4.MCE=1 (if any didn't, then they will force a reset when they see
> the machine check). Also you need to make sure that they jump to the
> copy of do_machine_check() in the new kernel, not the old kernel.

Doesn't matter, right? The new copy is as clueless as the old one about
those MCEs.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
