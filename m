From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 3 Aug 2007 00:37:43 -0700
Subject: [patch] add kdump_after_notifier
In-Reply-To: <2462.1186122844@kao2.melbourne.sgi.com>
References: <20070802232502.b93f4ea0.akpm@linux-foundation.org>
	<2462.1186122844@kao2.melbourne.sgi.com>
Message-ID: <20070803003743.1de639b3.akpm@linux-foundation.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, 03 Aug 2007 16:34:04 +1000 Keith Owens <kaos@ocs.com.au> wrote:

> Andrew Morton (on Thu, 2 Aug 2007 23:25:02 -0700) wrote:
> >On Fri, 03 Aug 2007 14:05:47 +1000 Keith Owens <kaos@sgi.com> wrote:
> 
> Switching to kaos at ocs.com.au, I just resigned from SGI.
> 
> >> I have pretty well given up on RAS code in the Linux kernel.  Everybody
> >> has different ideas, there is no overall plan and little interest from
> >> Linus in getting RAS tools into the kernel.  We are just thrashing.
> >
> >Lots of different groups, little commonality in their desired funtionality,
> >little interest in sharing infrastructure or concepts.  Sometimes people
> >need a bit of motivational help.
> >
> >In this case that motivation would come from the understanding that all the
> >RAS tools would be *required* to use such infrastructure if it was merged. 
> >Going off and open-coding your own stuff would henceforth not be acceptable.
> >If it turns out that it really was unsuitable for a particular group's RAS
> >feature, and we merged it anyway, well, that mismatch is that group's
> >fault.
> >
> >It was a sizeable mistake to send those patches to a few obscure mailing
> >lists - this is the first I've heard of it, for example.
> 
> linux-arch is obscure?? 

Exceedingly.  It's a way of contacting arch maintainers, that's all.  It
isn't really a place to discuss new infrastructural concepts which affect
multiple features.

> Where else do you send patches that affect
> multiple architectures?

This should have gone to linux-kernel.

> >So.  Please, send it all again, copy the correct lists and people, make sure
> >that at least one client of the infrastructure is wired up and working (ideally,
> >all such in-kernel clients should be wired up) and let's take a look at it.
> 
> Already tried that.  The only RAS tool that is currently in the kernel is
> kexec/kdump and they insist on doing things their own way.  That makes
> it impossible to put a common RAS structure in place, because kexec
> will not use it.

eh, write the patch for them, let's look at how much impact it is likely to
have.

> Sorry to keep beating on this drum, but kexec insist that their code
> must have priority and that they do not trust the rest of the kernel.
> Until that changes, there is no point is discussing how to make kexec
> coexist with other RAS tools.  If kexec change their mind then we can
> look at using a common RAS interface, otherwise it is a waste of time
> and I have better things to do with my life.

I saw one email from Vivek expressing on-general-principle concerns.  It
was hardly thorough or irreconcilable-looking.

Let's drag this thing into the daylight and poke at it a bit.

