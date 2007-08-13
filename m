Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IKjOe-0002NX-BT
	for kexec@lists.infradead.org; Mon, 13 Aug 2007 19:32:31 -0400
Received: from [172.16.3.165] (vagw.valinux.co.jp [210.128.90.14])
	by mail.valinux.co.jp (Postfix) with ESMTP id 08EA12DC86E
	for <kexec@lists.infradead.org>; Tue, 14 Aug 2007 08:32:27 +0900 (JST)
Date: Tue, 14 Aug 2007 08:32:59 +0900
From: Itsuro ODA <oda@valinux.co.jp>
Subject: Re: makedumpfile-1.1.5: Xen support
Message-Id: <20070814083117.DC32.ODA@valinux.co.jp>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi,

> Hmm, adding to skip zero-filled pages is easy but I wonder
> how effective it is ...

I found it is sometimes effective.

The attached patch enables the "-d" option with --xen-syms.
Note that only the level 1 (skip zero-filled pages) is supported.

ex. # makedumpfile -E -d 1 --xen-syms xen-syms.debug vmcore output

Thanks.
Itsuro Oda

On Tue, 31 Jul 2007 07:19:48 +0900
Itsuro ODA <oda@valinux.co.jp> wrote:

> Hi,
> 
> > Is the "-d" dump_level option completely ignored, or can it
> > (without vmlinux awareness) recognize and skip zero-filled
> > pages?
> 
> Yes, "-d" is ignored.
> 
> Hmm, adding to skip zero-filled pages is easy but I wonder
> how effective it is ...
> 
> Thanks.
> -- 
> Itsuro ODA <oda@valinux.co.jp>
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexe
-- 
--- makedumpfile.c.org	2007-08-10 15:14:22.000000000 +0900
+++ makedumpfile.c	2007-08-10 15:51:16.000000000 +0900
@@ -5195,6 +5195,9 @@
 	int i;
 	struct pt_load_segment *pls;
 	int ret = FALSE;
+	unsigned long long paddr;
+	off_t offset_page;
+	unsigned char *buf = NULL;
 
 	/*
 	 * NOTE: the first half of bitmap is not used for Xen extraction
@@ -5211,6 +5214,11 @@
 		    strerror(errno));
 		goto out;
 	}
+	if ((buf = malloc(info->page_size)) == NULL) {
+		ERRMSG("Can't allocate memory for the page. %s\n",
+		    strerror(errno));
+		goto out;
+	}
 
 	pfn = 0;
 	for (i = 0; i < info->num_load_memory; i++) {
@@ -5255,11 +5263,35 @@
 			 *  - xen heap area, or
 			 *  - selected domain page
 			 */
-			if (_domain == 0 ||
+			if (!(_domain == 0 ||
 				(info->xen_heap_start <= pfn && pfn < info->xen_heap_end) ||
-				((count_info & 0xffff) && is_select_domain(info, _domain))) {
-				set_bitmap(bm2.buf, pfn%PFN_BUFBITMAP, 1);
+				((count_info & 0xffff) && is_select_domain(info, _domain)))) {
+				continue;
+			}
+			if (info->dump_level & DL_EXCLUDE_ZERO) {
+				paddr = (unsigned long long)pfn * info->page_size;
+				offset_page = paddr_to_offset(info, paddr);
+				if (!offset_page) {
+					ERRMSG("Can't convert physaddr(%llx) to a offset.\n",
+					    paddr);
+					goto out;
+				}
+				if (lseek(info->fd_memory, offset_page,
+				    SEEK_SET) == (off_t)-1) {
+					ERRMSG("Can't seek the dump memory(%s). %s\n",
+					    info->name_memory, strerror(errno));
+					goto out;
+				}
+				if (read(info->fd_memory, buf, info->page_size)
+				    != info->page_size) {
+					ERRMSG("Can't read the dump memory(%s). %s\n",
+					    info->name_memory, strerror(errno));
+					goto out;
+				}
+				if (is_zero_page(buf, info->page_size))
+					continue;
 			}
+			set_bitmap(bm2.buf, pfn%PFN_BUFBITMAP, 1);
 		}
 	}
 
@@ -5275,6 +5307,8 @@
 out:
 	if (bm2.buf != NULL)
 		free(bm2.buf);
+	if (buf != NULL)
+		free(buf);
 
 	return ret;
 }
@@ -5546,7 +5580,7 @@
 			MSG("-E must be specified with --xen-syms or --xen-vmcoreinfo.\n");
 			goto out;
 		}
-		info->dump_level = DL_EXCLUDE_XEN;
+		info->dump_level |= DL_EXCLUDE_XEN;
 		return handle_xen(info);
 
 	} else if (info->flag_rearrange) {


-- 
Itsuro ODA <oda@valinux.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
