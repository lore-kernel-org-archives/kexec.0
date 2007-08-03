Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from netops-testserver-4-out.sgi.com ([192.48.171.29]
	helo=relay.sgi.com)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IGqjy-0005KL-Mp
	for kexec@lists.infradead.org; Fri, 03 Aug 2007 02:34:31 -0400
From: Keith Owens <kaos@ocs.com.au>
Subject: Re: [patch] add kdump_after_notifier 
In-reply-to: Your message of "Thu, 02 Aug 2007 23:25:02 MST."
	<20070802232502.b93f4ea0.akpm@linux-foundation.org> 
Mime-Version: 1.0
Date: Fri, 03 Aug 2007 16:34:04 +1000
Message-ID: <2462.1186122844@kao2.melbourne.sgi.com>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, Takenori Nagano <t-nagano@ah.jp.nec.com>, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>

Andrew Morton (on Thu, 2 Aug 2007 23:25:02 -0700) wrote:
>On Fri, 03 Aug 2007 14:05:47 +1000 Keith Owens <kaos@sgi.com> wrote:

Switching to kaos@ocs.com.au, I just resigned from SGI.

>> I have pretty well given up on RAS code in the Linux kernel.  Everybody
>> has different ideas, there is no overall plan and little interest from
>> Linus in getting RAS tools into the kernel.  We are just thrashing.
>
>Lots of different groups, little commonality in their desired funtionality,
>little interest in sharing infrastructure or concepts.  Sometimes people
>need a bit of motivational help.
>
>In this case that motivation would come from the understanding that all the
>RAS tools would be *required* to use such infrastructure if it was merged. 
>Going off and open-coding your own stuff would henceforth not be acceptable.
>If it turns out that it really was unsuitable for a particular group's RAS
>feature, and we merged it anyway, well, that mismatch is that group's
>fault.
>
>It was a sizeable mistake to send those patches to a few obscure mailing
>lists - this is the first I've heard of it, for example.

linux-arch is obscure??  Where else do you send patches that affect
multiple architectures?

>So.  Please, send it all again, copy the correct lists and people, make sure
>that at least one client of the infrastructure is wired up and working (ideally,
>all such in-kernel clients should be wired up) and let's take a look at it.

Already tried that.  The only RAS tool that is currently in the kernel is
kexec/kdump and they insist on doing things their own way.  That makes
it impossible to put a common RAS structure in place, because kexec
will not use it.

Sorry to keep beating on this drum, but kexec insist that their code
must have priority and that they do not trust the rest of the kernel.
Until that changes, there is no point is discussing how to make kexec
coexist with other RAS tools.  If kexec change their mind then we can
look at using a common RAS interface, otherwise it is a waste of time
and I have better things to do with my life.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
