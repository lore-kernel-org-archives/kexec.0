Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132] helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hBcNA-0001W8-MM
 for kexec@lists.infradead.org; Wed, 03 Apr 2019 09:39:58 +0000
Date: Wed, 3 Apr 2019 17:39:47 +0800
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190403093947.GJ1555@localhost.localdomain>
References: <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190401000837.GA5170@jeru.linux.bs1.fc.nec.co.jp>
 <20190402120319.GA7605@dhcp-128-65.nay.redhat.com>
 <20190403053459.GD1555@localhost.localdomain>
 <20190403055340.GA11976@dhcp-128-65.nay.redhat.com>
 <20190403072141.GE1555@localhost.localdomain>
 <20190403080846.GB2579@dhcp-128-65.nay.redhat.com>
 <20190403082305.GG1555@localhost.localdomain>
 <20190403090210.GH1555@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190403090210.GH1555@localhost.localdomain>
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
To: Dave Young <dyoung@redhat.com>
Cc: "kasong@redhat.com" <kasong@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Junichi Nomura <j-nomura@ce.jp.nec.com>

On Wed, Apr 03, 2019 at 05:02:11PM +0800, Chao Fan wrote:
>On Wed, Apr 03, 2019 at 04:23:06PM +0800, Chao Fan wrote:
>>On Wed, Apr 03, 2019 at 04:09:16PM +0800, Dave Young wrote:
>>>On 04/03/19 at 03:21pm, Chao Fan wrote:
>>>> On Wed, Apr 03, 2019 at 01:53:40PM +0800, Dave Young wrote:
>>>> >On 04/03/19 at 01:35pm, Chao Fan wrote:
>>>> >> On Tue, Apr 02, 2019 at 08:03:19PM +0800, Dave Young wrote:
>>>> >> >On 04/01/19 at 12:08am, Junichi Nomura wrote:
>[...]
>>>> >
>>>> >It is weird to me. Probably I need find out why I can not reproduce the
>>>> >bug this patch is addressing first.
>>>> 
>>>> Hmm, is your laptop booted from EFI or legacy BIOS?
>>>
>>>EFI booted.
>>>
>>>> >
>>>> >earlyprintk seems not working for me anymore, it is not easy to debug on
>>>> >laptop now.
>>>> 
>>>> Another computer can help print the console message.
>>>> I remeber you are good at debug on two computers.
>>>
>>>I used to use earlyprintk, but seems earlyprintk can not work so early.
>>>So I only can try to comment out code manually.
>>
>>Ah, I got it. If you want to use earlyprintk to print message of
>>get_rsdp_addr(), you should change some code.
>>Because get_rsdp_addr() is called before earlyprintk initialed.
>>
>>I am still testing, but in my debug stage, I change like this:
>>diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
>>index c0d6c560df69..dbbe8d9a5792 100644
>>--- a/arch/x86/boot/compressed/misc.c
>>+++ b/arch/x86/boot/compressed/misc.c
>>@@ -352,7 +352,6 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>>        boot_params->hdr.loadflags &= ~KASLR_FLAG;
>>
>>        /* Save RSDP address for later use. */
>>-       boot_params->acpi_rsdp_addr = get_rsdp_addr();
>>
>>        sanitize_boot_params(boot_params);
>>
>>@@ -368,6 +367,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>>        cols = boot_params->screen_info.orig_video_cols;
>>
>>        console_init();
>>+       boot_params->acpi_rsdp_addr = get_rsdp_addr();
>>        debug_putstr("early console in extract_kernel\n");
>>
>>        free_mem_ptr     = heap;        /* Heap */
>>
>>Call this function after console_init().
>>That will make earlyprintk works.
>>
>>>
>>>It seems to be still some bug in early acpi code because if I 
>>>return 0 in get rsdp function it just works.
>>>
>>>This guess make sense to me for now:
>>>1. nokaslr does not work because it may only avoid randomization, but it
>>>does not avoid running the early acpi parsing code.
>>>
>>>2. kexec does not work without the patch we talked about, because I just
>>>reproduced Junichi reported bug, sometimes hang, or reset, it is
>>>understandable.
>>>
>>>3. kexec does not work with the patch, so there is still bugs in the
>>>code. 
>>>
>>>So several things to do is:
>>>
>>>Fix 1. (separate issue),  Baoquan or either of you may want to fix it :)
>>
>>For 1, I think it's not needed to fix. Since not only KASLR needs RSDP.
>>So nokaslr should not stop the acpi parsing code.
>>>
>>>Fix 3.  need more debugging, have you or Junichi run tests on more real
>>>hardware, maybe it is easier to reproduce on real hardware, I'm glad to
>>>help to try test patch or provide any help. 
>>
>>I am still testing in real hardware.
>
>Hi Dave,
>
>I find a Fujitsu Desktop PC to test it.
>Without this PATCH, it failed to kexec and kdump.
>With this PATCH, it succeed to kexec.
>But failed to kdump. From the log, I think it didn't jump to the second
>kernel, just reboot after panic. I have not figured out what's the
>problem, but it seems not caused by this PATCH.

I comment out this line:
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index c0d6c560df69..4d826abe659c 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -352,7 +352,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
        boot_params->hdr.loadflags &= ~KASLR_FLAG;

        /* Save RSDP address for later use. */
-       boot_params->acpi_rsdp_addr = get_rsdp_addr();
+       //boot_params->acpi_rsdp_addr = get_rsdp_addr();

        sanitize_boot_params(boot_params);

Kdump also failed to jump to the second kernel and just hang.
So I think it's another issue. As for this PATCH, I think it works.
So for now, we only find your laptop will meet the problem, so maybe
you can debug for more information.

Thanks,
Chao Fan

>So I still think this PATCH works for the Fujitsu Desktop PC.
>
>As for your issue, I think there may be some problems related to specified
>hardware. Are you using a Lenovo laptop?
>
>And I am not sure how Nomura tested it.
>
>Thanks,
>Chao Fan
>
>>
>>Thanks,
>>Chao Fan
>>
>>>
>>>Thanks
>>>Dave
>>>
>>>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
