Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W4ABI-0001Sx-5U
 for kexec@lists.infradead.org; Fri, 17 Jan 2014 14:13:57 +0000
Date: Fri, 17 Jan 2014 09:13:27 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Q] Why does kexec use device_shutdown rather than ubind them
Message-ID: <20140117141327.GC24394@redhat.com>
References: <1389929988.7406.18.camel@pasglop> <871u07fbvl.fsf@xmission.com>
 <1389938353.7406.22.camel@pasglop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1389938353.7406.22.camel@pasglop>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

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
