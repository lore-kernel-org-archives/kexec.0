Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp01.in.ibm.com ([59.145.155.1])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LQKFq-0000Os-1i
	for kexec@lists.infradead.org; Fri, 23 Jan 2009 11:31:21 +0000
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp01.in.ibm.com (8.13.1/8.13.1) with ESMTP id n0NBVDLL026580
	for <kexec@lists.infradead.org>; Fri, 23 Jan 2009 17:01:13 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0NBTBlr2502894
	for <kexec@lists.infradead.org>; Fri, 23 Jan 2009 16:59:11 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.13.1/8.13.3) with ESMTP id n0NBVCms008962
	for <kexec@lists.infradead.org>; Fri, 23 Jan 2009 22:31:13 +1100
Message-ID: <4979AA81.8030300@in.ibm.com>
Date: Fri, 23 Jan 2009 17:01:13 +0530
From: Chandru <chandru@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [patch] Possible fix for kexec-tools dynamic range allocation
References: <20090120212959.GA3564@verge.net.au>
In-Reply-To: <20090120212959.GA3564@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: Michael Ellerman <michael@ellerman.id.au>, Bernhard Walle <bwalle@suse.de>, mohan@in.ibm.com, kexec@lists.infradead.org

Simon Horman wrote:
>
> Does Bernhard's recent patch (sorry that I applied it even though
> it came in after your patch) help this problem?
>
> commit 95c74405638c786bc76fbca5e4e8427dfe26e907
> Author: Bernhard Walle <bwalle@suse.de>
> Date:   Fri Jan 16 19:11:34 2009 +0100
> Subject: Fix memory corruption when using realloc_memory_ranges()
>
>   
'git clone' or 'git pull' isn't showing these patches. The last commit 
that I can see is : 6d4cdf4f94bf7ad2d1752b553ea948385881ff79 and search 
by that commit doesn't yield anything :(.

Thanks,
Chandru

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
