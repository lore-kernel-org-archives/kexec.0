Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58] helo=smtp.tuxdriver.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1Ld1Mp-0006Oq-Is
	for kexec@lists.infradead.org; Fri, 27 Feb 2009 11:59:02 +0000
Date: Fri, 27 Feb 2009 06:58:46 -0500
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: Kexec failled with igb-1.2.45-K2 network driver
Message-ID: <20090227115846.GA17429@hmsreliant.think-freely.org>
References: <49A7A613.7060009@bull.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <49A7A613.7060009@bull.net>
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
To: Thierry Iceta <Thierry.Iceta@bull.net>
Cc: kexec@lists.infradead.org

On Fri, Feb 27, 2009 at 09:36:35AM +0100, Thierry Iceta wrote:
> Hi
> 
> Using kexec as indicated hereunder I am enable to use ethernet network 
> directly after kexec boot
> due to I suppose last igb driver "igb-1.2.45-K2"
> Only solution found is to rmmod igb  and just after modprobe igb
> 
> Coul you tell me the kexec version that take into account the driver 
> igb-1.2.45-K2?
> May be an other solution is to tell kexec to load this modules ? but how ?
> 
> any help will be appreciated
> Thanks in advance
> Thierry
> HW=X86_64
> SW=redhat (kernel 2.6.18-122)
> kexec used par Rhel5 ==>kexec-tools-1.102pre-56.el5 ==>KO
> kerxec tested ==>kexec-tools-2.0.0-7.fc11.x86_64.rpm ==>KO
> 
> kexec_append="root=LABEL=/ ro  ro root=LABEL=/    console=tty0 
> console=ttyS1,115200"
> export $kexec_append
> kexec --force --append="$kexec_append" 
> --initrd=/a/boot/initrd-2.6.18-122.el5.img --args-linux 
> /a/boot/vmlinuz-2.6.18-122.el5
> 

Sounds like something has gone bad in the driver in resetting the NIC.  If you
open a bug at bugzilla.redhat.com, I'll pick it up and look at it.
Neil

> -- 
>   __________________________________________________________________        
>                   Bull, Architect of an Open World TM
>                     	 Open Software R&D
> 
>         Email   :Thierry.Iceta@bull.net
>         Bull SA                Bullcom :229 76 29
>         1, rue de Provence     Phone   :+33 04 76 29 76 29
>         B.P. 208               http://www.bull.com                          
>         38432 Echirolles-CEDEX Office  :FREC B1-361 
>   __________________________________________________________________        
> 
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
