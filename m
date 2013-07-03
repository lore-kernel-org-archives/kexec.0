Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UuHyZ-0003V2-5b
 for kexec@lists.infradead.org; Wed, 03 Jul 2013 07:59:43 +0000
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 3 Jul 2013 08:56:49 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 148912190059
 for <kexec@lists.infradead.org>; Wed,  3 Jul 2013 09:03:02 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r637x6pa47710242
 for <kexec@lists.infradead.org>; Wed, 3 Jul 2013 07:59:06 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r637xGB1006069
 for <kexec@lists.infradead.org>; Wed, 3 Jul 2013 01:59:16 -0600
Date: Wed, 3 Jul 2013 09:59:13 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 2/5] s390/vmcore: Use ELF header in new memory feature
Message-ID: <20130703095913.6f6d145d@holzheu>
In-Reply-To: <20130702162322.GD22603@redhat.com>
References: <1372707159-10425-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1372707159-10425-3-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130702162322.GD22603@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Tue, 2 Jul 2013 12:23:23 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Mon, Jul 01, 2013 at 09:32:36PM +0200, Michael Holzheu wrote:
> 
> [..]
> > +ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
> > +{
> > +	void *src = (void *)(unsigned long)*ppos;
> > +
> > +	src = elfcorehdr_newmem ? src : src - OLDMEM_BASE;
> 
> Seriously, we need to get rid of all this OLDMEM_BASE logic in s390
> specific code. For regular kdump, it is no different than x86. Only
> special handling required for zfcpdump for HSA region.
> 
> Why do we need above. Is it to cover the case where elfcorehdr have
> been prepared by user space? Are elf headers initially stored in
> reserved region and then swapped. Why do we need to swap these or
> why kexec-tools could not take care of swapping it.

I know it is confusing. The "src - OLDMEM_BASE" term is currently
needed because of the swap issue that we have discussed already. We
load the ELF header into reserved memory
[OLDMEM_BASE, OLDMEM_BASE + OLDMEM_SIZE] that is swapped with
[0, OLDMEM_SIZE]. So the ELF header address has to be adjusted.

Thanks!
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
