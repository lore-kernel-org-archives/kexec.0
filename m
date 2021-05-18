Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <20210517203343.3941777-1-arnd@kernel.org>
 <20210517203343.3941777-2-arnd@kernel.org>
 <m1y2cc3d97.fsf@fess.ebiederm.org> <YKNhXQ883lRbqQGA@infradead.org>
In-Reply-To: <YKNhXQ883lRbqQGA@infradead.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 18 May 2021 09:44:20 +0200
Message-ID: <CAK8P3a0ecwY1hwDqhW7DyQMGR1a7xiQND=1s7Pd9OP7i5+hoWg@mail.gmail.com>
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
To: Christoph Hellwig <hch@infradead.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-arch <linux-arch@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org

On Tue, May 18, 2021 at 8:40 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, May 17, 2021 at 10:57:24PM -0500, Eric W. Biederman wrote:
> > We open ourselves up to bugs whenever we lie to the type system.
> >
> > Skimming through the code it looks like it should be possible
> > to not need the in_compat_syscall and the casts to the wrong
> > type by changing the order of the code a little bit.

There are obviously other ways of doing the same. The reason for doing it
this specific way is so I can eliminate the compat entry point entirely in
patch 4/4.

> What kind of bug do you expect?  We must only copy from user addresses
> once anyway.  I've never seen bugs due the use of in_compat_syscall,
> but plenty due to cruft code trying to avoid it.

Right, I've used the same approach of passing a native-typed __user pointer
and converting it in a copy_from_user/copy_to_user wrapper in a number of
other places, as this tends to produce the most readable version by
concentrating the tricky logic in the one place that already has to be careful.

Most of the bugs I've seen with compat code are from duplicated code paths
that diverge over time when a bugfix for the native version is applied
incorrectly
or not at all to the compat version.

        Arnd

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
