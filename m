Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Umh8j-0000MG-NE
 for kexec@lists.infradead.org; Wed, 12 Jun 2013 09:14:50 +0000
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 12 Jun 2013 10:12:12 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3B03D1B08061
 for <kexec@lists.infradead.org>; Wed, 12 Jun 2013 10:14:25 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5C9EDX553870834
 for <kexec@lists.infradead.org>; Wed, 12 Jun 2013 09:14:13 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r5C9EObr010987
 for <kexec@lists.infradead.org>; Wed, 12 Jun 2013 03:14:24 -0600
Date: Wed, 12 Jun 2013 11:14:22 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 5/5] s390/vmcore: Use vmcore for zfcpdump
Message-ID: <20130612111422.2a1d6889@holzheu>
In-Reply-To: <51B7B728.9000803@jp.fujitsu.com>
References: <1370624161-2298-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1370624161-2298-6-git-send-email-holzheu@linux.vnet.ibm.com>
 <51B7B728.9000803@jp.fujitsu.com>
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
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

On Wed, 12 Jun 2013 08:47:52 +0900
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> (2013/06/08 1:56), Michael Holzheu wrote:
[snip]
> > +static int remap_oldmem_pfn_range_zfcpdump(struct vm_area_struct *vma,
> > +					   unsigned long from,
> > +					   unsigned long pfn,
> > +					   unsigned long size, pgprot_t prot)
> > +{
> > +	unsigned long size_hsa;
> > +
> > +	if (pfn < ZFCPDUMP_HSA_SIZE >> PAGE_SHIFT) {
> > +		size_hsa = min(size, OLDMEM_SIZE - (pfn << PAGE_SHIFT));
> 
> ZFCPDUMP_HSA_SIZE?

Correct!

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
