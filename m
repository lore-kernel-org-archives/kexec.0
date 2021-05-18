Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <20210517203343.3941777-1-arnd@kernel.org>
 <20210517203343.3941777-2-arnd@kernel.org>
 <m1bl982m8c.fsf@fess.ebiederm.org>
 <CAK8P3a27_z8zk6j5W4n+u3g2e90v-h+3AbaTZ6YjCQ0B7AbJaA@mail.gmail.com>
In-Reply-To: <CAK8P3a27_z8zk6j5W4n+u3g2e90v-h+3AbaTZ6YjCQ0B7AbJaA@mail.gmail.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 18 May 2021 16:17:53 +0200
Message-ID: <CAK8P3a277VggQbBnXUzpwP7TKMj-S_z6rDMYYxfjyQmzGJdpCA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] kexec: simplify compat_sys_kexec_load
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org

On Tue, May 18, 2021 at 4:05 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, May 18, 2021 at 3:41 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> > Arnd Bergmann <arnd@kernel.org> writes:
> >
> > > From: Arnd Bergmann <arnd@arndb.de>KEXEC_ARCH_DEFAULT
> > >
> > > The compat version of sys_kexec_load() uses compat_alloc_user_space to
> > > convert the user-provided arguments into the native format.
> > >
> > > Move the conversion into the regular implementation with
> > > an in_compat_syscall() check to simplify it and avoid the
> > > compat_alloc_user_space() call.
> > >
> > > compat_sys_kexec_load() now behaves the same as sys_kexec_load().
> >
> > Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >KEXEC_ARCH_DEFAULT
> > The patch is wrong.
> >
> > The logic between the compat entry point and the ordinary entry point
> > are by necessity different.   This unifies the logic and breaks the compat
> > entry point.
> >
> > The fundamentally necessity is that the code being loaded needs to know
> > which mode the kernel is running in so it can safely transition to the
> > new kernel.
> >
> > Given that the two entry points fundamentally need different logic,
> > and that difference was not preserved and the goal of this patchset
> > was to unify that which fundamentally needs to be different.  I don't
> > think this patch series makes any sense for kexec.
>
> Sorry, I'm not following that explanation. Can you clarify what different
> modes of the kernel you are referring to here, and how my patch
> changes this?

I think I figured it out now myself after comparing the two functions:

--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -269,7 +269,8 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry,
unsigned long, nr_segments,

        /* Verify we are on the appropriate architecture */
        if (((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH) &&
-               ((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
+               (in_compat_syscall() ||
+               ((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT)))
                return -EINVAL;

        /* Because we write directly to the reserved memory

Not sure if that's the best way of doing it, but it looks like folding this
in restores the current behavior.

        Arnd

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
