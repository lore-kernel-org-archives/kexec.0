Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NyLwA-00078x-HJ
	for kexec@lists.infradead.org; Sun, 04 Apr 2010 09:16:11 +0000
Subject: Re: [PATCH 3/4] Revert "x86: disable IOMMUs on kernel crash"
References: <20100403012751.834020949@sous-sol.org>
	<20100403012820.229410717@sous-sol.org>
	<20100403172224.GO24846@8bytes.org> <m18w94l9c9.fsf@fess.ebiederm.org>
	<20100404084435.GT24846@8bytes.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 04 Apr 2010 02:16:00 -0700
In-Reply-To: <20100404084435.GT24846@8bytes.org> (Joerg Roedel's message of
	"Sun\, 4 Apr 2010 10\:44\:36 +0200")
Message-ID: <m1fx3befxr.fsf@fess.ebiederm.org>
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
To: Joerg Roedel <joro@8bytes.org>
Cc: nhorman@redhat.com, nhorman@tuxdriver.com, Joerg Roedel <joerg.roedel@amd.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, vgoyal@redhat.com

Joerg Roedel <joro@8bytes.org> writes:

> On Sat, Apr 03, 2010 at 10:44:22AM -0700, Eric W. Biederman wrote:
>> Joerg Roedel <joro@8bytes.org> writes:
>
>> > Hmm, I think for this we need to change the gart code too and disable
>> > the gart before its initialization runs to not re-introduce issues fixed
>> > in commit bc2cea6a34fdb30f118ec75db39a46a191870607, no?
>> 
>> That is a different code path with a different set of assumptions and
>> restrictions.  On a normal kexec of course we want to do an orderly shutdown.
>
> Thats another problem with this patch. It introduces a difference
> between the panic-shutdown kexec and the ordinary kexec.

Of course there is.  kexec on panic does no shutdown, and should not.
That is fundamental.  That is documented.

This make them symmetric crap is a bad idea, because we can not reliably
do it.  999 times out of 1000 we can actually handle everything we
need to in the kdump kernel in the initialization path and when
we succeed it makes linux much more robust.

>> For the gart with a little luck we can just ignore it on kexec on
>> panic.
>
> The commit I mentioned above already proves this assumption wrong.

Now that I look at that commit again I am stunned.  That commit
already says it is doing things wrong.  

What I meant by ignore it is that we should be able to not use it.

>> Unlike a virtualization capable iommu it doesn't prevent access
>> to devices, when it is enabled.   Worst case is that we have to start
>> including iommu=off for gart systems.
>
> No no no. This is a maintenance nightmare for almost everybody. Where do
> you want to Document this special cases that 'if kernel uses gart then
> and only then boot the kexec kernel with iommu=off'.
> Always passing iommu=off to the kexec kernel doesn't work too for
> obvious reasons.

I agree.  I would like to see something better, but the situation
with the current set of patches is workable.  Getting autodetection
in there an automatically doing the right thing would be much better.

Do you happen to have a patch you would like to submit to handle this?

>> The best case is that we can figure out how to have the gart code
>> reinitialize itself sanely, starting from some arbitrary point.
>
> Yes, that is missing in this patch. But to keep changes small and don't
> bother with the gart code at all I suggest to remove the shutdown
> routine from the amd-iommu code only and not the whole shutdown call in
> the machine_crash_shutdown path.

Which will only encourage further abuse of that code path.  The reliability
has been continually decreasing lately and I believe this is one of those
reasons.  The hpet junk in there appears to be an even bigger reason.

I have machines right now that can not reliably crash dump because
someone tried papering over problems by putting code in the
machine_crash_shutdown path which must have worked for their test cast
but does not work for real world failures, and right now I am very
grumpy about it all.

I guess what I am saying is that I do not believe shutting down the
gart in machine_crash_shutdown actually works.  It is definitely not
the right place to do that work.  So I don't see why we should keep
any of that code there.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
