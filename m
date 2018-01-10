Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eZ6kb-0001fF-Dz
 for kexec@lists.infradead.org; Wed, 10 Jan 2018 03:08:27 +0000
Date: Wed, 10 Jan 2018 11:08:04 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 4.14 023/159] mm/sparsemem: Allocate mem_section at
 runtime for CONFIG_SPARSEMEM_EXTREME=y
Message-ID: <20180110030804.GB1744@dhcp-128-110.nay.redhat.com>
References: <20171222084623.668990192@linuxfoundation.org>
 <20171222084625.007160464@linuxfoundation.org>
 <1515302062.6507.18.camel@gmx.de>
 <20180108160444.2ol4fvgqbxnjmlpg@gmail.com>
 <20180108174653.7muglyihpngxp5tl@black.fi.intel.com>
 <20180109001303.dy73bpixsaegn4ol@node.shutemov.name>
 <20180109010927.GA2082@dhcp-128-65.nay.redhat.com>
 <20180109054131.GB1935@localhost.localdomain>
 <20180109072440.GA6521@dhcp-128-65.nay.redhat.com>
 <20180109090552.45ddfk2y25lf4uyn@node.shutemov.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180109090552.45ddfk2y25lf4uyn@node.shutemov.name>
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
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Galbraith <efault@gmx.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>, Cyrill Gorcunov <gorcunov@openvz.org>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

On Tue, Jan 09, 2018 at 12:05:52PM +0300, Kirill A. Shutemov wrote:
> On Tue, Jan 09, 2018 at 03:24:40PM +0800, Dave Young wrote:
> > On 01/09/18 at 01:41pm, Baoquan He wrote:
> > > On 01/09/18 at 09:09am, Dave Young wrote:
> > > 
> > > > As for the macro name, VMCOREINFO_SYMBOL_ARRAY sounds better.
> 
> Yep, that's better.
> 
> > > I still think using vmcoreinfo_append_str is better. Unless we replace
> > > all array variables with the newly added macro.
> > > 
> > > vmcoreinfo_append_str("SYMBOL(mem_section)=%lx\n",
> > >                                 (unsigned long)mem_section);
> > 
> > I have no strong opinion, either change all array uses or just introduce
> > the macro and start to use it from now on if we have similar array
> > symbols.
> 
> Do you need some action on my side or will you folks take care about this?

I think Baoquan was suggesting to update all array users in current code, if you can check every VMCOREINFO_SYMBOL and update all the arrays he will be happy. But if can not do it easily I'm fine with a VMCOREINFO_SYMBOL_ARRAY changes only now, we kdump people can do it later as well. 

> 
> -- 
>  Kirill A. Shutemov

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
