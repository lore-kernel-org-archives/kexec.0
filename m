Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fvNTc-0003zL-J8
 for kexec@lists.infradead.org; Thu, 30 Aug 2018 13:59:19 +0000
Received: by mail-pg1-x543.google.com with SMTP id r1-v6so3921798pgp.11
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2018 06:59:02 -0700 (PDT)
Date: Thu, 30 Aug 2018 16:58:56 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 0/3] Add restrictions for kexec/kdump jumping between
 5-level and 4-level kernel
Message-ID: <20180830135855.rylamc7mx2ur3tab@kshutemo-mobl1>
References: <20180829141624.13985-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180829141624.13985-1-bhe@redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org, kirill.shutemov@linux.intel.com

On Wed, Aug 29, 2018 at 10:16:21PM +0800, Baoquan He wrote:
> This was suggested by Kirill several months ago, I worked out several
> patches to fix, then interrupted by other issues. So sort them out
> now and post for reviewing.

Thanks for doing this.

> The current upstream kernel supports 5-level paging mode and supports
> dynamically choosing paging mode during bootup according to kernel
> image, hardware and kernel parameter setting. This flexibility brings
> several issues for kexec/kdump:
> 1)
> Switching between paging modes, requires changes into target kernel.
> It means you cannot kexec() 4-level paging kernel from 5-level paging
> kernel if 4-level paging kernel doesn't include changes. 
> 
> 2)
> Switching from 5-level paging to 4-level paging kernel would fail, if
> kexec() put kernel image above 64TiB of memory.

I'm not entirely sure that 64TiB is the limit here. Technically, 4-level
paging allows to address 256TiB in 1-to-1 mapping. We just don't have
machines with that wide physical address space (which don't support
5-level paging too).

What is your reasoning about 64TiB limit?

-- 
 Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
