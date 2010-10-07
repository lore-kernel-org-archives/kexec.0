Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga03.intel.com ([143.182.124.21])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1P3vbu-0007k5-9u
	for kexec@lists.infradead.org; Thu, 07 Oct 2010 18:54:35 +0000
Message-ID: <4CAE1767.5040409@intel.com>
Date: Thu, 07 Oct 2010 11:54:31 -0700
From: "H. Peter Anvin" <h.peter.anvin@intel.com>
MIME-Version: 1.0
Subject: Re: [tip:core/memblock] x86, memblock: Fix crashkernel allocation
References: <4CABAF2A.5090501@kernel.org>
	<tip-9f4c13964b58608fbce05540743281ea3146c0e8@git.kernel.org>
	<20101006151449.GA7378@redhat.com> <4CACF531.2060407@intel.com>
	<20101006224704.GD7378@redhat.com> <4CAD01A9.9050907@intel.com>
	<20101007181804.GE23308@redhat.com>
In-Reply-To: <20101007181804.GE23308@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "caiqian@redhat.com" <caiqian@redhat.com>, "linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "yinghai@kernel.org" <yinghai@kernel.org>

On 10/07/2010 11:18 AM, Vivek Goyal wrote:
> 
> Ok, I was browsing through kexec-tools, x86 bzImage code and trying to
> refresh my memory what segments were being loaded and what were memory
> address concerns.
> 
> - relocatable bzImage (max addr 0x37ffffff, 896MB). 
> 	Though I don't know/understand where that 896MB come from.
> 
> - initrd (max addr 0x37ffffff, 896MB)
> 	Don't know why 896MB as upper limit

896 MB is presumably the (default!!) LOWMEM limit on 32 bits.  This is
actually wrong if vmalloc= is also specified on command line, though, or
with nonstandard compile-time options.

> - Purgatory (max addr 2G)
> 
> - A segment to keep elf headers (no limit)
> 	These are accessed when second kernel as fully booted so can be
> 	addressed in higher addresses.
> 
> - A backup segment to copy first 640K of memory (not aware of any limit)
> - Setup/parameter segment (no limit)
> 	- We don't really execute anything here and just access it for
>   	  command line.

Probably has a 4 GB limit, since I believe it only has a 32-bit pointer.

> So atleast for bzImage it looks that if we specify crashkernel=128M<896M, it
> will work.
> 
> So I am fine with above additional syntax for crashkernel=. May be we shall
> have to the deprecate the crashkernel=X<@0 syntax.
> 
> CCing kexec list, in case others have any comments.

It would be easy enough to either deprecate or make it an alias for
crashkernel=...<896M, which is basically what Yinghai's patch does.

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
