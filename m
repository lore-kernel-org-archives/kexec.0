Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UzyBm-00011m-Im
 for kexec@lists.infradead.org; Fri, 19 Jul 2013 00:04:52 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 978913EE0BC
 for <kexec@lists.infradead.org>; Fri, 19 Jul 2013 09:04:20 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 883BE45DEB5
 for <kexec@lists.infradead.org>; Fri, 19 Jul 2013 09:04:20 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7243C45DEB6
 for <kexec@lists.infradead.org>; Fri, 19 Jul 2013 09:04:20 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 63FD71DB803B
 for <kexec@lists.infradead.org>; Fri, 19 Jul 2013 09:04:20 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 169E5EF8002
 for <kexec@lists.infradead.org>; Fri, 19 Jul 2013 09:04:20 +0900 (JST)
Message-ID: <51E88265.1000005@jp.fujitsu.com>
Date: Fri, 19 Jul 2013 09:03:49 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 6/7] Mute some compiler warnings
References: <1373977929-4253-1-git-send-email-daniel.kiper@oracle.com>
 <1373977929-4253-7-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1373977929-4253-7-git-send-email-daniel.kiper@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: andrew.cooper3@citrix.com, xen-devel@lists.xensource.com, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

(2013/07/16 21:32), Daniel Kiper wrote:
<cut>
> diff --git a/sadump_info.c b/sadump_info.c
> index be6cf55..01cf5eb 100644
> --- a/sadump_info.c
> +++ b/sadump_info.c
> @@ -948,7 +948,6 @@ int
>   readpage_sadump(unsigned long long paddr, void *bufptr)
>   {
>   	unsigned long long pfn, block, whole_offset, perdisk_offset;
> -	ulong page_offset;
>   	int fd_memory;
>
>   	if (si->kdump_backed_up &&
> @@ -957,7 +956,6 @@ readpage_sadump(unsigned long long paddr, void *bufptr)
>   		paddr += si->backup_offset - si->backup_src_start;
>
>   	pfn = paddr_to_pfn(paddr);
> -	page_offset = paddr % info->page_size;
>
>   	if (pfn >= si->sh_memory->max_mapnr)
>   		return FALSE;
>

It seems good to me. Thanks.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
