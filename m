Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fs9UX-0005NJ-97
 for kexec@lists.infradead.org; Tue, 21 Aug 2018 16:26:53 +0000
Received: by mail-pf1-x444.google.com with SMTP id l9-v6so8730689pff.9
 for <kexec@lists.infradead.org>; Tue, 21 Aug 2018 09:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180801210804.175176-1-ndesaulniers@google.com>
 <CAKwvOd=WZB=x86zqu=vFDoJgpWnfCj0K3qXv14vtysfv3ioi1w@mail.gmail.com>
 <CAKwvOd=qGTv1F3CsEeNjuJ93BD9zTnUekUHgvw4Ttpx7us5JdA@mail.gmail.com>
 <CAKwvOd=U0aMsUmBytK7vq=ORj+Npw7FqZ50EMEJPnmTG15N7dg@mail.gmail.com>
 <CA+55aFxHtbq=X9Jaes1qwVAhu5mx0eTahUjd7ijxgW44JjFaYQ@mail.gmail.com>
 <87bm9v28rh.fsf@xmission.com>
In-Reply-To: <87bm9v28rh.fsf@xmission.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 21 Aug 2018 09:26:24 -0700
Message-ID: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: prefer _THIS_IP_ to current_text_addr
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
To: "Eric W . Biederman" <ebiederm@xmission.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@verge.net.au>, Philippe Ombredanne <pombredanne@nexb.com>, Greg KH <gregkh@linuxfoundation.org>, x86@kernel.org, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, hpa@zytor.com, Nathan Chancellor <natechancellor@gmail.com>, Thomas Gleixner <tglx@linutronix.de>

On Tue, Aug 21, 2018 at 5:40 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> > On Mon, Aug 20, 2018 at 10:58 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> >>
> >> + akpm, Linus
> >>
> >> Bumping for review.
> >
> > Ugh. I am not personally a huge fan of this endless "fix up one at a time".
> >
> > Just do a patch that removes current_text_addr() entirely and be done
> > with it, if that's what we want the end result to be.
> >
> > Don't bother with these small "let's remove the remaining ones one by
> > one". Just get it over and done with.

Linus,
No problem. Will send a V2 that rips off the band-aid.

I explained my thoughts on the process more in
https://lkml.org/lkml/2018/8/1/1689, which akpm agreed with.  I was
hoping that I wouldn't have to bother you with a tree-wide change, but
if code review takes 3 weeks...

Also, I was hoping to save the small but many clean ups as starter
patches for some newbies that we're asking me how to get started
contributing to the kernel, but I can find other good first bugs for
them.

>
> One is generic code the other is assembly but the both appear to do the
> same thing without unexpected complexity.
>
> That said the patch earlier in this thread has clearly never been
> compiled as it is using THIS_IP instead of _THIS_IP_ and there is not
> a define of THIS_IP in the kernel.

Eric,
Please triple check your email client or whatever you're using to
download patches, as I suspect one of them may be stripping
leading+trailing underscores.  That would be quite problematic for
code review or applying patch files.  I've seen some text renderers
treat the underscores as markdown and italicize the contained word.
https://lkml.org/lkml/2018/8/1/1608 shows the underscores.

-- 
Thanks,
~Nick Desaulniers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
