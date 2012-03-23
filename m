Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SB0un-0005ZJ-BI
 for kexec@lists.infradead.org; Fri, 23 Mar 2012 09:36:13 +0000
Received: from 99.77.194.77.rev.sfr.net ([77.194.77.99] helo=[16.1.1.20])
 by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <louis.bouchard@canonical.com>)
 id 1SB0ui-0005Aw-3R
 for kexec@lists.infradead.org; Fri, 23 Mar 2012 09:36:07 +0000
Message-ID: <4F6C43EA.5010405@canonical.com>
Date: Fri, 23 Mar 2012 10:35:38 +0100
From: Bouchard Louis <louis.bouchard@canonical.com>
MIME-Version: 1.0
Subject: Re: Doing kexec reboot right in systemd
References: <CABRT9RAB--szWwmYO9_JyjXRP-9YYgkG-TsAg8jS=birUF2e=w@mail.gmail.com>
In-Reply-To: <CABRT9RAB--szWwmYO9_JyjXRP-9YYgkG-TsAg8jS=birUF2e=w@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello,

Le 22/03/2012 20:14, Marti Raudsepp a =E9crit :
> Hi list,
> =

> I was recently pondering how systemd could use kexec "properly", in a
> reasonably general way, to make reboots faster. I exchanged an email
> with Poettering on the systemd list and he suggested me to ask here.
> =


While not done by systemd, isn't is what is done on Debian when
kexec-tools is installed ?

It provides a 'coldreboot' script that does the following :


 #!/bin/sh
 NOKEXECFILE=3D/tmp/no-kexec-reboot

 /bin/rm -f $NOKEXECFILE
 touch $NOKEXECFILE
 /sbin/reboot $*

FWIR, using reboot will quickly kexec into a new kernel.

Kind regards,

...Louis
-- =

Louis Bouchard
Backline Support Analyst
Canonical Ltd
Ubuntu support: http://landscape.canonical.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
