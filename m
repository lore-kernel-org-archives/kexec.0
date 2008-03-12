Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JZJx0-0006G8-QR
	for kexec@lists.infradead.org; Wed, 12 Mar 2008 05:56:31 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2C5uR9x030230
	for <kexec@lists.infradead.org>; Wed, 12 Mar 2008 01:56:27 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2C5uRJp311262
	for <kexec@lists.infradead.org>; Wed, 12 Mar 2008 01:56:27 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2C5uRch016481
	for <kexec@lists.infradead.org>; Wed, 12 Mar 2008 01:56:27 -0400
Date: Wed, 12 Mar 2008 11:26:23 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: Fwd: Kexec support for PS3 (ppc64)
Message-ID: <20080312055623.GD409@in.ibm.com>
References: <C5065F118AFB3D478B052FC1E9810D9CA9041B@tec-mail.ttec.soc-soft.com>
	<4574cb3d0803062155k7da6be9al30ee3f35d01f9f0@mail.gmail.com>
	<47D19114.1090700@am.sony.com>
	<4574cb3d0803110325u759a411ckbae3ff69557b0230@mail.gmail.com>
	<47D6B92D.2020205@am.sony.com> <47D6D406.8050209@am.sony.com>
	<47D73003.8060208@bluelane.com> <47D7349E.90409@am.sony.com>
	<20080312052509.GC409@in.ibm.com> <47D76CC9.5080200@am.sony.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47D76CC9.5080200@am.sony.com>
Reply-To: mohan@in.ibm.com
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
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: Rajasekaran P <rajasekaran83@gmail.com>, kexec@lists.infradead.org, piet@bluelane.com

On Tue, Mar 11, 2008 at 10:40:25PM -0700, Geoff Levand wrote:
> That is for the IBM pSeries.  I can't see how it would work
> on the ps3.  ps3 hvcalls are in lv1calls.h.

Oh, okay.

> 
> Just out of curiosity, how exactly did you 'use' it?
> 

We used the function plpar_put_term_char

Regards,
Mohan.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
