Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IMA5f-0001Y1-VD
	for kexec@lists.infradead.org; Fri, 17 Aug 2007 18:14:50 -0400
Message-ID: <007901c7e11c$1d5e4640$545010ac@fcsw1jlydk0m5j>
From: "Akira Imamura" <aimamura@redhat.com>
References: <20070813111858oomichi@mail.jp.nec.com>
Subject: Re: makedumpfile-1.1.6: linux-2.6.22 support
Date: Fri, 17 Aug 2007 18:15:21 -0400
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: RH Imamura <aimamura@redhat.com>, kexec-ml <kexec@lists.infradead.org>

Hi Ohmichi-san,

I'm sorry for my late reply.

> o Some cleanups
>  - Cleanup the description for '--message-level' by Akira Imamura.

Thank you for applying it. I verified the latest package.

Thanks,
Akira Imamura

>
> Hi,
>
> makedumpfile version 1.1.6 is released.
> Please test it. Your opinions/comments are welcome.
>
> Explanation of makedumpfile:
>  To shorten the size of the dumpfile and the time of creating the
>  dumpfile, makedumpfile copies only the necessary pages for analysis
>  to the dumpfile from /proc/vmcore. You can specify the kind of
>  unnecessary pages with dump_level. If you want to shorten the size
>  further, enable the compression of the page data.
>
>
> Changelog:
>
> Changelog:
> o linux-2.6.22 support.
>  The method for getting the member offset of "page.mapping" is
>  applied for linux-2.6.22.
>  Old makedumpfile assumed that there was "mapping" in the first
>  union in structure "page". But on linux-2.6.22, there is "mapping"
>  in the second union, because "_mapcount" and structure for slub
>  are packed in the first union. Then, new makedumpfile gets the
>  offset by searching "mapping" in each union.
>
> o Change the check method of free_pages for linux-2.6.21 or later.
>  On linux-2.6.21 or later, the number of free_pages (vm_stat[0])
>  is sometimes different from the one of the pages listed in
>  "free_area" actually, because the former is flushed asynchronously.
>  Then, new makedumpfile doesn't check these numbers, and confirms
>  the free_pages only by checking whether the list "free_area" is
>  not corrupted.
>
> o Some cleanups
>  - Cleanup the description for '--message-level' by Akira Imamura.
>  - Cleanup the structures DumpInfo and vm_table.
>  - Cleanup the dwarf method.
>  - Cleanup page_to_pfn() method.
>
>
> You can download the latest makedumpfile(ver. 1.1.6) from the following 
> URL.
> Details of the change are written on the CVS page of the following site.
> https://sourceforge.net/projects/makedumpfile/
>
> Method of installation:
>  You can compile the makedumpfile command as follows;
>  1. "tar -zxvf makedumpfile-1.1.6.tar.gz"
>  2. "cd makedumpfile"
>  3. "make; make install"
>
> Usage:
>  makedumpfile [-c] [-E] [-d dump_level] [-x vmlinux] dump_mem dump_file
>
> Example:
>  If you want to exclude pages filled by zero, cache pages, user pages
>  and free pages and to enable compression, please execute the following
>  command.
>
>  # makedumpfile -c -d 31 -x vmlinux /proc/vmcore dumpfile
>
>
> Thanks
> Ken'ichi Ohmichi
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
