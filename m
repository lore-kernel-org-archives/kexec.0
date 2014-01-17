Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from gate.crashing.org ([63.228.1.57])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W4GXh-0005gt-6z
 for kexec@lists.infradead.org; Fri, 17 Jan 2014 21:01:30 +0000
Message-ID: <1389992443.7406.35.camel@pasglop>
Subject: Re: [Q] Why does kexec use device_shutdown rather than ubind them
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 18 Jan 2014 08:00:43 +1100
In-Reply-To: <20140117141327.GC24394@redhat.com>
References: <1389929988.7406.18.camel@pasglop> <871u07fbvl.fsf@xmission.com>
 <1389938353.7406.22.camel@pasglop> <20140117141327.GC24394@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, 2014-01-17 at 09:13 -0500, Vivek Goyal wrote:
> On Fri, Jan 17, 2014 at 04:59:13PM +1100, Benjamin Herrenschmidt wrote:
> > On Thu, 2014-01-16 at 20:52 -0800, Eric W. Biederman wrote:
> > > 
> > > I think we have largely survied until now because kdump is so popular
> > > and kdump winds up having to reinitialize devices from any random
> > > state.
> > 
> > kdump also doesn't care too much if the device is still DMA'ing to the
> > old kernel memory :-)
> 
> In principle kdump does not care about ongoing DMAs but in practice it
> is giving us some headaches with IOMMU. Various kind of issues crop up
> during IOMMU intialization in second kernel while DMA is ongoing and
> unfortunately no good solution has made into upstream yet.
> 
> Well, ongoing DMA and IOMMU seems to be orthogonal to using ->remove()
> in kexec. So I will stop here. :-)

Right, it's an orthogonal problem. I think hot resetting the bus might
solve it too though. It's even worse on ppc because the resulting iommu
errors trigger those "EEH freeze" that we have here blocking the devices
out etc...

Ben.

> Thanks
> Vivek
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
