Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BB1C3600A
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 15:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2phGq1PASew3t0QitT+lz7mcsTOMpz4L7ee8QirsuZU=; b=V3XiIHZWmUjHhNBl82nLAkT88r
	7K1tLYyHB6jY4ZZFYa5rwjAeyoRrAGB9XzJljiq3kFNVEVD28wrBtvImUgq8yqyGAJDAwR9ThxEuB
	BiT3sGuwPvKE8lAokwxoYRWqfA+r/IY6Hm4FAYsdyqTaBlJJUIl2GPKITFUkiY728n9QI9INhTNiM
	jk+d/mUSHIjSTsUYeCx2DA6IdRwKTqGt1lTd4iONduL3Ar889d3SWIG4Q19CMfEY3AUGsWWs77Mp0
	mRcKpsw1KcbGMMnce5HG3dj7p/9JfPicLWaWiXcQyHmnmdQMP0jMn77TeXx8A9KRRqdzbjEei4LmM
	AS8ftPeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHRx-0000000CTyV-1DFY;
	Thu, 20 Mar 2025 15:04:49 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tl9f7-00000001w6p-3Vvd;
	Thu, 20 Feb 2025 16:44:34 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KBld33001689;
	Thu, 20 Feb 2025 16:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2phGq1PASew3t0QitT+lz7mcsTOMpz
	4L7ee8QirsuZU=; b=Fg2ZdEdZwarsWS57pS+/6IXcUxTrTtCLnhG9CBGZ/7HGWi
	4zAWb3M539K8KPS0Ajmb/PEzTqkGG38Ai+zL1gYVY4anEms/XTxHY28EJ4xlx/AF
	IUn+cXfqtcI5hv4hzHC4AL7ugPq0hKMuYbyTtcKHIbdd6lb7tMPr95gbVbiNVJH+
	yzBsnvN0hGYuWJxvHvbXddPIPPhMLHzGJxo+0NEWCwpR/A6b6JLE7YAgE1qftFmU
	X8qdol1P5giI4dqT57n6qb3N89dOmr8ZV58kAi7tkbB+YnfIhyNfQnGQOLkoz4M2
	sXSo3k/o/GFXMpo2IP6vEkxcgwZaMd1wbjpTThkQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wtfa4552-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 16:43:55 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51KGhsmH028733;
	Thu, 20 Feb 2025 16:43:54 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wtfa454x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 16:43:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KF7PST027113;
	Thu, 20 Feb 2025 16:43:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w025b1sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 16:43:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KGhnA118088388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 16:43:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8F0820043;
	Thu, 20 Feb 2025 16:43:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4888520040;
	Thu, 20 Feb 2025 16:43:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 20 Feb 2025 16:43:49 +0000 (GMT)
Date: Thu, 20 Feb 2025 17:43:48 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Dave Young <dyoung@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>, Ingo Molnar <mingo@redhat.com>,
        James Gowans <jgowans@amazon.com>, Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pratyush Yadav <ptyadav@amazon.de>, Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
        Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Usama Arif <usama.arif@bytedance.com>, Will Deacon <will@kernel.org>,
        devicetree@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, Philipp Rudo <prudo@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
Message-ID: <Z7dbxJNxlW2EA_aa@tuxmaker.boeblingen.de.ibm.com>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <CALu+AoRMQyRDFS_4L0KQkmrFT_S+yk=uZ-Mqt86JQYKKnj-5Ug@mail.gmail.com>
 <Z7WJD6eBLuIRnLwk@kernel.org>
 <CALu+AoSaEthfed1NOYPiQgm_g-dhibVMRAp0+=_+9qTT4_x=tg@mail.gmail.com>
 <d8c43707-65a2-4176-85e2-acdb4c9d16ad@amazon.com>
 <CALu+AoR0BbmbZeOkLU55OpD8kxGsVnFs+pXgEC9Y_MpB4=GMvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALu+AoR0BbmbZeOkLU55OpD8kxGsVnFs+pXgEC9Y_MpB4=GMvQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 02CmlzRAvH6gUhNjDul_d5grRXN4j5Cf
X-Proofpoint-GUID: vqtrf0KyRdj5sNl93G5J7u-LcnzQFqNz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=660
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200116
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_084433_876924_660B71FD 
X-CRM114-Status: GOOD (  33.07  )
X-Mailman-Approved-At: Thu, 20 Mar 2025 08:04:44 -0700
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

On Thu, Feb 20, 2025 at 09:49:52AM +0800, Dave Young wrote:
> On Wed, 19 Feb 2025 at 21:55, Alexander Graf <graf@amazon.com> wrote:
> > >>> What architecture exactly does this KHO work fine?   Device Tree
> > >>> should be ok on arm*, x86 and power*, but how about s390?
> > >> KHO does not use device tree as the boot protocol, it uses FDT as a data
> > >> structure and adds architecture specific bits to the boot structures to
> > >> point to that data, very similar to how IMA_KEXEC works.
> > >>
> > >> Currently KHO is implemented on arm64 and x86, but there is no fundamental
> > >> reason why it wouldn't work on any architecture that supports kexec.
> > > Well,  the problem is whether there is a way to  add dtb in the early
> > > boot path,  for X86 it is added via setup_data,  if there is no such
> > > way I'm not sure if it is doable especially for passing some info for
> > > early boot use.  Then the KHO will be only for limited use cases.
> >
> >
> > Every architecture has a platform specific way of passing data into the
> > kernel so it can find its command line and initrd. S390x for example has
> > struct parmarea. To enable s390x, you would remove some of its padding
> > and replace it with a KHO base addr + size, so that the new kernel can
> > find the KHO state tree.
> 
> Ok, thanks for the info,  I cced s390 people maybe they can provide inputs.

If I understand correctly, the parmarea would be used for passing the
FDT address - which appears to be fine. However, s390 does not implement
early_memremap()/early_memunmap(), which KHO needs.

Thanks, Dave!

