Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from py-out-1112.google.com ([64.233.166.177])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IadX8-00088B-I8
	for kexec@lists.infradead.org; Wed, 26 Sep 2007 16:31:09 -0400
Received: by py-out-1112.google.com with SMTP id a25so4971587pyi
	for <kexec@lists.infradead.org>; Wed, 26 Sep 2007 13:30:57 -0700 (PDT)
Date: Wed, 26 Sep 2007 16:30:36 -0400
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3: kexec jump
Message-ID: <20070926203036.GF31759@nineveh.local>
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<200709211225.25874.nigel@nigel.suspend2.net>
	<1190342757.21818.75.camel@caritas-dev.intel.com>
	<200709211259.00195.nigel@nigel.suspend2.net>
	<m1r6ksiq27.fsf@ebiederm.dsl.xmission.com>
	<20070921094512.GA20149@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070921094512.GA20149@elf.ucw.cz>
From: jfannin@gmail.com (Joseph Fannin)
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
To: Pavel Machek <pavel@ucw.cz>
Cc: nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Fri, Sep 21, 2007 at 11:45:12AM +0200, Pavel Machek wrote:
> Hi!
> > >
> > > Sounds doable, as long as you can cope with long command lines (which
> > > shouldn't be a biggie). (If you've got a swapfile or parts of a swap
> > > partition already in use, it can be quite fragmented).
> >
> > Hmm.  This is an interesting problem.  Sharing a swap file or a swap
> > partition with the actual swap of user space pages does seem to be
> > a limitation of this approach.
> >
> > Although the fact that it is simple to write to a separate file may
> > be a reasonable compensation.
>
> I'm not sure how you'd write it to a separate file. Notice that kjump
> kernel may not mount journalling filesystems, not even
> read-only. (Ext3 replays journal in that case). You could pass block
> numbers from the original kernel...

    The ext3 thing is a bug, the case for which I don't think has been
adequately explained to the ext[34] folks.  There should be at least a
no_replay mount flag available, or something.  It has ramifications
for more than just hibernation.

    And yeah, I'm gonna bring up the swap files thing again.  If you
can hibernate to a swap file, you can hibernate to a dedicated
hibernation file, and vice versa.

    If you can't hibernate to a swap file, then swap files are
effectively unsupported for any system you might want to hibernate.
<handwave> I wonder what embedded folks would think about that
</handwave>.

    But, in my ignorance, I'm not sure even fixing the ext3 bug will
guarantee you consistent metadata so that you can handle a
swap/hibernate file.  You can do a sync(), but how do you make that
not race against running processes without the freezer, or blkdev
snapshots?

    I guess uswsusp and the-patch-previously-known-as-suspend2 handle
this somehow, though.

   (It's that same ignorance that has me waiting for someone with
established credit with kernel people to make that argument for the
ext3 bug, so I can hang my own reasons for thinking that it's bad off
of theirs).

--
Joseph Fannin
jfannin@gmail.com


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
