Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bzn5t-0004Nw-Rw
 for kexec@lists.infradead.org; Thu, 27 Oct 2016 15:59:55 +0000
Received: by mail-qt0-f174.google.com with SMTP id q7so26938501qtq.1
 for <kexec@lists.infradead.org>; Thu, 27 Oct 2016 08:59:33 -0700 (PDT)
Subject: Re: [PATCH Makedumpfile 0/4] x86_64: Fix page_offset for randomized
 base enabled
References: <cover.1477327674.git.panand@redhat.com>
 <20161027023743.GA20446@dhcp-128-65.nay.redhat.com>
 <20161027025437.GA20670@dhcp-128-65.nay.redhat.com>
 <20161027061945.GA23354@dhcp-128-65.nay.redhat.com>
 <926225735.8567580.1477574985798.JavaMail.zimbra@redhat.com>
 <595835228.8595706.1477581920601.JavaMail.zimbra@redhat.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <56d182b4-73b6-4d16-4d5a-bd527cff944d@redhat.com>
Date: Thu, 27 Oct 2016 21:29:27 +0530
MIME-Version: 1.0
In-Reply-To: <595835228.8595706.1477581920601.JavaMail.zimbra@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: ats-kumagai@wm.jp.nec.com, bhe@redhat.com



On Thursday 27 October 2016 08:55 PM, Dave Anderson wrote:
> As it turns out, the problem with the crash utility is that it has to
> calculate phys_base well before it even knows the kernel has been relocated
> by KASLR.  So when it sees the __START_KERNEL_map PT_LOAD segment, it mistakes
> it for the kernel modules' virtual address region and skips it.
>
> The kernel has this:
>
>   #if defined(CONFIG_RANDOMIZE_BASE)
>   #define KERNEL_IMAGE_SIZE       (1024 * 1024 * 1024)
>   #else
>   #define KERNEL_IMAGE_SIZE       (512 * 1024 * 1024)
>   #endif
>
> and then this:
>
>   #define MODULES_VADDR    (__START_KERNEL_map + KERNEL_IMAGE_SIZE)
>
> So with KASLR, MODULES_VADDR gets pushed up from the traditional ffffffffa0000000
> up to ffffffffc0000000.
>
> So I'm curious as to what you use in makedumpfile to determine whether
> CONFIG_RANDOMIZE_BASE has been configured?

So far we are trying to avoid to know that in makedumpfile. makedumpfile 
needed to know MODULES_VADDR, VMALLOC_START etc only to know that 
whether a VA to PA translation can be done using direct mapping or to be 
done by reading corresponding page table entry.

Now, we do VA to PA for all VAs using page table entry only.

https://github.com/pratyushanand/makedumpfile/blob/x86_devel/arch/x86_64.c#L186

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
