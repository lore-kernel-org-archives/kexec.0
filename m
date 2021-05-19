Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <20210517203343.3941777-1-arnd@kernel.org>
 <20210517203343.3941777-2-arnd@kernel.org>
 <m1bl982m8c.fsf@fess.ebiederm.org>
 <CAK8P3a27_z8zk6j5W4n+u3g2e90v-h+3AbaTZ6YjCQ0B7AbJaA@mail.gmail.com>
 <CAK8P3a277VggQbBnXUzpwP7TKMj-S_z6rDMYYxfjyQmzGJdpCA@mail.gmail.com>
 <m1y2cbzmnw.fsf@fess.ebiederm.org>
In-Reply-To: <m1y2cbzmnw.fsf@fess.ebiederm.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 19 May 2021 11:55:05 +0200
Message-ID: <CAK8P3a2kjF5v9OyNL+8m_855xqjcW3MWfRrigmWirAaEk1O6nw@mail.gmail.com>
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

On Wed, May 19, 2021 at 12:45 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Arnd Bergmann <arnd@kernel.org> writes:
> > On Tue, May 18, 2021 at 4:05 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >> On Tue, May 18, 2021 at 3:41 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I think something like the untested diff below is enough to get rid of
> compat_alloc_user cleanly.
>
> Certainly it should be enough to give any idea what I am thinking.

Yes, that looks sufficient to me. I had started a slightly different
approach by trying
to move the kimage_alloc_init() into the top-level entry points to
avoid the extra
kmalloc, but that got rather complicated, and your patch is simpler overall.

The allocation could still be combined with kexec_load_check() into a new
function to reduce the number of duplicate lines, but if you think the current
version is ok, then I'll leave this part as it is.

I've fixed a duplicate kfree() and some whitespace damage, and rebased the
rest of my series on top of this to give it a spin on the build test boxes.
I'll send a v4 series once I have made sure there are no build-time regressions.

Can I add your Signed-off-by for the patch?
Is there a set of tests I should run on it?

      Arnd

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
