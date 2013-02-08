Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U3uVo-0003TW-KM
 for kexec@lists.infradead.org; Fri, 08 Feb 2013 20:25:33 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <5112E30C.50707@zytor.com> <87obfx8115.fsf@xmission.com>
 <1855338.FfngI2qLCK@skinner.arch.suse.de>
Date: Fri, 08 Feb 2013 12:25:14 -0800
In-Reply-To: <1855338.FfngI2qLCK@skinner.arch.suse.de> (Thomas Renninger's
 message of "Fri, 08 Feb 2013 21:08:39 +0100")
Message-ID: <87txpmv9hx.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Cleanup kdump memmap= passing and e820 usage
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
To: Thomas Renninger <trenn@suse.de>
Cc: x86@kernel.org, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, yinghai@kernel.org, vgoyal@redhat.com

Thomas Renninger <trenn@suse.de> writes:

> On Wednesday, February 06, 2013 03:39:50 PM Eric W. Biederman wrote:
>> "H. Peter Anvin" <hpa@zytor.com> writes:

>> >> The existing e820 handling for unknown type is much much better.  It
>> >> just treats them as reserved and goes about it's merry way.
> If the new kdump type is treated as reserved and things work out,
> I agree that this would be the most elegant approach, especially also
> for backporting etc.

Only kexec-tools needs the functionality so no kernel level backporting
is necessary.

> In a kernel which has the patch/functionality backported I would do
> it like this then:
>   - If the special kdump e820 type shows up, all memmap options from
>     memmap=exactmap on are ignored and the kexec-tools passed
>     e820 table is used just as it is.
>     -> This would still allow e820 modifcations through memmap=
>     if passed manually for debugging, they just have to show up before
>     the kexec-tools generated ones. Anyway, I will also send a patch
>     how I think this can be backported and still work with old and new
>     kexec-tools versions.

Way over complicated.  kexec-tools can just stop passing the memmap=
options entirely for every kernel.

We have not actually identified a use that the kernel would make of the
reserved areas.  Comming up with a new mapping type is just hedging our
bets in case there is a reason we want to know what is actually RAM at
some point in the future.

>> > It sounds like this is the way to go.
>> 
>> It certainly looks good.  We still need someone with the time to write
>> the patch and test it.
>
> I try to find time for this early next week to code something together and
> already give it some testing, but I cannot promise anything.
>
> Thanks everybody for the help to find the best solution,

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
