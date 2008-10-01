Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kl6Yz-0006yk-6c
	for kexec@lists.infradead.org; Wed, 01 Oct 2008 18:36:41 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m91IaLcV001862
	for <kexec@lists.infradead.org>; Wed, 1 Oct 2008 14:36:21 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m91IaLhc137628
	for <kexec@lists.infradead.org>; Wed, 1 Oct 2008 12:36:21 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m91IaLub001948
	for <kexec@lists.infradead.org>; Wed, 1 Oct 2008 12:36:21 -0600
Message-ID: <48E3C318.3040507@in.ibm.com>
Date: Thu, 02 Oct 2008 00:06:08 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Remove legacy kdump kernel build support
References: <20080930124828.GA1945@in.ibm.com>
	<20080930172540.GA21378@oksana.dev.rtsoft.ru>
In-Reply-To: <20080930172540.GA21378@oksana.dev.rtsoft.ru>
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
To: avorontsov@ru.mvista.com
Cc: ppcdev <linuxppc-dev@ozlabs.org>, paulus@samba.org, kexec@lists.infradead.org

Anton Vorontsov wrote:
> On Tue, Sep 30, 2008 at 06:18:28PM +0530, Mohan Kumar M wrote:
>> Remove legacy kdump kernel build support
>>

Hi,

I have submitted the patch to support relocatable kdump kernel with 
retaining legacy kdump build support.

Regards,
Mohan.

> 
> Can we leave the legacy support for a while? On PPC32 we don't have
> the relocatable kernel support, but we have kdump patches floating
> around[1], and they use the `hard-coded values' approach, so far.
> 
> I'm not sure if anybody is currently working on a PPC32 kernel
> relocation support.. but for sure it will take some time to implement.
> 
> Thanks,
> 
> [1] http://ozlabs.org/pipermail/linuxppc-dev/2008-August/061161.html
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
