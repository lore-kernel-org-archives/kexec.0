Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JZJSx-00044h-DM
	for kexec@lists.infradead.org; Wed, 12 Mar 2008 05:25:27 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2C5OQG6016878
	for <kexec@lists.infradead.org>; Wed, 12 Mar 2008 01:24:26 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2C5PMpT143462
	for <kexec@lists.infradead.org>; Tue, 11 Mar 2008 23:25:22 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2C5PM1x022205
	for <kexec@lists.infradead.org>; Tue, 11 Mar 2008 23:25:22 -0600
Date: Wed, 12 Mar 2008 10:55:09 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: Fwd: Kexec support for PS3 (ppc64)
Message-ID: <20080312052509.GC409@in.ibm.com>
References: <C5065F118AFB3D478B052FC1E9810D9CA9041B@tec-mail.ttec.soc-soft.com>
	<4574cb3d0803062155k7da6be9al30ee3f35d01f9f0@mail.gmail.com>
	<47D19114.1090700@am.sony.com>
	<4574cb3d0803110325u759a411ckbae3ff69557b0230@mail.gmail.com>
	<47D6B92D.2020205@am.sony.com> <47D6D406.8050209@am.sony.com>
	<47D73003.8060208@bluelane.com> <47D7349E.90409@am.sony.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47D7349E.90409@am.sony.com>
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

On Tue, Mar 11, 2008 at 06:40:46PM -0700, Geoff Levand wrote:
> When the first stage kernel goes down it releases all hypervisor
> resources so that whatever boots next can successful open those
> resources.  The frame buffer is one of those resources that are
> released, and after it is, there will be no more output to the
> display until the second stage image brings up its display.  It
> is not a matter of adding print statements or string formatting.
>

Geoff,

What about using Hypervisor call H_PUT_TERM_CHAR?

I used this call to debug the first kernel kexec shutdown sequence.

Regards,
Mohan.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
