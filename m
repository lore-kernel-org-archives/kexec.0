Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <20200918132439.1475479-1-arnd@arndb.de>
 <20200918132439.1475479-5-arnd@arndb.de>
 <20200919054148.GL30063@infradead.org>
In-Reply-To: <20200919054148.GL30063@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 26 Sep 2020 17:14:46 +0200
Message-ID: <CAK8P3a0VKObd8BR0x-+fHKizEwhYJ-8YwEN6rKhTHU34G=ADbg@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: remove compat numa syscalls
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
Cc: linux-arch <linux-arch@vger.kernel.org>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>

On Sat, Sep 19, 2020 at 7:41 AM Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Sep 18, 2020 at 03:24:39PM +0200, Arnd Bergmann wrote:

> > +static int get_bitmap(unsigned long *mask, const unsigned long __user *nmask,
> > +                   unsigned long maxnode)
> > +{
> > +     unsigned long nlongs = BITS_TO_LONGS(maxnode);
> > +     int ret;
> > +
> > +     if (in_compat_syscall())
> > +             ret = compat_get_bitmap(mask, (void __user *)nmask, maxnode);
>
> I'd either pass void __user all the way, or do an explicit case from
> the native to the compat version in the compat handler.

Changed to

        if (in_compat_syscall())
                ret = compat_get_bitmap(mask,
                                (const compat_ulong_t __user *)nmask,
                                maxnode);

> > +     else
> > +             ret = copy_from_user(mask, nmask, nlongs*sizeof(unsigned long));
>
> That whole BITS_TO_LONGS(b) * sizeof(unsigned long) pattern is
> duplicated in various places including the checking of compat vs native
> and probably want a helper that includes the in_compat_syscall() check.

I don't see what you mean here. I can see how having the helper would
simplify copy_nodes_to_user(), but not how it can be shared with the
use in get_bitmap()/get_nodes().

      Arnd

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
