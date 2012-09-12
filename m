Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TBaxL-0000TR-8C
 for kexec@lists.infradead.org; Wed, 12 Sep 2012 00:37:28 +0000
Date: Wed, 12 Sep 2012 09:37:20 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/7] Add device-tree support to kexec-tools for ARM
Message-ID: <20120912003720.GE26818@verge.net.au>
References: <1347009086-16506-1-git-send-email-matthew.leach@arm.com>
 <20120910000550.GI30480@verge.net.au>
 <20120910085358.GA21650@mudshark.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120910085358.GA21650@mudshark.cambridge.arm.com>
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
To: Will Deacon <will.deacon@arm.com>
Cc: Matthew Leach <Matthew.Leach@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Mon, Sep 10, 2012 at 09:53:58AM +0100, Will Deacon wrote:
> On Mon, Sep 10, 2012 at 01:05:50AM +0100, Simon Horman wrote:
> > On Fri, Sep 07, 2012 at 10:11:19AM +0100, Matthew Leach wrote:
> > > Hi all,
> > > 
> > > Running a kexec() on ARM platforms has become an issue as information
> > > about the platform that is presented via device-tree is required to
> > > boot newer kernels.
> > > 
> > > The ATAGs kernel code is re-used, replacing the ATAGs with a
> > > device-tree blob so that only kexec-tools needs to be changed. There
> > > are two options for generating a dtb to be passed to the kernel from
> > > kexec-tools: 1) Read in the device-tree that is exposed in
> > > /proc/device-tree and flatten this out into a dtb.  2) Allow the user
> > > to specify a dtb file on the command line.  These blobs are then
> > > loaded into memory before the kernel image and the address passed
> > > through to r2, as stated in the ARM booting documentation.
> > > 
> > > These patches depend upon a kernel patch, namely:
> > > http://lists.infradead.org/pipermail/linux-arm-kernel/2012-September/118275.html
> > > 
> > > Simon - you are welcome to add your signed-off-by to my final patch as
> > > I incorporated bits of your final patch into mine.
> > 
> > Sure, I'll add the sign-off as part of merging the changes.
> > 
> > What I have in mind is to to merge the non ppc64/powerpc patches,
> > that is 5 of the 7 patches. I'm a but unsure how the kernel-side of things
> > will pan out, but an incremental patch can be made to kexec-tools
> > if needed and this series shouldn't break any existing support
> > Does that work for you?
> 
> Sounds good to me, I'll pursue the kernel-side changes for ARM.

Thanks. I have pushed the following kexec-tools patches.

* ARM: Add device tree support to the ARM platform
* arm: Make use of memory_ranges
* libfdt: Move from kexec/arch/ppc/libfdt/ to kexec/libfdt/
* kexec-elf.h: Include headers for types used
* fs2dt: Add a generic copy of fs2dt

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
