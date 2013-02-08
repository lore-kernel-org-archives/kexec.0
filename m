Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U3uGV-00039P-TE
 for kexec@lists.infradead.org; Fri, 08 Feb 2013 20:09:44 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/3] Cleanup kdump memmap= passing and e820 usage
Date: Fri, 08 Feb 2013 21:08:39 +0100
Message-ID: <1855338.FfngI2qLCK@skinner.arch.suse.de>
In-Reply-To: <87obfx8115.fsf@xmission.com>
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <5112E30C.50707@zytor.com> <87obfx8115.fsf@xmission.com>
MIME-Version: 1.0
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, yinghai@kernel.org, vgoyal@redhat.com

On Wednesday, February 06, 2013 03:39:50 PM Eric W. Biederman wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
...
> >> My real preference would be to define a command line option that will
> >> work on all architectures that implement kdump, as the craskernel option
> >> does.  Unfortunately it looks like that ship has sailed, and there isn't
> >> enough desire to fix this to come up with a generic option that will
> >> work on more than just x86.  But if we could get past the kernel
> >> versioning and figure out a arch-generic solution it might be worth it.
> > 
> > What would that option look like?
> 
> Probably something like "usemem=<size>@<addr>,..."
If the e820 table approach is taken, x86 would not need any such
parameter at all anymore?
All the memmap= stuff can vanish only the elfcorehdr= param remains.
 
...
> >> The existing e820 handling for unknown type is much much better.  It
> >> just treats them as reserved and goes about it's merry way.
If the new kdump type is treated as reserved and things work out,
I agree that this would be the most elegant approach, especially also
for backporting etc.
In a kernel which has the patch/functionality backported I would do
it like this then:
  - If the special kdump e820 type shows up, all memmap options from
    memmap=exactmap on are ignored and the kexec-tools passed
    e820 table is used just as it is.
    -> This would still allow e820 modifcations through memmap=
    if passed manually for debugging, they just have to show up before
    the kexec-tools generated ones. Anyway, I will also send a patch
    how I think this can be backported and still work with old and new
    kexec-tools versions.

> > It sounds like this is the way to go.
> 
> It certainly looks good.  We still need someone with the time to write
> the patch and test it.

I try to find time for this early next week to code something together and
already give it some testing, but I cannot promise anything.

Thanks everybody for the help to find the best solution,

  Thomas

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
