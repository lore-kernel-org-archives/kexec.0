Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W4Bp5-0005jA-Jw
 for kexec@lists.infradead.org; Fri, 17 Jan 2014 15:59:08 +0000
From: "Sumner, William" <bill.sumner@hp.com>
Subject: RE: [Q] Why does kexec use device_shutdown rather than ubind them
Date: Fri, 17 Jan 2014 15:57:34 +0000
Message-ID: <875D89B79D1D86448A583A7302C022A055ACA571@G4W3299.americas.hpqcorp.net>
References: <1389929988.7406.18.camel@pasglop> <871u07fbvl.fsf@xmission.com>
 <1389938353.7406.22.camel@pasglop> <20140117141327.GC24394@redhat.com>
In-Reply-To: <20140117141327.GC24394@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

Vivek, Ben, Eric,

Please take a look at a proposed patch to intel-iommu: "[PATCHv3 0/6] Crashdump Accepting Active IOMMU"

This is specifically for kdump; however, would some small variation of this technique be applicable to kexec ?

Thanks,
Bill

-----Original Message-----
From: kexec [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Vivek Goyal
Sent: Friday, January 17, 2014 8:13 AM
To: Benjamin Herrenschmidt
Cc: Matthew Garrett; kexec@lists.infradead.org; linux-kernel@vger.kernel.org; Eric W. Biederman; Andrew Morton; Linus Torvalds
Subject: Re: [Q] Why does kexec use device_shutdown rather than ubind them

On Fri, Jan 17, 2014 at 04:59:13PM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2014-01-16 at 20:52 -0800, Eric W. Biederman wrote:
> > 
> > I think we have largely survied until now because kdump is so popular
> > and kdump winds up having to reinitialize devices from any random
> > state.
> 
> kdump also doesn't care too much if the device is still DMA'ing to the
> old kernel memory :-)

In principle kdump does not care about ongoing DMAs but in practice it
is giving us some headaches with IOMMU. Various kind of issues crop up
during IOMMU intialization in second kernel while DMA is ongoing and
unfortunately no good solution has made into upstream yet.

Well, ongoing DMA and IOMMU seems to be orthogonal to using ->remove()
in kexec. So I will stop here. :-)

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
