Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UCq3R-0003XJ-Nk
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 11:29:10 +0000
MIME-Version: 1.0
Message-ID: <46f3a121-c37e-4df8-ace6-e3a9c5d84b70@default>
Date: Tue, 5 Mar 2013 03:29:00 -0800 (PST)
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [Xen-devel] [PATCH 0/8] kexec: extended kexec hypercall for use
 with pv-ops kernels
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: david.vrabel@citrix.com
Cc: Ian.Jackson@eu.citrix.com, kexec@lists.infradead.org, ian.campbell@citrix.com, xen-devel@lists.xen.org

> On 21/02/13 17:48, David Vrabel wrote:
> > The series improves the kexec hypercall by making Xen responsible for
> > loading and relocating the image.  This allows kexec to be usable by
> > pv-ops kernels and should allow kexec to be usable from a HVM or PVH
> > privileged domain.
>
> Any further comments/acks for any of these patches? Specifically patch 2
> and the toolstack patches (7 and 8).

I am reviewing patches more deeply right now.
I will send you my comments by the end
of this week (as I promised earlier).

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
