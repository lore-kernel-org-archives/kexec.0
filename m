Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailgw.miraclelinux.com ([122.216.84.157])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1LCr3T-0001xK-AY
	for kexec@lists.infradead.org; Wed, 17 Dec 2008 07:42:51 +0000
Date: Wed, 17 Dec 2008 16:42:43 +0900
From: Yoshihiro Takahashi <ytakahashi@miraclelinux.com>
Subject: Re: kdump hangs up by Sysrq+C trigger in high load.
Message-Id: <20081217164243.a7710ae3.ytakahashi@miraclelinux.com>
In-Reply-To: <20081216110949.GB4299@elte.hu>
References: <20081216152143.88caba51.ytakahashi@miraclelinux.com>
	<20081216110949.GB4299@elte.hu>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas, Eduardo Habkost <ehabkost@redhat.com>, Bernhard Walle <bwalle@suse.de>, Ying <ying.huang@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Huang, "H. Peter Anvin" <hpa@zytor.com>, Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>

Ingo. Thank you, your reply.

I will serch it again.

On Tue, 16 Dec 2008 12:09:49 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Yoshihiro Takahashi <ytakahashi@miraclelinux.com> wrote:
> 
> > Hi.
> > 
> > kdump hangs up by Sysrq+C trigger once in about 10 times in high load. 
> > After the above occurs, kdump cannot collect vmcores with NMI button. 
> > When waiting_for_crash_ipi does case more than 0, mdelay seem to make a 
> > stall.
> > 
> > While nmi_shootdown_cpus(), mdelay may not work since interruption is 
> > disable.  (ex. when crashing kernel by NMI interruption, all 
> > interruption may be disabled.).
> > 
> > So I think that it should use other way (TSC) instead of mdelay() in 
> > nmi_shootdown_cpus().
> 
> mdelay uses either the tsc or CPU loops - neither stop while IRQs are 
> disabled.
> 
> Could you figure out exactly why it hangs in your case?
> 
> 	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
