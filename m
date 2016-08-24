Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bcMP2-0001A0-AS
 for kexec@lists.infradead.org; Wed, 24 Aug 2016 00:50:49 +0000
Received: by mail-qk0-x241.google.com with SMTP id v123so121858qkh.3
 for <kexec@lists.infradead.org>; Tue, 23 Aug 2016 17:50:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <239172a5-1952-de2d-e48d-4ca7d882356c@gmail.com>
References: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <4126991.2tm6WB17SD@hactar> <3ca4a2de-0d44-dbc6-b57b-c149d10b048f@gmail.com>
 <4586138.sszncvQpYx@hactar> <239172a5-1952-de2d-e48d-4ca7d882356c@gmail.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Wed, 24 Aug 2016 10:50:26 +1000
Message-ID: <CAOSf1CGyfz97NLyrfxkHZ3-Hwq7R2ZsN8L3f3=aEjH0zyToz3A@mail.gmail.com>
Subject: Re: [PATCH v5 04/13] powerpc: Factor out relocation code from
 module_64.c to elf_util_64.c.
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
To: Balbir Singh <bsingharora@gmail.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Young <dyoung@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On Tue, Aug 23, 2016 at 1:21 PM, Balbir Singh <bsingharora@gmail.com> wrote:
>
>> zImage on ppc64 BE is an ELF32 file. This patch set only supports loading
>> ELF files of the same class as the kernel, so a 64 bit kernel can't load an
>> ELF32 file. It would be possible to add such support, but it would be a new
>> feature.
>>
>> The distros I was able to check on ppc64 LE and BE all use vmlinux.
>> kexec-tools with kexec_load also doesn't support zImage. Do you think it is
>> important to support zImage?
>
> Well if it didn't work already, I think its low priority. Michael should be
> able to confirm this. Oliver's been trying to cleanup the zImage to get rid
> the old zImage limitation, cc'ing him

I don't think it's ever worked so I wouldn't worry too much about
supporting it. Fixing kexec-into-zImage and fixing the 32bit wrapper
on 64bit BE kernel problem has been on my TODO list for a while, but
it's not a priority.

oliver

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
