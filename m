Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bVm1Q-0007Mm-Sg
 for kexec@lists.infradead.org; Fri, 05 Aug 2016 20:47:13 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u75KiZ0u002296
 for <kexec@lists.infradead.org>; Fri, 5 Aug 2016 16:46:51 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24mud8pwhh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 05 Aug 2016 16:46:51 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 5 Aug 2016 17:46:49 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/3] kexec: extend kexec_file_load system call
Date: Fri, 05 Aug 2016 17:46:43 -0300
In-Reply-To: <1469579069-28472-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <20160712014201.11456-4-takahiro.akashi@linaro.org>
 <1469579069-28472-1-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-Id: <1988385.QMVjiCbb5e@hactar>
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
To: kexec@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, Stewart Smith <stewart@linux.vnet.ibm.com>, Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Mimi Zohar <zohar@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, Russell King - ARM Linux <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Michael Ellerman <michael@ellerman.id.au>, AKASHI Takahiro <takahiro.akashi@linaro.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, linux-arm-kernel@lists.infradead.org

Hi,

Am Dienstag, 26 Juli 2016, 21:24:29 schrieb Thiago Jung Bauermann:
> Notes:
>     This is a new version of the last patch in this series which adds
>     a function where each architecture can verify if the DTB is safe
>     to load:
> 
>     int __weak arch_kexec_verify_buffer(enum kexec_file_type type,
>                                         const void *buf,
>                                         unsigned long size)
>     {
>             return -EINVAL;
>     }
> 
>     I will then provide an implementation in my powerpc patch series
>     which checks that the DTB only contains nodes and properties from a
>     whitelist. arch_kexec_kernel_image_load will copy these properties
>     to the device tree blob the kernel was booted with (and perform
>     other changes such as setting /chosen/bootargs, of course).

Is this approach ok? If so, I'll post a patch next week adding an 
arch_kexec_verify_buffer hook for powerpc to enforce the whitelist, and also 
a new version of the patches implementing kexec_file_load for powerpc on top 
of this series.

Eric, does this address your concerns?

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
