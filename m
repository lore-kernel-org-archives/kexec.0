Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VakEz-0001Ku-5c
 for kexec@lists.infradead.org; Mon, 28 Oct 2013 10:40:09 +0000
Date: Mon, 28 Oct 2013 18:39:18 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 3/6] Cleanup efi_enter_virtual_mode function
Message-ID: <20131028103918.GH25527@dhcp-16-126.nay.redhat.com>
References: <20131027034713.481920209@dhcp-16-126.nay.redhat.com>
 <20131027035923.081819853@dhcp-16-126.nay.redhat.com>
 <20131028093206.GB4314@pd.tnic>
 <20131028094049.GC25527@dhcp-16-126.nay.redhat.com>
 <20131028095117.GD25527@dhcp-16-126.nay.redhat.com>
 <20131028100402.GC4314@pd.tnic>
 <20131028101011.GF25527@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131028101011.GF25527@dhcp-16-126.nay.redhat.com>
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
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, kexec@lists.fedoraproject.org, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On 10/28/13 at 06:10pm, Dave Young wrote:
> On 10/28/13 at 11:04am, Borislav Petkov wrote:
> > On Mon, Oct 28, 2013 at 05:51:17PM +0800, Dave Young wrote:
> > > It does have a warning, but it applied successfully, no idea though: 
> > > patches/02-efi-enter-virtual-mode-cleanup.patch
> > > Applying: Cleanup efi_enter_virtual_mode function
> > > /home/dave/git/efi/.git/rebase-apply/patch:42: space before tab in indent.
> > >  	efi_memory_desc_t *md, *prev_md = NULL;
> > > warning: 1 line adds whitespace errors.
> > 
> > Hmm, ok, can you upload the patches somewhere so that I can pull them?
> 
> Sorry, I have not any public git account. Attached the patch I applied with git

Here is the kernel patche files if you would like to try,
I have not got time to update them based on comments.
https://people.redhat.com/ruyang/kexec-efi/for-bp/kernel-patches/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
