Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MwXg6-00059I-Sc
	for kexec@lists.infradead.org; Sat, 10 Oct 2009 08:51:55 +0000
Date: Sat, 10 Oct 2009 16:51:35 +0800 (CST)
Message-Id: <20091010.165135.12569232.caiqian@redhat.com>
Subject: Re: makedumpfile-1.3.4: Support kdump-compressed format for input
	file.
From: CAI Qian <caiqian@redhat.com>
In-Reply-To: <4ACEA2A3.5090706@mxs.nes.nec.co.jp>
References: <4ACEA2A3.5090706@mxs.nes.nec.co.jp>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: oomichi@mxs.nes.nec.co.jp
Cc: usui@mxm.nes.nec.co.jp, tindoh@redhat.com, kexec@lists.infradead.org, caiqian@redhat.com, anderson@redhat.com

Hallo Ken'ichi!

From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: makedumpfile-1.3.4: Support kdump-compressed format for input file.
Date: Fri, 09 Oct 2009 11:40:35 +0900

> 
> Hi,
> 
> makedumpfile version 1.3.4 is released.
> Your comments/patches are welcome.
> 
> Changelog:
>  o New feature
>    - Support kdump-compressed format for input file. (by Takao Indoh)
>       A new makedumpfile can read dumpfile which is kdump-compressed format
>       instead of /proc/vmcore and re-filter it.

Does it need to specify either a vmlinux or vmcoreinfo file?  Got a
failure if not. Note, file vmcore is a full VMCore generated from a
2.6.31 x86_64 kernel and kexec-tools-2.0.0.

# ./makedumpfile -c -d 3 vmcore vmcore.1
...
The dumpfile is saved to vmcore.1
...
# /makedumpfile -c -d 31 vmcore.1 vmcore.2
vmcore.1 doesn't contain vmcoreinfo.
Specify '-x' option or '-i' option.
Commandline parameter is invalid.
Try `makedumpfile --help' for more information.

makedumpfile Failed.

Thanks!
CAI Qian

>    - Add dump filtering on an x86_64 xen domain-0.
>       A new makedumpfile can exclude unnecessary pages (cache pages, user
>       process data pages, and free pages) on on x86_64 xen domain-0.
>    - Save utsname data into disk_dump_header.
>       A new makedumpfile saves utsname data into disk_dump_header.
>       The crash utility can output the data from a dumpfile by 'help -n'.
>    - Add linux-2.6.30 - 2.6.31 support.
> 
>  o Bugfix
>    - Fix some lacks of free(). (by Minoru Usui)
> 
>  o Code Cleanup
>    - Add some comments to code for the readability.
>    - Remove VERSION_LINUX_2_6_XX.
>    - Add paddr_to_pfn() and pfn_to_paddr() macros.
>    - Merge the version information of makedumpfile.
>    - Merge the PT_NOTE methods of both elf64 and elf32.
>    - Reduce some indents in exclude_unnecessary_pages().
>    - Remove unnecessary spaces.
>    - read_disk_dump_header() and read_kdump_sub_header().
>    - Use DISKDUMP_HDADER_BLOCKS for the readability.
> 
> Explanation of makedumpfile:
>   To shorten the size of the dumpfile and the time of creating the
>   dumpfile, makedumpfile copies only the necessary pages for analysis
>   to the dumpfile from /proc/vmcore. You can specify the kind of
>   unnecessary pages with dump_level. If you want to shorten the size
>   further, enable the compression of the page data.
> 
> Download:
>   You can download the latest makedumpfile from the following URL.
>   Details of the change are written on the CVS page of the following site.
>   https://sourceforge.net/projects/makedumpfile/
> 
> Method of installation:
>   You can compile the makedumpfile command as follows;
>   1. "tar -zxvf makedumpfile-x.y.z.tar.gz"
>   2. "cd makedumpfile-x.y.z"
>   3. "make; make install"
> 
> Usage:
>   makedumpfile [-c] [-E] [-d dump_level] [-x vmlinux] dump_mem dump_file
> 
> Example:
>   If you want to exclude pages filled by zero, cache pages, user pages
>   and free pages and to enable compression, please execute the following
>   command.
> 
>   # makedumpfile -c -d 31 -x vmlinux /proc/vmcore dumpfile
> 
> 
> Thanks
> Ken'ichi Ohmichi
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
