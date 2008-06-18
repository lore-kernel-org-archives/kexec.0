Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K8uIK-0000eY-2I
	for kexec@lists.infradead.org; Wed, 18 Jun 2008 09:49:37 +0000
Date: Wed, 18 Jun 2008 11:49:17 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] [PATCH] Use BOOTMEM_EXCLUSIVE for i386
Message-ID: <20080618094917.GA15255@elte.hu>
References: <20080608141607.GA25743@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080608141607.GA25743@suse.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, anderson@redhat.com, hpa@zytor.com, tglx@linutronix.de, vgoyal@redhat.com
Cc: the arch/x86 maintainers <x86@kernel.org>, Yinghai Lu <yhlu.kernel@gmail.com>


* Bernhard Walle <bwalle@suse.de> wrote:

> This patch uses the BOOTMEM_EXCLUSIVE for crashkernel reservation also 
> for i386 and prints a error message on failure.
> 
> The patch is still for 2.6.26 since it is only bug fixing. The 
> unification of reserve_crashkernel() between i386 and x86_64 should be 
> done for 2.6.27.

applied to tip/x86/urgent, thanks Bernhard.

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
