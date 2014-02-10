Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WCo1o-0006Qm-Ss
 for kexec@lists.infradead.org; Mon, 10 Feb 2014 10:23:53 +0000
Received: from 40.77.194.77.rev.sfr.net ([77.194.77.40] helo=[192.168.1.80])
 by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <louis.bouchard@ubuntu.com>)
 id 1WCo1S-0006IX-Cg
 for kexec@lists.infradead.org; Mon, 10 Feb 2014 10:23:30 +0000
Message-ID: <52F8A896.1050205@ubuntu.com>
Date: Mon, 10 Feb 2014 11:23:18 +0100
From: Louis Bouchard <louis.bouchard@ubuntu.com>
MIME-Version: 1.0
Subject: Reserved memory estimation for crashkernel=
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

I would be interested to know if there is a semi-accurate way to evaluate the
amount of memory that needs to be reserved and passed to the crashkernel=
parameter ?

I understand that it is very specific to the environment (system configuration,
kernel options, etc) but if we could at least know how much memory will be
required by makedumpfile it would be a good start.

Maybe we can imagine an enhancement to makedumpfile to have it evaluate a value
that could provide some kind of estimate.

TIA,

Kind regards,

...Louis
-- 
Louis Bouchard
Software engineer,
Ubuntu

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
