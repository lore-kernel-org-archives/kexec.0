Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97911C27C53
	for <kexec@archiver.kernel.org>; Wed, 12 Jun 2024 23:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:References:
	In-Reply-To:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r1KnABANpgpxdvpvlHKFgsAi4d8fUy8vJa2Xt/ApoOc=; b=gBwtn6QJDI78Hl
	4rdvaH7HJueV5bGQReNcl3YjUROZYhV8jBgVIJhWYTw878wF4h3HnPsCEKyU7l4khKmaJHho1Wrbe
	tGONXGNxyn8HfG+SGWF+MePoIeq1bsfD8iLvCheVn+sjBXON8Xkv0JWSLhdzcJxpY4HU8OJihNwAG
	qxfLRBa3lQe5XT2jTBFxYCsKFeUz5du94AUzxOL8VzGHpq8QTIoSvyRWsb6mcDYcGAGt0pZl4y4qR
	rAr1f4zUU3gsZAlWSt5uqxXz1+4bNZhpFDVg1MOl0OvmpKEiufXZaXIfXBvjL+yeKD7Ip1UY8AucV
	OGwJb/nHaHNuw2nvl1eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHXMF-0000000ETYs-2Q1i;
	Wed, 12 Jun 2024 23:26:23 +0000
Received: from torg.zytor.com ([2607:7c80:54:3::138] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHXMC-0000000ETYE-1Aa2
	for kexec@lists.infradead.org;
	Wed, 12 Jun 2024 23:26:21 +0000
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45CNPftp3933198
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 12 Jun 2024 16:25:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45CNPftp3933198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1718234743;
	bh=SaATviG6Z81UgEioCPxN9VS+E0yDGnphYvOlmf9J1es=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=KF9jPSBE0HgW6q2T+PnT8ZrKRIq/1w1yA2lERYUpTk0mvJnKTRoZ/s6e2WTNmsBvu
	 bane9gvKiCqNfsQZu6Zou2esQBN+Se+uKDSjd+lVt4YqhJA97uEMT0Xz1JMwHrRc78
	 BYsmaRDenE593mlF1op7w5q31M3WCf/+F9N1ls4tDCI25tuNiqNNCi2wTn8F8ltiMI
	 Do+1jRWckpsiW09/FKMgRroup8rCGQZ8m5s6WJrQ2LWwRFWbUBN9k2XKbwbIs0DwyR
	 v4X8SRVrEL48m/RSHe7ElSxkO31u/qnXEYCL2t9OL1WU/nPKYGs+PAc/3EkMw2ZV4U
	 HFEVTl5DhqKsg==
Date: Wed, 12 Jun 2024 16:25:41 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Borislav Petkov <bp@alien8.de>, Nikolay Borisov <nik.borisov@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
        Baoquan He <bhe@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
        linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv11_05/19=5D_x86/relocate=5Fkern?=
 =?US-ASCII?Q?el=3A_Use_named_labels_for_less_confusion?=
User-Agent: K-9 Mail for Android
In-Reply-To: <addbd29a-66dc-4180-ae45-ef038c2249d1@citrix.com>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com> <20240528095522.509667-6-kirill.shutemov@linux.intel.com> <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com> <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5> <748d3b70-60b4-44e0-bd81-9117f1ab699d@zytor.com> <20240604091503.GQZl7bF14qTSAjqUhN@fat_crate.local> <ehttxqgg7zhbgty5m5uxkduj3xf7soonrzfu4rfw7hccqgdydl@afki66pnree5> <5c8b3ee9-64c2-4ff3-9cca-ba2672b9635e@zytor.com> <nxllu5wfhvfvorxbbt6ll3lc2mr47lw7sduszfawhtryqgtyrd@3qgtci7ocah6> <addbd29a-66dc-4180-ae45-ef038c2249d1@citrix.com>
Message-ID: <587E6BF3-4200-442D-95F2-156A96F6FDD8@zytor.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_162620_329786_8DADAA39 
X-CRM114-Status: GOOD (  15.71  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On June 12, 2024 4:06:07 PM PDT, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>On 12/06/2024 10:22 am, Kirill A. Shutemov wrote:
>> On Tue, Jun 11, 2024 at 11:26:17AM -0700, H. Peter Anvin wrote:
>>> On 6/4/24 08:21, Kirill A. Shutemov wrote:
>>>>  From b45fe48092abad2612c2bafbb199e4de80c99545 Mon Sep 17 00:00:00 2001
>>>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>>> Date: Fri, 10 Feb 2023 12:53:11 +0300
>>>> Subject: [PATCHv11.1 06/19] x86/kexec: Keep CR4.MCE set during kexec for TDX guest
>>>>
>>>> TDX guests run with MCA enabled (CR4.MCE=1b) from the very start. If
>>>> that bit is cleared during CR4 register reprogramming during boot or
>>>> kexec flows, a #VE exception will be raised which the guest kernel
>>>> cannot handle it.
>>>>
>>>> Therefore, make sure the CR4.MCE setting is preserved over kexec too and
>>>> avoid raising any #VEs.
>>>>
>>>> The change doesn't affect non-TDX-guest environments.
>>>>
>>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>> ---
>>>>   arch/x86/kernel/relocate_kernel_64.S | 17 ++++++++++-------
>>>>   1 file changed, 10 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
>>>> index 085eef5c3904..9c2cf70c5f54 100644
>>>> --- a/arch/x86/kernel/relocate_kernel_64.S
>>>> +++ b/arch/x86/kernel/relocate_kernel_64.S
>>>> @@ -5,6 +5,8 @@
>>>>    */
>>>>   #include <linux/linkage.h>
>>>> +#include <linux/stringify.h>
>>>> +#include <asm/alternative.h>
>>>>   #include <asm/page_types.h>
>>>>   #include <asm/kexec.h>
>>>>   #include <asm/processor-flags.h>
>>>> @@ -145,14 +147,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>>>>   	 * Set cr4 to a known state:
>>>>   	 *  - physical address extension enabled
>>>>   	 *  - 5-level paging, if it was enabled before
>>>> +	 *  - Machine check exception on TDX guest, if it was enabled before.
>>>> +	 *    Clearing MCE might not be allowed in TDX guests, depending on setup.
>>>> +	 *
>>>> +	 * Use R13 that contains the original CR4 value, read in relocate_kernel().
>>>> +	 * PAE is always set in the original CR4.
>>>>   	 */
>>>> -	movl	$X86_CR4_PAE, %eax
>>>> -	testq	$X86_CR4_LA57, %r13
>>>> -	jz	.Lno_la57
>>>> -	orl	$X86_CR4_LA57, %eax
>>>> -.Lno_la57:
>>>> -
>>>> -	movq	%rax, %cr4
>>>> +	andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d
>>>> +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %r13d), X86_FEATURE_TDX_GUEST
>>>> +	movq	%r13, %cr4
>>> If this is the case, I don't really see a reason to clear MCE per se as I'm
>>> guessing a machine check here will be fatal anyway? It just changes the
>>> method of death.
>> Andrew had a strong opinion on method of death here.
>>
>> https://lore.kernel.org/all/1144340e-dd95-ee3b-dabb-579f9a65b3c7@citrix.com
>
>Not sure if I intended it to come across that strongly, but given a
>choice, the !CR4.MCE death is cleaner because at least you're not
>interpreting garbage and trying to use it as a valid IDT.
>
>~Andrew

Zorch the IDT if it isn't valid?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
