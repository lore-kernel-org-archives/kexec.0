Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNJfT-0002JF-J6
 for kexec@lists.infradead.org; Wed, 13 Jul 2016 12:53:36 +0000
Subject: Re: [Xen-devel] [PATCH 2/2] Allow kdump with
 crash_kexec_post_notifiers
References: <20160713121950.14969.78606.stgit@hananiah.suse.cz>
 <20160713122000.14969.99963.stgit@hananiah.suse.cz>
From: David Vrabel <david.vrabel@citrix.com>
Message-ID: <578639AE.10500@citrix.com>
Date: Wed, 13 Jul 2016 13:53:02 +0100
MIME-Version: 1.0
In-Reply-To: <20160713122000.14969.99963.stgit@hananiah.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.com>, Juergen Gross <jgross@suse.com>, Josh
 Triplett <josh@joshtriplett.org>, Ingo Molnar <mingo@redhat.com>, Thomas
 Gleixner <tglx@linutronix.de>, Eric Biederman <ebiederm@xmission.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, David Vrabel <david.vrabel@citrix.com>
Cc: "moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>, "maintainer:X86 ARCHITECTURE 32-BIT AND
 64-BIT" <x86@kernel.org>, "open list:KEXEC" <kexec@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>

On 13/07/16 13:20, Petr Tesarik wrote:
> If a crash kernel is loaded, do not crash the running domain. This is
> needed if the kernel is loaded with crash_kexec_post_notifiers, because
> panic notifiers are run before __crash_kexec() in that case, and this
> Xen hook prevents its being called later.

Prioritising the in-kernel kexec image over the hypervisor one seems
sensible behaviour to me.

Reviewed-by: David Vrabel <david.vrabel@citrix.com>

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
