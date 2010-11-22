Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20101122144040.GM31227@n2100.arm.linux.org.uk>
References: <1290161310-22808-1-git-send-email-per.xx.fransson@stericsson.com>
	<20101122072420.GC14080@gw.healthdatacare.com>
	<AANLkTikJiXFG_kGV4=wTKOzViy-h9VtGRHKVBuh76fE2@mail.gmail.com>
	<20101122104740.GA30744@n2100.arm.linux.org.uk>
	<20101122112759.GA31227@n2100.arm.linux.org.uk>
	<AANLkTi=jXuupD+_t663_8haxgB-7Agf7UVcnjBQk+Z-Y@mail.gmail.com>
	<20101122144040.GM31227@n2100.arm.linux.org.uk>
Date: Mon, 22 Nov 2010 18:03:03 +0100
Message-ID: <AANLkTinj5wnP4823bacK6rs3nQbw3qtqDDjYof2-ALUk@mail.gmail.com>
Subject: Re: [PATCH] Add call to non-crashing cores through IPI
From: Per Fransson <per.fransson.ml@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: kexec@lists.infradead.org, Mika Westerberg <mika.westerberg@iki.fi>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

On the other hand, do we really need to enable the interrupts before
performing an ipi?
The important thing must be for them to be enabled on the
receiving/callee cores. It's not
as if we want the crashing core to be interruptable, is it?

I tried it and it seems to work fine.

/Per

On Mon, Nov 22, 2010 at 3:40 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Nov 22, 2010 at 03:31:24PM +0100, Per Fransson wrote:
>> On Mon, Nov 22, 2010 at 12:27 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Mon, Nov 22, 2010 at 10:47:40AM +0000, Russell King - ARM Linux wro=
te:
>> >> However, we do need smp_send_stop() to wait for a limited time for the
>> >> other CPUs to respond to the request.
>> >
>> > ARM: smp: make smp_send_stop() wait for secondary CPUs to stop
>> >
>> > Wait up to one second for secondary CPUs to respond to a request to
>> > stop. =A0This avoids the sender CPU continuing and possibly destroying
>> > state before the recipients have had a chance to respond to the stop.
>> > However, if the recipients have crashed, we won't hang the sender
>> > CPU indefinitely.
>> >
>>
>> The point of the crash kernel functionality is to make it possible to gr=
ab a
>> snapshot of the system at the time of the crash. smp_send_stop() will
>> take the other cores offline, which makes the snapshot differ from the
>> crash state more than it has to. To be more concrete, any core dump
>> analysis tool which reads the cpu_online_mask to determine the number
>> of cpus in use will get an incorrect picture.
>
> Well, you can't go around randomly enabling interrupts to call functions
> that require interrupts to be enabled, so I guess it's not possible to
> save the state of the other cores.
>
> I guess you're going to have to come up with another solution.
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
