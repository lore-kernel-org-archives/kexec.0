Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gw0-f49.google.com ([74.125.83.49])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nn9L8-0003dO-Tn
	for kexec@lists.infradead.org; Thu, 04 Mar 2010 11:35:43 +0000
Received: by gwj21 with SMTP id 21so1207307gwj.36
	for <kexec@lists.infradead.org>; Thu, 04 Mar 2010 03:35:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B8E9E0C.4050809@caviumnetworks.com>
References: <20100303110527.11233.20400.stgit@muvarov>
	<4B8E9E0C.4050809@caviumnetworks.com>
Date: Thu, 4 Mar 2010 14:35:37 +0300
Message-ID: <572af9171003040335w16434350y60a9f39676dbfa3d@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS kexec,kdump support
From: Maxim Uvarov <muvarov@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-mips@linux-mips.org, horms@verge.net.au, kexec@lists.infradead.org, ralf@linux-mips.org

2010/3/3 David Daney <ddaney@caviumnetworks.com>:
> On 03/03/2010 03:05 AM, Maxim Uvarov wrote:
>>
>> Hello folks,
>>
>> Please find here MIPS crash and kdump patches.
>> This is patch set of 3 patches:
>> 1. generic MIPS changes (kernel);
>> 2. MIPS Cavium Octeon board kexec/kdump code (kernel);
>> 3. Kexec user space MIPS changes.
>>
>> Patches were tested on the latest linux-mips@ git kernel and the latest
>> kexec-tools git on Cavium Octeon 50xx board.
>>
>> I also made the same code working on RMI XLR/XLS boards for both
>> mips32 and mips64 kernels.
>>
>> Best regards,
>> Maxim Uvarov.
>>
>>
>> ---
>>
>> =A0arch/mips/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 24 +++++++=
+++
>
> [...]
>>
>>
>> Signed-off-by: Maxim Uvarov<muvarov@gmail.com>
>>
>
> That Signed-off-by: needs to be just above the '---' not at the end.
>
> David Daney
>
Thanks David, I corrected stgit email template. I think I don't need
resend patches with only this change.


-- =

Best regards,
Maxim Uvarov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
