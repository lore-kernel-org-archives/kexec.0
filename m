Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vnc8c-0003wZ-Al
 for kexec@lists.infradead.org; Mon, 02 Dec 2013 22:38:46 +0000
Message-ID: <1386023600.1791.201.camel@misato.fc.hp.com>
Subject: Re: [PATCH v4 07/12] efi: passing kexec necessary efi data via
 setup_data
From: Toshi Kani <toshi.kani@hp.com>
Date: Mon, 02 Dec 2013 15:33:20 -0700
In-Reply-To: <20131129091415.GH4186@dhcp-16-126.nay.redhat.com>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
 <1385445477-9665-8-git-send-email-dyoung@redhat.com>
 <20131127140732.GD32267@pd.tnic>
 <20131129091415.GH4186@dhcp-16-126.nay.redhat.com>
Mime-Version: 1.0
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
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, Borislav Petkov <bp@alien8.de>, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Fri, 2013-11-29 at 17:14 +0800, Dave Young wrote:
> On 11/27/13 at 03:07pm, Borislav Petkov wrote:
> > On Tue, Nov 26, 2013 at 01:57:52PM +0800, Dave Young wrote:
> > > Add a new setup_data type SETUP_EFI for kexec use.
> > > Passing the saved fw_vendor, runtime, config tables and
> > > efi runtime mappings.
> > > 
> > > When entering virtual mode, directly mapping the efi
> > > runtime ragions which we passed in previously. And skip
> > > the step to call SetVirtualAddressMap.
> > > 
> > > Specially for HP z420 workstation it need another variable
> > > saving,
> > 
> > Why the special handling? Does that mean, this is going to be the case
> > for other HP UEFI implementations too?
> 
> I have only one HP machine for testing, Maybe Toshi can help to verify
> on other machines. Just comment out the function efi_reuse_config to see
> if kexec kernel panic.

My system (HP prototype server) did not need the special handling in
efi_reuse_config().  I will check with firmware team to get more
information on this.

Thanks,
-Toshi



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
