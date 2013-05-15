Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UcexS-0005h2-L6
 for kexec@lists.infradead.org; Wed, 15 May 2013 16:53:44 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <CAKw_n9E=Hf0=ao1+tjbarHhQoJUdw70xhTUFaY_s4g3OARpdMg@mail.gmail.com>
 <87k3n1w7a5.fsf@xmission.com>
 <CAKw_n9H99M-5QaNvRdXk6iKSQiChAC60U_f=C_yJGwpb0vFDaA@mail.gmail.com>
 <87sj1pry2u.fsf@xmission.com>
 <CAKw_n9FKo8Uz+pPpC7Qu78H-mE5WJebZ7wJEDK7g6y6=H68yRw@mail.gmail.com>
 <87k3n1rw6e.fsf@xmission.com>
 <CAKw_n9GLaBK8OK61N=PAfFj5Jroog+wMe3OazF731pZicenNog@mail.gmail.com>
Date: Wed, 15 May 2013 09:53:06 -0700
In-Reply-To: <CAKw_n9GLaBK8OK61N=PAfFj5Jroog+wMe3OazF731pZicenNog@mail.gmail.com>
 (Dave Lloyd's message of "Wed, 15 May 2013 10:50:40 -0500")
Message-ID: <87ehd8mbgt.fsf@xmission.com>
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

> On Tue, May 14, 2013 at 6:14 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>
>>
>> Oh. Yeah.  IB definitely sets up memory for ongoing dma.  So if it
>> doesn't have a shutdown method and IB traffic comes in during boot just
>> about anything cood happen.
>>
>>> I'm inclined to chalk the ACPI Error mesages up to potentially buggy
>>> BIOS/hardware from the vendor since pata_amd and pata_acpi are in wide
>>> use and I would expect to see more issues reported were there truly an
>>> issue with rebooting with kexec and not unloading pata_amd and
>>> pata_acpi.
>>
>> Maybe.  Or it might be luck of timing, which memory was stomped when
>> incomming IB packets stomped on memory.
>>
>> Eric
>>
>
> Removing the infiniband drivers in /etc/init.d/halt right before the
> kexec -e definitely seems to have done the trick. Thanks!
>
> My follow up question is, if we are clearing the bus master DMA bit,
> why are the Mellanox not reset or at least stop doing DMA until the
> driver is loaded again? Is this a case of the Mellanox hardware
> needing an extra poke to do the right thing?

Some hardware does not respect the bus master bit.  I assume that Mellanox
has that problem.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
