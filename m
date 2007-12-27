Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J7hzx-00057C-Ep
	for kexec@lists.infradead.org; Thu, 27 Dec 2007 01:57:31 +0000
Date: Wed, 26 Dec 2007 20:57:16 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/3 -mm] kexec jump -v8
Message-ID: <20071227015716.GA6718@redhat.com>
References: <1198222399.1965.15.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1198222399.1965.15.camel@caritas-dev.intel.com>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org

On Fri, Dec 21, 2007 at 03:33:19PM +0800, Huang, Ying wrote:

[..]
> The following user-space tools can be used with kexec jump.
> 
> 1. kexec-tools needs to be patched to support kexec jump. The patches
>    and the precompiled kexec can be download from the following URL:
>        source: http://khibernation.sourceforge.net/download/release_v8/kexec-tools/kexec-tools-src_git_kh8.tar.bz2
>        patches: http://khibernation.sourceforge.net/download/release_v8/kexec-tools/kexec-tools-patches_git_kh8.tar.bz2
>        binary: http://khibernation.sourceforge.net/download/release_v8/kexec-tools/kexec_git_kh8
> 
> 2. makedumpfile with patches are used as memory image saving tool, it
>    can exclude free pages from original kernel memory image file. The
>    patches and the precompiled makedumpfile can be download from the
>    following URL:
>        source: http://khibernation.sourceforge.net/download/release_v8/makedumpfile/makedumpfile-src_cvs_kh8.tar.bz2
>        patches: http://khibernation.sourceforge.net/download/release_v8/makedumpfile/makedumpfile-patches_cvs_kh8.tar.bz2
>        binary: http://khibernation.sourceforge.net/download/release_v8/makedumpfile/makedumpfile_cvs_kh8
> 
> 3. A simplest memory image restoring tool named "krestore" is
>    implemented. It can be downloaded from the following URL:
>        source: http://khibernation.sourceforge.net/download/release_v8/krestore/krestore-src_cvs_kh8.tar.bz2
>        binary: http://khibernation.sourceforge.net/download/release_v8/krestore/krestore_cvs_kh8
> 
> An initramfs image can be used as the root file system of kexeced
> kernel. An initramfs image built with "BuildRoot" can be downloaded
> from the following URL:
>     initramfs image: http://khibernation.sourceforge.net/download/release_v8/initramfs/rootfs_cvs_kh8.gz
> All user space tools above are included in the initramfs image.
> 
> 
> Usage example of jumping between original and kexeced kernel:
> 
> 1. Compile and install patched kernel with following options selected:
> 
> CONFIG_X86_32=y
> CONFIG_RELOCATABLE=y
> CONFIG_KEXEC=y
> CONFIG_CRASH_DUMP=y
> CONFIG_PM=y
> 
> 2. Build an initramfs image contains kexec-tool, or download the
>    pre-built initramfs image, called rootfs.gz in following text.
> 
> 3. Boot kernel compiled in step 1.
> 
> 4. Load kernel compiled in step 1 with /sbin/kexec. If You want to use
>    "krestore" tool, the --elf64-core-headers should be specified in
>    command line of /sbin/kexec. The shell command line can be as
>    follow:
> 
>    /sbin/kexec --load-jump-back /boot/bzImage --mem-min=0x100000
>      --mem-max=0xffffff --elf64-core-headers --initrd=rootfs.gz
> 
> 5. Boot the kexeced kernel with following shell command line:
> 
>    /sbin/kexec -e
> 
> 6. The kexeced kernel will boot as normal kexec. In kexeced kernel the
>    memory image of original kernel can read via /proc/vmcore or
>    /dev/oldmem, and can be written via /dev/oldmem. You can
>    save/restore/modify it as you want to.
> 
> 7. Prepare jumping back from kexeced kernel with following shell
>    command lines:
> 
>    jump_back_entry=`cat /proc/cmdline | tr ' ' '\n' | grep kexec_jump_back_entry | cut -d '='`
>    /sbin/kexec --load-jump-back-helper=$jump_back_entry
> 
> 8. Jump back to the original kernel with following shell command line:
> 
>    /sbin/kexec -e
> 
> 9. Now, you are in the original kernel again. You can read/write the
>    memory image of kexeced kernel via /proc/kimgcore.
> 

Why do we need two interfaces, /proc/vmcore and /proc/kimgcore? Can't
we have just one say /proc/vmcore. Irrespective of what kernel you are
in /proc/vmcore gives you the access to the memory of kernel which was
previously booted.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
