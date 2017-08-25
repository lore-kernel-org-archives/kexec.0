Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dl2pW-0002Kl-Vr
 for kexec@lists.infradead.org; Fri, 25 Aug 2017 00:50:37 +0000
Received: by mail-pg0-x233.google.com with SMTP id 63so5979987pgc.2
 for <kexec@lists.infradead.org>; Thu, 24 Aug 2017 17:50:14 -0700 (PDT)
Date: Fri, 25 Aug 2017 09:50:07 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH 03/14] resource: add walk_system_ram_res_rev()
Message-ID: <20170825005006.GB6434@akashi-kouhiroshi-no-MacBook-Air.local>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-4-takahiro.akashi@linaro.org>
 <CAKv+Gu_UfeDf13RPUejVqz0y=QjSCGhPn6fTTCyLWHY=iu-4BA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_UfeDf13RPUejVqz0y=QjSCGhPn6fTTCyLWHY=iu-4BA@mail.gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Baoquan He <bhe@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, "David S. Miller" <davem@davemloft.net>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Aug 24, 2017 at 10:06:28AM +0100, Ard Biesheuvel wrote:
> On 24 August 2017 at 09:18, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> > +       /* create a list */
> > +       rams = vmalloc(sizeof(struct resource) * count);
> > +       if (!rams)
> > +               return ret;
> > +
> > +       res.start = start;
> > +       res.end = end;
> > +       res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> > +       orig_end = res.end;
> > +       i = 0;
> > +       while ((res.start < res.end) &&
> > +               (!find_next_iomem_res(&res, IORES_DESC_NONE, true))) {
> > +               if (i >= count) {
> > +                       /* unlikely but */
> > +                       vfree(rams);
> > +                       count += 16;
> 
> If the count is likely to be < 16, why are we using vmalloc() here?

Ah, you're right :)

-Takahiro AKASHI

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
