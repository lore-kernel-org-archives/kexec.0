Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cWHRQ-00045p-Kk
 for kexec@lists.infradead.org; Wed, 25 Jan 2017 06:52:26 +0000
Received: by mail-pf0-f177.google.com with SMTP id f144so56218815pfa.2
 for <kexec@lists.infradead.org>; Tue, 24 Jan 2017 22:52:02 -0800 (PST)
Subject: Re: [PATCH] /proc/kcore: Update physical address for kcore ram and
 text
References: <f951340d2917cdd2a329fae9837a83f2059dc3b2.1485318868.git.panand@redhat.com>
 <20170125062949.GA3423@dhcp-128-65.nay.redhat.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <c99e8165-1aa7-4bb3-ef6f-7d66020c57dd@redhat.com>
Date: Wed, 25 Jan 2017 12:21:47 +0530
MIME-Version: 1.0
In-Reply-To: <20170125062949.GA3423@dhcp-128-65.nay.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, anderson@redhat.com, linux-kernel@vger.kernel.org, bhe@redhat.com

Hi Dave,

On Wednesday 25 January 2017 11:59 AM, Dave Young wrote:
> Hi Pratyush
> On 01/25/17 at 10:14am, Pratyush Anand wrote:
>> Currently all the p_paddr of PT_LOAD headers are assigned to 0, which is
>> not true and could be misleading, since 0 is a valid physical address.
> I do not know the history of /proc/kcore, so a question is why the
> p_addr was set as 0, if there were some reasons and if this could cause
> some risk or breakage.
>

I do not know why it was 0, which is a valid physical address. But 
certainly, it might break some user space tools, and those need to be 
fixed. For example, see following code from kexec-tools

kexec/kexec-elf.c:build_mem_phdrs()

435                 if ((phdr->p_paddr + phdr->p_memsz) < phdr->p_paddr) {
436                         /* The memory address wraps */
437                         if (probe_debug) {
438                                 fprintf(stderr, "ELF address wrap 
around\n");
439                         }
440                         return -1;
441                 }

We do not need to perform above check for an invalid physical address.

I think, kexec-tools and makedumpfile will need fixup. I already have 
those fixup which will be sent upstream once this patch makes through.
Pro with this approach is that, it will help to calculate variable like 
page_offset, phys_base from PT_LOAD even when they are randomized and 
therefore will reduce many variable and version specific values in user 
space tools.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
