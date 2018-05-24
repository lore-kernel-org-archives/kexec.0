Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fLl6z-0002k8-B3
 for kexec@lists.infradead.org; Thu, 24 May 2018 07:56:58 +0000
Date: Thu, 24 May 2018 15:56:15 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] kdump: add default crashkernel reserve kernel config
 options
Message-ID: <20180524075615.GC1940@dhcp-128-65.nay.redhat.com>
References: <20180521025337.GA4627@dhcp-128-65.nay.redhat.com>
 <20180521120215.117d963a7619eb0d1f54bced@linux-foundation.org>
 <20180523070641.GA1689@dhcp-128-65.nay.redhat.com>
 <877enucqr0.fsf@xmission.com>
 <20180523222236.5a96732e@ezekiel.suse.cz>
 <20180524014905.GB2031@dhcp-128-65.nay.redhat.com>
 <20180524085708.31aa311d@ezekiel.suse.cz>
 <20180524072627.GA1940@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180524072627.GA1940@dhcp-128-65.nay.redhat.com>
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: dzickus@redhat.com, Neil Horman <nhorman@redhat.com>, Tony Luck <tony.luck@intel.com>, bhe@redhat.com, Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Hari Bathini <hbathini@linux.vnet.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cong Wang <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

> > > Instead of setting aside a significant chunk of memory nobody can use,
> > > [...] reserve a significant chunk of memory that the kernel is prevented
> > > from using [...], but applications are free to use it.
> > 
> > That works great, because user space pages are filtered out in the
> > common case, so they can be used freely by the panic kernel.
> 
> Good suggestion. I have been reading that posts already at the same time before I saw
> this reply from you :)
> 
> That could be a good idea and worth to discuss more.  I cced Hari
> already in the thread. Hari, is it possible for you to extend your
> idea to general use, ie. shared by both kdump and fadump?  Anyway I
> think that is another topic we can discuss separately.

BTW, I remember we had some Red hat internal discussion about CMA previously
there is a problem, that is we have crashkernel=,high for reserving high
memory and ,low for low memory, we were not sure if CMA can handle this
case.

Thanks
Dave
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
