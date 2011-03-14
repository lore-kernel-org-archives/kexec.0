Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PzCGl-0002X3-0o
	for kexec@lists.infradead.org; Mon, 14 Mar 2011 18:13:28 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp05.in.ibm.com (8.14.4/8.13.1) with ESMTP id p2EIDJ5i030575
	for <kexec@lists.infradead.org>; Mon, 14 Mar 2011 23:43:19 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p2EIDJP41749242
	for <kexec@lists.infradead.org>; Mon, 14 Mar 2011 23:43:19 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p2EIDJ4s006104
	for <kexec@lists.infradead.org>; Tue, 15 Mar 2011 05:13:19 +1100
Date: Mon, 14 Mar 2011 23:43:15 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] kdump: Allow shrinking of kdump region to be
	overridden
Message-ID: <20110314181315.GA16075@in.ibm.com>
References: <20100825002258.GD28360@kryten> <m139u37cii.fsf@fess.ebiederm.org>
	<4D771EE6.5050404@linux.vnet.ibm.com>
	<20110309122046.GC16951@cr0.redhat.com>
	<20110309234657.264d3080@kryten>
	<20110309142108.GD16951@cr0.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110309142108.GD16951@cr0.redhat.com>
Reply-To: mahesh@linux.vnet.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: =?iso-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, "Eric W. Biederman" <ebiederm@xmission.com>, akpm@linux-foundation.org, Anton Blanchard <anton@samba.org>

On Wed, Mar 09, 2011 at 10:21:08PM +0800, Am=E9rico Wang wrote:
> On Wed, Mar 09, 2011 at 11:46:57PM +1100, Anton Blanchard wrote:
> >
> >Hi,
> >
> >> The crashkernel region is specified via kernel cmdline, so why
> >> not just drop a failure when it overlaps with RMO region?
> >> Am I missing something?
> >
> >Unfortunately a ppc64 kernel requires a chunk of RMO memory. We would
> >need the ability to specify multiple crashkernel regions - about 32MB
> >in the RMO and the rest can be anywhere. That sounds pretty fragile for
> >a user to configure successfully on the cmdline.
> >
> >Thats why the ppc64 crashkernel region begins mid way through the RMO
> >region. It means both kernels get a chunk of RMO and we only have to
> >deal with one crashkernel reservation in all the tools and
> >documentation.
> >
> =

> So, when I specify 128M in cmdline, 32M of them are RMO, and the
> rest 96M are normal memory? And when I want to free all of them,
> actually the 32M RMO will never be freed?

In ppc64 implementation the crashkernel region begins mid way through
the RMO and spans across into the normal memory. For e.g. on power system
with 128M RMO size, when user specifies 128M in cmdline, the crashkernel
starts from default offset 64M through 192M. Which means 64M in RMO region
and rest beyond RMO.

 <-------------------RMO--------------->
                             <---rtas-->
0                    64M               128M                     End
|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
           Crash_start|<------------128M----------->| Crash End

During free we do free all of them including RMO region. But since the rtas
region is always on top of RMO, crashkernel memory overlaps rtas region and
we endup freeing that even, which is causing the crash.

> =

> =

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

-- =

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
