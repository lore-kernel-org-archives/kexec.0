Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Lvt61-0004dm-8O
	for kexec@lists.infradead.org; Mon, 20 Apr 2009 12:59:44 +0000
Date: Mon, 20 Apr 2009 08:59:28 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <474287444.42861240232368767.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1214523746.42431240232120653.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
Subject: Re: makedumpfile question / request
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec-ml <kexec@lists.infradead.org>, "Discussion list for crash utility usage,
	maintenance and development" <crash-utility@redhat.com>


----- "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp> wrote:

> Hi Dave,
> 
> Dave Anderson wrote:
> > Is there a reason that makedumpfile does not fill in the utsname structure
> > in the compressed dumpfile's header?  
> 
> Thank you for good point.
> 
> makedumpfile does not fill it because makedumpfile might not be able to
> get kernel debug information (containing symbol system_utsname/init_uts_ns).
> makedumpfile does not need kernel debug information if dump_level is 0 or 1,
> and it does not read a new_utsname structure. (check_release() is not called.)
> 
> 
> > The data structure does get read into a local new_utsname structure in the
> > check_release() function, but it doesn't get saved and copied into the
> > disk_dump_header in write_kdump_header().
> >
> > It would be helpful if that were in place as a quick ID for what the
> > compressed dumpfile contains.
> 
> I feel that is worth.
> How about saving new_utsname data into disk_dump_header only if dump_level
> is 2 or bigger ?

Well, that's certainly preferable than the way it is now.

But let me ask you this...

Given that the init_uts_ns structure is always located in:

(1) unity-mapped memory, or in a mapped kernel region for x86_64/ia64, and
(2) that your initial() function calls get_phys_base() in all cases,

can't you just strip the relevant unity-mapping from the supplied 
VMCOREINFO/init_uts_ns symbol value, apply the phys_base, and then
read it from the vmcore file?

Dave



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
