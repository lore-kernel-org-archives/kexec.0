Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HgHT1-0001Ad-Rw
	for kexec@lists.infradead.org; Tue, 24 Apr 2007 10:37:49 +0100
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3O9bMRI027199
	for <kexec@lists.infradead.org>; Tue, 24 Apr 2007 05:37:22 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3O9bLqb156204
	for <kexec@lists.infradead.org>; Tue, 24 Apr 2007 03:37:21 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3O9bLKc023239
	for <kexec@lists.infradead.org>; Tue, 24 Apr 2007 03:37:21 -0600
Date: Tue, 24 Apr 2007 14:31:55 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH] aacraid: fails to initialize after a  kexec operation
Message-ID: <20070424090154.GD22742@in.ibm.com>
References: <20070423161203.GA2129@in.ibm.com>
	<AE4F746F2AECFC4DA4AADD66A1DFEF0188AE58@otce2k301.adaptec.com>
	<20070424084444.GC22742@in.ibm.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070424084444.GC22742@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
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
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, Kexec Mailing List <kexec@lists.infradead.org>, Judith Lebzelter <judith@linux-foundation.org>, linux-scsi@vger.kernel.org

On Tue, Apr 24, 2007 at 02:14:44PM +0530, Vivek Goyal wrote:
> 
> In second attempt, it mounted the file system but it found some issue
> with "resize" inode and asked me to run fsck manually. Which in turn 
> deleted whole lot of inodes.
> 
> In third attemt it panics later when it finds ext3 to be corrupted.
> 
> =========================================
> Creating block device nodes.
> Trying to resume from LABEL=SWAP-sda3
> No suspend signature on swap, not resuming.
> Creating root device.
> Mounting root filesystem.
> EXT3-fs: Magic mismatch, very weird !
> mount: error mouKernel panic - not syncing: Attempted to kill init!
> nting /dev/root
> =================================================== 
> 

Hi Mark,

Interesting observation. After above message I rebooted my system
expecting ext3 is corrupted and I shall have to try to recover it
using fsck. Nothing of that sort happened. System just booted fine.

This leaves me wondering why does ext things that Magic number is a 
mismatch while booting using kexec. Is AACRAID returning the write bytes
from the disk after an reset?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
