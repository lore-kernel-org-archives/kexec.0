Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OkoXh-0002sx-La
	for kexec@lists.infradead.org; Mon, 16 Aug 2010 01:31:14 +0000
Date: Mon, 16 Aug 2010 10:31:10 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH][EFI] Run EFI in physical mode
Message-ID: <20100816013109.GS10165@verge.net.au>
References: <F0CB3B1C601247indou.takao@jp.fujitsu.com>
	<4C65C630.4070008@zytor.com>
	<987664A83D2D224EAE907B061CE93D53015B2DAD87@orsmsx505.amr.corp.intel.com>
	<m1r5i2kt0n.fsf@fess.ebiederm.org> <4C65D263.6050904@zytor.com>
	<AANLkTim8U87uZ73BcFc42O6EFWuNkA5UjhhiNeVLtAWT@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTim8U87uZ73BcFc42O6EFWuNkA5UjhhiNeVLtAWT@mail.gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Tony Luck <tony.luck@gmail.com>
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>, "nhorman@tuxdriver.com" <nhorman@tuxdriver.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On Fri, Aug 13, 2010 at 04:36:03PM -0700, Tony Luck wrote:
> On Fri, Aug 13, 2010 at 4:16 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> > I guess my real question was "is this something IA64 could benefit from
> > and/or could we make the IA64 code more similar to the x86 bits"?
> 
> If Eric's recollection about the "weird floating point fixup routines"[1]
> performance issues are correct - then ia64 won't want to do this.

I proposed something similar to this for ia64 at one point to solve the
problem of kexecing to Xen - which at that time mapped EFI to a different
location to Linux.

As I recall, the idea was shot-down by SGI Altix people on the basis
potential performance problems. I don't recall any reasons more specific
than that being given (and to be honest I was less than happy about
it at the time).

In the end I moved EFI in Xen to match Linux and have been able to ignore
the problem ever since. Though as Eric pointed out elsewhere in this
thread, there is ample scope for incompatibilities with future/other
kernels.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
