Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from bobafett.staff.proxad.net ([213.228.1.121])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K22lX-0002Ez-Uh
	for kexec@lists.infradead.org; Fri, 30 May 2008 11:27:24 +0000
From: Nicolas Schichan <nschichan@freebox.fr>
Subject: Re: kexec on mips - anyone has it working?
Date: Fri, 30 May 2008 13:27:11 +0200
References: <483BCB75.4050901@wpkg.org>
	<200805291347.05196.nschichan@freebox.fr>
	<483F0EF3.3060500@wpkg.org>
In-Reply-To: <483F0EF3.3060500@wpkg.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200805301327.11925.nschichan@freebox.fr>
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
Cc: linux-mips@linux-mips.org, openwrt-devel@lists.openwrt.org, Kexec Mailing List <kexec@lists.infradead.org>

On Thursday 29 May 2008 22:15:47 Tomasz Chmielewski wrote:
> # kexec -e
> b44: eth0: powering down PHY
> Starting new kernel
> Will call new kernel at 00305000

The calling address of the kernel looks quite wrong, it should clearly
be inside the KSEG0 zone. could  you please indicate the output of the
command "mips-linux-readelf -l vmlinux" ?

Regards,

-- 
Nicolas Schichan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
