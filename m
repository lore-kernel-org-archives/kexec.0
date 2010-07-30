Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <4C53400F.6020408@zytor.com>
Date: Fri, 30 Jul 2010 14:11:43 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: In place kexec
References: <4C51C878.2090102@zytor.com> <20100729191654.GB28704@redhat.com>	
	<m1lj8uvzgy.fsf@fess.ebiederm.org>	
	<20100729125535.85dfd7da.randy.dunlap@oracle.com>	
	<4C524934.5070806@zytor.com> <m1d3u5ins8.fsf@fess.ebiederm.org>	
	<1280508817.28006.0.camel@macbook.infradead.org>	
	<m1vd7w3k5l.fsf@fess.ebiederm.org>
	<20100730183446.GC3332@redhat.com>	
	<alpine.LFD.2.00.1007301948420.13729@dwoodhou-mobl2.ger.corp.intel.com>	
	<20100730185625.GD3332@redhat.com>	
	<alpine.LFD.2.00.1007302015140.13729@dwoodhou-mobl2.ger.corp.intel.com>	
	<m1zkx8kbcs.fsf@fess.ebiederm.org>	
	<alpine.LFD.2.00.1007302040440.13729@dwoodhou-mobl2.ger.corp.intel.com>	
	<m18w4ska11.fsf@fess.ebiederm.org>
	<1280520940.28006.7.camel@macbook.infradead.org>
In-Reply-To: <1280520940.28006.7.camel@macbook.infradead.org>
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

On 07/30/2010 01:15 PM, David Woodhouse wrote:
> 
>  - 'on with page tables cleared', in which case you are safe but some
>     devices might get upset when their DMA is aborted, so their driver
>     needs not to be a pile of shit, and needs to recover from that.
> 

I presume this is the state he's referring to.

Now, if this means there are page tables in memory those tables are
still subject to being overwritten.

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
