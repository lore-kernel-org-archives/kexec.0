Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fNsXD-0006Fl-3d
 for kexec@lists.infradead.org; Wed, 30 May 2018 04:16:32 +0000
Received: by mail-wm0-x244.google.com with SMTP id f8-v6so45118756wmc.4
 for <kexec@lists.infradead.org>; Tue, 29 May 2018 21:16:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <77f40316d72044a196f5e9bedfc1627f@HXTBJIDCEMVIW02.hxtcorp.net>
References: <1526018427-8710-1-git-send-email-yanjiang.jin@hxt-semitech.com>
 <1526018427-8710-2-git-send-email-yanjiang.jin@hxt-semitech.com>
 <CAHM4w1=5eyi+fL0yyUF1ur4CMvjpCLrOpqSKzvtBt=Le5Kguxg@mail.gmail.com>
 <77f40316d72044a196f5e9bedfc1627f@HXTBJIDCEMVIW02.hxtcorp.net>
From: Pratyush Anand <pratyush.anand@gmail.com>
Date: Wed, 30 May 2018 09:46:13 +0530
Message-ID: <CAHM4w1nrKWMPMdgP1Uke9WYEp0WrgrJgAaV-oUWMGQMfEAOGfA@mail.gmail.com>
Subject: Re: [PATCH] arm64: update PHYS_OFFSET to conform to kernel
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
To: "Jin, Yanjiang" <yanjiang.jin@hxt-semitech.com>
Cc: "jinyanjiang@gmail.com" <jinyanjiang@gmail.com>, "horms@verge.net.au" <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Yanjiang,

On Wed, May 30, 2018 at 8:33 AM, Jin, Yanjiang
<yanjiang.jin@hxt-semitech.com> wrote:
> Hi Pratyush,
>
> Thanks for your help! but please see my reply inline.
>

[...]

>> > If an application, for example, vmcore-dmesg, wants to access the
>> > kernel symbol which is located in the last 2M address, it would fail
>> > with the below error:
>> >
>> >   "No program header covering vaddr 0xffff8017ffe90000 found kexec bug?"
>>
>> I think, fix might not be correct.
>>
>> Problem is in vmcore-dmesg and that should be fixed and not the kexec.
>> See here (https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-
>> tools.git/tree/vmcore-dmesg/vmcore-dmesg.c?id=HEAD#n261).
>
> Firstly, for my patch, vmcore-dmesg is just an auxiliary application to help to reproduce this issue. The function, which is to generate vmcore,  is the root cause.

...and the function which generates vmcore is not the kexec rather the
secondary kernel.

>
> On the other hand, vmcore-dmesg is under kexec-tools, it has no a standalone git repo.  Even we want to fix vmcore-dmesg, we still need to send the patch to kexec-tools, right?

Sure. I meant `kexec` application. We have three applications in
kexec-tools. `kexec`, `vmcore-dmesg` and `kdump`. [I hope kdump is
useless and we are going to get rid off it very soon.]

>
> Yanjiang
>
>> How symbols are extracted from vmcore.
>>
>> You do have "NUMBER(PHYS_OFFSET)=" information in vmcore.
>>
>> You can probably see makedumpfile code, that how to extract information from
>> "NUMBER".
>
> I have seen makedumpfile before, NUMBER(number) is just read a number from vmcore. But as I show before, the root issue is vmcore contains a wrong number, my patch is to fix the vmcore generating issue, we can't read vmcore at this point since we don't have vmcore yet.

..and IIUC, you were able to reach correctly till the end of secondary
kernel where you tried vmcore-dmesg and then you had issue, right?

How did you conclude that vmcore contains wrong number? It's unlikely,
but if it does then we have problem somewhere in Linux kernel , not
here.

Have you tried to extract "PHYS_OFFSET" from vmcore either in
vmcore-dmesg or in makedumpfile and found it not matching to the value
of "PHYS_OFFSET" from first kernel?

In my understanding flow is like this:

- First kernel will have reserved area for secondary kernel, as well
as for elfcore.
- First kernel will embed all the vmcore information notes into
elfcore (see crash_save_vmcoreinfo_init() ->
arch_crash_save_vmcoreinfo()). Therefore, we will have PHYS_OFFSET,
kimage_voffset and VA_BITS information for first kernel in vmcore,
which is in separate memory and can be read by second kernel
- elfcore will also have notes about all the other physical memory of
first kernel which need to be copied by second kernel.
- Now when crash happens, second kernel should have all the required
info for reading symbols from first kernel's physical memory, no?

>
> NUMBER(number) = read_vmcoreinfo_ulong(STR_NUMBER(str_number))
>
> Yanjiang
>
>>
>> Once you know the real PHYS_OFFSET (which could have been random if KASLR is
>> enabled), you can fix the problem you are seeing.
>
> I have both validated with/without KASLR,  all of them worked well after applying my patch.

IMHO, even if that works it does not mean that its good a fix. We
should try to find root cause. Moreover, you might not have /dev/mem
available for all the configuration where KASLR is enabled.

Regards
Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
