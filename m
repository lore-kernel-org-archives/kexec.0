Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i0X1U-00086v-KZ
 for kexec@lists.infradead.org; Wed, 21 Aug 2019 20:16:01 +0000
References: <20190715082702.27308-1-svens@stackframe.org>
 <20190715082702.27308-2-svens@stackframe.org>
 <87zhk3mj0k.fsf@morokweng.localdomain>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v4 1/7] kexec: add KEXEC_ELF
In-reply-to: <87zhk3mj0k.fsf@morokweng.localdomain>
Date: Wed, 21 Aug 2019 17:15:49 -0300
Message-ID: <877e76w9ze.fsf@morokweng.localdomain>
MIME-Version: 1.0
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
Cc: linuxppc-dev@lists.ozlabs.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>


Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:

>> diff --git a/arch/powerpc/kernel/kexec_elf_64.c b/kernel/kexec_elf.c
>> similarity index 71%
>> copy from arch/powerpc/kernel/kexec_elf_64.c
>> copy to kernel/kexec_elf.c
>> index ba4f18a43ee8..6e9f52171ede 100644
>> --- a/arch/powerpc/kernel/kexec_elf_64.c
>> +++ b/kernel/kexec_elf.c
>> @@ -1,33 +1,10 @@
>> -/*
>> - * Load ELF vmlinux file for the kexec_file_load syscall.
>> - *
>> - * Copyright (C) 2004  Adam Litke (agl@us.ibm.com)
>> - * Copyright (C) 2004  IBM Corp.
>> - * Copyright (C) 2005  R Sharada (sharada@in.ibm.com)
>> - * Copyright (C) 2006  Mohan Kumar M (mohan@in.ibm.com)
>> - * Copyright (C) 2016  IBM Corporation
>> - *
>> - * Based on kexec-tools' kexec-elf-exec.c and kexec-elf-ppc64.c.
>> - * Heavily modified for the kernel by
>> - * Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>.
>> - *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License as published by
>> - * the Free Software Foundation (version 2 of the License).
>> - *
>> - * This program is distributed in the hope that it will be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> - * GNU General Public License for more details.
>> - */
>> +// SPDX-License-Identifier: GPL-2.0-only
>
> I may be wrong, but my understanding of the SPDX license identifier is
> that it substitutes the license text (i.e., the last two paragraphs
> above), but not the copyright statements. Is it ok to have a file with a
> SPDX license identifier but no copyright statement?

Answering my own question: I just came accross commit b24413180f56
("License cleanup: add SPDX GPL-2.0 license identifier to files with no
license") which adds SPDX license identifiers to a lot of files without
any copyright statement so I conclude that it is indeed ok to not have
copyright statements in a file.

In this instance the new file is heavily based on the old one though, so
IMHO it makes sense for it to inherit the copyright statements from the
original file.

--
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
