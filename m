Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VpDlz-0004Nm-B7
 for kexec@lists.infradead.org; Sat, 07 Dec 2013 09:02:05 +0000
Date: Sat, 7 Dec 2013 04:01:02 -0500 (EST)
From: Dave Young <dyoung@redhat.com>
Message-ID: <2141297830.13051543.1386406862068.JavaMail.root@redhat.com>
In-Reply-To: <20131202094020.GA7380@pd.tnic>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
 <1385445477-9665-7-git-send-email-dyoung@redhat.com>
 <20131127114402.GB32267@pd.tnic>
 <20131129094034.GI4186@dhcp-16-126.nay.redhat.com>
 <20131129115029.GB4266@pd.tnic>
 <20131202025942.GF3999@dhcp-16-126.nay.redhat.com>
 <20131202094020.GA7380@pd.tnic>
Subject: Re: [PATCH v4 06/12] efi: export efi runtime memory mapping to sysfs
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi kani <toshi.kani@hp.com>, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James Bottomley <James.Bottomley@HansenPartnership.com>, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

Hi, all

Update my status:

I have finished most of thecode related changes including the krealloc
fixes (both for original code and my new code). And I'm slowly
moving the kexec related stuff to efi_kexec.c, this involves
some other cleanups, such as:
efi_systab_init:
 -> move 64bit code to efi_64.c, move 32bit code to efi_32.c

efi_setup global variable is changing to physical address, ioremapping
it when necessary instead of directly using the virt addr because
previously the virt addr will be freed until entering virtual mode,
it's possible a leak in case something is wrong in the middle also it
occupies the ioremap slot a little bit long.

There's also other problems, so I still need a few days probably
a week to carefully restructure the code.

Thanks
Dave

Sending from web interface so sorry for the email format.
----- Original Message -----
From: "Borislav Petkov" <bp@alien8.de>
To: "Dave Young" <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, "toshi kani" <toshi.kani@hp.com>, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "James Bottomley" <James.Bottomley@HansenPartnership.com>, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com
Sent: Monday, December 2, 2013 5:40:20 PM
Subject: Re: [PATCH v4 06/12] efi: export efi runtime memory mapping to sysfs

On Mon, Dec 02, 2013 at 10:59:42AM +0800, Dave Young wrote:
> They are only called if there's setup_data SETUP_EFI passed in. Yes, I
> think only kexec need that part of code. But I hesitated to mess the
> code with a lot of #if. Will think about it.

Well, the accepted strategy with the efi code is to have function calls
in efi.c and then have different versions of those functions defined for
32 and 64-bit, i.e. efi_32.c and efi_64.c.

I can imagine adding an efi_kexec.c could make the whole deal very
clearly arranged without ifdeffery.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
