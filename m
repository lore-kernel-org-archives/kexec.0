Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ViZug-0003EE-Cz
 for kexec@lists.infradead.org; Tue, 19 Nov 2013 01:15:34 +0000
Date: Tue, 19 Nov 2013 10:15:11 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCHv7 0/4] kexec-tools: add support for Xen 4.4
Message-ID: <20131119011511.GB17628@verge.net.au>
References: <1383749722-12091-1-git-send-email-david.vrabel@citrix.com>
 <52835429.8040708@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52835429.8040708@citrix.com>
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
To: David Vrabel <david.vrabel@citrix.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, xen-devel@lists.xen.org

On Wed, Nov 13, 2013 at 10:27:53AM +0000, David Vrabel wrote:
> On 06/11/13 14:55, David Vrabel wrote:
> > The series adds support for the new hypercall ABI which should be
> > provided by Xen 4.4.  Images are loaded into Xen directly with no
> > kernel involvement.
> > 
> > Please do not apply until the hypervisor side patches are applied to
> > Xen.
> 
> The hypervisor patches are now in Xen unstable and will be available in
> the upcoming Xen 4.4 release.
> 
> Please apply this corresponding kexec-tools series.
> 
> When making a new release with these patches in I would recommend adding
> a release note saying Xen 4.4 is now required to kexec under Xen.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
