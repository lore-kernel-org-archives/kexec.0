Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dBe0y-0007u1-0T
 for kexec@lists.infradead.org; Fri, 19 May 2017 09:16:05 +0000
Date: Fri, 19 May 2017 17:15:38 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] Handle additional e820 memmap type strings
Message-ID: <20170519091538.GA24903@x1>
References: <1494432217-26092-1-git-send-email-eric.devolder@oracle.com>
 <20170515140711.GB21797@x1>
 <ff7c75d3-2b12-fe7a-8ede-ec04a6161665@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ff7c75d3-2b12-fe7a-8ede-ec04a6161665@oracle.com>
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
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: andrew.cooper3@citrix.com, daniel.kiper@oracle.com, horms@verge.net.au, kexec@lists.infradead.org, konrad.wilk@oracle.com

On 05/17/17 at 07:51am, Eric DeVolder wrote:
> > > diff --git a/kexec/firmware_memmap.c b/kexec/firmware_memmap.c
> > > index 4d84f00..1ee214a 100644
> > > --- a/kexec/firmware_memmap.c
> > > +++ b/kexec/firmware_memmap.c
> > > @@ -164,6 +164,10 @@ static int parse_memmap_entry(const char *entry, struct memory_range *range)
> > >   		range->type = RANGE_RESERVED;
> > >   	else if (strcmp(type, "reserved") == 0)
> > >   		range->type = RANGE_RESERVED;
> > > +	else if (strcmp(type, "Reserved") == 0)
> > > +		range->type = RANGE_RESERVED;
> > > +	else if (strcmp(type, "Unknown E820 type") == 0)
> > > +		range->type = RANGE_RESERVED;
> > 
> > Should we change the "reserved" one to "Reserved" so that we don't need
> > to have "reserved" and "Reserved" at the same time?
> 
> The lower-case "reserved" has been in use by the kernel for quite a long
> while, and upper-case "Reserved" has been recently introduced. I think
> removing lower-case "reserved" would result in problems with existing,
> older, kernels that still would be using "reserved".

Thanks. Then it looks good to me. Ack.

Simon might pick several patches one time every several days. Please
wait.
> 
> > 
> > >   	else if (strcmp(type, "ACPI Non-volatile Storage") == 0)
> > >   		range->type = RANGE_ACPI_NVS;
> > >   	else if (strcmp(type, "Uncached RAM") == 0)
> > > -- 
> > > 2.7.4
> > > 
> > > 
> > > _______________________________________________
> > > kexec mailing list
> > > kexec@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
