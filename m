Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirk.serum.com.pl ([213.77.9.205] helo=serum.com.pl)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K1tbz-0007BI-6J
	for kexec@lists.infradead.org; Fri, 30 May 2008 01:40:55 +0000
Date: Fri, 30 May 2008 02:40:27 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: kexec on mips - anyone has it working?
In-Reply-To: <483F0EF3.3060500@wpkg.org>
Message-ID: <Pine.LNX.4.55.0805300233450.8254@cliff.in.clinika.pl>
References: <483BCB75.4050901@wpkg.org>
	<200805271449.45124.nschichan@freebox.fr>
	<483C4F73.4040909@wpkg.org> <200805291347.05196.nschichan@freebox.fr>
	<483F0EF3.3060500@wpkg.org>
MIME-Version: 1.0
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
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: linux-mips@linux-mips.org, openwrt-devel@lists.openwrt.org, Kexec Mailing List <kexec@lists.infradead.org>, Nicolas Schichan <nschichan@freebox.fr>

On Thu, 29 May 2008, Tomasz Chmielewski wrote:

> I guess I'm not that lucky. Either CONFIG_MIPS_UNCACHED slowed the 
> device down so much that it didn't boot, or it didn't boot. Hey, isn't 
> it the same? So either BCM43XX doesn't work very well with certain 
> kernel options enabled/disabled, or OpenWRT patches still lack some 
> features to make ASUS WL-500gP properly (added openwrt-devel to CC:).

 LL/SC are undefined on uncached memory.  Implementers are free to keep
the instructions working the same way as on cached memory, but are not
required to do so and your chip may be an example.  Of course the reason
of the hang you see may be different, but this is one plausible
explanation.  I wouldn't trust a kernel running with CONFIG_MIPS_UNCACHED
enabled -- it is merely a debugging hack.

  Maciej

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
