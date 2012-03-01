Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qw0-f42.google.com ([209.85.216.42])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S2vGo-0000NW-0X
 for kexec@lists.infradead.org; Thu, 01 Mar 2012 01:57:26 +0000
Received: by qaui11 with SMTP id i11so2298658qau.15
 for <kexec@lists.infradead.org>; Wed, 29 Feb 2012 17:57:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120301.105126.193682835.d.hatayama@jp.fujitsu.com>
References: <CANrfoUXd4L2bjBO+L8ZBCkc1dfnZahn39sB25zsrUMqGA5zY5A@mail.gmail.com>
 <20120301013200.GF16483@verge.net.au>
 <CANrfoUVTSh6jWckz2jt9+X6E6FSPL5OwqWNrcXchbo1BwkCLgw@mail.gmail.com>
 <20120301.105126.193682835.d.hatayama@jp.fujitsu.com>
From: Eugene Surovegin <surovegin@google.com>
Date: Wed, 29 Feb 2012 17:56:54 -0800
Message-ID: <CANrfoUXGyjXeWSHWXzTq1r9Trd8riSWkF4+DoejJXRBnHkDPvw@mail.gmail.com>
Subject: Re: [PATCH] kdump: force page alignment for per-CPU crash notes.
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, ebiederm@xmission.com

On Wed, Feb 29, 2012 at 5:51 PM, HATAYAMA Daisuke
<d.hatayama@jp.fujitsu.com> wrote:
> From: Eugene Surovegin <surovegin@google.com>
> Subject: Re: [PATCH] kdump: force page alignment for per-CPU crash notes.
> Date: Wed, 29 Feb 2012 17:39:55 -0800
>
>> On Wed, Feb 29, 2012 at 5:32 PM, Simon Horman <horms@verge.net.au> wrote:
>>> On Wed, Feb 29, 2012 at 05:23:10PM -0800, Eugene Surovegin wrote:
>>>> On Wed, Feb 29, 2012 at 5:18 PM, Simon Horman <horms@verge.net.au> wro=
te:
>>>>
>>>> > On Wed, Feb 29, 2012 at 09:21:23AM -0800, Eugene Surovegin wrote:
>>>> > > Per-CPU allocations are not guaranteed to be physically contiguous.
>>>> > > However, kdump kernel and user-space code assumes that per-CPU
>>>> > > memory, used for saving CPU registers on crash, is.
>>>> > > This can cause corrupted /proc/vmcore in some cases - the main
>>>> > > symptom being huge ELF note section.
>>>> > >
>>>> > > Force page alignment for note_buf_t to ensure that this assumption=
 holds.
>>>> >
>>>> > Ouch. I'm surprised there is an allocation on crash, perhaps
>>>> > it could at least be done earlier? And am I right in thinking
>>>> > that this change increases the likely hood that the allocation
>>>> > could fail?
>>>> >
>>>>
>>>> I'm not following. This allocation is done on start-up, not on crash.
>>>> If you cannot allocate this much memory on system boot, I'm not sure w=
hat
>>>> else you can do on this system....
>>>
>>> Sorry, my eyes deceived me. You are correct and I agree.
>>>
>>> Is it the case that note_buf_t is never larger than PAGE_SIZE?
>>> If so I your patch looks good to me.
>>
>> Currently, maximum note size is hardcoded in kexec-tools to 1024
>> (MAX_NOTE_BYTES).
>> Usually it's way less. IIRC on x86_64 it's 336 bytes.
>>
>
> This is elf_prstatus and I guess it's mostly equal to registers.
>
> crash> p sizeof(struct elf_prstatus)
> $3 =3D 336
> crash> ptype struct elf_prstatus
> type =3D struct elf_prstatus {
> =A0 =A0struct elf_siginfo pr_info;
> =A0 =A0short int pr_cursig;
> =A0 =A0long unsigned int pr_sigpend;
> =A0 =A0long unsigned int pr_sighold;
> =A0 =A0pid_t pr_pid;
> =A0 =A0pid_t pr_ppid;
> =A0 =A0pid_t pr_pgrp;
> =A0 =A0pid_t pr_sid;
> =A0 =A0struct timeval pr_utime;
> =A0 =A0struct timeval pr_stime;
> =A0 =A0struct timeval pr_cutime;
> =A0 =A0struct timeval pr_cstime;
> =A0 =A0elf_gregset_t pr_reg; <-- this
> =A0 =A0int pr_fpvalid;
> }
>
> What kinds of architecture does have so many registers? It's just my
> interest. Or possibly other kinds of notes is written here?

I'm not sure about other archs, but we don't write there anything
except for 'elf_prstatus' and sentinel "final" note.

--
Eugene

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
