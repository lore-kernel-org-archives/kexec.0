Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vsx3A-00024k-RC
 for kexec@lists.infradead.org; Tue, 17 Dec 2013 15:59:17 +0000
Date: Tue, 17 Dec 2013 16:58:44 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 10/14] efi: only print saved efi runtime maps instead
 of all memmap ranges for kexec
Message-ID: <20131217155844.GG30592@pd.tnic>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <1386582147-9802-11-git-send-email-dyoung@redhat.com>
 <20131213160150.GE32329@pd.tnic>
 <20131216020010.GC3754@dhcp-16-126.nay.redhat.com>
 <20131216113324.GB4922@pd.tnic>
 <20131217063436.GF6751@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131217063436.GF6751@dhcp-16-126.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Tue, Dec 17, 2013 at 02:34:36PM +0800, Dave Young wrote:
> They are moved to efi.c efi_setup_init(), I'm not sure if I expained
> clear enough, in current code parse_efi_setup only accept one argument
> phys_addr so I will mapping it with sizeof(struct setup_data) to
> get the payload size then get the nr_efi_runtime_map. This is a
> simplification from the old implementation.
>
> Based on current implementation, yes, I can add back another argument
> data_len to avoid the 1st mapping thus I can print efi memmap as you
> said.
>
> In this way I need export another extern for the data_len though.

Well, think about it: do you want to do the memremap/unmap a second time
*just* to print the memmap in the efi kernel or do you want to do the
memremap/unmap only once and do the work once?

If you say you don't care about speed and wasting cycles then I'm
certainly fine with that as I've spent more time hinting at the
performance aspect than I'd like to.

> What do you mean about NOPARSE, do you want another function name like
> save_efi_setup()?

-ENOPARSE means I cannot parse what you said above.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
