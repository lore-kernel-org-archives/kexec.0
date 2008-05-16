Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jwqnn-00081T-Nl
	for kexec@lists.infradead.org; Fri, 16 May 2008 03:40:16 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1210574441.30365.8.camel@caritas-dev.intel.com>
	<20080513053408.GA5870@redhat.com>
	<1210730266.23707.50.camel@caritas-dev.intel.com>
	<20080514025607.GA19944@redhat.com>
	<1210736275.23707.62.camel@caritas-dev.intel.com>
	<m1lk2c4l4i.fsf@frodo.ebiederm.org>
	<1210827473.23707.133.camel@caritas-dev.intel.com>
	<m1lk2bs970.fsf@frodo.ebiederm.org>
	<1210902114.23707.156.camel@caritas-dev.intel.com>
	<m14p8zgf43.fsf@frodo.ebiederm.org>
	<1210906575.23707.189.camel@caritas-dev.intel.com>
Date: Thu, 15 May 2008 20:33:41 -0700
In-Reply-To: <1210906575.23707.189.camel@caritas-dev.intel.com> (Ying Huang's
	message of "Fri, 16 May 2008 10:56:15 +0800")
Message-ID: <m1iqxegbxm.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec based hibernation: a prototype of kexec multi-stage
	load
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

"Huang, Ying" <ying.huang@intel.com> writes:


> I think it is reasonable to enable jumping back and forth more than one
> time.

I'm not opposed.  I just don't understand the utility yet.

> So the following should be possible:
>
> 1. Jump from A to B (actually jump to purgatory, trigger the boot of B)
> 2. Jump from B to A
> 3. Jump from A to B again (jump to the kexec_jump_back_entry of B)
                      (And we go through purgatory which remembers
                       the kexec_jump_back_entry of B)
> 4. Jump from B to A
> ...
>
> So it should be possible to get the re-entry point of kernel B in
> kexec_jump_back_entry of kernel A too. So I think in
> kexec_jump_back_entry, the caller's stack should be checked to get
> re-entry point of peer. And the stack state is different depend on where
> come from, from relocate_new_kernel() or return.

Yes.

Any conditional logic needs to be in purgatory or a similar trampoline.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
