Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 14 Jul 2015 15:48:33 +0000
From: dwalker@fifo99.com
Subject: Re: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump
 is not available
Message-ID: <20150714154833.GA18883@fifo99.com>
References: <20150710113331.4368.10495.stgit@softrs>
 <20150710113331.4368.63745.stgit@softrs>
 <87wpy82kqf.fsf@x220.int.ebiederm.org>
 <20150713202611.GA16525@fifo99.com>
 <87h9p7r0we.fsf@x220.int.ebiederm.org>
 <20150714135919.GA18333@fifo99.com>
 <20150714150208.GD10792@redhat.com>
 <20150714153430.GA18766@fifo99.com>
 <20150714154040.GA3912@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150714154040.GA3912@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>, linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-metag@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org

On Tue, Jul 14, 2015 at 11:40:40AM -0400, Vivek Goyal wrote:
> On Tue, Jul 14, 2015 at 03:34:30PM +0000, dwalker@fifo99.com wrote:
> > On Tue, Jul 14, 2015 at 11:02:08AM -0400, Vivek Goyal wrote:
> > > On Tue, Jul 14, 2015 at 01:59:19PM +0000, dwalker@fifo99.com wrote:
> > > > On Mon, Jul 13, 2015 at 08:19:45PM -0500, Eric W. Biederman wrote:
> > > > > dwalker@fifo99.com writes:
> > > > > 
> > > > > > On Fri, Jul 10, 2015 at 08:41:28AM -0500, Eric W. Biederman wrote:
> > > > > >> Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:
> > > > > >> 
> > > > > >> > You can call panic notifiers and kmsg dumpers before kdump by
> > > > > >> > specifying "crash_kexec_post_notifiers" as a boot parameter.
> > > > > >> > However, it doesn't make sense if kdump is not available.  In that
> > > > > >> > case, disable "crash_kexec_post_notifiers" boot parameter so that
> > > > > >> > you can't change the value of the parameter.
> > > > > >> 
> > > > > >> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > > > > >
> > > > > > I think it would make sense if he just replaced "kdump" with "kexec".
> > > > > 
> > > > > It would be less insane, however it still makes no sense as without
> > > > > kexec on panic support crash_kexec is a noop.  So the value of the
> > > > > seeting makes no difference.
> > > > 
> > > > Can you explain more, I don't really understand what you mean. Are you suggesting
> > > > the whole "crash_kexec_post_notifiers" feature has no value ?
> > > 
> > > Daniel,
> > > 
> > > BTW, why are you using crash_kexec_post_notifiers commandline? Why not
> > > without it?
> > 
> > It was explained in the prior thread but to rehash, the notifiers are used to do a switch
> > over from the crashed machine to another redundant machine.
> 
> So why not detect failure using polling or issue notifications from second
> kernel.
> 
> IOW, expecting that a crashed machine will be able to deliver notification
> reliably is falwed to begin with, IMHO.

It's flawed to think you can kexec, but you still do it right ? I've not gotten into
the deep details of this switching process, but that's how this interface is used.
 
> If a machine is failing, there are high chance it can't deliver you the
> notification. Detecting that failure suing some kind of polling mechanism
> might be more reliable. And it will make even kdump mechanism more
> reliable so that it does not have to run panic notifiers after the crash.

I think what your suggesting is that my company should change how it's hardware works
and that's not really an option for me. This isn't a simple thing like checking over the
network if the machine is down or not, this is way more complex hardware design.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
