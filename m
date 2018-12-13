Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXEji-0002ua-1Z
 for kexec@lists.infradead.org; Thu, 13 Dec 2018 00:20:19 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBD0Iapq093721
 for <kexec@lists.infradead.org>; Wed, 12 Dec 2018 19:20:07 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2pbacvdy87-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 12 Dec 2018 19:20:07 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.ibm.com>;
 Thu, 13 Dec 2018 00:20:06 -0000
References: <20181208202705.18673-1-nayna@linux.ibm.com>
 <20181208202705.18673-8-nayna@linux.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v2 7/7] ima: Support platform keyring for kernel appraisal
In-reply-to: <20181208202705.18673-8-nayna@linux.ibm.com>
Date: Wed, 12 Dec 2018 22:19:56 -0200
MIME-Version: 1.0
Message-Id: <87y38ue0r7.fsf@morokweng.localdomain>
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
To: Nayna Jain <nayna@linux.ibm.com>
Cc: linux-efi@vger.kernel.org, mpe@ellerman.id.au, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, dhowells@redhat.com, seth.forshee@canonical.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, ebiederm@xmission.com, jforbes@redhat.com, linux-integrity@vger.kernel.org, vgoyal@redhat.com


Nayna Jain <nayna@linux.ibm.com> writes:

> On secure boot enabled systems, the bootloader verifies the kernel
> image and possibly the initramfs signatures based on a set of keys. A
> soft reboot(kexec) of the system, with the same kernel image and
> initramfs, requires access to the original keys to verify the
> signatures.
>
> This patch allows IMA-appraisal access to those original keys, now
> loaded on the platform keyring, needed for verifying the kernel image
> and initramfs signatures.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> - replace 'rc' with 'xattr_len' when calling integrity_digsig_verify()
> with INTEGRITY_KEYRING_IMA for readability
> Suggested-by: Serge Hallyn <serge@hallyn.com>
> ---
> Changelog:
>
> v2:
> - replace 'rc' with 'xattr_len' when calling integrity_digsig_verify()
> with INTEGRITY_KEYRING_IMA for readability
>
>  security/integrity/ima/ima_appraise.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

With the change to only access the platform keyring when it is enabled:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

--
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
