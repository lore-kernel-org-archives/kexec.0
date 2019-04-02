Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132] helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hBGKQ-0007uQ-Jj
 for kexec@lists.infradead.org; Tue, 02 Apr 2019 10:07:41 +0000
Date: Tue, 2 Apr 2019 19:06:36 +0800
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190402110635.GC1555@localhost.localdomain>
References: <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic>
 <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190401000837.GA5170@jeru.linux.bs1.fc.nec.co.jp>
 <20190402094149.GB1555@localhost.localdomain>
 <20190402095350.GA20733@jeru.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190402095350.GA20733@jeru.linux.bs1.fc.nec.co.jp>
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
To: Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc: "kasong@redhat.com" <kasong@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>

On Tue, Apr 02, 2019 at 09:53:51AM +0000, Junichi Nomura wrote:
>On Tue, Apr 02, 2019 at 05:41:49PM +0800, Chao Fan wrote:
>> [   77.989030] kexec_core: Starting new kernel
>> early console in extract_kernel
>> input_data: 0x000000017f6033b1
>> input_len: 0x00000000008412d4
>> output: 0x000000017e000000
>> output_len: 0x0000000001e15844
>> kernel_total_size: 0x0000000001e2c000
>> trampoline_32bit: 0x000000000009d000
>> booted via startup_64()
>> 
>> 
>> Physical KASLR disabled: no suitable memory region!
>> ------
>> 
>> I am not sure whether I have done the right test.
>> This guest is booted from EFI. Here we can see the kexeced kernel
>> has completed the compressed boot stage. So I think your PATCH works.
>
>Thanks for testing.  If your test bed doesn't boot even with the patch,
>you could check what was found as RSDP with a debug patch like below.

Oh no, it booted. I just put the compressed stag log.

Thanks,
Chao Fan

>
>diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
>--- a/arch/x86/boot/compressed/misc.c
>+++ b/arch/x86/boot/compressed/misc.c
>@@ -379,6 +379,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
> 	debug_putaddr(output);
> 	debug_putaddr(output_len);
> 	debug_putaddr(kernel_total_size);
>+	debug_putaddr(boot_params->acpi_rsdp_addr);
> 
> #ifdef CONFIG_X86_64
> 	/* Report address of 32-bit trampoline */
>
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
