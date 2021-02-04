Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7Swf-0005Bj-Rv
 for kexec@lists.infradead.org; Thu, 04 Feb 2021 00:56:31 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <CAN_LGv3Go0DgKbjPVHFFXU+U8RRU15m-np3F6_RrVmx6FmBoHQ@mail.gmail.com>
 <20210128052924.GC2339@MiWiFi-R3L-srv>
 <20210203064849.GA11522@dhcp-128-65.nay.redhat.com>
 <CADnq5_MdLTLvVdwFQJxuRaQcQFNkLUNRt267zaxULNH0FUvFeA@mail.gmail.com>
Date: Wed, 03 Feb 2021 18:54:41 -0600
In-Reply-To: <CADnq5_MdLTLvVdwFQJxuRaQcQFNkLUNRt267zaxULNH0FUvFeA@mail.gmail.com>
 (Alex Deucher's message of "Wed, 3 Feb 2021 09:46:56 -0500")
Message-ID: <87wnvoodny.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: amdgpu problem after kexec
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
To: Alex Deucher <alexdeucher@gmail.com>
Cc: kexec@lists.infradead.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, Dave Young <dyoung@redhat.com>, "Alexander E. Patrakov" <patrakov@gmail.com>, Baoquan He <bhe@redhat.com>

Alex Deucher <alexdeucher@gmail.com> writes:

> On Wed, Feb 3, 2021 at 3:36 AM Dave Young <dyoung@redhat.com> wrote:
>>
>> Hi Baoquan,
>>
>> Thanks for ccing.
>> On 01/28/21 at 01:29pm, Baoquan He wrote:
>> > On 01/11/21 at 01:17pm, Alexander E. Patrakov wrote:
>> > > Hello,
>> > >
>> > > I was trying out kexec on my new laptop, which is a HP EliteBook 735
>> > > G6. The problem is, amdgpu does not have hardware acceleration after
>> > > kexec. Also, strangely, the lines about BlueTooth are missing from
>> > > dmesg after kexec, but I have not tried to use BlueTooth on this
>> > > laptop yet. I don't know how to debug this, the relevant amdgpu lines
>> > > in dmesg are:
>> > >
>> > > amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB
>> > > test failed on gfx (-110).
>> > > [drm:process_one_work] *ERROR* ib ring test failed (-110).
>> > >
>> > > The good and bad dmesg files are attached. Is it a kexec problem (and
>> > > amdgpu is only a victim), or should I take it to amdgpu lists? Do I
>> > > need to provide some extra kernel arguments for debugging?

The best debugging I can think of is can you arrange to have the amdgpu
modules removed before the final kexec -e?

That would tell us if the code to shutdown the gpu exist in the rmmod
path aka the .remove method and is simply missing in the kexec path aka
the .shutdown method.


>> > I am not familiar with graphical component. Add Dave to CC to see if
>> > he has some comments. It would be great if amdgpu expert can have a look.
>>
>> It needs amdgpu driver people to help.  Since kexec bypass
>> bios/UEFI initialization so we requires drivers to implement .shutdown
>> method and test it to make 2nd kernel to work correctly.
>
> kexec is tricky to make work properly on our GPUs.  The problem is
> that there are some engines on the GPU that cannot be re-initialized
> once they have been initialized without an intervening device reset.
> APUs are even trickier because they share a lot of hardware state with
> the CPU.  Doing lots of extra resets adds latency.  The driver has
> code to try and detect if certain engines are running at driver load
> time and do a reset before initialization to make this work, but it
> apparently is not working properly on your system.

There are two cases that I think sometimes get mixed up.

There is kexec-on-panic in which case all of the work needs to happen in
the driver initialization.

There is also a simple kexec in which case some of the work can happen
in the kernel that is being shutdown and sometimes that is easer.

Does it make sense to reset your device unconditionally on driver removal?
Would it make sense to reset your device unconditionally on driver add?

How can someone debug the smart logic of reset on driver load?

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
