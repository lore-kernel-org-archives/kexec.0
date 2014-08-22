Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from borg.tf-network.de ([62.75.218.204])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XKnzj-0006AW-Np
 for kexec@lists.infradead.org; Fri, 22 Aug 2014 12:31:04 +0000
Message-ID: <53F737ED.5070908@whissi.de>
Date: Fri, 22 Aug 2014 14:30:37 +0200
From: "Thomas D." <whissi@whissi.de>
MIME-Version: 1.0
Subject: Re: kexec fails to boot kernels where CONFIG_RANDOMIZE_BASE=y is set
References: <53F11882.3060803@whissi.de> <20140818145718.GD4745@redhat.com>
 <20140819090724.GB21724@dhcp-17-37.nay.redhat.com>
 <20140820143315.GC16303@redhat.com>
 <CAGXu5jLxEoKEy0nw8qj0MW0f2Vpog-DtDi7OwnUrkh7jGSkdWw@mail.gmail.com>
 <20140821181000.GB21891@redhat.com>
 <20140822031941.GB2651@dhcp-17-37.nay.redhat.com>
 <20140822115902.GA12681@dhcp-16-116.nay.redhat.com>
In-Reply-To: <20140822115902.GA12681@dhcp-16-116.nay.redhat.com>
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
To: Baoquan He <bhe@redhat.com>, WANG Chao <chaowang@redhat.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, Kees Cook <keescook@chromium.org>, Vivek Goyal <vgoyal@redhat.com>

Hi,

Baoquan He wrote:
> Could you test below patch? 
> 
> 
> This is patch is from Lu Yinghai.
> ---
>  arch/x86/boot/compressed/misc.c |   14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> Index: linux-2.6/arch/x86/boot/compressed/misc.c
> ===================================================================
> --- linux-2.6.orig/arch/x86/boot/compressed/misc.c
> +++ linux-2.6/arch/x86/boot/compressed/misc.c
> [...]

Sorry, I don't know how to apply this patch.

I am building kexec-tools from
git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git master
branch and there is no misc.c?!


-Thomas


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
