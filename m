Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ausmtp04.au.ibm.com ([202.81.18.152])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KGB2O-00070z-F3
	for kexec@lists.infradead.org; Tue, 08 Jul 2008 11:07:13 +0000
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id m68B90dk090688
	for <kexec@lists.infradead.org>; Tue, 8 Jul 2008 21:09:00 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m68AwBsR238310
	for <kexec@lists.infradead.org>; Tue, 8 Jul 2008 20:58:11 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m68AwAwK003053
	for <kexec@lists.infradead.org>; Tue, 8 Jul 2008 20:58:10 +1000
From: Chandru <chandru@in.ibm.com>
Subject: Re: [PATCH 1/4] kdump : add support for ibm,
	dynamic-reconfiguration-memory for kexec/kdump
Date: Tue, 8 Jul 2008 16:28:07 +0530
References: <200807080014.24910.chandru@in.ibm.com>
	<20080708113646.13836635.sfr@canb.auug.org.au>
In-Reply-To: <20080708113646.13836635.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200807081628.07843.chandru@in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org

Thanks for the review comments. I will change to 'snprintf' at all the places  
and remove the unnecessary casts.

On Tuesday 08 July 2008 07:06:46 Stephen Rothwell wrote:
> Hi Chandru,
>
> On Tue, 8 Jul 2008 00:14:24 +0530 Chandru <chandru@in.ibm.com> wrote:
> > +		if (usm != NULL) {
> > +			ranges = (len >> 2) / (n_mem_addr_cells +
>
>                                  ^^^^^^^^^^
> len / sizeof(u32) ?

ranges is made to count the number of linux,usable-memory properties in the 
device tree.  It's acting as a counter here.  So the expression in the patch 
is fine. 

Thanks,
Chandru

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
