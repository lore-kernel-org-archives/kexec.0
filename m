Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F049E77199
	for <kexec@archiver.kernel.org>; Wed,  8 Jan 2025 12:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r51rzpkQRIaDuYN5m2napHEaWvqxm7bLsc8aVa3GJ6A=; b=otiMf1PbIRdErrQLs7CLxGH3hW
	6tYkcoFFhv9W1vtVXpSvKEf6sR+7kZNeiPzXfcX7GEo3YFPCoiMIwqlICro+WzDLyoZRmsZ+enP+j
	PezjVuLupySez6ko+7B0ZMcfutQdLgtqY7DYZuc2bacXJ7PBLA5HNpt0IM2ufa2XBzbj6kqecl5hj
	qbXvVwy++FYIEj7IR9sZcaMQ8onRhSHgPXLs/r8uc4MJJrI2Mgnk4XCTqXCPre/MZ+GCCPX8oqPMO
	poxjlN+vhHS3YKsvVKNkuSvOEkT7i3EtKAFrM1hxTQO7W5BlWL1kxAskhrJaG2NR5O0g/oHI2HLHn
	7i+flDhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVVds-00000008WTb-3Roz;
	Wed, 08 Jan 2025 12:58:36 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVUtk-00000008MtB-0Akh
	for kexec@lists.infradead.org;
	Wed, 08 Jan 2025 12:10:57 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50886DsG022826;
	Wed, 8 Jan 2025 12:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=r51rzpkQRIaDuYN5m2napHEaWvqxm7
	bLsc8aVa3GJ6A=; b=a3mhkps8NcJSJ7brUUW2LjGlaaiDXS/SeW445rQPrcg//4
	mzRgfxNjB73jcFwlhy/pOTaQFup5wPf7FLeguOvtiJkmbQ73kUDtGy6mvS/l20l2
	SpAONktG0AljeG72A/bwh3DvxqdsqbgZiE4Ds7kLFO3DZ1cXHPsKjzp72zIQbB/b
	p5t1VjXN4CvGCmKdiDRQDyFYFMkl3rXt1zUfrb23gadfFF7fp2PLC7Um50t3t9Ik
	StEyZHIIri2/+Cuw808QTealaF+fIfjuOhKMw6Jvl6SC9yqBhqG5cK0FAl4VY8fu
	mKqOcZ+hGNDNFvysudC2kNFZ9JTwj4wyAohtCPXg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441nj393bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 12:10:50 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 508BoOkW013439;
	Wed, 8 Jan 2025 12:10:50 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441nj393bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 12:10:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5089cDI0015805;
	Wed, 8 Jan 2025 12:10:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygtkygy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 12:10:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 508CAjgN49873158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 12:10:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E2882004B;
	Wed,  8 Jan 2025 12:10:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAEEA20043;
	Wed,  8 Jan 2025 12:10:44 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Jan 2025 12:10:44 +0000 (GMT)
Date: Wed, 8 Jan 2025 13:10:43 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        virtualization@lists.linux.dev, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Thomas Huth <thuth@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 00/12] fs/proc/vmcore: kdump support for virtio-mem on
 s390
Message-ID: <20250108121043.7704-I-hca@linux.ibm.com>
References: <20241204125444.1734652-1-david@redhat.com>
 <20250108070407-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108070407-mutt-send-email-mst@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rwRjGyiOCqOBLv_v9BGL6q74O-HSoqwn
X-Proofpoint-GUID: PmVcktqpx1H2mp0ezMbm_qIXZXexrl8-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 clxscore=1011 adultscore=0 impostorscore=0 mlxlogscore=699 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_041056_196782_2F0CFEB6 
X-CRM114-Status: GOOD (  31.79  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Jan 08, 2025 at 07:04:23AM -0500, Michael S. Tsirkin wrote:
> On Wed, Dec 04, 2024 at 01:54:31PM +0100, David Hildenbrand wrote:
> > The only "different than everything else" thing about virtio-mem on s390
> > is kdump: The crash (2nd) kernel allocates+prepares the elfcore hdr
> > during fs_init()->vmcore_init()->elfcorehdr_alloc(). Consequently, the
> > kdump kernel must detect memory ranges of the crashed kernel to
> > include via PT_LOAD in the vmcore.
> > 
> > On other architectures, all RAM regions (boot + hotplugged) can easily be
> > observed on the old (to crash) kernel (e.g., using /proc/iomem) to create
> > the elfcore hdr.
> > 
> > On s390, information about "ordinary" memory (heh, "storage") can be
> > obtained by querying the hypervisor/ultravisor via SCLP/diag260, and
> > that information is stored early during boot in the "physmem" memblock
> > data structure.
> > 
> > But virtio-mem memory is always detected by as device driver, which is
> > usually build as a module. So in the crash kernel, this memory can only be
> > properly detected once the virtio-mem driver started up.
> > 
> > The virtio-mem driver already supports the "kdump mode", where it won't
> > hotplug any memory but instead queries the device to implement the
> > pfn_is_ram() callback, to avoid reading unplugged memory holes when reading
> > the vmcore.
> > 
> > With this series, if the virtio-mem driver is included in the kdump
> > initrd -- which dracut already takes care of under Fedora/RHEL -- it will
> > now detect the device RAM ranges on s390 once it probes the devices, to add
> > them to the vmcore using the same callback mechanism we already have for
> > pfn_is_ram().
> > 
> > To add these device RAM ranges to the vmcore ("patch the vmcore"), we will
> > add new PT_LOAD entries that describe these memory ranges, and update
> > all offsets vmcore size so it is all consistent.
> > 
> > My testing when creating+analyzing crash dumps with hotplugged virtio-mem
> > memory (incl. holes) did not reveal any surprises.
> > 
> > Patch #1 -- #7 are vmcore preparations and cleanups
> > Patch #8 adds the infrastructure for drivers to report device RAM
> > Patch #9 + #10 are virtio-mem preparations
> > Patch #11 implements virtio-mem support to report device RAM
> > Patch #12 activates it for s390, implementing a new function to fill
> >           PT_LOAD entry for device RAM
> 
> Who is merging this?
> virtio parts:
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

I guess this series should go via Andrew Morton. Andrew?

Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390

