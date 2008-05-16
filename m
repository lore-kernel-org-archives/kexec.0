Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JwpFf-0007xK-9Z
	for kexec@lists.infradead.org; Fri, 16 May 2008 02:00:56 +0000
Date: Thu, 15 May 2008 22:00:43 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kexec based hibernation: a prototype of kexec
	multi-stage load
Message-ID: <20080516020043.GC6926@redhat.com>
References: <1210574441.30365.8.camel@caritas-dev.intel.com>
	<20080513053408.GA5870@redhat.com>
	<1210730266.23707.50.camel@caritas-dev.intel.com>
	<20080514025607.GA19944@redhat.com>
	<1210736275.23707.62.camel@caritas-dev.intel.com>
	<m1lk2c4l4i.fsf@frodo.ebiederm.org>
	<1210827473.23707.133.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1210827473.23707.133.camel@caritas-dev.intel.com>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>

On Thu, May 15, 2008 at 12:57:53PM +0800, Huang, Ying wrote:
> On Wed, 2008-05-14 at 14:43 -0700, Eric W. Biederman wrote:
> [...]
> > Then as a preliminary design let's plan on this.
> > 
> > - Pass the rentry point as the return address (using the C ABI).
> >   We may want to load the stack pointer etc so we can act as
> >   a direct entry point for new code.
> 
> There are some issues about passing entry point as return address. The
> kexec jump (or kexec with return) is used for
> 
> - Switching between original kernel (A) and kexeced kernel (B)
> - Call some code (such as BIOS code) in physical mode
> 
> 1) When call some code in physical mode, the called code can use a
> simple return to return to kernel A. So there is no return address on
> stack after return to kernel A. Instead, argument 1 is on stack top.
> 
> 2) When switch back from kernel B to kernel A, kernel B will call the
> jump back entry of kernel A with C ABI. So, the return address is on
> stack top. And kernel A get jump back entry of kernel B via the return
> address.
> 
> Because the stack state is different between 1) and 2), the jump back
> entry of kernel A should distinguish them. Possible solution can be as
> follow:
> 
> a) Before kernel A call some physical mode code or kernel B, it set
> argument 1 to be a magic number that can not be return address (such as
> -1). Jump back entry of kernel A can check whether the stack top is
> argument 1 or return address.
> 
> b) Distinguish by return address. Such as, called physical mode code
> must return 0, while kernel B must set %eax to some other number.
> 

IMHO, this kind of make more sense to me when keeping C function like
semantics in mind.

Both the cases can be treated like calls to functions (calling BIOS function
and jumping to kernel B). The basic difference between two cases is the
re-entry point. In BIOS function case, we always re-enter the function at the
start but in case of kernel B, except first entry, all other entries happen
at a run time determined address, which needs to be communicated to kernel A.

I would think that second kernel B just should execute "ret" and new entry
address of kernel B is passed to kernel A through %eax (return value of
function).

Not sure if BIOS routines can always return a fix code so that we can
differentiate between two cases.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
