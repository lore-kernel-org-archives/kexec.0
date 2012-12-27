Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1ToMnJ-0006WG-VZ
 for kexec@lists.infradead.org; Thu, 27 Dec 2012 23:23:22 +0000
MIME-Version: 1.0
Message-ID: <5698071f-c96c-4891-81d6-a77c4e3b77c2@default>
Date: Thu, 27 Dec 2012 15:23:02 -0800 (PST)
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v3 06/11] x86/xen: Add i386 kexec/kdump implementation
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
To: hpa@zytor.com
Cc: xen-devel@lists.xensource.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, jbeulich@suse.com, maxim.uvarov@oracle.com, tglx@linutronix.de, vgoyal@redhat.com

> On 12/26/2012 06:18 PM, Daniel Kiper wrote:
> > Add i386 kexec/kdump implementation.
> >
> > v2 - suggestions/fixes:
> >     - allocate transition page table pages below 4 GiB
> >       (suggested by Jan Beulich).
>
> Why?

Sadly all addresses are passed via unsigned long
variable to kexec hypercall.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
