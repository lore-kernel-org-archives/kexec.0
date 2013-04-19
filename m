Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UTBHA-0005mB-8S
 for kexec@lists.infradead.org; Fri, 19 Apr 2013 13:22:53 +0000
Date: Fri, 19 Apr 2013 15:22:34 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [Xen-devel] [PATCHv4 0/8] kexec: extend kexec hypercall for use
 with pv-ops kernels
Message-ID: <20130419132234.GA3607@debian70-amd64.local.net-space.pl>
References: <1366132390-5269-1-git-send-email-david.vrabel@citrix.com>
 <20130417123437.GA906@debian70-amd64.local.net-space.pl>
 <51702F9F.30500@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51702F9F.30500@citrix.com>
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
Cc: Keir Fraser <keir@xen.org>, kexec@lists.infradead.org, xen-devel@lists.xen.org

On Thu, Apr 18, 2013 at 06:38:39PM +0100, David Vrabel wrote:
> On 17/04/13 13:34, Daniel Kiper wrote:
> >
> > kexec -e still does not work. I see in my console:
> >
> > I'm in purgatory
> > sha256 digests do not match :(
>
> I have now fixed this.  Xen was not probably zeroing out trailing pages
> (only partial pages) when loading a default image (crash was fine).

Idea is quite good but how many pages in percent are zero?
Is it worth to do that? Additionally, I am afraid that this
way you are only masking bug in kexec-tools. I think it
is better to do bisect on it and find out which patch
introduces a bug.

> The kernel does this by allocating and clearing pages and then
> relocating these as normal but it's wasteful to allocate a bunch of
> empty pages so I added a IND_ZERO entry type for the indirection pages
> which gets the relocation code to zero the destination.
>
> See the kexec-v5 branch at:
>
> http://xenbits.xen.org/gitweb/?p=people/dvrabel/xen.git;a=summary
>
> I shall repost this series again once the 4.4 development window is open.

Do you think that at this stage we are not able to introduce this
kexec implementation into 4.3? I think that we should try.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
