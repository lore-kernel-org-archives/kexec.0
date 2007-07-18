Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]
	helo=bifrost.lang.hm)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IAxSe-0005mB-1G
	for kexec@lists.infradead.org; Wed, 18 Jul 2007 01:32:14 +0100
Date: Tue, 17 Jul 2007 17:25:29 -0700 (PDT)
From: david@lang.hm
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec
	=?iso-8859-15?q?base=09hibernation?=
In-Reply-To: <200707171622.53657.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.64.0707171707380.2467@asgard.lang.hm>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<Pine.LNX.4.64.0707170101010.19248@asgard.lang.hm>
	<1184676518.10998.34.camel@caritas-dev.intel.com>
	<200707171622.53657.rjw@sisk.pl>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Tue, 17 Jul 2007, Rafael J. Wysocki wrote:

> On Tuesday, 17 July 2007 14:48, Huang, Ying wrote:
>> On Tue, 2007-07-17 at 01:13 -0700, david@lang.hm wrote:
>>> however, since the resume designed for ACPI won't work would the following
>>> approach work
>>>
>>> 1. boot one kernel
>>> 2. setup a kexec the same way you would for hibernate
>>> 3. kexec to the new kernel
>>> 4. overwrite the memory of the first kernel
>>> 5. kexec 'back' to the main kernel that has now been overwritten by what was saved?
>>>
>>> as part of this question, when you do a kexec, how does the kernel that
>>> you are doing the kexec to know what to run next?
>>
>> For kernel in 3 that do kexec, the devices and CPU state are saved into
>> memory before executing the new kernel. So when jumping back, the
>> control will continue from kexec point. If the memory image of main
>> kernel is restored from disk, the devices and CPU state in memory is
>> restored too. Before jumping back in 5, the devices are put in the known
>> state, after jumping back, the devices and CPU state is restored. If the
>> "kexec -j" is used to trigger the kexec in 3, the system will continue
>> with "kexec -j" exiting with exit code 0.
>>
>>> it needs to do some initialization first before it starts running normal
>>> things, and at that point it the move back doesn't look for init like a
>>> normal kernel boot (or the system would effectivly boot instead of picking
>>> up where it left off)
>>
>> I think the early initialization can be done in a initramfs. At that
>> point, the resume image can be checked, the next step depends on the
>> result of checking.
>>
>>> is this 'restart point' flexible enough that either the pre-hibernate
>>> kerenl or the small hibernate kernel could tell the pre-hibernate kernel
>>> to go into suspend-to-ram mode before doing anything else?
>>
>> It is possible for hibernate kernel to pass information back to
>> pre-hibernate kernel. For example, the information can be passed in jump
>> buffer page.
>
> I think it would be reasonable to have a protocol defined for passing this
> information, so that it's independent of the kernel version etc.

At this point it looks like we have the following communication nessasary 
between the two kernels

1. the original kernel needs to create a map of what memory to backup

   this could be either a bitmap, or a series of address:blockcount pairs.
   in either case the result could be sizeable, so it's probably best to 
define a standard location to find the type and address of the data.

2. the new kernel needs to tell the old kernel which 'restart point' to 
use.

   this could be a simple jump table.

   the list that has been suggested so far is
     A. restore (the default)
     B. suspend-to-ram
     C. ACPI suspend-to-disk (S4 mode)

since both kernels have access to the other kernel's memory the data could 
be stored in either kernel's address space, but my initial thought is that 
it's cleaner to store this in the original kernel's space and have the 
second kernel find it there.

I don't have the knowledge to create either of these interfaces, let alone 
the pull to get them implmented in the kernel.

could I ask that one of you consider makeing a patch that implements at 
least #1 (the memory map)

it sounds as if these kexec-back patches plus makeing the memory map 
available would allow for a ACPI-free hibernate mode with no other 
modifications. I'd like to try experimenting with this, but without the 
memory map it sounds as if things will croak when I try to do this.

David Lang

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
