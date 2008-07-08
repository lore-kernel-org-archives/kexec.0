Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KGFLa-0005xn-09
	for kexec@lists.infradead.org; Tue, 08 Jul 2008 15:43:18 +0000
Date: Tue, 8 Jul 2008 17:43:54 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Use progress bar also for bitmap creation
Message-ID: <20080708174354.641d5a1a@halley.suse.de>
In-Reply-To: <48718477.3020406@mxs.nes.nec.co.jp>
References: <20080626143721.GA12486@suse.de>
	<4864B595.8040205@mxs.nes.nec.co.jp>
	<48718477.3020406@mxs.nes.nec.co.jp>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, jlan@sgi.com, kexec@lists.infradead.org

* Ken'ichi Ohmichi [2008-07-07 11:50]:
> Ken'ichi Ohmichi wrote:
> > Hi Bernhard,
> > 
> > Thank you for your patch.
> > I like this idea :-)
> > 
> > I am busy now, and I will consider the patch well the next week.
> 
> Thank you for the patch, and sorry for my late response.
> 
> I added the progress bar for excluding free pages to your patch.
> Could you please check the attached patch ?
> If there is no problem in the attached patch, I will release the
> next release with this patch.

I also tested on a larger SGI machine. Here the exclusion of the memory
holes takes a considerable amount of time. Therefore, I would suggest
to also use the patch below:


Signed-off-by: Bernhard Walle <bwalle@suse.de>

Index: makedumpfile.c
===================================================================
RCS file: /cvsroot/makedumpfile/makedumpfile/makedumpfile.c,v
retrieving revision 1.7.2.36
diff -u -r1.7.2.36 makedumpfile.c
--- makedumpfile.c	8 Jul 2008 01:31:44 -0000	1.7.2.36
+++ makedumpfile.c	8 Jul 2008 15:41:18 -0000
@@ -40,6 +40,7 @@
  * Message texts
  */
 #define PROGRESS_COPY   	"Copying data"
+#define PROGRESS_HOLES		"Checking for memory holes"
 #define PROGRESS_UNN_PAGES 	"Excluding unnecessary pages"
 #define PROGRESS_FREE_PAGES 	"Excluding free pages"
 #define PROGRESS_ZERO_PAGES 	"Excluding zero pages"
@@ -4068,11 +4069,20 @@
 	 */
 	for (pfn = 0, paddr = 0; pfn < info->max_mapnr;
 	    pfn++, paddr += info->page_size) {
+
+		print_progress(PROGRESS_HOLES, pfn, info->max_mapnr);
+
 		if (is_in_segs(paddr))
 			set_bit_on_1st_bitmap(pfn);
 		else
 			pfn_memhole++;
 	}
+
+	/*
+	 * print 100 %
+	 */
+	print_progress(PROGRESS_HOLES, info->max_mapnr, info->max_mapnr);
+
 	if (!sync_1st_bitmap())
 		goto out;
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
