Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d7cBB-0004dZ-9E
 for kexec@lists.infradead.org; Mon, 08 May 2017 06:29:58 +0000
Received: by mail-wm0-x242.google.com with SMTP id y10so13157126wmh.0
 for <kexec@lists.infradead.org>; Sun, 07 May 2017 23:29:36 -0700 (PDT)
Date: Mon, 8 May 2017 08:29:32 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 2/2] x86_64/kexec: Use PUD level 1GB page for identity
 mapping if available
Message-ID: <20170508062932.bzg6ck5efarvzqlt@gmail.com>
References: <1493862171-8799-1-git-send-email-xlpang@redhat.com>
 <1493862171-8799-2-git-send-email-xlpang@redhat.com>
 <20170505065253.s5yv7c2cxgfcf4i3@gmail.com>
 <590C2A96.3090106@redhat.com>
 <20170505092046.2qu72pdherfxjmec@gmail.com>
 <590C5912.80202@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <590C5912.80202@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: xlpang@redhat.com
Cc: Yinghai Lu <yinghai@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Eric Biederman <ebiederm@xmission.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>


* Xunlei Pang <xpang@redhat.com> wrote:

> On 05/05/2017 at 05:20 PM, Ingo Molnar wrote:
> > * Xunlei Pang <xpang@redhat.com> wrote:
> >
> >> On 05/05/2017 at 02:52 PM, Ingo Molnar wrote:
> >>> * Xunlei Pang <xlpang@redhat.com> wrote:
> >>>
> >>>> @@ -122,6 +122,10 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
> >>>>  
> >>>>  	level4p = (pgd_t *)__va(start_pgtable);
> >>>>  	clear_page(level4p);
> >>>> +
> >>>> +	if (direct_gbpages)
> >>>> +		info.direct_gbpages = true;
> >>> No, this should be keyed off the CPU feature (X86_FEATURE_GBPAGES) automatically, 
> >>> not set blindly! AFAICS this patch will crash kexec on any CPU that does not 
> >>> support gbpages.
> >> It should be fine, probe_page_size_mask() already takes care of this:
> >>     if (direct_gbpages && boot_cpu_has(X86_FEATURE_GBPAGES)) {
> >>         printk(KERN_INFO "Using GB pages for direct mapping\n");
> >>         page_size_mask |= 1 << PG_LEVEL_1G;
> >>     } else {
> >>         direct_gbpages = 0;
> >>     }
> >>
> >> So if X86_FEATURE_GBPAGES is not supported, direct_gbpages will be set to 0.
> > So why is the introduction of the info.direct_gbpages flag necessary? AFAICS it 
> > just duplicates the kernel's direct_gbpages flag. One outcome is that hibernation 
> > won't use gbpages, which is silly.
> 
> boot/compressed/pagetable.c also uses kernel_ident_mapping_init() for kaslr, at 
> the moment we don't have "direct_gbpages" definition or X86_FEATURE_GBPAGES 
> feature detection.
> 
> I thought that we can change the other call sites when found really needed.

Ok, you are right - I'll use the original patches as submitted, with the updated 
changelogs.

Thanks,

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
