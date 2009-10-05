Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MubLt-0003W5-90
	for kexec@lists.infradead.org; Mon, 05 Oct 2009 00:23:02 +0000
Message-ID: <4AC9384A.50604@mxs.nes.nec.co.jp>
Date: Mon, 05 Oct 2009 09:05:30 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: Can't exclude unnecessary pages for 2.6.31 Kernel
References: <394279530.1283331254493445641.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <394279530.1283331254493445641.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
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
To: Dave Anderson <anderson@redhat.com>
Cc: nhorman@redhat.com, tachibana@mxm.nes.nec.co.jp, kexec@lists.infradead.org, CAI Qian <caiqian@redhat.com>


Dave Anderson wrote:
> ----- "Dave Anderson" <anderson@redhat.com> wrote:
> 
>> ----- "CAI Qian" <caiqian@redhat.com> wrote:
>>
>>> From: CAI Qian <caiqian@redhat.com>
>>> Subject: Re: Can't exclude unnecessary pages for 2.6.31 Kernel
>>> Date: Fri, 02 Oct 2009 19:26:44 +0800 (CST)
>>>
>>>> Cced the crash utility maintainer.
>>>>
>>>> BZ filed -- https://bugzilla.redhat.com/show_bug.cgi?id=526749
>>>>
>>>>> It does make -d 16 works without errors. However, the crash utility
>>>>> failed to read it (the log attached), but the full VMCore is working
>>>>> fine there.
>>>>>
>>>>> crash: page excluded: kernel virtual address: ffffffff819f1764 type: "tss_struct ist array"
>> I believe that the "tss_struct" issue is a crash bug if in fact it works
>> OK with a full vmcore.  I'll look at the vmlinux/vmcores from the BZ.
> 
> Definitely a crash utility bug -- I'll fix it in the next upstream release.

good job :-)


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
