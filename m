Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cFa5o-0006Fs-Hl
 for kexec@lists.infradead.org; Sat, 10 Dec 2016 05:21:07 +0000
Received: by mail-oi0-x244.google.com with SMTP id m75so4832130oig.1
 for <kexec@lists.infradead.org>; Fri, 09 Dec 2016 21:20:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161210024927.GD1034@x1>
References: <20161210002202.19829-1-robert@leblancnet.us>
 <20161210024927.GD1034@x1>
From: Robert LeBlanc <robert@leblancnet.us>
Date: Fri, 9 Dec 2016 22:20:41 -0700
Message-ID: <CAANLjFq92OLqsPmoz0FMHw9ZEyAm60s3M1UgkqTLtHabuQL6DA@mail.gmail.com>
Subject: Re: [PATCH] Add +~800M crashkernel explaination
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
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org

On Fri, Dec 9, 2016 at 7:49 PM, Baoquan He <bhe@redhat.com> wrote:
> On 12/09/16 at 05:22pm, Robert LeBlanc wrote:
>> When trying to configure crashkernel greater than about 800 MB, the
>> kernel fails to allocate memory on x86 and x86_64. This is due to an
>> undocumented limit that the crashkernel and other low memory items must
>> be allocated below 896 MB unless the ",high" option is given. This
>> updates the documentation to explain this and what I understand the
>> limitations to be on the option.
>
> This is true, but not very accurate. You found it's about 800M, it's
> becasue usually the current kernel need about 40M space to run, and some
> extra reservation before reserve_crashkernel invocation, another ~10M.
> However it's normal case, people may build modules into or have some
> special code to bloat kernel. This patch makes sense to address the
> low|high issue, it might be not good so determined to say ~800M.

My testing showed that I could go anywhere from about 830M to 880M,
depending on distro, kernel version, and stuff that you mentioned. I
just thought some rule of thumb of when to consider using high would
be good. People may not think that 800 MB is 'large' when you have 512
GB of RAM for instance. I thought about making 512 MB be the rule of
thumb, but you can do a lot with ~300 MB.

I'm happy to adjust the wording, what would you recommend? Also, I'm
not 100% sure that I got the cases covered correctly. I was surprised
that I could not get it to work with the "new" format with the
multiple ranges, and that specifying an offset would't work either,
although the offset kind of makes sense. Do you know for sure that it
doesn't work with ranges?

I tried,

crashkernel=256M-1G:128M,high,1G-4G:256M,high,4G-:512M,high

and

crashkernel=256M-1G:128M,1G-4G:256M,4G-:512M,high

and neither worked. It seems that a better separator would be ';'
instead of ',' for ranges, then you could specify options better. Kind
of hard to change now.

>
>>
>> Signed-off-by: Robert LeBlanc <robert@leblancnet.us>
>> ---
>>  Documentation/kdump/kdump.txt | 22 +++++++++++++++++-----
>>  1 file changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
>> index b0eb27b..aa3efa8 100644
>> --- a/Documentation/kdump/kdump.txt
>> +++ b/Documentation/kdump/kdump.txt
>> @@ -256,7 +256,9 @@ While the "crashkernel=size[@offset]" syntax is sufficient for most
>>  configurations, sometimes it's handy to have the reserved memory dependent
>>  on the value of System RAM -- that's mostly for distributors that pre-setup
>>  the kernel command line to avoid a unbootable system after some memory has
>> -been removed from the machine.
>> +been removed from the machine. If you need to allocate more than ~800M
>> +for x86 or x86_64 then you must use the simple format as the format
>> +',high' conflicts with the separators of ranges.
>>
>>  The syntax is:
>>
>> @@ -282,11 +284,21 @@ Boot into System Kernel
>>  1) Update the boot loader (such as grub, yaboot, or lilo) configuration
>>     files as necessary.
>>
>> -2) Boot the system kernel with the boot parameter "crashkernel=Y@X",
>> +2) Boot the system kernel with the boot parameter "crashkernel=Y[@X | ,high]",
>>     where Y specifies how much memory to reserve for the dump-capture kernel
>> -   and X specifies the beginning of this reserved memory. For example,
>> -   "crashkernel=64M@16M" tells the system kernel to reserve 64 MB of memory
>> -   starting at physical address 0x01000000 (16MB) for the dump-capture kernel.
>> +   and X specifies the beginning of this reserved memory or ',high' to load in
>> +   high memory. For example, "crashkernel=64M@16M" tells the system
>> +   kernel to reserve 64 MB of memory starting at physical address
>> +   0x01000000 (16MB) for the dump-capture kernel.
>> +
>> +   Specifying "crashkernel=1G,high" tells the system kernel to reserve 1 GB
>> +   of memory using high memory for the dump-capture kernel, there may also
>> +   be some low memory allocated as well. If you need more than ~800M for
>> +   the crash kernel to operate (volumes on FC/iSCSI, large volumes, systemd
>> +   added to the previous, etc), you need to specify ',high' since without
>> +   it crashkerenel has to try and fit under 896M along with some other
>> +   items and will fail to allocate memory. High memory may only be relevant
>> +   on x86 and x86_64.
>>
>>     On x86 and x86_64, use "crashkernel=64M@16M".
>>
>> --
>> 2.10.2
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec

----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
