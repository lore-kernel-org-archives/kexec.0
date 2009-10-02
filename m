Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1Mtcgx-0001Be-Um
	for kexec@lists.infradead.org; Fri, 02 Oct 2009 07:36:45 +0000
Message-ID: <4AC5AC1D.7010907@mxs.nes.nec.co.jp>
Date: Fri, 02 Oct 2009 16:30:37 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: Can't exclude unnecessary pages for 2.6.31 Kernel
References: <4AC54672.7080201@mxs.nes.nec.co.jp>	<20091002.122142.187435277.caiqian@redhat.com>	<4AC5A28D.9040600@mxs.nes.nec.co.jp>
	<20091002.151145.185394253.caiqian@redhat.com>
In-Reply-To: <20091002.151145.185394253.caiqian@redhat.com>
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
To: CAI Qian <caiqian@redhat.com>
Cc: nhorman@redhat.com, kexec@lists.infradead.org, tachibana@mxm.nes.nec.co.jp


Hi CAI,

CAI Qian wrote:
>>>> I created the patch for catching this change.
>>>> Could you try the attached patch ?
>>>>
>>> It does make -d 16 works without errors. However, the crash utility
>>> failed to read it (the log attached), but the full VMCore is working
>>> fine there.
>>>
>>> crash: page excluded: kernel virtual address: ffffffff819f1764 type:
>>>        "tss_struct ist array"
>> I can not reproduce the above problem, and I want to reproduce this
>> problem on my machine for investigating it.
>>
>> Could you send your kernel .config file ?
> 
> Sure. Attached.

Thank you.
I'm making a linux-2.6.31 kernel by your .config file.


> Not sure if this the crash utility problem or not, FYI
> it was reproduced using the latest upstream version.

Is "the latest upstream version" 2.6.32-rc1 ?


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
