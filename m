Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 25 Jun 2010 16:05:44 +0900 (JST)
Message-Id: <20100625.160544.125902258.igawa@mxs.nes.nec.co.jp>
Subject: Re: [PATCH 3/3] add ARM crashdump support
From: Masayuki Igawa <igawa@mxs.nes.nec.co.jp>
In-Reply-To: <20100625.083133.77342472.igawa@mxs.nes.nec.co.jp>
References: <20100624163356.dbb849bc.igawa@mxs.nes.nec.co.jp>
	<20100624081915.GF29920@esdhcp04058.research.nokia.com>
	<20100625.083133.77342472.igawa@mxs.nes.nec.co.jp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ext-mika.1.westerberg@nokia.com
Cc: oomichi@mxs.nes.nec.co.jp, tachibana@mxm.nes.nec.co.jp, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi,

From: Masayuki Igawa <igawa@mxs.nes.nec.co.jp>
Subject: Re: [PATCH 3/3] add ARM crashdump support
Date: Fri, 25 Jun 2010 08:31:33 +0900 (JST)
> From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> Date: Thu, 24 Jun 2010 11:19:15 +0300
>> On Thu, Jun 24, 2010 at 09:33:56AM +0200, ext Masayuki Igawa wrote:
>>> Hi, Mika.
>> 
>> (...)
> 
>>> How about is this?
>>> ====
>>> +unsigned long long
>>> +vaddr_to_paddr_arm(unsigned long vaddr)
>>> +{
>>> +	unsigned long long paddr = vaddr_to_paddr_general(vaddr);
>>> +
>>> +	if (paddr != NOT_PADDR)
>>> +		return paddr;
>>> ====
>> 
>> Yeah, looks OK to me.
>> 
>> Do you want me to send a revisited version of the patches or do you change that
>> yourself?
> 
> I'll change that myself.
> 
>> 
>>> BTW, I'm testing these patches for x86/x86_64 arch now.
>>> I'll merge these patches after my testing.
>> 
>> Cool, thanks.

I've finished my tests(x86/x86_64). No problems were found.
So I've merged and pushed these patches.

Thanks,
-- Masayuki Igawa


>> 
>>> But I cannot test for ARM because have no test machines of ARM.
>> 
>> Well I can do the testing for ARM (unless someone else, who is using ARM kdump
>> currently, wants to test this). If the above is the only change it should still
>> work.
> 
> OK. I'll merge and push these patches (including this change).
> And I'd like you to do the testing for ARM after that.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
