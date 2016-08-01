Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from prv-mh.provo.novell.com ([137.65.248.74])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bUBod-0007em-Qw
 for kexec@lists.infradead.org; Mon, 01 Aug 2016 11:55:28 +0000
Message-Id: <579F54B502000078001013F1@prv-mh.provo.novell.com>
Date: Mon, 01 Aug 2016 05:55:01 -0600
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH 2/2] Allow kdump with
 crash_kexec_post_notifiers
References: <20160713121950.14969.78606.stgit@hananiah.suse.cz>
 <20160713122000.14969.99963.stgit@hananiah.suse.cz>
 <578639AE.10500@citrix.com>
In-Reply-To: <578639AE.10500@citrix.com>
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
To: David Vrabel <david.vrabel@citrix.com>, Petr Tesarik <PTesarik@suse.com>
Cc: Juergen Gross <JGross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "maintainer:X86 ARCHITECTURE 32-BIT AND64-BIT" <x86@kernel.org>, "open list:KEXEC" <kexec@lists.infradead.org>, JoshTriplett <josh@joshtriplett.org>, open list <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H.Peter Anvin" <hpa@zytor.com>, "moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>, ThomasGleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

>>> On 13.07.16 at 14:53, <david.vrabel@citrix.com> wrote:
> On 13/07/16 13:20, Petr Tesarik wrote:
>> If a crash kernel is loaded, do not crash the running domain. This is
>> needed if the kernel is loaded with crash_kexec_post_notifiers, because
>> panic notifiers are run before __crash_kexec() in that case, and this
>> Xen hook prevents its being called later.
> 
> Prioritising the in-kernel kexec image over the hypervisor one seems
> sensible behaviour to me.

For HVM guests certainly; does loading of an in-kernel crash kernel
properly fail for PV guests (and namely PV Dom0), or does such a
setup work nowadays?

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
