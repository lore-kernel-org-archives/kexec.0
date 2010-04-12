Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fallback-out1.mxes.net ([216.86.168.180]
	helo=fallback-in1.mxes.net)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O1L7H-0007wn-B4
	for kexec@lists.infradead.org; Mon, 12 Apr 2010 15:00:02 +0000
Received: from mxout-08.mxes.net (mxout-08.mxes.net [216.86.168.183])
	by fallback-in1.mxes.net (Postfix) with ESMTP id 7407986493
	for <kexec@lists.infradead.org>; Mon, 12 Apr 2010 10:53:16 -0400 (EDT)
Received: from [192.168.0.52] (unknown [71.112.172.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTPSA id 28B85509DE
	for <kexec@lists.infradead.org>; Mon, 12 Apr 2010 10:52:10 -0400 (EDT)
Message-ID: <4BC3339C.9040903@anabaptists.org>
Date: Mon, 12 Apr 2010 07:52:12 -0700
From: Brian Smucker <bsmucker@anabaptists.org>
MIME-Version: 1.0
Subject: Re: Kexec for ARM: Is it expected to load old kernels?
References: <4BBFC9F5.3070105@anabaptists.org>
	<n2id1b08f941004120500o43859311x8331038ceb84d1b7@mail.gmail.com>
In-Reply-To: <n2id1b08f941004120500o43859311x8331038ceb84d1b7@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi

So it appears I cannot load pre-2.6.24 kernels ARM kernels.  I have some 
further questions.

Is this an ARM-only thing?

If I want to load an arbitrary kernel, am I out of luck?

I thought theoretically kexec was able to execute arbitrary elf 
binaries, non-kernals, etc.  Is this true, or only my own misconception?

Or is it true in general, but not for ARM?

If it is not true for ARM, can I fix it?

I would like kexec to be able to boot old,old kernels, of the 2.4.16 
vintage.

Can you help answer these questions?

Thanks,

Brian



Andrea Adami wrote:
> Brian,
>
> I suppose you need the ATAG changes introduced in 2.6.24 in order to
> boot an arm kernel from kexec.
> There are around patches for 2.6.22 and 2.6.23
> (http://docs.openmoko.org/trac/ticket/930).
>
> See amongst others:
>
> [ARM] 4599/1: Preserve ATAG list for use with kexec (2.6.23)
> [ARM] 4836/1: Make ATAGS_PROC depend on KEXEC
>
>
> Regards
>
> Andrea
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>   


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
