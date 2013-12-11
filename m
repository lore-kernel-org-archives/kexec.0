Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vqr6U-0000Wx-Mg
 for kexec@lists.infradead.org; Wed, 11 Dec 2013 21:13:59 +0000
Received: by mail-ob0-f180.google.com with SMTP id wo20so7590196obc.39
 for <kexec@lists.infradead.org>; Wed, 11 Dec 2013 13:13:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87vbyvxojs.fsf@xmission.com>
References: <20131210001620.GA7938@www.outflux.net>
 <87vbyvxojs.fsf@xmission.com>
Date: Wed, 11 Dec 2013 13:13:32 -0800
Message-ID: <CAGXu5j+hCf8zkO3FEJ=ZO++unnpzL8GLivSNqy=dYFzJah0WCg@mail.gmail.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, Rik van Riel <riel@redhat.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, Rob Landley <rob@landley.net>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Wed, Dec 11, 2013 at 9:52 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Kees Cook <keescook@chromium.org> writes:
>
>> For general-purpose (i.e. distro) kernel builds it makes sense to build with
>> CONFIG_KEXEC to allow end users to choose what kind of things they want to do
>> with kexec. However, in the face of trying to lock down a system with such
>> a kernel, there needs to be a way to disable kexec (much like module loading
>> can be disabled). Without this, it is too easy for the root user to modify
>> kernel memory even when CONFIG_STRICT_DEVMEM and modules_disabled are
>> set.
>
> So let me get this straight.  You object to what happens in sys_reboot
> so you patch sys_kexec_load?

Yes; it's the entry point for loading the image used for crashes and
LINUX_REBOOT_CMD_KEXEC.

> You give someone the privilege to boot whatever they want and yet you
> don't want to support them booting whatever they want?
>
> I'm sorry my brain is hurting trying to understand the logic of this
> patch.

I'm not trying to claim this fixes all attack vectors from a root
user. That is exceedingly hard. :) However, kexec gives the root user
a trivial (and undetectable) way to modify the running kernel.
Providing an option to block sys_kexec_load for systems that will
never use it (or will use it once at startup) is valuable in several
situations. There's no reason to make an attacker's job easier, and
this doesn't get in any one else's way.

-Kees

-- 
Kees Cook
Chrome OS Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
