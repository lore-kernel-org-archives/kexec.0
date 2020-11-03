Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <20201102123151.2860165-1-arnd@kernel.org>
 <20201102123151.2860165-5-arnd@kernel.org>
 <20201103083703.GD9092@infradead.org>
In-Reply-To: <20201103083703.GD9092@infradead.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 3 Nov 2020 10:45:54 +0100
Message-ID: <CAK8P3a2m_VYiTY7Rg+3kfohPc2W=jHLh7dF4aVffSpwMa7C=4Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] compat: remove some compat entry points
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Borislav Petkov <bp@alien8.de>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>

On Tue, Nov 3, 2020 at 9:38 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Nov 02, 2020 at 01:31:51PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > These are all handled correctly when calling the native
> > system call entry point, so remove the special cases.
>
> Ok, this is where you do it.  I think this belongs into the main
> patches.

I had it there originally, I guess I should have left it there ;-)

When I changed it, I was considering to do the same for additional
syscalls that have very small differences now (timer_create,
rt_sigqueueinfo, rt_sigpending, recvmsg, sendmsg) and use
in_compat_syscall() there, but then I decided against that.

In the end, I did like the split, as I found the smaller three
patches that contain the real change easier to review, and
it turns the larger patch at the end into a more obvious
transformation.

      Arnd

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
