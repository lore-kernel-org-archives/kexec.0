Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JkDzS-0002nS-Rc
	for kexec@lists.infradead.org; Fri, 11 Apr 2008 07:48:12 +0000
Subject: Re: [KEXEC] [ARM]
From: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <9b8644470804102121k43362a86i92d4d80275569dc4@mail.gmail.com>
References: <9b8644470804102121k43362a86i92d4d80275569dc4@mail.gmail.com>
Date: Fri, 11 Apr 2008 00:48:00 -0700
Message-Id: <1207900080.15605.14.camel@x61.ebiederm.org>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Sundeep Borra <sundeep471@gmail.com>, kexec@lists.infradead.org

I've added the kexec list as there may be other people that can help
out.

On Fri, 2008-04-11 at 09:51 +0530, Sundeep Borra wrote:
> Dear Eric,
> 
> I am working on KEXEC tool for ARM platform with linux-2.6.22.6.
> I have problem loading and running the zImage that is compiled with
> kexec_syscall support.
> 
> I found no code related to ARM architecture either in pugatory or in
> other branch of Kexec-tools source tree.

Have you looked at the kexec-tools-testing repository.  That is where
the work has been happening lately.

> I searched for Corresponding Patches on Net and those patches had
> nothign significant about ARM support on Purgatory,
> 
> Where to start from, inorder to get ARm specific purgatory code.

Well we compile purgatory as a relocatable object file and then 
process the relocations so we can put it in memory wherever we want
so there is relocation support.

Beyond that for purgatory it should just be a handful of stubs from
assembly to C that should be straight forward to write if you know
the architecture.

> I would like to donate ARM specific code if one doesn't exist

Well.  I don't know a lot about the ARM architecture but I can give some
general guidance.

As I recall ARM has the option to disable the MMU like x86 and the
kernel starts in that mode by default which makes things straight 
forward.

The biggest part is to figure out the format that the ARM kernel
accepts arguments in and generate those arguments when you load
an ARM kernel.  Basically that the kexec code really does collect
up the information a boot loader would pass and it passes it to the
kernel.


> -----------------------------------------------------------------------------------------------------
> KEXEC-tools Version: 1.101
> ----------------------------------------
> 
> PLATFORM: ARM926
> --------------------------------
> 
> COMMAND:
> ------------------
> ./kexec -l vmlinux
> 
> 
> ERROR:
> ------------
> 
> kernel: 0x4012c008 kernel_size: 191e72
> kexec_load: entry = 0xa0008000 flags = 280000
> nr_segments = 1
> segment[0].buf   = 0x4012c008
> segment[0].bufsz = 191e72
> segment[0].mem   = 0xa0008000
> segment[0].memsz = 192000
> kexec_load failed: Function not implemented
-ENOSYS?

Is the kernel portion of kexec implemented on ARM?

> entry       = 0xa0008000 flags = 280000
> nr_segments = 1
> segment[0].buf   = 0x4012c008
> segment[0].bufsz = 191e72
> segment[0].mem   = 0xa0008000
> segment[0].memsz = 192000
> 
> 
> CAUSE: syscall is failing in file kexec/kexec.c
> 
> -----------------------------------------------------------------------------------------------------
> Please help me in this regard,
> 
> Thanks in advance.

Hope this helps some.

Eric



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
