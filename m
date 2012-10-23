Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TQgly-0006Wr-QO
 for kexec@lists.infradead.org; Tue, 23 Oct 2012 15:52:07 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20121018031028.GA3850@localhost.localdomain>
 <1350572194.3894.14.camel@rhapsody>
 <20121018191107.GC18147@redhat.com>
 <1350588121.30243.7.camel@rhapsody>
 <20121018193831.GD18147@redhat.com> <874nlrv2ni.fsf@xmission.com>
 <20121019020630.GA27052@redhat.com> <877gqnnnf0.fsf@xmission.com>
 <20121019143112.GB27052@redhat.com> <871ugqb4gj.fsf@xmission.com>
 <20121023131854.GA16496@redhat.com>
Date: Tue, 23 Oct 2012 08:51:53 -0700
In-Reply-To: <20121023131854.GA16496@redhat.com> (Vivek Goyal's message of
 "Tue, 23 Oct 2012 09:18:54 -0400")
Message-ID: <87hapl6vae.fsf@xmission.com>
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

> On Mon, Oct 22, 2012 at 02:07:56PM -0700, Eric W. Biederman wrote:
>
> [..]
>> > Can we pass all argument in one kexec segment and let associated image
>> > format handlers parse the arguments.
>> 
>> The issue is can we pass trusted arguments?  Any kind of firmware
>> callback ACPI, EFI, openfirmware etc needs to be in the trusted
>> parameter set so it must come from a trusted location.
>> 
>
> I think parameters will include something like read only one and second
> kernel should be able to verify it. It should not be an executable code
> of any form. (like acpi_rsdp).  I think this is similar to that we don't
> sign/verify kernel command line passed in a bootloader. 

I wasn't talking about the kernel command line.

>> Unless we can trust the /sbin/kexec binary we can't trust pointers
>> to executable code passed to us that we can not verify are safe.
>
> Given the fact we allow user to specify command line, even if we sign
> /sbin/kexec, we have no way to trust it. IMO here we just need to make
> sure that input parameters/arguments can't lead one to execute arbitrary
> code.

The x86 kernel boot protocol specifies a parameter block where the
address of the initrd etc is passed.  If we don't pass the acpi
parameter block via the command line it will come in that parameter
block.  How shrug.

>> >> There are 3 options for trusting /sbin/kexec.  There are IMA and EMA,
>> >> and it is conceivable to have ELF note sections with signatures for
>> >> executables.
>> >
>> > Can you please tell more about what is EMA and IMA. I did quick google
>> > and could not find much.
>> 
>> That should have been EVM and IMA.  Look under security/integrity/.  I
>> don't know much about them but they appear to be security modules with a
>> focus on verifying checksum or perhaps encrypted hashes of executables
>> are consistent.
>
> I will do some quick search there and I see if I can understand something.
>
> [..]
>> It just occurred to me there is a 4th approach we can take that seems
>> interesting.
>> 
>> Have a system call where you pass in a signature of yourself, that will
>> allow you to increase your set of capabilities.  I am a good binary here
>> is proof.  I initially that it might be a complement to sys_kexec_load
>> just for the kexec case but there is no reason to limit it.
>
> If one presents its own signature, then anybody can copy and present
> that signature. There needs to be a mechanism to verify that you 
> actually have the signature you are presenting (i mean digest of
> executable).
>
> So above does not address that how that new system call will verify the
> signature/hash of process invoking system call.

Of course it would.  A signature by it's very definition is a signed
digest.  You can present your own signature and the process that
presents that signature can be verified against the signature.

>> > - What happens to purgatory code. It is unsigned piece of code which
>> >   runs in kernel?
>> 
>> The purgatory code would need to be signed.  Which is why it is
>> important to enable composition of signed pieces of code.
>
> purgatory code is modified dynamically upon every invocation of kexec.
> That means there needs to be a mechanism to sign it after we are done
> with purgatory modification. But there are no signing keys available
> on the system. All the signing happens externally during build time. So
> we don't have the option of signing purgatory at run time.

Hogwash.

The only significant modification we make to purgatory is relocation
processing.  That relocation processing is a convinience, not a
necessity.  Potentially we could move the relocation processing into
purgatory itself.

To making signing work how we process and deal with purgatory would need
to be changed a bit, but fundmanetally signing purgatory or a couple
of specialized versions of purgatory is totally doable.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
