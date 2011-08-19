Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QuJcl-0007Fa-E2
	for kexec@lists.infradead.org; Fri, 19 Aug 2011 07:36:16 +0000
Date: Fri, 19 Aug 2011 15:16:59 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v2 7/8] makedumpfile: Add erased information in
	compressed kdump file
Message-Id: <20110819151659.6cfd324b.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110517200608.12740.68790.stgit@mars.in.ibm.com>
References: <20110517200608.12740.68790.stgit@mars.in.ibm.com>
Mime-Version: 1.0
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
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Dave Anderson <anderson@redhat.com>, Reinhard <BUENDGEN@de.ibm.com>, kexec@lists.infradead.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, V Srivatsa <vsrivatsa@in.ibm.com>


Hi Mahesh,

Sorry about many responses of this patch.

On Wed, 18 May 2011 01:36:17 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
>
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> Include the erase information in the makedumpfile generated dumpfile. The
> erased information contains only effective lines from the filter
> configuration file. This patch supports inclusion of erase information in
> kdump compressed, flatten and split dumpfiles. On re-filtering, the erase
> information from input dumpfile (if any) will be carried over to resulting
> dumpfile.
> 
> This patch introduces new members offset_eraseinfo, size_eraseinfo into the
> sub header in compressed kdump file.
> 
> The erased information would contain *multiple* erased symbol names.
> For example, the following is based on your above example.
> 
> 	struct S1 {
> 		int a;
> 		int b;
> 		int c;
> 	};
> 	struct S2 {
> 		struct S1 *mystruct1;
> 		struct S1 *mystruct2;
> 	};
> 
> 	struct S2 mystruct2;
> 
> 	#Filter command
> 	erase mystruct2.mystruct1.a
> 	erase mystruct2.mystruct1.c
> 	erase mystruct2.mystruct2.b
> 
> 	#The erased information
> 	erase mystruct2.mystruct1.a 4
> 	erase mystruct2.mystruct1.c 4
> 	erase mystruct2.mystruct2.b 4

While testing this feature, I noticed the description format of
makedumpfile.conf is different from the one of eraseinfo.
The former contains "size", but the later does not.

I feel the same format will be useful.
Are there any reasons of different formats ?


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
