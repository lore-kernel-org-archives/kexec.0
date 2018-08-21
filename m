Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fs5xz-00059r-9K
 for kexec@lists.infradead.org; Tue, 21 Aug 2018 12:41:00 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20180801210804.175176-1-ndesaulniers@google.com>
 <CAKwvOd=WZB=x86zqu=vFDoJgpWnfCj0K3qXv14vtysfv3ioi1w@mail.gmail.com>
 <CAKwvOd=qGTv1F3CsEeNjuJ93BD9zTnUekUHgvw4Ttpx7us5JdA@mail.gmail.com>
 <CAKwvOd=U0aMsUmBytK7vq=ORj+Npw7FqZ50EMEJPnmTG15N7dg@mail.gmail.com>
 <CA+55aFxHtbq=X9Jaes1qwVAhu5mx0eTahUjd7ijxgW44JjFaYQ@mail.gmail.com>
Date: Tue, 21 Aug 2018 14:40:02 +0200
In-Reply-To: <CA+55aFxHtbq=X9Jaes1qwVAhu5mx0eTahUjd7ijxgW44JjFaYQ@mail.gmail.com>
 (Linus Torvalds's message of "Mon, 20 Aug 2018 16:48:38 -0700")
Message-ID: <87bm9v28rh.fsf@xmission.com>
MIME-Version: 1.0
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, the arch/x86 maintainers <x86@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>, natechancellor@gmail.com, Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Aug 20, 2018 at 10:58 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>>
>> + akpm, Linus
>>
>> Bumping for review.
>
> Ugh. I am not personally a huge fan of this endless "fix up one at a time".
>
> Just do a patch that removes current_text_addr() entirely and be done
> with it, if that's what we want the end result to be.
>
> Don't bother with these small "let's remove the remaining ones one by
> one". Just get it over and done with.

One is generic code the other is assembly but the both appear to do the
same thing without unexpected complexity.

That said the patch earlier in this thread has clearly never been
compiled as it is using THIS_IP instead of _THIS_IP_ and there is not
a define of THIS_IP in the kernel.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
