Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gRleq-0000yJ-KE
 for kexec@lists.infradead.org; Tue, 27 Nov 2018 22:16:42 +0000
Received: by mail-yw1-xc41.google.com with SMTP id d190so9838733ywd.12
 for <kexec@lists.infradead.org>; Tue, 27 Nov 2018 14:16:29 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com.
 [209.85.219.177])
 by smtp.gmail.com with ESMTPSA id j134sm4245763ywb.91.2018.11.27.14.16.26
 for <kexec@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Nov 2018 14:16:27 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id p144-v6so9758788yba.11
 for <kexec@lists.infradead.org>; Tue, 27 Nov 2018 14:16:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181121113944.GD27797@zn.tnic>
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
 <20181121113944.GD27797@zn.tnic>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Nov 2018 14:16:25 -0800
Message-ID: <CAGXu5jKYxgLPD4YonGSXjECJS=c18rxWmuFC1eeUJK9fLeTxcg@mail.gmail.com>
Subject: Re: [PATCH v2] x86_64,
 vmcoreinfo: Append 'page_offset_base' to vmcoreinfo
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
To: Borislav Petkov <bp@alien8.de>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Baoquan He <bhe@redhat.com>, Bhupesh Sharma <bhsharma@redhat.com>, X86 ML <x86@kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Omar Sandoval <osandov@fb.com>, Dave Anderson <anderson@redhat.com>, James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Wed, Nov 21, 2018 at 3:39 AM, Borislav Petkov <bp@alien8.de> wrote:
> + Kees.
>
> On Fri, Nov 16, 2018 at 03:17:49AM +0530, Bhupesh Sharma wrote:
>> x86_64 kernel uses 'page_offset_base' variable to point to the
>> start of direct mapping of all physical memory. This variable
>> is also updated for KASLR boot cases, so this can be exported
>> via vmcoreinfo as a standard ABI between kernel and user-space,
>> to allow user-space utilities to use the same for calculating
>> the start of direct mapping of all physical memory.

Why is KERNELOFFSET= not sufficient?

See commit b6085a865762 ("x86, kaslr: export offset in VMCOREINFO ELF notes")

+       vmcoreinfo_append_str("KERNELOFFSET=%lx\n",
+                             (unsigned long)&_text - __START_KERNEL);

-Kees

>> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
>> index 4c8acdfdc5a7..6161d77c5bfb 100644
>> --- a/arch/x86/kernel/machine_kexec_64.c
>> +++ b/arch/x86/kernel/machine_kexec_64.c
>> @@ -356,6 +356,9 @@ void arch_crash_save_vmcoreinfo(void)
>>       VMCOREINFO_SYMBOL(init_top_pgt);
>>       vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
>>                       pgtable_l5_enabled());
>> +#ifdef CONFIG_RANDOMIZE_BASE
>> +     VMCOREINFO_NUMBER(page_offset_base);
>> +#endif
>>
>>  #ifdef CONFIG_NUMA
>>       VMCOREINFO_SYMBOL(node_data);

-- 
Kees Cook

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
