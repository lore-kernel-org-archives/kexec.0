Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vr0TZ-0003P4-0e
 for kexec@lists.infradead.org; Thu, 12 Dec 2013 07:14:26 +0000
Date: Thu, 12 Dec 2013 15:13:37 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 08/14] efi: export efi runtime memory mapping to sysfs
Message-ID: <20131212071337.GI3751@dhcp-16-126.nay.redhat.com>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <1386582147-9802-9-git-send-email-dyoung@redhat.com>
 <20131211185520.GG23793@pd.tnic>
 <20131212023617.GF3751@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131212023617.GF3751@dhcp-16-126.nay.redhat.com>
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

> 
> > 
> > and the EFI_BOOT* tests can be done in save_runtime_map and also the
> > error handling can happen there. This way efi_map_regions() won't
> > need to know about anything. This way, you can later move the whole
> > save_runtime_map() function to efi-kexec.c just by taking it without any
> > need for untangling.
> > 
> > > +out_save_runtime:
> > > +       kfree(efi_runtime_map);
> > > +       nr_efi_runtime_map = 0;
> > > +       efi_runtime_map = NULL;
> > 
> > This can go there too.
> 
> This section can go the save_runtime_map but it looks clearer to put them here.

BTW, I will restructure the whole code when I move them to efi_kexec.c,
so no worry about it? If you have strong opinion I can move them though.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
