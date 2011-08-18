Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QuDV0-0003QV-Ap
	for kexec@lists.infradead.org; Fri, 19 Aug 2011 01:03:51 +0000
Received: from joe.akashicho.tokyo.vergenet.net
	(joe.akashicho.tokyo.vergenet.net
	[IPv6:2001:470:f44f:403:1ec1:deff:fe98:754d])
	by kirsty.vergenet.net (Postfix) with ESMTP id AE69F24062
	for <kexec@lists.infradead.org>; Fri, 19 Aug 2011 11:03:44 +1000 (EST)
Resent-Message-ID: <20110819010343.GA17659@verge.net.au>
Resent-To: kexec@lists.infradead.org
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QuAy3-0002eX-0C
	for kexec@lists.infradead.org; Thu, 18 Aug 2011 22:21:39 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p7IEiHvo022633
	for <kexec@lists.infradead.org>; Thu, 18 Aug 2011 08:44:17 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7IMLWBI146562
	for <kexec@lists.infradead.org>; Thu, 18 Aug 2011 16:21:32 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p7IMRFKq015005
	for <kexec@lists.infradead.org>; Thu, 18 Aug 2011 16:27:15 -0600
Received: from d27ml101.rchland.ibm.com (d27ml101.rchland.ibm.com
	[9.10.229.40])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p7IMREth014995
	for <kexec@lists.infradead.org>; Thu, 18 Aug 2011 16:27:14 -0600
Subject: Bootloaders with early kdump support?
Message-ID: <OF087F73E2.5ECF6BE5-ON862578F0.0079BA5A-862578F0.007AD1A0@us.ibm.com>
From: Nathan D Miller <nathanm2@us.ibm.com>
Date: Thu, 18 Aug 2011 17:21:30 -0500
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0124340994=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

--===============0124340994==
Content-type: multipart/alternative; 
	Boundary="0__=09BBF263DFEA3CCA8f9e8a93df938690918c09BBF263DFEA3CCA"
Content-Disposition: inline

--0__=09BBF263DFEA3CCA8f9e8a93df938690918c09BBF263DFEA3CCA
Content-type: text/plain; charset=US-ASCII


Greetings-

Vivek made the following statement a few months ago:

> On a side note, few months back there were folks who were trying
> to enhance bootloaders to be able to prepare basic environment so
> that a kdump kernel can boot even in the event of early first
> kernel boot.

Any idea which bootloaders?  Which folks?

I'm curious how one would go about implementing such a thing.  What
parameters would the bootloader need to supply to the kernel?

Thanks,
Nate
--0__=09BBF263DFEA3CCA8f9e8a93df938690918c09BBF263DFEA3CCA
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><font size="2" face="sans-serif">Greetings-</font><br>
<br>
<font size="2" face="sans-serif">Vivek made the following statement a few months ago: </font><br>
<br>
<tt><font size="3">&gt; On a side note, few months back there were folks who were trying<br>
&gt; to enhance bootloaders to be able to prepare basic environment so<br>
&gt; that a kdump kernel can boot even in the event of early first<br>
&gt; kernel boot.</font></tt><br>
<br>
<font size="2" face="sans-serif">Any idea which bootloaders? &nbsp;Which folks? </font><br>
<br>
<font size="2" face="sans-serif">I'm curious how one would go about implementing such a thing. &nbsp;What parameters would the bootloader need to supply to the kernel?</font><br>
<br>
<font size="2" face="sans-serif">Thanks, </font><br>
<font size="2" face="sans-serif">Nate</font></body></html>
--0__=09BBF263DFEA3CCA8f9e8a93df938690918c09BBF263DFEA3CCA--




--===============0124340994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0124340994==--



