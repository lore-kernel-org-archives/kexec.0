Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W2j2C-0001b9-Va
 for kexec@lists.infradead.org; Mon, 13 Jan 2014 15:02:37 +0000
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 13 Jan 2014 15:02:11 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 88FE117D8059
 for <kexec@lists.infradead.org>; Mon, 13 Jan 2014 15:02:19 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0DF1t9p56688750
 for <kexec@lists.infradead.org>; Mon, 13 Jan 2014 15:01:55 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0DF27R5014190
 for <kexec@lists.infradead.org>; Mon, 13 Jan 2014 08:02:07 -0700
Date: Mon, 13 Jan 2014 16:02:05 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2 V2] raw i/o and root device to use less memory
Message-ID: <20140113160205.6e631a5e@holzheu>
In-Reply-To: <20140113133033.GA917@sgi.com>
References: <E1Vy8l7-0004oL-7v@eag09.americas.sgi.com>
 <20140110175830.GA7498@sgi.com> <20140113105831.57412728@holzheu>
 <20140113133033.GA917@sgi.com>
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
To: Cliff Wickman <cpw@sgi.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org

On Mon, 13 Jan 2014 07:30:33 -0600
Cliff Wickman <cpw@sgi.com> wrote:

> On Mon, Jan 13, 2014 at 10:58:31AM +0100, Michael Holzheu wrote:
> > On Fri, 10 Jan 2014 11:58:30 -0600
> > Cliff Wickman <cpw@sgi.com> wrote:
> > 
> > [snip]
> > 
> > > Use O_DIRECT (raw) i/o for the dump and for the bitmaps file, so that writing
> > > to those files does not allocate kernel memory for page cache.
> > 
> > Hello Cliff,
> > 
> > Have you tested O_DIRECT together with the new vmcore mmap interface?
> > IIRC when we tried O_DIRECT together with mmap for some reason it did
> > not work.
> > 
> > Michael
> 
> Hi Michael,
> 
>   How new of a kernel do I need?  i.e. how 'new' of an mmap interface?
>   The latest kernel I used was 3.0.93 (sle11sp3).
>   And makedumpfile was 1.5.5.

I think sles11 SP3 does not support mmap for /proc/vmcore. Upstream you
need at least kernel 3.11. For makedumpfile version 1.5.5 should be ok.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
