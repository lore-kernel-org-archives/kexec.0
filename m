Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1brPU5-0002lC-Oy
 for kexec@lists.infradead.org; Tue, 04 Oct 2016 13:10:14 +0000
Date: Tue, 4 Oct 2016 21:09:49 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 3/3] makedumpfile: Add support for MM randomization
Message-ID: <20161004130949.GD9185@x1.redhat.com>
References: <1472460862-29842-1-git-send-email-bhe@redhat.com>
 <1472460862-29842-4-git-send-email-bhe@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E62E28@BPXM01GP.gisp.nec.co.jp>
 <20160930045620.GB9185@x1.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E6CE53@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E6CE53@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "thgarnie@google.com" <thgarnie@google.com>

On 10/04/16 at 01:40am, Atsushi Kumagai wrote:
> >> > 	/*
> >> > 	 * On linux-2.6.26, MAX_PHYSMEM_BITS is changed to 44 from 40.
> >> >@@ -159,22 +160,13 @@ get_versiondep_info_x86_64(void)
> >> > 	else
> >> > 		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_31;
> >> >
> >> >-	if (info->kernel_version < KERNEL_VERSION(2, 6, 27))
> >> >-		info->page_offset = __PAGE_OFFSET_ORIG;
> >> >-	else
> >> >-		info->page_offset = __PAGE_OFFSET_2_6_27;
> >> >+	info->page_offset = NUMBER(page_offset);
> >> >
> >> >-	if (info->kernel_version < KERNEL_VERSION(2, 6, 31)) {
> >> >-		info->vmalloc_start = VMALLOC_START_ORIG;
> >> >-		info->vmalloc_end   = VMALLOC_END_ORIG;
> >> >-		info->vmemmap_start = VMEMMAP_START_ORIG;
> >> >-		info->vmemmap_end   = VMEMMAP_END_ORIG;
> >> >-	} else {
> >> >-		info->vmalloc_start = VMALLOC_START_2_6_31;
> >> >-		info->vmalloc_end   = VMALLOC_END_2_6_31;
> >> >-		info->vmemmap_start = VMEMMAP_START_2_6_31;
> >> >-		info->vmemmap_end   = VMEMMAP_END_2_6_31;
> >> >-	}
> >>
> >> These *_END_* are no longer used, it's better to remove the definitions
> >> of them.
> >
> >
> >Seems is_vmalloc_addr_x86_64 still needs VMALLOC_END and VMEMMAP_END to
> >make a judgement.
> 
> Yes, VMALLOC_END and VMEMMAP_END are necessary, but what I mentioned were
> VMALLOC_END_ORIG, VMEMMAP_END_ORIG , VMALLOC_END_2_6_31 and VMEMMAP_END_2_6_31.
> The symbols were used only to initialize info->vmalloc_end and info->vmemmap_end,
> so they will be unnecessary by this patch.

Yes, you are right. These unused MACRO definitions need be removed.
Thanks for your reviewing.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
