Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qy0-f177.google.com ([209.85.216.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S2v0M-0007iq-Lc
 for kexec@lists.infradead.org; Thu, 01 Mar 2012 01:40:27 +0000
Received: by qcsu28 with SMTP id u28so29909qcs.36
 for <kexec@lists.infradead.org>; Wed, 29 Feb 2012 17:40:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120301013200.GF16483@verge.net.au>
References: <1330536083-13098-1-git-send-email-surovegin@google.com>
 <20120301011811.GC16483@verge.net.au>
 <CANrfoUXd4L2bjBO+L8ZBCkc1dfnZahn39sB25zsrUMqGA5zY5A@mail.gmail.com>
 <20120301013200.GF16483@verge.net.au>
From: Eugene Surovegin <surovegin@google.com>
Date: Wed, 29 Feb 2012 17:39:55 -0800
Message-ID: <CANrfoUVTSh6jWckz2jt9+X6E6FSPL5OwqWNrcXchbo1BwkCLgw@mail.gmail.com>
Subject: Re: [PATCH] kdump: force page alignment for per-CPU crash notes.
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec-list <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>

On Wed, Feb 29, 2012 at 5:32 PM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Feb 29, 2012 at 05:23:10PM -0800, Eugene Surovegin wrote:
>> On Wed, Feb 29, 2012 at 5:18 PM, Simon Horman <horms@verge.net.au> wrote:
>>
>> > On Wed, Feb 29, 2012 at 09:21:23AM -0800, Eugene Surovegin wrote:
>> > > Per-CPU allocations are not guaranteed to be physically contiguous.
>> > > However, kdump kernel and user-space code assumes that per-CPU
>> > > memory, used for saving CPU registers on crash, is.
>> > > This can cause corrupted /proc/vmcore in some cases - the main
>> > > symptom being huge ELF note section.
>> > >
>> > > Force page alignment for note_buf_t to ensure that this assumption holds.
>> >
>> > Ouch. I'm surprised there is an allocation on crash, perhaps
>> > it could at least be done earlier? And am I right in thinking
>> > that this change increases the likely hood that the allocation
>> > could fail?
>> >
>>
>> I'm not following. This allocation is done on start-up, not on crash.
>> If you cannot allocate this much memory on system boot, I'm not sure what
>> else you can do on this system....
>
> Sorry, my eyes deceived me. You are correct and I agree.
>
> Is it the case that note_buf_t is never larger than PAGE_SIZE?
> If so I your patch looks good to me.

Currently, maximum note size is hardcoded in kexec-tools to 1024
(MAX_NOTE_BYTES).
Usually it's way less. IIRC on x86_64 it's 336 bytes.

--
Eugene

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
