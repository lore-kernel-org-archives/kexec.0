Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ob0-x22e.google.com ([2607:f8b0:4003:c01::22e])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vqt73-00045w-Ss
 for kexec@lists.infradead.org; Wed, 11 Dec 2013 23:22:43 +0000
Received: by mail-ob0-f174.google.com with SMTP id wn1so7722259obc.19
 for <kexec@lists.infradead.org>; Wed, 11 Dec 2013 15:22:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87k3fbuggk.fsf@xmission.com>
References: <20131210001620.GA7938@www.outflux.net>
 <87vbyvxojs.fsf@xmission.com>
 <CAGXu5j+hCf8zkO3FEJ=ZO++unnpzL8GLivSNqy=dYFzJah0WCg@mail.gmail.com>
 <87k3fbuggk.fsf@xmission.com>
Date: Wed, 11 Dec 2013 15:22:18 -0800
Message-ID: <CAGXu5j+i1CfUqrFtwQUHC92n=qvFjKaqJeLh7Bn7aEFBE1cixw@mail.gmail.com>
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
Cc: Matthew Garrett <matthew.garrett@nebula.com>, Rik van Riel <riel@redhat.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, Rob Landley <rob@landley.net>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Wed, Dec 11, 2013 at 3:15 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Kees Cook <keescook@chromium.org> writes:
>
>> On Wed, Dec 11, 2013 at 9:52 AM, Eric W. Biederman
>> <ebiederm@xmission.com> wrote:
>>> Kees Cook <keescook@chromium.org> writes:
>>>
>>>> For general-purpose (i.e. distro) kernel builds it makes sense to build with
>>>> CONFIG_KEXEC to allow end users to choose what kind of things they want to do
>>>> with kexec. However, in the face of trying to lock down a system with such
>>>> a kernel, there needs to be a way to disable kexec (much like module loading
>>>> can be disabled). Without this, it is too easy for the root user to modify
>>>> kernel memory even when CONFIG_STRICT_DEVMEM and modules_disabled are
>>>> set.
>>>
>>> So let me get this straight.  You object to what happens in sys_reboot
>>> so you patch sys_kexec_load?
>>
>> Yes; it's the entry point for loading the image used for crashes and
>> LINUX_REBOOT_CMD_KEXEC.
>>
>>> You give someone the privilege to boot whatever they want and yet you
>>> don't want to support them booting whatever they want?
>>>
>>> I'm sorry my brain is hurting trying to understand the logic of this
>>> patch.
>>
>> I'm not trying to claim this fixes all attack vectors from a root
>> user. That is exceedingly hard. :) However, kexec gives the root user
>> a trivial (and undetectable) way to modify the running kernel.
>> Providing an option to block sys_kexec_load for systems that will
>> never use it (or will use it once at startup) is valuable in several
>> situations. There's no reason to make an attacker's job easier, and
>> this doesn't get in any one else's way.
>
> I am simply trying to point out your patch is incomplete and silly as
> presented.
>
> LINUX_REBOOT_CMD_KEXEC should be disabled if you are calling the sysctl
> kexec_disable.  If you want to it to be kexec_load_disable please call
> it that.  A kexec_load_disable is a different thing than a
> kexec_disable.
>
> A kexec_disable would block both sys_kexec_load and
> sys_reboot(LINUX_REBOOT_CMD_KEXEC) and would remove any staged kexec
> images.  Allowing you to stop considering kexec past that point from a
> security analysis perspective.  That is what it sounds like you want.
>
> What I am asking for is an problem description and an implementation
> that are in sync, and a problem description that people can look at and
> say was this a complete implementation.
>
> Right now I can not tell what was intended so I can not truly tell if
> the patch is correct.  Code with that property does not serve anyone any
> good, especially as the kernel evolves.
>
> So please decide if you want kexec_disable or kexec_load_disable, or if
> you want something a little more nuanced.
>
> Right now I think a full and complete kexec_disable makes sense.  I
> probably won't use it but I think it makes sense.  Your patch
> implementiong kexec_load_disable seems to be a half solution that tries
> to please everyone and does not serve anyone well.  So I don't see the
> point.

Sure, it seems reasonable to clarify it's purpose. I would like block
_changes_ to the kexec image. In the case of systems not using kexec,
this freezes it to "no kexec image", for those with a crash kernel, it
freezes it to just that image, and makes sure it can't change until
reboot. Blocking LINUX_REBOOT_CMD_KEXEC doesn't make sense in the
latter sense, so it seems like changing the sysctl to
"kexec_load_disable" is the sensible direction. I can send a v3 that
changes the name and clarifies the purpose and potential uses.

-Kees

-- 
Kees Cook
Chrome OS Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
