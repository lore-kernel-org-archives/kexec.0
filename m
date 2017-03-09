Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1clqdy-0008WH-Lj
 for kexec@lists.infradead.org; Thu, 09 Mar 2017 05:29:44 +0000
Received: by mail-pf0-f175.google.com with SMTP id j5so24177986pfb.2
 for <kexec@lists.infradead.org>; Wed, 08 Mar 2017 21:29:21 -0800 (PST)
Subject: Re: Questions about kexec-tools (resend to list)
References: <A5F1D916-BEB0-47A2-8227-4C2A78A0B5DA@fedoraproject.org>
 <1ea88eb9-4df4-3410-5cb6-3ef10b9cb0e3@redhat.com>
 <67B8328D-6052-4D47-9172-412AB0CA7B0A@fedoraproject.org>
 <78e72659-4605-7187-e725-3bf8bf517590@redhat.com>
 <EE2A2BAB-BAA5-4D79-B37C-90C72A5D972D@fedoraproject.org>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <ced55ae5-9095-3e24-c981-07e17561f478@redhat.com>
Date: Thu, 9 Mar 2017 10:59:16 +0530
MIME-Version: 1.0
In-Reply-To: <EE2A2BAB-BAA5-4D79-B37C-90C72A5D972D@fedoraproject.org>
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
To: Philip Prindeville <philipp@fedoraproject.org>
Cc: kexec@lists.infradead.org



On Wednesday 08 March 2017 10:59 PM, Philip Prindeville wrote:
> CRASH MEMORY RANGES
> 0000000000000005-ffffffffffffffff (1)
> 0000000000000005-ffffffffffffffff (0)
> 0000000000000005-ffffffffffffffff (1)
> 0000000000000005-ffffffffffffffff (1)
> 0000000000000005-ffffffffffffffff (0)
> 0000000000000005-ffffffffffffffff (3)
> 0000000000000005-ffffffffffffffff (0)
> 0000000000000005-ffffffffffffffff (1)
> 0000000000000005-ffffffffffffffff (0)
> 0000000000000005-ffffffffffffffff (1)
> 0000000000000005-ffffffffffffffff (2)
> 0000000000000005-ffffffffffffffff (3)
> 0000000000000005-ffffffffffffffff (1)
> 0000000000000005-ffffffffffffffff (0)
> 0000000000000005-ffffffffffffffff (1)
> 0000000000000005-ffffffffffffffff (1)
> 0000000000000005-ffffffffffffffff (1)
> 0000000000000005-ffffffffffffffff (1)
> 0000000000000005-ffffffffffffffff (1)
> 0000000000000005-ffffffffffffffff (1)
> 0000000000000005-ffffffffffffffff (1)
> 0000000000000005-ffffffffffffffff (0)
> 0000000000000130-00007f18b2a21938 (0)

No sure whats going here..but above does not look good. It should have 
values from  /proc/iomem.

> Cannot get kernel page_offset_base symbol address
> kernel symbol _stext vaddr =      a0000000005
> kernel vaddr = 0xffffffff81000000 size = 0x818000
> Memmap after adding segment
> 0000000000000000-000000000009ffff (0)
> Cannot load /tmp/boot/boot/vmlinuz

Above wrong ranges might be the reason of failure most likely in 
crash_create_elf**_headers().


~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
