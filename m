Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TvX6Q-0001mc-FL
 for kexec@lists.infradead.org; Wed, 16 Jan 2013 17:48:43 +0000
Message-ID: <50F6E7F6.7060905@citrix.com>
Date: Wed, 16 Jan 2013 17:48:38 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [RFC PATCH 0/3] Improve kexec support in Xen
 hypervisor
References: <1358353746-1899-1-git-send-email-david.vrabel@citrix.com>
 <1358355772.13856.11.camel@zakaz.uk.xensource.com>
In-Reply-To: <1358355772.13856.11.camel@zakaz.uk.xensource.com>
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
To: Ian Campbell <Ian.Campbell@citrix.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On 16/01/13 17:02, Ian Campbell wrote:
> On Wed, 2013-01-16 at 16:29 +0000, David Vrabel wrote:
>> Since the kexec hypercall is for use by dom0 I have removed the
>> implementation of the old load/unload ops and thus guests will require
>> updated kexec-tools to load images.  Is this acceptable? 
> 
> How hard would it be to also support the old interface for the benefit
> of old kernels and userspaces (e.g. existing distros)?

There's an easy way (see patch 1), but it doesn't have full
compatibility as it no longer executes the code page supplied by the
guest.  This won't matter with Linux guests as their code pages can be
replaced by the code in Xen, but may matter with some more obscure
guests that do unusual things in their code pages (are there any like
this -- I doubt it?).

Full compatibility is possible and not that hard.  Is it actually worth
it though?  Will there be people updating Xen to 4.3 and unable to
update their kernel or userspace tools?

> Rather than a _v2 suffix we have in the past renamed the old ones
> _compat and introduced the new ones, with appropriate use of
> __XEN_INTERFACE_VERSION__ to paper over things for old users.
> 
> See __HYPERVISOR_sched_op for example.

Ok. I'll look at this.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
