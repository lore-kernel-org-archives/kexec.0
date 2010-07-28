Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OeEhx-00007w-1h
	for kexec@lists.infradead.org; Wed, 28 Jul 2010 22:02:38 +0000
Subject: Re: In place kexec
References: <4C50A7AD.8040902@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 28 Jul 2010 15:02:19 -0700
In-Reply-To: <4C50A7AD.8040902@zytor.com> (H. Peter Anvin's message of "Wed\,
	28 Jul 2010 14\:57\:01 -0700")
Message-ID: <m1y6cvtgd0.fsf@fess.ebiederm.org>
MIME-Version: 1.0
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

"H. Peter Anvin" <hpa@zytor.com> writes:

> We are getting a claim that the qla driver corrupts memory after a
> kexec, apparently due to a DMA engine left running in the before-kernel.
>
> For an in-place kexec (as opposed to a crash dump kexec, where we switch
> into dedicated memory), what shutdown paths get executed?

It is the normal reboot path, so the device shutdown method gets
executed.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
