Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bTGkL-0006c2-V6
 for kexec@lists.infradead.org; Fri, 29 Jul 2016 22:59:14 +0000
Subject: Re: [PATCH] arm64:kexec: Memstart should not be before the kernel
 start address
References: <1461708860-23034-1-git-send-email-sgoel@codeaurora.org>
 <1461715120.27026.4.camel@infradead.org>
 <3624bf19-6569-b631-92f9-cc9fc91b40cd@codeaurora.org>
 <1465576876.3105.54.camel@infradead.org>
From: "Goel, Sameer" <sgoel@codeaurora.org>
Message-ID: <569f36b7-e153-742f-b7fe-c3a1d7b1febc@codeaurora.org>
Date: Fri, 29 Jul 2016 16:58:50 -0600
MIME-Version: 1.0
In-Reply-To: <1465576876.3105.54.camel@infradead.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoff@infradead.org>, kexec@lists.infradead.org
Cc: timur@codeaurora.org, rruigrok@codeaurora.org, shankerd@codeaurora.org

Hi Geoff,
In our setup we cannot place the kernel starting at 0 address. So, it it 
placed at the first valid aligned address after placing the reserved 
regions in memory.

The code from the change (https://patchwork.kernel.org/patch/8325221/) 
adds the reserved regions to iomem ranges. So, when the kexec tool is 
run it picks up the first reserved region as the start address for 
physical ram. When the kernel is loaded at this address, it fails to boot.

So, I have put in a filter in the code that would pick up the right 
address of the primary kernel after this change was introduced.
Thanks,
Sameer

On 6/10/2016 10:41 AM, Geoff Levand wrote:
> Hi Sameer,
>
>>>> On Tue, 2016-04-26 at 16:14 -0600, Sameer Goel wrote:
>>>>> Starting 4.6-rc4 the kernel memblock start is rounded down to a desirable
>>>>> alignment. So, the kernel can see reserved memory regions before the kernel
>>>>> start address in the iomem query.
>>>>> Need to make sure that the right kernel start address is picked from the iomem
>>>>> query.
>>>>> ---
>
> It is still in question whether or not your's is the correct
> fix.  Could you provide a test case that hits this problem
> so we can work on the solution?
>
> Thanks.
>
> -Geoff
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
