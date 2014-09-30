Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XZ4rn-0006j8-Ad
 for kexec@lists.infradead.org; Tue, 30 Sep 2014 21:21:51 +0000
Message-ID: <542B1EC1.8090502@zytor.com>
Date: Tue, 30 Sep 2014 14:21:05 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [resend Patch v3 1/2] kaslr: check if kernel location is changed
References: <1412060896-1902-1-git-send-email-bhe@redhat.com>
In-Reply-To: <1412060896-1902-1-git-send-email-bhe@redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: whissi@whissi.de, ak@linux.intel.com, keescook@chromium.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, mingo@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, tglx@linutronix.de, vgoyal@redhat.com

On 09/30/2014 12:08 AM, Baoquan He wrote:
> Function handle_relocations() is used to do the relocations handling
> for i686 and kaslr of x86_64. For 32 bit the relocation handling is
> mandotary to perform. For x86_64 only when kaslr is enabled and a
> random kernel location is chosen successfully the relocation handling
> shound be done. However previous implementation only compared the
> kernel loading address and LOAD_PHYSICAL_ADDR where kernel were
> compiled to run at. This would casue system to be exceptional in
> few conditions like when delta between load address and compiled
> address is bigger than what 32bit signed relocations can handle.
> Also there will be limitations that delta can't be too big otherwise
> kernel text virtual addresses will overflow in module address space.
> 
> So in this patch check if kernel location is changed after
> choose_kernel_location() when x86_64. If and only if in x86_64
> and kernel location is changed, we say a kaslr random kernel
> location is chosen, then the relocation handling is needed.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Acked-by: Vivek Goyal <vgoyal@redhat.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> Tested-by: Thomas D. <whissi@whissi.de>
> Cc: stable@vger.kernel.org

Could you clarify under what conditions we may end up with 32-bit signed
overflow, and yet have a functional kernel?

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
