Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XKtQl-00010K-7X
 for kexec@lists.infradead.org; Fri, 22 Aug 2014 18:19:20 +0000
Date: Fri, 22 Aug 2014 14:18:55 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Kexec failing in handle_relocations() (Was: Re: kexec fails to boot
 kernels where CONFIG_RANDOMIZE_BASE=y is set)
Message-ID: <20140822181855.GJ5954@redhat.com>
References: <53F11882.3060803@whissi.de> <20140818145718.GD4745@redhat.com>
 <20140819090724.GB21724@dhcp-17-37.nay.redhat.com>
 <20140820143315.GC16303@redhat.com>
 <CAGXu5jLxEoKEy0nw8qj0MW0f2Vpog-DtDi7OwnUrkh7jGSkdWw@mail.gmail.com>
 <20140821181000.GB21891@redhat.com>
 <20140821190226.GE21891@redhat.com> <53F64815.8010206@whissi.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53F64815.8010206@whissi.de>
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
To: "Thomas D." <whissi@whissi.de>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, Kees Cook <keescook@chromium.org>, WANG Chao <chaowang@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

On Thu, Aug 21, 2014 at 09:27:17PM +0200, Thomas D. wrote:
> Hi,
> 
> Vivek Goyal wrote:
> > Thomas, can you please test kexec with "nokaslr" specified in command
> > line. This can atleast get you going for now till the problem is actually
> > fixed.
> 
> I booted linux-3.15.10 with "nokaslr"
> 
> >  # dmesg | grep -i command
> > [    0.000000] Command line: BOOT_IMAGE=/kernel dolvm video=1280x1024 root=UUID=6d42... rootfs=ext4 nokaslr initrd=/initramfs
> > [    0.000000] Kernel command line: BOOT_IMAGE=/kernel dolvm video=1280x1024 root=UUID=6d42... rootfs=ext4 nokaslr initrd=/initramfs
> 
> and run kexec with
> 
> > --reuse-cmdline -l /boot/kernel root=/dev/dm-3  --initrd=/boot/initramfs
> 
> But it still doesn't reboot. I see no difference between using "nokaslr"
> or not.

[ CC hpa ]

I think handle_relocations() is contributing to the problem here.

I enabled earlyprintk and enabled debug boot messages. I also put some
debug messages of my own to print values of some variables and I see
following when I try to kexec.

**********************************************************************
[  340.709078] kexec: Starting new kernel
early console in decompress_kernel
KASLR disabled by default...

Decompressing Linux... Parsing ELF...

min_addr=000000042e000000
delta=000000042d000000
Performing relocations...
map=00000004ad000000

32-bit relocation outside of kernel!


 -- System halted
*****************************************************************

So min_addr is the location where kernel is actually being loaded and
will be run from. delta is the difference between compile time address
and run time address. 

KASLR is disabled by default. I am wondering that why do we have to
go through handle_relocations() if KASLR is disabled. Should we fall
back to old logic of manipulating page tables.

Or we need to figure out how to make handle_relocations() work in such
a way that kernel can be loaded anywhere in the memory. 

I suspect that 32bit relocations might not be able to handle it and
we probably might need all 64bit relocations to handle that case. But
with this resulting virtual addresses might still be the problem.

I summary, I am wondering what kind of limitation handle_relocations()
put on physical location of kernel and how can we remove that restriction
to be able to load kernel anywhere in memory.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
