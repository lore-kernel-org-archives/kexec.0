Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 30 Jul 2010 20:46:12 +0100 (BST)
From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: In place kexec
In-Reply-To: <m1zkx8kbcs.fsf@fess.ebiederm.org>
Message-ID: <alpine.LFD.2.00.1007302040440.13729@dwoodhou-mobl2.ger.corp.intel.com>
References: <4C51C878.2090102@zytor.com> <20100729191654.GB28704@redhat.com>
	<m1lj8uvzgy.fsf@fess.ebiederm.org>
	<20100729125535.85dfd7da.randy.dunlap@oracle.com>
	<4C524934.5070806@zytor.com> <m1d3u5ins8.fsf@fess.ebiederm.org>
	<1280508817.28006.0.camel@macbook.infradead.org>
	<m1vd7w3k5l.fsf@fess.ebiederm.org> <20100730183446.GC3332@redhat.com>
	<alpine.LFD.2.00.1007301948420.13729@dwoodhou-mobl2.ger.corp.intel.com>
	<20100730185625.GD3332@redhat.com>
	<alpine.LFD.2.00.1007302015140.13729@dwoodhou-mobl2.ger.corp.intel.com>
	<m1zkx8kbcs.fsf@fess.ebiederm.org>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Neil Horman <nhorman@redhat.com>, "kexec\\@lists.infradead.org" <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>, Andrew Vasquez <andrew.vasquez@qlogic.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-driver@qlogic.com, Vivek Goyal <vgoyal@redhat.com>

On Fri, 30 Jul 2010, Eric W. Biederman wrote:

> David Woodhouse <dwmw2@infradead.org> writes:
>> The DMA gets blocked, and you don't have to worry about whether the device was
>> shut down cleanly or not. The device may be unhappy, but when the new kernel's
>> driver loads and reinitialises it, all should be forgiven.
>
> Assuming IOMMU page faults don't cause pain.  I seem to remember that
> also being a nasty issue.

Only if the driver (or the hardware) is so broken that it can't reccover. 
There's very little excuse for a driver to have that problem even at 
runtime (and fail to recover from such an error)... for a driver to fail 
to initialise the hardware even when that driver is first being loaded is 
*entirely* fucked.

Not that it doesn't happen, of course. But do we care? I lump those 
broken drivers is the same class as the ones which only work after a warm 
start from Windows or Mac OS.

-- 
dwmw2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
