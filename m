Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KHOyC-0001hd-8o
	for kexec@lists.infradead.org; Fri, 11 Jul 2008 20:11:56 +0000
Date: Fri, 11 Jul 2008 16:11:49 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH -mm 1/2] kexec jump -v12: kexec jump
Message-ID: <20080711201149.GB3298@redhat.com>
References: <1215401122.4660.4.camel@caritas-dev.intel.com>
	<20080708145051.GA14745@redhat.com>
	<20080711122131.b6461ab1.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080711122131.b6461ab1.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Horms <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Huang Ying <ying.huang@intel.com>, linux-pm@lists.linux-foundation.org

On Fri, Jul 11, 2008 at 12:21:31PM -0700, Andrew Morton wrote:
> On Tue, 8 Jul 2008 10:50:51 -0400 Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > On Mon, Jul 07, 2008 at 11:25:22AM +0800, Huang Ying wrote:
> > > This patch provides an enhancement to kexec/kdump. It implements
> > > the following features:
> > > 
> > > - Backup/restore memory used by the original kernel before/after
> > >   kexec.
> > > 
> > > - Save/restore CPU state before/after kexec.
> > > 
> > 
> > Hi Huang,
> > 
> > In general this patch set looks good enough to live in -mm and
> > get some testing going.
> > 
> > To me, adding capability to return back to original kernel looks
> > like a logical extension to kexec functionality.
> 
> Exciting ;)  It's much less code than I expected.
> 
> I don't think I understand the feature any more.  Once upon a time we
> thought that this might become a new and better (or at least
> better-code-sharing) way of doing suspend-to-disk.  How far are we from
> that?
> 

Hi Andrew,

We can use this patchset for hibernation, but can it be a better way of doing
things than what we already have, I don't know. Last time I had raised
this question and power people had various views. In the end, Pavel wanted
this patchset to be in.  Pavel, can tell more here...

To me this patchset looks interesting for couple of reasons.

- Looks like an interesting feature where one can have a separate kernel
  in memory and one can switch between the kernels on the fly. It can
  be modified to have more than one kernel in memory at a time.

- So far kexec was one directional. One can only kexec to new kernel and
  old kernel was gone. Now this patchset makes kexec functionality kind
  of bidirectional and this looks like logical extension and can lead
  to intersting use cases in future.

Huang also talks of using this feature for snapshotting kernel and
invoking some BIOS code in protected mode. I am not very sure how exactly
are they planning to use it. Huang, do you have more details on this?

> What are the prospects of supporting other architectures?
> 

I think it should be doable on other architectures as well where kexec
is supported. Can't think of a reason why it can't be. Huang, what do
you think?

> Who maintains kexec-tools, and are they OK with merging up the
> corresponding changes?
> 

I think Eric still has the ownership of kexec-tools. But it has been
long since kexec-tools has been updated. Now simon horman is maintaining
a separate tree, kexec-tools-testing, and all the active development
is taking place there.

Huang has not exactly posted kexec-tools patches but has given link
to kexec-tools patches and no body has objected so far. I am CCing it
to Simon Horman, if he sees any issues.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
