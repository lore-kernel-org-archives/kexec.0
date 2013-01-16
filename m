Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.eu.citrix.com ([46.33.159.39])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TvWO7-0000kH-EK
 for kexec@lists.infradead.org; Wed, 16 Jan 2013 17:02:56 +0000
Message-ID: <1358355772.13856.11.camel@zakaz.uk.xensource.com>
Subject: Re: [Xen-devel] [RFC PATCH 0/3] Improve kexec support in Xen
 hypervisor
From: Ian Campbell <Ian.Campbell@citrix.com>
Date: Wed, 16 Jan 2013 17:02:52 +0000
In-Reply-To: <1358353746-1899-1-git-send-email-david.vrabel@citrix.com>
References: <1358353746-1899-1-git-send-email-david.vrabel@citrix.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On Wed, 2013-01-16 at 16:29 +0000, David Vrabel wrote:
> Since the kexec hypercall is for use by dom0 I have removed the
> implementation of the old load/unload ops and thus guests will require
> updated kexec-tools to load images.  Is this acceptable? 

How hard would it be to also support the old interface for the benefit
of old kernels and userspaces (e.g. existing distros)?

Rather than a _v2 suffix we have in the past renamed the old ones
_compat and introduced the new ones, with appropriate use of
__XEN_INTERFACE_VERSION__ to paper over things for old users.

See __HYPERVISOR_sched_op for example.

Ian.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
