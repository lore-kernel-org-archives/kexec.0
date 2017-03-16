Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1coUK1-0005zZ-JK
 for kexec@lists.infradead.org; Thu, 16 Mar 2017 12:16:08 +0000
Received: by mail-pg0-x233.google.com with SMTP id 141so24418737pgd.1
 for <kexec@lists.infradead.org>; Thu, 16 Mar 2017 05:15:39 -0700 (PDT)
Date: Thu, 16 Mar 2017 12:15:32 +0000
From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: kexec regression since 4.9 caused by efi
Message-ID: <20170316121532.GE6261@codeblueprint.co.uk>
References: <20170308201616.GC8598@vader>
 <20170309063806.GB17257@dhcp-128-65.nay.redhat.com>
 <20170309095408.GA17883@vader>
 <CAKv+Gu-gRmt=Vq=QCcT5ETY9DwLzJe0f4gHR_9sFMKX7-vK++w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-gRmt=Vq=QCcT5ETY9DwLzJe0f4gHR_9sFMKX7-vK++w@mail.gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Omar Sandoval <osandov@osandov.com>, Dave Young <dyoung@redhat.com>, kernel-team@fb.com

On Thu, 09 Mar, at 12:53:36PM, Ard Biesheuvel wrote:
> 
> Hi Omar,
> 
> Thanks for tracking this down.
> 
> I wonder if this is an unintended side effect of the way we repurpose
> the EFI_MEMORY_RUNTIME attribute in efi_arch_mem_reserve(). AFAIUI,
> splitting memory map entries should only be necessary for regions that
> are not runtime memory regions to begin with, and so whether their
> virtual mapping address makes sense or not should be irrelevant.
> 
> Perhaps this only illustrates my lack of understanding of the x86 way
> of doing this, so perhaps Matt can shed some light on this?

Sorry for the delay.

Yes, Ard is correct. It's not necessary to split/reserve memory
regions that already have the EFI_MEMORY_RUNTIME attribute.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
