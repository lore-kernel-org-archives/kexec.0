Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QvT8t-0004k2-BK
	for kexec@lists.infradead.org; Mon, 22 Aug 2011 11:58:12 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id p7MBpWSD006101
	for <kexec@lists.infradead.org>; Mon, 22 Aug 2011 21:51:32 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7MBulQu1257696
	for <kexec@lists.infradead.org>; Mon, 22 Aug 2011 21:56:47 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7MBw0rm003543
	for <kexec@lists.infradead.org>; Mon, 22 Aug 2011 21:58:01 +1000
Date: Mon, 22 Aug 2011 17:27:58 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 7/8] makedumpfile: Add erased information in
	compressed kdump file
Message-ID: <20110822115757.GA23157@in.ibm.com>
References: <20110517200608.12740.68790.stgit@mars.in.ibm.com>
	<20110819151659.6cfd324b.oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110819151659.6cfd324b.oomichi@mxs.nes.nec.co.jp>
Reply-To: mahesh@linux.vnet.ibm.com
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>

On 2011-08-19 15:16:59 Fri, Ken'ichi Ohmichi wrote:
> 
> Hi Mahesh,
> 
> Sorry about many responses of this patch.
> 
> On Wed, 18 May 2011 01:36:17 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> >
> > From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > 
> > Include the erase information in the makedumpfile generated dumpfile. The
> > erased information contains only effective lines from the filter
> > configuration file. This patch supports inclusion of erase information in
> > kdump compressed, flatten and split dumpfiles. On re-filtering, the erase
> > information from input dumpfile (if any) will be carried over to resulting
> > dumpfile.
> > 
> > This patch introduces new members offset_eraseinfo, size_eraseinfo into the
> > sub header in compressed kdump file.
> > 
> > The erased information would contain *multiple* erased symbol names.
> > For example, the following is based on your above example.
> > 
> > 	struct S1 {
> > 		int a;
> > 		int b;
> > 		int c;
> > 	};
> > 	struct S2 {
> > 		struct S1 *mystruct1;
> > 		struct S1 *mystruct2;
> > 	};
> > 
> > 	struct S2 mystruct2;
> > 
> > 	#Filter command
> > 	erase mystruct2.mystruct1.a
> > 	erase mystruct2.mystruct1.c
> > 	erase mystruct2.mystruct2.b
> > 
> > 	#The erased information
> > 	erase mystruct2.mystruct1.a 4
> > 	erase mystruct2.mystruct1.c 4
> > 	erase mystruct2.mystruct2.b 4
> 
> While testing this feature, I noticed the description format of
> makedumpfile.conf is different from the one of eraseinfo.
> The former contains "size", but the later does not.
> 
> Are there any reasons of different formats ?

There is no specific reason, since it is just an information I thought we
can follow a simple format.

> I feel the same format will be useful.

Sure, will make the change.

Thanks,
-Mahesh.

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

-- 
Mahesh J Salgaonkar

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
