Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cVibX-0003Er-5o
 for kexec@lists.infradead.org; Mon, 23 Jan 2017 17:40:32 +0000
Date: Mon, 23 Jan 2017 09:40:09 -0800
From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH] x86/mce: Keep quiet in case of broadcasted mce after
 system panic
Message-ID: <20170123174008.GA4945@intel.com>
References: <1485158511-22374-1-git-send-email-xlpang@redhat.com>
 <20170123125157.u2kefedwpvgcdyfo@pd.tnic>
 <588606B9.3070604@redhat.com>
 <20170123145056.fyraeehjfnwmmfb6@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170123145056.fyraeehjfnwmmfb6@pd.tnic>
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

On Mon, Jan 23, 2017 at 03:50:56PM +0100, Borislav Petkov wrote:
> On Mon, Jan 23, 2017 at 09:35:53PM +0800, Xunlei Pang wrote:
> > One possible timing sequence would be:
> > 1st kernel running on multiple cpus panicked
> > then the crash dump code starts
> > the crash dump code stops the others cpus except the crashing one
> > 2nd kernel boots up on the crash cpu with "nr_cpus=1"
> > some broadcasted mce comes on some cpu amongst the other cpus(not the crashing cpu)
> 
> Where does this broadcasted MCE come from?
> 
> The crash dump code triggered it? Or it happened before the panic()?
> 
> Are you talking about an *actual* sequence which you're experiencing on
> real hw or is this something hypothetical?

If the system had experienced some memory corruption, but
recovered ... then there would be some pages sitting around
that the old kernel had marked as POISON and stopped using.
The kexec'd kernel doesn't know about these, so may touch that
memory while taking a crash dump ... and then you have a
broadcast machine check (on older[1] Intel CPUs that don't support
local machine check).

This is hard to work around.  You really need all the CPUs to
have set CR4.MCE=1 (if any didn't, then they will force a reset
when they see the machine check). Also you need to make sure that
they jump to the copy of do_machine_check() in the new kernel, not
the old kernel.

A while ago I played with the nr_cpus=N code to have it bring
all the CPUs far enough online to get the machine check initialization
done, then any extras above "N" just go back offline again.
But I never got this to work reliably.

-Tony

[1] older == all released ones, at the moment.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
