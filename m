Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 4/4] compat: remove some compat entry points
In-Reply-To: <20210517203343.3941777-5-arnd@kernel.org>
References: <20210517203343.3941777-1-arnd@kernel.org>
 <20210517203343.3941777-5-arnd@kernel.org>
Date: Wed, 19 May 2021 22:33:07 +0200
Message-ID: <87h7iycvlo.ffs@nanos.tec.linutronix.de>
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
To: Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>, Eric Biederman <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org

On Mon, May 17 2021 at 22:33, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> These are all handled correctly when calling the native
> system call entry point, so remove the special cases.
>  arch/x86/entry/syscall_x32.c              |  2 ++
>  arch/x86/entry/syscalls/syscall_32.tbl    |  6 ++--
>  arch/x86/entry/syscalls/syscall_64.tbl    |  4 +--

That conflicts with

  https://lore.kernel.org/lkml/20210517073815.97426-1-masahiroy@kernel.org/

which I'm picking up. We have more changes in that area coming in.

Thanks,

        tglx



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
