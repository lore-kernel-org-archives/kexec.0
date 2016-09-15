Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2401:3900:2:1::2])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bkLiE-0008Ff-7D
 for kexec@lists.infradead.org; Thu, 15 Sep 2016 01:43:39 +0000
Date: Thu, 15 Sep 2016 11:43:08 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v5 1/5] kexec_file: Include the purgatory segment in the
 kexec image checksum.
Message-ID: <20160915114308.19195f71@canb.auug.org.au>
In-Reply-To: <1473900890-1476-2-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1473900890-1476-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1473900890-1476-2-git-send-email-bauerman@linux.vnet.ibm.com>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-ima-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>

Hi Thiago,

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 2a1f0ce7c59a..dcd1679f3005 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1792,6 +1792,11 @@ config SECCOMP
>  
>  source kernel/Kconfig.hz
>  
> +# x86 needs to relocate the purgatory after the checksum is calculated,
> +# therefore the purgatory cannot be part of the kexec image checksum.
> +config ARCH_MODIFIES_KEXEC_PURGATORY
> +	bool
> +

The above should probably be in arch/Kconfig (with an appropriately
changed comment) since it is used in generic code.
-- 
Cheers,
Stephen Rothwell

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
