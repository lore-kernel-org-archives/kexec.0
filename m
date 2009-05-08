Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pfepb.post.tele.dk ([195.41.46.236])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1M2KJX-0002Im-L1
	for kexec@lists.infradead.org; Fri, 08 May 2009 07:16:18 +0000
Date: Fri, 8 May 2009 09:17:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 01/14] x86,
	boot: align the .bss section in the decompressor
Message-ID: <20090508071759.GA12808@uranus.ravnborg.org>
References: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
	<1241735222-6640-2-git-send-email-hpa@linux.intel.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1241735222-6640-2-git-send-email-hpa@linux.intel.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ebiederm@xmission.com, ying.huang@intel.com, mingo@elte.hu, tglx@linutronix.de, vgoyal@redhat.com

On Thu, May 07, 2009 at 03:26:49PM -0700, H. Peter Anvin wrote:
> From: H. Peter Anvin <hpa@zytor.com>
> 
> Aligning the .bss section makes it trivially faster, and makes using
> larger transfers for the clear slightly easier.
> 
> [ Impact: trivial performance enhancement, future patch prep ]
> 
> Signed-off-by: H. Peter Anvin <hpa@zytor.com>
> ---
>  arch/x86/boot/compressed/vmlinux.lds.S |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 0d26c92..27c168d 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -42,6 +42,7 @@ SECTIONS
>  		*(.data.*)
>  		_edata = . ;
>  	}
> +	. = ALIGN(32);

Where does this magic 32 comes from?
I would assume the better choice would be:
	. = ALIGN(L1_CACHE_BYTES);

So we match the relevant CPU.

In general for alignmnet of output sections I see the need for:
1) Function call
2) L1_CACHE_BYTES
3) PAGE_SIZE
4) 2*PAGE_SIZE

But I see magic constant used here and there that does not match
the above (when looking at all archs).
So I act when I see a new 'magic' number..

	Sam

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
