Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from home.nigel.suspend2.net ([203.171.70.205])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Iadsv-0002Qy-RK
	for kexec@lists.infradead.org; Wed, 26 Sep 2007 21:53:32 +0100
From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3: kexec jump
Date: Thu, 27 Sep 2007 06:52:57 +1000
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<20070921094512.GA20149@elf.ucw.cz>
	<20070926203036.GF31759@nineveh.local>
In-Reply-To: <20070926203036.GF31759@nineveh.local>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200709270652.58205.nigel@nigel.suspend2.net>
Reply-To: nigel@suspend2.net
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Joseph Fannin <jfannin@gmail.com>
Cc: nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

Hi.

On Thursday 27 September 2007 06:30:36 Joseph Fannin wrote:
> On Fri, Sep 21, 2007 at 11:45:12AM +0200, Pavel Machek wrote:
> > Hi!
> > > >
> > > > Sounds doable, as long as you can cope with long command lines (which
> > > > shouldn't be a biggie). (If you've got a swapfile or parts of a swap
> > > > partition already in use, it can be quite fragmented).
> > >
> > > Hmm.  This is an interesting problem.  Sharing a swap file or a swap
> > > partition with the actual swap of user space pages does seem to be
> > > a limitation of this approach.
> > >
> > > Although the fact that it is simple to write to a separate file may
> > > be a reasonable compensation.
> >
> > I'm not sure how you'd write it to a separate file. Notice that kjump
> > kernel may not mount journalling filesystems, not even
> > read-only. (Ext3 replays journal in that case). You could pass block
> > numbers from the original kernel...
> 
>     The ext3 thing is a bug, the case for which I don't think has been
> adequately explained to the ext[34] folks.  There should be at least a
> no_replay mount flag available, or something.  It has ramifications
> for more than just hibernation.
> 
>     And yeah, I'm gonna bring up the swap files thing again.  If you
> can hibernate to a swap file, you can hibernate to a dedicated
> hibernation file, and vice versa.
> 
>     If you can't hibernate to a swap file, then swap files are
> effectively unsupported for any system you might want to hibernate.
> <handwave> I wonder what embedded folks would think about that
> </handwave>.
> 
>     But, in my ignorance, I'm not sure even fixing the ext3 bug will
> guarantee you consistent metadata so that you can handle a
> swap/hibernate file.  You can do a sync(), but how do you make that
> not race against running processes without the freezer, or blkdev
> snapshots?
> 
>     I guess uswsusp and the-patch-previously-known-as-suspend2 handle
> this somehow, though.
> 
>    (It's that same ignorance that has me waiting for someone with
> established credit with kernel people to make that argument for the
> ext3 bug, so I can hang my own reasons for thinking that it's bad off
> of theirs).

I haven't looked at swsusp support, but TuxOnIce handles all storage (swap 
partitions, swap files and ordinary files) by first allocating swap (if we're 
using swap), then bmapping the storage we're going to use. After that, we can 
freeze filesystems and processes with impunity. The allocated storage is then 
viewed as just a collection of bdevs, each with an ordered chain of extents 
defining which blocks we're going to read/write - a series of tapes if you 
like. In the image header, we store dev_ts and the block chains, together 
with the configuration information. As long as the same bdevs are configured 
at boot time prior to the echo > /sys/power/resume, we're in business. 
Filesystems don't need to be mounted because we don't use filesystem code 
anyway. (LVM etc does though in so far as it's needed to make the dev_t match 
the device again).

This matches with what you said above about hibernating to swap files and 
dedicated hibernation files - TuxOnIce uses exactly the same code to do the 
i/o to both; the variation is in the code to recognise the image header and 
allocate/free/bmap storage.

<not a filesystem expert> Personally, I don't think ext[34] is broken. If 
there's data being left in the journal that will need replaying, then 
mounting without replaying the journal sounds wrong. Perhaps you should 
instead be arguing that nothing should be left in the journal after a 
filesystem freeze. But, of course, current code isn't doing a filesystem 
freeze (just a process freeze) and the kexec guys want to take even that 
away. </not a filesystem expert>

In short, I agree. AFAICS, you need both the process freezer and filesystem 
freezing to make this thing fly properly.

Nigel
-- 
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
