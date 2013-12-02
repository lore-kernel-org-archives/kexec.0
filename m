Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VnJkR-0003ST-EW
 for kexec@lists.infradead.org; Mon, 02 Dec 2013 03:00:36 +0000
Date: Mon, 2 Dec 2013 10:59:42 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 06/12] efi: export efi runtime memory mapping to sysfs
Message-ID: <20131202025942.GF3999@dhcp-16-126.nay.redhat.com>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
 <1385445477-9665-7-git-send-email-dyoung@redhat.com>
 <20131127114402.GB32267@pd.tnic>
 <20131129094034.GI4186@dhcp-16-126.nay.redhat.com>
 <20131129115029.GB4266@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131129115029.GB4266@pd.tnic>
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

On 11/29/13 at 12:50pm, Borislav Petkov wrote:
> No need for the list - I actually meant you simply use a tmp pointer for
> each krealloc invocation - just look around the tree for examples.
> 
> Also think about what happens to the pointed-to memory when krealloc
> returns NULL.

Ok, thanks for the explaination.

> 
> > suppose kexec runtime map preparing fails we still can get 1st kernel
> > boot ok.
> 
> Yeah, nothing stops that - especially if you iterate over the mapped
> regions a second time separately, for kexec.
> 
> Which reminds me, all that save_runtime_map code needs to be behind
> CONFIG_KEXEC. We don't want to be doing this if KEXEC is not enabled.

They are only called if there's setup_data SETUP_EFI passed in. Yes, I think
only kexec need that part of code. But I hesitated to mess the code with
a lot of #if. Will think about it.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
