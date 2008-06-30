Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KD8Gd-0006Gy-JR
	for kexec@lists.infradead.org; Mon, 30 Jun 2008 01:33:20 +0000
Message-Id: <486837DB.8020405@mxs.nes.nec.co.jp>
Date: Mon, 30 Jun 2008 10:33:15 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] Fix vmcoreinfo generation on 32bit hosts for 64bit kernels
References: <20080626124731.GA24365@suse.de>	<48645B6C.1070608@mxs.nes.nec.co.jp>
	<20080627131701.5ab66b5a@halley.suse.de>
In-Reply-To: <20080627131701.5ab66b5a@halley.suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0154251672=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec-ml <kexec@lists.infradead.org>

--===============0154251672==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Bernhard Walle wrote:
>>> This bug fixes the generation of vmcoreinfo files on 32bit hosts for ELF64
>>> files, i.e. 64bit kernels. The concrete problem was PPC64 which is built in a
>>> 32bit environment at SUSE.
>> I have one question.
>> I guess that the fundamental problem is that makedumpfile cannot
>> use vmcoreinfo which is contained in /proc/vmcore on ppc64, right ?
>> If yes, could you please test my attached patch for fixing it.
>>
>> I created the kernel patch for adding the symbol "node_data" to
>> ppc64's vmcoreinfo, but I cannot tested it because I don't have
>> any ppc64 machine.
> 
> No, not directly. We still ship the makedumpfile.config. Yes, we plan
> to switch to /proc/vmcore vmcoreinfo for next release (SLES 11).
> 
> I'll test your patch on PPC and give feedback!

Sounds good to me :-)


> But I think the patch is also valid since makedumpfile.config file is
> still supported and should work.

OK.
I think that your patch is good, and I will merge it to the next
release anyway.


Thanks
Ken'ichi Ohmichi


--===============0154251672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0154251672==--
