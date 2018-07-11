Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fdI2h-0004cF-DE
 for kexec@lists.infradead.org; Wed, 11 Jul 2018 16:32:44 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH] uts: Don't randomize "struct uts_namespace".
Date: Wed, 11 Jul 2018 16:31:15 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC035582C1@BPXM09GP.gisp.nec.co.jp>
References: <1530871650-3582-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CA+55aFzK5z4VQEMQAOqVHXpm+o_gd_eg5Vecck07E=WmoO6BFA@mail.gmail.com>
 <271dcdcd-d622-552c-338a-5eeca5e2b4a0@i-love.sakura.ne.jp>
In-Reply-To: <271dcdcd-d622-552c-338a-5eeca5e2b4a0@i-love.sakura.ne.jp>
Content-Language: en-US
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Kees Cook <keescook@chromium.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Tetsuo,

Thanks for your report.

On Friday, July 6, 2018 7:10 PM, Tetsuo Handa wrote:
> Hello Ken'ichi,
> 
> I noticed that makedumpfile ( https://sourceforge.net/p/makedumpfile/code/ )
> can no longer detect kernel version correctly because "struct uts_namespace"
> (which is exposed to userspace via vmcoreinfo) is subjected to randomization
> by GCC_PLUGIN_RANDSTRUCT kernel config option since 4.13.
> 
> The code was introduced by below commit.
> 
>   commit bfc8fe181c822ad0d8495ceda3c7109a407192f0
>   Author: ken1_ohmichi <ken1_ohmichi>
>   Date:   Fri Dec 22 07:41:14 2006 +0000
> 
>       linux-2.6.19 support.
>       On linux-2.6.18 or former, the release information could be gotten from
>       the symbol "system_utsname". But on linux-2.6.19, it can be done from the
>       symbol "init_uts_ns". A new makedumpfile can get the release information
>       from the existing symbol.
> 
> Can you detect kernel version without using "struct uts_namespace" ?

makedumpfile needs a whole "struct new_utsname" data in "struct uts_namespace"
because it has to write the data out to dump file header, so we need to add
the offset of uts_namespace.name to vmcoreinfo or get it from vmlinux.
But I'm not sure whether it is all to get makedumpfile working well with the
randomization, e.g. some additional offset exposures might be needed.

And I saw a report to the crash utility mailing list that crash also couldn't
work with the randomization due to a vmlinux issue, so if it is still not fixed,
even if makedumpfile (and kernel) is fixed, we cannot use crash.

* [Crash-utility] Using crash with structure layout randomized kernel
  https://www.redhat.com/archives/crash-utility/2018-January/thread.html#00035

Thanks,
Kazu

> 
> On 2018/07/07 1:11, Linus Torvalds wrote:
> > On Fri, Jul 6, 2018 at 3:07 AM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> I noticed that makedumpfile utility is failing to check kernel version, for
> >> it depends on offset of "struct uts_namespace"->name being sizeof(int).
> >
> > For something like this, we fix makedumpfile instead. This is not a
> > "user program" using system calls etc, this is something that delves
> > into the kernel dump and tries to make sense of it.
> >
> > Where is the makedumpfile source code? What is it trying to do, and why?
> >
> > One option is to just say "hey, you can't make much sense of a
> > randomized kernel dump anyway, so don't even try".
> >
> >                  Linus
> >
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
