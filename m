Return-path: <kexec-bounces@lists.infradead.org>
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IkZs4-0007bx-UA
	for kexec@lists.infradead.org; Wed, 24 Oct 2007 07:37:46 +0100
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9O6YTtU003726
	for <kexec@lists.infradead.org>; Wed, 24 Oct 2007 02:34:29 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9O6YT4k069080
	for <kexec@lists.infradead.org>; Wed, 24 Oct 2007 00:34:29 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9O6YSCh026463
	for <kexec@lists.infradead.org>; Wed, 24 Oct 2007 00:34:28 -0600
Date: Wed, 24 Oct 2007 12:04:34 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH 0/3] x86: unify crash_32/64.c
Message-ID: <20071024063434.GC4622@in.ibm.com>
References: <47195763.1090803@ct.jp.nec.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47195763.1090803@ct.jp.nec.com>
Reply-To: vgoyal@in.ibm.com
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
Errors-To: kexec-bounces@lists.infradead.org
To: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Cc: hbabu@us.ibm.com, tglx@linutronix.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, Oct 19, 2007 at 06:18:27PM -0700, Hiroshi Shimamoto wrote:
> Hi,
> 
> I made patches to unify crash_32/64.c.
> There are three patches;
> 1. add lapic_shutdown for x86_64
> 2. add safe_smp_processor_id for x86_64
> 3. unify crash_32/64.c
> 
> I'm not sure that it's good to split to these patches.
> 
> I've compiled on both of 32bit and 64bit, and tested
> kdump on 64bit.
> 

Hi Hiroshi,

Thanks for the patches. Can you please also test it on 32bit to make
sure nothing is broken.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
