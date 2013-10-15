Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VW2pv-0004vI-7w
 for kexec@lists.infradead.org; Tue, 15 Oct 2013 11:30:52 +0000
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Tue, 15 Oct 2013 12:30:28 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1B5182190063
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 12:30:25 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9FBUC9d57278688
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 11:30:12 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9FBUNBH004290
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 05:30:24 -0600
Date: Tue, 15 Oct 2013 13:30:21 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] procfs, vmcore: fix regression of mmap on
 /proc/vmcore since v3.12-rc1
Message-ID: <20131015133021.44602125@holzheu>
In-Reply-To: <20131014093606.9801.11175.stgit@localhost6.localdomain6>
References: <20131014093606.9801.11175.stgit@localhost6.localdomain6>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, davem@davemloft.net, willeke@de.ibm.com, ebiederm@xmission.com, akpm@linux-foundation.org, adobriyan@gmail.com, vgoyal@redhat.com

Hello Hatayama,

We successfully tested your patches on s390, mmap for /proc/vmcore
seems to work again.

Thanks!

Michael

On Mon, 14 Oct 2013 18:36:06 +0900
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> This patch set fixes regression of mmap on /proc/vmcore since
> v3.12-rc1. The primary one is the 2nd patch. The 1st patch is another
> bug I found during investiation and it affects mmap on /proc/vmcore
> even if only 2nd patch is applied, so fix it together in this patch
> set. The last patch is just for cleaning up of target function in both
> 1st and 2nd patches.
> 
> ---
> 
> HATAYAMA Daisuke (3):
>       procfs: fix unintended truncation of returned mapped address
>       procfs: Call default get_unmapped_area on MMU-present architectures
>       procfs: clean up proc_reg_get_unmapped_area for 80-column limit
> 
> 
>  fs/proc/inode.c |   20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
