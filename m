Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f0ok3-0004Ku-LL
 for kexec@lists.infradead.org; Tue, 27 Mar 2018 13:34:31 +0000
Subject: Re: [RESEND PATCH 1/2] dt-ops: Add helper API to dump fdt blob
References: <1521455739-8022-1-git-send-email-bhsharma@redhat.com>
 <20180319144529.vkfrrkc4bdhwvvbi@dragonfly>
 <CACi5LpObqAJ=yC_e2G80JsspfzEx50Rq=J2G_UAnoT3UqS4HFQ@mail.gmail.com>
 <CACi5LpPVbVZBAXynMQ79kkboLrQcw1s-LSuFkSQAnkXtdS8wAA@mail.gmail.com>
 <20180326123038.GA14737@linaro.org>
From: James Morse <james.morse@arm.com>
Message-ID: <e5ed1c04-73db-fda5-602d-f9bd447801da@arm.com>
Date: Tue, 27 Mar 2018 14:31:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180326123038.GA14737@linaro.org>
Content-Language: en-US
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>, Bhupesh Sharma <bhsharma@redhat.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec@lists.infradead.org

Hi Akashi, Bhupesh,

On 27/03/18 10:04, AKASHI Takahiro wrote:
> On Mon, Mar 26, 2018 at 02:29:31PM +0530, Bhupesh Sharma wrote:
>> On Tue, Mar 20, 2018 at 12:36 AM, Bhupesh Sharma <bhsharma@redhat.com> wrote:
>>> On Mon, Mar 19, 2018 at 8:15 PM, AKASHI Takahiro
>>> <takahiro.akashi@linaro.org> wrote:
>>>> On Mon, Mar 19, 2018 at 04:05:38PM +0530, Bhupesh Sharma wrote:
>>>>> At several occasions it would be useful to dump the fdt
>>>>> blob being passed to the second (kexec/kdump) kernel
>>>>> when '-d' flag is specified while invoking kexec/kdump.
>>>>
>>>> Why not just save binary data to a file and interpret it
>>>> with dtc command?

I'd prefer this too. It would also let us debug any issue where kexec-tools
produces an invalid DTB. It also lets us test booting the kernel from firmware
with that DTB.


>>> Well, there are a couple of reasons for that which can be understood
>>> from a system which is in a production environment (for e.g. I have
>>> worked on one arm64 system in the past which used a yocto based
>>> distribution in which kexec -p was launched with a -d option as a part
>>> of initial ramfs scriptware):

and panics before you get an interactive prompt or persistent storage? I think
this would be a pretty niche use-case. You could always base64-dump the dtb to
stdout from your script.


>>> - In a production environment, installing and executing tools like dtc
>>> (which might not have been installed by default via 'yum' or 'apt-get
>>> install' or other means is not only an additional step, but we might
>>> not get a chance to run it even if it is installed if we have a early
>>> crash in kdump itself (for e.g. consider the 'acpi table access' issue
>>> in the arm64 crashkernel we discussed some time back
>>> <https://www.spinics.net/lists/arm-kernel/msg616632.html>):

Wouldn't it be possible to transfer the dumped DTB file off the machine before
the behaviour that brings the machine down? Kdump always requires a setup step
to load the kdump kernel/dtb. You have to decide to add the debug flags at this
point. I don't see how choosing to save the modified-DTB would be any different.

I assume the flow here is: do thingX, the kernel crashes. Enable kdump, do
thingX, kdump fails to boot. Enable kdump-debug. Do thingX...


>>> a) In such a case the primary kernel has already crashed, so we had no
>>> opportunity to run a dtc interpreter there and the kdump kernel itself
>>> has crashed in a very early boot phase. So we didn't get a chance to
>>> execute 'dtc' on the kdump kernel command prompt (if the kdump scripts
>>> are configured not to reboot the primary again).

Transfer it off the machine, save it somewhere persistent or print it to stdout
in base64.


>>> b) Also when an early arm64 kdump crash is reported by a customer, we
>>> usually only have access to the primary and secondary console log
>>> which also might include the 'kexec -p -d' log messages, which can
>>> point us to a discrepancy in dtc nodes like 'linux,usable-memory"
>>> which might have caused a early crashkernel crash.

>>> Personally, so-far I have found this dtb dumping facility of use in
>>> debugging atleast a couple of arm64 crashkernel crash/panic issues.
>>> Till the arm64 kexec/kdump implementation matures further, I feel this
>>> dumping facility is of good use to ease crashkernel panic debugs.
>>
>> Ping. Do you have any further comments on it?
> 
> No.
> While I don't think dumping fdt is so useful as "kexec -d" option
> outputs enough information for me, you can go ahead.

(likewise)


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
