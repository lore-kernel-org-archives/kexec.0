Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8LNG-00063V-S1
 for kexec@lists.infradead.org; Mon, 25 Mar 2019 08:54:32 +0000
Date: Mon, 25 Mar 2019 09:54:19 +0100
In-Reply-To: <20190325082720.GA20771@jeru.linux.bs1.fc.nec.co.jp>
References: <20190322110342.GA16202@jeru.linux.bs1.fc.nec.co.jp>
 <20190322152328.GD12472@zn.tnic>
 <20190325002740.GA6637@jeru.linux.bs1.fc.nec.co.jp>
 <20190325060128.GB9385@dhcp-128-65.nay.redhat.com>
 <20190325061929.GC9385@dhcp-128-65.nay.redhat.com>
 <bcb5bd29-a3b8-e42d-8da7-a8501f695c21@ce.jp.nec.com>
 <20190325065921.GA11096@dhcp-128-65.nay.redhat.com>
 <20190325082720.GA20771@jeru.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
From: Boris Petkov <bp@alien8.de>
Message-ID: <51D9A7D1-49BF-4679-B102-0FC5AC300C9F@alien8.de>
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
To: Junichi Nomura <j-nomura@ce.jp.nec.com>, Dave Young <dyoung@redhat.com>, "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>, "bp@suse.de" <bp@suse.de>, "bhe@redhat.com" <bhe@redhat.com>, "kasong@redhat.com" <kasong@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On March 25, 2019 9:27:21 AM GMT+01:00, Junichi Nomura <j-nomura@ce.jp.nec.com> wrote:
>On 3/25/19 3:59 PM, Dave Young wrote:
>> On 03/25/19 at 06:47am, Junichi Nomura wrote:
>>> On 3/25/19 3:19 PM, Dave Young wrote:
>>>> On 03/25/19 at 02:01pm, Dave Young wrote:
>>>> I think normally people do not see this bug, because kernel will
>set the
>>>> rsdp in boot_params->acpi_rsdp_addr.  Maybe you are testing with
>>>
>>> I think it's only done for file-based kexec interface.
>> 
>> Saw Kairui's another reply, yes, kexec-tools need a patch to fill the
>> value as well then.
>> 
>> I would vote for a repost of your old patch with some #ifdef
>
>Thanks for comments, Dave, Kairui and Baoquan.
>
>The problem for me is it's a regression in v5.1-rc1, that breaks
>existing setup. If early parsing of RSDP is required only for newly
>supported configuration, I'm fine such configuration requires
>new tools or new options.
>
>This is the 1st version plus #ifdef around the EFI code.

I'm going to repeat that again until you get it:

If the kexec kernel should continue to use efi_systab_init() then you
should make efi_get_rsdp_addr() exit early in the kexec-ed kernel.
-- 
Sent from a small device: formatting sux and brevity is inevitable. 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
