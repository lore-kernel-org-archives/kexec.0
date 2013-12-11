Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vqt12-0003xK-3Z
 for kexec@lists.infradead.org; Wed, 11 Dec 2013 23:16:29 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20131210001620.GA7938@www.outflux.net>
 <87vbyvxojs.fsf@xmission.com>
 <CAGXu5j+hCf8zkO3FEJ=ZO++unnpzL8GLivSNqy=dYFzJah0WCg@mail.gmail.com>
Date: Wed, 11 Dec 2013 15:15:55 -0800
In-Reply-To: <CAGXu5j+hCf8zkO3FEJ=ZO++unnpzL8GLivSNqy=dYFzJah0WCg@mail.gmail.com>
 (Kees Cook's message of "Wed, 11 Dec 2013 13:13:32 -0800")
Message-ID: <87k3fbuggk.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] kexec: add sysctl to disable kexec
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
To: Kees Cook <keescook@chromium.org>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, Rik van Riel <riel@redhat.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, Rob Landley <rob@landley.net>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

Kees Cook <keescook@chromium.org> writes:

> On Wed, Dec 11, 2013 at 9:52 AM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> Kees Cook <keescook@chromium.org> writes:
>>
>>> For general-purpose (i.e. distro) kernel builds it makes sense to build with
>>> CONFIG_KEXEC to allow end users to choose what kind of things they want to do
>>> with kexec. However, in the face of trying to lock down a system with such
>>> a kernel, there needs to be a way to disable kexec (much like module loading
>>> can be disabled). Without this, it is too easy for the root user to modify
>>> kernel memory even when CONFIG_STRICT_DEVMEM and modules_disabled are
>>> set.
>>
>> So let me get this straight.  You object to what happens in sys_reboot
>> so you patch sys_kexec_load?
>
> Yes; it's the entry point for loading the image used for crashes and
> LINUX_REBOOT_CMD_KEXEC.
>
>> You give someone the privilege to boot whatever they want and yet you
>> don't want to support them booting whatever they want?
>>
>> I'm sorry my brain is hurting trying to understand the logic of this
>> patch.
>
> I'm not trying to claim this fixes all attack vectors from a root
> user. That is exceedingly hard. :) However, kexec gives the root user
> a trivial (and undetectable) way to modify the running kernel.
> Providing an option to block sys_kexec_load for systems that will
> never use it (or will use it once at startup) is valuable in several
> situations. There's no reason to make an attacker's job easier, and
> this doesn't get in any one else's way.

I am simply trying to point out your patch is incomplete and silly as
presented.

LINUX_REBOOT_CMD_KEXEC should be disabled if you are calling the sysctl
kexec_disable.  If you want to it to be kexec_load_disable please call
it that.  A kexec_load_disable is a different thing than a
kexec_disable.

A kexec_disable would block both sys_kexec_load and
sys_reboot(LINUX_REBOOT_CMD_KEXEC) and would remove any staged kexec
images.  Allowing you to stop considering kexec past that point from a
security analysis perspective.  That is what it sounds like you want.

What I am asking for is an problem description and an implementation
that are in sync, and a problem description that people can look at and
say was this a complete implementation.

Right now I can not tell what was intended so I can not truly tell if
the patch is correct.  Code with that property does not serve anyone any
good, especially as the kernel evolves.

So please decide if you want kexec_disable or kexec_load_disable, or if
you want something a little more nuanced.

Right now I think a full and complete kexec_disable makes sense.  I
probably won't use it but I think it makes sense.  Your patch
implementiong kexec_load_disable seems to be a half solution that tries
to please everyone and does not serve anyone well.  So I don't see the
point.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
