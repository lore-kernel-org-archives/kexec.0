Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx03.syneticon.net ([87.79.32.166])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K13iO-0002Nn-Gv
	for kexec@lists.infradead.org; Tue, 27 May 2008 18:16:05 +0000
Message-ID: <483C4F73.4040909@wpkg.org>
Date: Tue, 27 May 2008 20:14:11 +0200
From: Tomasz Chmielewski <mangoo@wpkg.org>
MIME-Version: 1.0
Subject: Re: kexec on mips - anyone has it working?
References: <483BCB75.4050901@wpkg.org>
	<200805271405.55346.nschichan@freebox.fr>
	<483C0135.9070203@wpkg.org>
	<200805271449.45124.nschichan@freebox.fr>
In-Reply-To: <200805271449.45124.nschichan@freebox.fr>
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
> On Tuesday 27 May 2008 14:40:21 you wrote:
>>> Could you try to add the following line in machine_kexec.c, just before
>>> jumping to the trampoline:
>>>
>>>        change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
>> And machine_kexec.c file is in where? It's not in the above one, it's
>> not in kexec-tools-testing-20080324?
> 
> 
> machine_kexec.c is in the kernel not in the kexec userland tools.

Aah, I see.

Anyway, it doesn't work - with or without this slight change in 
machine_kexec.c, with kexec compiled from the sources in the link you 
gave or with kexec-tools-testing-20080324, it just doesn't work on 
BCM43XX with OpenWRT patches. At least on Asus WL-500gP.


-- 
Tomasz Chmielewski
http://wpkg.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
