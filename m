Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: In place kexec
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <m18w4ska11.fsf@fess.ebiederm.org>
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
	<alpine.LFD.2.00.1007302040440.13729@dwoodhou-mobl2.ger.corp.intel.com>
	<m18w4ska11.fsf@fess.ebiederm.org>
Date: Fri, 30 Jul 2010 22:15:40 +0200
Message-ID: <1280520940.28006.7.camel@macbook.infradead.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Neil Horman <nhorman@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>, Andrew Vasquez <andrew.vasquez@qlogic.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-driver@qlogic.com, Vivek Goyal <vgoyal@redhat.com>

On Fri, 2010-07-30 at 13:08 -0700, Eric W. Biederman wrote:
> The issue is what happens if you take an IOMMU page fault during
> between shutdown and restart.  I seem to remember an IOMMU page fault
> triggering a machine check on AMD cpus.  So maybe it works but my gut
> impression is simply leaving the IOMMU in a state that is on but not
> responding could actually make a reboot or kexec less stable than having
> on-going DMAs stomping on memory.  If you can leave it on, without
> translations and not trapping to software that is a different story. 

Speaking of the Intel IOMMU, I know nothing of any 'on but not
responding' state. You have:

 - 'off', which gives a 1:1 mapping and thus if you do this during kexec
    any still-running devices could be scribbling *anywhere* in memory,
    using their previously-allocated virtual DMA addresses which are
    now interpreted as physical addresses.

 - 'on with page tables cleared', in which case you are safe but some
    devices might get upset when their DMA is aborted, so their driver
    needs not to be a pile of shit, and needs to recover from that.

 - 'on and we preserve the virt->phys mappings of the previous kernel',
    which is just crack-inspired. You'd have to find the physical pages
    which were mapped by the previous kernel and steal them away from
    the new kernel's memory map, just in case they get scribbled on by
    a device which hasn't been properly shut down by the previous
    kernel, through the still-extant DMA mappings.

I mention the latter only because it's been suggested by someone who was
dealing with a broken driver/hardware combination where it *didn't* get
properly reset after a fault, even when the driver was loaded anew. Not
because anyone in their right mind would ever *do* it.

-- 
dwmw2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
