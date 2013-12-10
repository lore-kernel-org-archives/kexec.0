Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-oa0-x22b.google.com ([2607:f8b0:4003:c02::22b])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqT3r-0003G6-Kf
 for kexec@lists.infradead.org; Tue, 10 Dec 2013 19:33:41 +0000
Received: by mail-oa0-f43.google.com with SMTP id i7so6129694oag.16
 for <kexec@lists.infradead.org>; Tue, 10 Dec 2013 11:33:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131210191409.GE13909@redhat.com>
References: <20131210001620.GA7938@www.outflux.net>
 <52A66190.9060907@zytor.com>
 <CAGXu5jKkCNWQKH-Ozm72C3aY_NBzRdNo2GmqKbVVJds5xs=SXg@mail.gmail.com>
 <20131210143540.GA13909@redhat.com>
 <f4fbae55-7d7b-400d-b50f-258002371368@email.android.com>
 <20131210183352.GD13909@redhat.com> <52A76348.5080803@zytor.com>
 <20131210191409.GE13909@redhat.com>
Date: Tue, 10 Dec 2013 11:33:16 -0800
Message-ID: <CAGXu5j+1-X+35ks29XuG8g=ZLVSFSmQJbTETdc3QYqOonpNVTQ@mail.gmail.com>
Subject: Re: [PATCH v2] kexec: add sysctl to disable kexec
From: Kees Cook <keescook@chromium.org>
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
Cc: Matthew Garrett <matthew.garrett@nebula.com>, Rik van Riel <riel@redhat.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, Rob Landley <rob@landley.net>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>

On Tue, Dec 10, 2013 at 11:14 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
> On Tue, Dec 10, 2013 at 10:54:00AM -0800, H. Peter Anvin wrote:
>> On 12/10/2013 10:33 AM, Vivek Goyal wrote:
>> > On Tue, Dec 10, 2013 at 08:32:38AM -0800, H. Peter Anvin wrote:
>> >> Of course it isn't.
>> >
>> > I am not sure what are you trying to say. This is too brief.
>> >
>> > Thanks
>> > Vivek
>> >
>>
>> Of course it is not sufficient.  Once you can get arbitrary code into
>> kernel space (CPL 0) you can do anything, and "disabling jump back" is
>> just a speed bump.
>
> Agreed that disabling jump back is only a speed bump.
>
> Kees, so how would be use this knob?
>
> - If I put it in some init script, then root will permission to modify
>   and remove it.

Correct. Same applies to changing the kernel itself, yes. However, all
those options require a reboot, and unexpected system reboots should
signal a significant problem to a system owner. :) This is a big step
better than a silent kernel root kit getting installed.

> - Can one specify sysctl parameters on command line? If yes, then one
>   can disable this using kernel command line and in that case kdump will
>   be disabled too.

If they can be set on the command line, I'd like to know about it.
That would let me flip the bit even earlier, since I don't use kexec
at all (and don't need to wait until boot up is done).

-Kees

-- 
Kees Cook
Chrome OS Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
