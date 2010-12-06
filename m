Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PPYmo-0003Bl-6y
	for kexec@lists.infradead.org; Mon, 06 Dec 2010 10:59:15 +0000
Received: from g4t0009.houston.hp.com (g4t0009.houston.hp.com [16.234.32.26])
	by g4t0015.houston.hp.com (Postfix) with ESMTP id 76B9787F3
	for <kexec@lists.infradead.org>; Mon,  6 Dec 2010 10:59:09 +0000 (UTC)
Received: from [16.17.61.61] (bouchardlnx.emea.hpqcorp.net [16.17.61.61])
	by g4t0009.houston.hp.com (Postfix) with ESMTP id 3B4BEC104
	for <kexec@lists.infradead.org>; Mon,  6 Dec 2010 10:59:09 +0000 (UTC)
Message-ID: <4CFCC1FC.2020409@hp.com>
Date: Mon, 06 Dec 2010 11:59:08 +0100
From: Louis Bouchard <louis.bouchard@hp.com>
MIME-Version: 1.0
Subject: Re: kdump_post : busybox returns "Applet not found"
References: <4CF91748.5000401@hp.com>	<20101205201938.GA2265@localhost.localdomain>
	<4CFBFB8B.2060902@bwalle.de>
In-Reply-To: <4CFBFB8B.2060902@bwalle.de>
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

Hello,

On 05/12/2010 21:52, Bernhard Walle wrote:
> Am 05.12.10 21:19, schrieb Neil Horman:
>> I'm kind of suprised this is working at all.  I don't see a #!/bin/sh or
>> #!/bin/msh line at the top of the script.  How does the system know what
>> interpreter to use?
> 
> /bin/sh is the default interpreter.
> 
> 
> Regards,
> Bernhard
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

While, as Bernhard said, /bin/sh is default so the test script does
work, the crashdc scripts that I'm testing do have the #!/bin/sh at the
beginning, with identical behavior.

Kind regards,

..Louis

-- 
Louis Bouchard
Linux Support Engineer
Team lead, EMEA Linux Competency Center,
Linux Advocate, HP

HP Technology Services - Global Competency Center
Hewlett-Packard Company

louis.bouchard@hp.com     / Email
Mon-Fri 9-17<WET>,<GMT+2> / Working Hours
Mark Fay                  / Manager
mark.fay@hp.com           / Manager's Email

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
