Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-oa0-x229.google.com ([2607:f8b0:4003:c02::229])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WDzWv-0005Cy-AY
 for kexec@lists.infradead.org; Thu, 13 Feb 2014 16:52:54 +0000
Received: by mail-oa0-f41.google.com with SMTP id j17so13167772oag.0
 for <kexec@lists.infradead.org>; Thu, 13 Feb 2014 08:52:29 -0800 (PST)
Message-ID: <52FCF69C.2080108@acm.org>
Date: Thu, 13 Feb 2014 10:45:16 -0600
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
Subject: Re: Tool for creating full vmcore
References: <52FBD7C3.4060304@acm.org> <20140212214257.GF16470@redhat.com>
 <CADq4U7+K-Zi2Ckb-mfDWFf50Oq7hbTWR6H92=Jx=STqWSJu89g@mail.gmail.com>
 <20140213135153.GB30844@redhat.com> <20140213135229.GC30844@redhat.com>
In-Reply-To: <20140213135229.GC30844@redhat.com>
Reply-To: minyard@acm.org
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, Dave Anderson <anderson@redhat.com>

On 02/13/2014 07:52 AM, Vivek Goyal wrote:
> Oops, forgot to cc kexec list. Doing it now.
Yeah, I forgot that, too.

>
> On Thu, Feb 13, 2014 at 08:51:53AM -0500, Vivek Goyal wrote:
>> CCing kexec list. Please don't drop the list from the conversation.
>>
>> On Wed, Feb 12, 2014 at 04:51:07PM -0600, Corey Minyard wrote:
>>> Well, I would like to use crash, but it does not support cross debugging
>>> and everything we do is cross development.
>> Hmm.., I will let Dave Anderson comment on that.

Dave has already commented on it several times.  It's not going to happen.

>>
>>> I'm not familiar with filtered core files, but it would be easy enough to
>>> just dump kernel memory.  It's not a big deal for what I do, we don't deal
>>> with huge machines.  I suppose that's coming, though.
>> Well, makedumpfile utility does the kernel filtering and that utility has
>> been growing over time. So for a specific use case it might be trivial but
>> when you try to make it generic, we end up the size of makedumpfile.
>>
>> So this is like trying to regenerate kcore file out of vmcore where
>> there are ELF headers for vmalloc and vmemmap areas?

Basically, that's it.  It walks the page tables and generates an ELF
file from that, so it will pick up anything in the page tables.  It's
theoretically possible to walk user page tables, too.  That means
there's arch-specific code.  It's pretty trivial for everything but
MIPS, which implements page tables in software and has too many options.

Oh, I forgot to mention earlier that i386 is not tested yet.  x86_64,
ARM, and MIPS are tested.  I need to get to i386 soon.

>>
>> Given the fact that this tool is specifically generating kcore, I guess
>> one possile name for the tool could be vmcore-kcore.

Yeah, I've been leaning somewhere in that direction for the name.

>>
>> I saw some references to /dev/oldmem in git. /dev/oldmem has been
>> deprecated, so you can remove all the code dealing with that and
>> just rely on /proc/vmcore being there.

Yes, I found that out and removed it a while ago.  Makes sense.

>>
>> I guess if code is small enough, then it might be useful to 
>> keep it in a direcotry say kexec-tools/vmcore-kcore. But if it turns
>> out to be big, it might be better to maintain it as a separate project
>> (like makedumpfile).

Yeah, it's a little big, but not huge.  Most of the code is the elf
part, which is in it's own file and could be a separate library.  I'm
fine either way.  It will get bigger as new arch-specific code is added.

Thanks,

-corey

>> Thanks
>> Vivek
>>
>>> -corey
>>> On Feb 12, 2014 3:43 PM, "Vivek Goyal" <vgoyal@redhat.com> wrote:
>>>
>>>> On Wed, Feb 12, 2014 at 02:21:23PM -0600, Corey Minyard wrote:
>>>>> Hello,
>>>>>
>>>>> I've written a tool that takes an coredump of physical kernel memory and
>>>>> converts it to a coredump of virtual kernel memory that can be directly
>>>>> used by gdb to debug a kernel.
>>>> I am wondering where is it useful. So you find using gdb on kernel
>>>> core give you better experience as compared to crash which is fully
>>>> tailored to kernel debugging only?
>>>>
>>>> What about dump filtering? Now a days we use makedumpfile by default
>>>> and makedumpfile has its own format for dump files which crash
>>>> understands.
>>>>
>>>> I guess gdb will not work with makedumpfile format files. If that's the
>>>> case, that means this tool will work with unfiltered core files and
>>>> generate unfiltered core files. I think working with unfiltered core
>>>> files is not very practical now a days given large amount of RAM
>>>> machines typically tend to have.
>>>>
>>>> Thanks
>>>> Vivek
>>>>
>>>>> I was trying to use /proc/vmcore, but that did not include any of
>>>>> vmalloc memory or vmemmap, which made it kind of useless.  I thought
>>>>> about adding all that to the vmcore, but that didn't seem like the
>>>>> proper way to do things.
>>>>>
>>>>> The tool is at https://github.com/cminyard/kdump-tool
>>>>>
>>>>> It can create a physical memory coredump (like the kdump tool) and a
>>>>> virtual memory coredump (either from a physical memory one, or directly
>>>>> from /proc/vmcore and /dev/mem).
>>>>>
>>>>> Two kernel patches are in the "kernel-patches" directory of the tool, on
>>>>> the master branch:
>>>>>
>>>>> One adds the valid physical memory ranges to the notes in the core
>>>>> file.  Memory doesn't always start from zero, some systems have more
>>>>> than one OS running on the same hardware,  and memory often has holes
>>>>> and places that are bad to read from.  It seems prudent to pass in these
>>>>> ranges so the coredump is only the memory required.  It also adds the
>>>>> physical address of the kernel page directory to the notes, so it can
>>>>> parse the page tables.
>>>>>
>>>>> The other is MIPS specific.  You need a whole bunch of information about
>>>>> the configuration to parse the MIPS page tables.
>>>>>
>>>>> One cool thing this should be able to do is create a coredump for
>>>>> userspace processes.  You can look into kernel memory to find the page
>>>>> table and pass that in to the tool.  It should be able to extract the
>>>>> process' resident memory from a physical coredump.  Of course, it will
>>>>> only dump resident memory, anything on disk will not be there.
>>>>>
>>>>> Is this interesting to the kdump community?  I'd like to include it in
>>>>> kexec, if possible.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> -corey
>>>>>
>>>>> _______________________________________________
>>>>> kexec mailing list
>>>>> kexec@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
