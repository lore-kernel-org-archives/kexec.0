Return-path: <kexec-bounces@lists.infradead.org>
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Il6yh-0006cS-Vy
	for kexec@lists.infradead.org; Thu, 25 Oct 2007 18:58:46 +0100
Message-ID: <4720D933.3080703@ct.jp.nec.com>
Date: Thu, 25 Oct 2007 10:58:11 -0700
From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] x86: unify crash_32/64.c
References: <47195763.1090803@ct.jp.nec.com> <20071024063434.GC4622@in.ibm.com>
	<471F72AD.8030902@ct.jp.nec.com>
In-Reply-To: <471F72AD.8030902@ct.jp.nec.com>
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
To: vgoyal@in.ibm.com
Cc: hbabu@us.ibm.com, tglx@linutronix.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Hiroshi Shimamoto wrote:
> Vivek Goyal wrote:
>> On Fri, Oct 19, 2007 at 06:18:27PM -0700, Hiroshi Shimamoto wrote:
>>> Hi,
>>>
>>> I made patches to unify crash_32/64.c.
>>> There are three patches;
>>> 1. add lapic_shutdown for x86_64
>>> 2. add safe_smp_processor_id for x86_64
>>> 3. unify crash_32/64.c
>>>
>>> I'm not sure that it's good to split to these patches.
>>>
>>> I've compiled on both of 32bit and 64bit, and tested
>>> kdump on 64bit.
>>>
>> Hi Hiroshi,
>>
>> Thanks for the patches. Can you please also test it on 32bit to make
>> sure nothing is broken.
> 
> Okay, I'll test it on 32bit.
> A build problem already has been found on 32bit.
> 
I'm now testing crash on 32bit, but there is an issue before
applying the patches. My machine stopped at checking 'hlt'
after kexec, showing below message.

CPU: Intel(R) Xeon(TM) CPU 3.80GHz stepping 0a
Checking 'hlt' instruction...

v2.6.23.1 works fine for 1st kernel.
I'm investigating it..

Thanks
Hiroshi Shimamoto

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
