Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1LA7fv-0000Jz-Mz
	for kexec@lists.infradead.org; Tue, 09 Dec 2008 18:51:16 +0000
Subject: Re: kdump: quad core Opteron
From: Bob Montgomery <bob.montgomery@hp.com>
In-Reply-To: <200812091742.45275.chandru@in.ibm.com>
References: <48EB5B68.8010401@in.ibm.com>
	<200812082126.16680.chandru@in.ibm.com>
	<20081208215432.GH4264@redhat.com>
	<200812091742.45275.chandru@in.ibm.com>
Date: Tue, 09 Dec 2008 11:55:59 -0700
Message-Id: <1228848959.3428.372.camel@amd.troyhebe>
Mime-Version: 1.0
Reply-To: bob.montgomery@hp.com
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
To: Chandru <chandru@in.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>

On Tue, 2008-12-09 at 12:12 +0000, Chandru wrote:
> On Tuesday 09 December 2008 03:24:32 Vivek Goyal wrote:
> 
> > Hi Chandru,
> >
> > So this patch will solve the issue (at least for /proc/vmcore) even if
> > we don't make any changes on kernel side?
> >
> > Thanks
> > Vivek
> 
> Hi Vivek,
> 
> Yes, without any changes to the kernel and with this patch, we can boot into
> kdump kernel on these quad core Opteron machines and collect a dump.

Provided that the kernel is new enough to have the "Insert GART region
into resource map" already.  Otherwise, you will need to change the
kernel for this to work.

Chandru, thanks for coding this up.

Bob Montgomery


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
