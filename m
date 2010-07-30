Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <4C533922.10901@zytor.com>
Date: Fri, 30 Jul 2010 13:42:10 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: In place kexec
References: <4C50A7AD.8040902@zytor.com> <m1y6cvtgd0.fsf@fess.ebiederm.org>	
	<20100729134343.GA31490@shamino.rdu.redhat.com>	
	<4C519853.2040206@zytor.com>	
	<20100729150640.GF31490@shamino.rdu.redhat.com>
	<4C51BFA5.60507@zytor.com>	 <m1k4oe88n9.fsf@fess.ebiederm.org>
	<4C51C878.2090102@zytor.com>	 <20100729191654.GB28704@redhat.com>
	<m1lj8uvzgy.fsf@fess.ebiederm.org>	
	<20100729125535.85dfd7da.randy.dunlap@oracle.com>	
	<4C524934.5070806@zytor.com> <m1d3u5ins8.fsf@fess.ebiederm.org>
	<1280508817.28006.0.camel@macbook.infradead.org>
In-Reply-To: <1280508817.28006.0.camel@macbook.infradead.org>
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
To: David Woodhouse <dwmw2@infradead.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Neil Horman <nhorman@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-driver@qlogic.com, Vivek Goyal <vgoyal@redhat.com>, Andrew Vasquez <andrew.vasquez@qlogic.com>

On 07/30/2010 09:53 AM, David Woodhouse wrote:
> On Thu, 2010-07-29 at 21:41 -0700, Eric W. Biederman wrote:
>> There isn't a bus master shut off at the core level.  
> 
> Effectively, there is if you have an IOMMU.

With the "core level" I meant Linux kernel code, as opposed to hardware
level which is slightly different; I meant it would make sense to at
least set the bus master control bit (PCI_COMMAND_MASTER) to zero before
kexec.

I also agree that reboot and kexec are different; the requirements for
kexec are really much more strict.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
