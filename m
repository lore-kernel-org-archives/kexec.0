From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 2 Aug 2007 23:25:02 -0700
Subject: [patch] add kdump_after_notifier
In-Reply-To: <31687.1186113947@kao2.melbourne.sgi.com>
References: <20070802112852.GA7054@in.ibm.com>
	<31687.1186113947@kao2.melbourne.sgi.com>
Message-ID: <20070802232502.b93f4ea0.akpm@linux-foundation.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, 03 Aug 2007 14:05:47 +1000 Keith Owens <kaos@sgi.com> wrote:

> I have pretty well given up on RAS code in the Linux kernel.  Everybody
> has different ideas, there is no overall plan and little interest from
> Linus in getting RAS tools into the kernel.  We are just thrashing.

Lots of different groups, little commonality in their desired funtionality,
little interest in sharing infrastructure or concepts.  Sometimes people
need a bit of motivational help.

In this case that motivation would come from the understanding that all the
RAS tools would be *required* to use such infrastructure if it was merged. 
Going off and open-coding your own stuff would henceforth not be acceptable.
If it turns out that it really was unsuitable for a particular group's RAS
feature, and we merged it anyway, well, that mismatch is that group's
fault.

It was a sizeable mistake to send those patches to a few obscure mailing
lists - this is the first I've heard of it, for example.

So.  Please, send it all again, copy the correct lists and people, make sure
that at least one client of the infrastructure is wired up and working (ideally,
all such in-kernel clients should be wired up) and let's take a look at it.

Much of the onus is upon the various RAS tool developers to demonstrate why it
is unsuitable for their use and, hopefully, to explain how it can be fixed for
them.


