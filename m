Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hEUmN-00052j-8I
 for kexec@lists.infradead.org; Thu, 11 Apr 2019 08:09:52 +0000
Date: Thu, 11 Apr 2019 10:09:37 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190411080927.GA30080@zn.tnic>
References: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp>
 <20190410171431.GE26580@zn.tnic>
 <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com>
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
To: Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>

On Wed, Apr 10, 2019 at 11:34:51PM +0000, Junichi Nomura wrote:
> But efi_get_rsdp_addr() needs to check whether the kernel was
> kexec booted to avoid accessing invalid EFI table address.
> efi_get_kexec_setup_data_addr() is the only method I know
> to check if it was kexec-booted.

Your v3 had the right approach - you first check if you can get the
address as a kexec-ed kernel. If you do, you use that one and continue
the normal path.

If you don't, you fall back to efi_get_rsdp_addr() and get it directly
from EFI.

And then carve out the functionality you need to call multiple times in
helper functions like __efi_get_rsdp_addr().

Why doesn't that work anymore?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
