Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SeqqE-0000Za-Fl
 for kexec@lists.infradead.org; Wed, 13 Jun 2012 16:54:47 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <9A3DED9B-FB11-49CC-A51E-40ED03E24999@vt.edu>
Date: Wed, 13 Jun 2012 09:54:04 -0700
In-Reply-To: <9A3DED9B-FB11-49CC-A51E-40ED03E24999@vt.edu> (Ben Shelton's
 message of "Thu, 7 Jun 2012 18:47:35 -0400")
Message-ID: <87ipevp2z7.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: Kexec: where does the kernel image get relocated?
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
To: Ben Shelton <beshelto@vt.edu>
Cc: Antonio Barbalace <antoniob@vt.edu>, kexec@lists.infradead.org, Cong Wang <xiyou.wangcong@gmail.com>

Ben Shelton <beshelto@vt.edu> writes:

> Hi all,
>
> I'm working on a distributed-computing project where we'd like to boot multiple instances of the Linux kernel on the same machine.  We'd like to leverage kexec to decompress each guest kernel and copy it to an area within the physical address space.
>
> From following through the code and using GDB/QEMU, it seems like the steps to reboot with kexec look like this:
>
> - Decompress the kernel somewhere (not necessarily contiguous)
> - In relocate_kernel_64.S, copy the kernel to a contiguous space and jump/return to purgatory
> - In purgatory, reinitialize the hardware if necessary, then jump to the start of the kernel
>
> My issue is that I can't seem to find where the address to which the
> kernel is copied in step 2 is defined.  Can anyone give me a brief
> description of how this works?

The addresses are specified in the kexec_load system call.

If the kernel doesn't like those addresses it might move itself as Cong
Wang mentioned.

/sbin/kexec looks at the headers of the kernel image and either use
where the kernel is required to be loaded by the boot protocol or if the
image is relocatable an available extent of memory that is supported by
the boot protocol is picked.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
