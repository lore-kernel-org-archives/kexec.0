Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <57AA0361.6030505@arm.com>
Date: Tue, 09 Aug 2016 17:22:57 +0100
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v22 2/8] arm64: limit memory regions based on DT property, 
 usable-memory-range
References: <20160712050514.22307-1-takahiro.akashi@linaro.org>
 <20160712050514.22307-3-takahiro.akashi@linaro.org>
 <578D1A31.5080509@arm.com> <20160721005756.GN20774@linaro.org>
 <579225B6.3090209@arm.com> <20160725052754.GA8855@linaro.org>
 <20160804062131.GM7995@linaro.org>
In-Reply-To: <20160804062131.GM7995@linaro.org>
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
Cc: mark.rutland@arm.com, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org, bauerman@linux.vnet.ibm.com, dennis.chen@arm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Akashi,

Sorry for the late response, (I was on holiday last week...)

On 04/08/16 07:21, AKASHI Takahiro wrote:
> On Mon, Jul 25, 2016 at 02:27:55PM +0900, AKASHI Takahiro wrote:
>> On Fri, Jul 22, 2016 at 02:55:02PM +0100, James Morse wrote:
>>> On 21/07/16 01:57, AKASHI Takahiro wrote:
>>>> Could you please apply the diff attached below and confirm that
>>>> kdump works in your environment?
>>>> I can't test it by myself since my hikey board seems to be broken now.
>>>
>>> With this I get a failure even earlier, even with 'acpi=off'.
>>> With this patch, on boot of the kdump kernel I get:
>>
>> I think you ran into the problem that I mentioned in:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/444500.html
>>
>> You may want to
>> - apply the change stated above, or
>>   (Given that we don't know about the configuration of crash dump kernel,
>>   checking for CONFIG_ZONE_DMA doesn't make sense. Instead, we'd better
>>   always enforce ARCH_LOW_ADDRESS_LIMIT.)
>> - explicitly specify the start address (Y) below ARCH_LOW_ADDRESS_LIMIT
>>   at "crashkernel=X@Y"
>> Either would work.
> 
> Have these methods fixed your problem in the end?

The change you made in v23 to use ARCH_LOW_ADDRESS_LIMIT fixed the problem with
juno and acpi. I will retest it with v24 and using Seattle too...

Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
