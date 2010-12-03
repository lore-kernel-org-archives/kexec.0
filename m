Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1POVGm-0004G7-Vz
	for kexec@lists.infradead.org; Fri, 03 Dec 2010 13:01:52 +0000
Received: from g5t0029.atlanta.hp.com (g5t0029.atlanta.hp.com [16.228.8.141])
	by g5t0007.atlanta.hp.com (Postfix) with ESMTP id E12D6142C1
	for <kexec@lists.infradead.org>; Fri,  3 Dec 2010 13:01:42 +0000 (UTC)
Received: from [16.17.222.159] (unknown [16.17.222.159])
	by g5t0029.atlanta.hp.com (Postfix) with ESMTP id B6435200D8
	for <kexec@lists.infradead.org>; Fri,  3 Dec 2010 13:01:41 +0000 (UTC)
Message-ID: <4CF8EA33.30705@hp.com>
Date: Fri, 03 Dec 2010 14:01:39 +0100
From: Louis Bouchard <louis.bouchard@hp.com>
MIME-Version: 1.0
Subject: Presentation of crashdc
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello everyone

I just want to take  a few minutes of your time to let you know about
crashdc, a project that I have been working on for the last year.

It is a set of scripts that leverage kexec's kdump_post mechanism to
generate a text file called crash-data-{date}.txt containing some
specific 'crash' command output.

This allows kexec to automatically generate a high level text file that
can be sent to support engineers without going through the pain of
sending multi-gigabyte files over the Internet.

crashdc can also be triggered by an initscript upon reboot if sysadmins
prefer to avoid execution of crash commands in the kexec booted kernel
context, as it sometimes require a sensible increase in the
crashkernel's reserved memory.

It is currently working on RHEL5, SLES10 and SLES11 and I'm working on
RHEL6 enablement (x86 and x86_64).

You can find more details about it here :

http://cariblog.kamikamamak.com/2009/10/17/crashdc-the-architecture/

The project is hosted here :

http://crashdc.sourceforge.net

If some of you are insterested in more details, don't hesitate to let me
know.

Kind Regards,

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
