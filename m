Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TPDba-0006f0-0k
 for kexec@lists.infradead.org; Fri, 19 Oct 2012 14:31:19 +0000
Date: Fri, 19 Oct 2012 10:31:12 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC] Kdump with UEFI secure boot (Re: [PATCH v2] kdump: pass
 acpi_rsdp= to 2nd kernel for efi booting)
Message-ID: <20121019143112.GB27052@redhat.com>
References: <20121018031028.GA3850@localhost.localdomain>
 <1350572194.3894.14.camel@rhapsody>
 <20121018191107.GC18147@redhat.com>
 <1350588121.30243.7.camel@rhapsody>
 <20121018193831.GD18147@redhat.com> <874nlrv2ni.fsf@xmission.com>
 <20121019020630.GA27052@redhat.com> <877gqnnnf0.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <877gqnnnf0.fsf@xmission.com>
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
Cc: kexec@lists.infradead.org, horms@verge.net.au, "H. Peter Anvin" <hpa@zytor.com>, Khalid Aziz <khalid@gonehiking.org>, Dave Young <dyoung@redhat.com>, Matthew Garrett <mjg@redhat.com>

On Thu, Oct 18, 2012 at 08:36:19PM -0700, Eric W. Biederman wrote:

[..]
> Handling the file formats etc in kernel space in inflexible.
> 
> Given that what we load current at no time is exactly what is in the
> executable but is the executable plus it's ``arguments'' I have to agree
> with that assesment.
> 
> In practice we have all kinds of argument passing conventions and those
> conventions prevent the kernel from executing another linux kernel
> directly, even if we had the other pieces in place.

Can we pass all argument in one kexec segment and let associated image
format handlers parse the arguments. 

> 
> Not to mention things like the SHA512 checksum that we do to verify the
> kdump kernel has not been corrupted.

As we will be preparing all the segments intenally and also preparing
the purgatory(or equivalent) in kernel, we can alaways calculate the
checksum in kernel tool IOW, there is no reason that why can't we do
existing verifications in kernel.

> 
> >>  So we either need to
> >> find a way to trust the /sbin/kexec binary
> >
> > This would be the key. How do we trust /sbin/kexec. We don't have any
> > infrastrucutre to sign user space executables. Code for signing modules
> > got just in after a long battle. 
> 
> There are 3 options for trusting /sbin/kexec.  There are IMA and EMA,
> and it is conceivable to have ELF note sections with signatures for
> executables.

Can you please tell more about what is EMA and IMA. I did quick google
and could not find much.

Adding signatures to ELF should be possible. I guess this is similar
to signed PE/COFF images. Just that convention changes that how images
are signed and where exactly signatures are stored.

I do see some references to elfsign and elfverify during search. Have
not dived in to figure out what exactly they are.

I think bigger issue here is that creating that generic system of signing
user space executables and kernel verifying it. Then we end up creating
even more complicated and more locked down system.

> 
> 
> >> and do the signature
> >> verification there on a per file type basis,
> >
> > This will be possible only if we figure a way out to trust /sbin/kexec
> > otherwise trust chain is broken.
> 
> Not so.  When loading an executable in general we don't process
> relocation entries.  Which means the bits in the file and the bits
> actually loaded in memory match.  Since we are passing the bits through
> /sbin/kexec if we also pass through the signature bits all should be
> well.

So are you saying that let /sbin/kexec still load all the segments. It
will also load the attached signatures/certificates in a separate
segment and kernel can calculate hash and do verification? If yes,
few issues. here.

- What happens to purgatory code. It is unsigned piece of code which
  runs in kernel?

If you meant something else, can you please explain a bit more.

> 
> Modulo argument passing.
> 
> If we can pass in two signed executable blobs we can also perform
> trusted argument conversions.

Again lost here. Which two executable blobs you are referring to. One
is signed kernel executable, which is other one.

[..]
> > If we are ok with the idea of passing executables and initramfs to
> > kernel, then kernel can do the placement. That means fields "mem and
> > memsz fields of kexec_segment will be free. We can possibly overload
> > memsz field and pass flags to represent segment type. This will happen
> > only if user chooses kernel as bootloader functionality.
> 
> Which sounds nice initially but I don't think the notion of the kernel
> being a general purpose bootloader holds up to well.  It doesn't provide
> an easy place to put all of the weird cases.
> 
> If we are going to pass in a file it probably makes sense to do a
> variation of kexec_load that passes in a file descriptor, a filename
> could work but I don't think we want those races.
> 
> But then we get how do we pass in a different kernel command line and
> an initrd.  Things that were simple start quickly becoming complex.

Expecting three segments as input. Kernel executable, initrd and one
segment which contains all arguemnts (separated by new line) including
command line. Will that be generic enough to cover all kind of cases?

[..]
> So at this point my recommendation would be:
> 
> - Target images where the bits are passed straight through.
> 
> - Add support for passing the initial kernels parameters through to the
>   kexec'd image.
> 
> - Add support for passing the executable image signed signature through
>   to the kernel, and the conversion code signed signature through to the
>   kernel.

What is conversion code here? Are you referring to /sbin/kexec here which
breaks down kernel executables into segments? If yes, are you saying that
sign /sbin/kexec and pass its signature along with kernel signature?

But that does not help as any program can get the signature of /sbin/kexec
and pass it to kernel as its own signatures. 

I might be completely into weeds here. So little elaboration will help
me understand your ideas better.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
