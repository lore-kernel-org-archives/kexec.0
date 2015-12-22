Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aBUGb-0007DR-KS
 for kexec@lists.infradead.org; Tue, 22 Dec 2015 21:14:47 +0000
Date: Tue, 22 Dec 2015 13:14:23 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kexec: Move some memembers and definitions within the
 scope of CONFIG_KEXEC_FILE
Message-Id: <20151222131423.e173a94907f8caf5b70eccae@linux-foundation.org>
In-Reply-To: <567936B7.5020702@redhat.com>
References: <1450678154-12581-1-git-send-email-xlpang@redhat.com>
 <20151222104704.GA28313@dhcp-128-25.nay.redhat.com>
 <567936B7.5020702@redhat.com>
Mime-Version: 1.0
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
Cc: Minfei Huang <mhuang@redhat.com>, dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com

On Tue, 22 Dec 2015 19:40:39 +0800 Xunlei Pang <xlpang@redhat.com> wrote:

> > Following functions will be used only in kexec_file. Please wrap them in
> > CONFIG_KEXEC_FILE.
> >
> > int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> > 					 unsigned long buf_len);
> > void * __weak arch_kexec_kernel_image_load(struct kimage *image);
> > int __weak arch_kimage_file_post_load_cleanup(struct kimage *image);
> > int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
> > 					unsigned long buf_len);
> > int __weak arch_kexec_apply_relocations_add(const Elf_Ehdr *ehdr,
> > 					Elf_Shdr *sechdrs, unsigned int relsec);
> > int __weak arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> > 					unsigned int relsec);
> 
> Thanks for the comment.
> 
> I noticed this as well, but seems for the function declarations we don't need do this,
> since they don't consume the actual space.
> 
> For example, in the include/linux/timekeeping.h
> /*  
>  * RTC specific
>  */ 
> extern bool timekeeping_rtc_skipsuspend(void);
> extern bool timekeeping_rtc_skipresume(void);
> 
> extern void timekeeping_inject_sleeptime64(struct timespec64 *delta);
> 
> also not embraced by the corresponding macros.

Yes.  If we add the ifdefs then a programming error will be detected at
compile time.  If we don't add the ifdefs then that error will be
detected at link time.  So the ifdefs provide a quite small advantage,
while making the code harder to read and harder to maintain.  I believe
that "no ifdefs" is the better side of this tradeoff.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
