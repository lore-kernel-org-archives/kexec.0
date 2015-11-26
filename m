Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a21or-0000cx-M7
 for kexec@lists.infradead.org; Thu, 26 Nov 2015 19:03:02 +0000
Received: from localhost
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Thu, 26 Nov 2015 19:02:39 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id E246C17D8059
 for <kexec@lists.infradead.org>; Thu, 26 Nov 2015 19:03:02 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAQJ2a7G42991626
 for <kexec@lists.infradead.org>; Thu, 26 Nov 2015 19:02:36 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAQJ2aRL001916
 for <kexec@lists.infradead.org>; Thu, 26 Nov 2015 12:02:36 -0700
Date: Thu, 26 Nov 2015 20:02:35 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] kexec: fix mmap return code handling
Message-ID: <20151126200235.5450c397@holzheu>
In-Reply-To: <20151126190228.47e4213a@hananiah.suse.cz>
References: <20151125134741.55c7e21c@holzheu> <20151126183231.33da064b@holzheu>
 <20151126190228.47e4213a@hananiah.suse.cz>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Petr Tesarik <ptesarik@suse.cz>
Cc: kexec@lists.infradead.org

On Thu, 26 Nov 2015 19:02:28 +0100
Petr Tesarik <ptesarik@suse.cz> wrote:

> On Thu, 26 Nov 2015 18:32:31 +0100
> Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:
> 
> > Hi Simon again,
> > 
> > After a bit more thinking: In theory mmap() could also return NULL.
> > Therefore the following fix is probably the better one ...
> 
> No, if you let the kernel choose the address (i.e. call mmap with NULL
> addr), it will return at least PAGE_SIZE (and a higher limit is usually
> enforced by sys.vm.mmap_min_addr sysctl). Admittedly the limit is set
> in arch-specific code, so theoretically there can be an architecture
> which sets the limit to 0, but I doubt it, because it would break too
> many assumptions in user space (for example gcc assumes that
> dereferencing a NULL pointer terminates a process).
>
> In short, this other fix is just as good as the previous one.

Hi Petr,

Thanks for clarification! I still would vote for the second one ;-)

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
