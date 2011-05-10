Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from adelie.canonical.com ([91.189.90.139])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QJhPZ-00083o-32
	for kexec@lists.infradead.org; Tue, 10 May 2011 07:31:18 +0000
Message-ID: <4DC8E9C2.3030801@canonical.com>
Date: Tue, 10 May 2011 09:31:14 +0200
From: Bouchard Louis <louis.bouchard@canonical.com>
MIME-Version: 1.0
Subject: Re: [Bug] Kdump does not work when panic triggered due to MCE
References: <20110506165412.GB2719@in.ibm.com>	<20110509123902.GA5975@redhat.com>
	<4DC80662.9000703@canonical.com> <20110509154606.GE5975@redhat.com>
In-Reply-To: <20110509154606.GE5975@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Bouchard Louis <louis.bouchard@canonical.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

Le 09/05/2011 17:46, Vivek Goyal a =E9crit :
> Louis, is this "crashdc" an independent executable. Where is it packaged?
> What is the significance of name "crashdc" (Crash data collecor ?) Will it
> make sense to merge it with makedumpfile which does kernel filtering
> already and this could be one of the additional features.
>
> Thanks
> Vivek

crashdc is hosted no SF.  You can have a look at it here :

http://crashdc.svn.sourceforge.net/viewvc/crashdc/trunk/and

Most of the work happens in /usr/bin/crashdc and the
run-crashdc-{distro}.sh scripts.

It does indeed means crash data collector.  It basically is a set of
shell script that send a set of predefined commands to the crash utility
and gather the result in a text file that can be easily sent over email.

In one implementation, it makes use of the KDUMP_POST mechanism to run.
Another way to use it is through an init script upon reboot.

As for merging it with makedumpfile, it could be an interesting choice. =

But that might add requirements to makedumpfile that you might not want
to have (dependencies on crash & the kernel-debuginfo packages which are
needed).

I have recently changed jobs, so I had to suspend my work on crashdc a
bit. I'm hoping to find time to work on it and adapt it to debian based
distro in the near future.

Kind regards,

...Louis

-- =

Louis Bouchard
Server Support Analyst
Canonical Ltd
Ubuntu support: http://landscape.canonical.com


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
