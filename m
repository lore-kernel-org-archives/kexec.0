Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TjInj-0004p8-Je
 for kexec@lists.infradead.org; Fri, 14 Dec 2012 00:06:56 +0000
Received: by mail-bk0-f49.google.com with SMTP id jm19so1377158bkc.36
 for <kexec@lists.infradead.org>; Thu, 13 Dec 2012 16:06:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50CA67FF.90009@zytor.com>
References: <1355437112-9250-1-git-send-email-yinghai@kernel.org>
 <1355437112-9250-4-git-send-email-yinghai@kernel.org>
 <50CA67FF.90009@zytor.com>
Date: Thu, 13 Dec 2012 16:06:47 -0800
Message-ID: <CAE9FiQX6yZ3SVEdA8crw+hy-Fbw13KrufNbVbei84nuKMndu1A@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] kexec, x86: Fix bzImage real-mode booting
From: Yinghai Lu <yinghai@kernel.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Dec 13, 2012 at 3:42 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 12/13/2012 02:18 PM, Yinghai Lu wrote:
>
>> +       if (real_mode_entry) {
>> +               /* restore can use heap and load high */
>> +               real_mode->loader_flags = 0x81;
>> +               if (real_mode->protocol_version >= 0x0201)
>> +                       real_mode->heap_end_ptr += heap_size - 0x200;
>> /*stack*/
>> +       }
>> +
>
>
> This code is wrong: the bits at the bottom of this field (LOADED_HIGH) are
> kernel->bootloader flags.
>
> The right behavior is:
>
>         if (real_mode->protocol_version >= 0x0201) {
>                 real_mode->loader_flag |= CAN_USE_HEAP;
>
>                 real_mode->heap_end_ptr += heap_size - 0x200; /*stack*/
>         }

ok.
>
>
>> +               regs16.ds = regs16.es = regs16.fs = regs16.gs = setup_base
>> >> 4;
>>
>> +               regs16.cs = regs16.ds + 0x20;
>> +               regs16.ip = 0;
>> +               /* XXX: Documentation/i386/boot.txt says 'ss' must equal
>> 'ds' */
>> +               regs16.ss = (elf_rel_get_addr(&info->rhdr, "stack_end") -
>> 64*1024) >> 4;
>> +               /* XXX: Documentation/i386/boot.txt says 'sp' must equal
>> heap_end */
>> +               regs16.esp = 0xFFFC;
>> +
>
>
> And, pray tell, why aren't they?

?, maybe Eric could answer that.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
