Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IENmC-0000y8-Qx
	for kexec@lists.infradead.org; Fri, 27 Jul 2007 07:14:36 -0400
Date: Fri, 27 Jul 2007 07:14:28 -0400
From: Neil Horman <nhorman@redhat.com>
Subject: Re: makedumpfile-1.1.5: Xen support
Message-ID: <20070727111428.GB25242@hmsendeavour.rdu.redhat.com>
References: <20070727181243oomichi@mail.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070727181243oomichi@mail.jp.nec.com>
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
Cc: Itsuro ODA <oda@valinux.co.jp>, Akira Imamura <aimamura@redhat.com>, Bernhard Walle <bwalle@suse.de>, kexec-ml <kexec@lists.infradead.org>, Neil Horman <nhorman@redhat.com>

On Fri, Jul 27, 2007 at 06:12:43PM +0900, Ken'ichi Ohmichi wrote:
> 
> Hi,
> 
> makedumpfile version 1.1.5 is released.
> Please test it. Your opinions/comments are welcome.
> 
> Explanation of makedumpfile:
>   To shorten the size of the dumpfile and the time of creating the
>   dumpfile, makedumpfile copies only the necessary pages for analysis
>   to the dumpfile from /proc/vmcore. You can specify the kind of
>   unnecessary pages with dump_level. If you want to shorten the size
>   further, enable the compression of the page data.
> 
Hey, this is too late to take into 5.1, but I'll hapily take it for 5.2
Neil



> 
> Changelog:
> o Add a new feature that extracting the part of xen hypervisor and
>   domain-0 from /proc/vmcore. In most cases under xen environment,
>   it is enough to analyze a cause of system crash.
>   The patch was provided by Itsuro Oda.
>   Usage:
>     # makedumpfile -E --xen-syms xen-syms /proc/vmcore dumpfile
> 
> o Add a new option '-f' to overwrite existing dumpfile.
>   The patch was provided by Bernhard Walle.
> 
> o Add a new option '--message-level "message-level"'.
>   A user can specify multiple message types by setting the sum of each
>   message type for "message-level". The default value is '7' (Print
>   the progress indicator, common messages, and error messages).
>    0: Print nothing.
>    1: Print the progress indicator.
>    2: Print common messages.
>    4: Print error messages.
>    8: Print debugging messages.
> 
> o Fix the problem that makedumpfile complains about overlapping memory
>   segments. On some machines (ia64, discontigmem, and specific machine),
>   one pglist_data has overlapping memory segments with other nodes.
>   The existing makedumpfile complains about them, and it fails.
>   To fix the problem, overlapping memory segments is separated by
>   node_memblk. The idea was provided by Bernhard Walle.
> 
> o Rename makedumpfile's config file to "vmcoreinfo file".
>   http://lists.infradead.org/pipermail/kexec/2007-July/000349.html
> 
> o Change the method for getting the kernel's OSRELEASE if generating
>   a vmcoreinfo file. A new makedumpfile gets it from a vmlinux file.
>   http://lists.infradead.org/pipermail/kexec/2007-July/000319.html
> 
> o Some cleanups
>   - Cleanup the linux-version checking method.
>     The patch was provided by Neil Horman.
>   - Cleanup README for the building problem.
>   - Cleanup the method for getting the offset of page.mapping.
>   - Cleanup the method for reading a vmcoreinfo file.
> 
> 
> You can download the latest makedumpfile(ver. 1.1.5) from the following URL.
> Details of the change are written on the CVS page of the following site.
> https://sourceforge.net/projects/makedumpfile/
> 
> Method of installation:
>   You can compile the makedumpfile command as follows;
>   1. "tar -zxvf makedumpfile-1.1.5.tar.gz"
>   2. "cd makedumpfile"
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

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
