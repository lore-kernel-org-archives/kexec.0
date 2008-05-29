Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx03.syneticon.net ([87.79.32.166])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K1h3v-0004Et-0T
	for kexec@lists.infradead.org; Thu, 29 May 2008 12:16:55 +0000
Message-ID: <483E9E97.6050207@wpkg.org>
Date: Thu, 29 May 2008 14:16:23 +0200
From: Tomasz Chmielewski <mangoo@wpkg.org>
MIME-Version: 1.0
Subject: Re: kexec on mips - anyone has it working?
References: <483BCB75.4050901@wpkg.org>
	<200805271449.45124.nschichan@freebox.fr>
	<483C4F73.4040909@wpkg.org>
	<200805291347.05196.nschichan@freebox.fr>
In-Reply-To: <200805291347.05196.nschichan@freebox.fr>
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
> On Tuesday 27 May 2008 20:14:11 you wrote:
>> Aah, I see.
>>
>> Anyway, it doesn't work - with or without this slight change in
>> machine_kexec.c, with kexec compiled from the sources in the link you
>> gave or with kexec-tools-testing-20080324, it just doesn't work on
>> BCM43XX with OpenWRT patches. At least on Asus WL-500gP.
> 
> I'm not familiar with broadcom CPU names, but isn't BCM43XX supposed
> to be a Wifi chipset ? :)

Well, yeah, indeed the device is sold as a wireless router. But it can 
perfectly run Debian, so it should run kexec as well, shouldn't it? ;)


> However,  could   you  kexec   a  kernel  from   a  kernel   that  has
> CONFIG_MIPS_UNCACHED  set (under  "Kernel  hacking", "run  uncached")?
> this will slow down the kernel that does the kexec, but if this works,
> then it is most probably a cache problem.
> 
> Could you also indicate the last lines of kernel messages just before
> the "Bye." ?

I'll try that later today and will post the results.


> Are you trying to kexec a big kernel image ?

Hmm, is it big? It's the same kernel I booted:

# ls -l vmlinux
-rwxr-xr-x 1 root root 3868065 May 26 23:30 vmlinux


> how much RAM do you have
> on the board ?

It has 32 MB RAM; some ~11 MB is used before I load another kernel.


> are there some hardware that could have a hard time to
> be re-probed by the kexeced linux kernel ?

The kexeced kernel is the same one I booted, so no.


-- 
Tomasz Chmielewski
http://wpkg.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
