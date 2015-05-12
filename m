Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ys4gg-0005Uk-Dr
 for kexec@lists.infradead.org; Tue, 12 May 2015 07:33:10 +0000
Received: by pdbnk13 with SMTP id nk13so173638918pdb.0
 for <kexec@lists.infradead.org>; Tue, 12 May 2015 00:32:48 -0700 (PDT)
Message-ID: <5551AC97.9040802@linaro.org>
Date: Tue, 12 May 2015 16:32:39 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
MIME-Version: 1.0
Subject: Re: [v2 1/5] arm64: kdump: reserve memory for crash dump kernel
References: <1429861989-8417-1-git-send-email-takahiro.akashi@linaro.org>
 <1429861989-8417-2-git-send-email-takahiro.akashi@linaro.org>
 <20150428091935.GJ15033@dhcp-16-116.nay.redhat.com>
 <55505C91.8070503@linaro.org>
 <20150511075447.GA4290@dhcp-128-28.nay.redhat.com>
 <5550659D.90006@linaro.org>
 <20150511094115.GB4290@dhcp-128-28.nay.redhat.com>
In-Reply-To: <20150511094115.GB4290@dhcp-128-28.nay.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: hbabus@us.ibm.com, linaro-kernel@lists.linaro.org, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, vgoyal@redhat.com, broonie@kernel.org, david.griego@linaro.org, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 05/11/2015 06:41 PM, Baoquan He wrote:
> On 05/11/15 at 05:17pm, AKASHI Takahiro wrote:
>> On 05/11/2015 04:54 PM, Baoquan He wrote:
>>> In this patch you reserve a separate memory region in 1st kernel to
>>> store elfcorehdr. I am wondering why you don't call add_buffer in
>>> kexec-tools directly. Like this you can get a region from reserved
>>> crashkernel region. Then you don't need reserve_elfcorehdr() to reserve
>>> memory for elfcorehdr specifically. Like other ARCHs do only one memory
>>> region is reserved in 1st kernel, that's crashkernel region.
>>
>> I think that you misunderstand somewhat.
>> * Kexec-tools only locates/identifies a small region for elfcore header within crash kernel's
>> memory region while 1st kernel is running.
>> * the data in elfcore header is filled up by kexec_load system call on 1st kernel.
>> * 1st kernel doesn't reserve any region for elfcore header because the kernel
>> commandline parameters don't contains "elfcorehdr=" parameter, then elfcorehdr_size=0.
>> * Crash dump kernel does reserve the region, as I said, because we don't want to
>> corrupt the info in elfcore header accidentally while crash kernel is running.
>>
>> Clear?
>
> OK, got it now.
>
> Then I am wondering why "elfcorehdr=" can't be contained in kernel
> cmdline as other ARCH does. Maybe I need go over all related threads
> then know why it is. Thanks for explanation.

Kexec-tools on 1st kernel appends "elfcorehdr=" to the kernel command line,
actually chosen/bootargs in a device tree, that is passed to *crash dump kernel*.
So when crash dump kernel boots up, it can recognizes that area (and reserves it
for later use of managing /proc/vmcore.)

Thanks,
-Takahiro AKASHI

> Thanks
> Baoquan
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
