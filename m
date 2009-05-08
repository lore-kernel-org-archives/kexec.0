Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1M2TXW-0001lK-Ge
	for kexec@lists.infradead.org; Fri, 08 May 2009 17:07:21 +0000
Message-ID: <4A0465E6.9000401@zytor.com>
Date: Fri, 08 May 2009 10:03:34 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 01/14] x86,
	boot: align the .bss section in the	decompressor
References: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
	<1241735222-6640-2-git-send-email-hpa@linux.intel.com>
	<20090508075354.GA6132@lenovo>
In-Reply-To: <20090508075354.GA6132@lenovo>
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
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ebiederm@xmission.com, ying.huang@intel.com, mingo@elte.hu, "H. Peter Anvin" <hpa@linux.intel.com>, sam@ravnborg.org, tglx@linutronix.de, vgoyal@redhat.com

Cyrill Gorcunov wrote:
> | 
> | diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> | index 0d26c92..27c168d 100644
> | --- a/arch/x86/boot/compressed/vmlinux.lds.S
> | +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> | @@ -42,6 +42,7 @@ SECTIONS
> |  		*(.data.*)
> |  		_edata = . ;
> |  	}
> | +	. = ALIGN(32);
> |  	.bss : {
> |  		_bss = . ;
> |  		*(.bss)
> | -- 
> | 1.6.0.6
> | 
> 
> Hi Peter, should not it be ALIGN(8) rather? I thought
> we keep these sections as tight as possible in a sake
> of limitation of setup code size. Perhaps I miss something.
> 

This isn't the setup code at all.  This is the actual kernel, although
in its compressed form.  Furthermore, this is the bss, so it doesn't
affect the compressed image size.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
