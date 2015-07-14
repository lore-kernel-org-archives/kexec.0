Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 14 Jul 2015 11:02:08 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump
 is not available
Message-ID: <20150714150208.GD10792@redhat.com>
References: <20150710113331.4368.10495.stgit@softrs>
 <20150710113331.4368.63745.stgit@softrs>
 <87wpy82kqf.fsf@x220.int.ebiederm.org>
 <20150713202611.GA16525@fifo99.com>
 <87h9p7r0we.fsf@x220.int.ebiederm.org>
 <20150714135919.GA18333@fifo99.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150714135919.GA18333@fifo99.com>
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
To: dwalker@fifo99.com
Cc: linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>, linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-metag@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org

On Tue, Jul 14, 2015 at 01:59:19PM +0000, dwalker@fifo99.com wrote:
> On Mon, Jul 13, 2015 at 08:19:45PM -0500, Eric W. Biederman wrote:
> > dwalker@fifo99.com writes:
> > 
> > > On Fri, Jul 10, 2015 at 08:41:28AM -0500, Eric W. Biederman wrote:
> > >> Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:
> > >> 
> > >> > You can call panic notifiers and kmsg dumpers before kdump by
> > >> > specifying "crash_kexec_post_notifiers" as a boot parameter.
> > >> > However, it doesn't make sense if kdump is not available.  In that
> > >> > case, disable "crash_kexec_post_notifiers" boot parameter so that
> > >> > you can't change the value of the parameter.
> > >> 
> > >> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > >
> > > I think it would make sense if he just replaced "kdump" with "kexec".
> > 
> > It would be less insane, however it still makes no sense as without
> > kexec on panic support crash_kexec is a noop.  So the value of the
> > seeting makes no difference.
> 
> Can you explain more, I don't really understand what you mean. Are you suggesting
> the whole "crash_kexec_post_notifiers" feature has no value ?

Daniel,

BTW, why are you using crash_kexec_post_notifiers commandline? Why not
without it?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
