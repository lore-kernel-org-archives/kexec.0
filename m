Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eqGm3-0002ek-7T
 for kexec@lists.infradead.org; Mon, 26 Feb 2018 11:16:55 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1QBDlFk117373
 for <kexec@lists.infradead.org>; Mon, 26 Feb 2018 06:16:36 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gch3y89nc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 26 Feb 2018 06:16:35 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.vnet.ibm.com>;
 Mon, 26 Feb 2018 11:16:34 -0000
Date: Mon, 26 Feb 2018 12:16:28 +0100
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/17] Add kexec_file_load support to s390
In-Reply-To: <20180226012100.GA6019@linaro.org>
References: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
 <20180214073543.GA12328@dhcp-128-65.nay.redhat.com>
 <20180214105449.1325bfbe@ThinkPad>
 <20180223083405.GA29498@dhcp-128-65.nay.redhat.com>
 <20180223110143.1747fb3f@ThinkPad>
 <20180224015956.GA11191@dhcp-128-65.nay.redhat.com>
 <20180226012100.GA6019@linaro.org>
MIME-Version: 1.0
Message-Id: <20180226121628.5e832adf@ThinkPad>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Hi Dave
Hi AKASHI

On Mon, 26 Feb 2018 10:21:02 +0900
AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:

> > 
> > Arch code need arch maintainer to review, maybe either of you can send
> > the common part first before the arch code, eg. AKASHI can split the common
> >  cleanup patches and post them as a separate series, after these prep
> > series are reviewed then other patches can be refreshed based on it.
> > 
> > Seems in AKASHI's series, only patch 2, 3 ,4 ,5 is needed if split out
> > as a common change series.  
> 
> Yeah, all of those are touching kernel/kexec_file.c and in turn
> they can conflict if being applied with 390 patches, but none of changes
> that I made on kexec_file.c are overlapped with Phillips', I suppose
> that merging these two patch sets is rather straightforward.
> 
> @Phillips: I hope that your patch#14 and #17 be aligned with my patch#3
> as it is factoring out arch_kexec_{image_probe, image_load, verify_sig}()
> and arch_kimage_file_post_load_cleanup().

Splitting the common code patches from the series is totally fine with me.

On Friday I managed to get my code working with AKASHI's patches. After setting
ARCH_HAS_PURGATORY and cleaning up the kexec_* functions it worked basically out
of the box. However there is one problem with older compilers on s390. Please
see my comment on patch #3 for details.

Thanks
Philipp


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
