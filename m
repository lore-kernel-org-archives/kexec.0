Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TP3Nz-00051W-6P
 for kexec@lists.infradead.org; Fri, 19 Oct 2012 03:36:36 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20121018031028.GA3850@localhost.localdomain>
 <1350572194.3894.14.camel@rhapsody>
 <20121018191107.GC18147@redhat.com>
 <1350588121.30243.7.camel@rhapsody>
 <20121018193831.GD18147@redhat.com> <874nlrv2ni.fsf@xmission.com>
 <20121019020630.GA27052@redhat.com>
Date: Thu, 18 Oct 2012 20:36:19 -0700
In-Reply-To: <20121019020630.GA27052@redhat.com> (Vivek Goyal's message of
 "Thu, 18 Oct 2012 22:06:31 -0400")
Message-ID: <877gqnnnf0.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [RFC] Kdump with UEFI secure boot (Re: [PATCH v2] kdump: pass
 acpi_rsdp= to 2nd kernel for efi booting)
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
Cc: kexec@lists.infradead.org, horms@verge.net.au, "H. Peter Anvin" <hpa@zytor.com>, Khalid Aziz <khalid@gonehiking.org>, Dave Young <dyoung@redhat.com>, Matthew Garrett <mjg@redhat.com>

Vivek Goyal <vgoyal@redhat.com> writes:

>> 
>> > I was thinking that how about supporting in kernel bootloader. That is,
>> > kernel acts as a boot loader. User passes the kernel, initrd and
>> > commandline from user space using kexec system call and kernel parses
>> > it and prepares appropriate memory areas ( ex. boot_params, kernel, initramfs,
>> > backup region, elf header region etc). At the time of kexec -e, we just
>> > follow th regular path and jump to second kernel.
>> >
>> > At the time of loading, kernel can verify the signature of incoming
>> > bzImage and reject it if signatures don't match. Matthew mentioned that
>> > kernel signing certificate will be available inside the running kernel,
>> > so verifying PE/COFF bzImage should be easy.
>> 
>> Except that we don't pass the executable file to the kernel.  That
>> approach was nixed in the early review of kexec.
>
> Ok, this is the crux of this discussion. Why was passing executable image
> to kernel was rejected. What's wrong with it? We can pass the executable
> segments but not the executable image? Is it about keeping the file type
> handling code in user space? 

Handling the file formats etc in kernel space in inflexible.

Given that what we load current at no time is exactly what is in the
executable but is the executable plus it's ``arguments'' I have to agree
with that assesment.

In practice we have all kinds of argument passing conventions and those
conventions prevent the kernel from executing another linux kernel
directly, even if we had the other pieces in place.

Not to mention things like the SHA512 checksum that we do to verify the
kdump kernel has not been corrupted.

>>  So we either need to
>> find a way to trust the /sbin/kexec binary
>
> This would be the key. How do we trust /sbin/kexec. We don't have any
> infrastrucutre to sign user space executables. Code for signing modules
> got just in after a long battle. 

There are 3 options for trusting /sbin/kexec.  There are IMA and EMA,
and it is conceivable to have ELF note sections with signatures for
executables.


>> and do the signature
>> verification there on a per file type basis,
>
> This will be possible only if we figure a way out to trust /sbin/kexec
> otherwise trust chain is broken.

Not so.  When loading an executable in general we don't process
relocation entries.  Which means the bits in the file and the bits
actually loaded in memory match.  Since we are passing the bits through
/sbin/kexec if we also pass through the signature bits all should be
well.

Modulo argument passing.

If we can pass in two signed executable blobs we can also perform
trusted argument conversions.

>> or we need to pass an
>> additional signature along with the code (the signature would be encoded
>> with an extra kexec flag and a special purpose segment I expect).
>
> We can possibly pass the signature in separate segment but part of the
> verification process also involves calculating the digest of executable.
> And how digest is calculated depends on file type. For PE/Coff there is
> specific method regarding how to go about digest calculation and what
> area to include and what fields to exclude.
>
> That means for kernel to do signature verification, we shall have to
> pass the full executable to kenrel as it is with PE/COFF headers and
> we are back to original idea of passing executables to kernel.

See above.

>> If we pass the signature to the kernel for verification there are rough
>> bits like how do file formats with relocation entries, the purgatory
>> code, ramdisks, and kernel parameters.
>> 
>> > We don't have to worry about initramfs verification as it runs in 
>> > user space.
>> 
>> Except that we need a way to distinguish the initramfs and other data
>> the part that is signed.
>
> If we are ok with the idea of passing executables and initramfs to
> kernel, then kernel can do the placement. That means fields "mem and
> memsz fields of kexec_segment will be free. We can possibly overload
> memsz field and pass flags to represent segment type. This will happen
> only if user chooses kernel as bootloader functionality.

Which sounds nice initially but I don't think the notion of the kernel
being a general purpose bootloader holds up to well.  It doesn't provide
an easy place to put all of the weird cases.

If we are going to pass in a file it probably makes sense to do a
variation of kexec_load that passes in a file descriptor, a filename
could work but I don't think we want those races.

But then we get how do we pass in a different kernel command line and
an initrd.  Things that were simple start quickly becoming complex.

>> This leaves us with a couple of important questions to answer.
>> - How do we trust /sbin/kexec or how do we avoid the need to trust
>>   /sbin/kexec.
>> - Where is the root of trust located?
>
> I think it is either in UEFI or in kernel.

So for our purposes then it must be in the kernel, because the
implementation must work on all 25+ architectures that linux supports.

>> - How do we verify /sbin/kexec or do we verify /sbin/kexec.
>> - How do we verify the images we load?
>> - How do we separate code/data that needs trust from code/data that
>>   doesn't need trust?
>
> If we agree on passing executable to kernel, then we just need to
> verify only kernel. And we could overload kexec_segment->mem for
> this.

If we are passing in a file I think it calls for a new variant of the
kexec_load system call.

>> - How does the design we pick reduce the amount of code we need to trust?
>> 
>
> I think if we loading in kernel, then we don't have to trust /sbin/kexec
> and problem gets simplified a lot.

I don't see loading in the kernel being a requirement needed for
simplification.

If we are going to have a thing about first class and second class
arguments we are likely going to need to do something to allow the
arguments memorized at boot time to be passed through the kernel
and not read into userspace.  Another kexec flag?

Grumble.  If we didn't support ACPI or firmware callbacks it would be
simpler...

>> None of this is particularly hard but it all needs going through
>> carefully by someone who cares.
>
> I think here crux of the matter is what's wrong with passing kernel
> executable to kernel for loading and verification.

Lack of flexibility, and lack of backward compatibility.  And at this
point complete rearchitecture of kexec.

....

So at this point my recommendation would be:

- Target images where the bits are passed straight through.

- Add support for passing the initial kernels parameters through to the
  kexec'd image.

- Add support for passing the executable image signed signature through
  to the kernel, and the conversion code signed signature through to the
  kernel.

modulo a few implementation details that should allow for preservation
of most of the existing design and flexibility while allowing for signed
images without too much work.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
