Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJEMm-0001LG-6C
 for kexec@lists.infradead.org; Wed, 24 Apr 2019 09:39:01 +0000
Date: Wed, 24 Apr 2019 11:38:52 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 0/2] x86/boot: Use efi_setup_data for searching RSDP
 on kexec-ed kernel
Message-ID: <20190424093852.GB30142@zn.tnic>
References: <20190424092944.30481-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190424092944.30481-1-bhe@redhat.com>
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
Cc: x86@kernel.org, kasong@redhat.com, fanc.fnst@cn.fujitsu.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, j-nomura@ce.jp.nec.com, tglx@linutronix.de, dyoung@redhat.com

On Wed, Apr 24, 2019 at 05:29:42PM +0800, Baoquan He wrote:
> In this series, patch 2/2 has dependency on patch 1/1, otherwise
> it may cause system to reset to firmware on some machines.
> 
> The patch 2/2 is the version Boris organized:
> http://lkml.kernel.org/r/20190416095209.GG27892@zn.tnic
> 
> Patch 1/1 is based on Kairui's v1 patch, and add ACPI tables mapping:
> http://lkml.kernel.org/r/20190422092804.15534-1-kasong@redhat.com
> 
> Dave Young confirmed this patchset passed test on his t420 laptop, where
> the system resetting issue caused by patch 2/2 was found.

I guess but this does not give me the warm and fuzzy feeling one week
before the merge window.

So:

https://git.kernel.org/tip/36f0c423552dacaca152324b8e9bda42a6d88865

and we all can relax ourselves and take the next release cycle to test
the hell out of this before reenabling it again.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
