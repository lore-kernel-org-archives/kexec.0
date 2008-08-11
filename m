Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KSXp2-0001KP-7z
	for kexec@lists.infradead.org; Mon, 11 Aug 2008 13:52:32 +0000
Date: Mon, 11 Aug 2008 09:51:36 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH -v2 7/8] kexec jump: ftrace_enabled_save/restore
Message-ID: <20080811135136.GD28030@redhat.com>
References: <1218178368.22039.80.camel@caritas-dev.intel.com>
	<20080808141700.GF3840@redhat.com>
	<alpine.DEB.1.10.0808081026240.22796@gandalf.stny.rr.com>
	<1218417741.30464.23.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1218417741.30464.23.camel@caritas-dev.intel.com>
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
To: Huang Ying <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu

On Mon, Aug 11, 2008 at 09:22:21AM +0800, Huang Ying wrote:
> Hi, Steven,
> 
> On Fri, 2008-08-08 at 10:30 -0400, Steven Rostedt wrote:
> [...]
> > The only problem with this approach is what happens if the user changes 
> > the enabled in between these two calls. This would make ftrace 
> > inconsistent.
> > 
> > I have a patch from the -rt tree that handles what you want. It is 
> > attached below. Not sure how well it will apply to mainline.
> > 
> > I really need to go through the rt patch set and start submitting a bunch 
> > of clean-up/fixes to mainline. We've been meaning to do it, just have been 
> > distracted :-(
> 
> Your version is better in general sense. Thank you very much!
> 
> But in this specific situation of kexec/kjump. The execution environment
> is that other CPUs are disabled, local irq is disabled, and it is not
> permitted to switch to other process. But it is safe and sufficient to
> use non-locked version here.
> 
> So to satisfy both demands, I think it is better to provide both
> version, locked and non-locked. What do you think about that?
> 

Huang,

So you want to use a non-locked version from optimization point of view?
So that we don't end up taking and release a lock?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
