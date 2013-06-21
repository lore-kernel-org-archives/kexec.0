Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uq1ZC-00037A-MK
 for kexec@lists.infradead.org; Fri, 21 Jun 2013 13:39:55 +0000
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 21 Jun 2013 14:35:04 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id D42E71B08023
 for <kexec@lists.infradead.org>; Fri, 21 Jun 2013 14:39:27 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5LDdGw340566936
 for <kexec@lists.infradead.org>; Fri, 21 Jun 2013 13:39:16 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r5LDdQFK030927
 for <kexec@lists.infradead.org>; Fri, 21 Jun 2013 07:39:26 -0600
Date: Fri, 21 Jun 2013 15:39:24 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 0/5] kdump: Allow ELF header creation in new kernel
Message-ID: <20130621153924.1d3ad4c5@holzheu>
In-Reply-To: <20130614185454.GM12023@redhat.com>
References: <1370624161-2298-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130614185454.GM12023@redhat.com>
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

On Fri, 14 Jun 2013 14:54:54 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Fri, Jun 07, 2013 at 06:55:56PM +0200, Michael Holzheu wrote:
> 
> [..]
> > In this patch series I did not include the discussed ELF header swap trick
> > patch because with the ELF header read functions this patch currently is
> > not necessary.
> 
> Michael,
> 
> Would be good to this change atleast in a separate patch series so that
> we have common mechanism across arches and understanding code becomes
> easier.

Ok fine, we can do that in a separate patch series on top.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
