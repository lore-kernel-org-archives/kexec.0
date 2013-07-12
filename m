Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2402:b800:7003:1:1::1])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UxS3j-0005mO-Gu
 for kexec@lists.infradead.org; Fri, 12 Jul 2013 01:22:08 +0000
Date: Fri, 12 Jul 2013 11:21:43 +1000
From: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: visible memory seems wrong in kexec crash dump kernel
Message-ID: <20130712012142.GA24112@concordia>
References: <51DF1BBB.5060904@mail.usask.ca> <51DF2229.5010604@mail.usask.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51DF2229.5010604@mail.usask.ca>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Chris Friesen <cbf123@mail.usask.ca>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>

On Thu, Jul 11, 2013 at 03:22:49PM -0600, Chris Friesen wrote:
> On 07/11/2013 02:55 PM, Chris Friesen wrote:
> >Hi,
> >
> >I'm running 2.6.34 with kexec 2.0.1 on a Freescale p5020-based system
> >with 8GB of memory.  (It's an embedded system and I can't do much
> >about the fact that it's using older software.)
> 
> I should probably clarify this...I may be able to update kexec, I
> can't update the kernel but I can backport more recent code if
> necessary.
> 
> Looking at the version of kexec that I have, it seems like where x86
> uses "memmap=" to specify the memory map usable by the capture
> kernel, powerpc does something different.

From memory, it's been years, on powerpc we add properties to the memory
nodes in the device tree that specify which memory is usable. The
properties are called "linux,usable-memory", and in modern kernels they
are read in early_init_dt_scan_memory().

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
