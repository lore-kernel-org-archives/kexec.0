Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JC9p9-0002aK-GP
	for kexec@lists.infradead.org; Tue, 08 Jan 2008 08:28:46 +0000
Date: Tue, 8 Jan 2008 09:28:16 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] i386: handle an initrd in highmem (version 2)
Message-ID: <20080108082816.GH31838@elte.hu>
References: <200801080502.m0852rhW017142@tazenda.hos.anvin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200801080502.m0852rhW017142@tazenda.hos.anvin.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dhaval Giani <dhaval@linux.vnet.ibm.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hbabu@us.ibm.com, Ingo Molnar <mingo@redhat.com>, Thomas Gleixer <tglx@linutronix.de>, vgoyal@redhat.com


* H. Peter Anvin <hpa@zytor.com> wrote:

> Fix crash on NUMA reported by Dhaval Giani (reported as being a kexec 
> issue.)

thanks, applied.

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
