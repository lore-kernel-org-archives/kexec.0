Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1LCXoQ-0008Ol-U1
	for kexec@lists.infradead.org; Tue, 16 Dec 2008 11:10:03 +0000
Date: Tue, 16 Dec 2008 12:09:49 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: kdump hangs up by Sysrq+C trigger in high load.
Message-ID: <20081216110949.GB4299@elte.hu>
References: <20081216152143.88caba51.ytakahashi@miraclelinux.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081216152143.88caba51.ytakahashi@miraclelinux.com>
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
To: Yoshihiro Takahashi <ytakahashi@miraclelinux.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Bernhard Walle <bwalle@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>


* Yoshihiro Takahashi <ytakahashi@miraclelinux.com> wrote:

> Hi.
> 
> kdump hangs up by Sysrq+C trigger once in about 10 times in high load. 
> After the above occurs, kdump cannot collect vmcores with NMI button. 
> When waiting_for_crash_ipi does case more than 0, mdelay seem to make a 
> stall.
> 
> While nmi_shootdown_cpus(), mdelay may not work since interruption is 
> disable.  (ex. when crashing kernel by NMI interruption, all 
> interruption may be disabled.).
> 
> So I think that it should use other way (TSC) instead of mdelay() in 
> nmi_shootdown_cpus().

mdelay uses either the tsc or CPU loops - neither stop while IRQs are 
disabled.

Could you figure out exactly why it hangs in your case?

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
