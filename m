Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bQOjI-00028j-CR
 for kexec@lists.infradead.org; Fri, 22 Jul 2016 00:54:17 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6M0rr6T064429
 for <kexec@lists.infradead.org>; Thu, 21 Jul 2016 20:53:55 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24atwte1yb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 21 Jul 2016 20:53:54 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <jeremy.kerr@au1.ibm.com>;
 Fri, 22 Jul 2016 10:53:48 +1000
Subject: Re: [RFC 0/3] extend kexec_file_load system call
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <3489461.zQnV5C1bXR@wuerfel> <1808359.GMbkTHC4O6@hactar>
 <4197460.etrDupniY8@hactar>
From: Jeremy Kerr <jeremy.kerr@au1.ibm.com>
Date: Fri, 22 Jul 2016 08:53:41 +0800
MIME-Version: 1.0
In-Reply-To: <4197460.etrDupniY8@hactar>
Message-Id: <7619c6f9-689e-f062-08d4-0d11a2df66ad@au.ibm.com>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Stewart Smith <stewart@linux.vnet.ibm.com>, bhe@redhat.com, linuxppc-dev@lists.ozlabs.org, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Russell King - ARM Linux <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Michael Ellerman <michael@ellerman.id.au>, AKASHI Takahiro <takahiro.akashi@linaro.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, linux-arm-kernel@lists.infradead.org

Hi Thiago,

> So even if not ideal, the solution above is desirable for powerpc. We would 
> like to preserve the ability of allowing userspace to pass parameters to the 
> OS via the DTB, even if secure boot is enabled.
> 
> I would like to turn the above into a proposal:
> 
> Extend the syscall as shown in this RFC from Takahiro AKASHI, but instead of 
> accepting a complete DTB from userspace, the syscall accepts a DTB 
> containing only a /chosen node. If the DTB contains any other node, the 
> syscall fails with EINVAL. If the DTB contains any subnode in /chosen, or if 
> there's a compatible or device_type property in /chosen, the syscall fails 
> with EINVAL as well.

This works for me. We could even have it as just a DTB fragment that is
merged *at* the /chosen/ node of the kernel-device tree - so would not
contain a /chosen node itself, and it would be impossible to provide
nodes outside of /chosen. Either is fine.

Thanks!


Jeremy


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
