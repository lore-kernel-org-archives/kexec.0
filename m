Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OehmM-0002pv-Hy
	for kexec@lists.infradead.org; Fri, 30 Jul 2010 05:05:07 +0000
Message-ID: <4C525D6A.4000007@zytor.com>
Date: Thu, 29 Jul 2010 22:04:42 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: In place kexec
References: <4C50A7AD.8040902@zytor.com>
	<m1y6cvtgd0.fsf@fess.ebiederm.org>	<20100729134343.GA31490@shamino.rdu.redhat.com>	<4C519853.2040206@zytor.com>	<20100729150640.GF31490@shamino.rdu.redhat.com>	<4C51BFA5.60507@zytor.com>
	<m1k4oe88n9.fsf@fess.ebiederm.org>	<4C51C878.2090102@zytor.com>
	<20100729191654.GB28704@redhat.com>	<m1lj8uvzgy.fsf@fess.ebiederm.org>	<20100729125535.85dfd7da.randy.dunlap@oracle.com>	<4C524934.5070806@zytor.com>
	<m1d3u5ins8.fsf@fess.ebiederm.org>
In-Reply-To: <m1d3u5ins8.fsf@fess.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Neil Horman <nhorman@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>, Andrew Vasquez <andrew.vasquez@qlogic.com>, linux-driver@qlogic.com, Vivek Goyal <vgoyal@redhat.com>

On 07/29/2010 09:41 PM, Eric W. Biederman wrote:
> 
> There isn't a bus master shut off at the core level.  When we did
> the original analysis it turned out that the bus mastering bit
> was implemented on a lot of devices in advisory way, so it didn't
> make sense to count on it.
> 

But does it make sense to not flip the bit for the cases where it is
implemented properly?

> That said it looks like the code to do the shutdown is in
> qla2x00_remove_one so it should be too hard if someone cared to
> extract just the hardware bits.

Charming.  Code is there, just not hooked up.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
