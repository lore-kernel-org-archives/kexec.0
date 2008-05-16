Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga03.intel.com ([143.182.124.21])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JwpRs-00013v-Sz
	for kexec@lists.infradead.org; Fri, 16 May 2008 02:13:33 +0000
Subject: Re: [PATCH] kexec based hibernation: a prototype of kexec
	multi-stage load
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <20080516020043.GC6926@redhat.com>
References: <1210574441.30365.8.camel@caritas-dev.intel.com>
	<20080513053408.GA5870@redhat.com>
	<1210730266.23707.50.camel@caritas-dev.intel.com>
	<20080514025607.GA19944@redhat.com>
	<1210736275.23707.62.camel@caritas-dev.intel.com>
	<m1lk2c4l4i.fsf@frodo.ebiederm.org>
	<1210827473.23707.133.camel@caritas-dev.intel.com>
	<20080516020043.GC6926@redhat.com>
Date: Fri, 16 May 2008 10:19:34 +0800
Message-ID: <1210904374.23707.178.camel@caritas-dev.intel.com>
MIME-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>

On Thu, 2008-05-15 at 22:00 -0400, Vivek Goyal wrote:
[...]
> IMHO, this kind of make more sense to me when keeping C function like
> semantics in mind.
> 
> Both the cases can be treated like calls to functions (calling BIOS function
> and jumping to kernel B). The basic difference between two cases is the
> re-entry point. In BIOS function case, we always re-enter the function at the
> start but in case of kernel B, except first entry, all other entries happen
> at a run time determined address, which needs to be communicated to kernel A.
> 
> I would think that second kernel B just should execute "ret" and new entry
> address of kernel B is passed to kernel A through %eax (return value of
> function).

The disadvantage of this solution is that kernel B must know it is
original kernel (A) or kexeced kernel (B). Different code should be used
by kernel A and kernel B. And after jump from A to B, jump from B to A,
when jump from A to B again, kernel A must use different code from the
first time.

Best Regards,
Huang Ying


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
