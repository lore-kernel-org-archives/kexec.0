Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f7ncq-00080F-Ia
 for kexec@lists.infradead.org; Sun, 15 Apr 2018 19:47:51 +0000
Received: by mail-lf0-f68.google.com with SMTP id p142-v6so19084287lfd.6
 for <kexec@lists.infradead.org>; Sun, 15 Apr 2018 12:47:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACi5LpN3bV6-TjAkbu9eGdSUfn-pCoEY==Z1qC5VzOZDdnw0-g@mail.gmail.com>
References: <1521455739-8022-1-git-send-email-bhsharma@redhat.com>
 <20180319144529.vkfrrkc4bdhwvvbi@dragonfly>
 <CACi5LpObqAJ=yC_e2G80JsspfzEx50Rq=J2G_UAnoT3UqS4HFQ@mail.gmail.com>
 <CACi5LpPVbVZBAXynMQ79kkboLrQcw1s-LSuFkSQAnkXtdS8wAA@mail.gmail.com>
 <20180326123038.GA14737@linaro.org>
 <e5ed1c04-73db-fda5-602d-f9bd447801da@arm.com>
 <CACi5LpN3bV6-TjAkbu9eGdSUfn-pCoEY==Z1qC5VzOZDdnw0-g@mail.gmail.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Mon, 16 Apr 2018 01:17:35 +0530
Message-ID: <CACi5LpNXp5hp1UWnEX52t5SBULD8BGOzTjzYZckUX7EO_ctxQg@mail.gmail.com>
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
To: James Morse <james.morse@arm.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Dave Young <dyoung@redhat.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec@lists.infradead.org

Hello,

On Tue, Apr 3, 2018 at 7:28 PM, Bhupesh Sharma <bhsharma@redhat.com> wrote:
> Hi James,
>
> Sorry for the delay, I had a long weekend last week.
>
> On Tue, Mar 27, 2018 at 7:01 PM, James Morse <james.morse@arm.com> wrote:
>> Hi Akashi, Bhupesh,
>>
>> On 27/03/18 10:04, AKASHI Takahiro wrote:
>>> On Mon, Mar 26, 2018 at 02:29:31PM +0530, Bhupesh Sharma wrote:
>>>> On Tue, Mar 20, 2018 at 12:36 AM, Bhupesh Sharma <bhsharma@redhat.com> wrote:
>>>>> On Mon, Mar 19, 2018 at 8:15 PM, AKASHI Takahiro
>>>>> <takahiro.akashi@linaro.org> wrote:
>>>>>> On Mon, Mar 19, 2018 at 04:05:38PM +0530, Bhupesh Sharma wrote:
>>>>>>> At several occasions it would be useful to dump the fdt
>>>>>>> blob being passed to the second (kexec/kdump) kernel
>>>>>>> when '-d' flag is specified while invoking kexec/kdump.
>>>>>>
>>>>>> Why not just save binary data to a file and interpret it
>>>>>> with dtc command?
>>
>> I'd prefer this too. It would also let us debug any issue where kexec-tools
>> produces an invalid DTB. It also lets us test booting the kernel from firmware
>> with that DTB.
>
> I captured the use case where it is not possible to do so. I have seen
> primary kernel crash before we can get to the command prompt to save
> the dtb blob. Since the arm64 crashkernel still seems to have issues
> itself while booting on acpi enabled machines (see
> <https://www.spinics.net/lists/arm-kernel/msg616632.html>), so we are
> trying to debug a problem which has two undefined variables :)
>
>>>>> Well, there are a couple of reasons for that which can be understood
>>>>> from a system which is in a production environment (for e.g. I have
>>>>> worked on one arm64 system in the past which used a yocto based
>>>>> distribution in which kexec -p was launched with a -d option as a part
>>>>> of initial ramfs scriptware):
>>
>> and panics before you get an interactive prompt or persistent storage? I think
>> this would be a pretty niche use-case. You could always base64-dump the dtb to
>> stdout from your script.
>
> That is pretty basic case on several new arm64 development boards
> (e.g. qualcomm, huawei etc) where we are debugging issues in primary
> kernel boot (and we are not even able to reach the command prompt).
>
> If the crashkernel crashes even before the primary kernel does because
> of the issues in the way DTB is passed to the crashkernel (which can
> include wrong DTB fields), we better have mechanisms to track the same
> rather than adding debug prints to the kernels.
>
> Note that the print logs are enabled when -d flag is passed to
> conventional 'kexec-tools' (where we already have several log
> messages), so I am not sure how adding the dtb print here affects the
> default (non-debug) case.
>
>>>>> - In a production environment, installing and executing tools like dtc
>>>>> (which might not have been installed by default via 'yum' or 'apt-get
>>>>> install' or other means is not only an additional step, but we might
>>>>> not get a chance to run it even if it is installed if we have a early
>>>>> crash in kdump itself (for e.g. consider the 'acpi table access' issue
>>>>> in the arm64 crashkernel we discussed some time back
>>>>> <https://www.spinics.net/lists/arm-kernel/msg616632.html>):
>>
>> Wouldn't it be possible to transfer the dumped DTB file off the machine before
>> the behaviour that brings the machine down? Kdump always requires a setup step
>> to load the kdump kernel/dtb. You have to decide to add the debug flags at this
>> point. I don't see how choosing to save the modified-DTB would be any different.
>
> Its not always possible to do the same in a customer setup or on
> remote board-farms.
>
>> I assume the flow here is: do thingX, the kernel crashes. Enable kdump, do
>> thingX, kdump fails to boot. Enable kdump-debug. Do thingX...
>
> Please see the use case I shared above
>
>>
>>>>> a) In such a case the primary kernel has already crashed, so we had no
>>>>> opportunity to run a dtc interpreter there and the kdump kernel itself
>>>>> has crashed in a very early boot phase. So we didn't get a chance to
>>>>> execute 'dtc' on the kdump kernel command prompt (if the kdump scripts
>>>>> are configured not to reboot the primary again).
>>
>> Transfer it off the machine, save it somewhere persistent or print it to stdout
>> in base64.
>>
>>
>>>>> b) Also when an early arm64 kdump crash is reported by a customer, we
>>>>> usually only have access to the primary and secondary console log
>>>>> which also might include the 'kexec -p -d' log messages, which can
>>>>> point us to a discrepancy in dtc nodes like 'linux,usable-memory"
>>>>> which might have caused a early crashkernel crash.
>>
>>>>> Personally, so-far I have found this dtb dumping facility of use in
>>>>> debugging atleast a couple of arm64 crashkernel crash/panic issues.
>>>>> Till the arm64 kexec/kdump implementation matures further, I feel this
>>>>> dumping facility is of good use to ease crashkernel panic debugs.
>>>>
>>>> Ping. Do you have any further comments on it?
>>>
>>> No.
>>> While I don't think dumping fdt is so useful as "kexec -d" option
>>> outputs enough information for me, you can go ahead.
>>
>> (likewise)
>>

Ping. Any comments on the above points?

If the use case is not clear in the git log message I can try and
resend this patchset and explain the use case and also maybe capture
the dtb dump that happens when -d option is used for clarity.

IMO getting this in upstream kexec-tools will really help distribution
guys like us who are debugging early crashes in the crashdump kernel
itself and enabling upstream primary kernels on newer arm64 boards (in
such cases, if both the primary and secondary happen to crash very
early during the boot flow, its very useful to have the dtb logs from
the kdump tool itself, which can be easily run in debug mode via
scriptware available in distributions like Fedora/Yocto).

Please let me know.

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
