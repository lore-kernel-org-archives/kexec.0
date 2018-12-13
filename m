Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXEg8-0000wf-Lk
 for kexec@lists.infradead.org; Thu, 13 Dec 2018 00:16:38 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBD0EHAS053941
 for <kexec@lists.infradead.org>; Wed, 12 Dec 2018 19:16:21 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pbasqn0wx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 12 Dec 2018 19:16:20 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.ibm.com>;
 Thu, 13 Dec 2018 00:16:20 -0000
References: <20181208202705.18673-2-nayna@linux.ibm.com>
 <20181209044849.825-1-nayna@linux.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v2 1/7] integrity: Define a trusted platform keyring
In-reply-to: <20181209044849.825-1-nayna@linux.ibm.com>
Date: Wed, 12 Dec 2018 22:15:56 -0200
MIME-Version: 1.0
Message-Id: <871s6mffib.fsf@morokweng.localdomain>
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

> On secure boot enabled systems, a verified kernel may need to kexec
> additional kernels. For example, it may be used as a bootloader needing
> to kexec a target kernel or it may need to kexec a crashdump kernel. In
> such cases, it may want to verify the signature of the next kernel
> image.
>
> It is further possible that the kernel image is signed with third party
> keys which are stored as platform or firmware keys in the 'db' variable.
> The kernel, however, can not directly verify these platform keys, and an
> administrator may therefore not want to trust them for arbitrary usage.
> In order to differentiate platform keys from other keys and provide the
> necessary separation of trust, the kernel needs an additional keyring to
> store platform keys.
>
> This patch creates the new keyring called ".platform" to isolate keys
> provided by platform from keys by kernel. These keys are used to
> facilitate signature verification during kexec. Since the scope of this
> keyring is only the platform/firmware keys, it cannot be updated from
> userspace.
>
> This keyring can be enabled by setting CONFIG_INTEGRITY_PLATFORM_KEYRING.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> ---
>  security/integrity/Kconfig                         | 11 +++++
>  security/integrity/Makefile                        |  1 +
>  security/integrity/digsig.c                        | 48 +++++++++++++++-------
>  security/integrity/integrity.h                     |  3 +-
>  .../integrity/platform_certs/platform_keyring.c    | 35 ++++++++++++++++
>  5 files changed, 83 insertions(+), 15 deletions(-)
>  create mode 100644 security/integrity/platform_certs/platform_keyring.c

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
