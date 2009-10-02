Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MtdWL-0001rT-7s
	for kexec@lists.infradead.org; Fri, 02 Oct 2009 08:29:50 +0000
Date: Fri, 02 Oct 2009 16:29:38 +0800 (CST)
Message-Id: <20091002.162938.206593281.caiqian@redhat.com>
Subject: Re: Can't exclude unnecessary pages for 2.6.31 Kernel
From: CAI Qian <caiqian@redhat.com>
In-Reply-To: <4AC5AC1D.7010907@mxs.nes.nec.co.jp>
References: <4AC5A28D.9040600@mxs.nes.nec.co.jp>
	<20091002.151145.185394253.caiqian@redhat.com>
	<4AC5AC1D.7010907@mxs.nes.nec.co.jp>
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
To: oomichi@mxs.nes.nec.co.jp
Cc: nhorman@redhat.com, kexec@lists.infradead.org, tachibana@mxm.nes.nec.co.jp, caiqian@redhat.com

From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: Can't exclude unnecessary pages for 2.6.31 Kernel
Date: Fri, 02 Oct 2009 16:30:37 +0900

> 
> Hi CAI,
> 
> CAI Qian wrote:
>>>>> I created the patch for catching this change.
>>>>> Could you try the attached patch ?
>>>>>
>>>> It does make -d 16 works without errors. However, the crash utility
>>>> failed to read it (the log attached), but the full VMCore is working
>>>> fine there.
>>>>
>>>> crash: page excluded: kernel virtual address: ffffffff819f1764 type:
>>>>        "tss_struct ist array"
>>> I can not reproduce the above problem, and I want to reproduce this
>>> problem on my machine for investigating it.
>>>
>>> Could you send your kernel .config file ?
>> 
>> Sure. Attached.
> 
> Thank you.
> I'm making a linux-2.6.31 kernel by your .config file.
> 
> 
>> Not sure if this the crash utility problem or not, FYI
>> it was reproduced using the latest upstream version.
> 
> Is "the latest upstream version" 2.6.32-rc1 ?

Sorry, I have not made my self clearly. I mean the latest upstream
version of the crash utility.

http://people.redhat.com/anderson/

The kernel is 2.6.31.

Thanks!
CAI Qian

> 
> 
> Thanks
> Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
