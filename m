Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vt6Xa-0000o5-AU
 for kexec@lists.infradead.org; Wed, 18 Dec 2013 02:07:16 +0000
Date: Wed, 18 Dec 2013 10:06:27 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 10/14] efi: only print saved efi runtime maps instead
 of all memmap ranges for kexec
Message-ID: <20131218020627.GA3917@dhcp-16-126.nay.redhat.com>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <1386582147-9802-11-git-send-email-dyoung@redhat.com>
 <20131213160150.GE32329@pd.tnic>
 <20131216020010.GC3754@dhcp-16-126.nay.redhat.com>
 <20131216113324.GB4922@pd.tnic>
 <20131217063436.GF6751@dhcp-16-126.nay.redhat.com>
 <20131217155844.GG30592@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131217155844.GG30592@pd.tnic>
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

On 12/17/13 at 04:58pm, Borislav Petkov wrote:
> On Tue, Dec 17, 2013 at 02:34:36PM +0800, Dave Young wrote:
> > They are moved to efi.c efi_setup_init(), I'm not sure if I expained
> > clear enough, in current code parse_efi_setup only accept one argument
> > phys_addr so I will mapping it with sizeof(struct setup_data) to
> > get the payload size then get the nr_efi_runtime_map. This is a
> > simplification from the old implementation.
> >
> > Based on current implementation, yes, I can add back another argument
> > data_len to avoid the 1st mapping thus I can print efi memmap as you
> > said.
> >
> > In this way I need export another extern for the data_len though.
> 
> Well, think about it: do you want to do the memremap/unmap a second time
> *just* to print the memmap in the efi kernel or do you want to do the
> memremap/unmap only once and do the work once?
> 
> If you say you don't care about speed and wasting cycles then I'm
> certainly fine with that as I've spent more time hinting at the
> performance aspect than I'd like to.

For these non critical path I would prefer the code which should be easier to 
be understood. But yes I have managed to work out what you want in latest
version. Of course I appreciate your time for reviewing those patches.
Thanks.

> 
> > What do you mean about NOPARSE, do you want another function name like
> > save_efi_setup()?
> 
> -ENOPARSE means I cannot parse what you said above.

Ok.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
