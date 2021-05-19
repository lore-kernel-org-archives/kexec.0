Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <20210517203343.3941777-1-arnd@kernel.org>
 <20210517203343.3941777-5-arnd@kernel.org>
 <87h7iycvlo.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87h7iycvlo.ffs@nanos.tec.linutronix.de>
From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 19 May 2021 23:00:04 +0200
Message-ID: <CAK8P3a0KULCWrGZt=C9uWDgqNf184KC-uaK9rN8ZXjTG1HAqsw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] compat: remove some compat entry points
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
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>, Eric Biederman <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org

On Wed, May 19, 2021 at 10:33 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, May 17 2021 at 22:33, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > These are all handled correctly when calling the native
> > system call entry point, so remove the special cases.
> >  arch/x86/entry/syscall_x32.c              |  2 ++
> >  arch/x86/entry/syscalls/syscall_32.tbl    |  6 ++--
> >  arch/x86/entry/syscalls/syscall_64.tbl    |  4 +--
>
> That conflicts with
>
>   https://lore.kernel.org/lkml/20210517073815.97426-1-masahiroy@kernel.org/
>
> which I'm picking up. We have more changes in that area coming in.

Ok, thanks for the heads-up. I'll try a merge or rebase to see how this can be
handled. If both the drivers/net and drivers/media get picked up for 5.14, maybe
the rebased patches can go through -mm on top, along with the final
removal of compat_alloc_user_space()/copy_in_user(). If not, I suppose these
four patches can also wait another release.

       Arnd

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
