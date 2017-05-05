Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d6X78-0004mQ-Bn
 for kexec@lists.infradead.org; Fri, 05 May 2017 06:53:20 +0000
Received: by mail-wm0-x244.google.com with SMTP id u65so7759764wmu.3
 for <kexec@lists.infradead.org>; Thu, 04 May 2017 23:52:57 -0700 (PDT)
Date: Fri, 5 May 2017 08:52:53 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 2/2] x86_64/kexec: Use PUD level 1GB page for identity
 mapping if available
Message-ID: <20170505065253.s5yv7c2cxgfcf4i3@gmail.com>
References: <1493862171-8799-1-git-send-email-xlpang@redhat.com>
 <1493862171-8799-2-git-send-email-xlpang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1493862171-8799-2-git-send-email-xlpang@redhat.com>
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
To: Xunlei Pang <xlpang@redhat.com>
Cc: Yinghai Lu <yinghai@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Eric Biederman <ebiederm@xmission.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>


* Xunlei Pang <xlpang@redhat.com> wrote:

> @@ -122,6 +122,10 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
>  
>  	level4p = (pgd_t *)__va(start_pgtable);
>  	clear_page(level4p);
> +
> +	if (direct_gbpages)
> +		info.direct_gbpages = true;

No, this should be keyed off the CPU feature (X86_FEATURE_GBPAGES) automatically, 
not set blindly! AFAICS this patch will crash kexec on any CPU that does not 
support gbpages.

I only noticed this problem after having fixed/enhanced all the changelogs - so 
please pick up the new changelog up from the log below.

Thanks,

	Ingo


============================>

Author: Xunlei Pang <xlpang@redhat.com>

x86/mm: Add support for gbpages to kernel_ident_mapping_init()

Kernel identity mappings on x86-64 kernels are created in two
ways: by the early x86 boot code, or by kernel_ident_mapping_init().

Native kernels (which is the dominant usecase) use the former,
but the kexec and the hibernation code uses kernel_ident_mapping_init().

There's a subtle difference between these two ways of how identity
mappings are created, the current kernel_ident_mapping_init() code
creates identity mappings always using 2MB page(PMD level) - while
the native kernel boot path also utilizes gbpages where available.

This difference is suboptimal both for performance and for memory
usage: kernel_ident_mapping_init() needs to allocate pages for the
page tables when creating the new identity mappings.

This patch adds 1GB page(PUD level) support to kernel_ident_mapping_init()
to address these concerns.

The primary advantage would be better TLB coverage/performance,
because we'd utilize 1GB TLBs instead of 2MB ones.

It is also useful for machines with large number of memory to
save paging structure allocations(around 4MB/TB using 2MB page)
when setting identity mappings for all the memory, after using
1GB page it will consume only 8KB/TB.

( Note that this change alone does not activate gbpages in kexec,
  we are doing that in a separate patch. )


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
