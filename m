Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from brm-mailgate-2.brocade.com ([144.49.197.3])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LuWJw-0007xH-Go
	for kexec@lists.infradead.org; Thu, 16 Apr 2009 18:28:27 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: about ppc32/kexec
Date: Thu, 16 Apr 2009 11:28:02 -0700
Message-ID: <4C94DE2070B172459E4F1EE14BD2364E02D878B6@HQ-EXCH-5.corp.brocade.com>
In-Reply-To: <95529.61291.qm@web28312.mail.ukl.yahoo.com>
References: <95529.61291.qm@web28312.mail.ukl.yahoo.com>
From: "Ming Lei" <mlei@Brocade.COM>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: kexec@lists.infradead.org

Albert,

>> 
>> 1)       In relocate_new_kernel, you put the comment saying switch
the >>MMU off. Can you tell me how these code can achieve it. I don't
see it >>happens on FSL85xx(actually 85xx or 44x doesn't allow MMU to
turn off).
>> 
>> +       .globl relocate_new_kernel
>> +relocate_new_kernel:
>> +       /* r3 = page_list   */
>> +       /* r4 = reboot_code_buffer */
>> +       /* r5 = start_address      */
>> +
>> +       li      r0, 0
>> +
>> +       /*
>> +        * Set Machine Status Register to a known status,
>> +        * switch the MMU off and jump to 1: in a single step.
>> +        */
>> +
>> +       mr      r8, r0
>> +       ori     r8, r8, MSR_RI|MSR_ME
>> +       mtspr   SRR1, r8
>> +       addi    r8, r4, 1f - relocate_new_kernel
>> +       mtspr   SRR0, r8
>> +       sync
>> +       rfi

>This code sets the MSR to a value where MSR_IR (Instruction Relocate)
and >MSR_DI (Data Relocate) are cleared, and thus the MMU is turned
effectively >off.
>Turning the MMU off is possible at least on 6xx and 7xx.

I don't understand why you choose to turn the MMU off on ppc. Is there
any practical reason? On Freescale 85xx which is close to PPC44x, I did
not turn off MMU(I cannot) and I just rely on the current virtual to
physical mapping to jump to the start address to execute the second
kernel.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
