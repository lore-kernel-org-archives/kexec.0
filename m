Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22d.google.com ([2607:f8b0:400e:c03::22d])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bJu6N-0005KI-St
 for kexec@lists.infradead.org; Mon, 04 Jul 2016 02:59:17 +0000
Received: by mail-pa0-x22d.google.com with SMTP id zl15so14221871pab.3
 for <kexec@lists.infradead.org>; Sun, 03 Jul 2016 19:58:55 -0700 (PDT)
Date: Mon, 4 Jul 2016 12:04:14 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v20 13/14] arm64: kdump: update a kernel doc
Message-ID: <20160704030413.GN20774@linaro.org>
References: <cover.1466702804.git.geoff@infradead.org>
 <ef07d5dafe5c69b621dc4ec01ef1c6f3f9753e60.1466702804.git.geoff@infradead.org>
 <20160630090045.GA16958@x1.redhat.com>
 <20160701073707.GM20774@linaro.org>
 <20160701074505.GB10467@x1.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160701074505.GB10467@x1.redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, marc.zyngier@arm.com, James Morse <james.morse@arm.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Baoquan,

On Fri, Jul 01, 2016 at 03:45:05PM +0800, Baoquan He wrote:
> On 07/01/16 at 04:37pm, AKASHI Takahiro wrote:
> > Dave, Boaquan,
> > 
> > Thank you for your reviewing.
> > 
> > On Thu, Jun 30, 2016 at 05:00:45PM +0800, Baoquan He wrote:
> > > On 06/23/16 at 05:54pm, Geoff Levand wrote:
> > > > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > 
> > > > This patch adds arch specific descriptions about kdump usage on arm64
> > > > to kdump.txt.
> > > > 
> > > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > ---
> > > >  Documentation/kdump/kdump.txt | 15 ++++++++++++++-
> > > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
> > > > index 88ff63d..5d6da09 100644
> > > > --- a/Documentation/kdump/kdump.txt
> > > > +++ b/Documentation/kdump/kdump.txt
> > > > @@ -18,7 +18,7 @@ memory image to a dump file on the local disk, or across the network to
> > > >  a remote system.
> > > >  
> > > >  Kdump and kexec are currently supported on the x86, x86_64, ppc64, ia64,
> > > > -s390x and arm architectures.
> > > > +s390x, arm and arm64 architectures.
> > > >  
> > > >  When the system kernel boots, it reserves a small section of memory for
> > > >  the dump-capture kernel. This ensures that ongoing Direct Memory Access
> > > > @@ -249,6 +249,12 @@ Dump-capture kernel config options (Arch Dependent, arm)
> > > >  
> > > >      AUTO_ZRELADDR=y
> > > >  
> > > > +Dump-capture kernel config options (Arch Dependent, arm64)
> > > > +----------------------------------------------------------
> > > > +
> > > > +1) Currently, kvm will not be enabled on the dump-capture kernel even
> > > > +   if it is configured.
> 
> And here, could you say more about it?

On non-VHE (Virtualization Host Environment) system, the kernel, which
normally runs in EL1 mode, must be started in EL2 mode to enable kvm, but
the current code uses cpu pm notifier to reset CPU state to EL2 and
we have no chance to do that on panic.

I will clarify this in kdump.txt.

> > > > +
> > > >  Extended crashkernel syntax
> > > >  ===========================
> > > >  
> > > > @@ -305,6 +311,8 @@ Boot into System Kernel
> > > >     kernel will automatically locate the crash kernel image within the
> > > >     first 512MB of RAM if X is not given.
> > > >  
> > > > +   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
> > > 				  ~ Why square brackets here, is it
> > > different than other arch?
> > 
> > I want to clearly indicate that "@X" is optional, and that, when you explicitly
> > specify it, X must be properly aligned.
> > I think that "[..]" notation is quite common.
> 
> Yes, I see that. Just that has been noted in "Extended crashkernel
> syntax" section, and adding "[]" is not consistent with other places
> where "crashkernel=Y@X" is referred to in this section. Just feel it's
> a little redundent. Anyway it's not very critical, and Dave has acked
> it, I am fine if you want to keep it.

Thanks,
-Takahiro AKASHI

> Thanks
> Baoquan
> 
> > 
> > Thanks,
> > -Takahiro AKASHI
> > 
> > > 
> > > Except for this, it looks good to me.
> > > 
> > > Thanks
> > > Baoquan
> > > 
> > > > +   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
> > > >  
> > > >  Load the Dump-capture Kernel
> > > >  ============================
> > > > @@ -327,6 +335,8 @@ For s390x:
> > > >  	- Use image or bzImage
> > > >  For arm:
> > > >  	- Use zImage
> > > > +For arm64:
> > > > +	- Use vmlinux or Image
> > > >  
> > > >  If you are using a uncompressed vmlinux image then use following command
> > > >  to load dump-capture kernel.
> > > > @@ -370,6 +380,9 @@ For s390x:
> > > >  For arm:
> > > >  	"1 maxcpus=1 reset_devices"
> > > >  
> > > > +For arm64:
> > > > +	"1 maxcpus=1 reset_devices"
> > > > +
> > > >  Notes on loading the dump-capture kernel:
> > > >  
> > > >  * By default, the ELF headers are stored in ELF64 format to support
> > > > -- 
> > > > 2.5.0
> > > > 
> > > > 
> > > > 
> > > > _______________________________________________
> > > > kexec mailing list
> > > > kexec@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
