Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UCpfP-0007zI-GL
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 11:04:20 +0000
Message-ID: <5135D12E.2010504@citrix.com>
Date: Tue, 5 Mar 2013 11:04:14 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 0/8] kexec: extended kexec hypercall for use
 with pv-ops kernels
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: Ian Jackson <Ian.Jackson@eu.citrix.com>, Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, Ian Campbell <ian.campbell@citrix.com>, xen-devel@lists.xen.org

On 21/02/13 17:48, David Vrabel wrote:
> The series improves the kexec hypercall by making Xen responsible for
> loading and relocating the image.  This allows kexec to be usable by
> pv-ops kernels and should allow kexec to be usable from a HVM or PVH
> privileged domain.

Any further comments/acks for any of these patches? Specifically patch 2
and the toolstack patches (7 and 8).

Thanks.

> The first patch is a simple clean-up.
> 
> The second patch allows hypercall structures to be ABI compatible
> between 32- and 64-bit guests (by reusing stuff present for domctls
> and sysctls).  This seems better than having to keep adding compat
> handling for new hypercalls etc.
> 
> Patch 3 introduces the new ABI.
> 
> Patch 4 and 5 nearly completely reimplement the kexec load, unload and
> exec sub-ops.  The old load_v1 sub-op is then implemented on top of
> the new code.
> 
> Patch 6 calls the kexec image when dom0 crashes.  This avoids having
> to alter dom0 kernels to do a exec sub-op call on crash -- an existing
> SHUTDOWN_crash.
> 
> Patches 7 and 8 add the libxc API for the kexec calls.
> 
> The required patch series for kexec-tools will be posted shortly.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
