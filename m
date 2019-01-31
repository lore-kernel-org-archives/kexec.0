Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp9vZ-0005Bk-NE
 for kexec@lists.infradead.org; Thu, 31 Jan 2019 10:50:41 +0000
Date: Thu, 31 Jan 2019 11:50:19 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190131105019.GB6749@zn.tnic>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
 <CAFgQCTtrBrt9CEY=3YiVm7ADD+8oh8bYmatu=3vU92K2_C45ww@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFgQCTtrBrt9CEY=3YiVm7ADD+8oh8bYmatu=3vU92K2_C45ww@mail.gmail.com>
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
To: Pingfan Liu <kernelfans@gmail.com>
Cc: x86@kernel.org, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com

On Tue, Jan 29, 2019 at 01:51:45PM +0800, Pingfan Liu wrote:
> Sorry, can not catch up with you. Do you suggestion
> memblock_find_in_range(0, kernel_start) and
> memblock_find_in_range(kernel_end, mem_end)? But the memory is
> truncated into fraction by many component which call
> memblock_reserve(), besides kernel.

extract_kernel() selects the physical address where the place the
kernel. You can use that physical address to figure out where to
allocate the crash kernel range.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
