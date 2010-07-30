Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g6t0186.atlanta.hp.com ([15.193.32.63])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OexO9-0005IE-K8
	for kexec@lists.infradead.org; Fri, 30 Jul 2010 21:45:13 +0000
Subject: Re: In place kexec
From: Khalid Aziz <khalid_aziz@hp.com>
In-Reply-To: <1280524696.30160.34.camel@localhost>
References: <4C50A7AD.8040902@zytor.com> <m1y6cvtgd0.fsf@fess.ebiederm.org>
	<20100729134343.GA31490@shamino.rdu.redhat.com>
	<4C519853.2040206@zytor.com>
	<20100729150640.GF31490@shamino.rdu.redhat.com>	<4C51BFA5.60507@zytor.com>
	<m1k4oe88n9.fsf@fess.ebiederm.org>	<4C51C878.2090102@zytor.com>
	<20100729191654.GB28704@redhat.com>	<m1lj8uvzgy.fsf@fess.ebiederm.org>
	<20100729125535.85dfd7da.randy.dunlap@oracle.com>
	<4C524934.5070806@zytor.com> <m1d3u5ins8.fsf@fess.ebiederm.org>
	<1280508817.28006.0.camel@macbook.infradead.org>	<4C533922.10901@zytor.com>
	<1280524696.30160.34.camel@localhost>
Date: Fri, 30 Jul 2010 15:44:58 -0600
Message-Id: <1280526298.30160.39.camel@localhost>
Mime-Version: 1.0
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Neil Horman <nhorman@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, "linux-driver@qlogic.com" <linux-driver@qlogic.com>, David Woodhouse <dwmw2@infradead.org>, Vivek Goyal <vgoyal@redhat.com>, Andrew Vasquez <andrew.vasquez@qlogic.com>

On Fri, 2010-07-30 at 21:18 +0000, Aziz, Khalid wrote:
> There were some discussions regarding this and this code was removed by
> the time it was merged into mainline kernel. I can't remember the
> details of why. I remember one report of kernel hang on kexec that
> seemed to happen in device_shootdown(). I will look for any discussion
> threads I can find.
> 

These are the messages I could find discussing the code that disables
PCI Master bit, before the code doing that was removed from ia64 tree:

<https://lists.linux-foundation.org/pipermail/fastboot/2006-June/010175.html>
<https://lists.linux-foundation.org/pipermail/fastboot/2006-June/010176.html>
<https://lists.linux-foundation.org/pipermail/fastboot/2006-June/010178.html>
<https://lists.linux-foundation.org/pipermail/fastboot/2006-June/010214.html>

May be it is time to revisit this, for more than just ia64.

-- 
Khalid
====================================================================
Khalid Aziz                             Telco Platform Software, ISB
(970)898-9214                                        Hewlett-Packard
khalid.aziz@hp.com                                  Fort Collins, CO

"The Linux kernel is subject to relentless development" 
                                - Alessandro Rubini


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
