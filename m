Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from djurbala-pt.tunnel.tserv2.fmt.ipv6.he.net
	([2001:470:1f01:ffff::eb] helo=gate.crashing.org)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hsvfi-00051S-4G
	for kexec@lists.infradead.org; Tue, 29 May 2007 02:59:12 -0400
Subject: Re: [Patch ] Kexec/Kdump support - POWER6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <465BC5A1.5040505@in.ibm.com>
References: <4652E088.9080207@in.ibm.com> <4652E109.4020204@in.ibm.com>
	<4652E17C.7080607@in.ibm.com> <20070522153419.GA22047@lixom.net>
	<46540B6F.6030300@in.ibm.com>
	<18004.7556.311264.415721@cargo.ozlabs.ibm.com>
	<20070524121751.GB4547@in.ibm.com> <20070524142133.GA13191@lixom.net>
	<4656A488.2020507@in.ibm.com>
	<1180132987.19517.9.camel@localhost.localdomain>
	<465ABFC9.9020502@in.ibm.com>
	<1180387894.19517.99.camel@localhost.localdomain>
	<465BC5A1.5040505@in.ibm.com>
Date: Tue, 29 May 2007 16:58:05 +1000
Message-Id: <1180421885.19517.109.camel@localhost.localdomain>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: sachinp@in.ibm.com
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, kexec@lists.infradead.org

On Tue, 2007-05-29 at 11:48 +0530, Sachin P. Sant wrote:
> 
> In previous patches i had these #defines in mmu-hash64.h. But got
> review comments to move them to lpar.c :-)

Hrm... weird. Oh well, _I_ personally prefer them in mmu-hash64.h and
since I'm writing most of the MMU code lately I'd say my opinion makes
rule :-)

> Oh well i will move them back to mmu-hash64.h.

Thanks.

Cheers,
Ben.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
