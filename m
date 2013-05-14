Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UcNnK-0002OG-Ff
 for kexec@lists.infradead.org; Tue, 14 May 2013 22:34:07 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <CAKw_n9E=Hf0=ao1+tjbarHhQoJUdw70xhTUFaY_s4g3OARpdMg@mail.gmail.com>
 <87k3n1w7a5.fsf@xmission.com>
 <CAKw_n9H99M-5QaNvRdXk6iKSQiChAC60U_f=C_yJGwpb0vFDaA@mail.gmail.com>
Date: Tue, 14 May 2013 15:33:29 -0700
In-Reply-To: <CAKw_n9H99M-5QaNvRdXk6iKSQiChAC60U_f=C_yJGwpb0vFDaA@mail.gmail.com>
 (Dave Lloyd's message of "Tue, 14 May 2013 17:25:26 -0500")
Message-ID: <87sj1pry2u.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: Kernel panics when using kexec for rebooting
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
To: Dave Lloyd <dave@davelloyd.com>
Cc: kexec@lists.infradead.org

Dave Lloyd <dave@davelloyd.com> writes:

> On Tue, May 14, 2013 at 5:01 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>
>>
>> Yes this does seem to be all over the place, and memory corruption
>> probably caused by ongoing-dma seems like a reasonable hypothesis.
>
> Thank goodness it's not just me! :-)

It is a classic issue, although I suspect something is unique in your
setup because it has (to my knowledge) not been a widespread problem for
years.

>> The easy first thing to try is to remove all of your kernel modules
>> before you reboot with kexec.  Not infrequently the module remove path
>> is better tested than the device shutdown path.
>
> I'm trying this now. In one panic, the pte referenced was
> 0x100010000000000 which sure looks a whole like someone wrote his
> registers in there. It certainly doesn't look like a valid pte.
>
> So far, unloading pata_acpi and pata_amd seem to have eliminated the
> ACPI exception messages. I believe that this resets the device
> properly. Unfortunately, it looks like lots of drivers don't implement
> the pci_driver->shutdown call, so it would make sense that this is a
> relatively widespread problem.

Most devices don't leave dma setup if you reboot, and even more the
generic pci clears the bus master DMA bit which shuts down a lot more
dma.

So the actual lack of a shutdown method is not as much of an issue as it
might appear.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
