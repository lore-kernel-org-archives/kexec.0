Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <20210517203343.3941777-1-arnd@kernel.org>
 <20210517203343.3941777-2-arnd@kernel.org>
 <YKNgz7YaAq0awwNQ@infradead.org>
In-Reply-To: <YKNgz7YaAq0awwNQ@infradead.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 18 May 2021 09:47:27 +0200
Message-ID: <CAK8P3a2rWoOx22focNgLM=+BDocbgvC7ZNY8ymogmsuaqah8tg@mail.gmail.com>
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>, Eric Biederman <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org

On Tue, May 18, 2021 at 8:38 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +     if (in_compat_syscall())
> > +             return copy_user_compat_segment_list(image, nr_segments, segments);
>
> Annoying overly lone line here.

Oops, I was sure I had fixed all of these when you pointed this out before.
I probably rebased a slightly older branch that did not have the fixes.

> Otherwise:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks,

       Arnd

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
