Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qy0-f108.google.com ([209.85.221.108])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1M2KuA-0003DV-Br
	for kexec@lists.infradead.org; Fri, 08 May 2009 07:54:08 +0000
Received: by qyk6 with SMTP id 6so3072756qyk.28
	for <kexec@lists.infradead.org>; Fri, 08 May 2009 00:54:00 -0700 (PDT)
Date: Fri, 8 May 2009 11:53:54 +0400
From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [PATCH 01/14] x86, boot: align the .bss section in the
	decompressor
Message-ID: <20090508075354.GA6132@lenovo>
References: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
	<1241735222-6640-2-git-send-email-hpa@linux.intel.com>
MIME-Version: 1.0
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
Cc: "H. Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ebiederm@xmission.com, ying.huang@intel.com, mingo@elte.hu, sam@ravnborg.org, tglx@linutronix.de, vgoyal@redhat.com

[H. Peter Anvin - Thu, May 07, 2009 at 03:26:49PM -0700]
| From: H. Peter Anvin <hpa@zytor.com>
| 
| Aligning the .bss section makes it trivially faster, and makes using
| larger transfers for the clear slightly easier.
| 
| [ Impact: trivial performance enhancement, future patch prep ]
| 
| Signed-off-by: H. Peter Anvin <hpa@zytor.com>
| ---
|  arch/x86/boot/compressed/vmlinux.lds.S |    1 +
|  1 files changed, 1 insertions(+), 0 deletions(-)
| 
| diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
| index 0d26c92..27c168d 100644
| --- a/arch/x86/boot/compressed/vmlinux.lds.S
| +++ b/arch/x86/boot/compressed/vmlinux.lds.S
| @@ -42,6 +42,7 @@ SECTIONS
|  		*(.data.*)
|  		_edata = . ;
|  	}
| +	. = ALIGN(32);
|  	.bss : {
|  		_bss = . ;
|  		*(.bss)
| -- 
| 1.6.0.6
| 

Hi Peter, should not it be ALIGN(8) rather? I thought
we keep these sections as tight as possible in a sake
of limitation of setup code size. Perhaps I miss something.

	-- Cyrill

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
