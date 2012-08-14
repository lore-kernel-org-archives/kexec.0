Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rcsinet15.oracle.com ([148.87.113.117])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T1AT6-0004Dx-KR
 for kexec@lists.infradead.org; Tue, 14 Aug 2012 06:19:10 +0000
Date: Tue, 14 Aug 2012 08:17:42 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v2 1/6] xen: Always calculate max_cpus value
Message-ID: <20120814061742.GB2471@host-192-168-1-59.local.net-space.pl>
References: <20120810132513.GB2576@host-192-168-1-59.local.net-space.pl>
 <502539410200007800094355@nat28.tlf.novell.com>
 <20120813081235.GB2482@host-192-168-1-59.local.net-space.pl>
 <5028E09B0200007800094691@nat28.tlf.novell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5028E09B0200007800094691@nat28.tlf.novell.com>
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
To: Jan Beulich <JBeulich@suse.com>
Cc: olaf@aepfle.de, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, kexec@lists.infradead.org, ptesarik@suse.cz, xen-devel <xen-devel@lists.xen.org>, anderson@redhat.com, crash-utility@redhat.com

On Mon, Aug 13, 2012 at 10:10:19AM +0100, Jan Beulich wrote:
> >>> On 13.08.12 at 10:12, Daniel Kiper <daniel.kiper@oracle.com> wrote:
> > On Fri, Aug 10, 2012 at 03:39:29PM +0100, Jan Beulich wrote:
> >> >>> On 10.08.12 at 15:25, Daniel Kiper <daniel.kiper@oracle.com> wrote:
> >> > max_cpus is not available since 20374 changeset (Miscellaneous data
> >> > placement adjustments). It was moved to __initdata section. This section
> >> > is freed after Xen initialization. Assume that max_cpus is always
> >> > equal to XEN_HYPER_SIZE(cpumask_t) * 8.
> >>
> >> Just to repeat my response to the original version of this patch,
> >> which I don't recall having got any answer from you:
> >>
> >> "Using nr_cpu_ids, when available, would seem a better fit. And
> >>  I don't see why, on dumps from old hypervisors, you wouldn't
> >>  want to continue using max_cpus. Oh, wait, I see - you would
> >>  have to be able to tell whether it actually sits in .init.data, which
> >>  might not be strait forward."
> >
> > As I promised earlier I thought about that. The simplest way
> > to do that is to check in which section max_cpus resides. There
> > is some instrumentation in crash tool to do that. However, sadly
> > it does not differentiate between .data and .init.data section.
> > I could write something from scratch which could do that but
> > I think it could have larger costs then potential gains.
> > Let's leave it as is now. Current approximation is not so bad.
> > However, if any opportunity appears (some functions could
> > differentiate between .data and .init.data section) then
> > I could fix this.
>
> But minimally you should be using nr_cpu_ids when available.
> You just have to be prepared for bits beyond that value within
> any cpumask_t instance to have random contents.

I will try to improve that after my vacation (on September).

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
