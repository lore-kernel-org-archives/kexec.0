Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UmYJ2-0000qV-Uv
 for kexec@lists.infradead.org; Tue, 11 Jun 2013 23:48:54 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 783FC3EE0BD
 for <kexec@lists.infradead.org>; Wed, 12 Jun 2013 08:48:24 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 67D4945DEB6
 for <kexec@lists.infradead.org>; Wed, 12 Jun 2013 08:48:24 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 527D445DEB5
 for <kexec@lists.infradead.org>; Wed, 12 Jun 2013 08:48:24 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 4494C1DB803B
 for <kexec@lists.infradead.org>; Wed, 12 Jun 2013 08:48:24 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id F03EB1DB803E
 for <kexec@lists.infradead.org>; Wed, 12 Jun 2013 08:48:23 +0900 (JST)
Message-ID: <51B7B728.9000803@jp.fujitsu.com>
Date: Wed, 12 Jun 2013 08:47:52 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v5 5/5] s390/vmcore: Use vmcore for zfcpdump
References: <1370624161-2298-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1370624161-2298-6-git-send-email-holzheu@linux.vnet.ibm.com>
In-Reply-To: <1370624161-2298-6-git-send-email-holzheu@linux.vnet.ibm.com>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

(2013/06/08 1:56), Michael Holzheu wrote:
<cut>
> @@ -82,6 +116,43 @@ int remap_oldmem_pfn_range(struct vm_area_struct *vma, unsigned long from,
>   }
>
>   /*
> + * Remap "oldmem" for zfcpdump
> + *
> + * We only map available memory above ZFCPDUMP_HSA_SIZE. Memory below
> + * ZFCPDUMP_HSA_SIZE is read on demand using the copy_oldmem_page() function.
> + */
> +static int remap_oldmem_pfn_range_zfcpdump(struct vm_area_struct *vma,
> +					   unsigned long from,
> +					   unsigned long pfn,
> +					   unsigned long size, pgprot_t prot)
> +{
> +	unsigned long size_hsa;
> +
> +	if (pfn < ZFCPDUMP_HSA_SIZE >> PAGE_SHIFT) {
> +		size_hsa = min(size, OLDMEM_SIZE - (pfn << PAGE_SHIFT));

ZFCPDUMP_HSA_SIZE?

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
