Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UcOR4-0002uJ-VY
 for kexec@lists.infradead.org; Tue, 14 May 2013 23:15:12 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <CAKw_n9E=Hf0=ao1+tjbarHhQoJUdw70xhTUFaY_s4g3OARpdMg@mail.gmail.com>
 <87k3n1w7a5.fsf@xmission.com>
 <CAKw_n9H99M-5QaNvRdXk6iKSQiChAC60U_f=C_yJGwpb0vFDaA@mail.gmail.com>
 <87sj1pry2u.fsf@xmission.com>
 <CAKw_n9FKo8Uz+pPpC7Qu78H-mE5WJebZ7wJEDK7g6y6=H68yRw@mail.gmail.com>
Date: Tue, 14 May 2013 16:14:33 -0700
In-Reply-To: <CAKw_n9FKo8Uz+pPpC7Qu78H-mE5WJebZ7wJEDK7g6y6=H68yRw@mail.gmail.com>
 (Dave Lloyd's message of "Tue, 14 May 2013 17:57:26 -0500")
Message-ID: <87k3n1rw6e.fsf@xmission.com>
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

> On Tue, May 14, 2013 at 5:33 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> Dave Lloyd <dave@davelloyd.com> writes:
>>
>>> On Tue, May 14, 2013 at 5:01 PM, Eric W. Biederman
>>> <ebiederm@xmission.com> wrote:
>>>
>>>>
>>>> Yes this does seem to be all over the place, and memory corruption
>>>> probably caused by ongoing-dma seems like a reasonable hypothesis.
>>>
>>> Thank goodness it's not just me! :-)
>>
>> It is a classic issue, although I suspect something is unique in your
>> setup because it has (to my knowledge) not been a widespread problem for
>> years.
>
> It could certainly be buggy hardware. Other details include:
>
> Kernel 3.0.29.0 and we are also using infiniband (which I believe I
> found a reference to the Mellanox hardware potentially causing this
> issue unless the driver was unloaded before reboot with kexec). The
> potential issue with unloading the IB drivers doesn't bug me nearly as
> much as not unloading pata_amd and pata_acpi causing the ACPI Error
> messages upon reboot with kexec.

Oh. Yeah.  IB definitely sets up memory for ongoing dma.  So if it
doesn't have a shutdown method and IB traffic comes in during boot just
about anything cood happen.

> I'm inclined to chalk the ACPI Error mesages up to potentially buggy
> BIOS/hardware from the vendor since pata_amd and pata_acpi are in wide
> use and I would expect to see more issues reported were there truly an
> issue with rebooting with kexec and not unloading pata_amd and
> pata_acpi.

Maybe.  Or it might be luck of timing, which memory was stomped when
incomming IB packets stomped on memory.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
