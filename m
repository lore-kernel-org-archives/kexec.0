Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hijrj-0005zC-C5
	for kexec@lists.infradead.org; Tue, 01 May 2007 00:21:30 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 1/2] x86_64: Reflect the relocatability of the kernel in
	the ELF header.
References: <m1slah6gm0.fsf@ebiederm.dsl.xmission.com>
	<200704301717.08230.ak@suse.de> <20070501035539.GA15472@in.ibm.com>
Date: Mon, 30 Apr 2007 22:20:53 -0600
In-Reply-To: <20070501035539.GA15472@in.ibm.com> (Vivek Goyal's message of
	"Tue, 1 May 2007 09:25:39 +0530")
Message-ID: <m14pmx18ey.fsf@ebiederm.dsl.xmission.com>
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
To: vgoyal@in.ibm.com
Cc: linux-kernel@vger.kernel.org, Kexec Mailing List <kexec@lists.infradead.org>, Andi Kleen <ak@suse.de>, Jurriaan <thunder7@xs4all.nl>, Helge Hafting <helgehaf@aitel.hist.no>, Horms <horms@verge.net.au>, Andrew Morton <akpm@linux-foundation.org>

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Mon, Apr 30, 2007 at 05:17:07PM +0200, Andi Kleen wrote:
>> On Monday 30 April 2007 17:12:39 Eric W. Biederman wrote:
>> > 
>> > Currently because vmlinux does not reflect that the kernel is relocatable
>> > we still have to support CONFIG_PHYSICAL_START.  So this patch adds a small
>> > c program to do what we cannot do with a linker script set the elf header
>> > type to ET_DYN.
>> > 
>> > Since last time I have fixed the type to be in my code ET_DYN (oops),
>> > and verified this works with kexec.  I realized while testing that we
>> > don't have anyway of identifying a kernel vmlinux as linux so we
>> > probably want to add an ELF note but that will be another patch.
>> 
>> The patch is ok for me, but does it pass Vivek's usual testing?
>
> I am facing one issue with this patch. gdb can not analyze the
> resulting kernel core file. Looks like gdb treats vmlinux differently if
> ELF header type is "ET_DYN". It reads the symbol values incorrectly.

Weird.

> For example, symbol value of "panic_timeout" is 0xffffffff808a1fa8 but
> gdb somehow things that it is 0xffffffff008aaebf. Looks like it is
> performing some relocation.
>
> I am using GNU gdb Red Hat Linux (6.5-5.fc6rh).

Does it take a kernel core file to reproduce this problem?
Or can you just open up gdb on a vmlinux and look at the symbol
address?

At least without a core file it is working on with gdb 6.4.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
