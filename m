Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VnJaF-0003HD-Kv
 for kexec@lists.infradead.org; Mon, 02 Dec 2013 02:50:04 +0000
Date: Mon, 2 Dec 2013 10:49:15 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 07/12] efi: passing kexec necessary efi data via
 setup_data
Message-ID: <20131202024914.GD3999@dhcp-16-126.nay.redhat.com>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
 <1385445477-9665-8-git-send-email-dyoung@redhat.com>
 <20131127140732.GD32267@pd.tnic>
 <20131129091415.GH4186@dhcp-16-126.nay.redhat.com>
 <20131129164632.GD4266@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131129164632.GD4266@pd.tnic>
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
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On 11/29/13 at 05:46pm, Borislav Petkov wrote:
> On Fri, Nov 29, 2013 at 05:14:16PM +0800, Dave Young wrote:
> > That's reserved for future extension use, who knows if we will need to
> > pass other fields in the future.
> 
> Hrrmmm, 8*64 = 64 Bytes?? And you can't change it later because of the
> situation where machines might be using older kexec-tools?

Right, compatibility is the reason.

> 
> > > Static function - no need for "efi_" prefix.
> > 
> > Ok. I'm not very satisfied with the function name, any better
> > suggestion?
> > 
> > reuse_config
> > use_old_config_phys_addr
> > update_config_entry_with_phys_addr
> 
> Looks like we're applying quirks so apply_quirks()?

Ok, it looks better, will use apply_quirks, thank you.

> 
> And those kexec-specific quirks need to be behind CONFIG_KEXEC too, btw.

All these setup_data passing, remapping etc. is mostly for kexec, add
a lot of contiditional #if #endif makes the code a mess. I would prefer
to not do this if you are not strongly object. 

> 
> > Since Matt suggest to extend the function for other possible field
> > other than smbios, so I would like to move comment to the front
> > of the function like below:
> > /*
> >  * For kexec kernel there's some special config table entries which will be
> >  * converted to virtual addresses after entering virtual mode. In kexec kernel
> >  * we need the physical addresses instead, thus passing them via setup_data
> >  * and update the entries to physical addresses in this function.
> >  *
> >  * Currently only handles smbios which is necessary for HP z420.
> >  */
> 
> That's better.
> 
> > Is there any idea in your mind how to add the code for HP only?
> 
> DMI?

I'm confused how to connect this with DMI..

> 
> > Yes, __map_region return an error code will be better. Will you send
> > a patch for __map_region? or I can add one more patch along with next
> > version.
> 
> I was going to wait for your patches to settle down first so that I
> don't disturb your work.
> 
> But if you want to fix this, I certainly wouldn't want to stop you :)
> but please do so in a prepatch before your series which addresses only
> this issue.

Ok, so I will leave this to you after this series settle down.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
