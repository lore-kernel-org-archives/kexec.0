Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149AFC25B75
	for <kexec@archiver.kernel.org>; Mon,  3 Jun 2024 14:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9HQegbBq+/eAd18mzrDOh6wquqkrIjo6s4Jx7VFoLx8=; b=yhdJQNJqfRFiyk
	NSLZoFaoU1xVW18u0E157P6FS+dHgr3gEHyXm0IwJcm3EMb0BkLA4L0IYp5jg1VXoqhppEhUA6zdL
	etLmRu+oibRHqugx1yYB243JPTequtPzrYbYa5158P4KPqvoKuQysU839inbVy7TUSGlMcWGWz7hJ
	Oh567w/XMFDz6HGjUAVFen5m9xgzWXBjZNFBcoLEHLtNhktlWv8wljTZvG1hpo6lMkvkXWuzue25e
	Am5ywhNJodvw1O2XEiPIM8XVwmvsKDeKUbKWSnnfWZ9hpOAUEjbSBaT9xGFz/GLygj0xkcYjCTwXo
	wjq+fXpWZvgXwJey1Abg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE8y9-0000000H8a0-3Dj5;
	Mon, 03 Jun 2024 14:47:29 +0000
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE8y7-0000000H8Z1-0HUw
	for kexec@lists.infradead.org;
	Mon, 03 Jun 2024 14:47:28 +0000
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45392knG015151;
	Mon, 3 Jun 2024 14:46:37 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Dhpe.com;_h=3Dcc?=
 =?UTF-8?Q?:content-type:date:from:in-reply-to:message-id:mime-version:ref?=
 =?UTF-8?Q?erences:subject:to;_s=3Dpps0720;_bh=3DNmDlpuCKXf+fQPySad2+w7jdj?=
 =?UTF-8?Q?lccBZGAG9LaOBq8sig=3D;_b=3DosvRC+romGvPNw2d8ZPGJm0bk9cW8W6eJTpv?=
 =?UTF-8?Q?FkQUZhNHBul2BiCoHIi2BVsgGG6FSv9B_jug224d1D5H7KkOkUYcvKUp2hfRS5p?=
 =?UTF-8?Q?24PZDF/oPvx6F2M3JtqBkJWcFx3GSlOTrr137r_znk8H9ZP1nV9ptXRfLw9J8r2?=
 =?UTF-8?Q?vWgeqXp5mcmjh9ylw2X3LV9KZlzxNWZwcavnYEQs+tMY_mKbHthov+ZecfWAO5J?=
 =?UTF-8?Q?4k++pQR6c0GMQGhsqL9FkesDxSH1go8iQWF2SDth5huSq5GY4k_uHLMwqMKs49C?=
 =?UTF-8?Q?myWoyvPKXs640gF+sxgHyYA3+u2uaTOcXBH6cnCkgqJ4psvZwXHxyO21_ng=3D?=
 =?UTF-8?Q?=3D_?=
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3ygd93aby9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 14:46:37 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id F40AA14786;
	Mon,  3 Jun 2024 14:46:35 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 01F6780170C;
	Mon,  3 Jun 2024 14:46:31 +0000 (UTC)
Date: Mon, 3 Jun 2024 09:46:07 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Dave Young <dyoung@redhat.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Pavin Joseph <me@pavinjoseph.com>, Eric Hagberg <ehagberg@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Eric Biederman <ebiederm@xmission.com>, Sarah Brofeldt <srhb@dbc.dk>,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>, Michael Roth <michael.roth@amd.com>,
        Tao Liu <ltao@redhat.com>, kexec@lists.infradead.org
Subject: Re: [PATCH 0/3] Resolve problems with kexec identity mapping
Message-ID: <20240603144607.GA919612@dog.eag.rdlabs.hpecorp.net>
References: <20240520183633.1457687-1-steve.wahl@hpe.com>
 <CALu+AoQGvHzkoRPvAwqaCCokOBsjQ7tDwMVwgyOMUqKm=tEkuQ@mail.gmail.com>
 <CALu+AoR_OZbrrVWL_2EbDB-ctSR28+006q+nHhwgZ55QhK0qSw@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CALu+AoR_OZbrrVWL_2EbDB-ctSR28+006q+nHhwgZ55QhK0qSw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-GUID: X-I2ZXp4pRs7QeN3vWlXArNg9xrmUX1T
X-Proofpoint-ORIG-GUID: X-I2ZXp4pRs7QeN3vWlXArNg9xrmUX1T
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_11,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406030122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_074727_121154_FF677CCA 
X-CRM114-Status: GOOD (  48.68  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Gentle ping.  Can someone give me some feedback, please?  

Thanks,

Steve Wahl, HPE.

On Thu, May 23, 2024 at 10:54:33AM +0800, Dave Young wrote:
> Cc kexec list as well.
> 
> On Thu, 23 May 2024 at 10:52, Dave Young <dyoung@redhat.com> wrote:
> >
> > Add Tao in the cc list.
> >
> > On Tue, 21 May 2024 at 02:37, Steve Wahl <steve.wahl@hpe.com> wrote:
> > >
> > > Although there was a previous fix to avoid early kernel access to the
> > > EFI config table on Intel systems, the problem can still exist on AMD
> > > systems that support SEV (Secure Encrypted Virtualization).  The
> > > command line option "nogbpages" brings this bug to the surface.  And
> > > this is what caused the regression with my earlier patch that
> > > attempted to reduce the use of gbpages.  This patch series fixes that
> > > problem and restores my earlier patch.
> > >
> > > The following 2 commits caused the EFI config table, and the CC_BLOB
> > > entry in that table, to be accessed when enabling SEV at kernel
> > > startup.
> > >
> > >     commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
> > >                           earlier during boot")
> > >     commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
> > >                           detection/setup")
> > >
> > > These accesses happen before the new kernel establishes its own
> > > identity map, and before establishing a routine to handle page faults.
> > > But the areas referenced are not explicitly added to the kexec
> > > identity map.
> > >
> > > This goes unnoticed when these areas happen to be placed close enough
> > > to others areas that are explicitly added to the identity map, but
> > > that is not always the case.
> > >
> > > Under certain conditions, for example Intel Atom processors that don't
> > > support 1GB pages, it was found that these areas don't end up mapped,
> > > and the SEV initialization code causes an unrecoverable page fault,
> > > and the kexec fails.
> > >
> > > Tau Liu had offered a patch to put the config table into the kexec
> > > identity map to avoid this problem:
> > >
> > > https://lore.kernel.org/all/20230601072043.24439-1-ltao@redhat.com/
> > >
> > > But the community chose instead to avoid referencing this memory on
> > > non-AMD systems where the problem was reported.
> > >
> > >     commit bee6cf1a80b5 ("x86/sev: Do not try to parse for the CC blob
> > >                           on non-AMD hardware")
> > >
> > > I later wanted to make a different change to kexec identity map
> > > creation, and had this patch accepted:
> > >
> > >     commit d794734c9bbf ("x86/mm/ident_map: Use gbpages only where full GB page should be mapped.")
> > >
> > > but it quickly needed to be reverted because of problems on AMD systems.
> > >
> > > The reported regression problems on AMD systems were due to the above
> > > mentioned references to the EFI config table.  In fact, on the same
> > > systems, the "nogbpages" command line option breaks kexec as well.
> > >
> > > So I resubmit Tau Liu's original patch that maps the EFI config
> > > table, add an additional patch by me that ensures that the CC blob is
> > > also mapped (if present), and also resubmit my earlier patch to use
> > > gpbages only when a full GB of space is requested to be mapped.
> > >
> > > I do not advocate for removing the earlier, non-AMD fix.  With kexec,
> > > two different kernel versions can be in play, and the earlier fix
> > > still covers non-AMD systems when the kexec'd-from kernel doesn't have
> > > these patches applied.
> > >
> > > All three of the people who reported regression with my earlier patch
> > > have retested with this patch series and found it to work where my
> > > single patch previously did not.  With current kernels, all fail to
> > > kexec when "nogbpages" is on the command line, but all succeed with
> > > "nogbpages" after the series is applied.
> > >
> > > Tao Liu (1):
> > >   x86/kexec: Add EFI config table identity mapping for kexec kernel
> > >
> > > Steve Wahl (2):
> > >   x86/kexec: Add EFI Confidential Computing blob to kexec identity
> > >     mapping.
> > >   x86/mm/ident_map: Use gbpages only where full GB page should be
> > >     mapped.
> > >
> > >  arch/x86/kernel/machine_kexec_64.c | 82 ++++++++++++++++++++++++++++--
> > >  arch/x86/mm/ident_map.c            | 23 +++++++--
> > >  2 files changed, 95 insertions(+), 10 deletions(-)
> > >
> > > --
> > > 2.26.2
> > >
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
