Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp2.provo.novell.com ([137.65.250.81])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNJpP-0006ZU-Jq
 for kexec@lists.infradead.org; Wed, 13 Jul 2016 13:03:52 +0000
Date: Wed, 13 Jul 2016 15:03:22 +0200
From: Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH 1/2] Add a kexec_crash_loaded() function
Message-ID: <20160713150322.45d47ed4@hananiah.suse.cz>
In-Reply-To: <20160713125232.GA32462@x>
References: <20160713121950.14969.78606.stgit@hananiah.suse.cz>
 <20160713121955.14969.69080.stgit@hananiah.suse.cz>
 <20160713125232.GA32462@x>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Juergen Gross <jgross@suse.com>, Andrew Morton <akpm@linux-foundation.org>, "maintainer:X86 ARCHITECTURE 32-BIT AND
 64-BIT" <x86@kernel.org>, "open list:KEXEC" <kexec@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, "moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, David Vrabel <david.vrabel@citrix.com>

On Wed, 13 Jul 2016 05:52:33 -0700
Josh Triplett <josh@joshtriplett.org> wrote:

> On Wed, Jul 13, 2016 at 02:19:55PM +0200, Petr Tesarik wrote:
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -95,6 +95,12 @@ int kexec_should_crash(struct task_struct *p)
> >  	return 0;
> >  }
> >  
> > +int kexec_crash_loaded(void)
> > +{
> > +	return !!kexec_crash_image;
> > +}
> 
> Nit: this function should return bool rather than int, since it
> effectively returns true/false.

I thought about this for a moment. Since the return value should also
be used for the corresponding sysctl, which is an integer, I wasn't
sure if bool is the correct type, especially since other boolean
functions in kexec.h also return int... But that could be legacy.

I've got no problem changing the type to 'bool' if that's what it takes.

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
