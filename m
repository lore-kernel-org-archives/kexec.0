Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hZIh3-00027c-MT
 for kexec@lists.infradead.org; Fri, 07 Jun 2019 17:30:23 +0000
Date: Fri, 7 Jun 2019 19:30:16 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190607173016.GM20269@zn.tnic>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
 <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
 <20190128095809.GC3732@dhcp-128-65.nay.redhat.com>
 <20190128101831.GA27154@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190128101831.GA27154@zn.tnic>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>, Pingfan Liu <kernelfans@gmail.com>
Cc: x86@kernel.org, Baoquan He <bhe@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org, vgoyal@redhat.com

On Mon, Jan 28, 2019 at 11:18:31AM +0100, Borislav Petkov wrote:
> On Mon, Jan 28, 2019 at 05:58:09PM +0800, Dave Young wrote:
> > Another reason is in case ,high we will need automatically reserve a
> > region in low area for swiotlb.  So for example one use
> > crashkernel=256M,high,  actual reserved memory is 256M above 4G and
> > another 256M under 4G for swiotlb.  Normally it is not necessary for
> > most people.  Thus we can not make ,high as default.
> 
> And how is the poor user to figure out that we decided for her/him that
> swiotlb reservation is something not necessary for most people and thus
> we fail the crashkernel= reservation?
> 
> IOW, that "logic" above doesn't make a whole lot of sense to me from
> user friendliness perspective.

So to show what I mean: I'm trying to reserve a crash kernel region on a
box here. I tried:

crashkernel=64M@16M

as it is stated in Documentation/kdump/kdump.txt.

Box said:

[    0.000000] crashkernel reservation failed - memory is in use.

Oh great.

Then I tried:

crashkernel=64M@64M

Box said:

[    0.000000] crashkernel reservation failed - memory is in use.

So I simply did:

crashkernel=64M

and the box said:

[    0.000000] Reserving 64MB of memory at 3392MB for crashkernel (System RAM: 16271MB)

So I could've gone a long time poking at the memory to find a suitable
address.

So do you see what I mean with making this as user-friendly and as
robust as possible?

In this case I don't care about *where* my crash kernel is - I only want
to have one loaded *somewhere*.

And the same strategy should be applied to other reservation attempts
- we should try hard to reserve and if we cannot reserve, then try an
alternating range.

I even think that

crashkernel=X@Y

should not simply fail if Y is occupied but keep trying and say

[    0.000000] Reserving 64MB of memory at alternative address 3392MB for crashkernel (System RAM: 16271MB)

and only fail when the user doesn't really want the kernel to try hard
by booting with

crashkernel=X@Y,strict

But that's for another day.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
