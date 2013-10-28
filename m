Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from arkanian.console-pimps.org ([212.110.184.194])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vak2n-0000uo-Qf
 for kexec@lists.infradead.org; Mon, 28 Oct 2013 10:27:34 +0000
Date: Mon, 28 Oct 2013 10:27:05 +0000
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [patch 2/6] x86 efi: reserve boot service fix
Message-ID: <20131028102705.GI1982@console-pimps.org>
References: <20131027034713.481920209@dhcp-16-126.nay.redhat.com>
 <20131027035922.924386710@dhcp-16-126.nay.redhat.com>
 <20131027105009.GA21868@pd.tnic>
 <20131027203058.GE1982@console-pimps.org>
 <20131028011824.GD4397@dhcp-16-126.nay.redhat.com>
 <20131028084440.GA4314@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131028084440.GA4314@pd.tnic>
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
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, kexec@lists.fedoraproject.org, ebiederm@xmission.com, hpa@zytor.com, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

On Mon, 28 Oct, at 09:44:41AM, Borislav Petkov wrote:
> On Mon, Oct 28, 2013 at 09:18:24AM +0800, Dave Young wrote:
> > There should be some people see below message with non-kexec kernel:
> > "Could not reserve boot range ..."
> 
> I can find one other report like that: https://lkml.org/lkml/2013/7/16/309
> 
> [    0.000000] efi: Could not reserve boot range [0x0000000000-0x0000000fff]
> 
> for
> 
> efi: mem00: type=3, attr=0xf, range=[0x0000000000000000-0x0000000000001000) (0MB)
> 
> which is EFI_BOOT_SERVICES_CODE and
> 
> efi: Could not reserve boot range [0x000005f000-0x000009ffff]
> 
> for
> 
> efi: mem06: type=3, attr=0xf, range=[0x000000000005f000-0x00000000000a0000) (0MB)
> 
> which is of the same type.
 
But that doesn't look like the issue that the user was complaining
about. Rather, it's that the higher EFI regions are unable to be mapped
because of the user's mem= kernel parameter setting.

However, even though this bug isn't the main focus of the above report,
since people are hitting it (and since the fix is trivial), I agree it's
worth tagging for stable.

-- 
Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
