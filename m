Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jW1cq-0004bl-DN
 for kexec@lists.infradead.org; Tue, 05 May 2020 17:45:02 +0000
Subject: Re: [RFC][PATCH] kexec: Teach indirect pages how to live in high
 memory
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1588130803-20527-4-git-send-email-iamjoonsoo.kim@lge.com>
 <87h7wzvjko.fsf@x220.int.ebiederm.org>
 <CAAmzW4MrD75+Prw=fQ=d5uXKgGy3urBwmxnNtoNsw5M1m9xjYQ@mail.gmail.com>
 <87ftcfpzjn.fsf@x220.int.ebiederm.org>
 <87368fmkel.fsf_-_@x220.int.ebiederm.org>
From: Hari Bathini <hbathini@linux.ibm.com>
Message-ID: <54a53bfe-6929-2790-9b1d-943e9f47cd62@linux.ibm.com>
Date: Tue, 5 May 2020 23:14:32 +0530
MIME-Version: 1.0
In-Reply-To: <87368fmkel.fsf_-_@x220.int.ebiederm.org>
Content-Language: en-US
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
To: "Eric W. Biederman" <ebiederm@xmission.com>, Joonsoo Kim <js1304@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, Rik van Riel <riel@surriel.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Minchan Kim <minchan@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>, Christoph Hellwig <hch@infradead.org>, kernel-team@lge.com, Huang Rui <ray.huang@amd.com>, Linux Memory Management List <linux-mm@kvack.org>, Pavel Machek <pavel@ucw.cz>, Kexec Mailing List <kexec@lists.infradead.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Laura Abbott <labbott@redhat.com>, Mel Gorman <mgorman@techsingularity.net>, Christian Koenig <christian.koenig@amd.com>, Vlastimil Babka <vbabka@suse.cz>



On 05/05/20 3:29 am, Eric W. Biederman wrote:
> 
> Recently a patch was proposed to kimage_alloc_page to slightly alter
> the logic of how pages allocated with incompatible flags were
> detected.  The logic was being altered because the semantics of the
> page alloctor were changing yet again.
> 
> Looking at that case I realized that there is no reason for it to even
> exist.  Either the indirect page allocations and the source page
> allocations could be separated out, or I could do as I am doing now
> and simply teach the indirect pages to live in high memory.
> 
> This patch replaced pointers of type kimage_entry_t * with a new type
> kimage_entry_pos_t.  This new type holds the physical address of the
> indirect page and the offset within that page of the next indirect
> entry to write.  A special constant KIMAGE_ENTRY_POS_INVALID is added
> that kimage_image_pos_t variables that don't currently have a valid
> may be set to.
> 
> Two new functions kimage_read_entry and kimage_write_entry have been
> provided to write entries in way that works if they live in high
> memory.
> 
> The now unnecessary checks to see if a destination entry is non-zero
> and to increment it if so have been removed.  For safety new indrect
> pages are now cleared so we have a guarantee everything that has not
> been used yet is zero.  Along with this writing an extra trailing 0
> entry has been removed, as it is known all trailing entries are now 0.
> 
> With highmem support implemented for indirect pages
> kimage_image_alloc_page has been updated to always allocate
> GFP_HIGHUSER pages, and handling of pages with different
> gfp flags has been removed.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Eric, the patch failed with data access exception on ppc64. Using the below patch on top
got me going...


diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 45862fd..bef52f1 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -570,7 +570,12 @@ static int kimage_add_entry(struct kimage *image, kimage_entry_t entry)
 			return -ENOMEM;
 
 		ind_addr = page_to_boot_pfn(page) << PAGE_SHIFT;
-		kimage_write_entry(image->entry_pos, ind_addr | IND_INDIRECTION);
+
+		/* If it is the first entry, handle it here */
+		if (!image->head)
+			image->head = ind_addr | IND_INDIRECTION;
+		else
+			kimage_write_entry(image->entry_pos, ind_addr | IND_INDIRECTION);
 
 		clear_highpage(page);
 
@@ -623,7 +628,11 @@ int __weak machine_kexec_post_load(struct kimage *image)
 
 void kimage_terminate(struct kimage *image)
 {
-	kimage_write_entry(image->entry_pos, IND_DONE);
+	/* This could be the only entry in case of kdump */
+	if (!image->head)
+		image->head = IND_DONE;
+	else
+		kimage_write_entry(image->entry_pos, IND_DONE);
 }
 
 #define for_each_kimage_entry(image, pos, entry) 				\


Thanks
Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
