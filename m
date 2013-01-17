Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nat28.tlf.novell.com ([130.57.49.28])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tvmzu-00083i-Gt
 for kexec@lists.infradead.org; Thu, 17 Jan 2013 10:47:04 +0000
Message-Id: <50F7E4B102000078000B6BA7@nat28.tlf.novell.com>
Date: Thu, 17 Jan 2013 10:46:57 +0000
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [RFC PATCH 0/3] Improve kexec support in Xen
 hypervisor
References: <1358353746-1899-1-git-send-email-david.vrabel@citrix.com>
 <1358355772.13856.11.camel@zakaz.uk.xensource.com>
 <50F6E7F6.7060905@citrix.com>
In-Reply-To: <50F6E7F6.7060905@citrix.com>
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
To: David Vrabel <david.vrabel@citrix.com>, Ian Campbell <Ian.Campbell@citrix.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

>>> On 16.01.13 at 18:48, David Vrabel <david.vrabel@citrix.com> wrote:
> Full compatibility is possible and not that hard.  Is it actually worth
> it though?  Will there be people updating Xen to 4.3 and unable to
> update their kernel or userspace tools?

I think we simply shouldn't even be considering removal of
functionality that we can't tell for sure is not being used
anywhere, and that we don't deliberately want to go away (like
was the case with 32-bit hypervisor support).

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
