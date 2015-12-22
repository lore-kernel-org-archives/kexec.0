Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aBLfF-0004dW-QS
 for kexec@lists.infradead.org; Tue, 22 Dec 2015 12:03:38 +0000
Date: Tue, 22 Dec 2015 20:05:40 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH] kexec: Move some memembers and definitions within the
 scope of CONFIG_KEXEC_FILE
Message-ID: <20151222120540.GA29636@dhcp-128-25.nay.redhat.com>
References: <1450678154-12581-1-git-send-email-xlpang@redhat.com>
 <20151222104704.GA28313@dhcp-128-25.nay.redhat.com>
 <567936B7.5020702@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <567936B7.5020702@redhat.com>
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
Cc: dyoung@redhat.com, akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com

On 12/22/15 at 07:40pm, Xunlei Pang wrote:
> On 12/22/2015 at 06:47 PM, Minfei Huang wrote:
> > On 12/21/15 at 02:09pm, Xunlei Pang wrote:
> >> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > Hi, Xunlei.
> >
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

Yeah. I think it is better to fold above code as well, since there is
no side effect.

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

I think it is consistent of the construction to make code more clear.

Thanks
Minfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
