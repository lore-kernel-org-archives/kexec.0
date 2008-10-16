Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KqQAV-0000PX-B0
	for kexec@lists.infradead.org; Thu, 16 Oct 2008 10:33:23 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9GAXJHA016304
	for <kexec@lists.infradead.org>; Thu, 16 Oct 2008 06:33:19 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9GAXJOp288386
	for <kexec@lists.infradead.org>; Thu, 16 Oct 2008 06:33:19 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9GAXJ3q028459
	for <kexec@lists.infradead.org>; Thu, 16 Oct 2008 06:33:19 -0400
Message-ID: <48F71868.8000507@in.ibm.com>
Date: Thu, 16 Oct 2008 16:03:12 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Support for relocatable kdump kernel
References: <20081012233420.GA6240@in.ibm.com>
	<18674.42140.69339.584403@drongo.ozlabs.ibm.com>
In-Reply-To: <18674.42140.69339.584403@drongo.ozlabs.ibm.com>
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
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org

Paul Mackerras wrote:
> Mohan Kumar M writes:
> 
>> Support for relocatable kdump kernel
> 
>> @@ -1401,9 +1414,21 @@ _STATIC(__after_prom_start)
>>  	beq	9f			/* have already put us at zero */
>>  	li	r6,0x100		/* Start offset, the first 0x100 */
>>  					/* bytes were copied earlier.	 */
>> -#ifdef CONFIG_RELOCATABLE
>> +
>> +#ifdef CONFIG_CRASH_DUMP
> 
> What tree is this patch against?  No tree that I can find has a line
> saying "#ifdef CONFIG_RELOCATABLE" at that point.  Or is there a
> prerequisite patch that I haven't seen yet?

Hi Paul,

My patch is based on your PATCH 5 of relocatable kernel patchset (which 
demonstrates kernel can be relocatable).

Do I need to resend the patch by generating the diff with your patch5 also?

Regards,
Mohan.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
