Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]
	helo=VA3EHSOBE010.bigfish.com)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1P3FCp-0005hW-Q9
	for kexec@lists.infradead.org; Tue, 05 Oct 2010 21:37:52 +0000
Subject: Re: [PATCH] kexec/ppc: Use -O0 instead of -Os for purgatory
MIME-Version: 1.0 (Apple Message framework v1081)
From: Matthew McClintock <msm@freescale.com>
In-Reply-To: <AANLkTikW216sA4nu1bwmjLG7RY3hHwMB7A6yvKgNoNZZ@mail.gmail.com>
Date: Tue, 5 Oct 2010 16:37:50 -0500
Message-ID: <655DCE1B-CFCF-403B-9E90-9A8A50F24372@freescale.com>
References: <1286306243-14236-1-git-send-email-msm@freescale.com>
	<AANLkTikW216sA4nu1bwmjLG7RY3hHwMB7A6yvKgNoNZZ@mail.gmail.com>
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
To: Maxim Uvarov <muvarov@gmail.com>
Cc: kexec@lists.infradead.org


On Oct 5, 2010, at 4:26 PM, Maxim Uvarov wrote:

> I'm ok with that changes. I'm not sure why kernel did not turn this
> optimization off and goes
> with compiling crt.s with sources. There could be a reasons for that.
> More likely to not put anything from
> libgcc to kernel. We should do the same for purgatory code. So maybe
> it's reasonable
> to apply my patch and go the same way as kernel goes (but it will
> break old compilers, that should not
> be huge problem.)
> 

Wait, do your recent patches have a similar effect?

-M



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
