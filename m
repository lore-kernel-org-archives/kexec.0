Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nat28.tlf.novell.com ([130.57.49.28])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tvn3z-00021x-D5
 for kexec@lists.infradead.org; Thu, 17 Jan 2013 10:51:18 +0000
Message-Id: <50F7E5B002000078000B6BB5@nat28.tlf.novell.com>
Date: Thu, 17 Jan 2013 10:51:12 +0000
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [RFC PATCH 0/3] Improve kexec support in Xen
 hypervisor
References: <1358353746-1899-1-git-send-email-david.vrabel@citrix.com>
 <1358355772.13856.11.camel@zakaz.uk.xensource.com>
 <50F6E7F6.7060905@citrix.com>
 <50F7E4B102000078000B6BA7@nat28.tlf.novell.com>
In-Reply-To: <50F7E4B102000078000B6BA7@nat28.tlf.novell.com>
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

>>> On 17.01.13 at 11:46, "Jan Beulich" <JBeulich@suse.com> wrote:
>>>> On 16.01.13 at 18:48, David Vrabel <david.vrabel@citrix.com> wrote:
>> Full compatibility is possible and not that hard.  Is it actually worth
>> it though?  Will there be people updating Xen to 4.3 and unable to
>> update their kernel or userspace tools?
> 
> I think we simply shouldn't even be considering removal of
> functionality that we can't tell for sure is not being used
> anywhere, and that we don't deliberately want to go away (like
> was the case with 32-bit hypervisor support).

Forgot to say - for our distros, the kernel is being updated quite
regularly, whereas I have no idea at what intervals the kexec
user space code gets pulled. Plus I don't think I've seen any
patches to this one yet, so you're basically disabling all kexec
functionality for the time being when you remove the old code.

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
