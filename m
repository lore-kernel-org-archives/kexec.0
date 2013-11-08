Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from nat28.tlf.novell.com ([130.57.49.28])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Velz0-0003cg-Fi
 for kexec@lists.infradead.org; Fri, 08 Nov 2013 13:20:20 +0000
Message-Id: <527CF3050200007800101354@nat28.tlf.novell.com>
Date: Fri, 08 Nov 2013 13:19:49 +0000
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [PATCHv10 0/9] Xen: extend kexec hypercall for use with
 pv-ops kernels
References: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
 <20131107211651.GC11159@olila.local.net-space.pl>
 <527CE397.10101@citrix.com>
In-Reply-To: <527CE397.10101@citrix.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: Keir Fraser <keir@xen.org>, Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, xen-devel@lists.xen.org

>>> On 08.11.13 at 14:13, David Vrabel <david.vrabel@citrix.com> wrote:
> Keir,
> 
> Sorry, forgot to CC you on this series.
> 
> Can we have your opinion on whether this kexec series can be merged?
> And if not, what further work and/or testing is required?

Just to clarify - unless I missed something, there was still no
review of this from Daniel or someone else known to be
familiar with the subject. If Keir gave his ack, formally this
could go in, but I wouldn't feel too well with that (the more
that apart from not having reviewed it, Daniel seems to also
continue to have problems with it).

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
