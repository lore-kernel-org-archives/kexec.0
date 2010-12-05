Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtprelay04.ispgateway.de ([80.67.31.42])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PPLZP-0007xV-8D
	for kexec@lists.infradead.org; Sun, 05 Dec 2010 20:52:31 +0000
Received: from [212.114.235.33] (helo=galilei.fritz.box)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68) (envelope-from <bernhard@bwalle.de>) id 1PPLZL-0003sp-S1
	for kexec@lists.infradead.org; Sun, 05 Dec 2010 21:52:27 +0100
Message-ID: <4CFBFB8B.2060902@bwalle.de>
Date: Sun, 05 Dec 2010 21:52:27 +0100
From: Bernhard Walle <bernhard@bwalle.de>
MIME-Version: 1.0
Subject: Re: kdump_post : busybox returns "Applet not found"
References: <4CF91748.5000401@hp.com>
	<20101205201938.GA2265@localhost.localdomain>
In-Reply-To: <20101205201938.GA2265@localhost.localdomain>
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
To: kexec@lists.infradead.org

Am 05.12.10 21:19, schrieb Neil Horman:
> I'm kind of suprised this is working at all.  I don't see a #!/bin/sh or
> #!/bin/msh line at the top of the script.  How does the system know what
> interpreter to use?

/bin/sh is the default interpreter.


Regards,
Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
