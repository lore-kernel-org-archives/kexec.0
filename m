Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <20210517203343.3941777-1-arnd@kernel.org>
 <20210517203343.3941777-3-arnd@kernel.org>
 <f52b8bc9600443dab1814766552fe6bf@AcuMS.aculab.com>
In-Reply-To: <f52b8bc9600443dab1814766552fe6bf@AcuMS.aculab.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 19 May 2021 15:41:15 +0200
Message-ID: <CAK8P3a2WD+Y8hALadK1iCnaSijO8Xr+o-05s5KnJt292FENuMw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm: simplify compat_sys_move_pages
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
To: David Laight <David.Laight@aculab.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>, Eric Biederman <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Tue, May 18, 2021 at 10:49 PM David Laight <David.Laight@aculab.com> wrote:
> >
> > +static int put_compat_pages_array(const void __user *chunk_pages[],
> > +                               const void __user * __user *pages,
> > +                               unsigned long chunk_nr)
> > +{
>
> Should that be get_compat_pages_array() ?

Nice catch, thanks!

Fixed now.

       Arnd

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
