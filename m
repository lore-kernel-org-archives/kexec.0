Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx03.syneticon.net ([87.79.32.166])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K0yVD-0000Wo-Jh
	for kexec@lists.infradead.org; Tue, 27 May 2008 12:42:14 +0000
Message-ID: <483C0135.9070203@wpkg.org>
Date: Tue, 27 May 2008 14:40:21 +0200
From: Tomasz Chmielewski <mangoo@wpkg.org>
MIME-Version: 1.0
Subject: Re: kexec on mips - anyone has it working?
References: <483BCB75.4050901@wpkg.org>
	<200805271405.55346.nschichan@freebox.fr>
In-Reply-To: <200805271405.55346.nschichan@freebox.fr>
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
To: Nicolas Schichan <nschichan@freebox.fr>
Cc: linux-mips@linux-mips.org, Kexec Mailing List <kexec@lists.infradead.org>

Nicolas Schichan schrieb:

>>  Ideas? Ways to debug it?
> 
> I am using a 2.6.20 kernel on a 32bit mips platform and it is working 
> fine. however I am using this userland code (make CROSS=$(your 
> cross-compiler prefix) to compile it) :
> 
> http://chac.le-poulpe.net/~nico/kexec.tar.gz
> 
> Could you try to add the following line in machine_kexec.c, just before 
> jumping to the trampoline:
> 
>        change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);

And machine_kexec.c file is in where? It's not in the above one, it's 
not in kexec-tools-testing-20080324?


-- 
Tomasz Chmielewski
http://wpkg.org


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
