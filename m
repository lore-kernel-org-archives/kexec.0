Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from lixom.net ([66.141.50.11] helo=mail.lixom.net)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HrE7m-000838-Oq
	for kexec@lists.infradead.org; Thu, 24 May 2007 10:17:09 -0400
Date: Thu, 24 May 2007 09:21:33 -0500
Subject: Re: [Patch 2/2] Kexec/Kdump support - POWER6
Message-ID: <20070524142133.GA13191@lixom.net>
References: <4652E088.9080207@in.ibm.com> <4652E109.4020204@in.ibm.com>
	<4652E17C.7080607@in.ibm.com> <20070522153419.GA22047@lixom.net>
	<46540B6F.6030300@in.ibm.com>
	<18004.7556.311264.415721@cargo.ozlabs.ibm.com>
	<20070524121751.GB4547@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070524121751.GB4547@in.ibm.com>
From: olof@lixom.net (Olof Johansson)
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
To: Mohan Kumar M <mohan@in.ibm.com>
Cc: Milton Miller II <miltonm@us.ibm.com>, kexec@lists.infradead.org, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, sachinp@in.ibm.com, ellerman@au1.ibm.com

On Thu, May 24, 2007 at 05:47:51PM +0530, Mohan Kumar M wrote:
> On Wed, May 23, 2007 at 08:55:00PM +1000, Paul Mackerras wrote:
> > Sachin P. Sant writes:
> > 
> > > On Power machines supporting VRMA, Kexec/Kdump does not work.
> > > Hypervisor stores VRMA mapping used by the OS, in the hpte hash
> > > tables. Make sure these hpte entries are left untouched.
> > 
> > Surely all we need to do is to avoid clearing the VRMA entries.  We
> > can do this by not clearing any HPTE where the top 40 bits of the
> > first dword are 0x4001ffffff (B=1 for a 1TB segment and the
> > 0x0001ffffff special VSID).  In fact we can avoid having to read each
> > entry by doing the H_REMOVEs with H_ANDCOND and the bolted bit when we
> > clear the hash table, and only reading the HPTEs for which the
> > H_REMOVE returns an error.
> 
> So I tried 0x4000000000000000 as AVPN parameter and using that it
> removes all hpte entries other than VRMA(ie non 1TB segment size PTE
> entries).
> 
> Tested on POWER6/POWER5 machines.

Hi,

As Paul says above, you need to check for failures and compare the VSID
and possibly unhash it anyway in case of non-match. Otherwise if the
kernel ever starts using 1TB segments for regular use, those pages will
never be unhashed. I don't see your code doing that now.


-Olof


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
