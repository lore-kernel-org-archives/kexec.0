Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96BEC6FA8E
	for <kexec@archiver.kernel.org>; Thu,  2 Mar 2023 10:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SVsV6+NNZqxOZ+0te8t4tJa/7NcK1eASpptrGS6mCEo=; b=QwAFFcW/OOBAc7
	QaX1LKbAH6e4PijymNCiFQZmsxqP/3VRTlfpVAUFlpnaDAX9cbAllWR+yeEJsH9QqWh1lvhlQPa62
	VQfYprDITi7SIHkpQaEzHUcid2KV2GlP/0lw9g24jzGUehs4Jjbm7zDNxa/8O1QI2OvMA2T4F6P30
	svca+LeCj/ljvuLC+Lq9/LOsxVpS6IyHy4bHC4WqGs8yFhbc8oetbY/Yu1DHI3sLtxowfcJkiZZWF
	0k6ShiyR3EPSr/7QY8FoBrRyQXlxuFobhTSs1DECpYd/ytTySqbl1SxsqspId7SApCzdIZMuw4B4h
	uM/RHa5ooMIgD7sTzgNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXgXk-001ksf-Bl; Thu, 02 Mar 2023 10:52:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXgXh-001krb-DA
	for kexec@lists.infradead.org; Thu, 02 Mar 2023 10:52:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677754328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gqjuc7KYtNH8mTD7G1U99YdOExIzLeppGG/Zgz9wRuo=;
	b=I46OBM9IhDU1fg1gkEAXT9XwCdBF+4ytoyyDMPuqa9xmNFlJthukSotqygURCTwEDHURWa
	73Wt275/uK1wOdaajNOsesTAnIIp/4Q+9wvOYhVI5j3NVg0bbxO0gbtWXrQRtjGsOuOi4i
	9DB875R6iNKwN9h4e3U/YRTbMRnplBE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-e2EhAna4OXSp1kph64n9Ag-1; Thu, 02 Mar 2023 05:52:02 -0500
X-MC-Unique: e2EhAna4OXSp1kph64n9Ag-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9128D196EF8E;
	Thu,  2 Mar 2023 10:52:00 +0000 (UTC)
Received: from localhost (ovpn-12-47.pek2.redhat.com [10.72.12.47])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C1FB492C14;
	Thu,  2 Mar 2023 10:51:58 +0000 (UTC)
Date: Thu, 2 Mar 2023 18:51:55 +0800
From: Baoquan He <bhe@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
	dyoung@redhat.com, vgoyal@redhat.com, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
Message-ID: <ZAB/y/pUU/xhY2k9@MiWiFi-R3L-srv>
References: <87h6vw2rwf.ffs@tglx>
 <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
 <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
 <24034f33-739b-e5f5-40c0-8d5abeb1ad89@oracle.com>
 <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
 <b3d5c730-60ee-8f1c-978c-e3df41e3a3f1@oracle.com>
 <f7c0269b-05e7-c706-f111-c768d4a13b72@linux.ibm.com>
 <Y/33OOdv22CEaTNA@MiWiFi-R3L-srv>
 <7b0e3676-40e1-3ea1-6d58-6d934970aa27@oracle.com>
 <536c69d0-9ebd-8356-ebcb-680562bcd277@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <536c69d0-9ebd-8356-ebcb-680562bcd277@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230302_025209_558627_45CEE241 
X-CRM114-Status: GOOD (  35.66  )
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

On 03/01/23 at 09:48am, Eric DeVolder wrote:
...... 
> From b56aa428b07d970f26e3c3704d54ce8805f05ddc Mon Sep 17 00:00:00 2001
> From: Eric DeVolder <eric.devolder@oracle.com>
> Date: Tue, 28 Feb 2023 14:20:04 -0500
> Subject: [PATCH v19 3/7] crash: change crash_prepare_elf64_headers() to
>  for_each_possible_cpu()
> 
> The function crash_prepare_elf64_headers() generates the elfcorehdr
> which describes the cpus and memory in the system for the crash kernel.
> In particular, it writes out ELF PT_NOTEs for memory regions and the
> processors in the system.
> 
> With respect to the cpus, the current implementation utilizes
> for_each_present_cpu() which means that as cpus are added and removed,
> the elfcorehdr must again be updated to reflect the new set of cpus.
> 
> The reasoning behind the change to use for_each_possible_cpu(), is:
> 
> - At kernel boot time, all percpu crash_notes are allocated for all
>   possible cpus; that is, crash_notes are not allocated dynamically
>   when cpus are plugged/unplugged. Thus the crash_notes for each
>   possible cpu are always available.
> 
> - The crash_prepare_elf64_headers() creates an ELF PT_NOTE per cpu.
>   Changing to for_each_possible_cpu() is valid as the crash_notes
>   pointed to by each cpu PT_NOTE are present and always valid.
> 
> Furthermore, examining a common crash processing path of:
> 
>  kernel panic -> crash kernel -> makedumpfile -> 'crash' analyzer
>            elfcorehdr      /proc/vmcore     vmcore
> 
> reveals how the ELF cpu PT_NOTEs are utilized:
> 
> - Upon panic, each cpu is sent an IPI and shuts itself down, recording
>  its state in its crash_notes. When all cpus are shutdown, the
>  crash kernel is launched with a pointer to the elfcorehdr.
> 
> - The crash kernel via linux/fs/proc/vmcore.c does not examine or
>  use the contents of the PT_NOTEs, it exposes them via /proc/vmcore.
> 
> - The makedumpfile utility uses /proc/vmcore and reads the cpu
>  PT_NOTEs to craft a nr_cpus variable, which is reported in a
>  header but otherwise generally unused. Makedumpfile creates the
>  vmcore.
> 
> - The 'crash' dump analyzer does not appear to reference the cpu
>  PT_NOTEs. Instead it looks-up the cpu_[possible|present|onlin]_mask
>  symbols and directly examines those structure contents from vmcore
>  memory. From that information it is able to determine which cpus
>  are present and online, and locate the corresponding crash_notes.
>  Said differently, it appears to me that 'crash' analyzer does not
>  rely on the ELF PT_NOTEs for cpus; rather it obtains the information
>  directly via kernel symbols and the memory within the vmcore.
> 
> (There maybe other vmcore generating and analysis tools that do use
> these PT_NOTEs, but 'makedumpfile' and 'crash' seem to me to be the
> most common solution.)
> 
> This change results in the benefit of having all cpus described in
> the elfcorehdr, and therefore reducing the need to re-generate the
> elfcorehdr on cpu changes, at the small expense of an additional
> 56 bytes per PT_NOTE for not-present-but-possible cpus.
> 
> On systems where kexec_file_load() syscall is utilized, all the above
> is valid. On systems where kexec_load() syscall is utilized, there
> may be the need for the elfcorehdr to be regenerated once. The reason
> being that some archs only populate the 'present' cpus in the
> /sys/devices/system/cpus entries, which the userspace 'kexec' utility
> uses to generate the userspace-supplied elfcorehdr. In this situation,
> one memory or cpu change will rewrite the elfcorehdr via the
> crash_prepare_elf64_headers() function and now all possible cpus will
> be described, just as with kexec_file_load() syscall.

So, with for_each_possible_cpu(), we don't need to respond to cpu
hotplug event, right? If so, it does bring benefit. While kexec_load
won't benefit from that. So far, it looks not bad.

> 
> Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  kernel/crash_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index dba4b75f7541..537b199a8774 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -365,7 +365,7 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>  	ehdr->e_phentsize = sizeof(Elf64_Phdr);
> 
>  	/* Prepare one phdr of type PT_NOTE for each present CPU */
> -	for_each_present_cpu(cpu) {
> +	for_each_possible_cpu(cpu) {
>  		phdr->p_type = PT_NOTE;
>  		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
>  		phdr->p_offset = phdr->p_paddr = notes_addr;
> -- 
> 2.31.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
