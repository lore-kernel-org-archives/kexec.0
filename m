Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SUGye-0004DM-QB
 for kexec@lists.infradead.org; Tue, 15 May 2012 12:35:46 +0000
Date: Tue, 15 May 2012 08:35:38 -0400
From: Don Zickus <dzickus@redhat.com>
Subject: Re: makedumpfile memory usage grows with system memory size
Message-ID: <20120515123538.GR32472@redhat.com>
References: <20120410.085824.193685565.d.hatayama@jp.fujitsu.com>
 <20120410125205.GA21801@redhat.com>
 <20120412124040.bad03498.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120412.164714.39159547.d.hatayama@jp.fujitsu.com>
 <20120427164649.9932a33f.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120427125214.GF28185@redhat.com>
 <20120511101952.7530db09.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120511132601.GY32472@redhat.com>
 <20120515145705.d6daeb68.kumagai-atsushi@mxc.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120515145705.d6daeb68.kumagai-atsushi@mxc.nes.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: oomichi@mxs.nes.nec.co.jp, d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org, vgoyal@redhat.com

On Tue, May 15, 2012 at 02:57:05PM +0900, Atsushi Kumagai wrote:
> Hello Don,
> 
> On Fri, 11 May 2012 09:26:01 -0400
> Don Zickus <dzickus@redhat.com> wrote:
> 
> > > Thank you for your reply, Don, Vivek.
> > > 
> > > As Don said, I tried to change the method to exclude free pages and
> > > planed to resolve the memory consumption issue after it, because
> > > parsing free list repeatedly may cause a performance issue.
> > > 
> > > However, I'm thinking that to fix the size of memory consumption is more
> > > important than to resolve a performance issue for large system.
> > > 
> > > So I'm afraid that I would like to change the plan as:
> > > 
> > >   1. Implement "iterating filtering processing" to fix the size of memory
> > >      consumption. At this stage, makedumpfile will parse free list repeatedly
> > >      even though it may cause a performance issue.
> > >      
> > >   2. Take care of the performance issue after the 1st step.
> > 
> > Hello Atsushi-san,
> > 
> > Hmm.  The problem with the free list is that the addresses are in random
> > order, hence the reason to parse it repeatedly, correct?
> 
> Yes.
> 
> > I figured, now that you have a solution to parse the addresses in a linear
> > way (the changes you made a couple of weeks ago), you would just continue
> > with that.  With that complete, we can look at the performance issues and
> > solve them then.
> > 
> > But it is up to you.  You are willing to do the work, so I will defer to
> > your judgement on how best to proceed. :-)
> 
> What I wanted to tell you was I want to resolve the memory consumption issue
> as soon as possible. In other words, I think the method to exclude free pages
> is not so important.
> I'll continue to work with the method which is easy to implement.

Ok.  I look forward to your results.  Thanks for your effort.

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
