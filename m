Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8MzK-00062w-8t
 for kexec@lists.infradead.org; Mon, 25 Mar 2019 10:37:56 +0000
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Date: Mon, 25 Mar 2019 10:36:33 +0000
Message-ID: <701c8e69-e1d4-c653-1d87-1c41789d3d54@ce.jp.nec.com>
References: <20190322110342.GA16202@jeru.linux.bs1.fc.nec.co.jp>
 <20190322152328.GD12472@zn.tnic>
 <20190325002740.GA6637@jeru.linux.bs1.fc.nec.co.jp>
 <20190325060128.GB9385@dhcp-128-65.nay.redhat.com>
 <20190325061929.GC9385@dhcp-128-65.nay.redhat.com>
 <bcb5bd29-a3b8-e42d-8da7-a8501f695c21@ce.jp.nec.com>
 <20190325065921.GA11096@dhcp-128-65.nay.redhat.com>
 <20190325082720.GA20771@jeru.linux.bs1.fc.nec.co.jp>
 <51D9A7D1-49BF-4679-B102-0FC5AC300C9F@alien8.de>
 <20190325101509.GA13160@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190325101509.GA13160@dhcp-128-65.nay.redhat.com>
Content-Language: ja-JP
Content-ID: <895ABBA05F13AC4E969AC80CB8C41395@gisp.nec.co.jp>
MIME-Version: 1.0
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
To: Dave Young <dyoung@redhat.com>, Boris Petkov <bp@alien8.de>
Cc: "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>, "kasong@redhat.com" <kasong@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bp@suse.de" <bp@suse.de>

On 3/25/19 7:15 PM, Dave Young wrote:
> On 03/25/19 at 09:54am, Boris Petkov wrote:
>> On March 25, 2019 9:27:21 AM GMT+01:00, Junichi Nomura <j-nomura@ce.jp.nec.com> wrote:
>>> On 3/25/19 3:59 PM, Dave Young wrote:
>>>> On 03/25/19 at 06:47am, Junichi Nomura wrote:
>>>>> On 3/25/19 3:19 PM, Dave Young wrote:
>>>>>> On 03/25/19 at 02:01pm, Dave Young wrote:
>>>>>> I think normally people do not see this bug, because kernel will
>>> set the
>>>>>> rsdp in boot_params->acpi_rsdp_addr.  Maybe you are testing with
>>>>>
>>>>> I think it's only done for file-based kexec interface.
>>>>
>>>> Saw Kairui's another reply, yes, kexec-tools need a patch to fill the
>>>> value as well then.
>>>>
>>>> I would vote for a repost of your old patch with some #ifdef
>>>
>>> Thanks for comments, Dave, Kairui and Baoquan.
>>>
>>> The problem for me is it's a regression in v5.1-rc1, that breaks
>>> existing setup. If early parsing of RSDP is required only for newly
>>> supported configuration, I'm fine such configuration requires
>>> new tools or new options.
>>>
>>> This is the 1st version plus #ifdef around the EFI code.
>>
>> I'm going to repeat that again until you get it:
>>
>> If the kexec kernel should continue to use efi_systab_init() then you
>> should make efi_get_rsdp_addr() exit early in the kexec-ed kernel.
> 
> In that way, early parsing will fail in kexeced kernel, am I missing
> something?  The early code become complicated but since we have already
> the early acpi parsing why not to make it consistent in kexeced kernel?

AFAIU, early parsing is new code in v5.1-rc1 to support kexec on systems
with hotpluggable memory with KASLR enabled. For systems that requires the
new feature, it may be ok to say "you need to use another kexec interface"
and/or "you need new kexec-tools".

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
