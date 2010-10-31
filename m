Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vw0-f49.google.com ([209.85.212.49])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PCRb8-0001IV-Sc
	for kexec@lists.infradead.org; Sun, 31 Oct 2010 06:41:00 +0000
Received: by vws8 with SMTP id 8so862575vws.36
	for <kexec@lists.infradead.org>; Sat, 30 Oct 2010 23:40:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20101028122540.GA29759@basil.fritz.box>
References: <20100619132633.GA24277@basil.fritz.box>
	<m1mxuqu8yr.fsf@fess.ebiederm.org>
	<AANLkTillNx5owgU4O71izNz9FEL06MiI-FquTZ3ofktP@mail.gmail.com>
	<AANLkTi=HKMce2UojSRmqVdoLO3H4v+6Xtp-bgFuHwH+D@mail.gmail.com>
	<AANLkTinHP0Z-sQOgtETQsQ_5ZV1UbT+tGDJ47B23E4=0@mail.gmail.com>
	<20101024213802.GB9922@basil.fritz.box>
	<20101028121417.GD16206@verge.net.au>
	<20101028122540.GA29759@basil.fritz.box>
From: Michael Kerrisk <mtk.manpages@gmail.com>
Date: Sun, 31 Oct 2010 07:40:37 +0100
Message-ID: <AANLkTimFN2NvJoZZUmSGgKCrBKMUz951k6FSamq-BmqQ@mail.gmail.com>
Subject: Re: [PATCH] kexec_load manpage
Reply-To: mtk.manpages@gmail.com
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
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-man@vger.kernel.org, Simon Horman <horms@verge.net.au>, Kexec Mailing List <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>

Andi, Erric, and all,

On Thu, Oct 28, 2010 at 2:25 PM, Andi Kleen <andi@firstfloor.org> wrote:
> On Thu, Oct 28, 2010 at 09:14:17PM +0900, Simon Horman wrote:
>> On Sun, Oct 24, 2010 at 11:38:02PM +0200, Andi Kleen wrote:
>> > On Sun, Oct 24, 2010 at 04:56:24PM +0200, Michael Kerrisk wrote:
>> > > Hey Andi,
>> > >
>> > > I'd like to push this page out the door, but I'm blocked doing so
>> > > until I hear back from you regarding the question below (plus a new
>> > > version of the page, if needed please).
>> >
>> > Probably. Eric should know.
>> >
>> > Frankly without an header the syscall is pretty much unusable
>> > for normal programs anyways, so I gave up on this.
>>
>> I'm not sure that I ever understood the impasse over the header.
>
> It's basically: should kexec_load only be used from kexec(8)
> or is it a generally available syscall.
>
> If the former is true no header or manpage is needed.
> For the later both are.

On the other hand, I always think a man page is needed...

Andi, I incorporated Eric's suggestions and made a few other changes:

    Added a license (Andi, I used the verbatim license, and put copyright
    in your name -- okay?)

    Various wording and layout improvements.

    Fixed the name of a constant: s/KEXEC_ARCH_I386/KEXEC_ARCH_386/.

    Added RETURN VALUE and ERRORS sections.
    Added VERSIONS section

    Removed details of using syscall; the reader can find them in syscall(2).

    Added some details for KEXEC_PRESERVE_CONTEXT.

    Revised the text mentioning the kernel header, since it is
    not yet exported, and it's not certain that it will be.

    Note that CONFIG_KEXEC is needed

Review of my changes, and of course Andi's original would be most
welcome. The current version of the page is pushed to git, and inline
below.

Cheers,

Michael


.\" Hey Emacs! This file is -*- nroff -*- source.
.\"
.\" Copyright (C) 2010 Andi Kleen
.\"
.\" Permission is granted to make and distribute verbatim copies of this
.\" manual provided the copyright notice and this permission notice are
.\" preserved on all copies.
.\"
.\" Permission is granted to copy and distribute modified versions of this
.\" manual under the conditions for verbatim copying, provided that the
.\" entire resulting derived work is distributed under the terms of a
.\" permission notice identical to this one.
.\"
.\" Since the Linux kernel and libraries are constantly changing, this
.\" manual page may be incorrect or out-of-date.  The author(s) assume no
.\" responsibility for errors or omissions, or for damages resulting from
.\" the use of the information contained herein.  The author(s) may not
.\" have taken the same level of care in the production of this manual,
.\" which is licensed free of charge, as they might when working
.\" professionally.
.\"
.\" Formatted or processed versions of this manual, if unaccompanied by
.\" the source, must acknowledge the copyright and authors of this work.
.TH KEXEC_LOAD 2 2010-10-31 "Linux" "Linux Programmer's Manual"
.SH NAME
kexec_load \- load a new kernel for later execution
.SH SYNOPSIS
.b #include <linux/kexec.h>
.br
.BI "long kexec_load(unsigned long " entry ", unsigned long " nr_segments ","
.br
.BI "                struct kexec_segment *" segments \
", unsigned long " flags ");"
.SH DESCRIPTION
The
.BR kexec_load ()
system call loads a new kernel that can be executed later by
.BR reboot(2) .
.PP
The
.I flags
argument is a mask whose high-order bits control the operation of the call.
The following values can be specified in
.IR flags :
.TP
.B KEXEC_ON_CRASH
Execute the new kernel automatically on a system crash.
.\" FIXME figure out how this is really used
.TP
.B KEXEC_PRESERVE_CONTEXT
Preserve the system hardware and
software states before executing the new kernel.
This could be used for system suspend.
This flag is only available if the kernel was configured with
.BR CONFIG_KEXEC_JUMP ,
and is only effective if
.I nr_segments
is greater than 0.
.PP
The low-order bits of
.I flags
contain the architecture of the to-be-executed kernel.
Specify (OR) the constant
.B KEXEC_ARCH_DEFAULT
to use the current architecture,
or one of the following architecture constants
.BR KEXEC_ARCH_386 ,
.BR KEXEC_ARCH_X86_64 ,
.BR KEXEC_ARCH_PPC ,
.BR KEXEC_ARCH_PPC64 ,
.BR KEXEC_ARCH_IA_64 ,
.BR KEXEC_ARCH_ARM ,
.BR KEXEC_ARCH_S390 ,
.BR KEXEC_ARCH_SH ,
.BR KEXEC_ARCH_MIPS ,
and
.BR KEXEC_ARCH_MIPS_LE .
The architecture must be executable on the CPU of the system.

The
.I entry
argument is the physical entry address in the kernel image.
The
.I nr_segments
argument is the number of segments pointed to by the
.I segments
pointer.
The
.I segments
argument is an array of
.I kexec_segment
structures which define the kernel layout:
.in +4n
.nf

struct kexec_segment {
    void   *buf;        /* Buffer in user space */
    size_t  bufsz;      /* Buffer length in user space */
    void   *mem;        /* Physical address of kernel */
    size_t  memsz;      /* Physical address length */
};
.fi
.in
.PP
.\" FIXME elaborate on the following:
The kernel image defined by
.I segments
is copied from the calling process into previously reserved memory.
.SH RETURN VALUE
On success,
.BR kexec_load ()
returns 0.
On error, -1 is returned and
.I errno
is set to indicate the error.
.SH ERRORS
.TP
.B EBUSY
Another crash kernel is already being loaded
or a crash kernel is already in use.
.TP
.B EINVAL
.I flags
is invalid; of
.IR nr_segments is too large
.\" KEXEC_SEGMENT_MAX == 16
.TP
.B EPERM
The caller does not have the
.BR CAP_SYS_BOOT
capability.
.SH VERSIONS
The
.BR kexec_load ()
system call first appeared in Linux 2.6.7.
.SH CONFORMING TO
This system call is Linux-specific.
.SH NOTES
Currently, there is no glibc support for
.BR kexec_load ().
Call it using
.BR syscall (2).
.PP
The required constants are in the kernel source file
.IR linux/kexec.h ,
which is not currently exported to glibc.
.\" FIXME Andi submitted a patch for this.
.\" Check if it got accepted later.
Therefore, these constants must be defined manually.

This system call is only available if the kernel was configured with
.BR CONFIG_KEXEC .
.SH SEE ALSO
.BR syscall (2),
.BR reboot (2)


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Author of "The Linux Programming Interface"; http://man7.org/tlpi/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
