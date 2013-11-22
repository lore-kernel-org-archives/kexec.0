Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjguJ-0004nB-Ua
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 02:55:48 +0000
Date: Fri, 22 Nov 2013 10:54:56 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 4/9 v3] efi: cleanup efi_enter_virtual_mode function
Message-ID: <20131122025456.GE3874@dhcp-16-126.nay.redhat.com>
References: <20131121061704.363730447@dhcp-16-126.nay.redhat.com>
 <20131121061754.304016344@dhcp-16-126.nay.redhat.com>
 <20131121164929.GM26009@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131121164929.GM26009@pd.tnic>
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

> > +
> > +/*
> > + * Map efi memory ranges for runtime serivce and
> > + * update new_memmap with virtual addresses.
> > + */
> 
> Stretch comment to 80 cols:
> 
> /*
>  * Map efi memory ranges for runtime serivce and update new_memmap with virtual
>  * addresses.
>  */
> 
> like it is customary for the rest of the file.

Ok, will do.

--
Thanks for review
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
