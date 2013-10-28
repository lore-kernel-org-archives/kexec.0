Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([78.46.96.112])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VaiTi-0006dw-Oc
 for kexec@lists.infradead.org; Mon, 28 Oct 2013 08:47:16 +0000
Date: Mon, 28 Oct 2013 09:44:41 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [patch 2/6] x86 efi: reserve boot service fix
Message-ID: <20131028084440.GA4314@pd.tnic>
References: <20131027034713.481920209@dhcp-16-126.nay.redhat.com>
 <20131027035922.924386710@dhcp-16-126.nay.redhat.com>
 <20131027105009.GA21868@pd.tnic>
 <20131027203058.GE1982@console-pimps.org>
 <20131028011824.GD4397@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131028011824.GD4397@dhcp-16-126.nay.redhat.com>
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
Cc: Matt Fleming <matt@console-pimps.org>, linux-efi@vger.kernel.org, mjg59@srcf.ucam.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, kexec@lists.fedoraproject.org, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Mon, Oct 28, 2013 at 09:18:24AM +0800, Dave Young wrote:
> There should be some people see below message with non-kexec kernel:
> "Could not reserve boot range ..."

I can find one other report like that: https://lkml.org/lkml/2013/7/16/309

[    0.000000] efi: Could not reserve boot range [0x0000000000-0x0000000fff]

for

efi: mem00: type=3, attr=0xf, range=[0x0000000000000000-0x0000000000001000) (0MB)

which is EFI_BOOT_SERVICES_CODE and

efi: Could not reserve boot range [0x000005f000-0x000009ffff]

for

efi: mem06: type=3, attr=0xf, range=[0x000000000005f000-0x00000000000a0000) (0MB)

which is of the same type.

> But it's hard for them to notice the bad functionality because
> it's only one mem range which might be not the boot range what
> SetVirtualAddressMap need

Right.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
