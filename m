Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wg0-x22c.google.com ([2a00:1450:400c:c00::22c])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YHDRs-0003Tv-Og
 for kexec@lists.infradead.org; Fri, 30 Jan 2015 15:25:35 +0000
Received: by mail-wg0-f44.google.com with SMTP id z12so27548788wgg.3
 for <kexec@lists.infradead.org>; Fri, 30 Jan 2015 07:25:09 -0800 (PST)
Message-ID: <54CBA252.4050003@gmail.com>
Date: Fri, 30 Jan 2015 16:25:06 +0100
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
MIME-Version: 1.0
Subject: Re: Edited kexec_load(2) [kexec_file_load()] man page for review
References: <20150112221634.GD16162@redhat.com> <54B91271.3000600@gmail.com>
 <20150127142459.GA12851@redhat.com> <54C89816.8030709@gmail.com>
 <20150128144803.GC15342@redhat.com>
 <CAKgNAkhhVq5fuqwH0aPdgR1bKkAPPPuS84hfAFg3grGEJNxS4w@mail.gmail.com>
 <20150128203402.GG15342@redhat.com>
 <alpine.DEB.2.11.1501282104490.9275@localhost.localdomain>
 <20150128213125.GH15342@redhat.com>
 <alpine.DEB.2.11.1501282207570.5656@localhost.localdomain>
 <20150128222526.GJ15342@redhat.com>
 <alpine.DEB.2.11.1501290010120.6022@localhost.localdomain>
 <CAKgNAkjBBRmcpu8DuaGCCRhvXP_AFotK5xrHx2HaR6g_8omULw@mail.gmail.com>
 <alpine.DEB.2.11.1501291429001.1597@localhost.localdomain>
In-Reply-To: <alpine.DEB.2.11.1501291429001.1597@localhost.localdomain>
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
To: Scot Doyle <lkml14@scotdoyle.com>
Cc: "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Andi Kleen <andi@firstfloor.org>, Borislav Petkov <bp@alien8.de>, mtk.manpages@gmail.com, "H. Peter Anvin" <hpa@zytor.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

On 01/29/2015 05:06 PM, Scot Doyle wrote:
> On Thu, 29 Jan 2015, Michael Kerrisk (man-pages) wrote:
>> On 29 January 2015 at 02:27, Scot Doyle <lkml14@scotdoyle.com> wrote:
>>> On Wed, 28 Jan 2015, Vivek Goyal wrote:
>>>> On Wed, Jan 28, 2015 at 10:10:59PM +0000, Scot Doyle wrote:
>>>>> On Wed, 28 Jan 2015, Vivek Goyal wrote:
>>>>>> On Wed, Jan 28, 2015 at 09:14:03PM +0000, Scot Doyle wrote:
>>>>>>> When I tested, kexec_file_load required CONFIG_RELOCATABLE. Is the same
>>>>>>> true for kexec_load? Would it make sense to note this in the man pages
>>>>>>> along with the need for CONFIG_KEXEC_FILE, etc? Or as an error message?
>>>>>>
>>>>>> Hmm.., I can't see an explicity dependency between RELOCATABLE and
>>>>>> KEXEC. Both KEXEC and KEXEC_FILE should be able to load a kernel
>>>>>> even if it had RELOCATABLE=n.
>>>>>>
>>>>>> Just that kernel will run from the address it has been built for.
>>>>>>
>>>>>> Thanks
>>>>>> Vivek
>>>>>
>>>>> Confusing, right? kexec_file_load returns -ENOEXEC and dmesg says
>>>>> "kexec-bzImage64: XLF_CAN_BE_LOADED_ABOVE_4G is not set." which leads to
>>>>> arch/x86/boot/header.S line 396:
>>>>>
>>>>> #if defined(CONFIG_RELOCATABLE) && defined(CONFIG_X86_64)
>>>>>    /* kernel/boot_param/ramdisk could be loaded above 4g */
>>>>> # define XLF1 XLF_CAN_BE_LOADED_ABOVE_4G
>>>>> #else
>>>>> # define XLF1 0
>>>>> #endif
>>>>
>>>> Ah, this one. Actually generic kexec file loading implementation does not
>>>> impose this restriction. It is the image specific loader part which
>>>> decides what kind of bzImage it can load.
>>>>
>>>> Current implementation (kexec-bzimage64.c), is only supporting loading
>>>> bzImages which are 64bit and can be loaded above 4G. This simplifies
>>>> the implementation of loader.
>>>>
>>>> But there is nothing which prevents one from implementing other image
>>>> loaders.
>>>>
>>>> So instead of saying that kexec_file_load() depends on CONFIG_RELOCATABLE,
>>>> it might be better to say in man page that currently this system call
>>>> supports only loading a bzImage which is 64bit and which can be loaded
>>>> above 4G too.
>>>>
>>>> Thanks
>>>> Vivek
>>>
>>> Thanks, I agree, and think it would make sense to list them as part of the
>>> page's ENOEXEC error.
>>
>> Scott, could you then phras a couple of sentences that capture thge
>> details, so I can add it to the ENOEXEC error?
>>
>> Thanks,
>>
>> Michael
> 
> Yes, maybe something like "kernel_fd does not refer to an open file, or 
> the file type is not supported. Currently, the file must be a bzImage
> and contain an x86 kernel loadable above 4G in memory (see 
> Documentation/x86/boot.txt)."?
> 
> boot.txt explains that loading above 4G implies 64-bit and is specified 
> via a bit in xloadflags added in Linux 3.8.

Added and pushed. Thanks, Scott.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
