Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-da0-x230.google.com ([2607:f8b0:400e:c00::230])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UcOAG-0002h7-5g
 for kexec@lists.infradead.org; Tue, 14 May 2013 22:57:49 +0000
Received: by mail-da0-f48.google.com with SMTP id h32so580842dak.21
 for <kexec@lists.infradead.org>; Tue, 14 May 2013 15:57:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87sj1pry2u.fsf@xmission.com>
References: <CAKw_n9E=Hf0=ao1+tjbarHhQoJUdw70xhTUFaY_s4g3OARpdMg@mail.gmail.com>
 <87k3n1w7a5.fsf@xmission.com>
 <CAKw_n9H99M-5QaNvRdXk6iKSQiChAC60U_f=C_yJGwpb0vFDaA@mail.gmail.com>
 <87sj1pry2u.fsf@xmission.com>
Date: Tue, 14 May 2013 17:57:26 -0500
Message-ID: <CAKw_n9FKo8Uz+pPpC7Qu78H-mE5WJebZ7wJEDK7g6y6=H68yRw@mail.gmail.com>
Subject: Re: Kernel panics when using kexec for rebooting
From: Dave Lloyd <dave@davelloyd.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org

On Tue, May 14, 2013 at 5:33 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Dave Lloyd <dave@davelloyd.com> writes:
>
>> On Tue, May 14, 2013 at 5:01 PM, Eric W. Biederman
>> <ebiederm@xmission.com> wrote:
>>
>>>
>>> Yes this does seem to be all over the place, and memory corruption
>>> probably caused by ongoing-dma seems like a reasonable hypothesis.
>>
>> Thank goodness it's not just me! :-)
>
> It is a classic issue, although I suspect something is unique in your
> setup because it has (to my knowledge) not been a widespread problem for
> years.

It could certainly be buggy hardware. Other details include:

Kernel 3.0.29.0 and we are also using infiniband (which I believe I
found a reference to the Mellanox hardware potentially causing this
issue unless the driver was unloaded before reboot with kexec). The
potential issue with unloading the IB drivers doesn't bug me nearly as
much as not unloading pata_amd and pata_acpi causing the ACPI Error
messages upon reboot with kexec.

I'm inclined to chalk the ACPI Error mesages up to potentially buggy
BIOS/hardware from the vendor since pata_amd and pata_acpi are in wide
use and I would expect to see more issues reported were there truly an
issue with rebooting with kexec and not unloading pata_amd and
pata_acpi.

>>> The easy first thing to try is to remove all of your kernel modules
>>> before you reboot with kexec.  Not infrequently the module remove path
>>> is better tested than the device shutdown path.
>>
>> I'm trying this now. In one panic, the pte referenced was
>> 0x100010000000000 which sure looks a whole like someone wrote his
>> registers in there. It certainly doesn't look like a valid pte.
>>
>> So far, unloading pata_acpi and pata_amd seem to have eliminated the
>> ACPI exception messages. I believe that this resets the device
>> properly. Unfortunately, it looks like lots of drivers don't implement
>> the pci_driver->shutdown call, so it would make sense that this is a
>> relatively widespread problem.
>
> Most devices don't leave dma setup if you reboot, and even more the
> generic pci clears the bus master DMA bit which shuts down a lot more
> dma.
>
> So the actual lack of a shutdown method is not as much of an issue as it
> might appear.

Interesting. Thanks for the information. I have to admit, this part of
the kernel is a bit of a mystery to me.

--dlloyd

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
