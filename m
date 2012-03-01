Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S2w6T-0000gm-Dd
 for kexec@lists.infradead.org; Thu, 01 Mar 2012 02:50:51 +0000
Date: Thu, 1 Mar 2012 11:50:39 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kdump: force page alignment for per-CPU crash notes.
Message-ID: <20120301025038.GD10053@verge.net.au>
References: <CANrfoUXd4L2bjBO+L8ZBCkc1dfnZahn39sB25zsrUMqGA5zY5A@mail.gmail.com>
 <20120301013200.GF16483@verge.net.au>
 <CANrfoUVTSh6jWckz2jt9+X6E6FSPL5OwqWNrcXchbo1BwkCLgw@mail.gmail.com>
 <20120301.105126.193682835.d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120301.105126.193682835.d.hatayama@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: surovegin@google.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, ebiederm@xmission.com

On Thu, Mar 01, 2012 at 10:51:26AM +0900, HATAYAMA Daisuke wrote:
> From: Eugene Surovegin <surovegin@google.com>
> Subject: Re: [PATCH] kdump: force page alignment for per-CPU crash notes.
> Date: Wed, 29 Feb 2012 17:39:55 -0800
> 
> > On Wed, Feb 29, 2012 at 5:32 PM, Simon Horman <horms@verge.net.au> wrote:
> >> On Wed, Feb 29, 2012 at 05:23:10PM -0800, Eugene Surovegin wrote:
> >>> On Wed, Feb 29, 2012 at 5:18 PM, Simon Horman <horms@verge.net.au> wrote:
> >>>
> >>> > On Wed, Feb 29, 2012 at 09:21:23AM -0800, Eugene Surovegin wrote:
> >>> > > Per-CPU allocations are not guaranteed to be physically contiguous.
> >>> > > However, kdump kernel and user-space code assumes that per-CPU
> >>> > > memory, used for saving CPU registers on crash, is.
> >>> > > This can cause corrupted /proc/vmcore in some cases - the main
> >>> > > symptom being huge ELF note section.
> >>> > >
> >>> > > Force page alignment for note_buf_t to ensure that this assumption holds.
> >>> >
> >>> > Ouch. I'm surprised there is an allocation on crash, perhaps
> >>> > it could at least be done earlier? And am I right in thinking
> >>> > that this change increases the likely hood that the allocation
> >>> > could fail?
> >>> >
> >>>
> >>> I'm not following. This allocation is done on start-up, not on crash.
> >>> If you cannot allocate this much memory on system boot, I'm not sure what
> >>> else you can do on this system....
> >>
> >> Sorry, my eyes deceived me. You are correct and I agree.
> >>
> >> Is it the case that note_buf_t is never larger than PAGE_SIZE?
> >> If so I your patch looks good to me.
> > 
> > Currently, maximum note size is hardcoded in kexec-tools to 1024
> > (MAX_NOTE_BYTES).
> > Usually it's way less. IIRC on x86_64 it's 336 bytes.

I presume that MAX_NOTE_BYTES was chosen to be large to
minimise the chance that it would ever need to be changed.

> This is elf_prstatus and I guess it's mostly equal to registers.
> 
> crash> p sizeof(struct elf_prstatus)
> $3 = 336
> crash> ptype struct elf_prstatus
> type = struct elf_prstatus {
>     struct elf_siginfo pr_info;
>     short int pr_cursig;
>     long unsigned int pr_sigpend;
>     long unsigned int pr_sighold;
>     pid_t pr_pid;
>     pid_t pr_ppid;
>     pid_t pr_pgrp;
>     pid_t pr_sid;
>     struct timeval pr_utime;
>     struct timeval pr_stime;
>     struct timeval pr_cutime;
>     struct timeval pr_cstime;
>     elf_gregset_t pr_reg; <-- this
>     int pr_fpvalid;
> }
> 
> What kinds of architecture does have so many registers? It's just my
> interest. Or possibly other kinds of notes is written here?

The winner seems to be ia64 with 128.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
