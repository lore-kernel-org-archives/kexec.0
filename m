Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bzmYo-0004zE-45
 for kexec@lists.infradead.org; Thu, 27 Oct 2016 15:25:42 +0000
Date: Thu, 27 Oct 2016 11:25:20 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <595835228.8595706.1477581920601.JavaMail.zimbra@redhat.com>
In-Reply-To: <926225735.8567580.1477574985798.JavaMail.zimbra@redhat.com>
References: <cover.1477327674.git.panand@redhat.com>
 <20161027023743.GA20446@dhcp-128-65.nay.redhat.com>
 <20161027025437.GA20670@dhcp-128-65.nay.redhat.com>
 <20161027061945.GA23354@dhcp-128-65.nay.redhat.com>
 <926225735.8567580.1477574985798.JavaMail.zimbra@redhat.com>
Subject: Re: [PATCH Makedumpfile 0/4] x86_64: Fix page_offset for randomized
 base enabled
MIME-Version: 1.0
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
To: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: Pratyush Anand <panand@redhat.com>, ats-kumagai@wm.jp.nec.com, bhe@redhat.com



----- Original Message -----

>   
> That being said, my recent 4.8 and 4.9 KASLR testing has been on live
> systems and compressed kdumps, so the old tried-and-true manner of
> calculating the phys_base from the ELF PT_LOAD segments apparently
> no longer works with KASLR.
> 
> It would be so much more helpful if the VMCOREINFO data in the ELF
> header stored the actual phys_base value instead of its symbol value:
> 
>   crash> help -D
>   ...
>   SYMBOL(phys_base)=ffffffffa740b010
>   ...
> 
> which is completely useless unless the phys_base value is known.
> 
> Anyway, can you send me the makedumpfile code that calculates the
> phys_base value?
> 
> Dave

As it turns out, the problem with the crash utility is that it has to
calculate phys_base well before it even knows the kernel has been relocated 
by KASLR.  So when it sees the __START_KERNEL_map PT_LOAD segment, it mistakes
it for the kernel modules' virtual address region and skips it.

The kernel has this:

  #if defined(CONFIG_RANDOMIZE_BASE)
  #define KERNEL_IMAGE_SIZE       (1024 * 1024 * 1024)
  #else
  #define KERNEL_IMAGE_SIZE       (512 * 1024 * 1024)
  #endif

and then this:

  #define MODULES_VADDR    (__START_KERNEL_map + KERNEL_IMAGE_SIZE)

So with KASLR, MODULES_VADDR gets pushed up from the traditional ffffffffa0000000
up to ffffffffc0000000.

So I'm curious as to what you use in makedumpfile to determine whether 
CONFIG_RANDOMIZE_BASE has been configured?

Thanks,
  Dave



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
