Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nat28.tlf.novell.com ([130.57.49.28])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8nkg-0004nO-7T
 for kexec@lists.infradead.org; Fri, 22 Feb 2013 08:13:07 +0000
Message-Id: <512736DA02000078000C038C@nat28.tlf.novell.com>
Date: Fri, 22 Feb 2013 08:14:02 +0000
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH 0/4] kexec-tools: add support for Xen
 4.3
References: <1361469460-18771-1-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1361469460-18771-1-git-send-email-david.vrabel@citrix.com>
Mime-Version: 1.0
Content-Disposition: inline
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
To: David Vrabel <david.vrabel@citrix.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, xen-devel@lists.xen.org

>>> On 21.02.13 at 18:57, David Vrabel <david.vrabel@citrix.com> wrote:
> The series adds support for the new hypercall ABI which should be
> provided by Xen 4.3.  Images are loaded into Xen directly with no
> kernel involvement.
> 
> Do not apply until the hypervisor side patches are applied to Xen.
> 
> Patch 1 is unrelated but kexec wouldn't work for me without it. Not
> sure why I had problems, perhaps a toolstack specific issue?
> 
> Patch 2 makes libxc 4.3 mandatory for Xen support.

That doesn't sound right. How do you envision this to be
incorporated into existing distros that don't right away switch
to Xen 4.3?

Jan

> Patch 3 removes a use of /proc/iomem in favour of libxc.
> 
> Patch 4 adds the support for loading an image into Xen.
> 
> This series explicitly drops support for older version of libxc/Xen as
> supporting kexec on these hypervisors requires kernel support that
> will never be available upstream.
> 
> David
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org 
> http://lists.xen.org/xen-devel 




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
