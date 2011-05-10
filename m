Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mga03.intel.com ([143.182.124.21])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QJbk4-0006mX-7O
	for kexec@lists.infradead.org; Tue, 10 May 2011 01:28:05 +0000
Message-ID: <4DC894A0.5080303@intel.com>
Date: Tue, 10 May 2011 09:28:00 +0800
From: Huang Ying <ying.huang@intel.com>
MIME-Version: 1.0
Subject: Re: [Bug] Kdump does not work when panic triggered due to MCE
References: <20110506165412.GB2719@in.ibm.com>
	<20110506173825.GK11636@one.firstfloor.org>
	<20110509163540.GA1963@in.ibm.com>
In-Reply-To: <20110509163540.GA1963@in.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "prasad@linux.vnet.ibm.com" <prasad@linux.vnet.ibm.com>
Cc: Andi Kleen <andi@firstfloor.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>, "Luck, Tony" <tony.luck@intel.com>

Hi, Prasad,

On 05/10/2011 12:35 AM, K.Prasad wrote:
> On Fri, May 06, 2011 at 07:38:25PM +0200, Andi Kleen wrote:
>>> Has anybody tested this before? Or have found kdump working when fatal
>>> MCEs have actually occurred?
>>
>> Ying did some testing. mce-test has test cases for kdump.
>>
> 
> We'd be glad to hear about any successful testcases with recent kernels.
> My manual testing was quite similar to what the LTP kdump testcase would
> do i.e. configure kdump service, trigger crash through
> /proc/sysrq-trigger and watchout for kdump....but as you could see in
> the logs, that did not happen.
> 
>> My guess is you injected the error into some area used by the kexec
>> code or boot up path of the kexec kernel.
>>
>> -Andi
> 
> The logs did not suggest that the second kernel was booted into. The
> "Rebooting in ... seconds" message appeared from the first kernel. I
> tried the kdump testcase in atleast two dissimilar machines but with
> the same results, so it is not clear if the kexec code was affected by
> the MCE injection in both the cases.

From your panic logs, it seems that panic is triggered for MCE on one
CPU,  when crash_kexec is executing, another panic is triggered on
another CPU for timeout mechanism in MCE.  We have seen something like
that in mce-test developing.  Please try following command line for mce
injecting.

mce-inject --no-random
/home/prasadkr/mce/mce-test/cases/soft-inj/panic_ucr/data/srar_over

Which is used by kdump test driver of mce-test too.

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
