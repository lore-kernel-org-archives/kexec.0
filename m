Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gS23M-00047U-5j
 for kexec@lists.infradead.org; Wed, 28 Nov 2018 15:47:08 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wASFinCq008771
 for <kexec@lists.infradead.org>; Wed, 28 Nov 2018 10:46:50 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p1vrg41u5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 28 Nov 2018 10:46:49 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Wed, 28 Nov 2018 15:46:46 -0000
Subject: Re: [PATCH 5/7] efi: Import certificates from UEFI Secure Boot
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 28 Nov 2018 10:46:28 -0500
In-Reply-To: <20181125151500.8298-6-nayna@linux.ibm.com>
References: <20181125151500.8298-1-nayna@linux.ibm.com>
 <20181125151500.8298-6-nayna@linux.ibm.com>
Mime-Version: 1.0
Message-Id: <1543419988.3902.216.camel@linux.ibm.com>
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
To: Nayna Jain <nayna@linux.ibm.com>, Josh Boyer <jwboyer@fedoraproject.org>, linux-integrity@vger.kernel.org
Cc: linux-efi@vger.kernel.org, mpe@ellerman.id.au, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, seth.forshee@canonical.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, ebiederm@xmission.com, jforbes@redhat.com, vgoyal@redhat.com

On Sun, 2018-11-25 at 20:44 +0530, Nayna Jain wrote:
> From: Josh Boyer <jwboyer@fedoraproject.org>
> 
> New Patch Description:
> ======================
> 
> Secure Boot stores a list of allowed certificates in the 'db' variable.
> This patch imports those certificates into the platform keyring. The shim
> UEFI bootloader has a similar certificate list stored in the 'MokListRT'
> variable. We import those as well.
> 
> Secure Boot also maintains a list of disallowed certificates in the 'dbx'
> variable. We load those certificates into the system blacklist keyring
> and forbid any kernel signed with those from loading.
> 
> Original Patch Description:
> ============================
> 
> Secure Boot stores a list of allowed certificates in the 'db' variable.
> This imports those certificates into the system trusted keyring.  This
> allows for a third party signing certificate to be used in conjunction
> with signed modules. By importing the public certificate into the 'db'
> variable, a user can allow a module signed with that certificate to
> load. The shim UEFI bootloader has a similar certificate list stored
> in the 'MokListRT' variable. We import those as well.
> 
> Secure Boot also maintains a list of disallowed certificates in the 'dbx'
> variable. We load those certificates into the newly introduced system
> blacklist keyring and forbid any module signed with those from loading and
> forbid the use within the kernel of any key with a matching hash.
> 
> This facility is enabled by setting CONFIG_LOAD_UEFI_KEYS.

There are quite a few checkpatch.pl warnings that need to be
addressed, including the missing SPDX license.

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
