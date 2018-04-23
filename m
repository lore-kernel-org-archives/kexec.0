Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fAYrd-000181-4p
 for kexec@lists.infradead.org; Mon, 23 Apr 2018 10:38:31 +0000
Received: by mail-lf0-f65.google.com with SMTP id z130-v6so14202096lff.5
 for <kexec@lists.infradead.org>; Mon, 23 Apr 2018 03:38:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180417051706.GA5894@dhcp-128-65.nay.redhat.com>
References: <1521455739-8022-1-git-send-email-bhsharma@redhat.com>
 <20180319144529.vkfrrkc4bdhwvvbi@dragonfly>
 <CACi5LpObqAJ=yC_e2G80JsspfzEx50Rq=J2G_UAnoT3UqS4HFQ@mail.gmail.com>
 <CACi5LpPVbVZBAXynMQ79kkboLrQcw1s-LSuFkSQAnkXtdS8wAA@mail.gmail.com>
 <20180326123038.GA14737@linaro.org>
 <e5ed1c04-73db-fda5-602d-f9bd447801da@arm.com>
 <CACi5LpN3bV6-TjAkbu9eGdSUfn-pCoEY==Z1qC5VzOZDdnw0-g@mail.gmail.com>
 <20180416081325.GA4074@dhcp-128-65.nay.redhat.com>
 <CACi5LpOq-JYFTsVsmo7XOiW9ZB51Zy_8C_cJEX679xBwEmBygQ@mail.gmail.com>
 <20180417051706.GA5894@dhcp-128-65.nay.redhat.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Mon, 23 Apr 2018 16:08:16 +0530
Message-ID: <CACi5LpNJehvLrnJ7h7s5_d78ZNPTW=BD+M7X0exObU_jd75aJg@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/2] dt-ops: Add helper API to dump fdt blob
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
To: Dave Young <dyoung@redhat.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, James Morse <james.morse@arm.com>, kexec@lists.infradead.org

On Tue, Apr 17, 2018 at 10:47 AM, Dave Young <dyoung@redhat.com> wrote:
> On 04/16/18 at 08:39pm, Bhupesh Sharma wrote:
>> Hi Dave,
>>
>> On Mon, Apr 16, 2018 at 1:43 PM, Dave Young <dyoung@redhat.com> wrote:
>> > Hi Bhupesh,
>> >
>> > On 04/03/18 at 07:28pm, Bhupesh Sharma wrote:
>> >> Hi James,
>> >>
>> >> Sorry for the delay, I had a long weekend last week.
>> >>
>> >> On Tue, Mar 27, 2018 at 7:01 PM, James Morse <james.morse@arm.com> wrote:
>> >> > Hi Akashi, Bhupesh,
>> >> >
>> >> > On 27/03/18 10:04, AKASHI Takahiro wrote:
>> >> >> On Mon, Mar 26, 2018 at 02:29:31PM +0530, Bhupesh Sharma wrote:
>> >> >>> On Tue, Mar 20, 2018 at 12:36 AM, Bhupesh Sharma <bhsharma@redhat.com> wrote:
>> >> >>>> On Mon, Mar 19, 2018 at 8:15 PM, AKASHI Takahiro
>> >> >>>> <takahiro.akashi@linaro.org> wrote:
>> >> >>>>> On Mon, Mar 19, 2018 at 04:05:38PM +0530, Bhupesh Sharma wrote:
>> >> >>>>>> At several occasions it would be useful to dump the fdt
>> >> >>>>>> blob being passed to the second (kexec/kdump) kernel
>> >> >>>>>> when '-d' flag is specified while invoking kexec/kdump.
>> >> >>>>>
>> >> >>>>> Why not just save binary data to a file and interpret it
>> >> >>>>> with dtc command?
>> >> >
>> >> > I'd prefer this too. It would also let us debug any issue where kexec-tools
>> >> > produces an invalid DTB. It also lets us test booting the kernel from firmware
>> >> > with that DTB.
>> >>
>> >> I captured the use case where it is not possible to do so. I have seen
>> >> primary kernel crash before we can get to the command prompt to save
>> >> the dtb blob. Since the arm64 crashkernel still seems to have issues
>> >> itself while booting on acpi enabled machines (see
>> >> <https://www.spinics.net/lists/arm-kernel/msg616632.html>), so we are
>> >> trying to debug a problem which has two undefined variables :)
>> >>
>> >> >>>> Well, there are a couple of reasons for that which can be understood
>> >> >>>> from a system which is in a production environment (for e.g. I have
>> >> >>>> worked on one arm64 system in the past which used a yocto based
>> >> >>>> distribution in which kexec -p was launched with a -d option as a part
>> >> >>>> of initial ramfs scriptware):
>> >> >
>> >> > and panics before you get an interactive prompt or persistent storage? I think
>> >> > this would be a pretty niche use-case. You could always base64-dump the dtb to
>> >> > stdout from your script.
>> >>
>> >> That is pretty basic case on several new arm64 development boards
>> >> (e.g. qualcomm, huawei etc) where we are debugging issues in primary
>> >> kernel boot (and we are not even able to reach the command prompt).
>> >>
>> >> If the crashkernel crashes even before the primary kernel does because
>> >> of the issues in the way DTB is passed to the crashkernel (which can
>> >> include wrong DTB fields), we better have mechanisms to track the same
>> >> rather than adding debug prints to the kernels.
>> >
>> > In this case, since userspace always need to run 'kexec -l', there
>> > should be chance to save dtb and dump them in scripts if needed.
>> > If this is doable in scripts I also tend not to add the code in kexec-tools.
>>
>> Perhaps you missed my latest email which explained the use case better
>> (please see [1]).
>> Please note that I am talking about the 'kexec -p' or the kdump use
>> case rather than the 'kexec -l' or the warm reboot to the second
>> kernel.
>
> It is a typo, I meant about 'kexec -p' as well
>
>>
>> In several cases its useful if we are not able to reach the command
>> prompt to just modify the scriptware to launch 'kexec -p' when the
>> ramfs starts up so that we can catch crashes which happen before the
>> primary kernel reaches the command prompt. For example, on freescale
>> boards I found this scriptware mechanism quite useful on yocto based
>> distributions, as you can be porting a new upstream kernel on the
>> board and thus is not very stable while booting and the crashkernel
>> also has issues which causes it to crash. In such cases although we
>> see a panic message from the crashkernel it is very difficult to
>> deduce that it was because of some wrongly fixed up dtb property.
>
> Since kexec -p need to be automated in scripts, add something to dump
> dtb is also doable.
>
>>
>> Getting a debug log which contains the dtb dump is very useful in
>> above cases for debugging.
>>
>> Also saving the dtb requires 'dtc' tool to be installed which is an
>> additional dependency.
>
> I think it should be not a big problem,  dtc is designed to do this.
>
>>
>> Since we have debug facility/messages already available when we
>> execute 'kexec -p' with '-d' flag we can use the dtb dumps from the
>> tool to debug crashes than happen in the crashkernel also because of
>> wrong dtb fields fixed up by 'kexec-tools'. I was loathe to keep this
>> patch locally and apply to the upstream 'kexec-tools' when debugging
>> these issues as I think it makes sense to improve our debugging
>> capabilities if we know there are issues around the same.
>
> Hmm, do you have the example kexec-tools fix-up the dtb content?

Yes, I have sent out the v2 patchset to explain the background better
and also capture some details on where I found this patchset handy.
Also added some dtb dumps logs from 'kexec -p -d' for reference (with
this patchset applied) for clarity.

You can view the v2 here
<http://lists.infradead.org/pipermail/kexec/2018-April/020532.html>

Regards,
Bhupesh

>> Ok, let me resend this patch with a cover letter this time to explain
>> the use case better and also to capture the dtb logs.
>>
>> [1] https://marc.info/?l=kexec&m=152382169120505&w=2
>
> Thanks
> Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
