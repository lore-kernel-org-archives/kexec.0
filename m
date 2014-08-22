Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XKo9I-0003Ar-32
 for kexec@lists.infradead.org; Fri, 22 Aug 2014 12:40:56 +0000
Date: Fri, 22 Aug 2014 08:40:32 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kexec fails to boot kernels where CONFIG_RANDOMIZE_BASE=y is set
Message-ID: <20140822124032.GE5954@redhat.com>
References: <53F11882.3060803@whissi.de> <20140818145718.GD4745@redhat.com>
 <20140819090724.GB21724@dhcp-17-37.nay.redhat.com>
 <20140820143315.GC16303@redhat.com>
 <CAGXu5jLxEoKEy0nw8qj0MW0f2Vpog-DtDi7OwnUrkh7jGSkdWw@mail.gmail.com>
 <20140821181000.GB21891@redhat.com>
 <20140822031941.GB2651@dhcp-17-37.nay.redhat.com>
 <20140822115902.GA12681@dhcp-16-116.nay.redhat.com>
 <53F737ED.5070908@whissi.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53F737ED.5070908@whissi.de>
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
To: "Thomas D." <whissi@whissi.de>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, WANG Chao <chaowang@redhat.com>, Baoquan He <bhe@redhat.com>, Kees Cook <keescook@chromium.org>

On Fri, Aug 22, 2014 at 02:30:37PM +0200, Thomas D. wrote:
> Hi,
> 
> Baoquan He wrote:
> > Could you test below patch? 
> > 
> > 
> > This is patch is from Lu Yinghai.
> > ---
> >  arch/x86/boot/compressed/misc.c |   14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > Index: linux-2.6/arch/x86/boot/compressed/misc.c
> > ===================================================================
> > --- linux-2.6.orig/arch/x86/boot/compressed/misc.c
> > +++ linux-2.6/arch/x86/boot/compressed/misc.c
> > [...]
> 
> Sorry, I don't know how to apply this patch.
> 
> I am building kexec-tools from
> git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git master
> branch and there is no misc.c?!

This is a kernel patch and not kexec-tools patch.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
