Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eaJMx-0000QL-50
 for kexec@lists.infradead.org; Sat, 13 Jan 2018 10:49:00 +0000
Received: by mail-wr0-x244.google.com with SMTP id w50so7389313wrc.11
 for <kexec@lists.infradead.org>; Sat, 13 Jan 2018 02:48:48 -0800 (PST)
Date: Sat, 13 Jan 2018 11:48:38 +0100
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] kdump: Write a correct address of mem_section into
 vmcoreinfo
Message-ID: <20180113104838.ht57uooqk3fo546o@gmail.com>
References: <20180112162532.35896-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180112162532.35896-1-kirill.shutemov@linux.intel.com>
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
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Baoquan He <bhe@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>


* Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

> Depending on configuration mem_section can now be an array or a pointer
> to an array allocated dynamically. In most cases, we can continue to refer
> to it as 'mem_section' regardless of what it is.
> 
> But there's one exception: '&mem_section' means "address of the array" if
> mem_section is an array, but if mem_section is a pointer, it would mean
> "address of the pointer".
> 
> We've stepped onto this in kdump code. VMCOREINFO_SYMBOL(mem_section)
> writes down address of pointer into vmcoreinfo, not array as we wanted.
> 
> Let's introduce VMCOREINFO_SYMBOL_ARRAY() that would handle the
> situation correctly for both cases.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 83e3c48729d9 ("mm/sparsemem: Allocate mem_section at runtime for CONFIG_SPARSEMEM_EXTREME=y")
> Cc: stable@vger.kernel.org
> Acked-by: Baoquan He <bhe@redhat.com>
> Acked-by: Dave Young <dyoung@redhat.com>

You forgot the Reported-by - I added that to the commit.

Thanks,

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
