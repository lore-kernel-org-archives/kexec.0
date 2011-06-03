Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2001:470:1f0b:1c35:abcd:42:0:1])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QSUoO-0005JV-Nc
	for kexec@lists.infradead.org; Fri, 03 Jun 2011 13:53:17 +0000
Message-ID: <4DE8E746.2080100@linutronix.de>
Date: Fri, 03 Jun 2011 15:53:10 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] Kexec support for PPC440x
References: <4DE345B0.8020505@in.ibm.com> <4DE50617.7090509@linutronix.de>
	<4DE72EFE.8080502@in.ibm.com> <4DE8CA76.2060303@in.ibm.com>
In-Reply-To: <4DE8CA76.2060303@in.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Suzuki Poulose <suzuki@in.ibm.com>
Cc: linux ppc dev <linuxppc-dev@lists.ozlabs.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>

Suzuki Poulose wrote:
>>> The way you setup the 1:1 mapping should be close to what you are 
>>> doing on
>>> kernel entry.Isn't it possible to include the file here and in the entry
>>> code?
> 
>> I will make this change and resend the patch.
> 
> I took a look at the way we do it at kernel entry. It looks more cleaner 
> to leave
> it untouched. Especially, when we add the support for 47x in the future, 
> the code
>  will become more unreadable.
> 
> What do you think ?

So the entry code has one 256MiB mapping, you need 8 of those. Entry goes 
for TLB 63 and you need to be flexible and avoid TLB 63 :).
So after all you don't have that much in common with the entry code. If
you look at the FSL-book code then you will notice that I tried to share
some code.

I don't understand why you don't flip the address space bit. On fsl we
setup the tmp mapping in the "other address" space so we don't have two
mappings for the same address. The entry code could be doing this with STS
bit, I'm not sure.

If you want to keep your tiny mmu flip code instead of merging with the
entry code then please don't put it into a separate file. The only reason
why I did it, is to have the code once since I can't branch to it and I
wanted to share code.

> 
> Thanks
> 
> Suzuki

Sebastian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
