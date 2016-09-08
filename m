Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bi1B3-0001If-3k
 for kexec@lists.infradead.org; Thu, 08 Sep 2016 15:23:46 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u88FMa8c136948
 for <kexec@lists.infradead.org>; Thu, 8 Sep 2016 11:23:21 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25ataym051-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 08 Sep 2016 11:23:20 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 8 Sep 2016 12:23:18 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: Kexec regression in next-20160906
Date: Thu, 08 Sep 2016 12:23:13 -0300
In-Reply-To: <20160907080807.GD5783@n2100.arm.linux.org.uk>
References: <20160906220936.4txqzodkgknhjiyh@atomide.com>
 <2229914.bQjEFCIRgO@hactar> <20160907080807.GD5783@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Message-Id: <8729269.3rIvqbaU1r@hactar>
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
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, linux-ima-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org

Am Mittwoch, 07 September 2016, 09:08:07 schrieb Russell King - ARM Linux:
> Any change to a UAPI header needs to be carefully considered and
> questioned as it is always a potential userspace breakage - and in
> the kernel, we're supposed to be doing our up-most to avoid
> breaking userspace.
> 
> It's not like it was in the old days when we didn't have the UAPI
> seperate - today, we can find these things by looking at the patch
> diffstat and seeing whether any file in "uapi" is touched.  That
> should be the trigger for a really in-depth review of the change.

No UAPI header is touched by this patch series. That is because there are 
two definitions of struct kexec_segment, one in include/linux/kexec.h and 
the other one in include/uapi/linux/kexec.h. My patch changed the former.
I was unaware of the second definition in the latter.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
