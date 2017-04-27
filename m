Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d3Zc6-0007Rm-3l
 for kexec@lists.infradead.org; Thu, 27 Apr 2017 02:57:03 +0000
Date: Thu, 27 Apr 2017 10:56:30 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 3/3] kdump: Protect vmcoreinfo data under the crash
 memory
Message-ID: <20170427025630.GA10602@dhcp-128-65.nay.redhat.com>
References: <1492688374-27903-1-git-send-email-xlpang@redhat.com>
 <1492688374-27903-3-git-send-email-xlpang@redhat.com>
 <20170426070936.GB5381@dhcp-128-65.nay.redhat.com>
 <590066A2.4090309@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <590066A2.4090309@redhat.com>
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
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>, akpm@linux-foundation.org, Michael Holzheu <holzheu@linux.vnet.ibm.com>

[snip]
> >> index 43cdb00..a29e9ad 100644
> >> --- a/kernel/crash_core.c
> >> +++ b/kernel/crash_core.c
> >> @@ -15,9 +15,12 @@
> >>  
> >>  /* vmcoreinfo stuff */
> >>  static unsigned char *vmcoreinfo_data;
> >> -size_t vmcoreinfo_size;
> >> +static size_t vmcoreinfo_size;
> >>  u32 *vmcoreinfo_note;
> >>  
> >> +/* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
> > May make it clearer like:
> > /* Trusted vmcoreinfo copy in the kdump reserved memory */
> 
> My thought is that it is in crash_core.c now which should be independent of kexec/kdump,
> so I used "e.g. ..." just like one use case.

Ok, then it is fine.

[snip]
> >>  static int kimage_add_entry(struct kimage *image, kimage_entry_t entry)
> >>  {
> >>  	if (*image->entry != 0)
> >> @@ -598,6 +632,11 @@ void kimage_free(struct kimage *image)
> >>  	if (image->file_mode)
> >>  		kimage_file_post_load_cleanup(image);
> >>  
> >> +	if (image->vmcoreinfo_data_copy) {
> >> +		crash_update_vmcoreinfo_safecopy(NULL);
> >> +		vunmap(image->vmcoreinfo_data_copy);
> >> +	}
> >> +
> > Should move above chunk before the freeing of the actual page?
> 
> It should be fine, because it is allocated from the reserved memory, it doesn't
> need to be freed. Anyway I can move it above to avoid confusion. Thanks!
> 

Yes, it looks better, thanks for explanation.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
