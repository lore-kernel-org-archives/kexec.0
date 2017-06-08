Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dIqaO-0000YC-Qf
 for kexec@lists.infradead.org; Thu, 08 Jun 2017 06:06:26 +0000
Received: from mail-vk0-f48.google.com (mail-vk0-f48.google.com
 [209.85.213.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B1EA123A0E
 for <kexec@lists.infradead.org>; Thu,  8 Jun 2017 06:06:03 +0000 (UTC)
Received: by mail-vk0-f48.google.com with SMTP id p62so13229506vkp.0
 for <kexec@lists.infradead.org>; Wed, 07 Jun 2017 23:06:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170607191453.28645.92256.stgit@tlendack-t1.amdoffice.net>
References: <20170607191309.28645.15241.stgit@tlendack-t1.amdoffice.net>
 <20170607191453.28645.92256.stgit@tlendack-t1.amdoffice.net>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 7 Jun 2017 23:05:42 -0700
Message-ID: <CALCETrVVhMf=zkiDNn_-hKDZLGXKFiwxuWkPmD5RJgHa5VUMiQ@mail.gmail.com>
Subject: Re: [PATCH v6 10/34] x86, x86/mm, x86/xen, olpc: Use __va() against
 just the physical address in cr3
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
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, X86 ML <x86@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Jun 7, 2017 at 12:14 PM, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> The cr3 register entry can contain the SME encryption bit that indicates
> the PGD is encrypted.  The encryption bit should not be used when creating
> a virtual address for the PGD table.
>
> Create a new function, read_cr3_pa(), that will extract the physical
> address from the cr3 register. This function is then used where a virtual
> address of the PGD needs to be created/used from the cr3 register.

This is going to conflict with:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/pcid&id=555c81e5d01a62b629ec426a2f50d27e2127c1df

We're both encountering the fact that CR3 munges the page table PA
with some other stuff, and some readers want to see the actual CR3
value and other readers just want the PA.  The thing I prefer about my
patch is that I get rid of read_cr3() entirely, forcing the patch to
update every single reader, making review and conflict resolution much
safer.

I'd be willing to send a patch tomorrow that just does the split into
__read_cr3() and read_cr3_pa() (I like your name better) and then we
can both base on top of it.  Would that make sense?

Also:

> +static inline unsigned long read_cr3_pa(void)
> +{
> +       return (read_cr3() & PHYSICAL_PAGE_MASK);
> +}

Is there any guarantee that the magic encryption bit is masked out in
PHYSICAL_PAGE_MASK?  The docs make it sound like it could be any bit.
(But if it's one of the low 12 bits, that would be quite confusing.)

--Andy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
