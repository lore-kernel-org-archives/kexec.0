Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxU1q-000u2o-2i
 for kexec@lists.infradead.org; Wed, 15 Dec 2021 13:09:07 +0000
Date: Wed, 15 Dec 2021 14:09:03 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] arm64/crashdump: deduce paddr of _text based on kernel
 code size
Message-ID: <20211215130903.GC4314@vergenet.net>
References: <20211210025733.52605-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211210025733.52605-1-piliu@redhat.com>
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
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org

On Fri, Dec 10, 2021 at 10:57:33AM +0800, Pingfan Liu wrote:
> kexec-tools commit 61b8c79b0fb7 ("arm64/crashdump-arm64: deduce the
> paddr of _text") tries to deduce the paddr of _text, but turns out
> partially.
> 
> That commit is based on "The Image must be placed text_offset bytes from
> a 2MB aligned base address anywhere in usable system RAM and called
> there" in linux/Documentation/arm64/booting.rst, plus text_offset field
> is zero.
> 
> But in practice, some boot loaders does not obey the convention, and
> still boots up the kernel successfully.
> 
> Revisiting kernel commit e2a073dde921 ("arm64: omit [_text, _stext) from
> permanent kernel mapping"), the kernel code size changes from (unsigned
> long)__init_begin - (unsigned long)_text to (unsigned long)__init_begin
> - (unsigned long)_stext
> 
> And it should be a better factor to decide which label starts the
> "Kernel code" in /proc/iomem.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Simon Horman <horms@verge.net.au>
> To: kexec@lists.infradead.org

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
